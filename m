Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658597AFEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjI0Iue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjI0Iuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:50:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696DA95;
        Wed, 27 Sep 2023 01:50:30 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:50:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695804628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1tHVIYqE+sMaIp+HZXJZahZO0rDZZ9msFdB3oXvodU=;
        b=PTnWb0JXmCt3bGUd/C5hCnGTrPitCe8BS44PR/op1m0y/gbhb5DpmCzn1JG0wBOzGii5ur
        uZOI9+xotnj3IcTtxcOIMeodA1lmMf9VzukeentvPdD/YN/M+/aAQwm3c4aX6x9DZtY2Pu
        SEYiSfbAXcb9+Fmhe50p4V5eyTto7GYqofk0FoFhMDI5rDAN/OvLY24FA06zmPmuED7ZqL
        P3DsElOYsWk9mNZjXnEV6V7r4qMP/fjGbFPIgDbkArfn7a/1IZhS8QOUMwztzY5OAvHQb0
        MQcGnsKFB0TsS7a14FVUbTyTf+XW9ovYOs16Lte7yzsGJDa0kKpDF7340F0+Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695804628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1tHVIYqE+sMaIp+HZXJZahZO0rDZZ9msFdB3oXvodU=;
        b=NbSdLbhlLhiFWAwf5xNHCcP6bY/y9EjwlFlynk+Cd23JCF7aMQl6hBzCiL7ybet5pjgzr6
        lxy7Y5plkylZC2BA==
From:   "tip-bot2 for Alexey Kardashevskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/sev: Reduce #VC nesting for intercepted CPUID for
 SEV-SNP guest, to fix nesting crash
Cc:     Alexey Kardashevskiy <aik@amd.com>, Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230926040526.957240-1-aik@amd.com>
References: <20230926040526.957240-1-aik@amd.com>
MIME-Version: 1.0
Message-ID: <169580462768.27769.7125064834981635334.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     00541d61e7c68071fa589bdb045e7f5024f67713
Gitweb:        https://git.kernel.org/tip/00541d61e7c68071fa589bdb045e7f5024f67713
Author:        Alexey Kardashevskiy <aik@amd.com>
AuthorDate:    Tue, 26 Sep 2023 14:05:26 +10:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Sep 2023 10:46:22 +02:00

x86/sev: Reduce #VC nesting for intercepted CPUID for SEV-SNP guest, to fix nesting crash

For certain intercepts an SNP guest uses the GHCB protocol to talk to
the hypervisor from the #VC handler. The protocol requires a shared page so
there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
handler triggers a #VC, there is another "backup" GHCB page which stores
the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
The vc_raw_handle_exception() handler manages main and backup GHCB pages
via __sev_get_ghcb/__sev_put_ghcb.

This works fine for #VC and occasional NMIs. This does not work so fine if
the #VC handler causes intercept + another #VC, if NMI arrives during
the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
The problem place is the #VC CPUID handler. Running perf in the SNP guest
crashes with:

  Kernel panic - not syncing: Unable to handle #VC exception! GHCB and Backup GHCB are already in use

  vc_raw_handle_exception #1: exit_code 72 (CPUID) eax d ecx 1

We lock the main GHCB and while it is locked we get to
snp_cpuid_postprocess() which executes "rdmsr" of MSR_IA32_XSS==0xda0 which
triggers:

  vc_raw_handle_exception #2: exit_code 7c (MSR) ecx da0

Here we lock the backup ghcb.

And then PMC NMI comes which cannot complete as there is no GHCB page left
to use:

  CPU: 5 PID: 566 Comm: touch Not tainted 6.5.0-rc2-aik-ad9c-g7413e71d3dcf-dirty #27
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
  Call Trace:
   <NMI>
   dump_stack_lvl+0x44/0x60
   panic+0x222/0x310
   ____sev_get_ghcb+0x21e/0x220
   __sev_es_nmi_complete+0x28/0xf0
   exc_nmi+0x1ac/0x1c0
   end_repeat_nmi+0x16/0x67
  ...
   </NMI>
   <TASK>
   vc_raw_handle_exception+0x9e/0x2c0
   kernel_exc_vmm_communication+0x4d/0xa0
   asm_exc_vmm_communication+0x31/0x60
  RIP: 0010:snp_cpuid+0x2ad/0x420

Add a helper similar to rdmsr_safe() for making a direct hypercall in the SEV-ES
environment. Use the new helper instead of the raw "rdmsr" to avoid the extra
 #VC event.

Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230926040526.957240-1-aik@amd.com
---
 arch/x86/include/asm/svm.h   | 14 ++++++++++++++
 arch/x86/kernel/sev-shared.c |  5 +++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 19bf955..4416a8b 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -679,4 +679,18 @@ DEFINE_GHCB_ACCESSORS(sw_exit_info_2)
 DEFINE_GHCB_ACCESSORS(sw_scratch)
 DEFINE_GHCB_ACCESSORS(xcr0)
 
+/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
+#define rdmsr_safe_GHCB(msr, low, high, ghcb, ctxt) ({				\
+	int __ret;								\
+										\
+	ghcb_set_rcx((ghcb), (msr));						\
+	__ret = sev_es_ghcb_hv_call((ghcb), (ctxt), SVM_EXIT_MSR, 0, 0);	\
+	if (__ret == ES_OK) {							\
+		low  = (ghcb)->save.rax;					\
+		high = (ghcb)->save.rdx;					\
+		/* Invalidate qwords for likely another following GHCB call */	\
+		vc_ghcb_invalidate(ghcb);					\
+	}									\
+	__ret; })
+
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2eabccd..31f79da 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -439,8 +439,9 @@ static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
 			if (leaf->eax & BIT(3)) {
 				unsigned long lo, hi;
 
-				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
-						     : "c" (MSR_IA32_XSS));
+				if (rdmsr_safe_GHCB(MSR_IA32_XSS, lo, hi, ghcb, ctxt) != ES_OK)
+					return -EINVAL;
+
 				xss = (hi << 32) | lo;
 			}
 
