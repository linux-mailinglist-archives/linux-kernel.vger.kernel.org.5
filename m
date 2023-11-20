Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453C37F109A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjKTKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjKTKm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:42:26 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234AA131
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:21 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 62CA740E01A4;
        Mon, 20 Nov 2023 10:42:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U9lP6dp0nkUo; Mon, 20 Nov 2023 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476936; bh=DySgw/1dED05SP7datXJO+HR26dVzWR7bSCTZBHiUw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8o27gEMwrOButFakYWW0vpmJEeZmFXaQfBAEjSK7yKDOOdT3hH7XhhNitq92XUL/
         IF6ZF2qhZcuy3cwk2C6v2FH0+vJlQ1lhao+Q8KDuMln+l06lIstfgcgffsIe6POAQC
         UNvZqHYkxV5vc5eTp2yAwtzZfG/5M1y7pROFyE731/j1FhfXlUTz6c51+/17RyfXSq
         AtY6/ggVpW9LAeZiVTn4jVL/qye9CgFbxGKu8ywnDAwt/CPSKy5oivxwlAMMddpSfq
         3/BFxouFi2+5abL7+l7dWqL0cMZra5Nipty0Xbkqdl2ZE7O/pV9Pj6GFUr9jojvF7v
         1oU5xMywnFZwNqHr/N3XShaMBsnDtnBPwHezFrbMSXRrhXg759q07MuTrQtVQ2uNSK
         jopNTZbuwh6fvtDdbUXHrpJo9GVrP8g6YId3sl+SFj2r3nuikdWha/Xu4iWgAlbv80
         oTw7XLvmC3Jsz8oT1jHXqfkIYwE+7d7s5363BM6thjP72GZQ5zkVNnio6B40xuy4TY
         IoN4ILZrTSgsVayU4MR38L9+X2Fbaye9o11puMq3GvXC/9RXaBLgTOn/pxLwO/Nm/D
         N2ASOAteLI13CYeEcVTpxGd/XUYh9URRbLrwHUR3/B43Ufeb3A7Noh9/zbkkFlWWse
         G5Vet65elDTDZcwVPZUIYpms=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF21140E0199;
        Mon, 20 Nov 2023 10:42:14 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/13] x86/CPU/AMD: Move erratum 1076 fix into the Zen1 init function
Date:   Mon, 20 Nov 2023 11:41:43 +0100
Message-ID: <20231120104152.13740-5-bp@alien8.de>
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
 arch/x86/kernel/cpu/amd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 92202bad9bd3..6d87c43e4ee9 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1024,6 +1024,11 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 #ifdef CONFIG_NUMA
 	node_reclaim_distance =3D 32;
 #endif
+}
+
+static void init_amd_zen(struct cpuinfo_x86 *c)
+{
+	fix_erratum_1386(c);
=20
 	/* Fix up CPUID bits, but only if not virtualised. */
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
@@ -1034,11 +1039,6 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 	}
 }
=20
-static void init_amd_zen(struct cpuinfo_x86 *c)
-{
-	fix_erratum_1386(c);
-}
-
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
 	fix_erratum_1386(c);
--=20
2.42.0.rc0.25.ga82fb66fed25

