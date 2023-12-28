Return-Path: <linux-kernel+bounces-12551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA7581F6A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD24285683
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EEE6FC5;
	Thu, 28 Dec 2023 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="NtB0Z3WX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7F63C6;
	Thu, 28 Dec 2023 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id EC6E628C556;
	Thu, 28 Dec 2023 11:02:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1703757743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=reD/I3eBv9lwzRcVumL6wA4HHqcgwCGXR849XP7JFqk=;
	b=NtB0Z3WXtMxwoAgv6bocv8Vo273oBsXVko1c5uru6XFjKos2fIN6Y0QEXBbsP2yeMduL5P
	n8RLKsCcDx6vJfVhMojAhszQEeM9TRazAWvzWcA6V9dz2EPKEEXPH0Qzj3oGeGK8c9ZKQ0
	+DRSBUOFYPQ9mFL7obXKLYWIoOYj5HE=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id CB00D4423CE;
	Thu, 28 Dec 2023 11:02:23 +0100 (CET)
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
Subject: [RFC PATCH 1/5] mfd: 88pm88x: differences with respect to the PMIC RFC series
Date: Thu, 28 Dec 2023 10:39:10 +0100
Message-ID: <20231228100208.2932-2-karelb@gimli.ms.mff.cuni.cz>
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

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 drivers/mfd/88pm88x.c       | 14 ++++++++------
 include/linux/mfd/88pm88x.h |  2 ++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/88pm88x.c b/drivers/mfd/88pm88x.c
index 5db6c65b667d..3424d88a58f6 100644
--- a/drivers/mfd/88pm88x.c
+++ b/drivers/mfd/88pm88x.c
@@ -57,16 +57,16 @@ static struct reg_sequence pm886_presets[] = {
 	REG_SEQ0(PM88X_REG_BK_OSC_CTRL3, 0xc0),
 };
 
-static struct resource onkey_resources[] = {
+static struct resource pm88x_onkey_resources[] = {
 	DEFINE_RES_IRQ_NAMED(PM88X_IRQ_ONKEY, "88pm88x-onkey"),
 };
 
-static struct mfd_cell pm88x_devs[] = {
+static struct mfd_cell pm886_devs[] = {
 	{
 		.name = "88pm88x-onkey",
-		.num_resources = ARRAY_SIZE(onkey_resources),
-		.resources = onkey_resources,
-		.id = -1,
+		.of_compatible = "marvell,88pm88x-onkey",
+		.num_resources = ARRAY_SIZE(pm88x_onkey_resources),
+		.resources = pm88x_onkey_resources,
 	},
 };
 
@@ -74,6 +74,8 @@ static struct pm88x_data pm886_a1_data = {
 	.whoami = PM886_A1_WHOAMI,
 	.presets = pm886_presets,
 	.num_presets = ARRAY_SIZE(pm886_presets),
+	.devs = pm886_devs,
+	.num_devs = ARRAY_SIZE(pm886_devs),
 };
 
 static const struct regmap_config pm88x_i2c_regmap = {
@@ -157,7 +159,7 @@ static int pm88x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = devm_mfd_add_devices(&client->dev, 0, pm88x_devs, ARRAY_SIZE(pm88x_devs),
+	ret = devm_mfd_add_devices(&client->dev, 0, chip->data->devs, chip->data->num_devs,
 			NULL, 0, regmap_irq_get_domain(chip->irq_data));
 	if (ret) {
 		dev_err(&client->dev, "Failed to add devices: %d\n", ret);
diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
index a34c57447827..9a335f6b9c07 100644
--- a/include/linux/mfd/88pm88x.h
+++ b/include/linux/mfd/88pm88x.h
@@ -49,6 +49,8 @@ struct pm88x_data {
 	unsigned int whoami;
 	struct reg_sequence *presets;
 	unsigned int num_presets;
+	struct mfd_cell *devs;
+	unsigned int num_devs;
 };
 
 struct pm88x_chip {
-- 
2.43.0


