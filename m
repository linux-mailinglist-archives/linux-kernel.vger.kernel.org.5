Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96A27E72CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbjKIU3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345176AbjKIU3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:13 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD42844BB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeE-0002zX-SK; Thu, 09 Nov 2023 21:29:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeC-007rWX-Qx; Thu, 09 Nov 2023 21:29:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeC-00GGtP-Ht; Thu, 09 Nov 2023 21:29:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jay Fang <f.fangjian@huawei.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 01/12] bus: hisi_lpc: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:31 +0100
Message-ID: <20231109202830.4124591-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5AZNdjzJwHWz0slz9MDShONzNbivb6y7QJLchsJRFkk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUDvHN/cjdII1SSU5qZzP2524CDEuqVPHLnD/ Y6lU3Vv1juJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A7wAKCRCPgPtYfRL+ Tm9GB/4mE4RwhXz/CyJzR+mFdS6oldaSkbL0ziI1WpRhyQ6mwKF/uE6Qo6k1XGeUkLiNB2RpB5y Sf4DUeGKHwECLJ/rQ3kKPhpGO2oQN/vtmSOdpc65EpFHWKyEAXFkZ7oKUcbfB+rPptiXo3wQNQo hXzMJwssCkrtmN9NC43lra1MU+qoiD2glFkZi1E7gZLqEWXE+Qntxj4PSN++zWE3NaQiz0xl64B CxD6XrIOhPPWRvpQeUQcP7lkBVBifyr0b4HiSsg2zBfXQawRh7RAn2Tsj1BPxFyi9VihJq9yawf hpGsLG6K24/LN1y1bAgmcOefWFkl7kjiaD+FFduSWidFV7Pg
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
 drivers/bus/hisi_lpc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index cdc4e38c113e..09340adbacc2 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -657,7 +657,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hisi_lpc_remove(struct platform_device *pdev)
+static void hisi_lpc_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct hisi_lpc_dev *lpcdev = dev_get_drvdata(dev);
@@ -669,8 +669,6 @@ static int hisi_lpc_remove(struct platform_device *pdev)
 		of_platform_depopulate(dev);
 
 	logic_pio_unregister_range(range);
-
-	return 0;
 }
 
 static const struct of_device_id hisi_lpc_of_match[] = {
@@ -691,6 +689,6 @@ static struct platform_driver hisi_lpc_driver = {
 		.acpi_match_table = hisi_lpc_acpi_match,
 	},
 	.probe = hisi_lpc_probe,
-	.remove = hisi_lpc_remove,
+	.remove_new = hisi_lpc_remove,
 };
 builtin_platform_driver(hisi_lpc_driver);
-- 
2.42.0

