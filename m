Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C97FD583
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjK2LWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjK2LWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0E4171D;
        Wed, 29 Nov 2023 03:22:31 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++C9fCyPTZf5m4s6SYgnlSiDBPDbvOlA+9j4OOKLHCU=;
        b=2vVXrnnQjbXmYmdLB7avZgnhwRDkjNM2UbYngMxMGUk+B4pxeydyn1vhOT0iezWNuvzmCd
        cXt8NrNsT0KOQAZ7S/vRv1fZi1A0qsTD3UjwaLlaiOvksPsim24fGG6Muzo7IHyMkRh4Aj
        j+g1/ag69ba5MRM2C83liHZuEYyCm1TXUsuKDoOWrHrRaQ8PEu6uyHYTtTmCy4prgr4xoU
        g9hoGVdSHsacVAAMwuEeO22PJwfhmm+bCPDerPU3JZNqaNisAXmESLhNXYNxd9y+E32rL4
        UazPXXYO9HGZxeN2njb4thOavK8XSerQjg4uZbJuZhdCrdRX4hRF+zb6jN4cIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++C9fCyPTZf5m4s6SYgnlSiDBPDbvOlA+9j4OOKLHCU=;
        b=60d+/AoUJuzPBYPGhStOl16GUwDTPr6ccC/TlasjqZEGLO+mixF/ZM59Jjy/wY9IuFBx/h
        OZ4SG6xwlmYzGtDA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Move Zenbleed check to the Zen2 init function
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-8-bp@alien8.de>
References: <20231120104152.13740-8-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125694941.398.1156683558217970718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f69759be251dce722942594fbc62e53a40822a82
Gitweb:        https://git.kernel.org/tip/f69759be251dce722942594fbc62e53a40822a82
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 01 Nov 2023 12:38:35 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:12:34 +01:00

x86/CPU/AMD: Move Zenbleed check to the Zen2 init function

Prefix it properly so that it is clear which generation it is dealing
with.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: http://lore.kernel.org/r/20231120104152.13740-8-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f53e0a2..3c3b4c1 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -70,12 +70,6 @@ static const int amd_erratum_383[] =
 static const int amd_erratum_1054[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
 
-static const int amd_zenbleed[] =
-	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x30, 0x0, 0x4f, 0xf),
-			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
-			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x91, 0xf),
-			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
-
 static const int amd_div0[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
@@ -1059,11 +1053,8 @@ static bool cpu_has_zenbleed_microcode(void)
 	return true;
 }
 
-static void zenbleed_check(struct cpuinfo_x86 *c)
+static void zen2_zenbleed_check(struct cpuinfo_x86 *c)
 {
-	if (!cpu_has_amd_erratum(c, amd_zenbleed))
-		return;
-
 	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
 		return;
 
@@ -1084,6 +1075,7 @@ static void init_amd_zen2(struct cpuinfo_x86 *c)
 	init_amd_zen_common();
 	init_spectral_chicken(c);
 	fix_erratum_1386(c);
+	zen2_zenbleed_check(c);
 }
 
 static void init_amd_zen3(struct cpuinfo_x86 *c)
@@ -1227,8 +1219,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	    cpu_has(c, X86_FEATURE_AUTOIBRS))
 		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS));
 
-	zenbleed_check(c);
-
 	if (cpu_has_amd_erratum(c, amd_div0)) {
 		pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
 		setup_force_cpu_bug(X86_BUG_DIV0);
@@ -1393,7 +1383,7 @@ static void zenbleed_check_cpu(void *unused)
 {
 	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
 
-	zenbleed_check(c);
+	zen2_zenbleed_check(c);
 }
 
 void amd_check_microcode(void)
