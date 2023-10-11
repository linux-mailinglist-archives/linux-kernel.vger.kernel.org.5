Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE887C607D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376546AbjJKWoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376503AbjJKWn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:43:58 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C591DA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:43:56 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3af5fcb5e37so199037b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064236; x=1697669036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3jwsa4qQcq6MjdP7xBGeHtYxSgXnGko/9ZE84LMQJ8=;
        b=ECh+tPxXyDRic13SZWqVcc9fcrWuVet2skFgr0vWL5hgFDKraU/hGvEtXywm79tIxl
         6Hadfai5vE4sUSjL47tZrEwECpgQiNwqXepB43m93rvdmV0ucEVgabCGj1mW8hHVBBDf
         Rzu6A81yAmV1dpFUlHZsr0H2p1XbG6HqH59moG2xbvudCWoSu2kEqVS5E9lPU9Q7L1NW
         OWyJVBFAiiUM5y0CWknlz73mHK5Os0lw6EQj5lFc36MzvEJTbSFvOBpr9QviVC0adQ8C
         mmciu5pstctcEDJshOxP1703PsKOSgU2pKxx2ioAUOKec4LulEESogNfegNZFbA8/DfM
         YwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064236; x=1697669036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3jwsa4qQcq6MjdP7xBGeHtYxSgXnGko/9ZE84LMQJ8=;
        b=sKQOKghFxcMxl00mvs932as1NUbfYIeGphBik7FocYUxQMUqAvEE6RSC2BKiEU4RPL
         NNLH3OTi5GIJbUULNSdWP8CIDLgNbXmQMsHYwDmF1ePGdl8VW1GB6396Hp4tREmyJYlt
         LDvKwHGXo4s2c4nRafiq2XUbXXKpuIzX3HTz5TD2O4x7vmOGkI0d6r5RA3H1P9O53vTo
         QMSpm0VjfXsKSjh2Wy9x030vpPdvSaZ7oX6vdxDb1CEYd8o4QWPdeqj4HYm3Lh3N5jiP
         Qrzx4Z4+g/w9y7zBSZ3LWMjBIWUnqAiRfIWzpBNoraIeakqdaC1zvGggukg4HLharZbM
         tYyA==
X-Gm-Message-State: AOJu0YzgoJbDjWn35wk4iodvtchQ4JPzGmXzp0hPzJCMkjo+8d4wbFHI
        Ex5O9VzATMul6D6r5KYmeU6Wrq1DcA==
X-Google-Smtp-Source: AGHT+IHD91chU2bpjpfLNczYCGqe8aLE5Ffk4rfb4b18+Hf/AJPw9ibblIAQZr5UZPrxB1Of2VPnSg==
X-Received: by 2002:a05:6808:238d:b0:3b0:d939:298b with SMTP id bp13-20020a056808238d00b003b0d939298bmr11076793oib.47.1697064235608;
        Wed, 11 Oct 2023 15:43:55 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o10-20020a0cf4ca000000b0065b129ec0e8sm6132871qvm.57.2023.10.11.15.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:43:55 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 1/3] x86/entry/64: Convert SYSRET validation tests to C
Date:   Wed, 11 Oct 2023 18:43:49 -0400
Message-ID: <20231011224351.130935-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011224351.130935-1-brgerst@gmail.com>
References: <20231011224351.130935-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c        | 43 ++++++++++++++++++++++++++-
 arch/x86/entry/entry_64.S      | 53 ++--------------------------------
 arch/x86/include/asm/syscall.h |  2 +-
 3 files changed, 45 insertions(+), 53 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 0551bcb197fb..207149a0a9b3 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -71,7 +71,8 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 	return false;
 }
 
-__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
+/* Returns true to return using SYSRET, or false to use IRET */
+__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 {
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
@@ -85,6 +86,46 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
 
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
+	if (unlikely(!__is_canonical_address(regs->ip, __VIRTUAL_MASK_SHIFT + 1)))
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
index 3bdc22d7e78f..de6469dffe3a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -126,57 +126,8 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 * In the Xen PV case we must use iret anyway.
 	 */
 
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
+	ALTERNATIVE "testb %al, %al; jz swapgs_restore_regs_and_return_to_usermode", \
+		"jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 
 	/*
 	 * We win! This label is here just for ease of understanding
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index c7e25c940f1a..f44e2f9ab65d 100644
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

