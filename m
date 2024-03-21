Return-Path: <linux-kernel+bounces-110535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD0886042
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48C81F237A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B061332BC;
	Thu, 21 Mar 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1ootWPo"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DAA12BF3E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044317; cv=none; b=JE4ive5VRcybrSgGxvFZn+9hoUyNjEdbzKfsbsZHWrNLlNxkDfKVZCcxjfaZDq6y12GxepqOmkDn+QN/ltttPsIH8lIsOiAfLo+pP8bQUpDZyEgqeysxsILmsMgQGx1jZe6pEqjsmcmYSlCNSfxymj2tZXfsczdmBIK1AQkIgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044317; c=relaxed/simple;
	bh=myd+T4PBZXp07XIO4tJL5oUA6KnHWpDz8EFXE8AcQyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGA3UfGfeRBsvbIXRPzzHITRCbeaXqlg9b1afAvorldn5UzPDbZY+xum+pNzTBeoxAtBRf+g/Z4wphdclYHFmi2XGKymWSZGXg7OeFzGRu7z4xq7cnReYLn+hi1Z7tOE8qysQWqFYC3E+hXrQVzo76k8IOu/HoaA9TL19JRKgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1ootWPo; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78a2093cd44so102596785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711044314; x=1711649114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gu+yUvi3wnUdJSvvoa69Ja3av8KViaUgpe4ObwfOcEU=;
        b=C1ootWPoe4XBXriqw/p0chbMtbkMDluolb1lZ4wORJQrr3U/TxkN1eTRBdA3xuE7hO
         lMVUZvuIM8VzDHgYD4lPoi8jTgYh9lyV5O+ymkvq756CFSfJ9ZwBP4bpAPWXtOimTuZH
         tsb0z1xHYOTGz67tAvaLuExWu5IWCcdwD4FqaGujCQKBNTUPW6wufzVlAtrD5bXys6DM
         wRhTAHBRZFpCncrwQusVaJrmaQtl8730gLm/5jfoXAdy2KEjXLDzK9d+ESZRA2UEehxK
         aL08OLcym5TmYhHum2i0LrxQK6qN19yu+bzoyZaF9xUhvXFIobR5M4NzejDCcWNZewof
         9lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711044314; x=1711649114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gu+yUvi3wnUdJSvvoa69Ja3av8KViaUgpe4ObwfOcEU=;
        b=LBCpzHRtRLIHDJ62awdfcu+AtW7AStjaD/fCoquhrr9K0TuV11Kjt9f/56B7FqZVS+
         b88SgU10p0VoU0B16IaZVTBoDwKkZCrLdjZ92iDL7nqskZlJwgB3aZlFG30gR4dWqJ2D
         CQYdq35lvVBRMzirkbbNKfCaE0tC7YfaoUwKXokCBGJ2WWONvl5H0YuMb+piJAAGU8IH
         Na473NEPUaoPk0Bu3J2V40z/eJDwO6UHe5gPlS4GS8D7+oY/CbiV81MVejOMrBtsltLv
         +Qp5GIBZ3mjfl8BEVl4Xu8fjHyKA4LzQhuOKQo2QvdhUc4jdYDvh9tK3GdvSY39l4Zda
         +0gQ==
X-Gm-Message-State: AOJu0YxUko3ubHUxrVDEFUCERNcjJgfoVRKzZnFY+egPvadeYdFymKI0
	ExfTXIWrbE6TuzKPvL9Q5C3E1lDbovHyzyXNVNr38yJpp6AJwO1JJhHcNu8=
X-Google-Smtp-Source: AGHT+IEoNuvykuGWhHmm4VUPPxY4plON2DyZ4Ujdpe83xSdn6HQWK/6a9hLWwpBhEQWB1j5oUp16/Q==
X-Received: by 2002:a05:620a:561c:b0:787:8ebc:6cb2 with SMTP id vu28-20020a05620a561c00b007878ebc6cb2mr2495539qkn.46.1711044313667;
        Thu, 21 Mar 2024 11:05:13 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id b1-20020a05620a04e100b0078874565b40sm102629qkh.30.2024.03.21.11.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:05:13 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86/boot: Simplify boot stack setup
Date: Thu, 21 Mar 2024 14:05:06 -0400
Message-ID: <20240321180506.89030-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the symbol __top_init_kernel_stack instead of duplicating
the offset from __end_init_task in multiple places.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/processor.h |  6 ++----
 arch/x86/kernel/head_32.S        | 11 +----------
 arch/x86/kernel/head_64.S        |  2 +-
 arch/x86/kernel/vmlinux.lds.S    |  3 +++
 arch/x86/xen/xen-head.S          |  2 +-
 5 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 438c0c8f596a..89ed5237e79f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -636,12 +636,10 @@ static __always_inline void prefetchw(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-extern unsigned long __end_init_task[];
+extern unsigned long __top_init_kernel_stack[];
 
 #define INIT_THREAD {							\
-	.sp	= (unsigned long)&__end_init_task -			\
-		  TOP_OF_KERNEL_STACK_PADDING -				\
-		  sizeof(struct pt_regs),				\
+	.sp	= (unsigned long)&__top_init_kernel_stack,		\
 }
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index b50f3641c4d6..a9de527ba5c4 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -44,9 +44,6 @@
 #define X86_CAPABILITY	new_cpu_data+CPUINFO_x86_capability
 #define X86_VENDOR_ID	new_cpu_data+CPUINFO_x86_vendor_id
 
-
-#define SIZEOF_PTREGS 17*4
-
 /*
  * Worst-case size of the kernel mapping we need to make:
  * a relocatable kernel can live anywhere in lowmem, so we need to be able
@@ -488,13 +485,7 @@ SYM_DATA_END(initial_page_table)
 
 .data
 .balign 4
-/*
- * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
- * reliably detect the end of the stack.
- */
-SYM_DATA(initial_stack,
-		.long init_thread_union + THREAD_SIZE -
-		SIZEOF_PTREGS - TOP_OF_KERNEL_STACK_PADDING)
+SYM_DATA(initial_stack, .long __top_init_kernel_stack)
 
 __INITRODATA
 int_msg:
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8198fbd70e5..b11526869a40 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -66,7 +66,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	mov	%rsi, %r15
 
 	/* Set up the stack for verify_cpu() */
-	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
+	leaq	__top_init_kernel_stack(%rip), %rsp
 
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a20409b0a3f2..d430880175f2 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -167,6 +167,9 @@ SECTIONS
 		/* init_task */
 		INIT_TASK_DATA(THREAD_SIZE)
 
+		/* equivalent to task_pt_regs(&init_task) */
+		__top_init_kernel_stack = __end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
+
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
 		NOSAVE_DATA
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 04101b984f24..758bcd47b72d 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
 	ANNOTATE_NOENDBR
 	cld
 
-	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
+	leaq	__top_init_kernel_stack(%rip), %rsp
 
 	/* Set up %gs.
 	 *

base-commit: e1826833c3a9abb9d1fe4b938eca0e25eeafb39f
-- 
2.44.0


