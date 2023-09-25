Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4451E7ACDF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjIYCLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjIYCLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:11:45 -0400
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [IPv6:2001:41d0:1004:224b::be])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6ACF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:11:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1695607894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjYW+FPYn4FtPs/h0Kb7cdF5d1ojhB/ZqlHnYv4SWzY=;
        b=ADn0fQ3cpdEzqFpU0SrFyxBMlnwPycknXFywWCUBuZub8eXFzYI37a7nYbHGEBfg0aL+AG
        dllzsq8miBQKzbA+NcAg8elpwh6otvxEPlG/bpw8e9DXseIQlLxwHKqg0jsW8a9eDWoXiV
        1kwPcvFDcgR6CVeGpCXnGGAtm7RchLvsBIBr8AvIU9YQnA6DGjK5XrWSmsrG2mPyJdyD0/
        4WSKkHvfVnKz4ysncUjp5mx54ZP7CE0/rih8I8tySHwGmVt4SdGiK3Jurv7aVtVejKaEZU
        hNOdDm7PQqDNwR9OCBR8r2boGOmpGaOXrRAcLamPBCPzNzJ2MXNPta9ilqsnnQ==
From:   John Watts <contact@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, John Watts <contact@jookia.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 3/7] drm/panel: nv3052c: Allow specifying registers per panel
Date:   Mon, 25 Sep 2023 12:10:54 +1000
Message-ID: <20230925021059.451019-4-contact@jookia.org>
In-Reply-To: <20230925021059.451019-1-contact@jookia.org>
References: <20230925021059.451019-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panel initialization registers are per-display and not tied to the
controller itself. Different panels will specify their own registers.
Attach the sequences to the panel info struct so future panels
can specify their own sequences.

Signed-off-by: John Watts <contact@jookia.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 90dea21f9856..382062a79ba8 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -20,11 +20,18 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
+struct nv3052c_reg {
+	u8 cmd;
+	u8 val;
+};
+
 struct nv3052c_panel_info {
 	const struct drm_display_mode *display_modes;
 	unsigned int num_modes;
 	u16 width_mm, height_mm;
 	u32 bus_format, bus_flags;
+	const struct nv3052c_reg *panel_regs;
+	int panel_regs_len;
 };
 
 struct nv3052c {
@@ -36,12 +43,7 @@ struct nv3052c {
 	struct gpio_desc *reset_gpio;
 };
 
-struct nv3052c_reg {
-	u8 cmd;
-	u8 val;
-};
-
-static const struct nv3052c_reg nv3052c_panel_regs[] = {
+static const struct nv3052c_reg ltk035c5444t_panel_regs[] = {
 	// EXTC Command set enable, select page 1
 	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x01 },
 	// Mostly unknown registers
@@ -244,6 +246,8 @@ static inline struct nv3052c *to_nv3052c(struct drm_panel *panel)
 static int nv3052c_prepare(struct drm_panel *panel)
 {
 	struct nv3052c *priv = to_nv3052c(panel);
+	const struct nv3052c_reg *panel_regs = priv->panel_info->panel_regs;
+	int panel_regs_len = priv->panel_info->panel_regs_len;
 	struct mipi_dbi *dbi = &priv->dbi;
 	unsigned int i;
 	int err;
@@ -260,9 +264,9 @@ static int nv3052c_prepare(struct drm_panel *panel)
 	gpiod_set_value_cansleep(priv->reset_gpio, 0);
 	usleep_range(5000, 20000);
 
-	for (i = 0; i < ARRAY_SIZE(nv3052c_panel_regs); i++) {
-		err = mipi_dbi_command(dbi, nv3052c_panel_regs[i].cmd,
-				       nv3052c_panel_regs[i].val);
+	for (i = 0; i < panel_regs_len; i++) {
+		err = mipi_dbi_command(dbi, panel_regs[i].cmd,
+				       panel_regs[i].val);
 
 		if (err) {
 			dev_err(priv->dev, "Unable to set register: %d\n", err);
@@ -463,6 +467,8 @@ static const struct nv3052c_panel_info ltk035c5444t_panel_info = {
 	.height_mm = 64,
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+	.panel_regs = ltk035c5444t_panel_regs,
+	.panel_regs_len = ARRAY_SIZE(ltk035c5444t_panel_regs),
 };
 
 static const struct spi_device_id nv3052c_ids[] = {
-- 
2.42.0

