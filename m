Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D65C7F10AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjKTKo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjKTKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:44:09 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329FDF1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:43:16 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9FAD940E0031;
        Mon, 20 Nov 2023 10:43:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jFkyOQGuoUdA; Mon, 20 Nov 2023 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476966; bh=zSLgutEmyCmCS539z/eElXM8kHbppEABOqOJE2A9kTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfaLwZFiE/0gqirbhxB0qNTgeotT1cCYzCY45DBWt0bYLHBMbOABzNHDEEe1ePKKN
         ZmBk8aoVCLrZDCnb/4CVreCMX6+ncm0a0PftPrAQfydPKYF9xTtVRj1BtoWC6IelcN
         zGaFZQi+jRtzzYHGIYKU+7xFpWvH/JFORC1EIBzOELuIZ2XwdTwbgJjxfhMj249sRa
         gpENy/lJKBqQX7u6saBaoUc9mS9Hn0KMT87P8GE9nx6rzxECpP/1rtqqnM8kTb+q4S
         gfUGJlU3MgiUyHX6VRHlmQ4w91IlIJ0x9aJo/p3+2pbkyqcrMPu5Wgii6Fo3sE8fYA
         DwTxzm4WTka5ZQkXQ5Y3zVywTdFtjs8oQkiQK2deTrAFDDImCbN0OOVcbiQqRoq+zX
         U7Tg9siw9OTuOlkHqJCLn57uXCKuJjIC5Jq1tggMLLBRCt8X298ss9XT7xz5bkCnTn
         y9+LlUin3kS5VZ8D/5BpO2ryz9acVcSr7yQBveAxdKKwNsTkvx1jGDisMAjnxiWcEh
         g/HlMfzEzgfnw/2BfdzM+YNS+56VKogiajV+Ilhmt8cdYZAyZL/vlApJpbD6PVwe2C
         uUP7z9Yfpcrbe2TiL8yjxFkecvdPGVoxF+XFhauQbg7lPHfwumnunk5oExNrO2e++i
         uRIB/33Ryb1pmDLqLeedYKgQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDDB840E0176;
        Mon, 20 Nov 2023 10:42:43 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/13] x86/CPU/AMD: Get rid of amd_erratum_1485[]
Date:   Mon, 20 Nov 2023 11:41:51 +0100
Message-ID: <20231120104152.13740-13-bp@alien8.de>
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
 arch/x86/kernel/cpu/amd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f913ca245639..54e07c9b1292 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -59,10 +59,6 @@ static u32 nodes_per_socket =3D 1;
 #define AMD_MODEL_RANGE_START(range)	(((range) >> 12) & 0xfff)
 #define AMD_MODEL_RANGE_END(range)	((range) & 0xfff)
=20
-static const int amd_erratum_1485[] =3D
-	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
-			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
-
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erra=
tum)
 {
 	int osvw_id =3D *erratum++;
@@ -1093,6 +1089,9 @@ static void init_amd_zen3(struct cpuinfo_x86 *c)
 static void init_amd_zen4(struct cpuinfo_x86 *c)
 {
 	init_amd_zen_common();
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
=20
 static void init_amd(struct cpuinfo_x86 *c)
@@ -1215,10 +1214,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
 	    cpu_has(c, X86_FEATURE_AUTOIBRS))
 		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS));
-
-	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
-	     cpu_has_amd_erratum(c, amd_erratum_1485))
-		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
=20
 #ifdef CONFIG_X86_32
--=20
2.42.0.rc0.25.ga82fb66fed25

