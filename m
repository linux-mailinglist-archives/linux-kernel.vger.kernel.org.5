Return-Path: <linux-kernel+bounces-125534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062CA8927E8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895021F22295
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597813E6DB;
	Fri, 29 Mar 2024 23:50:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8E53379;
	Fri, 29 Mar 2024 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756252; cv=none; b=J9C4lUcTvA/mGTSRd36GsmB578axEMHBYe+JHqQpwm0c2E5rjzr64BZh8faHJrYoFvvxpYNWmCjG0OKHGLL9w66Gd4ssx8hy5myvtMwd8sKwj6b2iR5XBuzgRiMnGXJ+kzdkHT3dHX+XeoDB9DEwkhiByMS7rLfdBRv+eQ3rkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756252; c=relaxed/simple;
	bh=rBBaazLF117U4jfUSRPzXDXhpPFn1/m5OS2c0G/lMwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=brikATmjiGgxzFuY+5NRijaLpVrmeRNqcEcUtkcuOpIVn/1aeV5bMwDcG4oU3IaOc5fa+BslgAW+peuk3FlSVyPHoj23p2moWi2Se+OL7eoSu+eh4js44eNPx1J0qFam4yxLAPFa+rH53EShlOzYqMy4VGJN6REL2PksPZjEhVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2093012FC;
	Fri, 29 Mar 2024 16:51:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 181123F64C;
	Fri, 29 Mar 2024 16:50:47 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: [PATCH 1/4] regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones
Date: Fri, 29 Mar 2024 23:50:30 +0000
Message-Id: <20240329235033.25309-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240329235033.25309-1-andre.przywara@arm.com>
References: <20240329235033.25309-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X-Powers AXP717 PMIC has separate input supply pins for each group
of LDOs, so they are not all using the same DCDC1 input, as described
currently.

Replace the "supply" member of each LDO description with the respective
group supply name, so that the supply dependencies can be correctly
described in the devicetree.
Also fix two off-by-ones in the regulator macros, after some double
checking the numbers against the datasheet.

Fixes: d2ac3df75c3a ("regulator: axp20x: add support for the AXP717")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 34fcdd82b2eaa..3907606b091f6 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -140,7 +140,7 @@
 
 #define AXP717_DCDC1_NUM_VOLTAGES	88
 #define AXP717_DCDC2_NUM_VOLTAGES	107
-#define AXP717_DCDC3_NUM_VOLTAGES	104
+#define AXP717_DCDC3_NUM_VOLTAGES	103
 #define AXP717_DCDC_V_OUT_MASK		GENMASK(6, 0)
 #define AXP717_LDO_V_OUT_MASK		GENMASK(4, 0)
 
@@ -766,7 +766,7 @@ static const struct linear_range axp717_dcdc1_ranges[] = {
 static const struct linear_range axp717_dcdc2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
 	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
-	REGULATOR_LINEAR_RANGE(1600000, 88, 107, 100000),
+	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
 };
 
 static const struct linear_range axp717_dcdc3_ranges[] = {
@@ -790,40 +790,40 @@ static const struct regulator_desc axp717_regulators[] = {
 	AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
 		 AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
 		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
-	AXP_DESC(AXP717, ALDO1, "aldo1", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, ALDO1, "aldo1", "aldoin", 500, 3500, 100,
 		 AXP717_ALDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO0_OUTPUT_CONTROL, BIT(0)),
-	AXP_DESC(AXP717, ALDO2, "aldo2", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, ALDO2, "aldo2", "aldoin", 500, 3500, 100,
 		 AXP717_ALDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO0_OUTPUT_CONTROL, BIT(1)),
-	AXP_DESC(AXP717, ALDO3, "aldo3", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, ALDO3, "aldo3", "aldoin", 500, 3500, 100,
 		 AXP717_ALDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO0_OUTPUT_CONTROL, BIT(2)),
-	AXP_DESC(AXP717, ALDO4, "aldo4", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, ALDO4, "aldo4", "aldoin", 500, 3500, 100,
 		 AXP717_ALDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO0_OUTPUT_CONTROL, BIT(3)),
-	AXP_DESC(AXP717, BLDO1, "bldo1", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, BLDO1, "bldo1", "bldoin", 500, 3500, 100,
 		 AXP717_BLDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO0_OUTPUT_CONTROL, BIT(4)),
-	AXP_DESC(AXP717, BLDO2, "bldo2", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, BLDO2, "bldo2", "bldoin", 500, 3500, 100,
 		 AXP717_BLDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO0_OUTPUT_CONTROL, BIT(5)),
-	AXP_DESC(AXP717, BLDO3, "bldo3", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, BLDO3, "bldo3", "bldoin", 500, 3500, 100,
 		 AXP717_BLDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO0_OUTPUT_CONTROL, BIT(6)),
-	AXP_DESC(AXP717, BLDO4, "bldo4", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, BLDO4, "bldo4", "bldoin", 500, 3500, 100,
 		 AXP717_BLDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO0_OUTPUT_CONTROL, BIT(7)),
-	AXP_DESC(AXP717, CLDO1, "cldo1", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, CLDO1, "cldo1", "cldoin", 500, 3500, 100,
 		 AXP717_CLDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO1_OUTPUT_CONTROL, BIT(0)),
-	AXP_DESC(AXP717, CLDO2, "cldo2", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, CLDO2, "cldo2", "cldoin", 500, 3500, 100,
 		 AXP717_CLDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO1_OUTPUT_CONTROL, BIT(1)),
-	AXP_DESC(AXP717, CLDO3, "cldo3", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, CLDO3, "cldo3", "cldoin", 500, 3500, 100,
 		 AXP717_CLDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO1_OUTPUT_CONTROL, BIT(2)),
-	AXP_DESC(AXP717, CLDO4, "cldo4", "vin1", 500, 3500, 100,
+	AXP_DESC(AXP717, CLDO4, "cldo4", "cldoin", 500, 3500, 100,
 		 AXP717_CLDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO1_OUTPUT_CONTROL, BIT(3)),
 	AXP_DESC(AXP717, CPUSLDO, "cpusldo", "vin1", 500, 1400, 50,
-- 
2.35.8


