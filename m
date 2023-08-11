Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1B1779856
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjHKUOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjHKUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:14:45 -0400
Received: from out-122.mta1.migadu.com (out-122.mta1.migadu.com [IPv6:2001:41d0:203:375::7a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8AB30ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:14:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691784880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KohIP0ksHXxdx+GVUlJOfMvQCC6gcPhr/Z2zQUgwBik=;
        b=b+X1lQvdVhoQYU2XhhOyNGjflc23TRX6lpdQ4j3TVZPlsuUKRMU+OpZQaiDS13YPvo+Gag
        srOdPv0LV4WyVDiGbaOwKk/3WyOs2rlMkTR0lV3mh4EVr0rPjdTAgIvJxr6aaOPBWEh2/X
        nqesEmlNJGzzk6D9VQaz2yT3iRwRBq4rS9h58rGcfz/05bwCfeuo8YweYJqoScg0fw0DDe
        ZqaXU+vo2rLuDoUP1fOskzn8svSeJFPncg0PpgpBHvIpnIihbYRYERlAU8sL1dRIh3pTHO
        HWQ0HeRwYvp3S7Lcge1dubVrRGxaDvUpc6XOqdcdZXu6kYIPajrkAEiFFJXifQ==
From:   John Watts <contact@jookia.org>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, John Watts <contact@jookia.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] ASoC: sunxi: sun4i-i2s: Prepare for runtime channel slot selection
Date:   Sat, 12 Aug 2023 06:14:02 +1000
Message-ID: <20230811201406.4096210-4-contact@jookia.org>
In-Reply-To: <20230811201406.4096210-1-contact@jookia.org>
References: <20230811201406.4096210-1-contact@jookia.org>
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

The sun4i I2S controller supports mapping channels to specific TDM
slots. This is usually done in a 1:1 mapping because there's not
really a reason to re-order the TDM slots in software.

On the R329 and D1 multiplexing can be done using pins as well as
TDM. Here's an example of using 3 pins and 2 slots (left and right):

Channel 0 -> DIN0 -> ADC0, TDM slot 0
Channel 1 -> DIN0 -> ADC0, TDM slot 1
Channel 2 -> DIN1 -> ADC1, TDM slot 0
Channel 3 -> DIN1 -> ADC1, TDM slot 1
Channel 4 -> DIN2 -> ADC2, TDM slot 0
Channel 5 -> DIN2 -> ADC2, TDM slot 1

This connects 3 separate TDM-unaware ADCs to the I2S controller.
Likewise, multiple TDM slots could be used to run two sets of
TDM-aware ADCs on one I2S controller.

Prepare for configurable slot selection by adding a channel to slot
mapping array and using that in the R329 code if we multiple DIN pins.

Signed-off-by: John Watts <contact@jookia.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index cf66f21646a4..627bf319e1cc 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -217,6 +217,7 @@ struct sun4i_i2s {
 	unsigned int	slots;
 	unsigned int	slot_width;
 	u8	channel_dins[16];
+	u8	channel_slots[16];
 
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
@@ -266,6 +267,17 @@ static int sun4i_i2s_read_channel_dins(struct device *dev, struct sun4i_i2s *i2s
 	return 0;
 }
 
+static int sun4i_i2s_read_channel_slots(struct device *dev, struct sun4i_i2s *i2s)
+{
+	int max_channels = ARRAY_SIZE(i2s->channel_dins);
+
+	/* Use a 1:1 mapping by default */
+	for (int i = 0; i < max_channels; ++i)
+		i2s->channel_slots[i] = i;
+
+	return 0;
+}
+
 static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
 	{ .div = 2, .val = 0 },
 	{ .div = 4, .val = 1 },
@@ -570,7 +582,7 @@ static void sun50i_h6_write_channel_map(const struct sun4i_i2s *i2s,
 	for (int i = 3; i >= 0; i--) {
 		int channel = channel_start + i;
 		u8 din = i2s->channel_dins[channel];
-		u8 slot = channel; /* Map slot to channel */
+		u8 slot = i2s->channel_slots[channel];
 
 		reg_value <<= 8;
 		reg_value |= (din << 4) | slot;
@@ -1616,6 +1628,11 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (sun4i_i2s_read_channel_slots(&pdev->dev, i2s)) {
+		dev_err(&pdev->dev, "Invalid channel slots\n");
+		return -EINVAL;
+	}
+
 	i2s->playback_dma_data.addr = res->start +
 					i2s->variant->reg_offset_txdata;
 	i2s->playback_dma_data.maxburst = 8;
-- 
2.41.0

