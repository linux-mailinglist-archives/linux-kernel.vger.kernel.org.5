Return-Path: <linux-kernel+bounces-48477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03522845C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAACF1F2960D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC3626B6;
	Thu,  1 Feb 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fqO097aj"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91C626AC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803842; cv=none; b=MnghxxlhHbaRAMxcKqWOU5Y4pKhvQNY5JWjmCuHQfc0PFnW+v5Z4VYwLGDxt33YHYspF9utzwZmfMr7uYnRJpRSyIg7yuIlEjSOB3AwTFD7qrVd08nL/2jFXRynyMSNVu/zv1UMegDtazJ99eFKKH1s5cDd4jTAcOnKAUJUsn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803842; c=relaxed/simple;
	bh=VwIBUXKAEsKohjQKNiAhhvDm4Qf4t0hqmsmaz1tTZUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POcHIG+UEAzimFfoQJx5b5kBmd/S/Q21uuH0JipqYivNvMOauNRvtkSWTjSdeW9CMBeXReMuXu5xrxynGCX3wOvX7eyXUbepvKrbcQ1dKRJs4F5rFhOXWO0W66UNWeIl55m2cZsepJ7wt5wscLbgpcTiYsnAADJS/8tu2wl29yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fqO097aj reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 44B7340E016C;
	Thu,  1 Feb 2024 16:10:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FTpKQlxYPQCZ; Thu,  1 Feb 2024 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706803834; bh=Gl/hMPFVob6VaW5tFPoWgIe0G5ZAaqiNxRi62AslekY=;
	h=From:To:Cc:Subject:Date:From;
	b=fqO097ajlr3PWH0VcGIUsMsBcgZy5yRmivH+vxfXcPaY/5bYhtpezQNSPQfv+hPus
	 GFQxpBVPEZjPbT+7P9PfYBlzRDJRWO26DO3/CctuEKA7ySVacFPCn1TYGNzQBWgmet
	 z/o1QF380No5SiK0DVKzOtWQY5nLE01T4JlTs1fyzv+yBG5GJKN6urDpxSCNyiP2xA
	 FgUcZCWEIAT+UJYfWgrpiVQZ29SbMdwXtMtA6CWLa6jU/oOd3vdB2jmo3seyqpDIWt
	 Ae/w1BI9adOuHk/XpwTPAsvTrCsOjt5IOAiAcfJsryfD9swD7omkUE+q1y/LxcHl7u
	 XG3MEo3ZVjjXJQVvuruVqK5+2YFiiWXZhCUiCePRepMkOWwLUXjBqUS2XkLIrqr7jz
	 xPDGUGsUl5r/m/pr9KJY5gdWA0Xbd1+UgVnjR72se9daU7IaIn8nTZwarNuT0t/nOk
	 JQDfyP9hmXdw/W3Fm+JEM/goqU8Ylh98HcTRnwbBH728aH5eg4NZzqwxpzFp7cJIfu
	 P+aGgbIenws+xIESkhdAUdjlw29Dx2jNCVK7nBytMYlRwUawGth807ptRZcfRR8oDK
	 qvmIUTo1q1D18rwkYAVC5GiCI0Xlqj9duEcuHaQHH5mm5n7QSpqGocIIhsx/Oe+THK
	 m/JLcDM/oCEx7Woy6eOB+Epw=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C3F940E01A9;
	Thu,  1 Feb 2024 16:10:31 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/CPU/AMD: Do the common init on future Zens too
Date: Thu,  1 Feb 2024 17:10:24 +0100
Message-ID: <20240201161024.30839-1-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

There's no need to enable the common Zen init stuff for each new family
- just do it by default on everything >=3D 0x17 family.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 310fea1af124..adbad9bfded6 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -969,7 +969,6 @@ static void init_amd_zen_common(void)
=20
 static void init_amd_zen1(struct cpuinfo_x86 *c)
 {
-	init_amd_zen_common();
 	fix_erratum_1386(c);
=20
 	/* Fix up CPUID bits, but only if not virtualised. */
@@ -1023,7 +1022,6 @@ static void zen2_zenbleed_check(struct cpuinfo_x86 =
*c)
=20
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
-	init_amd_zen_common();
 	init_spectral_chicken(c);
 	fix_erratum_1386(c);
 	zen2_zenbleed_check(c);
@@ -1031,8 +1029,6 @@ static void init_amd_zen2(struct cpuinfo_x86 *c)
=20
 static void init_amd_zen3(struct cpuinfo_x86 *c)
 {
-	init_amd_zen_common();
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		/*
 		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
@@ -1046,15 +1042,12 @@ static void init_amd_zen3(struct cpuinfo_x86 *c)
=20
 static void init_amd_zen4(struct cpuinfo_x86 *c)
 {
-	init_amd_zen_common();
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
=20
 static void init_amd_zen5(struct cpuinfo_x86 *c)
 {
-	init_amd_zen_common();
 }
=20
 static void init_amd(struct cpuinfo_x86 *c)
@@ -1094,6 +1087,13 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x16: init_amd_jg(c); break;
 	}
=20
+	/*
+	 * Save up on some future enablement work and do common Zen
+	 * settings.
+	 */
+	if (c->x86 >=3D 0x17)
+		init_amd_zen_common();
+
 	if (boot_cpu_has(X86_FEATURE_ZEN1))
 		init_amd_zen1(c);
 	else if (boot_cpu_has(X86_FEATURE_ZEN2))
--=20
2.43.0


