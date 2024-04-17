Return-Path: <linux-kernel+bounces-148151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F52E8A7E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22911C2083B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2354513280F;
	Wed, 17 Apr 2024 08:31:43 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C812C486;
	Wed, 17 Apr 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342702; cv=none; b=kczeMdbNgEvvxZ5YUeml9vS3/RWhXaMmxODs4C6lXWr7TlUX5L1MMpmXGJamwa38ffibO6XjvpKwzXvC2H9TkkZvAg5qR1CNiSLu5LIZM0PL8NDYycRLmvA3HI2xIBLGLT7EbWh7yKhWsYYvaGdlmkFY7k8SgNgJKUMXB0xlFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342702; c=relaxed/simple;
	bh=uxwxNeYQPPPZxVlbsT5fzEjaxTsxN24ij15tiqhjAjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufPjR9yT6e0Bp2LhabS0wPsZEP+Yuz6cgwOaG/D7Lesh5I1IcsQ1PcdwQXHXirmSBFF8tywzGjjZ5NuWbAosR13TLHUFuWVZJjfek5rkLPzM3McPTNvltoy730mHtr5IaQ7pK1ULFVcdHZGuUFP8lxw8dFbAx+fz+lgFzj49fgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 242FF2F2023F; Wed, 17 Apr 2024 08:31:39 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 72EE62F20247;
	Wed, 17 Apr 2024 08:31:18 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	zhuning0077@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 6.1.y 4/6] ASoC: codecs: ES8326: Fix power-up sequence
Date: Wed, 17 Apr 2024 11:31:14 +0300
Message-Id: <20240417083116.608610-5-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240417083116.608610-1-kovalev@altlinux.org>
References: <20240417083116.608610-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Ning <zhuning0077@gmail.com>

Commit ac20a73d765c0374f5e7b5d0f2f43c4598d69c66 upstream.

Old power-up sequence causes large pop noise during start-up.
Using a new sequence instead.

Also, the registers are now reset to default value in suspend
function.

