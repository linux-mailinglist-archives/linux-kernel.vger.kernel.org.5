Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB3D7F10A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjKTKnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjKTKnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:43:08 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3650171B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:44 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CC9C140E01C0;
        Mon, 20 Nov 2023 10:42:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0ZD5UI-0_Or2; Mon, 20 Nov 2023 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476955; bh=zlnuWah+IyiMw2epMX+2lNNaMtlKVBskdmzvqDoHxY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bH0Xce1ArzTXJW1shOuFJBd/VnbluNCajFllQTaNX+GWIQc4RMqXvXtmZBvKWKjG5
         1QNd//zwd0rHMY6YRJftMN7mjVyFCchcJ2nBUl41kfMi3gCzFYmHT6qH0v20mDKDUx
         p23kWb2qqSHjURVakzL3PTo0XBFHacE2pi000xPmQYdWKVC0GdzuJW9wSdSgWw4Vea
         Xtyrr4nQfBxkcCw5f0xjOGBTTuvaauvxYySY9kxZ0MN29jZ1i4Tyak+UyTrhKDrV24
         x/YOjLu7TbxBuqeRtEaGq+twVXZrZt3Oi27hBXt58x3TTIWoPl0rBcjFSHlAUBUc82
         Zr0ll/77YOtM2SeW8uRrygyiBImK2CyK+Rczi2vEdWRmy3UyaElSUp0VCTsvT3vPBD
         eff4ZG/UyEM29wyFKRjU1Ky6Bf/XJlRfZ8WC+G21ayl77MJLnof50znZBxgXyeGAGP
         KP69HVqTCG7IvmoFt96Yy9oOeE5VCW/1L9zVuAvm6jVf2FsYZe+e11UIa/aUKMTOeS
         QFxEdoyfRgJ7n0GNOtiFiZLlcphCwZz8cIzT0/Wgzi2ZD6hDdI7MluAH1Xy0P8dVgI
         pANL0V7H59zs5er8VQPQEakid70KTZsO71WVeU6iINt32rdMrK4l8QfZd+E9zVF9FH
         aafZpkFXZWn/dQByN5jBu2uw=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C4DA40E0176;
        Mon, 20 Nov 2023 10:42:33 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/13] x86/CPU/AMD: Get rid of amd_erratum_1054[]
Date:   Mon, 20 Nov 2023 11:41:48 +0100
Message-ID: <20231120104152.13740-10-bp@alien8.de>
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

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 43d6a6da7591..62aa99b5d6c8 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -66,10 +66,6 @@ static const int amd_erratum_400[] =3D
 static const int amd_erratum_383[] =3D
 	AMD_OSVW_ERRATUM(3, AMD_MODEL_RANGE(0x10, 0, 0, 0xff, 0xf));
=20
-/* #1054: Instructions Retired Performance Counter May Be Inaccurate */
-static const int amd_erratum_1054[] =3D
-	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
-
 static const int amd_erratum_1485[] =3D
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
 			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
@@ -1201,7 +1197,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	 * Counter May Be Inaccurate".
 	 */
 	if (cpu_has(c, X86_FEATURE_IRPERF) &&
-	    !cpu_has_amd_erratum(c, amd_erratum_1054))
+	    (boot_cpu_has(X86_FEATURE_ZEN) && c->x86_model > 0x2f))
 		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
=20
 	check_null_seg_clears_base(c);
--=20
2.42.0.rc0.25.ga82fb66fed25

