Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928B07EB31A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjKNPJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjKNPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:09:37 -0500
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F4B1A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:09:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699974134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m5kKprLLEL4tPCbX40jldFRROJifNOVhztsTzbLcjYw=;
        b=WyS6P1AXayZo5bIYUZyFvxH6Pcx9HWuPhtPw37v8O/C66WjCM/UsZI7uLcPBQhHcgaFult
        iAcTH0nqI4aF7oSAFTboO7pyfc69AuLknUW9GM/uJkXUWSgMdgnBcNGGZ9brJwJvjYiGsZ
        OuC9XAyhhLHvBgL2h19yod6bgx6jhXg=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 4/8] drm/bridge: it66121: Add a helper function to get the next bridge
Date:   Tue, 14 Nov 2023 23:01:26 +0800
Message-Id: <20231114150130.497915-5-sui.jingfeng@linux.dev>
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

Group the code lines(which with the same functional) into one dedicated
function, which reduce the weight of it66121_probe() function. Just trivial
cleanuo, no functional change.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 53 ++++++++++++++++++----------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 0f78737adc83..7e473beefc79 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -340,6 +340,37 @@ static int it66121_of_read_bus_width(struct device *dev, u32 *bus_width)
 	return 0;
 }
 
+static int it66121_of_get_next_bridge(struct device *dev,
+				      struct drm_bridge **next_bridge)
+{
+	struct device_node *np;
+	struct drm_bridge *bridge;
+
+	np = of_graph_get_remote_node(dev->of_node, 1, -1);
+	if (!np) {
+		dev_err(dev, "The endpoint is unconnected\n");
+		return -EINVAL;
+	}
+
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		dev_err(dev, "The remote device is disabled\n");
+		return -ENODEV;
+	}
+
+	bridge = of_drm_find_bridge(np);
+	of_node_put(np);
+
+	if (!bridge) {
+		dev_dbg(dev, "Next bridge not found, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
+
+	*next_bridge = bridge;
+
+	return 0;
+}
+
 static const struct regmap_range_cfg it66121_regmap_banks[] = {
 	{
 		.name = "it66121",
@@ -1531,7 +1562,6 @@ static const char * const it66121_supplies[] = {
 static int it66121_probe(struct i2c_client *client)
 {
 	u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
-	struct device_node *ep;
 	int ret;
 	struct it66121_ctx *ctx;
 	struct device *dev = &client->dev;
@@ -1553,24 +1583,9 @@ static int it66121_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ep = of_graph_get_remote_node(dev->of_node, 1, -1);
-	if (!ep) {
-		dev_err(dev, "The endpoint is unconnected\n");
-		return -EINVAL;
-	}
-
-	if (!of_device_is_available(ep)) {
-		of_node_put(ep);
-		dev_err(dev, "The remote device is disabled\n");
-		return -ENODEV;
-	}
-
-	ctx->next_bridge = of_drm_find_bridge(ep);
-	of_node_put(ep);
-	if (!ctx->next_bridge) {
-		dev_dbg(dev, "Next bridge not found, deferring probe\n");
-		return -EPROBE_DEFER;
-	}
+	ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
+	if (ret)
+		return ret;
 
 	i2c_set_clientdata(client, ctx);
 	mutex_init(&ctx->lock);
-- 
2.34.1

