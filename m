Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7927A36E9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbjIQRiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjIQRiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:38:00 -0400
Received: from out-227.mta1.migadu.com (out-227.mta1.migadu.com [95.215.58.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8698D97
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:37:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694972270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N323SG+p/mVo7ES7cWOerqa91xnNuXKTdwM6oN1zMZo=;
        b=g4yyBsTrB3fseLbnLyD7Kvsv9dd1GO321DCOd9vwtDJ3KLOkGHstcPcRRmPiO/W3mswFs0
        /IQ/7PJ8PafN3aG1Vu+Upx+2ZtzCaUvPPJoCqO9Kr5Bw5liM4cEXZBeAzoUbmg8F5eDgrf
        OdXPyQpWYNScywJbVSGE3yuZJKrDceb+MbQMB4RUXx0QqLFByAcDEtb0m4r8rZZxUvOrKC
        n/l7mAP8YiCe2LTvLu/pHuDUYeumbCEmmdrYs9i3sFbKIEjK/wytJDXtfGMk48pL5mY1EL
        bJ9BXykGRgneS5ztS+z22g4oS5AHB9MXsb+IVPAanIGAs/ycTFyx0pEJIzIu/g==
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
Subject: [PATCH v3 2/3] ASoC: wm8782: Use wlf,fsampen device tree property
Date:   Mon, 18 Sep 2023 03:37:25 +1000
Message-ID: <20230917173726.1916439-3-contact@jookia.org>
In-Reply-To: <20230917173726.1916439-1-contact@jookia.org>
References: <20230917173726.1916439-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index f3dc87b92b1e..3a2acdfa9b85 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -119,8 +119,9 @@ static const struct snd_soc_component_driver soc_component_dev_wm8782 = {
 static int wm8782_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct wm8782_priv *priv;
-	int ret, i;
+	int ret, i, fsampen;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -136,8 +137,26 @@ static int wm8782_probe(struct platform_device *pdev)
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

