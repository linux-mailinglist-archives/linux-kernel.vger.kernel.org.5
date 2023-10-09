Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06E67BEC93
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378670AbjJIVPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378765AbjJIVOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B24193
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:14:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A628C433C7;
        Mon,  9 Oct 2023 21:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886071;
        bh=iejH9NjJRnuNyjxIKdKYWnTdtdDsE9ixrQ/D6TJFA6M=;
        h=From:To:Cc:Subject:Date:From;
        b=YrIUEfCS9d2sLC4rxiSsDdT5qL9HpTUZB2BesiZvVT4OStPogRrsHM6iOtMg0lAl9
         GTKFWyQk/fXOBa9l1P3Cg2LKggUUoETeIlLzvvt49XBVQBcyRHAW/nGxlt6ndJaghc
         6cJYfB/YdioIRkhoa5CThDDi0ynW7T203+CwqiPLNli8RW8vlEzsIKAuGHxkrWQEID
         oh56o0QMLBlGHECQhOy8cbYNa5U/ix3zv0zjENOwgR1DU2InkKce2gXmWOWMNpxPM5
         EDRJmZsv9jmLBjEj3y+9LEdtAXO69Dj9caHm0yMSmBT9kns7yOTHrH+vzWcDDe7UBP
         uNLbN8M6nFI0Q==
Received: (nullmailer pid 3246251 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: knav_qmss_queue: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 16:13:43 -0500
Message-ID: <20231009211356.3242037-13-robh@kernel.org>
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
 drivers/soc/ti/knav_qmss_queue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index cea791717957..06fb5505c22c 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -14,10 +14,12 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/soc/ti/knav_qmss.h>
 
@@ -1754,7 +1756,6 @@ static int knav_queue_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *qmgrs, *queue_pools, *regions, *pdsps;
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	u32 temp[2];
 	int ret;
@@ -1770,8 +1771,7 @@ static int knav_queue_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	match = of_match_device(of_match_ptr(keystone_qmss_of_match), dev);
-	if (match && match->data)
+	if (device_get_match_data(dev))
 		kdev->version = QMSS_66AK2G;
 
 	platform_set_drvdata(pdev, kdev);
-- 
2.42.0

