Return-Path: <linux-kernel+bounces-98069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909868774B4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3302818EE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E19F5C9C;
	Sun, 10 Mar 2024 01:02:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931681115;
	Sun, 10 Mar 2024 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710032563; cv=none; b=DTwIu6HuXmuAOoY2OHxSqlEilvpsviU+mdAAeK97O80q0k4zRGwAU/2KINBWRLEfyyPMJhnz6VahOlrR3glluB3PxyzmU+MZ+2iNxxovY6Wd/gz1QSQwSh7pvQKYDGDUXm4Z0jo1Z2jAaD1cAvyrhyRL1ymTGKWpE76TCa8Xfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710032563; c=relaxed/simple;
	bh=gZPZUILAOoXZSipH5q0S3AF34KwVnOZjIZzn+zJnjBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EHzbDBDDkGNtHvYjfYcMH5cZfsDnj4rIr3HGJW3lBalI2r3GLHbtFbXT4ZPP1ofbCOJfliwOtaK8x1M4edVndSGN6nlaWnTt22WgQ/Ygd3EXfljmNnXIMttyxCU8qfJ5tMcLXWcYDENzz6dkfSqkupwoVvK3wEzBfa8he0pEDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10DF71515;
	Sat,  9 Mar 2024 17:03:16 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 249323F73F;
	Sat,  9 Mar 2024 17:02:38 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 4/4] regulator: axp20x: add support for the AXP717
Date: Sun, 10 Mar 2024 01:02:11 +0000
Message-Id: <20240310010211.28653-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240310010211.28653-1-andre.przywara@arm.com>
References: <20240310010211.28653-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X-Powers AXP717 is a typical PMIC from X-Powers, featuring four
DC/DC converters and 15 LDOs, on the regulator side.

Describe the chip's voltage settings and switch registers, how the
voltages are encoded, and connect this to the MFD device via its
regulator ID.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 84 ++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h           | 21 +++++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 7bcc2d508b65a..34fcdd82b2eaa 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -138,6 +138,12 @@
 #define AXP313A_DCDC_V_OUT_MASK		GENMASK(6, 0)
 #define AXP313A_LDO_V_OUT_MASK		GENMASK(4, 0)
 
+#define AXP717_DCDC1_NUM_VOLTAGES	88
+#define AXP717_DCDC2_NUM_VOLTAGES	107
+#define AXP717_DCDC3_NUM_VOLTAGES	104
+#define AXP717_DCDC_V_OUT_MASK		GENMASK(6, 0)
+#define AXP717_LDO_V_OUT_MASK		GENMASK(4, 0)
+
 #define AXP803_PWR_OUT_DCDC1_MASK	BIT_MASK(0)
 #define AXP803_PWR_OUT_DCDC2_MASK	BIT_MASK(1)
 #define AXP803_PWR_OUT_DCDC3_MASK	BIT_MASK(2)
@@ -752,6 +758,79 @@ static const struct regulator_desc axp313a_regulators[] = {
 	AXP_DESC_FIXED(AXP313A, RTC_LDO, "rtc-ldo", "vin1", 1800),
 };
 
