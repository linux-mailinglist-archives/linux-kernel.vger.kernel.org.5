Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151027DC0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjJ3TmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjJ3TmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:42:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25FE10A;
        Mon, 30 Oct 2023 12:41:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507962561adso7107470e87.0;
        Mon, 30 Oct 2023 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694916; x=1699299716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nV4Ai08tkpOWFMEbSJPptM95Z5+f/6Xg1fGxclm9cNA=;
        b=mDMD1tUatcmH3j4c80jPFQ3s2sCeTlmfISC2YbY2GexRO/6liIPwaKY0TD06xtW3+o
         CE0BarUN6zkoPm/QgJbrzdcKRyQb20htth0Q3cBdnjHcN7d84QVsJcx7d28ZtUXc4HhW
         ObBnebXDlTF0h1Ak6kT/9egDygdR1RXt3eO8PbBPoQl/0eUeRKNaNpA7rzDcC+L+qAYU
         FLl6GElzDvKxyHJduuLIgxixwcuhVELMqvGwFqv7vT2HW1XUil0d5RS45mGtoluYMtvm
         TCIdzkeXG/XJotvHMNKaGgAAyLmhbE2zL1aYF1x/vb0dPoxCn1/DKToFmtsMmZViM5z6
         +p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694916; x=1699299716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV4Ai08tkpOWFMEbSJPptM95Z5+f/6Xg1fGxclm9cNA=;
        b=ejQYkBXhQdCYTexYeaNCc62HTmb0kZoyE8xmw6IwK/H5jEo2pLZbLOYZT8Ft5UXOuk
         tA+6aFvAOc2tYNJwdnRfXXz4F8XTZJevDhWV/Kbq/rt5QUoWVBHS1Vj5gFNB/pAVt0hT
         uaI7LQUo0XZvk3xONzGCAudK9xYPFA5DmKdgFjVdMzwJao948Wk1ogW9GF8ul4CoflbQ
         MrZHWGphYPxQnq8bOu2QUnUhyp/oK1jmRZTZ0XP2Vb4Ufa5Hcyn/YaaRcbGP7Yk2yVol
         4UuUVD0gT9aJjeUG+2yEP1bH67g9eX+CBZw70KlItgEejRt/cBbSs+cHU4wvBHX42JVu
         IW/g==
X-Gm-Message-State: AOJu0YyYjg76ONKlAsFgA8xFXflkNZqBC4aYf4nxu5PxOwv0bOGloFAE
        przOX5xVCLS3bts6TLfLS20=
X-Google-Smtp-Source: AGHT+IGlIeZzyq3CXKnAFKiUZLlTEcTypiCnxmVZUhW20jITO9bthnPr+fPPYDRtfYBZCJdUShAiFA==
X-Received: by 2002:a19:ad44:0:b0:4fb:9f93:365f with SMTP id s4-20020a19ad44000000b004fb9f93365fmr7587568lfd.38.1698694915815;
        Mon, 30 Oct 2023 12:41:55 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b005057184ae62sm1527802lfh.96.2023.10.30.12.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:41:55 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Date:   Mon, 30 Oct 2023 20:41:48 +0100
Subject: [PATCH v2 6/6] regulator: bcm590xx: Add proper handling for PMMODE
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-bcm59054-v2-6-5fa4011aa5ba@gmail.com>
References: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
In-Reply-To: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694906; l=6532;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=MOr6P062Hw1cr9IL31CLgUIsSEz/SzMD3p5bHJ1QOHY=;
 b=kLCeoKqnWrubrHw320soyDTW4OEXc3S5QCIyFAvROBe8Aa6eK7SRWEca6BdODbEslTI1mCmHT
 0z/YbvmoUDSBuEf3a86eSCoh/CRt+rotHIRF/NlMuvrk5sv7l8RL8qk
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state of BCM590XX regulators is controlled by writing to the
PMCTRL registers; there are 7 selectable mode entries in those
registers, each storing a specific mode value - OFF, LPM or ON.
Which entry is selected depends on the combination of enabled
PC pins (PC1, PC2 and the optional PC3).

Add a new function to write a specific mode value to all entries,
and make a custom enable/disable function to make use of it.
Keep the is_enabled function using the naive regmap method
(a potential improvement here would be to add support for getting
the state of the PC pins to figure out the selected mode).

It should also be possible to extend this to support regulator
modes, though some work may be needed to make sure it doesn't
interfere with the enabled/disabled state.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/regulator/bcm590xx-regulator.c | 96 +++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index 8b90eae06ca6..1905dc2a4111 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -38,6 +38,15 @@ struct bcm590xx_reg {
 #define BCM590XX_LDO_VSEL_MASK		GENMASK(5, 3)
 #define BCM590XX_SR_VSEL_MASK		GENMASK(5, 0)
 
+#define BCM590XX_PMMODE_ON		0x0
+#define BCM590XX_PMMODE_LPM		0x1
+#define BCM590XX_PMMODE_OFF		0x2
+
+#define PMMODE_3BIT_MASK(mode)						\
+	((mode << 3) | mode)
+#define PMMODE_2BIT_MASK(mode)						\
+	((mode << 6) | (mode << 4) | (mode << 2) | mode)
+
 /* BCM59056 registers */
 
 /* I2C slave 0 registers */
@@ -444,7 +453,7 @@ static int bcm590xx_get_vsel_register(struct bcm590xx_reg *pmu, int id)
 	return -EINVAL;
 }
 
