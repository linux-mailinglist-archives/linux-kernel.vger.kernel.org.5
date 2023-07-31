Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45C9769778
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjGaNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjGaNZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:25:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019D610E3;
        Mon, 31 Jul 2023 06:25:28 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 59A2513FE;
        Mon, 31 Jul 2023 15:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690809863;
        bh=UHTTCjc81txTyZ1stxkjLhTvtYVx+6QR6EF8xfykdnk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=T8CvZFQKm88z/unfOPwakpPYl7p6pDIhQhErpR/yXzKh3vz68yVvHBZFguVrcK0hD
         5ZGHy2hJCHg8XNu5RUYvO0U0yHeNvt2P5udFrggmSY6pMmYqNMg9nqeFehA6+8d1rW
         xK2LRQkecVfVjePh8+9jMFGthje34b3D40F/SCl4=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Mon, 31 Jul 2023 16:24:37 +0300
Subject: [PATCH v3 3/9] media: i2c: ds90ub953: Use
 v4l2_fwnode_endpoint_parse()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-fpdlink-additions-v3-3-8acfc49c215a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=UHTTCjc81txTyZ1stxkjLhTvtYVx+6QR6EF8xfykdnk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkx7Y+nhD3vEsFAkA8qcaVl982kop0Y/k0ebnJ8
 C0R/JYDBymJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMe2PgAKCRD6PaqMvJYe
 9aWiEACJy1CubZwmtO4AWG9sobMejlxlRAAbX6jt8y4nY0Qi7PbJSqFf8Cgb/D4vSjdEsXcHp89
 S5QNgIPbhkXI5A51hkZGnLCxvf17qkp8lojXuIZKRxt0sXgesMDQ2B6eO7RgksMtHGNytxs5PJy
 B0NxAHSHEWVMlEuPIdpjIJ7mIKc9pJpzOJFc2mRY1ASrWa0lEXYGY65xgHyUgRGatWnExHtPb2V
 RNlPCzm+d70JdDqPdtJtkbWat8hk6/IE8VEMPJhk1wp6F0217CkoL9sn19eIQc3RS1kxDttQKkc
 hmiU1//uZHBtUbKqMeGamuZI0ukBaeGDGYpKZL+0rhv9KtdspCH00zuUoa/DGKGb5RmujHXSql4
 6cEbgR4KK1NiTnUj8PUmaZprPjBipkk/2f01GvGgJGSaXdCVBPpdUyvaD12QKFnrPY3yPTevmM7
 gIOLGu4Ue2GzciUNwyeLqI2TBsXi2uy03wVgn8JHyvdYu4Mll3gX76jRX83Ezf1k08LWDRTfnnV
 QKHkcwTH3HvplmGRbIgkRtw8WT5OXAKDWfMZwesJwd2L162DU3rnX+VGVNrdtGSWwiIE929SdE+
 bElB/4Pf/IlSJ/UY6keRA+/3hHp/U+vV/l1id/32hLKOhCSmmEkCXVVq5oEPz4ABn62f01JBAHs
 0aHxfFOx6D0S/CQ==
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
 drivers/media/i2c/ds90ub953.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index 20b9cf893f74..1032c8633809 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -25,6 +25,8 @@
 #include <media/i2c/ds90ub9xx.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-event.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-mediabus.h>
 #include <media/v4l2-subdev.h>
 
 #define UB953_PAD_SINK			0
@@ -1111,7 +1113,11 @@ static const struct regmap_config ub953_regmap_config = {
 static int ub953_parse_dt(struct ub953_data *priv)
 {
 	struct device *dev = &priv->client->dev;
+	struct v4l2_fwnode_endpoint vep = {
+		.bus_type = V4L2_MBUS_CSI2_DPHY,
+	};
 	struct fwnode_handle *ep_fwnode;
+	unsigned char nlanes;
 	int ret;
 
 	ep_fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
@@ -1119,19 +1125,20 @@ static int ub953_parse_dt(struct ub953_data *priv)
 	if (!ep_fwnode)
 		return dev_err_probe(dev, -ENOENT, "no endpoint found\n");
 
-	ret = fwnode_property_count_u32(ep_fwnode, "data-lanes");
+	ret = v4l2_fwnode_endpoint_parse(ep_fwnode, &vep);
 
 	fwnode_handle_put(ep_fwnode);
 
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret,
-				     "failed to parse property 'data-lanes'\n");
+				     "failed to parse sink endpoint data\n");
 
-	if (ret != 1 && ret != 2 && ret != 4)
+	nlanes = vep.bus.mipi_csi2.num_data_lanes;
+	if (nlanes != 1 && nlanes != 2 && nlanes != 4)
 		return dev_err_probe(dev, -EINVAL,
-				     "bad number of data-lanes: %d\n", ret);
+				     "bad number of data-lanes: %u\n", nlanes);
 
-	priv->num_data_lanes = ret;
+	priv->num_data_lanes = nlanes;
 
 	return 0;
 }

-- 
2.34.1

