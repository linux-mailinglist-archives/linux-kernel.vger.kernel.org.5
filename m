Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87327756EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjHIKOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIKOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:14:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AFD10D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:14:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so106419971fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691576080; x=1692180880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP2WljCd9ESQp+EhFmr15Bf5cwuSzBUM7Oitp3XU6MA=;
        b=f+q8J3Cq9IRqWQU+ZUe9OpDMMzmRO5w3vDtM51hdsSHU8nMy6bq0YhdFjXTTxo3oia
         reOML288pir/h4rsvZkLJdd+UMDVKGDheTmELQTQ5CkyopUOWSyB0ja+U11jQHwBE3QR
         A4XNgXuSdx9flx6FpjHfeubSOpuK1dBXfKipzH9Rx0ytwXGh+tWz2kZbJYhLYOCid//b
         +5MMUI2xTpa3HjawGVzOxfTFludo8mUNgNV7Oepod4osuSyCjx57cTMZiL9tH/raretE
         8cmxbb29zmjMIxcdkbT43aakKUfN+78r6zvFkm7BXWsN0ksdloAuXxcWMY/riRORTVg6
         5NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691576080; x=1692180880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UP2WljCd9ESQp+EhFmr15Bf5cwuSzBUM7Oitp3XU6MA=;
        b=dIk205dSxQaU4uGjd39zdUuJAbPVMi0kBoPZMX/rIwfuhssXZYVzXasaQc+eVlkr2k
         JWqfM2WHP7RpYMPtrBGkngRiboMUNRPknXfmST0b8WbjJwkSntCJzt94DLQKT9TwcmIC
         fD7tAOEuOM3H5pQXSbwLIOw7TBMjCDGXP5xjrTj0RBlfiVa8CkU1HkUwOR6PlRwhoAW+
         Dm2qdhyZHN6AKmaPrWNuccbPpYiq1yJVL8FYd7L5+Fu9zmTTyKm4b1yD0Q7SSG9A/HZM
         W8g4swm8kk+fSTnVPL5p/NGHYtN8UITjim7NyC4iW+7jSJJcRcNFI7WzwbbQP6iXtgU6
         j+Rg==
X-Gm-Message-State: AOJu0YwsvYgNb5UD7oWp16cbPZiO4FlEDJ5H1z3wESDsP483X6Itkvhy
        5DvvAwjXouG0wk7yxmeTyFs=
X-Google-Smtp-Source: AGHT+IG9KC8gvErK23/4xxEf8HnIl5bRufC7qfg0WNZuqpCQK69p5oDEDR42xzJ6kofpFaHOS055zw==
X-Received: by 2002:a2e:9b4c:0:b0:2ba:34d0:fa5f with SMTP id o12-20020a2e9b4c000000b002ba34d0fa5fmr1448242ljj.37.1691576080464;
        Wed, 09 Aug 2023 03:14:40 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c479300b003fe24df4182sm2053718wmo.1.2023.08.09.03.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:14:40 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH 2/2] regulator: (tps65086): Select dedicated regulator config for chip variant
Date:   Wed,  9 Aug 2023 12:14:29 +0200
Message-ID: <20230809101429.7885-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809101429.7885-1-andre.werner@systec-electronic.com>
References: <20230809101429.7885-1-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

