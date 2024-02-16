Return-Path: <linux-kernel+bounces-68390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06185857997
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD621289176
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79DE225A8;
	Fri, 16 Feb 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aqxlhXGd"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1436224D0;
	Fri, 16 Feb 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077355; cv=none; b=KH0W0Ul6PYQhye4b6sOQsi1C91C7/oNTA+NJdYxi89jq94O20ZKrlWYCWiLMM6qyzOhz7bUACdVsctG6KiziIzYFH+c3GUKn1SCQTUQpctulL7oWOCoAejK8qYMDGojxIPvLGh0JJ8kP8O0r6rIxjzO1y3JG2h+n56yAU9Iuo1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077355; c=relaxed/simple;
	bh=tDRSHPUREY4LV8Nn4OrykHBSCBXJowmP1/9PykZy4fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGA4iDvFOEOt+5uq69sVH8SI5VSCMusAi4B/9+18tUVTOa4P4owewVRZlwPZvYONU4hvf2UBlpnQ2oqAP0XuzByTVzmnm+yeSJgZEJH0e6lTqqKhlAtoJd9HjHtwOOIIJrpDiMY7GhJMWG+x8yhbehmzCMTvSGslkfonpEoZKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aqxlhXGd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3C0D46B3;
	Fri, 16 Feb 2024 10:55:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708077348;
	bh=tDRSHPUREY4LV8Nn4OrykHBSCBXJowmP1/9PykZy4fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqxlhXGdae6DRlSsh1uoeEZZqMYm6923CpVRDuxvZco2PNK/Y7Grvk9dFys+pLxlf
	 XC+WK9NKwPXGmfteP5PxhrkEgqQ49rcTe9ZqKrgK5OPOm7dQIgVPG1pll2zrsOvt5Y
	 l+3SKf00SE+WCu+aU4H9yeP5Cc4ECLNCjzSERPlo=
From: Paul Elder <paul.elder@ideasonboard.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	umang.jain@ideasonboard.com,
	aford173@gmail.com,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 07/12] media: rkisp1: Configure gasket on i.MX8MP
Date: Fri, 16 Feb 2024 18:54:53 +0900
Message-Id: <20240216095458.2919694-8-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
References: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The i.MX8MP has a gasket between the CSI-2 receiver and the ISP.
Configure and enable it when starting the ISP, and disable it when
stopping.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../platform/rockchip/rkisp1/rkisp1-common.h  |   5 +
 .../platform/rockchip/rkisp1/rkisp1-dev.c     |  16 +++
 .../platform/rockchip/rkisp1/rkisp1-isp.c     | 131 +++++++++++++++++-
 3 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 219d4a2547aa..69940014d597 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -24,6 +24,7 @@
 #include "rkisp1-regs.h"
 
 struct dentry;
+struct regmap;
 
 /*
  * flags on the 'direction' field in struct rkisp1_mbus_info' that indicate
@@ -444,6 +445,8 @@ struct rkisp1_debug {
  * @dev:	   a pointer to the struct device
  * @clk_size:	   number of clocks
  * @clks:	   array of clocks
+ * @gasket:	   the gasket - i.MX8MP only
+ * @gasket_id:	   the gasket ID (0 or 1) - i.MX8MP only
  * @v4l2_dev:	   v4l2_device variable
  * @media_dev:	   media_device variable
  * @notifier:	   a notifier to register on the v4l2-async API to be notified on the sensor
@@ -466,6 +469,8 @@ struct rkisp1_device {
 	struct device *dev;
 	unsigned int clk_size;
 	struct clk_bulk_data clks[RKISP1_MAX_BUS_CLK];
+	struct regmap *gasket;
+	unsigned int gasket_id;
 	struct v4l2_device v4l2_dev;
 	struct media_device media_dev;
 	struct v4l2_async_notifier notifier;
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 2e40c376cab5..d0a3a13d9dd7 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
@@ -601,6 +602,21 @@ static int rkisp1_probe(struct platform_device *pdev)
 		return ret;
 	rkisp1->clk_size = info->clk_size;
 
+	if (info->isp_ver == RKISP1_V_IMX8MP) {
+		unsigned int id;
+
+		rkisp1->gasket = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+								      "fsl,blk-ctrl",
+								      1, &id);
+		if (IS_ERR(rkisp1->gasket)) {
+			ret = PTR_ERR(rkisp1->gasket);
+			dev_err(dev, "failed to get gasket: %d\n", ret);
+			return ret;
+		}
+
+		rkisp1->gasket_id = id;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 78a1f7a1499b..e45a213baf49 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -10,6 +10,7 @@
 
 #include <linux/iopoll.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/videodev2.h>
 #include <linux/vmalloc.h>
 
@@ -53,6 +54,115 @@
  * +---------------------------------------------------------+
  */
 
