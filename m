Return-Path: <linux-kernel+bounces-17193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C782496F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE721F238F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565C2C694;
	Thu,  4 Jan 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Aa2hnTK5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB72C681
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0900640E01FE;
	Thu,  4 Jan 2024 20:11:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ud5A7blET9Hf; Thu,  4 Jan 2024 20:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704399109; bh=h5u4a89Q552KmReRiF5dxNQT7fCFg48Wsu9uyCE9Z+w=;
	h=From:To:Cc:Subject:Date:From;
	b=Aa2hnTK5Y3kgReJnFiz3GJekJ7cMpItj/sqGVzTk5OLsz0erd8Iv4axsulPtsRyrT
	 O3Yh8LwvZGAZKb+Ao4roa85+xolhVy7jKZF9FO4Y55aWWtQQ0oOtTfrpJf3/m3oiHs
	 5Y3Mt45HLKbjhHU38v2YyFf7979MX/poCQ7zepA/t/qBtuoZ9i/QUmbizKnGMgbGNj
	 b6p8trpROcLUcLabbLDvhUKOOIxTZAGvP02uLB1ACu+L75iVjKhsm0uJGKLgv5p3/p
	 WPlgnR0Nf3Y4+yK9TtPup1N3t75pvJebOtIXgOASvmlo3v0RDf5kd11jtePnujnhHO
	 6KjK8hdf7Ba8cGOvcv6RdZ1tW2w8UdpwXSzcULCu/QErTN/C3CXBpK5vofbcIp5Vxe
	 Ef/NOiMJ2DdlpFiUwNH4Z5nAIc0xl5CAd9SBtZR8b3Pm+d0rpiJXr5EOGpjI7/UDAO
	 cDx6gFtuJ6n4gHHLkfSmuvVYErtc838QhnEgAClIqhbE6axlJ1MbR8m/3dz7W7MPNx
	 Sk+hdFjTagL1TDBFsBzStKW9Ct1HkysxmdIqZsfKBHlX80QnbFZDaRyxWKcB7Vk4SB
	 cPKOhA99QlDVypTJAX0CzIcex53XVVjQBx68/i7Q5X4Flrj9XbhOI0z30weAhA5ksp
	 s+BE6wdBSPtPkD6M1lTCCXuA=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D9BC40E0196;
	Thu,  4 Jan 2024 20:11:46 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Michael Roth <michael.roth@amd.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/CPU/AMD: Add X86_FEATURE_ZEN5
Date: Thu,  4 Jan 2024 21:11:37 +0100
Message-ID: <20240104201138.5072-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add a synthetic feature flag for Zen5.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeatures.h |  4 +---
 arch/x86/kernel/cpu/amd.c          | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
index 29cb275a219d..fdf723b6f6d0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -81,10 +81,8 @@
 #define X86_FEATURE_K6_MTRR		( 3*32+ 1) /* AMD K6 nonstandard MTRRs */
 #define X86_FEATURE_CYRIX_ARR		( 3*32+ 2) /* Cyrix ARRs (=3D MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* Centaur MCRs (=3D MTRRs) =
*/
-
-/* CPU types for specific tunings: */
 #define X86_FEATURE_K8			( 3*32+ 4) /* "" Opteron, Athlon64 */
-/* FREE, was #define X86_FEATURE_K7			( 3*32+ 5) "" Athlon */
+#define X86_FEATURE_ZEN5		( 3*32+ 5) /* "" CPU based on Zen5 microarchit=
ecture */
 #define X86_FEATURE_P3			( 3*32+ 6) /* "" P3 */
 #define X86_FEATURE_P4			( 3*32+ 7) /* "" P4 */
 #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* TSC ticks at a constant r=
ate */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 9f42d1c59e09..bc49e3b3aae0 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -538,7 +538,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
=20
 	/* Figure out Zen generations: */
 	switch (c->x86) {
-	case 0x17: {
+	case 0x17:
 		switch (c->x86_model) {
 		case 0x00 ... 0x2f:
 		case 0x50 ... 0x5f:
@@ -554,8 +554,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			goto warn;
 		}
 		break;
-	}
-	case 0x19: {
+
+	case 0x19:
 		switch (c->x86_model) {
 		case 0x00 ... 0x0f:
 		case 0x20 ... 0x5f:
@@ -569,7 +569,17 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			goto warn;
 		}
 		break;
-	}
+
+	case 0x1a:
+		switch (c->x86_model) {
+		case 0x00 ... 0x0f:
+			setup_force_cpu_cap(X86_FEATURE_ZEN5);
+			break;
+		default:
+			goto warn;
+		}
+		break;
+
 	default:
 		break;
 	}
@@ -1039,6 +1049,11 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
=20
+static void init_amd_zen5(struct cpuinfo_x86 *c)
+{
+	init_amd_zen_common();
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	u64 vm_cr;
@@ -1084,6 +1099,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 		init_amd_zen3(c);
 	else if (boot_cpu_has(X86_FEATURE_ZEN4))
 		init_amd_zen4(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN5))
+		init_amd_zen5(c);
=20
 	/*
 	 * Enable workaround for FXSAVE leak on CPUs
--=20
2.42.0.rc0.25.ga82fb66fed25


