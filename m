Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5912775AC05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGTKbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjGTKbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:31:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D510F1;
        Thu, 20 Jul 2023 03:31:42 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 030083484;
        Thu, 20 Jul 2023 12:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689849043;
        bh=P2mwt86IU+mUzZLLbuoF0ir+LSKXHqgzspTaSIT0SUo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RBp2sQ4BeAQlW9GbIPUqXXxiM7Vat1kuWEuSNUnM+KqZX8kESb7u1Y+tGAUSD009x
         zAk16Q0j56P9QBPsR71Dr1+hyBAaef36TajrQjv9uVHMSWxX+5Dna4GFAbfv7ClXrK
         FXCjwJbYFcCgw0yUqq+Sg7NLye976KV4GI+hByCM=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 20 Jul 2023 13:30:33 +0300
Subject: [PATCH v2 2/8] media: i2c: ds90ub953: Use
 v4l2_fwnode_endpoint_parse()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-fpdlink-additions-v2-2-b91b1eca2ad3@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=P2mwt86IU+mUzZLLbuoF0ir+LSKXHqgzspTaSIT0SUo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkuQ0FA9GXOLwxUYO52+WLLQqADbI7QZUvTsO5o
 6uQOD1QOEaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLkNBQAKCRD6PaqMvJYe
 9dKJD/9HVYxsj3ditaU5OdgmrYzNNMcy2DR8i8FE+5Sc46z+HqD5hWREguYYRs9kd2a2nFDRSnP
 yHaS9nteGT+HuWXkaLBMh4XJLY9IMpXb5X6q2sAsLrPUTdRPEU8GQ2h1aNoLIJXnIL44lTymJPV
 hSgiubMe0VBk6auxPmneHQTt/es6RTAG9v/QfN4nxJbkqbsiQ/MiDb090yxDLMN+IREPrMzmq+6
 iqWbYwUCruJWQvzQjDuC01OZzhMnV2MVw4Uw4GVEhyW0HeKBit7VBDXKnqP8TIOWgSavxK33eV5
 ITi3YgjW3lTdklCOi7z4gMplpdxqvu84Xs7VpkkgtrLH0WisgTeGcfGIEC08srbv8W9XhDuoJNp
 SzzFPV0ndcxuFkNL9B0HEs2CwGo3XISUJRvofcg8B5zpB2VmLVAwi2D1vzKUdd3T73g9C2p9e33
 9XJzCpbu33rvdVKiTpgNuUu/pzo0PVQ8bpzVbMH5ECvVv3O3vPZr6/JPfTP/9XGUf4uidKv/crN
 iWK/vEUrg48v4+789L0jV/+lzlSlMy+VWYXGGoNMijsINhli3R8EWt8JcYciAM5EFmtUZO6wVV6
 2P4nQv13LqhPJdG8AvxnlL67dLWuDOruXet0jOTSyTb8A+OQeZmFCKJyBEUrWvoO5YWs6Kp069v
 oRzd6mu7Anf9alg==
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
 drivers/media/i2c/ds90ub953.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index 591b52bf71c2..ad964bd6c7eb 100644
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
@@ -1111,7 +1113,9 @@ static const struct regmap_config ub953_regmap_config = {
 static int ub953_parse_dt(struct ub953_data *priv)
 {
 	struct device *dev = &priv->client->dev;
+	struct v4l2_fwnode_endpoint vep = {};
 	struct fwnode_handle *ep_fwnode;
+	unsigned char nlanes;
 	int ret;
 
 	ep_fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
@@ -1119,19 +1123,21 @@ static int ub953_parse_dt(struct ub953_data *priv)
 	if (!ep_fwnode)
 		return dev_err_probe(dev, -ENOENT, "no endpoint found\n");
 
-	ret = fwnode_property_count_u32(ep_fwnode, "data-lanes");
+	vep.bus_type = V4L2_MBUS_CSI2_DPHY;
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
+				     "bad number of data-lanes: %d\n", nlanes);
 
-	priv->num_data_lanes = ret;
+	priv->num_data_lanes = nlanes;
 
 	return 0;
 }

-- 
2.34.1

