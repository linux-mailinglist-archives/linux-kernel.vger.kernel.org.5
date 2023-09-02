Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D147909AB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 23:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjIBVG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 17:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjIBVGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 17:06:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892031718
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 14:06:45 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC9E366072B6;
        Sat,  2 Sep 2023 22:06:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693688804;
        bh=w5FQqX5N0SNY30mh7ugIsBlhQQTzEUlaqCEU1kT1GFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsV5Z5qXxHI1zSHIAWX75tvNJU3lFptraqm847T0X0jApT8o3TtarXt2lIAni6cYA
         zWoi/adINh/vCW9bvyQsNMGRqcFso3rmxgNOcit2Kxm02CQdSlF4N/HqgVqISFAykC
         wKCm3j/r+ROf4iBRKsRM412rvw4bLYyWhhHy5jBCZAtTUX/m4Ly0fuozAmS81chQv0
         1zPdtb5MDfdrdpq+f9ZsvWPaZCuviWhzCMqKnW1raow5TNdgjJVMOKIydeDjUyY3uY
         XW1BAEzxzmNi3RDMMprX5rN3fJJhvWaSpzNL2kRPIm7v6xsI/VLhw2ln6moTppPEyp
         i7FqJXBmtj4nw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 6/9] ASoC: cs35l41: Make use of dev_err_probe()
Date:   Sun,  3 Sep 2023 00:06:18 +0300
Message-ID: <20230902210621.1184693-7-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() helper where possible, to simplify error handling
during probe.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/cs35l41-i2c.c |  9 +++------
 sound/soc/codecs/cs35l41-spi.c |  9 +++------
 sound/soc/codecs/cs35l41.c     | 34 ++++++++++++++++------------------
 3 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-i2c.c b/sound/soc/codecs/cs35l41-i2c.c
index 7ea890d7d387..9109203a7f25 100644
--- a/sound/soc/codecs/cs35l41-i2c.c
+++ b/sound/soc/codecs/cs35l41-i2c.c
@@ -35,7 +35,6 @@ static int cs35l41_i2c_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct cs35l41_hw_cfg *hw_cfg = dev_get_platdata(dev);
 	const struct regmap_config *regmap_config = &cs35l41_regmap_i2c;
-	int ret;
 
 	cs35l41 = devm_kzalloc(dev, sizeof(struct cs35l41_private), GFP_KERNEL);
 
@@ -47,11 +46,9 @@ static int cs35l41_i2c_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, cs35l41);
 	cs35l41->regmap = devm_regmap_init_i2c(client, regmap_config);
-	if (IS_ERR(cs35l41->regmap)) {
-		ret = PTR_ERR(cs35l41->regmap);
-		dev_err(cs35l41->dev, "Failed to allocate register map: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(cs35l41->regmap))
+		return dev_err_probe(cs35l41->dev, PTR_ERR(cs35l41->regmap),
+				     "Failed to allocate register map\n");
 
 	return cs35l41_probe(cs35l41, hw_cfg);
 }
diff --git a/sound/soc/codecs/cs35l41-spi.c b/sound/soc/codecs/cs35l41-spi.c
index 5c8bb24909eb..28e9c9473e60 100644
--- a/sound/soc/codecs/cs35l41-spi.c
+++ b/sound/soc/codecs/cs35l41-spi.c
@@ -32,7 +32,6 @@ static int cs35l41_spi_probe(struct spi_device *spi)
 	const struct regmap_config *regmap_config = &cs35l41_regmap_spi;
 	struct cs35l41_hw_cfg *hw_cfg = dev_get_platdata(&spi->dev);
 	struct cs35l41_private *cs35l41;
-	int ret;
 
 	cs35l41 = devm_kzalloc(&spi->dev, sizeof(struct cs35l41_private), GFP_KERNEL);
 	if (!cs35l41)
@@ -43,11 +42,9 @@ static int cs35l41_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, cs35l41);
 	cs35l41->regmap = devm_regmap_init_spi(spi, regmap_config);
