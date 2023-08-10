Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6003D7783CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjHJWtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjHJWts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:49:48 -0400
Received: from out-95.mta1.migadu.com (out-95.mta1.migadu.com [IPv6:2001:41d0:203:375::5f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D622710
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:49:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691707785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOt1sdSQzarb5tnZ/esvuAWXN80C1rxnQDdSGkr2tUk=;
        b=01K1Clo5tUXVhOGMDlAbBOlOOwcHAo5RT/lrxTGiIK/AC5POgCHYrmpcisnJD5PzcFj5hv
        dQIbBEM9GPPWfgeIxJRjm27c8VCCcFSczjMcfY9b0Zm2z7X12KN9UgeiBg/nSND71ShynG
        4sb0q/7HBZsQcJx+6xLSgO3E84ngsDkYts7ulTYd9AIQ36TeWnNY0uGD8kx0SOPMbQ7iFz
        cg0QHmOaIJKuaL9LP/LK0gUUC392rni1LmiG8RsIXf7pJPS+X+FehGTc8YFZ2FTvglYg2+
        OHXnDHBO/AvUebXLeGTQxOcPqOS6MOw4ycXcK1gyAzI1I9oY0orH/JbcIXxJZg==
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
Subject: [PATCH 1/3] ASoC: wm8782: Handle maximum audio rate at runtime
Date:   Fri, 11 Aug 2023 08:49:28 +1000
Message-ID: <20230810224930.3216717-2-contact@jookia.org>
In-Reply-To: <20230810224930.3216717-1-contact@jookia.org>
References: <20230810224930.3216717-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm8782 supports up to 192kHz audio when pins are set correctly.
Instead of hardcoding which rates are supported enable them all
then refer to a max_rate variable at runtime.

Signed-off-by: John Watts <contact@jookia.org>
---
 sound/soc/codecs/wm8782.c | 45 ++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 95ff4339d103..63ab63f3189a 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -23,6 +23,30 @@
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
+static int wm8782_dai_hw_params(struct snd_pcm_substream *component,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct wm8782_priv *priv =
+		snd_soc_component_get_drvdata(dai->component);
+
+	if (params_rate(params) > priv->max_rate)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget wm8782_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("AINL"),
 SND_SOC_DAPM_INPUT("AINR"),
@@ -33,28 +57,22 @@ static const struct snd_soc_dapm_route wm8782_dapm_routes[] = {
 	{ "Capture", NULL, "AINR" },
 };
 
+static const struct snd_soc_dai_ops wm8782_dai_ops = {
+	.hw_params = &wm8782_dai_hw_params,
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
@@ -121,6 +139,9 @@ static int wm8782_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	/* For configurations with FSAMPEN=0 */
+	priv->max_rate = 48000;
+
 	return devm_snd_soc_register_component(&pdev->dev,
 			&soc_component_dev_wm8782, &wm8782_dai, 1);
 }
-- 
2.41.0

