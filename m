Return-Path: <linux-kernel+bounces-148150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4828A7E58
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2F71C20B96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027A131BD3;
	Wed, 17 Apr 2024 08:31:42 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69A12AAC9;
	Wed, 17 Apr 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342701; cv=none; b=FtFzKO6Cq5xCHh+S68Lj2lP/JSXg+JKS2Uv2E1aYRnYUyfXYUdH9WBpiQ5BuAHhJ/bBQpLh31PJKD4HiN2caWS39e+89jfPOl+UdyYKzRL+i0hONIarkY5y+H7+e7Ngb4YXaGFlsxjbyD2ZCxNjVSwUjebSIC8mJsDy3QLBbK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342701; c=relaxed/simple;
	bh=+bEdZI+oqNRE5k0Z3cA3o73P6RKiwrxwMuXHvScmwCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBNb7/bVlF6CGpAmhcij5npG8DkNCJmyIngtaRoT/R6/572FNTJPUAaKFep94Br1/SzGGXa/RJyV7MncUjsC0VjIlCFlhem5cjZDK5/5kCOGYHKG+3wr+DpTj4L0wHOmxQ7WvGXGvOwqQosiGs3uTyLOQPd4KmYLs1JCut7X9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 23FF62F2028A; Wed, 17 Apr 2024 08:31:34 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 9491C2F20248;
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
Subject: [PATCH 6.1.y 6/6] ASoC: codecs: ES8326: Update jact detection function
Date: Wed, 17 Apr 2024 11:31:16 +0300
Message-Id: <20240417083116.608610-7-kovalev@altlinux.org>
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

Commit 04f96c9340463aae20d2511a3d6cb0b005b07d24 upstream.

The old jack detection function only supports fixed OMTP/CTIA
hardware connection. The new one supports auto OMTP/CTIA
headset detection

Signed-off-by: Zhu Ning <zhuning0077@gmail.com>
Link: https://lore.kernel.org/r/20230717033223.42506-5-zhuning0077@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/soc/codecs/es8326.c | 109 +++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index eda0e53a1d8e43..bee505b5fa0b68 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -41,6 +41,8 @@ struct es8326_priv {
 
 	bool calibrated;
 	int version;
+	int hp;
+	int jack_remove_retry;
 };
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(dac_vol_tlv, -9550, 50, 0);
@@ -535,6 +537,7 @@ static void es8326_jack_button_handler(struct work_struct *work)
 		cur_button = SND_JACK_BTN_0;
 		break;
 	case 0x6f:
+	case 0x4b:
 		/* button volume up */
 		cur_button = SND_JACK_BTN_1;
 		break;
@@ -543,6 +546,7 @@ static void es8326_jack_button_handler(struct work_struct *work)
 		cur_button = SND_JACK_BTN_2;
 		break;
 	case 0x1e:
+	case 0xe2:
 		/* button released or not pressed */
 		cur_button = 0;
 		break;
