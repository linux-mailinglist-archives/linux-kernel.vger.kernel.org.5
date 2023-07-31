Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B6769783
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGaNZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjGaNZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:25:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B610F0;
        Mon, 31 Jul 2023 06:25:30 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4C6981536;
        Mon, 31 Jul 2023 15:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690809864;
        bh=0yRsXxkV/lQOSYD48MHpa+oMNWDiUXYP+PtboMvfA0g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fpo+n3u2nDplkFqME14iiXcqzAeXE6WfnK/3FCUpz9XeLZWhhe8I0TNNGI2RzOpc4
         pPuTWYm13aZ1jm2S5QD+bFt0F96sFeemisuJIb00di4ZMvG2IzDwjgEeDkdUMXYHOQ
         7WW+OA3UcI1IVgyImGOpiCeCLcjy6afPiYMLhhcg=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Mon, 31 Jul 2023 16:24:38 +0300
Subject: [PATCH v3 4/9] media: i2c: ds90ub913: Use
 v4l2_fwnode_endpoint_parse()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-fpdlink-additions-v3-4-8acfc49c215a@ideasonboard.com>
References: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
In-Reply-To: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2737;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=0yRsXxkV/lQOSYD48MHpa+oMNWDiUXYP+PtboMvfA0g=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkx7Y/UkF+aCPnDnU61gZ5W+NDaI/oDWZ3ErtOe
 FxN+bJF0H6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMe2PwAKCRD6PaqMvJYe
 9R10EAClMto+yzFKFHic76uSK/9sKjxdUH7wt+8tedKLXTqQn6WNzQviFcM8LVJAycaBMk6LwZ5
 q+520qzpIx4PagGAkHXLFvVXJwwxZdS6/BIoikAns+/3clcQSRclazteVWskCgPSIU1llUQK2Lf
 2U0TDkVFzUM4rMyjpT6RXHMUF/DiIKsuuj4RKSPxDbRbozk0kcyPImaAaetMcGYAsGQ/cK7vDf6
 54GJxmefhGY3te3ppxhDmjqrfAT4Cd9D9CfIiUHQ+8f9Cb7w6X2nVqkrXnQs7r5EmPfLF7BSjc6
 VFL8NeZsVMwXrcTTtz3OLovT+zo5D1GLjqRDZk0liQMuxibYvjrv60GAHkla0qK3P3/rObi7aLz
 oZQCE12RMhtJ0rNNSdi2nYF1LmuwoYAE9ieLbbJ+PpVs9cu23SHnfXuiqOeX/AAKByfP6Gh/F+s
 pqfKZ+cNNvdLx1xm8Eoiwztp61m5OPmLFunC4NAA8BQ2y1l7uqi1uVnnbprZ50K1jdwyxe5Dsht
 nO1o9N0vON9en4g+yzTEygFNtvx4SFri4ORTWkCk05DUdyuyJP7UA9gRuWP1Jney1v0V2NHdVYB
 0t4pyPOUJutMDH2rshGeNRWIoE1TEW60maQdLpZBq+NdYExuK/G58iY8ZjDaxMKVrlQrayQEalB
 mF3F96dTWAdav7A==
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ds90ub913.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
index 5410ccb54057..85b664e33482 100644
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
+	bool			pclk_polarity_rising;
 };
 
 static inline struct ub913_data *sd_to_ub913(struct v4l2_subdev *sd)
@@ -675,25 +677,32 @@ static int ub913_add_i2c_adapter(struct ub913_data *priv)
 static int ub913_parse_dt(struct ub913_data *priv)
 {
 	struct device *dev = &priv->client->dev;
+	struct v4l2_fwnode_endpoint vep = {
+		.bus_type = V4L2_MBUS_PARALLEL,
+	};
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
@@ -726,7 +735,7 @@ static int ub913_hw_init(struct ub913_data *priv)
 
 	ub913_read(priv, UB913_REG_GENERAL_CFG, &v);
 	v &= ~UB913_REG_GENERAL_CFG_PCLK_RISING;
-	v |= priv->pclk_polarity ? UB913_REG_GENERAL_CFG_PCLK_RISING : 0;
+	v |= priv->pclk_polarity_rising ? UB913_REG_GENERAL_CFG_PCLK_RISING : 0;
 	ub913_write(priv, UB913_REG_GENERAL_CFG, v);
 
 	return 0;

-- 
2.34.1

