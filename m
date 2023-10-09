Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC27BEC86
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378675AbjJIVOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378711AbjJIVOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA70AB6;
        Mon,  9 Oct 2023 14:14:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95544C433CA;
        Mon,  9 Oct 2023 21:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886062;
        bh=XqIqec+pw9iYlZMOI9gBZnvFzmC89KjXzQC2GvxygF4=;
        h=From:To:Cc:Subject:Date:From;
        b=nLmGy1oztAI1senaE9kaG+07yEaCgj31xYXfkt/5QbxmORxl0rC4BWcy+PopIxu13
         AiDE2qSrE1Kgo8ZxiutfMErLbDT3xCIYwNlaI0r4LALfZ6l8BSQb1OZKPy+FU22p+Y
         4H4kJcaOIduuy1JkYgOvh6rpbH9YlNZFH8vnGtuWaXy6OXTTcbNvyqArCXy6I6GqEo
         rvds4LLWICwDTz023QYdgfKmFcWRUy4sGoHnK0ZmN5I0U8zfpW4TT7Lh1tXRbvP7aK
         CXhlgeQGKv6rgR6f+OjV4MoO6XztZx2LQNPu/3MjEddl22nODF+32XBom0OA+chqNd
         SY1KpwqPV2J0g==
Received: (nullmailer pid 3246018 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: st: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 16:13:40 -0500
Message-ID: <20231009211356.3242037-10-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/remoteproc/st_remoteproc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index e3ce01d98b4c..b0638f984842 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -16,10 +16,9 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
@@ -341,7 +340,6 @@ static int st_rproc_parse_dt(struct platform_device *pdev)
 static int st_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
 	struct st_rproc *ddata;
 	struct device_node *np = dev->of_node;
 	struct rproc *rproc;
@@ -349,19 +347,15 @@ static int st_rproc_probe(struct platform_device *pdev)
 	int enabled;
 	int ret, i;
 
-	match = of_match_device(st_rproc_match, dev);
-	if (!match || !match->data) {
-		dev_err(dev, "No device match found\n");
-		return -ENODEV;
-	}
-
 	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
 	if (!rproc)
 		return -ENOMEM;
 
 	rproc->has_iommu = false;
 	ddata = rproc->priv;
-	ddata->config = (struct st_rproc_config *)match->data;
+	ddata->config = (struct st_rproc_config *)device_get_match_data(dev);
+	if (!ddata->config)
+		goto free_rproc;
 
 	platform_set_drvdata(pdev, rproc);
 
-- 
2.42.0

