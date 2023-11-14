Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47A07EB317
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjKNPJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjKNPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:09:37 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A51B6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:09:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699974120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RX2Fmd7n/lPyGrqbFE5Q/i0VXpKAAer+IRR7UyADmdM=;
        b=klKW73kaFsLVaV8jy29fj+SNcq26CObnK9T7ZK0lbfaiZ9pJIWcWc3+wTt5eXRI9KAA9IR
        rUls9elRnQaFDjw61cap3rSDs05hBsnaiPASNuG2NcT5drLy2PiqB1Qa4EAtQDJuokeQSz
        y7hD8OiSWR6bdBFVNwZjIHmcC2KkW3s=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 1/8] drm/bridge: it66121: Use dev replace ctx->dev in the it66121_probe()
Date:   Tue, 14 Nov 2023 23:01:23 +0800
Message-Id: <20231114150130.497915-2-sui.jingfeng@linux.dev>
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

As the value of 'ctx->dev' has already been cached to the local variable
'dev', so keep the usage consistent. Just trivial cleanup, no functional
change.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 1cf3fb1f13dc..6e5c10cfa0bc 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1536,20 +1536,20 @@ static int it66121_probe(struct i2c_client *client)
 
 	ep = of_graph_get_remote_node(dev->of_node, 1, -1);
 	if (!ep) {
-		dev_err(ctx->dev, "The endpoint is unconnected\n");
+		dev_err(dev, "The endpoint is unconnected\n");
 		return -EINVAL;
 	}
 
 	if (!of_device_is_available(ep)) {
 		of_node_put(ep);
-		dev_err(ctx->dev, "The remote device is disabled\n");
+		dev_err(dev, "The remote device is disabled\n");
 		return -ENODEV;
 	}
 
 	ctx->next_bridge = of_drm_find_bridge(ep);
 	of_node_put(ep);
 	if (!ctx->next_bridge) {
-		dev_dbg(ctx->dev, "Next bridge not found, deferring probe\n");
+		dev_dbg(dev, "Next bridge not found, deferring probe\n");
 		return -EPROBE_DEFER;
 	}
 
@@ -1599,7 +1599,7 @@ static int it66121_probe(struct i2c_client *client)
 
 	drm_bridge_add(&ctx->bridge);
 
-	dev_info(ctx->dev, "IT66121 revision %d probed\n", revision_id);
+	dev_info(dev, "IT66121 revision %d probed\n", revision_id);
 
 	return 0;
 }
-- 
2.34.1

