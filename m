Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369617F1094
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjKTKmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjKTKmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:42:14 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44246CA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:10 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7382040E0199;
        Mon, 20 Nov 2023 10:42:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RkOOUOSPk8KA; Mon, 20 Nov 2023 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476925; bh=HxttFcqjU7pq71AIEFYdAjIvuj4XO+qvt4ZK4/zq++U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlDFrVYYBJfJEwXM4O5nSh0jip04X+D96XbQtfFOgJDd1beZfTwZc5+OLZyQoKPyX
         zGGf2olJrYxTT4eSaTC97VxMFE6YYFvgD0bg6msN+hV/AYBjGmOA90vJ1dBEBfaSnG
         gIvElgm8CT75xSMeF/9/X+w14DHAbwRhseZkKjYuj+rZNz5cbTLkyvevhOOeFXmx6f
         WB8v5c+By/pcyE6HwwZBhoHDeI+mnbvzlCGu/PKiPH+pSe/xyTXGkLb71TzA/nIc1S
         +9FXpaHXOzrrT1LtY8dqBBt9eUU0MmX2vItpsOSBTeP4ZokLqb01PMyIQLSzqAuvNe
         xQfsPQacrBlKvEdteSyRCJuU/D/LrglJUpI9N2HX7WrS4dHnELMVGQA/VTBhkDhpKN
         HeXCIItYhtHoM5A7LnARnZ533EvPHfBi3lldQJqNWsrYyJgDrlHnm3yAGk51nAh+Sl
         bB+UaKJHODEePzhYmNY+RPYRE827Pst7+w4RKen8O7hRrzIHavAWhMgRAaIrF5xdPy
         u+BUJaKBj7WleaRDDp1aXloKvvY/EEHovQXzNPzy8hgoCL6ijKde0936gqKr2BoiL6
         yrD74wcbg0rU7lLd9ygCJWKMX++jbYOSTLwMYp3A2dFefWhf3ZESuydWYJFB3wCuG1
         BuiRogp2cqZOIlEnWiIIxnGQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91C1A40E0031;
        Mon, 20 Nov 2023 10:42:03 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/13] x86/CPU/AMD: Add ZenX generations flags
Date:   Mon, 20 Nov 2023 11:41:40 +0100
Message-ID: <20231120104152.13740-2-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
In-Reply-To: <20231120104152.13740-1-bp@alien8.de>
References: <20231120104152.13740-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add X86_FEATURE flags for each Zen generation. They should be used from
now on instead of checking f/m/s.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeatures.h |  6 ++-
 arch/x86/kernel/cpu/amd.c          | 70 +++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
index 4af140cf5719..6f6cf49e9891 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -218,7 +218,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Specu=
lation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barri=
er */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch P=
redictors */
-#define X86_FEATURE_ZEN			(7*32+28) /* "" CPU based on Zen microarchitec=
ture */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU based on Zen microarchite=
cture */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE in=
version */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL=
 configured */
@@ -308,10 +308,12 @@
 #define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocat=
ion */
 #define X86_FEATURE_BMEC		(11*32+22) /* "" Bandwidth Monitoring Event Co=
nfiguration */
 #define X86_FEATURE_USER_SHSTK		(11*32+23) /* Shadow stack support for u=
ser mode applications */
-
 #define X86_FEATURE_SRSO		(11*32+24) /* "" AMD BTB untrain RETs */
 #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs th=
rough aliasing */
 #define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only o=
n VMEXIT */
+#define X86_FEATURE_ZEN2		(11*32+27) /* "" CPU based on Zen2 microarchit=
ecture */
+#define X86_FEATURE_ZEN3		(11*32+28) /* "" CPU based on Zen3 microarchit=
ecture */
+#define X86_FEATURE_ZEN4		(11*32+29) /* "" CPU based on Zen4 microarchit=
ecture */
=20
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 *=
/
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a7eab05e5f29..fa6ba63ca7e2 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -616,6 +616,49 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
=20
 	resctrl_cpu_detect(c);
+
+	/* Figure out Zen generations: */
+	switch (c->x86) {
+	case 0x17: {
+		switch (c->x86_model) {
+		case 0x00 ... 0x2f:
+		case 0x50 ... 0x5f:
+			setup_force_cpu_cap(X86_FEATURE_ZEN);
+			break;
+		case 0x30 ... 0x4f:
+		case 0x60 ... 0x7f:
+		case 0x90 ... 0x91:
+		case 0xa0 ... 0xaf:
+			setup_force_cpu_cap(X86_FEATURE_ZEN2);
+			break;
+		default:
+			goto warn;
+		}
+		break;
+	}
+	case 0x19: {
+		switch (c->x86_model) {
+		case 0x00 ... 0x0f:
+		case 0x20 ... 0x5f:
+			setup_force_cpu_cap(X86_FEATURE_ZEN3);
+			break;
+		case 0x10 ... 0x1f:
+		case 0x60 ... 0xaf:
+			setup_force_cpu_cap(X86_FEATURE_ZEN4);
+			break;
+		default:
+			goto warn;
+		}
+		break;
+	}
+	default:
+		break;
+	}
+
+	return;
+
+warn:
+	WARN_ONCE(1, "Family 0x%x, model: 0x%x??\n", c->x86, c->x86_model);
 }
=20
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
@@ -974,8 +1017,6 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
=20
 static void init_amd_zn(struct cpuinfo_x86 *c)
 {
-	set_cpu_cap(c, X86_FEATURE_ZEN);
-
 #ifdef CONFIG_NUMA
 	node_reclaim_distance =3D 32;
 #endif
@@ -997,6 +1038,22 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 	}
 }
=20
+static void init_amd_zen(struct cpuinfo_x86 *c)
+{
+}
+
+static void init_amd_zen2(struct cpuinfo_x86 *c)
+{
+}
+
+static void init_amd_zen3(struct cpuinfo_x86 *c)
+{
+}
+
+static void init_amd_zen4(struct cpuinfo_x86 *c)
+{
+}
+
 static bool cpu_has_zenbleed_microcode(void)
 {
 	u32 good_rev =3D 0;
@@ -1077,6 +1134,15 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x19: init_amd_zn(c); break;
 	}
=20
+	if (boot_cpu_has(X86_FEATURE_ZEN))
+		init_amd_zen(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN2))
+		init_amd_zen2(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN3))
+		init_amd_zen3(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN4))
+		init_amd_zen4(c);
+
 	/*
 	 * Enable workaround for FXSAVE leak on CPUs
 	 * without a XSaveErPtr feature
--=20
2.42.0.rc0.25.ga82fb66fed25

