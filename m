Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530CC7F10A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjKTKn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjKTKmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:42:55 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D574D7A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:38 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CDCA640E01BB;
        Mon, 20 Nov 2023 10:42:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rW2bzRskiw9H; Mon, 20 Nov 2023 10:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476943; bh=8VW8eysMQa0djm7KxcVc0hk/6wK18+5mMT7sLtuADpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6YbZer+M5FkO4bn0RIg9PcN+Yjh3s844hrgbxqz6puXqQdjBpqQhIkpVggr0Vnyt
         cKXlVYe6rBAKPez1gdRt31UwV5eWPy1zxo4MEN55IihCAYQLZodXRIusx291aXbdtH
         FeIMr8sCGgnQO44Mtl+9wDLdkm3QovhX4FviixpYsZlaLy0PtiG7IplyanfjJweHl1
         W0ut6GI/7X8KobjRJMvOHA6a0jmGED7mVF9XaJeaX2OzFTIfB06j+ESQYQTk1BsJWQ
         wVigJgfWcQxsNhwK09TiYpXWV/n74QlrOz1tQxpA+ub0oDH0o9tuWQdfwNV/ydvOQZ
         xtos10Jf+LHmgCL4CozhobDiRKCUgelrHUnwfSJ0WX4HV4b6TqusEchQWox4jyMmG6
         dSQIkTprKRRvbRPOmfL2L2V0qj15hE8tiNFPaj/kelDuiRv3237qNhkuiAR31i3gLn
         pCTWbAkWDY110pm0vip5xAxkfs/45fQmm9ckF6g7c5FNk4xf89U4qNTmU0Q9BNlEzs
         LoQFpKWEVSUuZoaHwl/oV+T3oH/Q/p4/lbI5HlXhWMAOyk7P3sNKBmdltLbqKCf7Z/
         F2YvxTiU122d99UotKkDkZGgXFPpHlpGZ9RtSsZ6Gb9Ccrho5L+uHal6qKzRYvIQCQ
         kX3zGIWv+6tDJXD8V3kRgksQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A97EC40E01AF;
        Mon, 20 Nov 2023 10:42:21 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/13] x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
Date:   Mon, 20 Nov 2023 11:41:45 +0100
Message-ID: <20231120104152.13740-7-bp@alien8.de>
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

Call it from all Zen init functions.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f43a70d495da..8d90f5f6b0d9 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1017,7 +1017,7 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 #endif
 }
=20
-static void init_amd_zn(struct cpuinfo_x86 *c)
+static void init_amd_zen_common(void)
 {
 #ifdef CONFIG_NUMA
 	node_reclaim_distance =3D 32;
@@ -1026,6 +1026,7 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
=20
 static void init_amd_zen(struct cpuinfo_x86 *c)
 {
+	init_amd_zen_common();
 	fix_erratum_1386(c);
=20
 	/* Fix up CPUID bits, but only if not virtualised. */
@@ -1035,16 +1036,20 @@ static void init_amd_zen(struct cpuinfo_x86 *c)
 		if (!cpu_has(c, X86_FEATURE_CPB))
 			set_cpu_cap(c, X86_FEATURE_CPB);
 	}
+
 }
=20
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
+	init_amd_zen_common();
 	init_spectral_chicken(c);
 	fix_erratum_1386(c);
 }
=20
 static void init_amd_zen3(struct cpuinfo_x86 *c)
 {
+	init_amd_zen_common();
+
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		/*
 		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
@@ -1058,6 +1063,7 @@ static void init_amd_zen3(struct cpuinfo_x86 *c)
=20
 static void init_amd_zen4(struct cpuinfo_x86 *c)
 {
+	init_amd_zen_common();
 }
=20
 static bool cpu_has_zenbleed_microcode(void)
@@ -1135,9 +1141,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
 	case 0x16: init_amd_jg(c); break;
-	case 0x17:
-		   fallthrough;
-	case 0x19: init_amd_zn(c); break;
 	}
=20
 	if (boot_cpu_has(X86_FEATURE_ZEN))
--=20
2.42.0.rc0.25.ga82fb66fed25

