Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FC77F109B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjKTKmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjKTKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:42:28 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FD3C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:24 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ACD9340E01A4;
        Mon, 20 Nov 2023 10:42:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KxakAPnY9eKD; Mon, 20 Nov 2023 10:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476940; bh=Ak+9T+Upn9tPqHpt7fwMUcIjPgnr6VqaxzGs8MwZUrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyMvxKwqFiKuRmklu5eZT5TFr2VTiFJdgHnlCBvFowIn9DDapnd57dV3yYhcDlzVI
         5kqa90ZBRtBKcgXM2kt6+XJIp8ydcz25ERNVXmHxpITq4qc3xMY8qeDGITwmmuXVcR
         G0gAqkyoIlBrlqqt5C+83vJbR/mTG/h/7gD1KldYUEdgFmuhhhB0GiUWNm+jhBykl9
         4RAisLkfEWjhgfyhdvtR2Lmr+0NS3vSKjbbjml9tjbVN41A4BYXykT4fWknfWwQOrO
         92+33eTGAU4Pqg7UN0FeVTIPmyRmUcdHIUvJRyPPxX+VNHlnDzkQ3SBqkhm7U1MuBV
         GeCsN4bE3B6HP3hvDuE4fZRrRKCjfTYKbtI4v6VOqQUtgyNyowxKFReGIXGSMjhCpy
         NhyS/IoxJjMUmVT5yrCxNiDDo42WfjMfMybnoEghEmFtXTnzrG+ChViL1LP8ZgUM+p
         CMATVR0jugzSAFRsdbFXbs4t8B86n/jCQfNSobuAqs36dbGRIP5U9pgAdF5yJSCthj
         t191OMF6Nes6KwbulI1xRY2CLr0s4mSjpUD4WDXNmsKjYj0ws+W/cmHBBqpuJ4Xrdv
         b3QqPOQuj8+1aohYyID0RoobnL4gWBJaZh2GSOW5WUdZ2pBWMyoGXrTAOaGRPOMea3
         Ep7APjk59w/aYT57VcRArH9Y=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 600AD40E0031;
        Mon, 20 Nov 2023 10:42:18 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/13] x86/CPU/AMD: Call the spectral chicken in the Zen2 init function
Date:   Mon, 20 Nov 2023 11:41:44 +0100
Message-ID: <20231120104152.13740-6-bp@alien8.de>
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

No functional change.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 6d87c43e4ee9..f43a70d495da 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1007,10 +1007,8 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 	 *
 	 * This suppresses speculation from the middle of a basic block, i.e. i=
t
 	 * suppresses non-branch predictions.
-	 *
-	 * We use STIBP as a heuristic to filter out Zen2 from the rest of F17H
 	 */
-	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && cpu_has(c, X86_FEATURE_AMD_S=
TIBP)) {
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		if (!rdmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, &value)) {
 			value |=3D MSR_ZEN2_SPECTRAL_CHICKEN_BIT;
 			wrmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, value);
@@ -1041,6 +1039,7 @@ static void init_amd_zen(struct cpuinfo_x86 *c)
=20
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
+	init_spectral_chicken(c);
 	fix_erratum_1386(c);
 }
=20
@@ -1136,7 +1135,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
 	case 0x16: init_amd_jg(c); break;
-	case 0x17: init_spectral_chicken(c);
+	case 0x17:
 		   fallthrough;
 	case 0x19: init_amd_zn(c); break;
 	}
--=20
2.42.0.rc0.25.ga82fb66fed25

