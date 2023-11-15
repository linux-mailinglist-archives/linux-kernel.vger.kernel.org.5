Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A67EC1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbjKOMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjKOMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:13:55 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2216C122
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:13:46 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 3F5762072F;
        Wed, 15 Nov 2023 13:13:44 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Adrien Grassein <adrien.grassein@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 3/3] drm/bridge: lt8912b: Add power supplies
Date:   Wed, 15 Nov 2023 13:13:38 +0100
Message-Id: <20231115121338.22959-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115121338.22959-1-francesco@dolcini.it>
References: <20231115121338.22959-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add supplies to the driver that can be used to turn the Lontium lt8912b
on and off. It can have up to 7 independent supplies, we add them all
and enable/disable them with bulk_enable/disable.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 097ab04234b7..273157428c82 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -43,6 +43,8 @@ struct lt8912 {
 
 	struct videomode mode;
 
+	struct regulator_bulk_data supplies[7];
+
 	u8 data_lanes;
 	bool is_power_on;
 };
@@ -257,6 +259,12 @@ static int lt8912_free_i2c(struct lt8912 *lt)
 
 static int lt8912_hard_power_on(struct lt8912 *lt)
 {
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(lt->supplies), lt->supplies);
+	if (ret)
+		return ret;
+
 	gpiod_set_value_cansleep(lt->gp_reset, 0);
 	msleep(20);
 
@@ -267,6 +275,9 @@ static void lt8912_hard_power_off(struct lt8912 *lt)
 {
 	gpiod_set_value_cansleep(lt->gp_reset, 1);
 	msleep(20);
+
+	regulator_bulk_disable(ARRAY_SIZE(lt->supplies), lt->supplies);
+
 	lt->is_power_on = false;
 }
 
@@ -661,6 +672,21 @@ static int lt8912_bridge_suspend(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(lt8912_bridge_pm_ops, lt8912_bridge_suspend, lt8912_bridge_resume);
 
+static int lt8912_get_regulators(struct lt8912 *lt)
+{
+	unsigned int i;
+	const char * const supply_names[] = {
+		"vdd", "vccmipirx", "vccsysclk", "vcclvdstx",
+		"vcchdmitx", "vcclvdspll", "vcchdmipll"
+	};
+
+	for (i = 0; i < ARRAY_SIZE(lt->supplies); i++)
+		lt->supplies[i].supply = supply_names[i];
+
+	return devm_regulator_bulk_get(lt->dev, ARRAY_SIZE(lt->supplies),
+				       lt->supplies);
+}
+
 static int lt8912_parse_dt(struct lt8912 *lt)
 {
 	struct gpio_desc *gp_reset;
@@ -712,6 +738,10 @@ static int lt8912_parse_dt(struct lt8912 *lt)
 		goto err_free_host_node;
 	}
 
+	ret = lt8912_get_regulators(lt);
+	if (ret)
+		goto err_free_host_node;
+
 	of_node_put(port_node);
 	return 0;
 
-- 
2.25.1

