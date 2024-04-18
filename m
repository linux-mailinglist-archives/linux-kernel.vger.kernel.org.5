Return-Path: <linux-kernel+bounces-149341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7941C8A8FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2817F2825EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09761848E;
	Thu, 18 Apr 2024 00:07:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE44A04;
	Thu, 18 Apr 2024 00:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398876; cv=none; b=sFHolpQ9Zm9/vcYpmKAQIcc2nOkxa6Sk0p20ankmjODHItxARMq0fR4zRg+555Y8soXoGbBUwk7YROh42tL0SkuLsbce0/XRFbsrZBtzHicdI+ldFpPs7OLRLRDTQ0pZmVJF+joVphJm9HfQ894cTNqQHe9OTB5mYInqUs5KdrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398876; c=relaxed/simple;
	bh=bnC/G3wpFjcp/esOPiMBD/qQMc1n6JpkNiYtCAfnWLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJdWmbGr8UIb4G1mH03bvJqMeVav4b2jbRwarLYa3cA1GlVySfyOXiusU23PmlVhCvL2DTnJLEze3JQX90/YtGjOgZ+/v0o/cVpojJFHFppsWeMV6ZKBTHJGOY+MZKIaGERgdhBUAKE6LJaE+smkfGgbDlg/Kq8+snm5w5zNrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BF82339;
	Wed, 17 Apr 2024 17:08:21 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6818A3F64C;
	Wed, 17 Apr 2024 17:07:51 -0700 (PDT)
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
Subject: [PATCH v2 2/5] regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones
Date: Thu, 18 Apr 2024 01:07:33 +0100
Message-Id: <20240418000736.24338-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240418000736.24338-1-andre.przywara@arm.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
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
checking the numbers against the datasheet. This uncovered a bug in the
datasheet: add a comment to document this.

Fixes: d2ac3df75c3a ("regulator: axp20x: add support for the AXP717")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 33 ++++++++++++++++------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 34fcdd82b2eaa..f3c447ecdc3bf 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -140,7 +140,7 @@
 
 #define AXP717_DCDC1_NUM_VOLTAGES	88
 #define AXP717_DCDC2_NUM_VOLTAGES	107
-#define AXP717_DCDC3_NUM_VOLTAGES	104
+#define AXP717_DCDC3_NUM_VOLTAGES	103
 #define AXP717_DCDC_V_OUT_MASK		GENMASK(6, 0)
 #define AXP717_LDO_V_OUT_MASK		GENMASK(4, 0)
 
@@ -763,10 +763,15 @@ static const struct linear_range axp717_dcdc1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
 };
 
+/*
+ * The manual says that the last voltage is 3.4V, encoded as 0b1101011 (107),
+ * but every other method proves that this is wrong, so it's really 106 that
+ * programs the final 3.4V.
+ */
 static const struct linear_range axp717_dcdc2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
 	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
-	REGULATOR_LINEAR_RANGE(1600000, 88, 107, 100000),
+	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
 };
 
 static const struct linear_range axp717_dcdc3_ranges[] = {
@@ -790,40 +795,40 @@ static const struct regulator_desc axp717_regulators[] = {
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