+static const struct linear_range axp717_dcdc1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,   0, 70, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
+};
+
+static const struct linear_range axp717_dcdc2_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
+	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
+	REGULATOR_LINEAR_RANGE(1600000, 88, 107, 100000),
+};
+
+static const struct linear_range axp717_dcdc3_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,   0,  70, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 71, 102, 20000),
+};
+
+static const struct regulator_desc axp717_regulators[] = {
+	AXP_DESC_RANGES(AXP717, DCDC1, "dcdc1", "vin1",
+			axp717_dcdc1_ranges, AXP717_DCDC1_NUM_VOLTAGES,
+			AXP717_DCDC1_CONTROL, AXP717_DCDC_V_OUT_MASK,
+			AXP717_DCDC_OUTPUT_CONTROL, BIT(0)),
+	AXP_DESC_RANGES(AXP717, DCDC2, "dcdc2", "vin2",
+			axp717_dcdc2_ranges, AXP717_DCDC2_NUM_VOLTAGES,
+			AXP717_DCDC2_CONTROL, AXP717_DCDC_V_OUT_MASK,
+			AXP717_DCDC_OUTPUT_CONTROL, BIT(1)),
+	AXP_DESC_RANGES(AXP717, DCDC3, "dcdc3", "vin3",
+			axp717_dcdc3_ranges, AXP717_DCDC3_NUM_VOLTAGES,
+			AXP717_DCDC3_CONTROL, AXP717_DCDC_V_OUT_MASK,
+			AXP717_DCDC_OUTPUT_CONTROL, BIT(2)),
+	AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
+		 AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
+		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
+	AXP_DESC(AXP717, ALDO1, "aldo1", "vin1", 500, 3500, 100,
+		 AXP717_ALDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO0_OUTPUT_CONTROL, BIT(0)),
+	AXP_DESC(AXP717, ALDO2, "aldo2", "vin1", 500, 3500, 100,
+		 AXP717_ALDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO0_OUTPUT_CONTROL, BIT(1)),
+	AXP_DESC(AXP717, ALDO3, "aldo3", "vin1", 500, 3500, 100,
+		 AXP717_ALDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO0_OUTPUT_CONTROL, BIT(2)),
+	AXP_DESC(AXP717, ALDO4, "aldo4", "vin1", 500, 3500, 100,
+		 AXP717_ALDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO0_OUTPUT_CONTROL, BIT(3)),
+	AXP_DESC(AXP717, BLDO1, "bldo1", "vin1", 500, 3500, 100,
+		 AXP717_BLDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO0_OUTPUT_CONTROL, BIT(4)),
+	AXP_DESC(AXP717, BLDO2, "bldo2", "vin1", 500, 3500, 100,
+		 AXP717_BLDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO0_OUTPUT_CONTROL, BIT(5)),
+	AXP_DESC(AXP717, BLDO3, "bldo3", "vin1", 500, 3500, 100,
+		 AXP717_BLDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO0_OUTPUT_CONTROL, BIT(6)),
+	AXP_DESC(AXP717, BLDO4, "bldo4", "vin1", 500, 3500, 100,
+		 AXP717_BLDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO0_OUTPUT_CONTROL, BIT(7)),
+	AXP_DESC(AXP717, CLDO1, "cldo1", "vin1", 500, 3500, 100,
+		 AXP717_CLDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO1_OUTPUT_CONTROL, BIT(0)),
+	AXP_DESC(AXP717, CLDO2, "cldo2", "vin1", 500, 3500, 100,
+		 AXP717_CLDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO1_OUTPUT_CONTROL, BIT(1)),
+	AXP_DESC(AXP717, CLDO3, "cldo3", "vin1", 500, 3500, 100,
+		 AXP717_CLDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO1_OUTPUT_CONTROL, BIT(2)),
+	AXP_DESC(AXP717, CLDO4, "cldo4", "vin1", 500, 3500, 100,
+		 AXP717_CLDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO1_OUTPUT_CONTROL, BIT(3)),
+	AXP_DESC(AXP717, CPUSLDO, "cpusldo", "vin1", 500, 1400, 50,
+		 AXP717_CPUSLDO_CONTROL, AXP717_LDO_V_OUT_MASK,
+		 AXP717_LDO1_OUTPUT_CONTROL, BIT(4)),
+};
+
 /* DCDC ranges shared with AXP813 */
 static const struct linear_range axp803_dcdc234_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000,
@@ -1253,6 +1332,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		step = 150;
 		break;
 	case AXP313A_ID:
+	case AXP717_ID:
 	case AXP15060_ID:
 		/* The DCDC PWM frequency seems to be fixed to 3 MHz. */
 		if (dcdcfreq != 0) {
@@ -1479,6 +1559,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		regulators = axp313a_regulators;
 		nregulators = AXP313A_REG_ID_MAX;
 		break;
+	case AXP717_ID:
+		regulators = axp717_regulators;
+		nregulators = AXP717_REG_ID_MAX;
+		break;
 	case AXP803_ID:
 		regulators = axp803_regulators;
 		nregulators = AXP803_REG_ID_MAX;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index fd7a41a69526f..8c0a33a2e9ce2 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -466,6 +466,27 @@ enum {
 	AXP313A_REG_ID_MAX,
 };
 
+enum {
+	AXP717_DCDC1 = 0,
+	AXP717_DCDC2,
+	AXP717_DCDC3,
+	AXP717_DCDC4,
+	AXP717_ALDO1,
+	AXP717_ALDO2,
+	AXP717_ALDO3,
+	AXP717_ALDO4,
+	AXP717_BLDO1,
+	AXP717_BLDO2,
+	AXP717_BLDO3,
+	AXP717_BLDO4,
+	AXP717_CLDO1,
+	AXP717_CLDO2,
+	AXP717_CLDO3,
+	AXP717_CLDO4,
+	AXP717_CPUSLDO,
+	AXP717_REG_ID_MAX,
+};
+
 enum {
 	AXP806_DCDCA = 0,
 	AXP806_DCDCB,
-- 
2.35.8


