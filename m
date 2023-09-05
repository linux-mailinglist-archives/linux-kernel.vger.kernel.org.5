Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2E7926E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbjIEQIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354207AbjIEKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDC21B4;
        Tue,  5 Sep 2023 03:09:42 -0700 (PDT)
Date:   Tue, 05 Sep 2023 10:09:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693908581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zAW1sY8y/CFtmVQ3AG6AXSgo3LrJt8x+AHQltKYCTY=;
        b=Ui+aKj/JzK2cMg4MxPGpkxlrvNygtE5vTNZR+4YM12pTK0J9wlgYXuOWDo6onf+FfPcZpO
        BHbnKU/6zBdrYSrAkts88x5KuPoyevb+RRMLDOlVfW54Rlj8perTSdhvMMiMcZfqe0KmBj
        kT3lbpMSh5STT43eL6MvOPPUQXLQPmMnMhp3/gwmPCzKFBgcB9WdmCqNfgFBuaukHUTmDv
        nRrY743bYLHLgwWtm7NYafPgFyHtdXJ+bH3LRfZS6s8kNxcGXRlR1gXxCMbvQgskYsPNco
        QBM1fruQwxp17xNTIFWwGucIqcOZ+Pb2ge3bA7s9GXInkeWD8oiSSMeb8Yktsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693908581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zAW1sY8y/CFtmVQ3AG6AXSgo3LrJt8x+AHQltKYCTY=;
        b=AR5hYpX5E5PURkPVwBHMNeD7J3HwKqaPtgClIz0OauPsZEdhNf5SLCZTnU0Q9LQeFVtAMq
        kJFift+lrTQxrECg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Set CPUID feature bits independently of bug
 or mitigation status
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <869a1709abfe13b673bdd10c2f4332ca253a40bc.1693889988.git.jpoimboe@kernel.org>
References: <869a1709abfe13b673bdd10c2f4332ca253a40bc.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169390858054.27769.11564324626267743244.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     2ab15814d800b8c4526eda2750bf33b58555b86b
Gitweb:        https://git.kernel.org/tip/2ab15814d800b8c4526eda2750bf33b58555b86b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:46 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 05 Sep 2023 12:05:06 +02:00

x86/srso: Set CPUID feature bits independently of bug or mitigation status

Booting with mitigations=off incorrectly prevents the
X86_FEATURE_{IBPB_BRTYPE,SBPB} CPUID bits from getting set.

Also, future CPUs without X86_BUG_SRSO might still have IBPB with branch
type prediction flushing, in which case SBPB should be used instead of
IBPB.  The current code doesn't allow for that.

Also, cpu_has_ibpb_brtype_microcode() has some surprising side effects
and the setting of these feature bits really doesn't belong in the
mitigation code anyway.  Move it to earlier.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/869a1709abfe13b673bdd10c2f4332ca253a40bc.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/processor.h |  2 --
 arch/x86/kernel/cpu/amd.c        | 28 +++++++++-------------------
 arch/x86/kernel/cpu/bugs.c       | 13 +------------
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0086920..a3669a7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -683,13 +683,11 @@ extern u16 get_llc_id(unsigned int cpu);
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_nodes_per_socket(void);
 extern u32 amd_get_highest_perf(void);
-extern bool cpu_has_ibpb_brtype_microcode(void);
 extern void amd_clear_divider(void);
 extern void amd_check_microcode(void);
 #else
 static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
-static inline bool cpu_has_ibpb_brtype_microcode(void)	{ return false; }
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
 #endif
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index dd8379d..afacc48 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -766,6 +766,15 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 
 	if (cpu_has(c, X86_FEATURE_TOPOEXT))
 		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
+
+	if (!cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
+		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
+			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
+		else if (c->x86 >= 0x19 && !wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
+			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
+			setup_force_cpu_cap(X86_FEATURE_SBPB);
+		}
+	}
 }
 
 static void init_amd_k8(struct cpuinfo_x86 *c)
@@ -1301,25 +1310,6 @@ void amd_check_microcode(void)
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
 
-bool cpu_has_ibpb_brtype_microcode(void)
-{
-	switch (boot_cpu_data.x86) {
-	/* Zen1/2 IBPB flushes branch type predictions too. */
-	case 0x17:
-		return boot_cpu_has(X86_FEATURE_AMD_IBPB);
-	case 0x19:
-		/* Poke the MSR bit on Zen3/4 to check its presence. */
-		if (!wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
-			setup_force_cpu_cap(X86_FEATURE_SBPB);
-			return true;
-		} else {
-			return false;
-		}
-	default:
-		return false;
-	}
-}
-
 /*
  * Issue a DIV 0/1 insn to clear any division data from previous DIV
  * operations.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bdd3e29..b0ae985 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2404,27 +2404,16 @@ early_param("spec_rstack_overflow", srso_parse_cmdline);
 
 static void __init srso_select_mitigation(void)
 {
-	bool has_microcode;
+	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
 	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
 		goto pred_cmd;
 
-	/*
-	 * The first check is for the kernel running as a guest in order
-	 * for guests to verify whether IBPB is a viable mitigation.
-	 */
-	has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
 	if (!has_microcode) {
 		pr_warn("IBPB-extending microcode not applied!\n");
 		pr_warn(SRSO_NOTICE);
 	} else {
 		/*
-		 * Enable the synthetic (even if in a real CPUID leaf)
-		 * flags for guests.
-		 */
-		setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
-
-		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
 		 */
