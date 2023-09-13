Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9011779F028
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjIMRQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjIMRQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:16:27 -0400
Received: from out-211.mta0.migadu.com (out-211.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D1DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:16:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694625381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3FeZkXz+JQqXeiU3HazldI8mgv0sJ787/pyCTmTegd4=;
        b=ZFkMudF4vLRf2wwyLkRMjGNESmuzTssdLkRAglApAJ8yPv6gK4CSmiVmSozhR/msO9T1X0
        cwe809Oob+FAKFsjPNz50zFhGBQ6/MCMc1ZqLlbRyDxgja44nq1wiNyMteDtGAob8nGyaR
        5ImsryHJjxA4FjkZpt6MY9Hi3jc7QgOLDHRYjP0oZj9ntRl9OdCRjCGGJTBvNDI7CnYOZx
        FOb9TDIIXM03aX7F+vEO2AP+PNTKhYSIlmGy1TYSmYKNeUMbI0/XCxvfLNV13unO0eurm3
        X5O334si6FTqxRHh0IBJoZ9i+yGS3mhJ6pvlWEJo5n/we4vWKmDit3H4xCe/Rg==
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
Subject: [PATCH v2 2/3] ASoC: wm8782: Use wlf,fsampen device tree property
Date:   Thu, 14 Sep 2023 03:15:51 +1000
Message-ID: <20230913171552.92252-3-contact@jookia.org>
In-Reply-To: <20230913171552.92252-1-contact@jookia.org>
References: <20230913171552.92252-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm8782 supports rates 96kHz and 192kHz as long as the hardware
is configured properly. Allow this to be specified in the device tree.

Signed-off-by: John Watts <contact@jookia.org>
---
 sound/soc/codecs/wm8782.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 63ab63f3189a..249b58b093d6 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -122,8 +122,9 @@ static const struct snd_soc_component_driver soc_component_dev_wm8782 = {
 static int wm8782_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct wm8782_priv *priv;
-	int ret, i;
+	int ret, i, fsampen;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -139,8 +140,26 @@ static int wm8782_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	/* For configurations with FSAMPEN=0 */
-	priv->max_rate = 48000;
+	// Assume lowest value by default to avoid inadvertent overclocking
+	fsampen = 0;
+
+	if (np)
+		of_property_read_u32(np, "wlf,fsampen", &fsampen);
+
+	switch (fsampen) {
+	case 0:
+		priv->max_rate = 48000;
+		break;
+	case 1:
+		priv->max_rate = 96000;
+		break;
+	case 2:
+		priv->max_rate = 192000;
+		break;
+	default:
+		dev_err(dev, "Invalid wlf,fsampen value");
+		return -EINVAL;
+	}
 
 	return devm_snd_soc_register_component(&pdev->dev,
 			&soc_component_dev_wm8782, &wm8782_dai, 1);
-- 
2.42.0

