Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511357F10A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjKTKnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjKTKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:42:56 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02910EA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:39 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 163E940E01AF;
        Mon, 20 Nov 2023 10:42:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3De19TxaWLSh; Mon, 20 Nov 2023 10:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476948; bh=b7mZX+/YHV/jz5ttaRN2Dh9DCKP1lBz9NGfieIiWDcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0M0t6ZXTaD1Z17gE0E9Z/wgh1AZGmcRa6arAhcaetXyA26rFCpa1jr1H8JWHS5j2
         rAuRIEAYz00UIPtXO2Nc/NaZQVTHdkVoGv3E5l2U11YQ72bcptWTITUdy8xKULf/cN
         pbANYD5/anAFleP6otPVC0nCzQsnrWgjFQ1meiQCGlgYdz+uq6jjAX+2PXklw1YmIQ
         K9AGMYDJ9rKFJwK5OZDKYKcxL4s0dIpCyKAkUwBJ5oo4Y+CquKJnVHLp/Tvk04bx8N
         QBxHSq3uKMRELVbtdt/37AKRPqYrMoU3M/kCq7nKbGBr1YSUoHd9kSyA6UAg3/p8Vw
         JoMchPeRfHXBTywk3Fzv/JBwHaaZa1ih15gUg6WBak4MnTLErDgw6+UVWPfDa1wexv
         CA7/qgEUrbG3z/xkFRnwPug2OD2sh81lGOS5yLBAAMAQI3JnNWy/C38bw68xFLKzSA
         ABcGCJNMAe1S3+tTfyvA3e0nVRwJoSH/lPaAJ0vh5/soszlXBUKNd3nRoL85Bqs+Cd
         mL4dul9dbmL4KhGDi6dWhQ7hrO0A0H18R/hF/EEsBgK+7nhDB1cW0LAy3E33WW7vJM
         xtD4yJb2KvriFYBSGc9ICvEgatJys38QdewSgwq1boW1jhD4PW5gpAMcR/ltezGrLc
         KcHj04Nlk/VIPAPNQiAQjzvs=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C9B940E01B7;
        Mon, 20 Nov 2023 10:42:26 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/13] x86/CPU/AMD: Move Zenbleed check to the Zen2 init function
Date:   Mon, 20 Nov 2023 11:41:46 +0100
Message-ID: <20231120104152.13740-8-bp@alien8.de>
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

Prefix it properly so that it is clear which generation it is dealing
with.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 70 +++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8d90f5f6b0d9..7cbb108afaf4 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -70,12 +70,6 @@ static const int amd_erratum_383[] =3D
 static const int amd_erratum_1054[] =3D
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
=20
-static const int amd_zenbleed[] =3D
-	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x30, 0x0, 0x4f, 0xf),
-			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
-			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x91, 0xf),
-			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
-
 static const int amd_div0[] =3D
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
@@ -1039,33 +1033,6 @@ static void init_amd_zen(struct cpuinfo_x86 *c)
=20
 }
=20
-static void init_amd_zen2(struct cpuinfo_x86 *c)
-{
-	init_amd_zen_common();
-	init_spectral_chicken(c);
-	fix_erratum_1386(c);
-}
-
-static void init_amd_zen3(struct cpuinfo_x86 *c)
-{
-	init_amd_zen_common();
-
-	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
-		/*
-		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
-		 * Branch Type Confusion, but predate the allocation of the
-		 * BTC_NO bit.
-		 */
-		if (!cpu_has(c, X86_FEATURE_BTC_NO))
-			set_cpu_cap(c, X86_FEATURE_BTC_NO);
-	}
-}
-
-static void init_amd_zen4(struct cpuinfo_x86 *c)
-{
-	init_amd_zen_common();
-}
-
 static bool cpu_has_zenbleed_microcode(void)
 {
 	u32 good_rev =3D 0;
@@ -1087,11 +1054,8 @@ static bool cpu_has_zenbleed_microcode(void)
 	return true;
 }
=20
-static void zenbleed_check(struct cpuinfo_x86 *c)
+static void zen2_zenbleed_check(struct cpuinfo_x86 *c)
 {
-	if (!cpu_has_amd_erratum(c, amd_zenbleed))
-		return;
-
 	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
 		return;
=20
@@ -1106,6 +1070,34 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
 	}
 }
=20
+static void init_amd_zen2(struct cpuinfo_x86 *c)
+{
+	init_amd_zen_common();
+	init_spectral_chicken(c);
+	fix_erratum_1386(c);
+	zen2_zenbleed_check(c);
+}
+
+static void init_amd_zen3(struct cpuinfo_x86 *c)
+{
+	init_amd_zen_common();
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
+		/*
+		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
+		 * Branch Type Confusion, but predate the allocation of the
+		 * BTC_NO bit.
+		 */
+		if (!cpu_has(c, X86_FEATURE_BTC_NO))
+			set_cpu_cap(c, X86_FEATURE_BTC_NO);
+	}
+}
+
+static void init_amd_zen4(struct cpuinfo_x86 *c)
+{
+	init_amd_zen_common();
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	u64 vm_cr;
@@ -1227,8 +1219,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	    cpu_has(c, X86_FEATURE_AUTOIBRS))
 		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS));
=20
-	zenbleed_check(c);
-
 	if (cpu_has_amd_erratum(c, amd_div0)) {
 		pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full prote=
ction.\n");
 		setup_force_cpu_bug(X86_BUG_DIV0);
@@ -1390,7 +1380,7 @@ static void zenbleed_check_cpu(void *unused)
 {
 	struct cpuinfo_x86 *c =3D &cpu_data(smp_processor_id());
=20
-	zenbleed_check(c);
+	zen2_zenbleed_check(c);
 }
=20
 void amd_check_microcode(void)
--=20
2.42.0.rc0.25.ga82fb66fed25