-static int bcm59054_get_enable_register(struct bcm590xx_reg *pmu, int id)
+static int bcm59054_get_pmctrl_register(struct bcm590xx_reg *pmu, int id)
 {
 	int reg = 0;
 
@@ -483,7 +492,7 @@ static int bcm59054_get_enable_register(struct bcm590xx_reg *pmu, int id)
 	return reg;
 }
 
-static int bcm59056_get_enable_register(struct bcm590xx_reg *pmu, int id)
+static int bcm59056_get_pmctrl_register(struct bcm590xx_reg *pmu, int id)
 {
 	int reg = 0;
 
@@ -522,13 +531,13 @@ static int bcm59056_get_enable_register(struct bcm590xx_reg *pmu, int id)
 	return reg;
 }
 
-static int bcm590xx_get_enable_register(struct bcm590xx_reg *pmu, int id)
+static int bcm590xx_get_pmctrl_register(struct bcm590xx_reg *pmu, int id)
 {
 	switch (pmu->mfd->device_type) {
 	case BCM59054_TYPE:
-		return bcm59054_get_enable_register(pmu, id);
+		return bcm59054_get_pmctrl_register(pmu, id);
 	case BCM59056_TYPE:
-		return bcm59056_get_enable_register(pmu, id);
+		return bcm59056_get_pmctrl_register(pmu, id);
 	}
 	return -EINVAL;
 }
@@ -541,10 +550,73 @@ static int bcm590xx_get_enable_mask(struct bcm590xx_reg *pmu, int id)
 	return BCM590XX_REG_ENABLE;
 }
 
+/*
+ * The state of BCM590XX regulators is controlled by the PM mode; most
+ * regulators have 3 such modes (off, low-power and on).
+ *
+ * These modes are then stored in the PMCTRL registers - there are 7
+ * PMMODE entries within these registers for any given regulator.
+ * Which one is selected is decided by the PC1 and PC2 pins (and the
+ * optional PC3 pin, if configured).
+ *
+ * For simplicity, to set a PM mode, we write it to all available
+ * PMMODE registers.
+ */
+static int
+_bcm590xx_set_pmmode(struct bcm590xx_reg *pmu, int reg_id, unsigned int mode)
+{
+	struct regmap *regmap;
+	u8 pmctrl_addr = bcm590xx_get_pmctrl_register(pmu, reg_id);
+	unsigned int i;
+	int pmctrl_count;
+	int mode_mask;
+	int ret;
+
+	/*
+	 * Regulators using 2-bit mode controls have 2 PMCTRL registers;
+	 * regulators using 3-bit mode controls have 4 PMCTRL registers.
+	 * This is to accommodate all 7 selectable modes.
+	 */
+	if (bcm590xx_reg_mode_is_3bit(pmu, reg_id)) {
+		pmctrl_count = 4;
+		mode_mask = PMMODE_3BIT_MASK(mode);
+	} else {
+		pmctrl_count = 2;
+		mode_mask = PMMODE_2BIT_MASK(mode);
+	}
+
+	if (bcm590xx_reg_is_secondary(pmu, reg_id))
+		regmap = pmu->mfd->regmap_sec;
+	else
+		regmap = pmu->mfd->regmap_pri;
+
+	for (i = 0; i < pmctrl_count; i++) {
+		ret = regmap_write(regmap, pmctrl_addr + i, mode_mask);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int bcm590xx_regulator_enable(struct regulator_dev *rdev)
+{
+	struct bcm590xx_reg *pmu = rdev->reg_data;
+
+	return _bcm590xx_set_pmmode(pmu, rdev->desc->id, BCM590XX_PMMODE_ON);
+}
+
+static int bcm590xx_regulator_disable(struct regulator_dev *rdev)
+{
+	struct bcm590xx_reg *pmu = rdev->reg_data;
+
+	return _bcm590xx_set_pmmode(pmu, rdev->desc->id, BCM590XX_PMMODE_OFF);
+}
+
 static const struct regulator_ops bcm590xx_ops_ldo = {
 	.is_enabled		= regulator_is_enabled_regmap,
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
+	.enable			= bcm590xx_regulator_enable,
+	.disable		= bcm590xx_regulator_disable,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_table,
@@ -553,8 +625,8 @@ static const struct regulator_ops bcm590xx_ops_ldo = {
 
 static const struct regulator_ops bcm590xx_ops_dcdc = {
 	.is_enabled		= regulator_is_enabled_regmap,
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
+	.enable			= bcm590xx_regulator_enable,
+	.disable		= bcm590xx_regulator_disable,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear_range,
@@ -563,8 +635,8 @@ static const struct regulator_ops bcm590xx_ops_dcdc = {
 
 static const struct regulator_ops bcm590xx_ops_static = {
 	.is_enabled		= regulator_is_enabled_regmap,
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
+	.enable			= bcm590xx_regulator_enable,
+	.disable		= bcm590xx_regulator_disable,
 };
 
 static int bcm590xx_probe(struct platform_device *pdev)
@@ -633,7 +705,7 @@ static int bcm590xx_probe(struct platform_device *pdev)
 			pmu->desc[i].enable_is_inverted = true;
 		}
 		pmu->desc[i].enable_reg = \
-			bcm590xx_get_enable_register(pmu, i);
+			bcm590xx_get_pmctrl_register(pmu, i);
 		pmu->desc[i].type = REGULATOR_VOLTAGE;
 		pmu->desc[i].owner = THIS_MODULE;
 

-- 
2.42.0

