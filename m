Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24B7EB316
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjKNPJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjKNPJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:09:36 -0500
X-Greylist: delayed 455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 07:09:32 PST
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16925123
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:09:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699974142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tk2pBXgQD0Hn7zpS98T/yj1apxuqc9nh5y9T0ytNhnY=;
        b=IG+qX9fhNU13FWEzeAZz9CPbGXv4Uly+pxQorlItWtMm/A+Gg8MLaKRo/b7sILbTskuT8o
        4kIPnkiw7jtyV9we+sG8iA5WJrI4dONftKCvJ5peYK7Z5SVLke//m+V7D1J4WernaPkb2k
        vMg9KunawNFPE+bT756aiR/b3oyM738=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 6/8] drm/bridge: it66121: Add a helper to initialize the DRM bridge structure
Date:   Tue, 14 Nov 2023 23:01:28 +0800
Message-Id: <20231114150130.497915-7-sui.jingfeng@linux.dev>
In-Reply-To: <20231114150130.497915-1-sui.jingfeng@linux.dev>
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Helps the it66121_probe() function to reduce weight, no functional change.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index f36d05331f25..2f7f00f1bedb 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1004,6 +1004,21 @@ static const struct drm_bridge_funcs it66121_bridge_funcs = {
 	.hpd_disable = it66121_bridge_hpd_disable,
 };
 
+static void it66121_bridge_init_base(struct drm_bridge *bridge,
+				     struct device_node *of_node,
+				     bool hpd_support)
+{
+	bridge->funcs = &it66121_bridge_funcs;
+	bridge->type = DRM_MODE_CONNECTOR_HDMIA;
+	bridge->ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	if (hpd_support)
+		bridge->ops |= DRM_BRIDGE_OP_HPD;
+
+	bridge->of_node = of_node;
+
+	drm_bridge_add(bridge);
+}
+
 static irqreturn_t it66121_irq_threaded_handler(int irq, void *dev_id)
 {
 	int ret;
@@ -1637,11 +1652,6 @@ static int it66121_probe(struct i2c_client *client)
 	    ctx->device_id != ctx->info->pid)
 		return -ENODEV;
 
-	ctx->bridge.funcs = &it66121_bridge_funcs;
-	ctx->bridge.of_node = dev->of_node;
-	ctx->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
-	ctx->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
-
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,	it66121_irq_threaded_handler,
 					IRQF_ONESHOT, dev_name(dev), ctx);
 	if (ret < 0) {
@@ -1649,9 +1659,9 @@ static int it66121_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	it66121_audio_codec_init(ctx, dev);
+	it66121_bridge_init_base(&ctx->bridge, dev->of_node, true);
 
-	drm_bridge_add(&ctx->bridge);
+	it66121_audio_codec_init(ctx, dev);
 
 	dev_info(dev, "IT66121 probed, chip id: 0x%x:0x%x, revision: %u\n",
 		 ctx->vender_id, ctx->device_id, ctx->revision);
-- 
2.34.1

