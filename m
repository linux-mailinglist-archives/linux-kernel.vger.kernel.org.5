Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55497FD578
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjK2LWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjK2LWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8693519BC;
        Wed, 29 Nov 2023 03:22:28 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZgRhBmUlUnwhB36HfXgplvzDOMNeYjiRUD2/zH/lSI=;
        b=CG5AvWONmjQIsto2kag/zI+lQT7u7nhF2oCEPdZHmAjjeVOjP+SCk2nyh5nqndKsmAnlcu
        +8MMfBSSnLs8WA9+ceCfRIWh306L7uY8sZVT7MDLHQzHfZp9V3yKvWOF5RNLaTwT854eqa
        upNdy5BeOfDaTmujhH/gPWZmGhyxLgbthSr5DMouP5chaa0Ya2Mfyadf0MMCaC9e1lwAoI
        LZ/T17hO7PqKQGkyuApm/9TVSe9AK0IaMoZGFD6djlzyXx5OEKXUOmLUwiTZ7uzZMwbcZm
        u3e/Oemkn6d+jU4cc2icMtxuClmMbpZ/nPrFBTVia4BzkfcM855qKuyIvvUXxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZgRhBmUlUnwhB36HfXgplvzDOMNeYjiRUD2/zH/lSI=;
        b=LFT7HSq+61U4GVd31XtA3sHeGTiEQt+RF5GHe1p/6n5Ltb3ZwVXybbK4UOw8nLKnp1R5qX
        6AeU+kqmW/tRf8Dg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Get rid of amd_erratum_400[]
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-12-bp@alien8.de>
References: <20231120104152.13740-12-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125694654.398.5196102162020154893.tip-bot2@tip-bot2>
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

Commit-ID:     b3ffbbd282d4eb79f489853a171242c2a06bd8b8
Gitweb:        https://git.kernel.org/tip/b3ffbbd282d4eb79f489853a171242c2a06bd8b8
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 03 Nov 2023 23:20:11 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:13:23 +01:00

x86/CPU/AMD: Get rid of amd_erratum_400[]

Setting X86_BUG_AMD_E400 in init_amd() is early enough.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-12-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 7ab7f98..550ac25 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -59,10 +59,6 @@ static u32 nodes_per_socket = 1;
 #define AMD_MODEL_RANGE_START(range)	(((range) >> 12) & 0xfff)
 #define AMD_MODEL_RANGE_END(range)	((range) & 0xfff)
 
-static const int amd_erratum_400[] =
-	AMD_OSVW_ERRATUM(1, AMD_MODEL_RANGE(0xf, 0x41, 0x2, 0xff, 0xf),
-			    AMD_MODEL_RANGE(0x10, 0x2, 0x1, 0xff, 0xf));
-
 static const int amd_erratum_1485[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
 			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
@@ -765,15 +761,6 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	if (c->x86 == 0x16 && c->x86_model <= 0xf)
 		msr_set_bit(MSR_AMD64_LS_CFG, 15);
 
-	/*
-	 * Check whether the machine is affected by erratum 400. This is
-	 * used to select the proper idle routine and to enable the check
-	 * whether the machine is affected in arch_post_acpi_init(), which
-	 * sets the X86_BUG_AMD_APIC_C1E bug depending on the MSR check.
-	 */
-	if (cpu_has_amd_erratum(c, amd_erratum_400))
-		set_cpu_bug(c, X86_BUG_AMD_E400);
-
 	early_detect_mem_encrypt(c);
 
 	/* Re-enable TopologyExtensions if switched off by BIOS */
@@ -840,6 +827,16 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	msr_set_bit(MSR_K7_HWCR, 6);
 #endif
 	set_cpu_bug(c, X86_BUG_SWAPGS_FENCE);
+
+	/*
+	 * Check models and steppings affected by erratum 400. This is
+	 * used to select the proper idle routine and to enable the
+	 * check whether the machine is affected in arch_post_acpi_subsys_init()
+	 * which sets the X86_BUG_AMD_APIC_C1E bug depending on the MSR check.
+	 */
+	if (c->x86_model > 0x41 ||
+	    (c->x86_model == 0x41 && c->x86_stepping >= 0x2))
+		setup_force_cpu_bug(X86_BUG_AMD_E400);
 }
 
 static void init_amd_gh(struct cpuinfo_x86 *c)
@@ -874,6 +871,16 @@ static void init_amd_gh(struct cpuinfo_x86 *c)
 	msr_clear_bit(MSR_AMD64_BU_CFG2, 24);
 
 	set_cpu_bug(c, X86_BUG_AMD_TLB_MMATCH);
+
+	/*
+	 * Check models and steppings affected by erratum 400. This is
+	 * used to select the proper idle routine and to enable the
+	 * check whether the machine is affected in arch_post_acpi_subsys_init()
+	 * which sets the X86_BUG_AMD_APIC_C1E bug depending on the MSR check.
+	 */
+	if (c->x86_model > 0x2 ||
+	    (c->x86_model == 0x2 && c->x86_stepping >= 0x1))
+		setup_force_cpu_bug(X86_BUG_AMD_E400);
 }
 
 static void init_amd_ln(struct cpuinfo_x86 *c)
