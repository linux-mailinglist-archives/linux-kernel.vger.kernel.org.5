Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE537E72D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbjKIU3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbjKIU3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:15 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3944BB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeF-00033N-OC; Thu, 09 Nov 2023 21:29:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeF-007rX7-Aa; Thu, 09 Nov 2023 21:29:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeF-00GGuD-1O; Thu, 09 Nov 2023 21:29:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 11/12] bus: ti-sysc: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:41 +0100
Message-ID: <20231109202830.4124591-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=opTk4HTyURjB0GAHXubqOJ0QoyNNC03II0HWbr+XPDE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUD7++rpK6UFrsRtYltlQ1hWs00xrWDPQ+PR7 a0yuf2VwZCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A+wAKCRCPgPtYfRL+ TmE8B/4+R8UdQTyzVId2Y5KghT3jOlnVGcrlwPCYjGXUxBdn5orhi2SpN13OxnlaQcwfOTfyGhz wL9aJEod+w/fRiUVXvW9eDu90T9p9+0w8ZHpe0zV36adsT9hE6lqfyXDNmmOBCNxyia/LPIrfdZ D2jDnSXAHOLKKyXqLqvrVfTXneT4WFz0lkx/P5824KSHMfcZySPfqF+TAn8znuph3KrEc9aj2Tb SxX8sASUIE+NG2neTkASHaYKcsyL57R8lMOg2RC5UxCggM/6Jaq6gnrD4as3JpouexLwLjddOq8 N+GoHau3t/0hOzIVzVSYXhvvFpTzDtHIVlsSX+WgF7qfvSWj
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
 drivers/bus/ti-sysc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index d57bc066dce6..490841dbe0d8 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3387,7 +3387,7 @@ static int sysc_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int sysc_remove(struct platform_device *pdev)
+static void sysc_remove(struct platform_device *pdev)
 {
 	struct sysc *ddata = platform_get_drvdata(pdev);
 	int error;
@@ -3412,8 +3412,6 @@ static int sysc_remove(struct platform_device *pdev)
 
 unprepare:
 	sysc_unprepare(ddata);
-
-	return 0;
 }
 
 static const struct of_device_id sysc_match[] = {
@@ -3439,7 +3437,7 @@ MODULE_DEVICE_TABLE(of, sysc_match);
 
 static struct platform_driver sysc_driver = {
 	.probe		= sysc_probe,
-	.remove		= sysc_remove,
+	.remove_new	= sysc_remove,
 	.driver         = {
 		.name   = "ti-sysc",
 		.of_match_table	= sysc_match,
-- 
2.42.0

