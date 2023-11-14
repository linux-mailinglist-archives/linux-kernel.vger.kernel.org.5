Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386AC7EB318
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjKNPJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKNPJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:09:36 -0500
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 07:09:32 PST
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [IPv6:2001:41d0:203:375::b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3B118A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:09:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699974138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjLEQ2aBUBcn+Sqc95rmrPoW3NH5ZZ26cu6iyzwpGc0=;
        b=kuURKlYbDIZkkE2VlZVqW0eLF4/yKYOCNNFEuflSWrkD8XOv6U9BWn3iVZmIUtoJqSidkD
        tHAtBcRbv/f+SkUPe+gNkccy0E/Nv7Yd/65IhYW7jtAtFcDG5baoSGFxCLWjC+195kewFe
        Ihq1rL5hTg0Go/FFQ+xyAE9m8Z5jvmw=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 5/8] drm/bridge: it66121: Add a helper function to read chip id
Date:   Tue, 14 Nov 2023 23:01:27 +0800
Message-Id: <20231114150130.497915-6-sui.jingfeng@linux.dev>
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

Read the required chip id data back by calling regmap_bulk_read() once,
reduce the number of local variables needed in it66121_probe() function.
And store its values into struct it66121_ctx, as it will be used latter.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 47 ++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 7e473beefc79..f36d05331f25 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -313,6 +313,9 @@ struct it66121_ctx {
 		bool auto_cts;
 	} audio;
 	const struct it66121_chip_info *info;
+	u16 vender_id;
+	u16 device_id;
+	u8 revision;
 };
 
 static inline struct it66121_ctx *bridge_to_it66121(struct drm_bridge *bridge)
@@ -399,6 +402,30 @@ static void it66121_hw_reset(struct it66121_ctx *ctx)
 	gpiod_set_value(ctx->gpio_reset, 0);
 }
 
+static int it66121_read_chip_id(struct it66121_ctx *ctx, bool verbose)
+{
+	u8 id[4];
+	int ret;
+
+	ret = regmap_bulk_read(ctx->regmap, IT66121_VENDOR_ID0_REG, id, 4);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to read chip ID: %d\n", ret);
+		return ret;
+	}
+
+	ctx->vender_id = (u16)id[1] << 8 | id[0];
+	ctx->device_id = ((u16)(id[3] & IT66121_DEVICE_ID1_MASK) << 8 | id[2]);
+	/* Revision is shared with DEVICE_ID1 */
+	ctx->revision = FIELD_GET(IT66121_REVISION_MASK, id[3]);
+
+	if (verbose) {
+		dev_info(ctx->dev, "Found ITE66121: 0x%x%x, revision: %u\n",
+			 ctx->vender_id, ctx->device_id, ctx->revision);
+	}
+
+	return 0;
+}
+
 static inline int it66121_preamble_ddc(struct it66121_ctx *ctx)
 {
 	return regmap_write(ctx->regmap, IT66121_MASTER_SEL_REG, IT66121_MASTER_SEL_HOST);
@@ -1561,7 +1588,6 @@ static const char * const it66121_supplies[] = {
 
 static int it66121_probe(struct i2c_client *client)
 {
-	u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
 	int ret;
 	struct it66121_ctx *ctx;
 	struct device *dev = &client->dev;
@@ -1603,19 +1629,13 @@ static int it66121_probe(struct i2c_client *client)
 	if (IS_ERR(ctx->regmap))
 		return PTR_ERR(ctx->regmap);
 
-	regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
-	regmap_read(ctx->regmap, IT66121_VENDOR_ID1_REG, &vendor_ids[1]);
-	regmap_read(ctx->regmap, IT66121_DEVICE_ID0_REG, &device_ids[0]);
-	regmap_read(ctx->regmap, IT66121_DEVICE_ID1_REG, &device_ids[1]);
-
-	/* Revision is shared with DEVICE_ID1 */
-	revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
-	device_ids[1] &= IT66121_DEVICE_ID1_MASK;
+	ret = it66121_read_chip_id(ctx, false);
+	if (ret)
+		return ret;
 
-	if ((vendor_ids[1] << 8 | vendor_ids[0]) != ctx->info->vid ||
-	    (device_ids[1] << 8 | device_ids[0]) != ctx->info->pid) {
+	if (ctx->vender_id != ctx->info->vid ||
+	    ctx->device_id != ctx->info->pid)
 		return -ENODEV;
-	}
 
 	ctx->bridge.funcs = &it66121_bridge_funcs;
 	ctx->bridge.of_node = dev->of_node;
@@ -1633,7 +1653,8 @@ static int it66121_probe(struct i2c_client *client)
 
 	drm_bridge_add(&ctx->bridge);
 
-	dev_info(dev, "IT66121 revision %d probed\n", revision_id);
+	dev_info(dev, "IT66121 probed, chip id: 0x%x:0x%x, revision: %u\n",
+		 ctx->vender_id, ctx->device_id, ctx->revision);
 
 	return 0;
 }
-- 
2.34.1

