Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D713F7E72C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345166AbjKIU3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345159AbjKIU3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:09 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1637544B6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeD-0002ze-Gr; Thu, 09 Nov 2023 21:29:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeD-007rWa-1m; Thu, 09 Nov 2023 21:29:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeC-00GGtT-Oq; Thu, 09 Nov 2023 21:29:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 02/12] bus: omap-ocp2scp: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:32 +0100
Message-ID: <20231109202830.4124591-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FFKpIApq6M4HDMVMY1N4u4aY2zqamgYSCbjMD8II194=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlRfhw/3I82cxO40Xj0o6Stap2DN4aX/8m24xqyYvLgP7 48suvCjk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJHIrnYJiq6rqXJ1rUS6xR iOs/X88Ef1a1Cecdlxet4JzzoOXc4X1HOHUOOEp9kDc1/6PbyZtyImj/qzLJe95nRX3Ocv5/t9V rSh3HRu9XZowx5xZPl+WJV++pP9S91OjlqXLu35HpLsFuk+1NvU7Zzk3ynfq5yimT72XhreQei8 Pp4s2WGbE3eM1ltl1sCzt7bIFHtT3jew7P1Gzz8jVsua4NVywda6bu/v4t9GfDuotnJW+vMdmck r76RXjBco/wn1bLL2hXfO16kerab1M3zcUo5Oj2Kt7p3q/1+6zspUre+ctZ3GOJMam7EXM+a3X6 3vcNduw3G9ick+1V33Rxrdo4ycqt5PmPtgv5Bacjbs0DAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/omap-ocp2scp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
index e02d0656242b..7d7479ba0a75 100644
--- a/drivers/bus/omap-ocp2scp.c
+++ b/drivers/bus/omap-ocp2scp.c
@@ -84,12 +84,10 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap_ocp2scp_remove(struct platform_device *pdev)
+static void omap_ocp2scp_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 	device_for_each_child(&pdev->dev, NULL, ocp2scp_remove_devices);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -103,7 +101,7 @@ MODULE_DEVICE_TABLE(of, omap_ocp2scp_id_table);
 
 static struct platform_driver omap_ocp2scp_driver = {
 	.probe		= omap_ocp2scp_probe,
-	.remove		= omap_ocp2scp_remove,
+	.remove_new	= omap_ocp2scp_remove,
 	.driver		= {
 		.name	= "omap-ocp2scp",
 		.of_match_table = of_match_ptr(omap_ocp2scp_id_table),
-- 
2.42.0

