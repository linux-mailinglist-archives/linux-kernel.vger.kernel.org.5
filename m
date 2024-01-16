Return-Path: <linux-kernel+bounces-27386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3A782EF20
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6531F2452B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E791BC37;
	Tue, 16 Jan 2024 12:38:06 +0000 (UTC)
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C81BC30;
	Tue, 16 Jan 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id BA4281864EA3;
	Tue, 16 Jan 2024 15:37:52 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 87kUh4nzQxwi; Tue, 16 Jan 2024 15:37:52 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 6B2F11864BCC;
	Tue, 16 Jan 2024 15:37:52 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3uTgjf0xa7w9; Tue, 16 Jan 2024 15:37:52 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.102])
	by mail.astralinux.ru (Postfix) with ESMTPS id 2178F1864EA3;
	Tue, 16 Jan 2024 15:37:52 +0300 (MSK)
Received: from [192.168.32.67] (unknown [192.168.32.67])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TDpSb5CxMzfYlP;
	Tue, 16 Jan 2024 15:37:51 +0300 (MSK)
Message-ID: <5eb30083-1d8f-02cf-c4bf-2560ad46243d@astralinux.ru>
Date: Tue, 16 Jan 2024 15:37:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Content-Language: ru
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org
Cc: stephen.smalley.work@gmail.com, aaw@google.com
From: Dmitry Mastykin <dmastykin@astralinux.ru>
Subject: preventing executable stack with file_mprotect hook
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

I use the file_mprotect hook to prevent executable stack. It's called 
from mprotect syscall and prevents linkage with execstack-flagged 
libraries. But I don't see it called when I execute a simple 
execstack-flagged binary: int main() { char shell[100] = "\xb0\x01" // 
mov al, 1 "\x31\xdb" // xor ebx, ebx "\xcd\x80" ; // int 0x80 
((void(*)())shell)(); return 0; } I'm thinking about a patch like one in 
the end of this message. I would be glad to have a feedback, if someone 
find this reasonable. Thank you! Kind regards Dmitry Mastykin

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
  	struct vm_area_struct *vma = bprm->vma;
  	struct vm_area_struct *prev = NULL;
  	unsigned long vm_flags;
+	unsigned long prot = 0;
  	unsigned long stack_base;
  	unsigned long stack_size;
  	unsigned long stack_expand;
@@ -811,16 +813,19 @@ int setup_arg_pages(struct linux_binprm *bprm,
  	 * EXSTACK_ENABLE_X, disable for EXSTACK_DISABLE_X and leave alone
  	 * (arch default) otherwise.
  	 */
-	if (unlikely(executable_stack == EXSTACK_ENABLE_X))
+	if (unlikely(executable_stack == EXSTACK_ENABLE_X)) {
+		prot |= PROT_EXEC;
  		vm_flags |= VM_EXEC;
-	else if (executable_stack == EXSTACK_DISABLE_X)
+	} else if (executable_stack == EXSTACK_DISABLE_X)
  		vm_flags &= ~VM_EXEC;
  	vm_flags |= mm->def_flags;
  	vm_flags |= VM_STACK_INCOMPLETE_SETUP;
  
  	tlb_gather_mmu(&tlb, mm);
-	ret = mprotect_fixup(&tlb, vma, &prev, vma->vm_start, vma->vm_end,
-			vm_flags);
+	ret = security_file_mprotect(vma, prot, prot);
+	if (!ret)
+		ret = mprotect_fixup(&tlb, vma, &prev,
+				     vma->vm_start, vma->vm_end, vm_flags);
  	tlb_finish_mmu(&tlb);
  
  	if (ret)


