Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BD3782116
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjHUBTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjHUBTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636FC9C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB07762605
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D164FC433D9;
        Mon, 21 Aug 2023 01:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580768;
        bh=hlfPMB76muHx2zFyaDw6ambZjeXjtNStPq4AfGznGPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uVHww6TbCRJe7oSuQNr0dsihjR5BCV7N9tGZhwO5cw0NP+FAeBkqIqf97N2yKnK21
         5JDdNVzZ4qiDZ0Q6/K5xfoHvif7cDXKLCffYkMVxup/D/et1QT1GKSBbwg7oC8U2Jt
         XZ3VPjYSt/5Aww6q2VOTzPML20CcSCK6fjiBGh8puMOHoIyutLU8ZHi835YAZyHv3b
         JM40H0J7OHWOYdL8y4KMUbM15gqoigiFqSygJ37BfjO7BsZssEP/ON78qeY9Vsl9w7
         0QQhU+zJZ+yVby28nEtMk5N/Nf9GPjjFltwa0aAsJTKe2kzP815K7sTUVDQ+izMMuA
         nq39x1Jj9qzNQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 02/22] x86/srso: Set CPUID feature bits independently of bug or mitigation status
Date:   Sun, 20 Aug 2023 18:18:59 -0700
Message-ID: <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692580085.git.jpoimboe@kernel.org>
References: <cover.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/include/asm/processor.h |  2 --
 arch/x86/kernel/cpu/amd.c        | 28 +++++++++-------------------
 arch/x86/kernel/cpu/bugs.c       | 13 +------------
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index fd750247ca89..9e26294e415c 100644
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
index 7eca6a8abbb1..b08af929135d 100644
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
index bdd3e296f72b..b0ae985aa6a4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2404,26 +2404,15 @@ early_param("spec_rstack_overflow", srso_parse_cmdline);
 
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
-		/*
-		 * Enable the synthetic (even if in a real CPUID leaf)
-		 * flags for guests.
-		 */
-		setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
-
 		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
-- 
2.41.0

