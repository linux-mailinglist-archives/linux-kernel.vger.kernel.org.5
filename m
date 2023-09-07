Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94317979B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbjIGRSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbjIGRSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:18:41 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A0A1FD0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:18:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387HHIuV057569;
        Thu, 7 Sep 2023 12:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694107038;
        bh=vq7So6xb27BfuWlAt3oT5BbUy0TQs3s+9Xai7gTKSeg=;
        h=From:To:CC:Subject:Date;
        b=n27lVO45CyeCM0m+BoLgrpDhLHYSVPo2Z37QNlGYyG5TAB7CROM74G1paRD48WgKb
         BWes6L0HEomGFzfk9amXP0/vFKVQeNKgPlysi2hZzWwtxCGFJesWyOXlJFP8oolFdI
         Pvqetsv2erwKWWoRRIafuqVO6fCkMSCt0djxKb7c=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387HHIFW016247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Sep 2023 12:17:18 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 12:17:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 12:17:18 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387HHF8s018421;
        Thu, 7 Sep 2023 12:17:15 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <vibhore@ti.com>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH] firmware: ti_sci: Mark driver as non removable
Date:   Thu, 7 Sep 2023 22:47:00 +0530
Message-ID: <20230907171700.1922453-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI-SCI message protocol provides a way to communicate between
various compute processors with a central system controller entity. It
provides the fundamental device management capability and clock control
in the SOCs that it's used in.

Ensure that the driver isn't unbound by suppressing its bind and unbind
sysfs attributes. As the driver is built-in there is no way to remove
device once bound.

We can also remove the ti_sci_remove call along with the
ti_sci_debugfs_destroy as there are no callers for it any longer.

Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>

Thanks for bringing up the potential issue Uwe, sharing link below for
context:
https://lore.kernel.org/all/20230216083908.mvmydic5lpi3ogo7@pengutronix.de/

This patch is also inspired from the commit bbfa509d632946578d4f
("powerpc/ep8248e: Mark driver as non removable")

base: cd04b2fab5ee (tag: next-20230907) Add linux-next specific files for 20230907

 drivers/firmware/ti_sci.c | 46 +--------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 26a37f47f4ca..66c3846c9147 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -190,19 +190,6 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
 	return 0;
 }
 
-/**
- * ti_sci_debugfs_destroy() - clean up log debug file
- * @pdev:	platform device pointer
- * @info:	Pointer to SCI entity information
- */
-static void ti_sci_debugfs_destroy(struct platform_device *pdev,
-				   struct ti_sci_info *info)
-{
-	if (IS_ERR(info->debug_region))
-		return;
-
-	debugfs_remove(info->d);
-}
 #else /* CONFIG_DEBUG_FS */
 static inline int ti_sci_debugfs_create(struct platform_device *dev,
 					struct ti_sci_info *info)
@@ -3449,43 +3436,12 @@ static int ti_sci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_sci_remove(struct platform_device *pdev)
-{
-	struct ti_sci_info *info;
-	struct device *dev = &pdev->dev;
-	int ret = 0;
-
-	of_platform_depopulate(dev);
-
-	info = platform_get_drvdata(pdev);
-
-	if (info->nb.notifier_call)
-		unregister_restart_handler(&info->nb);
-
-	mutex_lock(&ti_sci_list_mutex);
-	if (info->users)
-		ret = -EBUSY;
-	else
-		list_del(&info->node);
-	mutex_unlock(&ti_sci_list_mutex);
-
-	if (!ret) {
-		ti_sci_debugfs_destroy(pdev, info);
-
-		/* Safe to free channels since no more users */
-		mbox_free_channel(info->chan_tx);
-		mbox_free_channel(info->chan_rx);
-	}
-
-	return ret;
-}
-
 static struct platform_driver ti_sci_driver = {
 	.probe = ti_sci_probe,
-	.remove = ti_sci_remove,
 	.driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
+		   .suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(ti_sci_driver);
-- 
2.34.1