Signed-off-by: Zhu Ning <zhuning0077@gmail.com>
Link: https://lore.kernel.org/r/20230717033223.42506-3-zhuning0077@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/soc/codecs/es8326.c | 95 ++++++++++++++++++++++++++++-----------
 sound/soc/codecs/es8326.h | 10 ++++-
 2 files changed, 77 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 04d7403bfe9064..00ffe788bc8c6f 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -638,40 +638,77 @@ static irqreturn_t es8326_irq(int irq, void *dev_id)
 static int es8326_resume(struct snd_soc_component *component)
 {
 	struct es8326_priv *es8326 = snd_soc_component_get_drvdata(component);
-	unsigned int reg;
 
 	regcache_cache_only(es8326->regmap, false);
 	regcache_sync(es8326->regmap);
 
+	/* reset internal clock state */
+	regmap_write(es8326->regmap, ES8326_RESET, 0x1f);
+	regmap_write(es8326->regmap, ES8326_VMIDSEL, 0x0E);
+	usleep_range(10000, 15000);
+	regmap_write(es8326->regmap, ES8326_HPJACK_TIMER, 0x88);
+	/* set headphone default type and detect pin */
+	regmap_write(es8326->regmap, ES8326_HPDET_TYPE, 0x81);
+	regmap_write(es8326->regmap, ES8326_CLK_RESAMPLE, 0x05);
+
+	/* set internal oscillator as clock source of headpone cp */
+	regmap_write(es8326->regmap, ES8326_CLK_DIV_CPC, 0x84);
 	regmap_write(es8326->regmap, ES8326_CLK_CTL, ES8326_CLK_ON);
-	/* Two channel ADC */
-	regmap_write(es8326->regmap, ES8326_PULLUP_CTL, 0x02);
+	/* clock manager reset release */
+	regmap_write(es8326->regmap, ES8326_RESET, 0x17);
+	/* set headphone detection as half scan mode */
+	regmap_write(es8326->regmap, ES8326_HP_MISC, 0x08);
+	regmap_write(es8326->regmap, ES8326_PULLUP_CTL, 0x00);
+
+	/* enable headphone driver */
+	regmap_write(es8326->regmap, ES8326_HP_DRIVER, 0xa7);
+	usleep_range(2000, 5000);
+	regmap_write(es8326->regmap, ES8326_HP_DRIVER_REF, 0xab);
+	usleep_range(2000, 5000);
+	regmap_write(es8326->regmap, ES8326_HP_DRIVER_REF, 0xbb);
+	usleep_range(2000, 5000);
+	regmap_write(es8326->regmap, ES8326_HP_DRIVER, 0xa1);
+
 	regmap_write(es8326->regmap, ES8326_CLK_INV, 0x00);
-	regmap_write(es8326->regmap, ES8326_CLK_DIV_CPC, 0x1F);
-	regmap_write(es8326->regmap, ES8326_CLK_VMIDS1, 0xC8);
-	regmap_write(es8326->regmap, ES8326_CLK_VMIDS2, 0x88);
-	regmap_write(es8326->regmap, ES8326_CLK_CAL_TIME, 0x20);
+	regmap_write(es8326->regmap, ES8326_CLK_VMIDS1, 0xc4);
+	regmap_write(es8326->regmap, ES8326_CLK_VMIDS2, 0x81);
+	regmap_write(es8326->regmap, ES8326_CLK_CAL_TIME, 0x00);
+
+	/* turn off headphone out */
+	regmap_write(es8326->regmap, ES8326_HP_CAL, 0x00);
+	/* set ADC and DAC in low power mode */
+	regmap_write(es8326->regmap, ES8326_ANA_LP, 0xf0);
+
+	/* force micbias on */
+	regmap_write(es8326->regmap, ES8326_ANA_MICBIAS, 0x4f);
 	regmap_write(es8326->regmap, ES8326_SYS_BIAS, 0x08);
-	regmap_write(es8326->regmap, ES8326_DAC2HPMIX, 0x22);
-	regmap_write(es8326->regmap, ES8326_ADC1_SRC, es8326->mic1_src);
-	regmap_write(es8326->regmap, ES8326_ADC2_SRC, es8326->mic2_src);
-	regmap_write(es8326->regmap, ES8326_HPJACK_TIMER, 0x88);
-	regmap_write(es8326->regmap, ES8326_HPDET_TYPE,
-		     ES8326_HP_DET_SRC_PIN9 | es8326->jack_pol);
-	regmap_write(es8326->regmap, ES8326_INT_SOURCE, es8326->interrupt_src);
-	regmap_write(es8326->regmap, ES8326_INTOUT_IO, es8326->interrupt_clk);
+	regmap_write(es8326->regmap, ES8326_ANA_VSEL, 0x7F);
+	/* select vdda as micbias source */
+	regmap_write(es8326->regmap, ES8326_VMIDLOW, 0x23);
+	/* set dac dsmclip = 1 */
+	regmap_write(es8326->regmap, ES8326_DAC_DSM, 0x08);
+	regmap_write(es8326->regmap, ES8326_DAC_VPPSCALE, 0x15);
+
+	regmap_write(es8326->regmap, ES8326_INT_SOURCE,
+		    (ES8326_INT_SRC_PIN9 | ES8326_INT_SRC_BUTTON));
+	regmap_write(es8326->regmap, ES8326_INTOUT_IO,
+		     es8326->interrupt_clk);
+	regmap_write(es8326->regmap, ES8326_SDINOUT1_IO,
+		    (ES8326_IO_DMIC_CLK << ES8326_SDINOUT1_SHIFT));
+	regmap_write(es8326->regmap, ES8326_SDINOUT23_IO, ES8326_IO_INPUT);
+
+	regmap_write(es8326->regmap, ES8326_ANA_PDN, 0x3b);
 	regmap_write(es8326->regmap, ES8326_RESET, ES8326_CSM_ON);
-	snd_soc_component_update_bits(component, ES8326_PGAGAIN,
-				      ES8326_MIC_SEL_MASK, ES8326_MIC1_SEL);
-
-	regmap_read(es8326->regmap, ES8326_CHIP_VERSION, &reg);
-	if ((reg & ES8326_VERSION_B) == 1) {
-		regmap_write(es8326->regmap, ES8326_ANA_MICBIAS, 0xDD);
-		regmap_write(es8326->regmap, ES8326_ANA_VSEL, 0x7F);
-		regmap_write(es8326->regmap, ES8326_VMIDLOW, 0x0F);
-		/* enable button detect */
-		regmap_write(es8326->regmap, ES8326_HP_DRIVER, 0xA0);
-	}
+	regmap_update_bits(es8326->regmap, ES8326_PGAGAIN, ES8326_MIC_SEL_MASK,
+			   ES8326_MIC1_SEL);
+
+	regmap_update_bits(es8326->regmap, ES8326_DAC_MUTE, ES8326_MUTE_MASK,
+			   ES8326_MUTE);
+
+	regmap_write(es8326->regmap, ES8326_HPDET_TYPE, 0x80 |
+			((es8326->version == ES8326_VERSION_B) ?
+			(ES8326_HP_DET_SRC_PIN9 | es8326->jack_pol) :
+			(ES8326_HP_DET_SRC_PIN9 | es8326->jack_pol | 0x04)));
 
 	es8326_irq(es8326->irq, es8326);
 	return 0;
@@ -688,6 +725,10 @@ static int es8326_suspend(struct snd_soc_component *component)
 	regcache_cache_only(es8326->regmap, true);
 	regcache_mark_dirty(es8326->regmap);
 
+	/* reset register value to default */
+	regmap_write(es8326->regmap, ES8326_CSM_I2C_STA, 0x01);
+	usleep_range(1000, 3000);
+	regmap_write(es8326->regmap, ES8326_CSM_I2C_STA, 0x00);
 	return 0;
 }
 
