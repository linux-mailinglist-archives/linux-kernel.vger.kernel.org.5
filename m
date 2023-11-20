Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8000F7F1098
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjKTKm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjKTKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:42:20 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE209F1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:16 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5A74040E01A4;
        Mon, 20 Nov 2023 10:42:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mUTZmNe3o_yt; Mon, 20 Nov 2023 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476933; bh=zSsMqSBzaGE3GgC230bZyMSbMWkZEifLyp6tOh9UKYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcXwUuf3TIxj6wQEkO/VjCeM4dRufo8nMzORXihxsDqHvx3xwAX6jn9dPNM35LGUM
         KjPWSqvhxIkto8BGAeJ5ZAOBlt/sIPHg411HYH7k1+mC8jXc7KQmodVYl7e5+pth6X
         tRp+vIvfB4vMCWdlcmCFK25+ymVcb8WUUltWD6RBfd9fS2tRftVG1peeWJEjR/bma2
         YhT5WPVUuV8Ioia3QIFta+9HIvWZiXm6kxlg1uklmnBE4ZXhkedoO4XNiwTMVFPyXB
         xkrspt2TkUXxYtJS5liS2on+KsLHE316IBU7+TKXQjZH29VZ4swHkvCxbzowDubx2c
         U4NdoWuCKYN0O3ENXik7RFzx0wGC+6twroXrflyboJISN9YFz8rUWlAv3mIvsYWuN2
         f7Rnrpx5Uxaa+FyqbEclbM9GjiXcfRMkSFL56/6oWz5pG2n1EiAtaxo7/1rtlHVpcJ
         pc4yNMHI+Mb3OFzPlsuvBbPEtf4BIL3/gRLC+Y6OPiLQlfeG1w5ZIQYM1YnRd2C4HP
         1BHe+B1+LmYp/Ovo1Y5S0bVtMyOR8yPKwzy3t9GJ6DP96TYd2H3yoH0z9DLtEOFl2L
         AUoK/12epO/9ePpIKs5lLDLCuTsnFe/1baD//F3qSNGblayhh1BAI6HtYLSyvjkBT5
         5iv/cPDQfCF8PWH4y9YsSIIU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0800740E0031;
        Mon, 20 Nov 2023 10:42:10 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/13] x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3 init function
Date:   Mon, 20 Nov 2023 11:41:42 +0100
Message-ID: <20231120104152.13740-4-bp@alien8.de>
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
 arch/x86/kernel/cpu/amd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b3f939101368..92202bad9bd3 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1031,14 +1031,6 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 		/* Erratum 1076: CPB feature bit not being set in CPUID. */
 		if (!cpu_has(c, X86_FEATURE_CPB))
 			set_cpu_cap(c, X86_FEATURE_CPB);
-
-		/*
-		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
-		 * Branch Type Confusion, but predate the allocation of the
-		 * BTC_NO bit.
-		 */
-		if (c->x86 =3D=3D 0x19 && !cpu_has(c, X86_FEATURE_BTC_NO))
-			set_cpu_cap(c, X86_FEATURE_BTC_NO);
 	}
 }
=20
@@ -1054,6 +1046,15 @@ static void init_amd_zen2(struct cpuinfo_x86 *c)
=20
 static void init_amd_zen3(struct cpuinfo_x86 *c)
 {
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
+		/*
+		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
+		 * Branch Type Confusion, but predate the allocation of the
+		 * BTC_NO bit.
+		 */
+		if (!cpu_has(c, X86_FEATURE_BTC_NO))
+			set_cpu_cap(c, X86_FEATURE_BTC_NO);
+	}
 }
=20
 static void init_amd_zen4(struct cpuinfo_x86 *c)
--=20
2.42.0.rc0.25.ga82fb66fed25

