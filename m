Return-Path: <linux-kernel+bounces-125537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310828927EE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71E21F222A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596013FD7E;
	Fri, 29 Mar 2024 23:50:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E99813F44E;
	Fri, 29 Mar 2024 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756258; cv=none; b=G0lzZA0/GKD1Ij8uO/qFeLXIS+ckV82fP8GwISmNVYouiS2FS7uSGfEMc9dDRfO56Ayyrwxf+L90XK6CeZHQKG93NFeJ/7YBm/hdOVR3Rfqp1K5lHxWGVO4ReBURQNBa5fdlQzRejGzOqstiCDzFo8mJjHVlLkOV7ZYT9qxno+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756258; c=relaxed/simple;
	bh=gzR5Vir/b6qMXe+daHd5TmgU6Hf11gWLwyKoQMzbRxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+YMURDC64bme+8L0Rs3xAKyhaKSjf5zPhvCBlG2AfqUeSuCjnZ1LQnzs2NCJ0Zr7Kw1Sd6Homsm6vAL6HLvyGPYSwI5w5icEGuMXXYCJklQVy6VeTtz/ybDN/4Ioay9eAC6ZU5VCJo6ChrfA4AAdXOKA/c0Xi5EHCvvdhoCnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB97712FC;
	Fri, 29 Mar 2024 16:51:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B5B3F64C;
	Fri, 29 Mar 2024 16:50:54 -0700 (PDT)
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
Subject: [PATCH 4/4] regulator: axp20x: AXP717: Add boost regulator
Date: Fri, 29 Mar 2024 23:50:33 +0000
Message-Id: <20240329235033.25309-5-andre.przywara@arm.com>
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

The AXP717 also contains an adjustable boost regulator, to provide the
5V USB VBUS rail when running on battery.

Add the regulator description that states the voltage range this
regulator can cover.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 4 ++++
 include/linux/mfd/axp20x.h           | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 3907606b091f6..71407c5810941 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -143,6 +143,7 @@
 #define AXP717_DCDC3_NUM_VOLTAGES	103
 #define AXP717_DCDC_V_OUT_MASK		GENMASK(6, 0)
 #define AXP717_LDO_V_OUT_MASK		GENMASK(4, 0)
+#define AXP717_BOOST_V_OUT_MASK		GENMASK(7, 4)
 
 #define AXP803_PWR_OUT_DCDC1_MASK	BIT_MASK(0)
 #define AXP803_PWR_OUT_DCDC2_MASK	BIT_MASK(1)
@@ -829,6 +830,9 @@ static const struct regulator_desc axp717_regulators[] = {
 	AXP_DESC(AXP717, CPUSLDO, "cpusldo", "vin1", 500, 1400, 50,
 		 AXP717_CPUSLDO_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO1_OUTPUT_CONTROL, BIT(4)),
+	AXP_DESC(AXP717, BOOST, "boost", "vin1", 4550, 5510, 64,
+		 AXP717_BOOST_CONTROL, AXP717_BOOST_V_OUT_MASK,
+		 AXP717_MODULE_EN_CONTROL, BIT(4)),
 };
 
 /* DCDC ranges shared with AXP813 */
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 4dad54fdf67ee..5e86b976c4caa 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -486,6 +486,7 @@ enum {
 	AXP717_CLDO3,
 	AXP717_CLDO4,
 	AXP717_CPUSLDO,
+	AXP717_BOOST,
 	AXP717_REG_ID_MAX,
 };
 
-- 
2.35.8


