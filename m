Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB8C7EB321
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjKNPJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjKNPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:09:37 -0500
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909E6198
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:09:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699974131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnL8rRLdhxEUHMmzuPbpEqxboZkciFsFzGYdTqdV4zg=;
        b=PKDm94kMbgxgRSLDoJDDSVLVgpcMTPt7BhKDKq9u6fu0bN01BjveNYWGPsleYtML9yc6Vd
        eKvVW8SN4uT1AYUPGnTKzuZUQsbFIhPRfNrOrlPK588nvpPe3PyohC6pRUszauqnKiTdjK
        GJIH4tNSxWQ8DotrzwByn2N/K9Jo9og=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 3/8] drm/bridge: it66121: Add a helper function to read bus width
Date:   Tue, 14 Nov 2023 23:01:25 +0800
Message-Id: <20231114150130.497915-4-sui.jingfeng@linux.dev>
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

Group those relavent code lines (which with common purpose) into one helper
function, suppress the dependency on DT to function level. Just trivial
cleanup, no functional change.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 32 ++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 83dbdbfc9ed8..0f78737adc83 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -320,6 +320,26 @@ static inline struct it66121_ctx *bridge_to_it66121(struct drm_bridge *bridge)
 	return container_of(bridge, struct it66121_ctx, bridge);
 }
 
+static int it66121_of_read_bus_width(struct device *dev, u32 *bus_width)
+{
+	struct device_node *np;
+	u32 bw;
+
+	np = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
+	if (!np)
+		return -EINVAL;
+
+	of_property_read_u32(np, "bus-width", &bw);
+	of_node_put(np);
+
+	if (bw != 12 && bw != 24)
+		return -EINVAL;
+
+	*bus_width = bw;
+
+	return 0;
+}
+
 static const struct regmap_range_cfg it66121_regmap_banks[] = {
 	{
 		.name = "it66121",
@@ -1525,19 +1545,13 @@ static int it66121_probe(struct i2c_client *client)
 	if (!ctx)
 		return -ENOMEM;
 
-	ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
-	if (!ep)
-		return -EINVAL;
-
 	ctx->dev = dev;
 	ctx->client = client;
 	ctx->info = i2c_get_match_data(client);
 
-	of_property_read_u32(ep, "bus-width", &ctx->bus_width);
-	of_node_put(ep);
-
-	if (ctx->bus_width != 12 && ctx->bus_width != 24)
-		return -EINVAL;
+	ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
+	if (ret)
+		return ret;
 
 	ep = of_graph_get_remote_node(dev->of_node, 1, -1);
 	if (!ep) {
-- 
2.34.1