-	if (IS_ERR(cs35l41->regmap)) {
-		ret = PTR_ERR(cs35l41->regmap);
-		dev_err(&spi->dev, "Failed to allocate register map: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(cs35l41->regmap))
+		return dev_err_probe(cs35l41->dev, PTR_ERR(cs35l41->regmap),
+				     "Failed to allocate register map\n");
 
 	cs35l41->dev = &spi->dev;
 	cs35l41->irq = spi->irq;
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index e143b0e306b1..6f2ad0d3a75c 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1204,16 +1204,14 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 
 	ret = devm_regulator_bulk_get(cs35l41->dev, CS35L41_NUM_SUPPLIES,
 				      cs35l41->supplies);
-	if (ret != 0) {
-		dev_err(cs35l41->dev, "Failed to request core supplies: %d\n", ret);
-		return ret;
-	}
+	if (ret != 0)
+		return dev_err_probe(cs35l41->dev, ret,
+				     "Failed to request core supplies\n");
 
 	ret = regulator_bulk_enable(CS35L41_NUM_SUPPLIES, cs35l41->supplies);
-	if (ret != 0) {
-		dev_err(cs35l41->dev, "Failed to enable core supplies: %d\n", ret);
-		return ret;
-	}
+	if (ret != 0)
+		return dev_err_probe(cs35l41->dev, ret,
+				     "Failed to enable core supplies\n");
 
 	/* returning NULL can be an option if in stereo mode */
 	cs35l41->reset_gpio = devm_gpiod_get_optional(cs35l41->dev, "reset",
@@ -1225,8 +1223,8 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 			dev_info(cs35l41->dev,
 				 "Reset line busy, assuming shared reset\n");
 		} else {
-			dev_err(cs35l41->dev,
-				"Failed to get reset GPIO: %d\n", ret);
+			dev_err_probe(cs35l41->dev, ret,
+				      "Failed to get reset GPIO\n");
 			goto err;
 		}
 	}
@@ -1242,8 +1240,8 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 				       int_status, int_status & CS35L41_OTP_BOOT_DONE,
 				       1000, 100000);
 	if (ret) {
-		dev_err(cs35l41->dev,
-			"Failed waiting for OTP_BOOT_DONE: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret,
+			      "Failed waiting for OTP_BOOT_DONE\n");
 		goto err;
 	}
 
@@ -1256,13 +1254,13 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 
 	ret = regmap_read(cs35l41->regmap, CS35L41_DEVID, &regid);
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "Get Device ID failed: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "Get Device ID failed\n");
 		goto err;
 	}
 
 	ret = regmap_read(cs35l41->regmap, CS35L41_REVID, &reg_revid);
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "Get Revision ID failed: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "Get Revision ID failed\n");
 		goto err;
 	}
 
@@ -1287,7 +1285,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 
 	ret = cs35l41_otp_unpack(cs35l41->dev, cs35l41->regmap);
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "OTP Unpack failed: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "OTP Unpack failed\n");
 		goto err;
 	}
 
@@ -1309,13 +1307,13 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 					IRQF_ONESHOT | IRQF_SHARED | irq_pol,
 					"cs35l41", cs35l41);
 	if (ret != 0) {
-		dev_err(cs35l41->dev, "Failed to request IRQ: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "Failed to request IRQ\n");
 		goto err;
 	}
 
 	ret = cs35l41_set_pdata(cs35l41);
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "Set pdata failed: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "Set pdata failed\n");
 		goto err;
 	}
 
@@ -1340,7 +1338,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 					      &soc_component_dev_cs35l41,
 					      cs35l41_dai, ARRAY_SIZE(cs35l41_dai));
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "Register codec failed: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "Register codec failed\n");
 		goto err_pm;
 	}
 
-- 
2.41.0

