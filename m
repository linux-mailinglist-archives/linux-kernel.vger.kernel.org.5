Return-Path: <linux-kernel+bounces-12552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4C81F6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737EC285640
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAEC747C;
	Thu, 28 Dec 2023 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="OdeYDjZG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F876FAD;
	Thu, 28 Dec 2023 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id D5FCC28C558;
	Thu, 28 Dec 2023 11:02:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1703757747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsD+Ig67rpZi8IXpGlEIkzXED2wjBoY8yOB7Th2FEqM=;
	b=OdeYDjZGY5quFqORPPXshpQaLVLAyOjxSWI/DIIBTr8Llsx2Kn/q7yNVRLH9AJNxKLs0ch
	B3PK3el9M1wK4pu3bX8ikixmfJqiYohnPrFYZ6GYYdYimUyhCDLSQl2NKZYsCGeVDS3ICr
	cXN635as2m9Aw8WM63evuFFTCR7lASY=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id B29D54423CE;
	Thu, 28 Dec 2023 11:02:27 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH 2/5] mfd: 88pm88x: initialize the regulators regmaps
Date: Thu, 28 Dec 2023 10:39:11 +0100
Message-ID: <20231228100208.2932-3-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

The regulators registers are accessed via a different I2C address than
the already implemented functionality. Initialize the new regmap for the
regulator driver to use. For 88PM886 the buck regmap is the same as LDO
regmap, however this is not the case for 88PM880.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 drivers/mfd/88pm88x.c       | 33 +++++++++++++++++++++++++++++++++
 include/linux/mfd/88pm88x.h |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/mfd/88pm88x.c b/drivers/mfd/88pm88x.c
index 3424d88a58f6..69a8e39d43b3 100644
--- a/drivers/mfd/88pm88x.c
+++ b/drivers/mfd/88pm88x.c
@@ -98,6 +98,35 @@ static int pm88x_power_off_handler(struct sys_off_data *data)
 	return NOTIFY_DONE;
 }
 
+static int pm88x_initialize_subregmaps(struct pm88x_chip *chip)
+{
+	struct i2c_client *page;
+	struct regmap *regmap;
+	int ret;
+
+	/* LDO page */
+	page = devm_i2c_new_dummy_device(&chip->client->dev, chip->client->adapter,
+					chip->client->addr + PM88X_PAGE_OFFSET_LDO);
+	if (IS_ERR(page)) {
+		ret = PTR_ERR(page);
+		dev_err(&chip->client->dev, "Failed to initialize LDO client: %d\n",
+				ret);
+		return ret;
+	}
+	regmap = devm_regmap_init_i2c(page, &pm88x_i2c_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&chip->client->dev, "Failed to initialize LDO regmap: %d\n",
+				ret);
+		return ret;
+	}
+	chip->regmaps[PM88X_REGMAP_LDO] = regmap;
+	/* buck regmap is the same as LDO */
+	chip->regmaps[PM88X_REGMAP_BUCK] = regmap;
+
+	return 0;
+}
+
 static int pm88x_setup_irq(struct pm88x_chip *chip)
 {
 	int ret;
@@ -155,6 +184,10 @@ static int pm88x_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
+	ret = pm88x_initialize_subregmaps(chip);
+	if (ret)
+		return ret;
+
 	ret = pm88x_setup_irq(chip);
 	if (ret)
 		return ret;
diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
index 9a335f6b9c07..703e6104c1d8 100644
--- a/include/linux/mfd/88pm88x.h
+++ b/include/linux/mfd/88pm88x.h
@@ -39,8 +39,12 @@
 
 #define PM88X_REG_AON_CTRL2		0xe2
 
+#define PM88X_PAGE_OFFSET_LDO		1
+
 enum pm88x_regmap_index {
 	PM88X_REGMAP_BASE,
+	PM88X_REGMAP_LDO,
+	PM88X_REGMAP_BUCK,
 
 	PM88X_REGMAP_NR
 };
-- 
2.43.0


