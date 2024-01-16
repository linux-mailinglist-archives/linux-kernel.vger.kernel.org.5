Return-Path: <linux-kernel+bounces-27473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B082F0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AD11C2357F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72651BF35;
	Tue, 16 Jan 2024 14:45:02 +0000 (UTC)
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB91BF2C;
	Tue, 16 Jan 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 022531864A89;
	Tue, 16 Jan 2024 17:44:54 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id W6DlY7W6TfxX; Tue, 16 Jan 2024 17:44:53 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 887221864BEA;
	Tue, 16 Jan 2024 17:44:53 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KKOQ-REb2L0O; Tue, 16 Jan 2024 17:44:53 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.102])
	by mail.astralinux.ru (Postfix) with ESMTPS id 58B561864A89;
	Tue, 16 Jan 2024 17:44:53 +0300 (MSK)
Received: from localhost.localdomain (unknown [192.168.32.67])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TDsH85SDPzfYm3;
	Tue, 16 Jan 2024 17:44:52 +0300 (MSK)
From: Dmitry Mastykin <dmastykin@astralinux.ru>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	Dmitry Mastykin <dmastykin@astralinux.ru>
Subject: preventing executable stack with file_mprotect hook
Date: Tue, 16 Jan 2024 17:43:41 +0300
Message-Id: <20240116144340.17902-1-dmastykin@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

I use the file_mprotect hook to prevent executable stack. It's called fro=
m mprotect syscall and prevents linkage with execstack-flagged libraries.
But I don't see it called when I execute a simple execstack-flagged binar=
y:

int main() {
	char shell[100] =3D "\xb0\x01" // mov al, 1
			  "\x31\xdb" // xor ebx, ebx
			  "\xcd\x80" ; // int 0x80
	((void(*)())shell)();
	return 0;
}

I'm thinking about a patch like one in the end of this message.
I would be glad to have a feedback, if someone find this reasonable.
Thank you!

Kind regards
Dmitry Mastykin

diff --git a/fs/exec.c b/fs/exec.c
index cebfe15bbad8..0288f14f11b2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -50,6 +50,7 @@
 #include <linux/module.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/mman.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/tsacct_kern.h>
@@ -759,6 +760,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	struct vm_area_struct *vma =3D bprm->vma;
 	struct vm_area_struct *prev =3D NULL;
 	unsigned long vm_flags;
+	unsigned long prot =3D 0;
 	unsigned long stack_base;
 	unsigned long stack_size;
 	unsigned long stack_expand;
@@ -811,16 +813,19 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	 * EXSTACK_ENABLE_X, disable for EXSTACK_DISABLE_X and leave alone
 	 * (arch default) otherwise.
 	 */
-	if (unlikely(executable_stack =3D=3D EXSTACK_ENABLE_X))
+	if (unlikely(executable_stack =3D=3D EXSTACK_ENABLE_X)) {
+		prot |=3D PROT_EXEC;
 		vm_flags |=3D VM_EXEC;
-	else if (executable_stack =3D=3D EXSTACK_DISABLE_X)
+	} else if (executable_stack =3D=3D EXSTACK_DISABLE_X)
 		vm_flags &=3D ~VM_EXEC;
 	vm_flags |=3D mm->def_flags;
 	vm_flags |=3D VM_STACK_INCOMPLETE_SETUP;
=20
 	tlb_gather_mmu(&tlb, mm);
-	ret =3D mprotect_fixup(&tlb, vma, &prev, vma->vm_start, vma->vm_end,
-			vm_flags);
+	ret =3D security_file_mprotect(vma, prot, prot);
+	if (!ret)
+		ret =3D mprotect_fixup(&tlb, vma, &prev,
+				     vma->vm_start, vma->vm_end, vm_flags);
 	tlb_finish_mmu(&tlb);
=20
 	if (ret)

