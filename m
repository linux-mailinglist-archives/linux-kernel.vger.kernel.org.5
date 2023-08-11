Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA56779854
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjHKUOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjHKUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:14:34 -0400
X-Greylist: delayed 77093 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 13:14:33 PDT
Received: from out-97.mta1.migadu.com (out-97.mta1.migadu.com [95.215.58.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9E030ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:14:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691784872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhYtgX26LvJBhk6rq6uv3xTzs4w5PTKDtDH5ARnA/4A=;
        b=G3FR1BhYf+QYeepS8uWwGULIaRbKottmRdYsDjusazmWtWiDg8fF5tcuc4FuZXcRMNF2Mo
        ieoy9oUrsQeJSeROCAv/695QGWwCOuZAuV7fs5AWXgdfEsc6UgpJpBjuPRS2Hofz0af/VT
        tmBpbOYnVZpR6BIbJBm8dYGC0gUvtemdTvaRXMkVzbJLGzE4MTaO1SXq/PmfzOvOwrqO9H
        tXOGIlA2GciINGlf4QK/fJ4JFnwS/FO+t48g2Sg9qwwBMjwkhOkNqm5iTPO+TSAU4Rx84E
        dVyExjbZ389fkoZxoqmDquJNbI2ASpqJqqKj3A1P+Sy1ou5RNvSxx8guWMrfog==
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
Subject: [RFC PATCH 2/7] ASoC: sunxi: sun4i-i2s: Use channel-dins device tree property
Date:   Sat, 12 Aug 2023 06:14:01 +1000
Message-ID: <20230811201406.4096210-3-contact@jookia.org>
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

Instead of using DIN pin 0 for all pins, allow changing this using
the device tree property.

As an example:

&i2s2 {
	channel-dins = /bits/ 8 <0 0 1 1 2 2>;
};

This sets channels 0 and 1 to DIN pin 0, channels 1 and 2 to DIN pin 1,
and channels 3 and 4 to DIN pin 3 respectively.

Signed-off-by: John Watts <contact@jookia.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d8f999ecaf05..cf66f21646a4 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -236,8 +236,33 @@ struct sun4i_i2s_clk_div {
 
 static int sun4i_i2s_read_channel_dins(struct device *dev, struct sun4i_i2s *i2s)
 {
+	struct device_node *np = dev->of_node;
+	int max_channels = ARRAY_SIZE(i2s->channel_dins);
+	int ret;
+
 	/* Use DIN pin 0 by default */
 	memset(i2s->channel_dins, 0, sizeof(i2s->channel_dins));
+
+	if (!np)
+		return 0;
+
+	ret = of_property_read_variable_u8_array(np, "channel-dins",
+						 i2s->channel_dins,
+						 1, max_channels);
+
+	if (ret == -EINVAL)
+		return 0;
+
+	if (ret < 0)
+		return ret;
+
+	for (int i = 0; i < ret; ++i) {
+		u8 din = i2s->channel_dins[i];
+
+		if (din >= i2s->variant->num_din_pins)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.41.0

