Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ACC7F62F3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346069AbjKWP1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346147AbjKWP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:27:02 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1291B2;
        Thu, 23 Nov 2023 07:27:05 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9054A20004;
        Thu, 23 Nov 2023 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700753224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcHHna0h/IgIzh58pWB4uS96fnTDDQBk114hJ4c/spg=;
        b=E+jrrnH0co7LYu4/GnGewYeLa1EUyGx6KlvfCrPmUt1PjaTCw1sLJBlY44E5cHxqYMQTvQ
        cSpc5252sJDrCfephHLtcbwTVgUd1qJTdCYuQsIlGC/PKrc83eGjKKTYk/31Copsxv+LCK
        115+HtMK732jm6aiFTBDGa387GQ0Cu2bc00hT1XVHRzZJXYPnbXOFCeLFJqK8t0HPUxL4+
        WPv5Jv+SQBtWf+OZvjeN51sV38ZgjUAvg2STXQc55653nKYzbXUO3L4dq8IeV+/RRgccL/
        tphMGs94TvwtZ4ZU9dBIBCMLbe7MxNZJVJIDAIhzJFT32lopeQnw8blt5RuODw==
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
Subject: [PATCH v2 11/21] MIPS: traps: Enhance memblock ebase allocation process
Date:   Thu, 23 Nov 2023 16:26:28 +0100
Message-ID: <20231123152639.561231-12-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123152639.561231-1-gregory.clement@bootlin.com>
References: <20231123152639.561231-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

