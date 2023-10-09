Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A517BE83B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377991AbjJIRdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378110AbjJIRc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:32:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33039184;
        Mon,  9 Oct 2023 10:32:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64278C433CB;
        Mon,  9 Oct 2023 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872772;
        bh=JQbWPDFsl0qN3wvjJzvnJTkMPT8Tve5fQAAfMjMgSmA=;
        h=From:To:Cc:Subject:Date:From;
        b=EcPaWquz30v0eQx4v7wpeCCivFKKYPuLfrITErlF9RNjiBTjCErFwD9riAKfpWQZW
         8nsOyRjcOa947N9aLyuAG/D9t5A1Z8WRgYfHbLByHuVmU+g5CxCls7SWuMdmb6XuOJ
         THrY6jYRnqBWYJrQE76l3wHPRo5VzId8m43qTjaHEhhqqoG5QKHfKFJx2Q2RIua/qI
         inCbIHg/+mG9huqSNUuHOPZwL2M1dH2WwpMStvdWMS48mVywRWAUbe/m3YPdEVrTK4
         8BTUdNN2jOxmOpqukCRgw/oWuYmpN63DEFsvy+Yw/xjtOSRN2AGrxCqyUwO38ApPMQ
         oaD8XNJbKMQpA==
Received: (nullmailer pid 2533476 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: cpcap: Drop non-DT driver matching
Date:   Mon,  9 Oct 2023 12:29:15 -0500
Message-ID: <20231009172923.2457844-20-robh@kernel.org>
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

Only DT based probing is used for the Motorola CPCAP charger driver, so
drop the !CONFIG_OF parts and redundant of_match_device() call.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/power/supply/cpcap-charger.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 431e951cccf0..cebca34ff872 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -17,8 +17,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
@@ -865,7 +864,6 @@ static const struct power_supply_desc cpcap_charger_usb_desc = {
 	.property_is_writeable = cpcap_charger_property_is_writeable,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id cpcap_charger_id_table[] = {
 	{
 		.compatible = "motorola,mapphone-cpcap-charger",
@@ -873,20 +871,13 @@ static const struct of_device_id cpcap_charger_id_table[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, cpcap_charger_id_table);
-#endif
 
 static int cpcap_charger_probe(struct platform_device *pdev)
 {
 	struct cpcap_charger_ddata *ddata;
-	const struct of_device_id *of_id;
 	struct power_supply_config psy_cfg = {};
 	int error;
 
-	of_id = of_match_device(of_match_ptr(cpcap_charger_id_table),
-				&pdev->dev);
-	if (!of_id)
-		return -EINVAL;
-
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
@@ -975,7 +966,7 @@ static struct platform_driver cpcap_charger_driver = {
 	.probe = cpcap_charger_probe,
 	.driver	= {
 		.name	= "cpcap-charger",
-		.of_match_table = of_match_ptr(cpcap_charger_id_table),
+		.of_match_table = cpcap_charger_id_table,
 	},
 	.shutdown = cpcap_charger_shutdown,
 	.remove_new = cpcap_charger_remove,
-- 
2.42.0

