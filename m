Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AB477B551
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjHNJWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjHNJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:22:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBDD130;
        Mon, 14 Aug 2023 02:22:29 -0700 (PDT)
Date:   Mon, 14 Aug 2023 09:22:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692004942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNZyioyg0CuqfNRFAIhBnybBfkifZC/RQ8HztUyD7MM=;
        b=gnqMSJp5O+I8IoMI3BZcJy0VbD3jNkJS+kSfB57wPIBUI2B6Zbdit4AM83LzSDpM/Bu8Ly
        b57OR02ZPMghb6gISCjsJYZv8SvvzU4AnsWDSPdOUOsraoIPZokoqfTyLm2A5ErvTSILRo
        bM4WNbFHzUKhCdvljsSGaVzbrp0+Ny/NK1Xt1wZLzfCs4IcsLKn3VdCMZ84Y7aIxWAD9PL
        hnglyzJgKv1cOqsyNE1h1lCQ5nnfXaLBOJKMK7U56evw9kOyvtdzQVvIEYX8hfJbn9QB2X
        rkGEQuEwPzLBaBNazPhOJOC3jZmytSTEuJ+b/yNX6fyeAHMzPgGAYDLKDuuLVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692004942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNZyioyg0CuqfNRFAIhBnybBfkifZC/RQ8HztUyD7MM=;
        b=R4bzImJcenZM1APzAvN3rocGHHb7B7iYKtoQjnd1tNJoMekLfKNsQMYqghJwmTZxnf2X32
        IoAi9ZGQBtsD6VAA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Fix the DIV(0) initial fix attempt
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230811213824.10025-1-bp@alien8.de>
References: <20230811213824.10025-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <169200494163.27769.3355062803892299575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f58d6fbcb7c848b7f2469be339bc571f2e9d245b
Gitweb:        https://git.kernel.org/tip/f58d6fbcb7c848b7f2469be339bc571f2e9d245b
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 11 Aug 2023 23:38:24 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Aug 2023 11:02:50 +02:00

x86/CPU/AMD: Fix the DIV(0) initial fix attempt

Initially, it was thought that doing an innocuous division in the #DE
handler would take care to prevent any leaking of old data from the
divider but by the time the fault is raised, the speculation has already
advanced too far and such data could already have been used by younger
operations.

Therefore, do the innocuous division on every exit to userspace so that
userspace doesn't see any potentially old data from integer divisions in
kernel space.

Do the same before VMRUN too, to protect host data from leaking into the
guest too.

Fixes: 77245f1c3c64 ("x86/CPU/AMD: Do not leak quotient data after a division by 0")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230811213824.10025-1-bp@alien8.de
---
 arch/x86/include/asm/entry-common.h | 1 +
 arch/x86/kernel/cpu/amd.c           | 1 +
 arch/x86/kernel/traps.c             | 2 --
 arch/x86/kvm/svm/svm.c              | 2 ++
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 1179038..ce8f501 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -92,6 +92,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 static __always_inline void arch_exit_to_user_mode(void)
 {
 	mds_user_clear_cpu_buffers();
+	amd_clear_divider();
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 70f9d56..7eca6a8 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1329,3 +1329,4 @@ void noinstr amd_clear_divider(void)
 	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
 		     :: "a" (0), "d" (0), "r" (1));
 }
+EXPORT_SYMBOL_GPL(amd_clear_divider);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1885326..4a817d2 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -206,8 +206,6 @@ DEFINE_IDTENTRY(exc_divide_error)
 {
 	do_error_trap(regs, 0, "divide error", X86_TRAP_DE, SIGFPE,
 		      FPE_INTDIV, error_get_trap_addr(regs));
-
-	amd_clear_divider();
 }
 
 DEFINE_IDTENTRY(exc_overflow)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 03e852d..d4bfdc6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4006,6 +4006,8 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 
 	guest_state_enter_irqoff();
 
+	amd_clear_divider();
+
 	if (sev_es_guest(vcpu->kvm))
 		__svm_sev_es_vcpu_run(svm, spec_ctrl_intercepted);
 	else
