Return-Path: <linux-kernel+bounces-154988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D812A8AE3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E332287046
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533717F499;
	Tue, 23 Apr 2024 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="xSJOntVV"
Received: from out187-16.us.a.mail.aliyun.com (out187-16.us.a.mail.aliyun.com [47.90.187.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B183CCB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871844; cv=none; b=jqBhvNodY0AHsg8EnJQpzVOfN0LuFzLYXgkNY7n4lzjev99pFKBsNttsO8WJQrbP/qb9nU+xY0ZJlupZ1nnpQic3PJzOamJKarXUW+PuEpRL6W2/iKkLyIHf4StzeyLWvDHjUdFF5DK09nxv7HF3qcZeS2CaRLF134OWdf1V53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871844; c=relaxed/simple;
	bh=7WJ6yWctR6knaJVR4QUqBonQC0vgU1vFUiJZIqMjLAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7bFBxUqkY8XjxfXBDuWG58Wg3yaHb4omVcAwcmYNo8OePFsVSxdWX5c5hJQl2n+xhJ2G8LueoKbrlOsDb9iN2wwmjnCg7ZiLP/IU5u64FEXhIsODW83IKYcrVvFlc1cnWJF+x4vCma1k8VW6wL+cf9rr5tyRwOmigyCFTMtzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=xSJOntVV; arc=none smtp.client-ip=47.90.187.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713871829; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4EXKiihVydLTnKmoFmv5QgTCQtRVg7rf+OIs/nHZkJ8=;
	b=xSJOntVV/uDCGgorf32VvI25PI8pFOL7vkKtVjr0o0exYqiqgl+f/733ZzKN8gDZWjdvUwrsrh2nvF2sYR3h7mpPkcJU2D8ByBDg21uhfFpLiXKwiF0M6LNd7Xlyia8Xh7sgiFy9iCDNW1SGjpnXfoSJMtTlUHDkj2n7m8ZhKd8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYhr_1713871512;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYhr_1713871512)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:12 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/7] um: Fix the -Wmissing-prototypes warning for get_thread_reg
Date: Tue, 23 Apr 2024 19:24:53 +0800
Message-Id: <20240423112457.2409319-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_thread_reg function is defined in the user code, and is
called by the kernel code. It should be declared in a shared header.

Fixes: dbba7f704aa0 ("um: stop polluting the namespace with registers.h contents")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/processor-generic.h | 1 -
 arch/x86/um/shared/sysdep/archsetjmp.h  | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 6c3779541845..5a7c05275aa7 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -94,7 +94,6 @@ extern struct cpuinfo_um boot_cpu_data;
 #define current_cpu_data boot_cpu_data
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
-extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
 extern unsigned long __get_wchan(struct task_struct *p);
 
diff --git a/arch/x86/um/shared/sysdep/archsetjmp.h b/arch/x86/um/shared/sysdep/archsetjmp.h
index 166cedbab926..15a75e01ce30 100644
--- a/arch/x86/um/shared/sysdep/archsetjmp.h
+++ b/arch/x86/um/shared/sysdep/archsetjmp.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_UM_SYSDEP_ARCHSETJMP_H
+#define __X86_UM_SYSDEP_ARCHSETJMP_H
+
 #ifdef __i386__
 #include "archsetjmp_32.h"
 #else
 #include "archsetjmp_64.h"
 #endif
+
+extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
+
+#endif /* __X86_UM_SYSDEP_ARCHSETJMP_H */
-- 
2.34.1


