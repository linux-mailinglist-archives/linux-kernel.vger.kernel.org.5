Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971257D0D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376870AbjJTK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376842AbjJTK3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:29:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8938D52;
        Fri, 20 Oct 2023 03:28:57 -0700 (PDT)
Date:   Fri, 20 Oct 2023 10:28:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697797735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VhHzo1Cv7+X6YKiJes2rk0Mf7POXMLyxJrcorpDyS4s=;
        b=GzDaKj0HmAZ6iPfxGhT0JGrqyCtvN8oFszVWl50DZKK7FQMwfnK6nLSilYU1seD6eiCOeL
        Fp+xE2qDLoPHV/EbgqjhfF7mqrURzSitQP+URxgybHcZ4rBDGVtzxJv9LAAxNy7Tajx0vl
        XDwHOD3XTeC4331n6N9Y+/NLS42TseIVUfvGEiI+Z+cfhpgeMpFLbLqUq9sDcwwD2SulTN
        5RFHaMORmNmQFF/p0rZLl0E50UHMx/s4z6ndVeU/mazZfRwbkcIFoCJgDOVKm72GbdYtKP
        j5vG5fCbzddG0R3AHgxjOf6GIbYC03dRwwsDpGBW0dGtY6rYVKyKp3zIQpMUXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697797735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VhHzo1Cv7+X6YKiJes2rk0Mf7POXMLyxJrcorpDyS4s=;
        b=+BNt2ql994GaQA5D24LQCr3xiFGbtD1LfdQc43o4h1iZ2qfHVztOI2VcwupqmSj7uyR45h
        nCr7ilQLv+ncpxBg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu, xen: Correct PER_CPU_VAR() usage to
 include symbol and its addend
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, Brian Gerst <brgerst@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169779773522.3135.10554164923279581371.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     aa47f90cd4331e1809d56c72fcbdbbe0a85e5992
Gitweb:        https://git.kernel.org/tip/aa47f90cd4331e1809d56c72fcbdbbe0a85e5992
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 17 Oct 2023 18:27:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 20 Oct 2023 12:19:51 +02:00

x86/percpu, xen: Correct PER_CPU_VAR() usage to include symbol and its addend

The PER_CPU_VAR() macro should be applied to a symbol and its addend.
Inconsistent usage is currently harmless, but needs to be corrected
before %rip-relative addressing is introduced to the PER_CPU_VAR() macro.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: linux-kernel@vger.kernel.org
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/xen-asm.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 9e5e680..448958d 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -28,7 +28,7 @@
  * non-zero.
  */
 SYM_FUNC_START(xen_irq_disable_direct)
-	movb $1, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+	movb $1, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
 	RET
 SYM_FUNC_END(xen_irq_disable_direct)
 
@@ -69,7 +69,7 @@ SYM_FUNC_END(check_events)
 SYM_FUNC_START(xen_irq_enable_direct)
 	FRAME_BEGIN
 	/* Unmask events */
-	movb $0, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+	movb $0, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
 
 	/*
 	 * Preempt here doesn't matter because that will deal with any
@@ -78,7 +78,7 @@ SYM_FUNC_START(xen_irq_enable_direct)
 	 */
 
 	/* Test for pending */
-	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_pending
+	testb $0xff, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_pending)
 	jz 1f
 
 	call check_events
@@ -97,7 +97,7 @@ SYM_FUNC_END(xen_irq_enable_direct)
  * x86 use opposite senses (mask vs enable).
  */
 SYM_FUNC_START(xen_save_fl_direct)
-	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+	testb $0xff, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
 	setz %ah
 	addb %ah, %ah
 	RET
@@ -113,7 +113,7 @@ SYM_FUNC_END(xen_read_cr2);
 
 SYM_FUNC_START(xen_read_cr2_direct)
 	FRAME_BEGIN
-	_ASM_MOV PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_arch_cr2, %_ASM_AX
+	_ASM_MOV PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_arch_cr2), %_ASM_AX
 	FRAME_END
 	RET
 SYM_FUNC_END(xen_read_cr2_direct);