@@ -717,7 +758,7 @@ static int es8326_probe(struct snd_soc_component *component)
 	ret = device_property_read_u8(component->dev, "everest,jack-pol", &es8326->jack_pol);
 	if (ret != 0) {
 		dev_dbg(component->dev, "jack-pol return %d", ret);
-		es8326->jack_pol = ES8326_HP_DET_BUTTON_POL | ES8326_HP_TYPE_OMTP;
+		es8326->jack_pol = ES8326_HP_TYPE_AUTO;
 	}
 	dev_dbg(component->dev, "jack-pol %x", es8326->jack_pol);
 
diff --git a/sound/soc/codecs/es8326.h b/sound/soc/codecs/es8326.h
index cd04d11a88d96a..90a08351d6acd0 100644
--- a/sound/soc/codecs/es8326.h
+++ b/sound/soc/codecs/es8326.h
@@ -160,6 +160,13 @@
 #define ES8326_HP_TYPE_AUTO	(1 << 0)
 #define ES8326_HP_TYPE_AUTO_INV	(0 << 0)
 
+/* ES8326_INT_SOURCE */
+#define ES8326_INT_SRC_DAC_MOZ (1 << 0)
+#define ES8326_INT_SRC_ADC_MOZ (1 << 1)
+#define ES8326_INT_SRC_BUTTON (1 << 2)
+#define ES8326_INT_SRC_PIN9 (1 << 3)
+#define ES8326_INT_SRC_PIN27 (1 << 4)
+
 /* ES8326_SDINOUT1_IO */
 #define ES8326_IO_INPUT	(0 << 0)
 #define ES8326_IO_SDIN_SLOT0 (1 << 0)
@@ -183,6 +190,7 @@
 #define ES8326_HPBUTTON_FLAG (1 << 0)
 
 /* ES8326_CHIP_VERSION 0xFF */
-#define ES8326_VERSION_B (1 << 0)
+#define ES8326_VERSION (1 << 0)
+#define ES8326_VERSION_B (3 << 0)
 
 #endif
-- 
2.33.8


