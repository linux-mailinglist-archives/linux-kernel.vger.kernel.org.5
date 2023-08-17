Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD777F3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349796AbjHQJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349968AbjHQJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:49:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4083581
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:49:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-3196afc7d4bso4324195f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692265767; x=1692870567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP2WljCd9ESQp+EhFmr15Bf5cwuSzBUM7Oitp3XU6MA=;
        b=Ax+JIMOqMeXldctMJzBuW7ZoYy2cU96tRalqwN4JPtnqjXr+xm6mFeHWlSqbsaFAfq
         Sa0fsfKq5jJfZIww1VcTga2cAyo3zaCnK8shxOivmKR0THNtNbulDzY1Qdozs6d501M9
         QGA3YpGaf05xUwXWn7OCl/WfP8tBblKVEvPnyz1S2w/3999ZgWxF2E4dlw8kPSoPmjj3
         Z18SbFh3c9a42vMxvRk3urMWGThymak/H2o0ip80VfUx56ba0y1S+Q+dVGXOAa8qG4zB
         oRs216Dc3Cep32fK55mN19wlcR2sampvqCD2W8iobFyLCm3bh2zXBEk4fBr1PJ8Ft/aV
         JIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692265767; x=1692870567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UP2WljCd9ESQp+EhFmr15Bf5cwuSzBUM7Oitp3XU6MA=;
        b=elv6CnW6eA1vdjfLMfKs8RfwrBvjnQtXLmSYQC8AmoyHgcGx1qMxSvQMRUb4xVu2aw
         IaXHAeUNCinFwD4jsMKZlleIwyxkA5udhujOEHGf/N6U+E+/gkRbcC5DVZAb2rRvVBw2
         PgbWXpM7RXbNlJXoAIapwprInyEf0LrrcRh9LqFXW/7Fz5Nr6IGU6Z6OqwgPPPy148sf
         fmMJo5dmO1KeQMzLos6bwT5pRbr3BC+eFeFfeOHx804g2zRSvu3GH1zwcUfWt/WVE9qP
         Nrzy9MbuBsjuM1Rrs3T0C4oQmRBrdVp5rqZwofCR0f2cmWwSErH89GRlPgo8ov/V4MAL
         lE1w==
X-Gm-Message-State: AOJu0Yzms+mEQcyhfO3og05tXpD++cogiliPihdHIOVsmAyA/uBfMfhS
        aEtCCtJAgfyt5XL6CTy1hhw=
X-Google-Smtp-Source: AGHT+IFiFzYz4MuvJzDSNlh20i1nR5lfjD9hNfd3q9b29uLBeL+vKZl8z9WPPBrSXkXQMJ88ulGbKA==
X-Received: by 2002:adf:edc6:0:b0:317:cdc4:762e with SMTP id v6-20020adfedc6000000b00317cdc4762emr4458046wro.63.1692265766872;
        Thu, 17 Aug 2023 02:49:26 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00317ab75748bsm24112362wri.49.2023.08.17.02.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 02:49:26 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH 2/2 RESEND] regulator: (tps65086): Select dedicated regulator config for chip variant
Date:   Thu, 17 Aug 2023 11:49:05 +0200
Message-ID: <20230817094922.31818-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817094922.31818-1-andre.werner@systec-electronic.com>
References: <20230817094922.31818-1-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Werner <andre.werner@systec-electronic.com>

Some configurations differ between chip variants, e,g. the register
to control the on of state of LDOA1 and SWB2. Thus, it is necessary
to choose the correct configuration for a dedicated device.
If the wrong configuration was used, the LDOA1 output that was
disabled by the bootloader was enabled in  Kernel again.

