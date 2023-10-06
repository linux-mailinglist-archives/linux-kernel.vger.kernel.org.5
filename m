Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF8A7BC150
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjJFVjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjJFVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:39:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFF9185;
        Fri,  6 Oct 2023 14:39:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7264FC433CB;
        Fri,  6 Oct 2023 21:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628356;
        bh=KOey3waN6ffVSfn0qfjxnmBrlFFQ4d0BRx5/VjhJFvI=;
        h=From:To:Cc:Subject:Date:From;
        b=b1ncxJpbZL/htugLz2JMwoueHn5a377shvJmt8RiyXpc2obwbfbqHDZi62/rRcqyA
         hRHoOfWuI8mf21l+hUJVEvieNM6O0Pud/KZ4VajE3OX9w/IQ5tX8vxEPLa4W8ne5VG
         jmqqDzXsf6Fx8e9DVHqmrzipTXLHhgpbZharQhciuBpq6Rhwq57nxId37mN9H64a7Z
         2wuD7xZiWE2uu9CNbPaAYNowntx/znkEU+rn3C4H15qCOQw6TSz7YQsp26Tq5YvEvb
         tQYIAl65nvIbm84A+hMezcpHvrA3YE3JGV3Xramgyd8UtdL1P6sxrKmaFfwZHaDAS0
         ato+0w8DkGl2w==
Received: (nullmailer pid 333645 invoked by uid 1000);
        Fri, 06 Oct 2023 21:39:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: exynos-ppmu: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:38:54 -0500
Message-Id: <20231006213854.333261-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/devfreq/event/exynos-ppmu.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 896a6cc93b00..56bac4702006 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -12,9 +12,9 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/suspend.h>
 #include <linux/devfreq-event.h>
@@ -507,7 +507,6 @@ static int of_get_devfreq_events(struct device_node *np,
 	struct device *dev = info->dev;
 	struct device_node *events_np, *node;
 	int i, j, count;
-	const struct of_device_id *of_id;
 	int ret;
 
 	events_np = of_get_child_by_name(np, "events");
@@ -525,13 +524,7 @@ static int of_get_devfreq_events(struct device_node *np,
 	}
 	info->num_events = count;
 
-	of_id = of_match_device(exynos_ppmu_id_match, dev);
-	if (of_id)
-		info->ppmu_type = (enum exynos_ppmu_type)of_id->data;
-	else {
-		of_node_put(events_np);
-		return -EINVAL;
-	}
+	info->ppmu_type = (enum exynos_ppmu_type)device_get_match_data(dev);
 
 	j = 0;
 	for_each_child_of_node(events_np, node) {
-- 
2.40.1

