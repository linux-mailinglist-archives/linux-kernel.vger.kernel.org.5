Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9407A9AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjIUSr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjIUSrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:47:18 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64493EE849
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:47:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38L9I5iK122575;
        Thu, 21 Sep 2023 04:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695287885;
        bh=Dm1e+plwHNwqQ1PDB+fSI8pFST4Rseh0QLTTgk3amws=;
        h=From:To:CC:Subject:Date;
        b=mJDEJkkxDqWwUogPca0RSQOUUPPqKrXZiLVU9iqVAqOSdKXueqfByTY1ZJmcvh9QE
         853SEgVdDUzP1gqzW9Bfmep0NKjzYOGccuigffBKF++kmmKApg38uqKcf+4ESEoWor
         Gi8xVGAgKicvUXJ0sXOv3pfqMcJCHIcqgwaogOx0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38L9I5cS030231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Sep 2023 04:18:05 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 04:18:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 04:18:05 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38L9I1AP079306;
        Thu, 21 Sep 2023 04:18:02 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH V2] firmware: ti_sci: Mark driver as non removable
Date:   Thu, 21 Sep 2023 14:40:26 +0530
Message-ID: <20230921091025.133130-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI-SCI message protocol provides a way to communicate between
various compute processors with a central system controller entity. It
provides the fundamental device management capability and clock control
in the SOCs that it's used in.

The remove function failed to do all the necessary cleanup if
there are registered users. Some things are freed however which
likely results in an oops later on.

Ensure that the driver isn't unbound by suppressing its bind and unbind
sysfs attributes. As the driver is built-in there is no way to remove
device once bound.

We can also remove the ti_sci_remove call along with the
ti_sci_debugfs_destroy as there are no callers for it any longer.

Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/linux-arm-kernel/20230216083908.mvmydic5lpi3ogo7@pengutronix.de/
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Link to v1:
https://lore.kernel.org/linux-arm-kernel/20230907171700.1922453-1-d-gole@ti.com/

Changelog:
Rebased, updated the commit message and added Reported and Closes tag.

Cc: Tero Kristo <kristo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>

---

 drivers/firmware/ti_sci.c | 46 +--------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index c288ae49f91c..ffca636cc13f 100644
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
@@ -3445,43 +3432,12 @@ static int ti_sci_probe(struct platform_device *pdev)
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

base-commit: 940fcc189c51032dd0282cbee4497542c982ac59
-- 
2.34.1

