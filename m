Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93194801CB2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjLBMtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBMtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:49:09 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270BFF0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 04:49:15 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61B7740E0195;
        Sat,  2 Dec 2023 12:49:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZyhtD1Jw_lpt; Sat,  2 Dec 2023 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701521350; bh=LooIIPRZ7pl7LhT6BDhGK//INYqvbPWGXvxL+VLbTw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eozt7UoCUlSupnilVrnFqo13FyWTvphQZSFJT9cpFkwx6TWCdC9EcNUBLxzsR6IkC
         ExNYiAhtbqGATxWS61wia/gErr5EcFZaHbGv+hf0mbwqm4dlU567rif+QoKJd+tQxF
         tgQa6Q+gwmGdwcTesC6R1Y97bRibF3ZV7ZQLl63WXxDb63vWMvdG/9uSF2twR4Z+rw
         C97QSf18GbqZLEOM9K5BDIvTpZhdyyZMzPU3bBE/X8/19V1HIodq8jSG3z/vUTRVbG
         mfH3wv2jgZxZFlLLX52IRRAUXGwCGDWld4DOGmkwhfJAZd/NTyq/DsH89RrBE0Ae4E
         1bvRx/9NDazgUkgXeCn69sb7O09I1fIF4o3y6zalj/eJiC8YR9aNbooK7CtAtOxHkP
         wvxagN4av8CC96wlq0Q07t8ZeW05P2DmLxEiRMdXuluPiYuYHxQV8Atdv1njP2pQ4h
         8OECdAN3TEBNvhinb92VDR/8nlqQeqrX9OvoWHeybdLk2mhpj0j/aqh+oZ86EmsMDq
         dLD9HReT0O3pftJ5suPhZOOBzR+1D13m73EeD6jaxsvZelqlXuKT9JVij7tCpinxHp
         s7lINQbGG6+AAenXvmkLQHhQI5oWRO67VC1a7E7PJuZ/XOqpzBU4QVwNhdXJ0pQjNj
         uYtNAm68atoVsSRYYRQUcA4M=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D53940E0030;
        Sat,  2 Dec 2023 12:49:06 +0000 (UTC)
Date:   Sat, 2 Dec 2023 13:49:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brian Gerst <brgerst@gmail.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/CPU/AMD: Add X86_FEATURE_ZEN1
Message-ID: <20231202124901.GBZWsnvQct4PxsUsXK@fat_crate.local>
References: <20231120104152.13740-1-bp@alien8.de>
 <20231120104152.13740-2-bp@alien8.de>
 <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com>
 <20231130171316.GLZWjCrHGHl+VVp724@fat_crate.local>
 <16400d3d-8264-4f3f-96ca-168064944462@amd.com>
 <20231130185048.GMZWjZiIjhpjrv4rPf@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130185048.GMZWjZiIjhpjrv4rPf@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Sat, 2 Dec 2023 12:50:23 +0100

Add a synthetic feature flag specifically for first generation Zen
machines. There's need to have a generic flag for all Zen generations so
make X86_FEATURE_ZEN be that flag.

Fixes: 30fa92832f40 ("x86/CPU/AMD: Add ZenX generations flags")
Suggested-by: Brian Gerst <brgerst@gmail.com>
Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com
---
 arch/x86/include/asm/cpufeatures.h       | 3 ++-
 arch/x86/kernel/cpu/amd.c                | 7 ++++---
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 149cc5d5c2ae..632c26cdeeda 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -218,7 +218,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU based on Zen microarchitecture */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" Generic flag for all Zen and newer */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
@@ -315,6 +315,7 @@
 #define X86_FEATURE_ZEN2		(11*32+28) /* "" CPU based on Zen2 microarchitecture */
 #define X86_FEATURE_ZEN3		(11*32+29) /* "" CPU based on Zen3 microarchitecture */
 #define X86_FEATURE_ZEN4		(11*32+30) /* "" CPU based on Zen4 microarchitecture */
+#define X86_FEATURE_ZEN1		(11*32+31) /* "" CPU based on Zen1 microarchitecture */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 9a2e0ec8d0f9..68669158faa4 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -542,7 +542,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		switch (c->x86_model) {
 		case 0x00 ... 0x2f:
 		case 0x50 ... 0x5f:
-			setup_force_cpu_cap(X86_FEATURE_ZEN);
+			setup_force_cpu_cap(X86_FEATURE_ZEN1);
 			break;
 		case 0x30 ... 0x4f:
 		case 0x60 ... 0x7f:
@@ -948,6 +948,7 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 
 static void init_amd_zen_common(void)
 {
+	setup_force_cpu_cap(X86_FEATURE_ZEN);
 #ifdef CONFIG_NUMA
 	node_reclaim_distance = 32;
 #endif
@@ -1075,7 +1076,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x16: init_amd_jg(c); break;
 	}
 
-	if (boot_cpu_has(X86_FEATURE_ZEN))
+	if (boot_cpu_has(X86_FEATURE_ZEN1))
 		init_amd_zen(c);
 	else if (boot_cpu_has(X86_FEATURE_ZEN2))
 		init_amd_zen2(c);
@@ -1143,7 +1144,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	 * Counter May Be Inaccurate".
 	 */
 	if (cpu_has(c, X86_FEATURE_IRPERF) &&
-	    (boot_cpu_has(X86_FEATURE_ZEN) && c->x86_model > 0x2f))
+	    (boot_cpu_has(X86_FEATURE_ZEN1) && c->x86_model > 0x2f))
 		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 
 	check_null_seg_clears_base(c);
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 4af140cf5719..f4542d2718f4 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -218,7 +218,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			(7*32+28) /* "" CPU based on Zen microarchitecture */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" Generic flag for all Zen and newer */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
-- 
2.42.0.rc0.25.ga82fb66fed25


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
