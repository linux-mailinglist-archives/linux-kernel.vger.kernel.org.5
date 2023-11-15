Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175697EC1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjKOMOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKOMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:13:55 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D7C121
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:13:46 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id F22302070A;
        Wed, 15 Nov 2023 13:13:42 +0100 (CET)
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
Subject: [PATCH v1 1/3] drm/bridge: lt8912b: Add suspend/resume support
Date:   Wed, 15 Nov 2023 13:13:36 +0100
Message-Id: <20231115121338.22959-2-francesco@dolcini.it>
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

Add support for suspend and resume. The lt8912b will power off when
going into suspend and power on when resuming.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 03532efb893b..097ab04234b7 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -634,6 +634,33 @@ static const struct drm_bridge_funcs lt8912_bridge_funcs = {
 	.get_edid = lt8912_bridge_get_edid,
 };
 
+static int lt8912_bridge_resume(struct device *dev)
+{
+	struct lt8912 *lt = dev_get_drvdata(dev);
+	int ret;
+
+	ret = lt8912_hard_power_on(lt);
+	if (ret)
+		return ret;
+
+	ret = lt8912_soft_power_on(lt);
+	if (ret)
+		return ret;
+
+	return lt8912_video_on(lt);
+}
+
+static int lt8912_bridge_suspend(struct device *dev)
+{
+	struct lt8912 *lt = dev_get_drvdata(dev);
+
+	lt8912_hard_power_off(lt);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(lt8912_bridge_pm_ops, lt8912_bridge_suspend, lt8912_bridge_resume);
+
 static int lt8912_parse_dt(struct lt8912 *lt)
 {
 	struct gpio_desc *gp_reset;
@@ -770,6 +797,7 @@ static struct i2c_driver lt8912_i2c_driver = {
 	.driver = {
 		.name = "lt8912",
 		.of_match_table = lt8912_dt_match,
+		.pm = pm_sleep_ptr(&lt8912_bridge_pm_ops),
 	},
 	.probe = lt8912_probe,
 	.remove = lt8912_remove,
-- 
2.25.1