@@ -552,20 +556,20 @@ static void es8326_jack_button_handler(struct work_struct *work)
 
 	if ((prev_button == cur_button) && (cur_button != 0)) {
 		press_count++;
-		if (press_count > 10) {
-			/* report a press every 500ms */
+		if (press_count > 3) {
+			/* report a press every 120ms */
 			snd_soc_jack_report(es8326->jack, cur_button,
 					SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2);
 			press_count = 0;
 		}
 		button_to_report = cur_button;
 		queue_delayed_work(system_wq, &es8326->button_press_work,
-				   msecs_to_jiffies(50));
+				   msecs_to_jiffies(35));
 	} else if (prev_button != cur_button) {
 		/* mismatch, detect again */
 		prev_button = cur_button;
 		queue_delayed_work(system_wq, &es8326->button_press_work,
-				   msecs_to_jiffies(50));
+				   msecs_to_jiffies(35));
 	} else {
 		/* released or no pressed */
 		if (button_to_report != 0) {
@@ -589,32 +593,96 @@ static void es8326_jack_detect_handler(struct work_struct *work)
 	mutex_lock(&es8326->lock);
 	iface = snd_soc_component_read(comp, ES8326_HPDET_STA);
 	dev_dbg(comp->dev, "gpio flag %#04x", iface);
+
+	if (es8326->jack_remove_retry == 1) {
+		if (iface & ES8326_HPINSERT_FLAG)
+			es8326->jack_remove_retry = 2;
+		else
+			es8326->jack_remove_retry = 0;
+
+		dev_dbg(comp->dev, "remove event check, set HPJACK_POL normal, cnt = %d\n",
+				es8326->jack_remove_retry);
+		/*
+		 * Inverted HPJACK_POL bit to trigger one IRQ to double check HP Removal event
+		 */
+		regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE,
+					ES8326_HP_DET_JACK_POL, (es8326->jd_inverted ?
+					~es8326->jack_pol : es8326->jack_pol));
+		goto exit;
+	}
+
 	if ((iface & ES8326_HPINSERT_FLAG) == 0) {
 		/* Jack unplugged or spurious IRQ */
-		dev_dbg(comp->dev, "No headset detected");
+		dev_dbg(comp->dev, "No headset detected\n");
+		es8326_disable_micbias(es8326->component);
 		if (es8326->jack->status & SND_JACK_HEADPHONE) {
+			dev_dbg(comp->dev, "Report hp remove event\n");
 			snd_soc_jack_report(es8326->jack, 0, SND_JACK_HEADSET);
-			snd_soc_component_write(comp, ES8326_ADC1_SRC, es8326->mic2_src);
-			es8326_disable_micbias(comp);
+			/* mute adc when mic path switch */
+			regmap_write(es8326->regmap, ES8326_ADC_SCALE, 0x33);
+			regmap_write(es8326->regmap, ES8326_ADC1_SRC, 0x44);
+			regmap_write(es8326->regmap, ES8326_ADC2_SRC, 0x66);
+			es8326->hp = 0;
+		}
+		regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x01);
+		/*
+		 * Inverted HPJACK_POL bit to trigger one IRQ to double check HP Removal event
+		 */
+		if (es8326->jack_remove_retry == 0) {
+			es8326->jack_remove_retry = 1;
+			dev_dbg(comp->dev, "remove event check, invert HPJACK_POL, cnt = %d\n",
+					es8326->jack_remove_retry);
+			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE,
+					ES8326_HP_DET_JACK_POL, (es8326->jd_inverted ?
+					es8326->jack_pol : ~es8326->jack_pol));
+
+		} else {
+			es8326->jack_remove_retry = 0;
 		}
 	} else if ((iface & ES8326_HPINSERT_FLAG) == ES8326_HPINSERT_FLAG) {
+		es8326->jack_remove_retry = 0;
+		if (es8326->hp == 0) {
+			dev_dbg(comp->dev, "First insert, start OMTP/CTIA type check\n");
+			/*
+			 * set auto-check mode, then restart jack_detect_work after 100ms.
+			 * Don't report jack status.
+			 */
+			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x01);
+			usleep_range(50000, 70000);
+			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x00);
+			queue_delayed_work(system_wq, &es8326->jack_detect_work,
+					msecs_to_jiffies(100));
+			es8326->hp = 1;
+			goto exit;
+		}
 		if (es8326->jack->status & SND_JACK_HEADSET) {
 			/* detect button */
+			dev_dbg(comp->dev, "button pressed\n");
 			queue_delayed_work(system_wq, &es8326->button_press_work, 10);
+			goto exit;
+		}
+		if ((iface & ES8326_HPBUTTON_FLAG) == 0x01) {
+			dev_dbg(comp->dev, "Headphone detected\n");
+			snd_soc_jack_report(es8326->jack,
+					SND_JACK_HEADPHONE, SND_JACK_HEADSET);
 		} else {
-			if ((iface & ES8326_HPBUTTON_FLAG) == 0x00) {
-				dev_dbg(comp->dev, "Headset detected");
-				snd_soc_jack_report(es8326->jack,
-						    SND_JACK_HEADSET, SND_JACK_HEADSET);
-				snd_soc_component_write(comp,
-							ES8326_ADC1_SRC, es8326->mic1_src);
-			} else {
-				dev_dbg(comp->dev, "Headphone detected");
-				snd_soc_jack_report(es8326->jack,
-						    SND_JACK_HEADPHONE, SND_JACK_HEADSET);
-			}
+			dev_dbg(comp->dev, "Headset detected\n");
+			snd_soc_jack_report(es8326->jack,
+					SND_JACK_HEADSET, SND_JACK_HEADSET);
+
+			regmap_write(es8326->regmap, ES8326_ADC_SCALE, 0x33);
+			regmap_update_bits(es8326->regmap, ES8326_PGA_PDN,
+					0x08, 0x08);
+			regmap_update_bits(es8326->regmap, ES8326_PGAGAIN,
+					0x80, 0x80);
+			regmap_write(es8326->regmap, ES8326_ADC1_SRC, 0x00);
+			regmap_write(es8326->regmap, ES8326_ADC2_SRC, 0x00);
+			regmap_update_bits(es8326->regmap, ES8326_PGA_PDN,
+					0x08, 0x00);
+			usleep_range(10000, 15000);
 		}
 	}
+exit:
 	mutex_unlock(&es8326->lock);
 }
 
@@ -633,7 +701,7 @@ static irqreturn_t es8326_irq(int irq, void *dev_id)
 				   msecs_to_jiffies(10));
 	else
 		queue_delayed_work(system_wq, &es8326->jack_detect_work,
-				   msecs_to_jiffies(300));
+				   msecs_to_jiffies(600));
 
 out:
 	return IRQ_HANDLED;
@@ -763,7 +831,8 @@ static int es8326_resume(struct snd_soc_component *component)
 			(ES8326_HP_DET_SRC_PIN9 | es8326->jack_pol) :
 			(ES8326_HP_DET_SRC_PIN9 | es8326->jack_pol | 0x04)));
 
-	es8326_irq(es8326->irq, es8326);
+	es8326->jack_remove_retry = 0;
+	es8326->hp = 0;
 	return 0;
 }
 
-- 
2.33.8


