Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E089D798AFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbjIHQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245242AbjIHQx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:53:27 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA2210C;
        Fri,  8 Sep 2023 09:52:57 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 388Fj6TW020297;
        Fri, 8 Sep 2023 18:52:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=QUriKgAIAV2H+EDbut4I3imj3RNChpoKLH5/B3MDzDQ=; b=Fh
        ULsVW+1ljOHKV0Bwjg4slbRk5U5dnaBCgGReKdYCkoRGBykyRKexPGSug2E72ZtR
        +aBQrkBYe4Nsl9Au+81oNohswaKCIX/A70LjxsYXKTpMFONNoOM2rUxZiUTBuVDQ
        N8RalLjjoMEm5xWxw1QLvlLNCxMuGxETiDNOAyAJaBR0A9q0NdueHLthKctUYQxM
        2vEqUU1uQjnVxWvkbhjpe6R86GYy6Y61H8BvrfAJ5qJ/HqluBdgv0M5yg7GF4sC3
        in84eGZ4AFn5eb3nupY3kXiTMZWVIA81N5zXxgrvLEZ0TiAb2ZA7PnzTM6fTcEH7
        0lYWbfdWayqyd+n90j1g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3suuxcndj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 18:52:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5AA9C10004B;
        Fri,  8 Sep 2023 18:52:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C58E209EF6;
        Fri,  8 Sep 2023 18:52:43 +0200 (CEST)
Received: from localhost (10.201.20.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 8 Sep
 2023 18:52:42 +0200
From:   Gatien Chevallier <gatien.chevallier@foss.st.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH 06/10] hwrng: stm32 - restrain RNG noise source clock
Date:   Fri, 8 Sep 2023 18:51:16 +0200
Message-ID: <20230908165120.730867-7-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908165120.730867-1-gatien.chevallier@foss.st.com>
References: <20230908165120.730867-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For NIST certification the noise source sampling may need to be
restrained.

This change implements an algorithm that gets the rate of the RNG
clock and apply the correct value in CLKDIV field in RNG_CR register
to force the RNG clock rate to be "max_clock_rate" maximum.

As it is platform-specific, implement it as a compat data.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/char/hw_random/stm32-rng.c | 34 ++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 3d32e0f4baef..3b77f1fe6aea 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -23,11 +23,13 @@
 #define RNG_CR_CONFIG1		GENMASK(11, 8)
 #define RNG_CR_NISTC		BIT(12)
 #define RNG_CR_CONFIG2		GENMASK(15, 13)
+#define RNG_CR_CLKDIV_SHIFT	16
+#define RNG_CR_CLKDIV		GENMASK(19, 16)
 #define RNG_CR_CONFIG3		GENMASK(25, 20)
 #define RNG_CR_CONDRST		BIT(30)
 #define RNG_CR_CONFLOCK		BIT(31)
 #define RNG_CR_ENTROPY_SRC_MASK	(RNG_CR_CONFIG1 | RNG_CR_NISTC | RNG_CR_CONFIG2 | RNG_CR_CONFIG3)
-#define RNG_CR_CONFIG_MASK	(RNG_CR_ENTROPY_SRC_MASK | RNG_CR_CED)
+#define RNG_CR_CONFIG_MASK	(RNG_CR_ENTROPY_SRC_MASK | RNG_CR_CED | RNG_CR_CLKDIV)
 
 #define RNG_SR			0x04
 #define RNG_SR_DRDY		BIT(0)
@@ -46,6 +48,7 @@
 #define RNG_NB_RECOVER_TRIES	3
 
 struct stm32_rng_data {
+	uint	max_clock_rate;
 	u32	cr;
 	u32	nscr;
 	u32	htcr;
@@ -238,6 +241,28 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 	return retval || !wait ? retval : -EIO;
 }
 
+static uint stm32_rng_clock_freq_restrain(struct hwrng *rng)
+{
+	struct stm32_rng_private *priv =
+	    container_of(rng, struct stm32_rng_private, rng);
+	unsigned long clock_rate = 0;
+	uint clock_div = 0;
+
+	clock_rate = clk_get_rate(priv->clk);
+
+	/*
+	 * Get the exponent to apply on the CLKDIV field in RNG_CR register
+	 * No need to handle the case when clock-div > 0xF as it is physically
+	 * impossible
+	 */
+	while ((clock_rate >> clock_div) > priv->data->max_clock_rate)
+		clock_div++;
+
+	pr_debug("RNG clk rate : %lu\n", clk_get_rate(priv->clk) >> clock_div);
+
+	return clock_div;
+}
+
 static int stm32_rng_init(struct hwrng *rng)
 {
 	struct stm32_rng_private *priv =
@@ -259,8 +284,11 @@ static int stm32_rng_init(struct hwrng *rng)
 	 * 0 is an invalid value as it disables all entropy sources.
 	 */
 	if (priv->data->has_cond_reset && priv->data->cr) {
+		uint clock_div = stm32_rng_clock_freq_restrain(rng);
+
 		reg &= ~RNG_CR_CONFIG_MASK;
-		reg |= RNG_CR_CONDRST | (priv->data->cr & RNG_CR_ENTROPY_SRC_MASK);
+		reg |= RNG_CR_CONDRST | (priv->data->cr & RNG_CR_ENTROPY_SRC_MASK) |
+		       (clock_div << RNG_CR_CLKDIV_SHIFT);
 		if (priv->ced)
 			reg &= ~RNG_CR_CED;
 		else
@@ -360,6 +388,7 @@ static const struct dev_pm_ops stm32_rng_pm_ops = {
 
 static const struct stm32_rng_data stm32mp13_rng_data = {
 	.has_cond_reset = true,
+	.max_clock_rate = 48000000,
 	.cr = 0x00F00D00,
 	.nscr = 0x2B5BB,
 	.htcr = 0x969D,
@@ -367,6 +396,7 @@ static const struct stm32_rng_data stm32mp13_rng_data = {
 
 static const struct stm32_rng_data stm32_rng_data = {
 	.has_cond_reset = false,
+	.max_clock_rate = 3000000,
 };
 
 static const struct of_device_id stm32_rng_match[] = {
-- 
2.25.1

