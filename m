Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14CE7783CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjHJWt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjHJWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:49:56 -0400
Received: from out-95.mta0.migadu.com (out-95.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F252D53
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:49:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691707790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWH/gVI2uwLGog9wayY3+Gon/swcoOVqlujmFzUv5MY=;
        b=m0z6cPN5yIKtAfUFKRi5hoLxNWAqVdrpSlpIF3O8XoWF+UM/oyPodVa9TB3ff5yFHjDXdJ
        Fw5bR8UmYBmhG0IJ6KIR13Zde1b27f13T/TGtU+sVDj49kbD0Ti8QxLHcRQrIXbCfMXGF7
        Egca2cmOGhvFeFV+TisTCfYI43vTwpJlAbshHAmka9w5fdzSH+N+svhnUOFTolmrCAdc6f
        77b2s3f98qk7spjBnaM+5DjwmwZEdvOtuIO2UlrkpiKkmLniy/JyXG+xElQVmSlOFxRiE3
        TLoSDZ+mh8QigcmkMbF2gJC1AEEEA0jJx4y3BWaso0TPJKScp6y++vfswy3TPg==
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
Subject: [PATCH 2/3] ASoC: wm8782: Use max-rate device tree property
Date:   Fri, 11 Aug 2023 08:49:29 +1000
Message-ID: <20230810224930.3216717-3-contact@jookia.org>
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

The wm8782 supports rates 96kHz and 192kHz as long as the hardware
is configured properly. Allow this to be specified in the device tree.

Signed-off-by: John Watts <contact@jookia.org>
---
 sound/soc/codecs/wm8782.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 63ab63f3189a..6a2f29ee897c 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -122,6 +122,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm8782 = {
 static int wm8782_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct wm8782_priv *priv;
 	int ret, i;
 
@@ -139,9 +140,12 @@ static int wm8782_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	/* For configurations with FSAMPEN=0 */
+	/* Assume lowest value by default to avoid inadvertent overclocking */
 	priv->max_rate = 48000;
 
+	if (np)
+		of_property_read_u32(np, "max-rate", &priv->max_rate);
+
 	return devm_snd_soc_register_component(&pdev->dev,
 			&soc_component_dev_wm8782, &wm8782_dai, 1);
 }
-- 
2.41.0

