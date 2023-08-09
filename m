Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE81877540D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjHIH1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjHIH04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:26:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BE41FCC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ng0HtP0mPXxyVNZW9LodryzCfpmkt7bPV8Ile831CE4=; b=M47LJF7biidaZPu4RGHoBwBHFY
        zc2GSVau7Cw7LOi9fhrO9IdOjjB8lRI8fPuHpYk2h+Ufl7KEV8EIObz/o+fU1nVmZ/uKL7glayruu
        6c6kpHUxPWSzuz9+GeilbxqyRRLbZc2hLKFAqRs7cau4JA0Axo0ZwBYoyBg7JnE5Cnfl4DIACbSF2
        5tSFmDa65H38ul7LuvqjKyc/o9jX/uvBIRies7CpZH/m6Kz9YJa1T3Vrb/BdFtbDb7SwWIYm6jU7C
        un96CE+pcaKewgXJCVWB9vVmSWLMQPKgjXDlzJ7vo8DN+ouCejYhUSK/JdvlOuLczIL5KvzNLmhHI
        l0dgKq/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTdaf-004olP-MY; Wed, 09 Aug 2023 07:26:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96BBE300703;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5AE892CC1CFB6; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072200.850338672@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
References: <20230809071218.000335006@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it is now readily apparent that the two SRSO
untrain_ret+return_thunk variants are exactly the same mechanism as
the existing (retbleed) zen untrain_ret+return_thunk, add them to the
existing retbleed options.

