Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D147A36E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbjIQRiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbjIQRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:37:51 -0400
Received: from out-229.mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7ADF1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:37:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694972264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzvX1zNT0X0Pb7ZYawRW0ysAeQBR279Tmloz2NWjDB8=;
        b=qMxNLiGgGTdCdti8zhfkaqKth8mGdP7i+e3GuWFeV0khatQpRSdJg74+gSffSHPQXRSIBt
        QYyKRwvMOZ4AiHpf50+fDrMwXJUhxndEf6XPS1iqNImvgxAIdRGJGzTfUPH6iz1KGdP9Q5
        Cnvmt9X8NT/aqdwyFFLlFb7AuzmJZWOfHkh9FoHZuQsLXgHmf3bMZgEsOXb9kidZQQNkHv
        +brOrbdY+ajdjtGtRlx49FEBPQ317PT7UuhPkWfnMLpZR2l2lbk66l52KR2GYJ9VyzFEGJ
        Fp3vaDWMpb5vcj3mM0y1cb6Am4hK/bSOEEEicTvqxKI1z9B//7FAvZucxSr1Zg==
From:   John Watts <contact@jookia.org>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, John Watts <contact@jookia.org>,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ASoC: wm8782: Constrain maximum audio rate at runtime
Date:   Mon, 18 Sep 2023 03:37:24 +1000
Message-ID: <20230917173726.1916439-2-contact@jookia.org>
In-Reply-To: <20230917173726.1916439-1-contact@jookia.org>
References: <20230917173726.1916439-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm8782 supports up to 192kHz audio when pins are set correctly.
Instead of hardcoding which rates are supported constrain them at
runtime based on a max_rate variable.

Signed-off-by: John Watts <contact@jookia.org>
---
 sound/soc/codecs/wm8782.c | 42 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 95ff4339d103..f3dc87b92b1e 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -23,6 +23,27 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+/* regulator power supply names */
+static const char *supply_names[] = {
+	"Vdda", /* analog supply, 2.7V - 3.6V */
+	"Vdd",  /* digital supply, 2.7V - 5.5V */
+};
+
+struct wm8782_priv {
+	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
+	int max_rate;
+};
+
+static int wm8782_dai_startup(struct snd_pcm_substream *sub, struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = sub->runtime;
+	struct wm8782_priv *priv =
+		snd_soc_component_get_drvdata(dai->component);
+
+	return snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE,
+					   8000, priv->max_rate);
+}
+
 static const struct snd_soc_dapm_widget wm8782_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("AINL"),
 SND_SOC_DAPM_INPUT("AINR"),
@@ -33,28 +54,22 @@ static const struct snd_soc_dapm_route wm8782_dapm_routes[] = {
 	{ "Capture", NULL, "AINR" },
 };
 
+static const struct snd_soc_dai_ops wm8782_dai_ops = {
+	.startup = &wm8782_dai_startup,
+};
+
 static struct snd_soc_dai_driver wm8782_dai = {
 	.name = "wm8782",
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 2,
 		.channels_max = 2,
-		/* For configurations with FSAMPEN=0 */
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE |
 			   SNDRV_PCM_FMTBIT_S20_3LE |
 			   SNDRV_PCM_FMTBIT_S24_LE,
 	},
-};
-
-/* regulator power supply names */
-static const char *supply_names[] = {
-	"Vdda", /* analog supply, 2.7V - 3.6V */
-	"Vdd",  /* digital supply, 2.7V - 5.5V */
-};
-
-struct wm8782_priv {
-	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
+	.ops = &wm8782_dai_ops,
 };
 
 static int wm8782_soc_probe(struct snd_soc_component *component)
@@ -121,6 +136,9 @@ static int wm8782_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	/* For configurations with FSAMPEN=0 */
+	priv->max_rate = 48000;
+
 	return devm_snd_soc_register_component(&pdev->dev,
 			&soc_component_dev_wm8782, &wm8782_dai, 1);
 }
-- 
2.42.0

