Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83B177985A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbjHKUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbjHKUPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:15:04 -0400
Received: from out-79.mta1.migadu.com (out-79.mta1.migadu.com [95.215.58.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3733584
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:14:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691784898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeLKekQPGIWeXPPUTKz0UKXYLZ76J8hy48F28uG+rX0=;
        b=LToGtkDrOCSOVpZih3iIpGEia0EWeKKZmc8sXDwvIDst79QFhcJMmKPTrN3sDyjY1Wy2V+
        6d5pHC5gzuuL+DV3YeuRE4CYWcZnwxcupNJ3tJ80rEWDQ6JfN4SLY7DiGJYwKfqWtUjjJo
        hlQ3qR7G7/W+ktYvQSU1ELwD75mHRMwo2GrfLValj+Rr+pHqoyjnO1uKCyC4tQbuSZ0b23
        oJrlGZFLUvH42hPAC5gr/y6pY7gbYWeaM2Q7ApnKbPjjkWEH2BueC6PRj0KLdKAGt0IrlZ
        4qb39dtKKzPT7NmuAjpPVfonV6xd//g4n3/p05BnPMSkG5/Ihe01O7RRs5AdGw==
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
Subject: [RFC PATCH 5/7] ASoC: sunxi: sun4i-i2s: Detect TDM slots based on channel slots
Date:   Sat, 12 Aug 2023 06:14:04 +1000
Message-ID: <20230811201406.4096210-6-contact@jookia.org>
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

The current controller code assumes a 1:1 relationship between audio
channel and TDM slot. This may not be the case when slots are set
explicitly. Instead figure out how many slots we need based on the
number of slots used in the channel map.

This allows the case of reading multiple data pins on a single slot.

Signed-off-by: John Watts <contact@jookia.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 019a4856c90b..6347aaaed016 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -271,6 +271,7 @@ static int sun4i_i2s_read_channel_slots(struct device *dev, struct sun4i_i2s *i2
 {
 	struct device_node *np = dev->of_node;
 	int max_channels = ARRAY_SIZE(i2s->channel_dins);
+	int slot_max;
 	int ret;
 
 	/* Use a 1:1 mapping by default */
@@ -290,6 +291,16 @@ static int sun4i_i2s_read_channel_slots(struct device *dev, struct sun4i_i2s *i2
 	if (ret < 0)
 		return ret;
 
+	for (int i = 0; i < ret; ++i) {
+		int slot = i2s->channel_slots[i];
+
+		if (slot_max < slot)
+			slot_max = slot;
+	}
+
+	/* Add 1 to be inclusive of slot 0 */
+	i2s->slots = slot_max + 1;
+
 	return 0;
 }
 
-- 
2.41.0

