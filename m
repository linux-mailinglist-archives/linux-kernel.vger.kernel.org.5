Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA50B79BA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377433AbjIKWVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjIKJDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:03:10 -0400
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com [95.215.58.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D1ECCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:03:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694422984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICC/SzyHwq6OWg2Vbcao+ENYPJZEyCaFguUig4QftpI=;
        b=zDWg5jC2P6F0x0iELGO62R3P8c638vuT/a7cEaoY5Uuy8K6n2rNcqYHcvMflGSOz7hmpXC
        clmQSzjrLcwD9IHkIjIKuaR8VkkAG+2POyviG/5e86djVfoqxYgj2cwa8u/2nQSXcTohqf
        +mUoIofWCtok+FoHwXPMG/VQUAxRO/fx5fUiq1RMWmCx2zx+2LniQ6PPVuEUz8caQSNOxe
        D9jDXe0O3dVub+j0ZETWRC4qZFWtXiuXDfU72zDrtpbxfvbxEvW/nIR6oLN3cQ0aPvLPDh
        2Ypki3ORVtzkxwYYAfABmeXbTXP/Kd2e0OHuea/2MhKoPdKl5NF2N3Bb43UkvQ==
From:   John Watts <contact@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, John Watts <contact@jookia.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/8] drm/panel: nv3052c: Allow specifying registers per panel
Date:   Mon, 11 Sep 2023 19:02:03 +1000
Message-ID: <20230911090206.3121440-6-contact@jookia.org>
In-Reply-To: <20230911090206.3121440-1-contact@jookia.org>
References: <20230911090206.3121440-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 307335d0f1fc..b2ad9b3a5eb7 100644
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
@@ -244,6 +246,7 @@ static inline struct nv3052c *to_nv3052c(struct drm_panel *panel)
 static int nv3052c_prepare(struct drm_panel *panel)
 {
 	struct nv3052c *priv = to_nv3052c(panel);
+	const struct nv3052c_reg *panel_regs = priv->panel_info->panel_regs;
 	struct mipi_dbi *dbi = &priv->dbi;
 	unsigned int i;
 	int err;
@@ -260,9 +263,11 @@ static int nv3052c_prepare(struct drm_panel *panel)
 	gpiod_set_value_cansleep(priv->reset_gpio, 0);
 	msleep(150);
 
-	for (i = 0; i < ARRAY_SIZE(nv3052c_panel_regs); i++) {
-		err = mipi_dbi_command(dbi, nv3052c_panel_regs[i].cmd,
-				       nv3052c_panel_regs[i].val);
+	int panel_regs_len = priv->panel_info->panel_regs_len;
+
+	for (i = 0; i < panel_regs_len; i++) {
+		err = mipi_dbi_command(dbi, panel_regs[i].cmd,
+				       panel_regs[i].val);
 
 		if (err) {
 			dev_err(priv->dev, "Unable to set register: %d\n", err);
@@ -466,6 +471,8 @@ static const struct nv3052c_panel_info ltk035c5444t_panel_info = {
 	.height_mm = 64,
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+	.panel_regs = ltk035c5444t_panel_regs,
+	.panel_regs_len = ARRAY_SIZE(ltk035c5444t_panel_regs),
 };
 
 static const struct spi_device_id nv3052c_ids[] = {
-- 
2.42.0

