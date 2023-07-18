Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257E0757E04
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjGRNpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGRNpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:45:02 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4193DD1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:01 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1b3c503af99so3968303fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689687900; x=1692279900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lEWUAIqsSfnKHfBAoJe/16DZctl9ATFmFT415kFxyk=;
        b=HpoRg2kORxwsOdZ9M6pI5W+pBvHeF6xR4uOJiDqPTdKNLzxhEq4nm0Gk29gLqXF+/t
         GEwI8KLl0wfVC8+E5HXjA2c+ToTQJjZmqghDtKGtgMerlfJQXUxlKzUTrY9uvLc9TfJN
         RbP3HMBy8iwb38Snrku/MEH+DooQBbcgISpK25LH+OOZr8nfH8hGkcIQNq04TXmTfRTr
         n+yw3jDo2XkjZcSTnUcnFX9ryNBcfJEaEuE4cpjlZ0V9E8qZDDzHw5laC8w3OVqFO6nI
         UoIe3ZW/qC8WnwVEw1dMmHxxPl1RFnOvAe/IpGy8MspjPYwv8hNet9smabZpb+nS8YBY
         z2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687900; x=1692279900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lEWUAIqsSfnKHfBAoJe/16DZctl9ATFmFT415kFxyk=;
        b=EmgQln3ZGo3vYA9jSNZZYnMEIoOVfdmPzLMJV/YHZBcYqPcwr7mdGWVaHeAmUe1XuJ
         6w3Vd3FEjbc/UlzpxeAlKaDs1mJStPMrbiClq9FrJh+8xQgGuhiSgPzj/5xQOmRexjYS
         KIFkBx1ytuMXSXXAyJ+UVbvApDVdaRj7UOxOW4Z8iitXjX5lwdU+wXRNBBXm6cmpmbZU
         MKH4aH4ZKxRhuVd1Bn0EtjrTir6ChC/JfD4+2CCt/1tYnEaBGHdCHYeAqchcbHWkvVOV
         WAQGLUdT+zWbaYEt3RkUDBniaXswEjeTV6dbKnxOFz5ooey53fzJbW950i3idEgKrZE3
         46ag==
X-Gm-Message-State: ABy/qLaaQI0B4CVhDfJ7dcZZFMb7HDOMibI/VH+POt50JWl43l2CmHaD
        wwrX+ZwnYo0x01zqESIORRxXXsqJeg==
X-Google-Smtp-Source: APBJJlEm1OAOJDfGCou/M5BV3u17gOhDf6JryXMzwJ9d8Luc2k0Ogkll7rUWR9yyrAWLZ1+hC2inPQ==
X-Received: by 2002:a05:6871:9b:b0:1b7:4c74:e1af with SMTP id u27-20020a056871009b00b001b74c74e1afmr16748571oaa.59.1689687899753;
        Tue, 18 Jul 2023 06:44:59 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id q7-20020a4aac47000000b005660ed0becesm726778oon.39.2023.07.18.06.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:44:58 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/6] x86/entry/64: Convert SYSRET validation tests to C
Date:   Tue, 18 Jul 2023 09:44:42 -0400
Message-ID: <20230718134446.168654-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718134446.168654-1-brgerst@gmail.com>
References: <20230718134446.168654-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c        | 50 ++++++++++++++++++++++++++++++-
 arch/x86/entry/entry_64.S      | 55 ++--------------------------------
 arch/x86/include/asm/syscall.h |  2 +-
 3 files changed, 52 insertions(+), 55 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..afe79c3f1c5b 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -70,8 +70,12 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 	return false;
 }
 
-__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
+/* Returns true to return using SYSRET, or false to use IRET */
+__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 {
+	long rip;
+	unsigned int shift_rip;
+
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
@@ -84,6 +88,50 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
 
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
+
+	/*
+	 * Check that the register state is valid for using SYSRET to exit
+	 * to userspace.  Otherwise use the slower but fully capable IRET
+	 * exit path.
+	 */
+
+	/* XEN PV guests always use IRET path */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+
+	/* SYSRET requires RCX == RIP and R11 == EFLAGS */
+	if (unlikely(regs->cx != regs->ip || regs->r11 != regs->flags))
+		return false;
+
+	/* CS and SS must match the values set in MSR_STAR */
+	if (unlikely(regs->cs != __USER_CS || regs->ss != __USER_DS))
+		return false;
+
+	/*
+	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
+	 * in kernel space.  This essentially lets the user take over
+	 * the kernel, since userspace controls RSP.
+	 *
+	 * Change top bits to match most significant bit (47th or 56th bit
+	 * depending on paging mode) in the address.
+	 */
+	shift_rip = (64 - __VIRTUAL_MASK_SHIFT + 1);
+	rip = (long) regs->ip;
+	rip <<= shift_rip;
+	rip >>= shift_rip;
+	if (unlikely((unsigned long) rip != regs->ip))
+		return false;
+
+	/*
+	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
+	 * restoring TF results in a trap from userspace immediately after
+	 * SYSRET.
+	 */
+	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)))
+		return false;
+
+	/* Use SYSRET to exit to userspace */
+	return true;
 }
 #endif
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c01776a51545..b1288e22cae8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -123,60 +123,9 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 * Try to use SYSRET instead of IRET if we're returning to
 	 * a completely clean 64-bit userspace context.  If we're not,
 	 * go to the slow exit path.
-	 * In the Xen PV case we must use iret anyway.
 	 */
-
-	ALTERNATIVE "", "jmp	swapgs_restore_regs_and_return_to_usermode", \
-		X86_FEATURE_XENPV
-
-	movq	RCX(%rsp), %rcx
-	movq	RIP(%rsp), %r11
-
-	cmpq	%rcx, %r11	/* SYSRET requires RCX == RIP */
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	/*
-	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
-	 * in kernel space.  This essentially lets the user take over
-	 * the kernel, since userspace controls RSP.
-	 *
-	 * If width of "canonical tail" ever becomes variable, this will need
-	 * to be updated to remain correct on both old and new CPUs.
-	 *
-	 * Change top bits to match most significant bit (47th or 56th bit
-	 * depending on paging mode) in the address.
-	 */
-#ifdef CONFIG_X86_5LEVEL
-	ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
-		"shl $(64 - 57), %rcx; sar $(64 - 57), %rcx", X86_FEATURE_LA57
-#else
-	shl	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
-	sar	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
-#endif
-
-	/* If this changed %rcx, it was not canonical */
-	cmpq	%rcx, %r11
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	cmpq	$__USER_CS, CS(%rsp)		/* CS must match SYSRET */
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	movq	R11(%rsp), %r11
-	cmpq	%r11, EFLAGS(%rsp)		/* R11 == RFLAGS */
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	/*
-	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
-	 * restoring TF results in a trap from userspace immediately after
-	 * SYSRET.
-	 */
-	testq	$(X86_EFLAGS_RF|X86_EFLAGS_TF), %r11
-	jnz	swapgs_restore_regs_and_return_to_usermode
-
-	/* nothing to check for RSP */
-
-	cmpq	$__USER_DS, SS(%rsp)		/* SS must match SYSRET */
-	jne	swapgs_restore_regs_and_return_to_usermode
+	testb	%al, %al
+	jz	swapgs_restore_regs_and_return_to_usermode
 
 	/*
 	 * We win! This label is here just for ease of understanding
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 4fb36fba4b5a..be6c5515e0b9 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -126,7 +126,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
 
-void do_syscall_64(struct pt_regs *regs, int nr);
+bool do_syscall_64(struct pt_regs *regs, int nr);
 
 #endif	/* CONFIG_X86_32 */
 
-- 
2.41.0

