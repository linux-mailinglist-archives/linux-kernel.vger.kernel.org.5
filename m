Return-Path: <linux-kernel+bounces-5433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD7A818AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7218A1F28313
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5037D33;
	Tue, 19 Dec 2023 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kpNGGetV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377D3789F;
	Tue, 19 Dec 2023 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA2D94000E;
	Tue, 19 Dec 2023 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702997687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WiWcy74D30aNuMveYw8b25DRrVXgNKfkfMFNESGJ9/s=;
	b=kpNGGetVkN0bkG/7+B6ioUkNPzkF11LNpB0EUYklvQxNxM2Ee0yXh3j51ywWSyEc/9OCsL
	M8qSKPOScAhXsvmjBvy11zoJCSnRkz/iV5LFS3at3ujLpLCSC2xhRy4j5iSmoufE4pi58B
	VxDlpiXndbIzztY21mkLsExht10oJ+NENgSlKum0HviactbBdPIyPKUUfApomjMiABim7b
	5kUcuveVv977SS4+KqAlCOl+8A62q8suSeSLCzLF+EBH5VAaNVNn+OEeaeyGQjYhS0tyLW
	iXsFceokjiocJjSRv4R1xMoAA2xUFxR56Hr2cTUrX0K6a8M55UWkfpgwXsTDjw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 Dec 2023 15:54:16 +0100
Subject: [PATCH v2 1/6] ASoC: rockchip: i2s-tdm: Fix clk_id usage in
 .set_sysclk()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-rk3308-audio-codec-v2-1-c70d06021946@bootlin.com>
References: <20231219-rk3308-audio-codec-v2-0-c70d06021946@bootlin.com>
In-Reply-To: <20231219-rk3308-audio-codec-v2-0-c70d06021946@bootlin.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: luca.ceresoli@bootlin.com

There are two problems with the second parameter of
rockchip_i2s_tdm_set_sysclk():

 1. The second argument to a .set_sysclk() op is a clk_id, not a stream
    index, so it is incorrect to compare it with SNDRV_PCM_STREAM_PLAYBACK.

    Technically this code works correctly anyway because
    SNDRV_PCM_STREAM_PLAYBACK is defined as 0, which is also the clk_id for
    the mclk_tx as enforced by the device tree bindings. So this is a
    formal error, not triggering incorrect behaviour.

 2. The else branch will consider any nonzero value as "rx", while only
    value 1 should be allowed for the mclk_rx clock. This does trigger
    incorrect behaviour if passing clk_id not equal to 0 or 1.

Fix problem 1 by adding a new enum for the clock indexes as enforced in
device tree and replace accordingly:

 * stream -> clk_id
 * SNDRV_PCM_STREAM_PLAYBACK -> CLK_MCLK_TX (value 0)

Fix problem 2 by returning error if clk_id is not 0 or 1.

Also simplify and improve dev_dbg() messages.

Fixes: 081068fd6414 ("ASoC: rockchip: add support for i2s-tdm controller")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v2:
 - use switch statement instead of if/then/else
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 860e66ec85e8..35b36aa3b970 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -32,6 +32,9 @@
 #define TRCM_TX 1
 #define TRCM_RX 2
 
+/* Clock indexes as enforced by the DT bindings */
+enum { CLK_IDX_MCLK_TX, CLK_IDX_MCLK_RX };
+
 struct txrx_config {
 	u32 addr;
 	u32 reg;
@@ -973,7 +976,7 @@ static int rockchip_i2s_tdm_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int stream,
+static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
 				       unsigned int freq, int dir)
 {
 	struct rk_i2s_tdm_dev *i2s_tdm = to_info(cpu_dai);
@@ -982,15 +985,22 @@ static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int stream,
 	if (i2s_tdm->clk_trcm) {
 		i2s_tdm->mclk_tx_freq = freq;
 		i2s_tdm->mclk_rx_freq = freq;
+
+		dev_dbg(i2s_tdm->dev, "mclk freq: %u", freq);
 	} else {
-		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		switch (clk_id) {
+		case CLK_IDX_MCLK_TX:
 			i2s_tdm->mclk_tx_freq = freq;
-		else
+			break;
+		case CLK_IDX_MCLK_RX:
 			i2s_tdm->mclk_rx_freq = freq;
-	}
+			break;
+		default:
+			return -ENOTSUPP;
+		}
 
-	dev_dbg(i2s_tdm->dev, "The target mclk_%s freq is: %d\n",
-		stream ? "rx" : "tx", freq);
+		dev_dbg(i2s_tdm->dev, "mclk[%d] freq: %u", clk_id, freq);
+	}
 
 	return 0;
 }

-- 
2.34.1