Each chip variant gets its dedicated configuration selected by
the chip ID previously collected from MFD probe function.
The VTT enum value (tps65086_regulators) is shifted because not all
chip variants have a separate SWB2 switch. Sometimes they are merged.
So the configuration possibilities differ, thus the regulator
configuration arrays have a different length.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
 drivers/regulator/tps65086-regulator.c | 163 +++++++++++++++++++++++--
 include/linux/mfd/tps65086.h           |   3 +
 2 files changed, 158 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index 663789198ba5..c4ae7a67dc77 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -15,7 +15,7 @@
 #include <linux/mfd/tps65086.h>
 
 enum tps65086_regulators { BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, LDOA1,
-	LDOA2, LDOA3, SWA1, SWB1, SWB2, VTT };
+	LDOA2, LDOA3, VTT, SWA1, SWB1, SWB2 };
 
 #define TPS65086_REGULATOR(_name, _of, _id, _nv, _vr, _vm, _er, _em, _lr, _dr, _dm)	\
 	[_id] = {							\
@@ -57,12 +57,24 @@ enum tps65086_regulators { BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, LDOA1,
 		},							\
 	}
 
+
+#define TPS65086_REGULATOR_CONFIG(_chip_id, _config)			\
+	[_chip_id] = {							\
+		.config = _config,					\
+		.num_elems = ARRAY_SIZE(_config),			\
+	}
+
 struct tps65086_regulator {
 	struct regulator_desc desc;
 	unsigned int decay_reg;
 	unsigned int decay_mask;
 };
 
+struct tps65086_regulator_config {
+	struct tps65086_regulator * const config;
+	const unsigned int num_elems;
+};
+
 static const struct linear_range tps65086_10mv_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(410000, 0x1, 0x7F, 10000),
@@ -114,7 +126,125 @@ static int tps65086_of_parse_cb(struct device_node *dev,
 				const struct regulator_desc *desc,
 				struct regulator_config *config);
 
