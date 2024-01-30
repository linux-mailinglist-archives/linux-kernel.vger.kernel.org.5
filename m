Return-Path: <linux-kernel+bounces-44298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A484200E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F18728F6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A066B49;
	Tue, 30 Jan 2024 09:47:31 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95753629EF;
	Tue, 30 Jan 2024 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608050; cv=none; b=YzAZnfwt4TQti+pyl5PNwUeiBEyMzzeCFXPHuaqZNnLy2siuSypP3Bud/HlVIV90W1+XdpQz1uboZf5Zo9zfV11SsjArOXRnoWSFYnggVT9p+UbG3hRBruNGqXinTEaOp8v2F0Yy35Rm1jY6NQR3KKGtJo7W8oZfT944PT2aRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608050; c=relaxed/simple;
	bh=3j7qNw//RbI0sRRiGsyMLOaSNqnyk1fLqWXikzWa7e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+B0uBqaqsaAY8eGnD+t9iNs3x+XQe48tENsQwFUOtRQb/NIwipH6Bl3NhClOK4j6TngJYtKdykptOfD0LL2r8pV1Q27kciIBkRrRZfsCxnQNpLa4/NE9cbw4HHvC7oKmjj963ksDf2d8GJBA8iOVwgHLVXHV151mf+1HIX8wBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 5052C2F20248; Tue, 30 Jan 2024 09:47:25 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 4F4882F20249;
	Tue, 30 Jan 2024 09:47:15 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	u.kleine-koenig@pengutronix.de,
	a.firago@yadro.com,
	sashal@kernel.org,
	zhuning0077@gmail.com,
	tiwai@suse.com,
	perex@perex.cz,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 6/7] ASOC: codecs: ES8326: Add calibration support for version_b
Date: Tue, 30 Jan 2024 12:47:07 +0300
Message-Id: <20240130094708.290485-7-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240130094708.290485-1-kovalev@altlinux.org>
References: <20240130094708.290485-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Ning <zhuning0077@gmail.com>

Commit 0663286e58e6f611f3578b5e63e1faa576d139fd upstream.

Version_b requires a new way of calibrating headset offset. A new
calibration function is added.

