Return-Path: <linux-kernel+bounces-83299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA7F869190
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C24B29625
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F9A13B7AA;
	Tue, 27 Feb 2024 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="eCuzhSel"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82113B7A2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039727; cv=none; b=UJsnVMHnlRrO5kMzoVMMyJTsSFYYX3wOnXQyrCJzMRMnIq2s1awuILAcaXoLNTNruP8da5MSd+V35GW0nUjHoC3hCIylJ2Qu42/Jw3hDC9JxK0xDMubZtl2J7lP0dLKbkokQVGKrJpTBn65uqNLBiS6nG1vIq+UzQ2NhiBGkPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039727; c=relaxed/simple;
	bh=FP6AjnY6lykXcHHYUiN/iTD0OoHVJjRqhJvevTgWu7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWkJe0ANlK6AgMosKjlpEk98fJo7NrvlnpQ7kXjUwe+wNeJjlXUVE3weY5XOC0TLGB4/uKxa7COBuoEsHhI8y/0orCr1Z0+Zax20JrVMnsHpRNLLCcqicVAyhMPsjwjKvd4PTvtlvI68EO3Qxo0LtzHsXCeVXZJ+KHlQJ4gH5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=eCuzhSel; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240227131514b5d18e2db4e7cf0d04
        for <linux-kernel@vger.kernel.org>;
        Tue, 27 Feb 2024 14:15:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gx92jGR/bM3wlQtlpHTsHDgQzGr0Puey6WoEtzn4I0A=;
 b=eCuzhSelNHUz20au0aROGtgres048/b9fq80IOQZyW7fUcqgF6IMwNn3u9rMYt3wZ5mvYX
 ikQhMyy2f1Fwtg8aqH13f1l3tZ1gEB7L+jVatBQhuYMmlQ85+1hm1oZ6WhNtw+bT1OHyy7L+
 vNbcsOUwgQcDp4EUro2PIoG60VOgw=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-rtc@vger.kernel.org
Cc: Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH] rtc: pcf85063: do a SW reset after rtc power fail
Date: Tue, 27 Feb 2024 14:14:32 +0100
Message-ID: <20240227131436.3342807-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Lukas Stockmann <lukas.stockmann@siemens.com>

From PCF85063A datasheet, section "Software reset":

"There is a low probability that some devices will have corruption of the
registers after the automatic power-on reset if the device is powered up
with a residual VDD level. It is required that the VDD starts at zero volts
at power up or upon power cycling to ensure that there is no corruption of
the registers. If this is not possible, a reset must be initiated after
power-up (i.e. when power is stable) with the software reset command"

Trigger SW reset if a power loss is detected.

Link: https://www.nxp.com/docs/en/data-sheet/PCF85063A.pdf
Signed-off-by: Lukas Stockmann <lukas.stockmann@siemens.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/rtc/rtc-pcf85063.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index fdbc07f14036..edfd75d18e19 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -35,6 +35,7 @@
 #define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
 #define PCF85063_REG_CTRL1_STOP		BIT(5)
 #define PCF85063_REG_CTRL1_EXT_TEST	BIT(7)
+#define PCF85063_REG_CTRL1_SWR		0x58
 
 #define PCF85063_REG_CTRL2		0x01
 #define PCF85063_CTRL2_AF		BIT(6)
@@ -580,7 +581,7 @@ static int pcf85063_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, pcf85063);
 
-	err = regmap_read(pcf85063->regmap, PCF85063_REG_CTRL1, &tmp);
+	err = regmap_read(pcf85063->regmap, PCF85063_REG_SC, &tmp);
 	if (err) {
 		dev_err(&client->dev, "RTC chip is not present\n");
 		return err;
@@ -590,6 +591,22 @@ static int pcf85063_probe(struct i2c_client *client)
 	if (IS_ERR(pcf85063->rtc))
 		return PTR_ERR(pcf85063->rtc);
 
+	/*
+	 * If a Power loss is detected, SW reset the device.
+	 * From PCF85063A datasheet:
+	 * There is a low probability that some devices will have corruption
+	 * of the registers after the automatic power-on reset...
+	 */
+	if (tmp & PCF85063_REG_SC_OS) {
+		dev_warn(&client->dev,
+			 "Power loss detected, send a SW reset to the device\n");
+		err = regmap_write(pcf85063->regmap, PCF85063_REG_CTRL1,
+				PCF85063_REG_CTRL1_SWR);
+		if (err < 0)
+			dev_err(&client->dev,
+				"SW reset failed, trying to continue\n");
+	}
+
 	err = pcf85063_load_capacitance(pcf85063, client->dev.of_node,
 					config->force_cap_7000 ? 7000 : 0);
 	if (err < 0)
-- 
2.43.2


