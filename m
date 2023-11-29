Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC3E7FD588
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjK2LXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjK2LWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FAD1BC5;
        Wed, 29 Nov 2023 03:22:35 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256953;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wRWoLYfCxb2rD35PLDvM7TDZLoRJJmNWECOPej3NnVA=;
        b=UHCc4r0eYu/bBA5ggnGjrHpge1W6RzmZiWa0brChWDkjZp0+TFxewiPUGWmj5wJDDNl8xE
        H87hR/AWuaomWp1uWZyYmLYPuNsYFTAYqM5EmyrAkX8XhV3tcHLwhuM99pnuXeoObjc4Aw
        aUEHTeiRalAXKFsPSt1eJ4FE9IJbMmLYJ4Hj8g3Cvw0TLMY7aZoBnYuMeitt71yTp+DXIX
        G7kV+eIXNJ+3/5DLv2S7hRLh2zSOUTHabC59BrLVLvXZFYJIL3EHT9u1EItt9ZaV5NpplH
        jS6O4symOTENdt4o3fa21sIk6044PikyhXXfXt6M1P2SXAs35GxzliPkaUStxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256953;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wRWoLYfCxb2rD35PLDvM7TDZLoRJJmNWECOPej3NnVA=;
        b=9P8DFIFDjCfoQD9SVXUfEIiga5vi+CCwtEk5WmAwaJXXFn/VstJ8SKgY5tqtZ495erII7A
        osE+KkvkKsPQXoBA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Carve out the erratum 1386 fix
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-3-bp@alien8.de>
References: <20231120104152.13740-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125695303.398.11143867605692920679.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a7c32a1ae9ee43abfe884f5af376877c4301d166
Gitweb:        https://git.kernel.org/tip/a7c32a1ae9ee43abfe884f5af376877c4301d166
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 01 Nov 2023 11:14:59 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:11:21 +01:00

x86/CPU/AMD: Carve out the erratum 1386 fix

Call it on the affected CPU generations.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-3-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 6aba224..0a499cb 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -984,6 +984,19 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 	clear_rdrand_cpuid_bit(c);
 }
 
+static void fix_erratum_1386(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
+	 * certain circumstances on Zen1/2 uarch, and not all parts have had
+	 * updated microcode at the time of writing (March 2023).
+	 *
+	 * Affected parts all have no supervisor XSAVE states, meaning that
+	 * the XSAVEC instruction (which works fine) is equivalent.
+	 */
+	clear_cpu_cap(c, X86_FEATURE_XSAVES);
+}
+
 void init_spectral_chicken(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_CPU_UNRET_ENTRY
@@ -1004,15 +1017,6 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 		}
 	}
 #endif
-	/*
-	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
-	 * certain circumstances on Zen1/2 uarch, and not all parts have had
-	 * updated microcode at the time of writing (March 2023).
-	 *
-	 * Affected parts all have no supervisor XSAVE states, meaning that
-	 * the XSAVEC instruction (which works fine) is equivalent.
-	 */
-	clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
 
 static void init_amd_zn(struct cpuinfo_x86 *c)
@@ -1080,10 +1084,12 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
 
 static void init_amd_zen(struct cpuinfo_x86 *c)
 {
+	fix_erratum_1386(c);
 }
 
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
+	fix_erratum_1386(c);
 }
 
 static void init_amd_zen3(struct cpuinfo_x86 *c)