Signed-off-by: Zhu Ning <zhuning0077@gmail.com>
Link: https://lore.kernel.org/r/20230717033223.42506-4-zhuning0077@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/soc/codecs/es8326.c | 83 ++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 1525fac1f9b8b1..50b13296e246e1 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -388,6 +388,7 @@ static int es8326_mute(struct snd_soc_dai *dai, int mute, int direction)
 {
 	struct snd_soc_component *component = dai->component;
 	struct es8326_priv *es8326 = snd_soc_component_get_drvdata(component);
+	unsigned int offset_l, offset_r;
 
 	if (mute) {
 		regmap_write(es8326->regmap, ES8326_HP_CAL, ES8326_HP_OFF);
@@ -398,10 +399,16 @@ static int es8326_mute(struct snd_soc_dai *dai, int mute, int direction)
 		if (!es8326->calibrated) {
 			regmap_write(es8326->regmap, ES8326_HP_CAL, ES8326_HP_FORCE_CAL);
 			msleep(30);
+			regmap_write(es8326->regmap, ES8326_HP_CAL, ES8326_HP_OFF);
+			regmap_read(es8326->regmap, ES8326_HPL_OFFSET_INI, &offset_l);
+			regmap_read(es8326->regmap, ES8326_HPR_OFFSET_INI, &offset_r);
+			regmap_write(es8326->regmap, ES8326_HP_OFFSET_CAL, 0x8c);
+			regmap_write(es8326->regmap, ES8326_HPL_OFFSET_INI, offset_l);
+			regmap_write(es8326->regmap, ES8326_HPR_OFFSET_INI, offset_r);
 			es8326->calibrated = true;
 		}
 		regmap_write(es8326->regmap, ES8326_HP_DRIVER, 0xa0);
-		regmap_write(es8326->regmap, ES8326_HP_VOL, 0x00);
+		regmap_write(es8326->regmap, ES8326_HP_VOL, 0x80);
 		regmap_write(es8326->regmap, ES8326_HP_CAL, ES8326_HP_ON);
 		regmap_update_bits(es8326->regmap, ES8326_DAC_MUTE,
 				ES8326_MUTE_MASK, ~(ES8326_MUTE));
@@ -420,15 +427,17 @@ static int es8326_set_bias_level(struct snd_soc_component *codec,
 		ret = clk_prepare_enable(es8326->mclk);
 		if (ret)
 			return ret;
-		regmap_write(es8326->regmap, ES8326_RESET, ES8326_PWRUP_SEQ_EN);
-		regmap_write(es8326->regmap, ES8326_INTOUT_IO, 0x45);
+
+		regmap_write(es8326->regmap, ES8326_RESET, 0x9f);
+		msleep(20);
+		regmap_update_bits(es8326->regmap, ES8326_DAC_DSM, 0x01, 0x00);
+		regmap_write(es8326->regmap, ES8326_INTOUT_IO, es8326->interrupt_clk);
 		regmap_write(es8326->regmap, ES8326_SDINOUT1_IO,
 			    (ES8326_IO_DMIC_CLK << ES8326_SDINOUT1_SHIFT));
-		regmap_write(es8326->regmap, ES8326_SDINOUT23_IO, ES8326_IO_INPUT);
-		regmap_write(es8326->regmap, ES8326_CLK_RESAMPLE, 0x05);
-		regmap_write(es8326->regmap, ES8326_VMIDSEL, 0x02);
+		regmap_write(es8326->regmap, ES8326_VMIDSEL, 0x0E);
 		regmap_write(es8326->regmap, ES8326_PGA_PDN, 0x40);
-		regmap_write(es8326->regmap, ES8326_DAC2HPMIX, 0xAA);
+		regmap_write(es8326->regmap, ES8326_ANA_PDN, 0x00);
+		regmap_update_bits(es8326->regmap,  ES8326_CLK_CTL, 0x20, 0x20);
 		regmap_write(es8326->regmap, ES8326_RESET, ES8326_CSM_ON);
 		break;
 	case SND_SOC_BIAS_PREPARE:
@@ -437,15 +446,10 @@ static int es8326_set_bias_level(struct snd_soc_component *codec,
 		break;
 	case SND_SOC_BIAS_OFF:
 		clk_disable_unprepare(es8326->mclk);
-		regmap_write(es8326->regmap, ES8326_DAC2HPMIX, 0x11);
-		regmap_write(es8326->regmap, ES8326_RESET, ES8326_CSM_OFF);
-		regmap_write(es8326->regmap, ES8326_PGA_PDN, 0xF8);
+		regmap_write(es8326->regmap, ES8326_ANA_PDN, 0x3b);
 		regmap_write(es8326->regmap, ES8326_VMIDSEL, 0x00);
-		regmap_write(es8326->regmap, ES8326_INT_SOURCE, 0x08);
+		regmap_update_bits(es8326->regmap, ES8326_CLK_CTL, 0x20, 0x00);
 		regmap_write(es8326->regmap, ES8326_SDINOUT1_IO, ES8326_IO_INPUT);
-		regmap_write(es8326->regmap, ES8326_SDINOUT23_IO, ES8326_IO_INPUT);
-		regmap_write(es8326->regmap, ES8326_RESET,
-			     ES8326_CODEC_RESET | ES8326_PWRUP_SEQ_EN);
 		break;
 	}
 
@@ -635,6 +639,54 @@ static irqreturn_t es8326_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int es8326_calibrate(struct snd_soc_component *component)
+{
+	struct es8326_priv *es8326 = snd_soc_component_get_drvdata(component);
+	unsigned int reg;
+	unsigned int offset_l, offset_r;
+
+	regmap_read(es8326->regmap, ES8326_CHIP_VERSION, &reg);
+	es8326->version = reg;
+
+	if ((es8326->version == ES8326_VERSION_B) && (es8326->calibrated == false)) {
+		dev_dbg(component->dev, "ES8326_VERSION_B, calibrating\n");
+		regmap_write(es8326->regmap, ES8326_CLK_INV, 0xc0);
+		regmap_write(es8326->regmap, ES8326_CLK_DIV1, 0x01);
+		regmap_write(es8326->regmap, ES8326_CLK_DLL, 0x30);
+		regmap_write(es8326->regmap, ES8326_CLK_MUX, 0xed);
+		regmap_write(es8326->regmap, ES8326_CLK_TRI, 0xc1);
+		regmap_write(es8326->regmap, ES8326_DAC_MUTE, 0x03);
+		regmap_write(es8326->regmap, ES8326_ANA_VSEL, 0x7f);
+		regmap_write(es8326->regmap, ES8326_VMIDLOW, 0x33);
+		regmap_write(es8326->regmap, ES8326_DAC2HPMIX, 0x88);
+		regmap_write(es8326->regmap, ES8326_HP_VOL, 0x80);
+		regmap_write(es8326->regmap, ES8326_HP_OFFSET_CAL, 0x8c);
+		regmap_write(es8326->regmap, ES8326_RESET, 0xc0);
+		usleep_range(15000, 20000);
+
+		regmap_write(es8326->regmap, ES8326_HP_OFFSET_CAL, ES8326_HP_OFF);
+		regmap_read(es8326->regmap, ES8326_CSM_MUTE_STA, &reg);
+		if ((reg & 0xf0) != 0x40)
+			msleep(50);
+
+		regmap_write(es8326->regmap, ES8326_HP_CAL, 0xd4);
+		msleep(200);
+		regmap_write(es8326->regmap, ES8326_HP_CAL, 0x4d);
+		msleep(200);
+		regmap_write(es8326->regmap, ES8326_HP_CAL, ES8326_HP_OFF);
+		regmap_read(es8326->regmap, ES8326_HPL_OFFSET_INI, &offset_l);
+		regmap_read(es8326->regmap, ES8326_HPR_OFFSET_INI, &offset_r);
+		regmap_write(es8326->regmap, ES8326_HP_OFFSET_CAL, 0x8c);
+		regmap_write(es8326->regmap, ES8326_HPL_OFFSET_INI, offset_l);
+		regmap_write(es8326->regmap, ES8326_HPR_OFFSET_INI, offset_r);
+		regmap_write(es8326->regmap, ES8326_CLK_INV, 0x00);
+
+		es8326->calibrated = true;
+	}
+
+	return 0;
+}
+
 static int es8326_resume(struct snd_soc_component *component)
 {
 	struct es8326_priv *es8326 = snd_soc_component_get_drvdata(component);
@@ -673,7 +725,8 @@ static int es8326_resume(struct snd_soc_component *component)
 	regmap_write(es8326->regmap, ES8326_CLK_VMIDS1, 0xc4);
 	regmap_write(es8326->regmap, ES8326_CLK_VMIDS2, 0x81);
 	regmap_write(es8326->regmap, ES8326_CLK_CAL_TIME, 0x00);
-
+	/* calibrate for B version */
+	es8326_calibrate(component);
 	/* turn off headphone out */
 	regmap_write(es8326->regmap, ES8326_HP_CAL, 0x00);
 	/* set ADC and DAC in low power mode */
-- 
2.33.8


