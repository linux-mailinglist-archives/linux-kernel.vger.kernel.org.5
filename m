Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F5B7BEC8F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378740AbjJIVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378801AbjJIVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E378BFD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:14:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3B9C433CB;
        Mon,  9 Oct 2023 21:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886074;
        bh=ESmiH/TEMoyx2a7FlX65mUwzXaBIM0ko/o8gmuHHSoo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZZGGPv8QSL2rXh+PxVZvekJ/yuCN1VFSLEc6tXQOTwetm5HnA7ds3y1wIY5M4MFmc
         IEsixsfZBC9jQmqsIWRIFeMaO2bVmZ20Jo5sKT2I/VLE4HOMKflQsPekscqYoQLeYn
         g19UzVvIb+iH7kIwnnwCFo8H8/GVVjYyS2Xkq1MVPg57e5pk9iqjpyHNEdavd+UQ5f
         1b4Ql9ZUueL3emkuU2N4q/utxrQhHks5VjKvLRuweDt7tkBeyAgFQiXmJHL4lsM0Uu
         Np/IHyxjMvCbvOvOuVAPir61fSQGmMyD1q/F47sTZG2Q+oaGfIZ0IfMPoR0Be4rQW+
         4n7YjbV4LfsjA==
Received: (nullmailer pid 3246161 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: omap: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 16:13:42 -0500
Message-ID: <20231009211356.3242037-12-robh@kernel.org>
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
 drivers/rtc/rtc-omap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 5b10ab06cd2e..c6155c48a4ac 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -18,12 +18,12 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/rtc.h>
 #include <linux/rtc/rtc-omap.h>
 
@@ -729,16 +729,14 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	struct omap_rtc	*rtc;
 	u8 reg, mask, new_ctrl;
 	const struct platform_device_id *id_entry;
-	const struct of_device_id *of_id;
 	int ret;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
-	of_id = of_match_device(omap_rtc_of_match, &pdev->dev);
-	if (of_id) {
-		rtc->type = of_id->data;
+	rtc->type = device_get_match_data(&pdev->dev);
+	if (rtc->type) {
 		rtc->is_pmic_controller = rtc->type->has_pmic_mode &&
 			of_device_is_system_power_controller(pdev->dev.of_node);
 	} else {
-- 
2.42.0