This avoids all confusion as to which of the three -- if any -- ought
to be active, there's a single point of control and no funny
interactions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/bugs.c |   87 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -748,6 +748,8 @@ enum spectre_v2_mitigation spectre_v2_en
 enum retbleed_mitigation {
 	RETBLEED_MITIGATION_NONE,
 	RETBLEED_MITIGATION_UNRET,
+	RETBLEED_MITIGATION_UNRET_SRSO,
+	RETBLEED_MITIGATION_UNRET_SRSO_ALIAS,
 	RETBLEED_MITIGATION_IBPB,
 	RETBLEED_MITIGATION_IBRS,
 	RETBLEED_MITIGATION_EIBRS,
@@ -758,17 +760,21 @@ enum retbleed_mitigation_cmd {
 	RETBLEED_CMD_OFF,
 	RETBLEED_CMD_AUTO,
 	RETBLEED_CMD_UNRET,
+	RETBLEED_CMD_UNRET_SRSO,
+	RETBLEED_CMD_UNRET_SRSO_ALIAS,
 	RETBLEED_CMD_IBPB,
 	RETBLEED_CMD_STUFF,
 };
 
 static const char * const retbleed_strings[] = {
-	[RETBLEED_MITIGATION_NONE]	= "Vulnerable",
-	[RETBLEED_MITIGATION_UNRET]	= "Mitigation: untrained return thunk",
-	[RETBLEED_MITIGATION_IBPB]	= "Mitigation: IBPB",
-	[RETBLEED_MITIGATION_IBRS]	= "Mitigation: IBRS",
-	[RETBLEED_MITIGATION_EIBRS]	= "Mitigation: Enhanced IBRS",
-	[RETBLEED_MITIGATION_STUFF]	= "Mitigation: Stuffing",
+	[RETBLEED_MITIGATION_NONE]		= "Vulnerable",
+	[RETBLEED_MITIGATION_UNRET]		= "Mitigation: untrained return thunk",
+	[RETBLEED_MITIGATION_UNRET_SRSO]	= "Mitigation: srso untrained return thunk",
+	[RETBLEED_MITIGATION_UNRET_SRSO_ALIAS]	= "Mitigation: srso alias untrained return thunk",
+	[RETBLEED_MITIGATION_IBPB]		= "Mitigation: IBPB",
+	[RETBLEED_MITIGATION_IBRS]		= "Mitigation: IBRS",
+	[RETBLEED_MITIGATION_EIBRS]		= "Mitigation: Enhanced IBRS",
+	[RETBLEED_MITIGATION_STUFF]		= "Mitigation: Stuffing",
 };
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
@@ -796,6 +802,10 @@ static int __init retbleed_parse_cmdline
 			retbleed_cmd = RETBLEED_CMD_AUTO;
 		} else if (!strcmp(str, "unret")) {
 			retbleed_cmd = RETBLEED_CMD_UNRET;
+		} else if (!strcmp(str, "srso")) {
+			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO;
+		} else if (!strcmp(str, "srso_alias")) {
+			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO_ALIAS;
 		} else if (!strcmp(str, "ibpb")) {
 			retbleed_cmd = RETBLEED_CMD_IBPB;
 		} else if (!strcmp(str, "stuff")) {
@@ -817,21 +827,54 @@ early_param("retbleed", retbleed_parse_c
 
 #define RETBLEED_UNTRAIN_MSG "WARNING: BTB untrained return thunk mitigation is only effective on AMD/Hygon!\n"
 #define RETBLEED_INTEL_MSG "WARNING: Spectre v2 mitigation leaves CPU vulnerable to RETBleed attacks, data leaks possible!\n"
+#define RETBLEED_SRSO_NOTICE "WARNING: See https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitigation options."
 
 static void __init retbleed_select_mitigation(void)
 {
 	bool mitigate_smt = false;
+	bool has_microcode = false;
 
-	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
+	if ((!boot_cpu_has_bug(X86_BUG_RETBLEED) && !boot_cpu_has_bug(X86_BUG_SRSO)) ||
+	    cpu_mitigations_off())
 		return;
 
+	if (boot_cpu_has_bug(X86_BUG_SRSO)) {
+		has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
+		if (!has_microcode) {
+			pr_warn("IBPB-extending microcode not applied!\n");
+			pr_warn(RETBLEED_SRSO_NOTICE);
+		} else {
+			/*
+			 * Enable the synthetic (even if in a real CPUID leaf)
+			 * flags for guests.
+			 */
+			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
+			setup_force_cpu_cap(X86_FEATURE_SBPB);
+
+			/*
+			 * Zen1/2 with SMT off aren't vulnerable after the right
+			 * IBPB microcode has been applied.
+			 */
+			if ((boot_cpu_data.x86 < 0x19) &&
+			    (cpu_smt_control == CPU_SMT_DISABLED))
+				setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
+		}
+	}
+
 	switch (retbleed_cmd) {
 	case RETBLEED_CMD_OFF:
 		return;
 
 	case RETBLEED_CMD_UNRET:
+	case RETBLEED_CMD_UNRET_SRSO:
+	case RETBLEED_CMD_UNRET_SRSO_ALIAS:
 		if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY)) {
-			retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
+			if (retbleed_cmd == RETBLEED_CMD_UNRET)
+				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
+			if (retbleed_cmd == RETBLEED_CMD_UNRET_SRSO)
+				retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO;
+			if (retbleed_cmd == RETBLEED_CMD_UNRET_SRSO_ALIAS)
+				retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO_ALIAS;
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_UNRET_ENTRY.\n");
 			goto do_cmd_auto;
@@ -843,6 +886,8 @@ static void __init retbleed_select_mitig
 			pr_err("WARNING: CPU does not support IBPB.\n");
 			goto do_cmd_auto;
 		} else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
+			if (boot_cpu_has_bug(X86_BUG_SRSO) && !has_microcode)
+				pr_err("IBPB-extending microcode not applied; SRSO NOT mitigated\n");
 			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
@@ -870,8 +915,17 @@ static void __init retbleed_select_mitig
 	default:
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
-				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
+			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY)) {
+				if (boot_cpu_has_bug(X86_BUG_RETBLEED))
+					retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
+
+				if (boot_cpu_has_bug(X86_BUG_SRSO) && !boot_cpu_has(X86_FEATURE_SRSO_NO)) {
+					if (boot_cpu_data.x86 == 0x19)
+						retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO_ALIAS;
+					else
+						retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO;
+				}
+			}
 			else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
 				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
 		}
@@ -886,9 +940,20 @@ static void __init retbleed_select_mitig
 	}
 
 	switch (retbleed_mitigation) {
+	case RETBLEED_MITIGATION_UNRET_SRSO_ALIAS:
+		setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
+		x86_return_thunk = srso_alias_return_thunk;
+		goto do_rethunk;
+
+	case RETBLEED_MITIGATION_UNRET_SRSO:
+		setup_force_cpu_cap(X86_FEATURE_SRSO);
+		x86_return_thunk = srso_return_thunk;
+		goto do_rethunk;
+
 	case RETBLEED_MITIGATION_UNRET:
-		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
+do_rethunk:
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)