+/* -----------------------------------------------------------------------------
+ * Media block control (i.MX8MP only)
+ */
+
+#define ISP_DEWARP_CONTROL				0x0138
+
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_HS_POLARITY	BIT(22)
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_RISING	(0 << 20)
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_NEGATIVE	(1 << 20)
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_POSITIVE	(2 << 20)
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_FALLING	(3 << 20)
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_MASK	GENMASK(21, 20)
+#define ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE	BIT(19)
+#define ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE(dt)	((dt) << 13)
+#define ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE_MASK	GENMASK(18, 13)
+
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_HS_POLARITY	BIT(12)
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_RISING	(0 << 10)
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_NEGATIVE	(1 << 10)
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_POSITIVE	(2 << 10)
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_FALLING	(3 << 10)
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_MASK	GENMASK(11, 10)
+#define ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE	BIT(9)
+#define ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE(dt)	((dt) << 3)
+#define ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE_MASK	GENMASK(8, 3)
+
+#define ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE		BIT(1)
+#define ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE		BIT(0)
+
+static int rkisp1_gasket_enable(struct rkisp1_device *rkisp1,
+				struct media_pad *source)
+{
+	struct v4l2_subdev *source_sd;
+	struct v4l2_mbus_frame_desc fd;
+	unsigned int dt;
+	u32 mask;
+	u32 val;
+	int ret;
+
+	/*
+	 * Configure and enable the gasket with the CSI-2 data type. Set the
+	 * vsync polarity as active high, as that is what the ISP is configured
+	 * to expect in ISP_ACQ_PROP. Enable left justification, as the i.MX8MP
+	 * ISP has a 16-bit wide input and expects data to be left-aligned.
+	 */
+
+	source_sd = media_entity_to_v4l2_subdev(source->entity);
+	ret = v4l2_subdev_call(source_sd, pad, get_frame_desc,
+			       source->index, &fd);
+	if (ret) {
+		dev_err(rkisp1->dev,
+			"failed to get frame descriptor from '%s':%u: %d\n",
+			source_sd->name, 0, ret);
+		return ret;
+	}
+
+	if (fd.num_entries != 1) {
+		dev_err(rkisp1->dev, "invalid frame descriptor for '%s':%u\n",
+			source_sd->name, 0);
+		return -EINVAL;
+	}
+
+	dt = fd.entry[0].bus.csi2.dt;
+
+	if (rkisp1->gasket_id == 0) {
+		mask = ISP_DEWARP_CONTROL_MIPI_CSI1_HS_POLARITY
+		     | ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_MASK
+		     | ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE
+		     | ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE_MASK
+		     | ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE;
+		val = ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_POSITIVE
+		    | ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE
+		    | ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE(dt);
+	} else {
+		mask = ISP_DEWARP_CONTROL_MIPI_CSI2_HS_POLARITY
+		     | ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_MASK
+		     | ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE
+		     | ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE_MASK
+		     | ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE;
+		val = ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_POSITIVE
+		    | ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE
+		    | ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE(dt);
+	}
+
+	regmap_update_bits(rkisp1->gasket, ISP_DEWARP_CONTROL, mask, val);
+
+	return 0;
+}
+
+static void rkisp1_gasket_disable(struct rkisp1_device *rkisp1)
+{
+	u32 mask;
+	u32 val;
+
+	if (rkisp1->gasket_id == 1) {
+		mask = ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE
+		     | ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE_MASK
+		     | ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE;
+		val = ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE;
+	} else {
+		mask = ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE
+		     | ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE_MASK
+		     | ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE;
+		val = ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE;
+	}
+
+	regmap_update_bits(rkisp1->gasket, ISP_DEWARP_CONTROL, mask, val);
+}
+
 /* ----------------------------------------------------------------------------
  * Camera Interface registers configurations
  */
@@ -291,6 +401,9 @@ static void rkisp1_isp_stop(struct rkisp1_isp *isp)
 		     RKISP1_CIF_VI_IRCL_MIPI_SW_RST |
 		     RKISP1_CIF_VI_IRCL_ISP_SW_RST);
 	rkisp1_write(rkisp1, RKISP1_CIF_VI_IRCL, 0x0);
+
+	if (rkisp1->info->isp_ver == RKISP1_V_IMX8MP)
+		rkisp1_gasket_disable(rkisp1);
 }
 
 static void rkisp1_config_clk(struct rkisp1_isp *isp)
@@ -315,16 +428,24 @@ static void rkisp1_config_clk(struct rkisp1_isp *isp)
 	}
 }
 
-static void rkisp1_isp_start(struct rkisp1_isp *isp,
-			     struct v4l2_subdev_state *sd_state)
+static int rkisp1_isp_start(struct rkisp1_isp *isp,
+			    struct v4l2_subdev_state *sd_state,
+			    struct media_pad *source)
 {
 	struct rkisp1_device *rkisp1 = isp->rkisp1;
 	const struct v4l2_mbus_framefmt *src_fmt;
 	const struct rkisp1_mbus_info *src_info;
 	u32 val;
+	int ret;
 
 	rkisp1_config_clk(isp);
 
+	if (rkisp1->info->isp_ver == RKISP1_V_IMX8MP) {
+		ret = rkisp1_gasket_enable(rkisp1, source);
+		if (ret)
+			return ret;
+	}
+
 	/* Activate ISP */
 	val = rkisp1_read(rkisp1, RKISP1_CIF_ISP_CTRL);
 	val |= RKISP1_CIF_ISP_CTRL_ISP_CFG_UPD |
@@ -338,6 +459,8 @@ static void rkisp1_isp_start(struct rkisp1_isp *isp,
 
 	if (src_info->pixel_enc != V4L2_PIXEL_ENC_BAYER)
 		rkisp1_params_post_configure(&rkisp1->params);
+
+	return 0;
 }
 
 /* ----------------------------------------------------------------------------
@@ -848,7 +971,9 @@ static int rkisp1_isp_s_stream(struct v4l2_subdev *sd, int enable)
 	if (ret)
 		goto out_unlock;
 
-	rkisp1_isp_start(isp, sd_state);
+	ret = rkisp1_isp_start(isp, sd_state, source_pad);
+	if (ret)
+		goto out_unlock;
 
 	ret = v4l2_subdev_call(rkisp1->source, video, s_stream, true);
 	if (ret) {
-- 
2.39.2


