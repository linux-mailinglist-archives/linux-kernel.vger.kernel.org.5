Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796E276977D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGaNZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGaNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:25:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA43210F2;
        Mon, 31 Jul 2023 06:25:24 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 81B99E79;
        Mon, 31 Jul 2023 15:24:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690809861;
        bh=CWOBqaJNAdPeoqe+d1O2pTibjSWEKIHUROFn5FDzjlc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uj97Fj0AquY7+dycLBMnUIAsyW/KYOWHfetX+nhMWQVVVcsfbjN+6DcJzGpv/+EF3
         dss5/WoW6JJLi7Iu8oeX7pcMEMRJT3hWwi8XYNUqNdpCD7gRMnPOrs1glp9f5sq0qP
         IIi2DT00KTxCg5Q0AOK2Xe81Vm0mxg/cXphVGH30=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Mon, 31 Jul 2023 16:24:35 +0300
Subject: [PATCH v3 1/9] media: i2c: ds90ub9x3: Fix sub-device matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-fpdlink-additions-v3-1-8acfc49c215a@ideasonboard.com>
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
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=CWOBqaJNAdPeoqe+d1O2pTibjSWEKIHUROFn5FDzjlc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkx7Y+TUX873kNfc2kqlxacUFaCJCdj0rl0gcBx
 +XPewlcZkuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMe2PgAKCRD6PaqMvJYe
 9XmdD/4505K8ecg5yJrvfd8RMFYwdHnvVGDzcBoWm3hXxKtBSZpBYAx5oSEh6AqAUFiq0NDWClh
 K52xiBqaZaQpUEiNazezljNI/sGcuezkaPPG449gesylTdCv/soXgLBW5POM3bj017D1lyzdLk8
 X33fy1Z7j/fVqYntfHwtcV26IulJlo4n9HeOc5i/8RmlBdqX7oK0Voy+3KuAmJ22qmcaV0AlS03
 o1XBlULGtvMxARv092nyHLIiduYyQUocQbfrqIrOLYslan5Us9ofmJMKt+q3IDTh3Yr6bG5/hXT
 xkR5AOI/sUQVd/IdwtvKZZis6YVbi9zeqqvwdyT9nihll5rUZfX2yTyOxYuOQPf2l2KLFjNG9QU
 dlg65B8UyknkzlU7/YDOh+j6raHl/acxJEihh17T3upXuGGd8xc746NQOSYTAwvSsoMuv61XJZx
 VT1bN4+0OTOIXIV6nypyAmPmDu3eGpG/obMUZJR0BLKKDVm16uSeSB+ldnUTp2VBh3LmGeIs4Gt
 P/Hq1j5OpLaXnciQQ8JV4n/xf4wDP8r4EkeE+I8ArYj6cx6f5EaMTfjwmoVX9XpD16fGQTliqGE
 eeYiBLjq6fFcZ9H+pjac5yHblinte7WJxqQQ64IfyzKkpN4t4j9P5Ipzqeg+q7SqXVpd/+pSkhp
 7LFOfw0d6rSSZqQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode
matching") recently changed how async sub-device matching works. This
breaks the UB9x3 drivers, as they set the subdev.fwnode to an endpoint.
Afaiu, the fix is simply to not set subdev.fwnode at all.

Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ds90ub913.c | 14 +-------------
 drivers/media/i2c/ds90ub953.c | 13 +------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
index 80d9cf6dd945..5410ccb54057 100644
--- a/drivers/media/i2c/ds90ub913.c
+++ b/drivers/media/i2c/ds90ub913.c
@@ -749,19 +749,9 @@ static int ub913_subdev_init(struct ub913_data *priv)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init pads\n");
 
-	priv->sd.fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
-							  UB913_PAD_SOURCE, 0,
-							  0);
-
-	if (!priv->sd.fwnode) {
-		ret = -ENODEV;
-		dev_err_probe(dev, ret, "Missing TX endpoint\n");
-		goto err_entity_cleanup;
-	}
-
 	ret = v4l2_subdev_init_finalize(&priv->sd);
 	if (ret)
-		goto err_fwnode_put;
+		goto err_entity_cleanup;
 
 	ret = ub913_v4l2_notifier_register(priv);
 	if (ret) {
@@ -782,8 +772,6 @@ static int ub913_subdev_init(struct ub913_data *priv)
 	ub913_v4l2_nf_unregister(priv);
 err_subdev_cleanup:
 	v4l2_subdev_cleanup(&priv->sd);
-err_fwnode_put:
-	fwnode_handle_put(priv->sd.fwnode);
 err_entity_cleanup:
 	media_entity_cleanup(&priv->sd.entity);
 
diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index cadf75eb0773..20b9cf893f74 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -1221,18 +1221,9 @@ static int ub953_subdev_init(struct ub953_data *priv)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init pads\n");
 
-	priv->sd.fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
-							  UB953_PAD_SOURCE, 0,
-							  0);
-	if (!priv->sd.fwnode) {
-		ret = -ENODEV;
-		dev_err_probe(dev, ret, "Missing TX endpoint\n");
-		goto err_entity_cleanup;
-	}
-
 	ret = v4l2_subdev_init_finalize(&priv->sd);
 	if (ret)
-		goto err_fwnode_put;
+		goto err_entity_cleanup;
 
 	ret = ub953_v4l2_notifier_register(priv);
 	if (ret) {
@@ -1253,8 +1244,6 @@ static int ub953_subdev_init(struct ub953_data *priv)
 	ub953_v4l2_notifier_unregister(priv);
 err_free_state:
 	v4l2_subdev_cleanup(&priv->sd);
-err_fwnode_put:
-	fwnode_handle_put(priv->sd.fwnode);
 err_entity_cleanup:
 	media_entity_cleanup(&priv->sd.entity);
 

-- 
2.34.1

