Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E47D7884D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbjHYKVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbjHYKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:20:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732262136;
        Fri, 25 Aug 2023 03:20:09 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RktaZDeSUcW5gejccp1Z0y2BQDy6OL9pq2tW1W4OM3U=;
        b=jYUiOPjUbreK/P6ZAqioF4iVYhzqx+W+Py93uVBmHbPWcOVOctosxQq12jaAyvU9s94HZ0
        Q2ziEj3P9OxJ5i8lvJYfRrVBIYNUPIFzGEsoz8i2cU/oxig+ghg8C/P3ysZhAfKMx6aFpJ
        ryXWsrAG1TywIRg//8QqNuAsurXqNpYx36m2qDhBMg2KaCLmQKjQThpZAC0GIa+eD0YRwg
        C/5GYGmIefBrdaPavizro0USmCeY5kLwRyi28rG0i4mUsfLN9wOP6BcwjrbIugq4GQgXtF
        VdGtoOZOayCd6NKkEA7lNbAk8JaF9g9VOSPIGnGC8AENX59a/BydUHDOTBYgrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RktaZDeSUcW5gejccp1Z0y2BQDy6OL9pq2tW1W4OM3U=;
        b=rD/3dcA+qoXy5erCzojrQyzpf3fd92RGf/6f2pvoLLT7Q9MRhGMIagpyncdsF08Y0+VCBT
        /M1FJb9ryCfAZzCw==
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
In-Reply-To: <f90527afa07624ba5912f0f3fec626e40cde0f24.1692919072.git.jpoimboe@kernel.org>
References: <f90527afa07624ba5912f0f3fec626e40cde0f24.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295877520.27769.5616267838589428019.tip-bot2@tip-bot2>
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

Commit-ID:     6a22cc6cfedcf7c4aa63230568a028a0fdd83e67
Gitweb:        https://git.kernel.org/tip/6a22cc6cfedcf7c4aa63230568a028a0fdd83e67
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:33 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:21:58 +02:00

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
Link: https://lore.kernel.org/r/f90527afa07624ba5912f0f3fec626e40cde0f24.1692919072.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/processor.h |  2 --
 arch/x86/kernel/cpu/amd.c        | 28 +++++++++-------------------
 arch/x86/kernel/cpu/bugs.c       | 13 +------------
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index fd75024..9e26294 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -676,12 +676,10 @@ extern u16 get_llc_id(unsigned int cpu);
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_nodes_per_socket(void);
 extern u32 amd_get_highest_perf(void);
-extern bool cpu_has_ibpb_brtype_microcode(void);
 extern void amd_clear_divider(void);
 #else
 static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
-static inline bool cpu_has_ibpb_brtype_microcode(void)	{ return false; }
 static inline void amd_clear_divider(void)		{ }
 #endif
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 7eca6a8..b08af92 100644
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
