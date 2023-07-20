Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1E475AC06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjGTKbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGTKbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:31:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D68910FC;
        Thu, 20 Jul 2023 03:31:42 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D93AE35CF;
        Thu, 20 Jul 2023 12:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689849044;
        bh=uXXiOXqzAU663MXYPT+tmzzgKeAuEaHLvlQ0jliVr5o=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gLRZb6AFKQidi64B0rF14hKfBN9ZKMZrDhvCf5cW9qC8Hxg8SAsq3ZAK1Knsl2ogC
         pmwZ4YknB+hbQZW9j0MXHoEOr5z4glDIp39Hkw7boJ7v+J4doeb6zv2xq7NZU+FP9V
         mk3WQtEN39Uoz1D1MR12D4UnqWKJTdwwOCqVpvuI=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 20 Jul 2023 13:30:34 +0300
Subject: [PATCH v2 3/8] media: i2c: ds90ub913: Use
 v4l2_fwnode_endpoint_parse()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-fpdlink-additions-v2-3-b91b1eca2ad3@ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
In-Reply-To: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2600;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=uXXiOXqzAU663MXYPT+tmzzgKeAuEaHLvlQ0jliVr5o=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkuQ0FoUEkQ60fvyZWGZBo8/gv2L3cSLqBJFNNy
 jhrdDffSKuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLkNBQAKCRD6PaqMvJYe
 9erZD/45jCtpXK5XImZlG2TG8AXAWT6T3sCxNwrn78kiUW97Is5ICbG3T27HYJRRVzYtednngw4
 qFXN0MLj5BgvtCTofolDCn0n3zCfKuwGZue0k6dM13rGCNcqyT/YGd1uQ5wcNNEptgsmJx3p50L
 ynBlE7loHtXLhgMjGFtzan8qcKIS0a9cEQXEFrkobBFLTMovW0dQ6dpbEcQq9gwzuVH4TPhDg/X
 dkcDVvQFa/JvGtRgg2ArE32WrF4xE+noOcwjZgDLGFlbvDzkL+87e4x4txgsf9mJIWo5Stc1xDo
 LTtOy7EeYuNnvIc8bKAuXseOmLASg3OkJSWf79LScUj+932M5Sd1nA1iiblkrRx5/QGwsptalnv
 CxZ9qz/JIXVLv0JexBEvytAFkCp+XWaEl1+fyMeXXdvbxfFefZw/SZNkKCQHBeufeV+Pl5VznLI
 olKrhec2yGBcqG4Rol4kzls13uD/+kIC5te016suagEIy+86qsqIoCrIhLiA7ZBTC4QaKiNiMKT
 7XrpJ4a9j50Jn76fw8ro1/1S6a2rNViPMWOChFACc5XBAt4285O9OFxTIuwZ6r3+dwyMYPiMdNo
 BKBOgxgfeDtN8V5gJuSJztkxeMzzZ8PlOqL0EWwb7gasT1U5lxnitBP26sWH7ejXESpxjhF0fSB
 0hDhFlDAO3fsp5Q==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use v4l2_fwnode_endpoint_parse() to parse the sink endpoint parameters.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/i2c/ds90ub913.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
index 4dae5afa9fa9..cb53b0654a43 100644
--- a/drivers/media/i2c/ds90ub913.c
+++ b/drivers/media/i2c/ds90ub913.c
@@ -21,6 +21,8 @@
 #include <linux/regmap.h>
 
 #include <media/i2c/ds90ub9xx.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-mediabus.h>
 #include <media/v4l2-subdev.h>
 
 #define UB913_PAD_SINK			0
@@ -83,7 +85,7 @@ struct ub913_data {
 
 	struct ds90ub9xx_platform_data *plat_data;
 
-	u32			pclk_polarity;
+	u32			pclk_polarity_rising;
 };
 
 static inline struct ub913_data *sd_to_ub913(struct v4l2_subdev *sd)
@@ -675,25 +677,31 @@ static int ub913_add_i2c_adapter(struct ub913_data *priv)
 static int ub913_parse_dt(struct ub913_data *priv)
 {
 	struct device *dev = &priv->client->dev;
+	struct v4l2_fwnode_endpoint vep = {};
 	struct fwnode_handle *ep_fwnode;
 	int ret;
 
 	ep_fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
 						    UB913_PAD_SINK, 0, 0);
-	if (!ep_fwnode) {
-		dev_err_probe(dev, -ENOENT, "No sink endpoint\n");
-		return -ENOENT;
-	}
+	if (!ep_fwnode)
+		return dev_err_probe(dev, -ENOENT, "No sink endpoint\n");
 
-	ret = fwnode_property_read_u32(ep_fwnode, "pclk-sample",
-				       &priv->pclk_polarity);
+	vep.bus_type = V4L2_MBUS_PARALLEL;
+	ret = v4l2_fwnode_endpoint_parse(ep_fwnode, &vep);
 
 	fwnode_handle_put(ep_fwnode);
 
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to parse 'pclk-sample'\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to parse sink endpoint data\n");
+
+	if (vep.bus.parallel.flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
+		priv->pclk_polarity_rising = true;
+	else if (vep.bus.parallel.flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
+		priv->pclk_polarity_rising = false;
+	else
+		return dev_err_probe(dev, -EINVAL,
+				     "bad value for 'pclk-sample'\n");
 
 	return 0;
 }
@@ -726,7 +734,7 @@ static int ub913_hw_init(struct ub913_data *priv)
 
 	ub913_read(priv, UB913_REG_GENERAL_CFG, &v);
 	v &= ~UB913_REG_GENERAL_CFG_PCLK_RISING;
-	v |= priv->pclk_polarity ? UB913_REG_GENERAL_CFG_PCLK_RISING : 0;
+	v |= priv->pclk_polarity_rising ? UB913_REG_GENERAL_CFG_PCLK_RISING : 0;
 	ub913_write(priv, UB913_REG_GENERAL_CFG, v);
 
 	return 0;

-- 
2.34.1

