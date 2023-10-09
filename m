Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF17BE839
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378117AbjJIRdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378018AbjJIRc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:32:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2DF132;
        Mon,  9 Oct 2023 10:32:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB0BC433C8;
        Mon,  9 Oct 2023 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872771;
        bh=SVXshXiEdwU2vmo+Rd2WRtoCqJf4zLLOZYef9zCZqeM=;
        h=From:To:Cc:Subject:Date:From;
        b=KIiaAQun92uGEzEnXnpSCd6MxUz9S9l94W/P1vnDz2MTFrn61Rip6EzZC7q4cWFgb
         ZA0UypE1C/YicJpz4OqcALR72Yu4e4OyKLuWvVftWPy7DWEG59nJY0NpoDbo07Btch
         uSG7qF+InS+Yi1vPANVq286rpM+aDPYQSj0pLuo8SpSe5JtOs2oir7sT8kGlhi2qHl
         NEIMOWTcubNYEbsEiDlL7TkHclJJTwAT7x8WiA0VjCiuY17mK1cFODuOf2ADlQf46A
         42pHJbHheRyujLP5NxwtI4IT1LJ9hhUYh/QASvPCod3fcZwbK2EVV27e+h5KJu8RHb
         Yh/akRVn+ZNGw==
Received: (nullmailer pid 2532666 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: vexpress: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 12:29:14 -0500
Message-ID: <20231009172923.2457844-19-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
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
 drivers/power/reset/vexpress-poweroff.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 17064d7b19f6..bb22b2db5907 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -7,8 +7,8 @@
 #include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/stat.h>
 #include <linux/vexpress.h>
@@ -108,20 +108,17 @@ static int _vexpress_register_restart_handler(struct device *dev)
 
 static int vexpress_reset_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-			of_match_device(vexpress_reset_of_match, &pdev->dev);
+	enum vexpress_reset_func func;
 	struct regmap *regmap;
 	int ret = 0;
 
-	if (!match)
-		return -EINVAL;
-
 	regmap = devm_regmap_init_vexpress_config(&pdev->dev);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 	dev_set_drvdata(&pdev->dev, regmap);
 
-	switch ((uintptr_t)match->data) {
+	func = (uintptr_t)device_get_match_data(&pdev->dev);
+	switch (func) {
 	case FUNC_SHUTDOWN:
 		vexpress_power_off_device = &pdev->dev;
 		pm_power_off = vexpress_power_off;
-- 
2.42.0

