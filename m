Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF080A885
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574350AbjLHQNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjLHQNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:13:04 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E119B6;
        Fri,  8 Dec 2023 08:13:04 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D24CB1C0004;
        Fri,  8 Dec 2023 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702051983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcHHna0h/IgIzh58pWB4uS96fnTDDQBk114hJ4c/spg=;
        b=ShlMJ/9E9iWREjauCv+qBvFMf4f8r53G9fhixcuTCpLqY3RgyZz2BVYlB7iG93Jh/LGoYT
        lhOBXozpMkdt56V0XVKs1tUQ7JGOxdRICcNVLuQvbdMDaZETMZJqrOZ9ZgWgp2PpAKA3v5
        qGsoqDIKJSvWtC+rTjGEVfTemCsM6MLX0bLkdZ7ZwoYAUnxxjbzRHI8EVDStbrzvEtrkWG
        PlwsRuBWriB/++SlD9jMQeQsoSq9GXuBG5GN5oChagh4H0SPxO61u1WTqKa4LAm+AQ4QtI
        BYKNSCkhszd6OVtjLRL4gO2Uh0rAwkB7sMQyxOOfPUKSCS43ZNcXWn1tTEKb9Q==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 11/22] MIPS: traps: Enhance memblock ebase allocation process
Date:   Fri,  8 Dec 2023 17:12:27 +0100
Message-ID: <20231208161249.1827174-12-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208161249.1827174-1-gregory.clement@bootlin.com>
References: <20231208161249.1827174-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

We try to allocate from KSEG0 accessible space first, and
then if we really can't allocate any memory from KSEG0 and
we are sure that we support ebase in higher segment, give
it another go without restriction.

This can maximize the possibility of having ebase in KSEG0.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/traps.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b6e94654f6211..68f1dd54cde1c 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2399,7 +2399,12 @@ void __init trap_init(void)
 		memblock_reserve(ebase_pa, vec_size);
 	} else {
 		vec_size = max(vec_size, PAGE_SIZE);
-		ebase_pa = memblock_phys_alloc(vec_size, 1 << fls(vec_size));
+		ebase_pa = memblock_phys_alloc_range(vec_size, 1 << fls(vec_size),
+						     0x0, KSEGX_SIZE - 1);
+
+		if (!ebase_pa && (IS_ENABLED(CONFIG_EVA) || cpu_has_ebase_wg))
+			ebase_pa = memblock_phys_alloc(vec_size, 1 << fls(vec_size));
+
 		if (!ebase_pa)
 			panic("%s: Failed to allocate %lu bytes align=0x%x\n",
 			      __func__, vec_size, 1 << fls(vec_size));
-- 
2.42.0

