Return-Path: <linux-kernel+bounces-167922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE518BB11A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE03282E12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E48157488;
	Fri,  3 May 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NEh5VK6U"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB34157472
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754519; cv=none; b=IChucf/otVVZ1BNp8WEwJPHJIFF+9MlIJ5ggbhAqUN12lSGlQvQojFOI0UjiWZDF4KIqk4kN/xNPP/GxHeHwkbIOqi85aRUHg2T1CxRoN3W2OV/XwTAea08CVZ1bGe+R3D0oV842FWpELnAtQgU+NMx0HbAYEh83BA1OwiEtQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754519; c=relaxed/simple;
	bh=oDsDgvNmE1gNYo2J1GuT2zh1jOMmgrd6DOF+6K/HdVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ugzh4F2FlzlJO2Pt/tdy0eEkZ8f6bhaoU7cCQLE4Y0BzM8f6EdQdJFVZhPQJ0JRIYcLr/chnWRA+VHI4V5V2fK0TfIcrjdExYXk2K0EPHOrlJ5NFRqAtqSqJFoPSA3vuNsjLC/M+YGhwMpcniNkpiSvXD0WCpAgfcVlOpt+iP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NEh5VK6U; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714754516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xw1HArlIdRKgIvugHN5vPeChqMUP7aJKLbZfZnnuOgI=;
	b=NEh5VK6URle7xDiPprL0Jooz648LzGTbbYh6D1rPErTFpZyfQ/vsJcTcpu51dv7P0nRGCK
	eMZVwR8n8Rz3ZbJf8mlqVb+aYep2gjO1DfcZAWXtIXG2Q2ewq2u8Pmdyvigc9xX28h25Ag
	fIH/qk9lIHDM7oOUBXYlWlz4118anZ8=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v5 08/10] drm/bridge: sii9234: Use fwnode APIs to abstract DT dependent API away
Date: Sat,  4 May 2024 00:41:04 +0800
Message-Id: <20240503164106.1172650-9-sui.jingfeng@linux.dev>
In-Reply-To: <20240503164106.1172650-1-sui.jingfeng@linux.dev>
References: <20240503164106.1172650-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Switch to use the freshly created drm_bridge_set_node() helper, no
functional changes. The reason behind of this introduction is that
the name 'of_node' itself has a smell of DT dependent, and it is a
internal memeber, when there has helper function, we should use the
revelant helper and avoid directly referencing and/or dereferencing
it.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/sii9234.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index d8373d918324..19b09634a134 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -817,10 +817,11 @@ static int sii9234_init_resources(struct sii9234 *ctx,
 				  struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	struct fwnode_handle *fwnode = dev_fwnode(ctx->dev);
 	int ret;
 
-	if (!ctx->dev->of_node) {
-		dev_err(ctx->dev, "not DT device\n");
+	if (!fwnode) {
+		dev_err(ctx->dev, "firmware data is missing\n");
 		return -ENODEV;
 	}
 
@@ -886,6 +887,7 @@ static int sii9234_probe(struct i2c_client *client)
 	struct i2c_adapter *adapter = client->adapter;
 	struct sii9234 *ctx;
 	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	int ret;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
@@ -922,7 +924,7 @@ static int sii9234_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, ctx);
 
 	ctx->bridge.funcs = &sii9234_bridge_funcs;
-	ctx->bridge.of_node = dev->of_node;
+	drm_bridge_set_node(&ctx->bridge, fwnode);
 	drm_bridge_add(&ctx->bridge);
 
 	sii9234_cable_in(ctx);
-- 
2.34.1