-static struct tps65086_regulator regulators[] = {
+static struct tps65086_regulator tps6508640_regulator_config[] = {
+	TPS65086_REGULATOR("BUCK1", "buck1", BUCK1, 0x80, TPS65086_BUCK1CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK1CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK2", "buck2", BUCK2, 0x80, TPS65086_BUCK2CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(1),
+			   tps65086_10mv_ranges, TPS65086_BUCK2CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK3", "buck3", BUCK3, 0x80, TPS65086_BUCK3VID,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(2),
+			   tps65086_10mv_ranges, TPS65086_BUCK3DECAY,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK4", "buck4", BUCK4, 0x80, TPS65086_BUCK4VID,
+			   BUCK_VID_MASK, TPS65086_BUCK4CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK4VID,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK5", "buck5", BUCK5, 0x80, TPS65086_BUCK5VID,
+			   BUCK_VID_MASK, TPS65086_BUCK5CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK5CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK6", "buck6", BUCK6, 0x80, TPS65086_BUCK6VID,
+			   BUCK_VID_MASK, TPS65086_BUCK6CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK6CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("LDOA1", "ldoa1", LDOA1, 0xF, TPS65086_LDOA1CTRL,
+			   VDOA1_VID_MASK, TPS65086_SWVTT_EN, BIT(7),
+			   tps65086_ldoa1_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA2", "ldoa2", LDOA2, 0x10, TPS65086_LDOA2VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA2CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA3", "ldoa3", LDOA3, 0x10, TPS65086_LDOA3VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA3CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_SWITCH("VTT", "vtt", VTT, TPS65086_SWVTT_EN, BIT(4)),
+	TPS65086_SWITCH("SWA1", "swa1", SWA1, TPS65086_SWVTT_EN, BIT(5)),
+	TPS65086_SWITCH("SWB1", "swb1", SWB1, TPS65086_SWVTT_EN, BIT(6)),
+	TPS65086_SWITCH("SWB2", "swb2", SWB2, TPS65086_LDOA1CTRL, BIT(0)),
+};
+
+static struct tps65086_regulator tps65086401_regulator_config[] = {
+	TPS65086_REGULATOR("BUCK1", "buck1", BUCK1, 0x80, TPS65086_BUCK1CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK1CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK2", "buck2", BUCK2, 0x80, TPS65086_BUCK2CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(1),
+			   tps65086_10mv_ranges, TPS65086_BUCK2CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK3", "buck3", BUCK3, 0x80, TPS65086_BUCK3VID,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(2),
+			   tps65086_10mv_ranges, TPS65086_BUCK3DECAY,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK4", "buck4", BUCK4, 0x80, TPS65086_BUCK4VID,
+			   BUCK_VID_MASK, TPS65086_BUCK4CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK4VID,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK5", "buck5", BUCK5, 0x80, TPS65086_BUCK5VID,
+			   BUCK_VID_MASK, TPS65086_BUCK5CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK5CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK6", "buck6", BUCK6, 0x80, TPS65086_BUCK6VID,
+			   BUCK_VID_MASK, TPS65086_BUCK6CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK6CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("LDOA1", "ldoa1", LDOA1, 0xF, TPS65086_LDOA1CTRL,
+			   VDOA1_VID_MASK, TPS65086_SWVTT_EN, BIT(7),
+			   tps65086_ldoa1_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA2", "ldoa2", LDOA2, 0x10, TPS65086_LDOA2VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA2CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA3", "ldoa3", LDOA3, 0x10, TPS65086_LDOA3VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA3CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_SWITCH("VTT", "vtt", VTT, TPS65086_SWVTT_EN, BIT(4)),
+	TPS65086_SWITCH("SWA1", "swa1", SWA1, TPS65086_SWVTT_EN, BIT(5)),
+	TPS65086_SWITCH("SWB1", "swb1", SWB1, TPS65086_SWVTT_EN, BIT(6)),
+};
+
+static struct tps65086_regulator tps6508641_regulator_config[] = {
+	TPS65086_REGULATOR("BUCK1", "buck1", BUCK1, 0x80, TPS65086_BUCK1CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK1CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK2", "buck2", BUCK2, 0x80, TPS65086_BUCK2CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(1),
+			   tps65086_10mv_ranges, TPS65086_BUCK2CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK3", "buck3", BUCK3, 0x80, TPS65086_BUCK3VID,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(2),
+			   tps65086_10mv_ranges, TPS65086_BUCK3DECAY,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK4", "buck4", BUCK4, 0x80, TPS65086_BUCK4VID,
+			   BUCK_VID_MASK, TPS65086_BUCK4CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK4VID,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK5", "buck5", BUCK5, 0x80, TPS65086_BUCK5VID,
+			   BUCK_VID_MASK, TPS65086_BUCK5CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK5CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK6", "buck6", BUCK6, 0x80, TPS65086_BUCK6VID,
+			   BUCK_VID_MASK, TPS65086_BUCK6CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK6CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("LDOA1", "ldoa1", LDOA1, 0xF, TPS65086_LDOA1CTRL,
+			   VDOA1_VID_MASK, TPS65086_SWVTT_EN, BIT(7),
+			   tps65086_ldoa1_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA2", "ldoa2", LDOA2, 0x10, TPS65086_LDOA2VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA2CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA3", "ldoa3", LDOA3, 0x10, TPS65086_LDOA3VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA3CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_SWITCH("VTT", "vtt", VTT, TPS65086_SWVTT_EN, BIT(4)),
+	TPS65086_SWITCH("SWA1", "swa1", SWA1, TPS65086_SWVTT_EN, BIT(5)),
+	TPS65086_SWITCH("SWB1", "swb1", SWB1, TPS65086_SWVTT_EN, BIT(6)),
+};
+
+static struct tps65086_regulator tps65086470_regulator_config[] = {
 	TPS65086_REGULATOR("BUCK1", "buck1", BUCK1, 0x80, TPS65086_BUCK1CTRL,
 			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(0),
 			   tps65086_10mv_ranges, TPS65086_BUCK1CTRL,
@@ -148,16 +278,25 @@ static struct tps65086_regulator regulators[] = {
 	TPS65086_REGULATOR("LDOA3", "ldoa3", LDOA3, 0x10, TPS65086_LDOA3VID,
 			   VDOA23_VID_MASK, TPS65086_LDOA3CTRL, BIT(0),
 			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_SWITCH("VTT", "vtt", VTT, TPS65086_SWVTT_EN, BIT(4)),
 	TPS65086_SWITCH("SWA1", "swa1", SWA1, TPS65086_SWVTT_EN, BIT(5)),
 	TPS65086_SWITCH("SWB1", "swb1", SWB1, TPS65086_SWVTT_EN, BIT(6)),
 	TPS65086_SWITCH("SWB2", "swb2", SWB2, TPS65086_SWVTT_EN, BIT(7)),
-	TPS65086_SWITCH("VTT", "vtt", VTT, TPS65086_SWVTT_EN, BIT(4)),
+};
+
+static const struct tps65086_regulator_config regulator_configs[] = {
+	TPS65086_REGULATOR_CONFIG(TPS6508640, tps6508640_regulator_config),
+	TPS65086_REGULATOR_CONFIG(TPS65086401, tps65086401_regulator_config),
+	TPS65086_REGULATOR_CONFIG(TPS6508641, tps6508641_regulator_config),
+	TPS65086_REGULATOR_CONFIG(TPS65086470, tps65086470_regulator_config)
 };
 
 static int tps65086_of_parse_cb(struct device_node *node,
 				const struct regulator_desc *desc,
 				struct regulator_config *config)
 {
+	struct tps65086 * const tps = dev_get_drvdata(config->dev);
+	struct tps65086_regulator *regulators = tps->reg_config->config;
 	int ret;
 
 	/* Check for 25mV step mode */
@@ -202,10 +341,14 @@ static int tps65086_of_parse_cb(struct device_node *node,
 static int tps65086_regulator_probe(struct platform_device *pdev)
 {
 	struct tps65086 *tps = dev_get_drvdata(pdev->dev.parent);
+	unsigned int chip_id = tps->chip_id;
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	int i;
 
+	/* Select regulator configuration for used PMIC device */
+	tps->reg_config = &regulator_configs[chip_id];
+
 	platform_set_drvdata(pdev, tps);
 
 	config.dev = &pdev->dev;
@@ -213,12 +356,16 @@ static int tps65086_regulator_probe(struct platform_device *pdev)
 	config.driver_data = tps;
 	config.regmap = tps->regmap;
 
-	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
-		rdev = devm_regulator_register(&pdev->dev, &regulators[i].desc,
-					       &config);
+	for (i = 0; i < tps->reg_config->num_elems; ++i) {
+		struct regulator_desc * const desc_ptr = &tps->reg_config->config[i].desc;
+
+		dev_dbg(tps->dev, "Index: %u; Regulator name: \"%s\"; Regulator ID: %d\n",
+			i, desc_ptr->name, desc_ptr->id);
+
+		rdev = devm_regulator_register(&pdev->dev, desc_ptr, &config);
 		if (IS_ERR(rdev)) {
-			dev_err(tps->dev, "failed to register %s regulator\n",
-				pdev->name);
+			dev_err(tps->dev, "failed to register %d \"%s\" regulator\n",
+				i, desc_ptr->name);
 			return PTR_ERR(rdev);
 		}
 	}
diff --git a/include/linux/mfd/tps65086.h b/include/linux/mfd/tps65086.h
index 88df344b38df..88ef5b556698 100644
--- a/include/linux/mfd/tps65086.h
+++ b/include/linux/mfd/tps65086.h
@@ -106,6 +106,8 @@ enum tps65086_irqs {
 	TPS65086_IRQ_FAULT,
 };
 
+struct tps65086_regulator_config;
+
 /**
  * struct tps65086 - state holder for the tps65086 driver
  *
@@ -115,6 +117,7 @@ struct tps65086 {
 	struct device *dev;
 	struct regmap *regmap;
 	unsigned int chip_id;
+	const struct tps65086_regulator_config *reg_config;
 
 	/* IRQ Data */
 	int irq;
-- 
2.41.0

