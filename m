Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A50F7E72CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345179AbjKIU3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345159AbjKIU3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:11 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7594B3A98
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeF-00035R-Ub; Thu, 09 Nov 2023 21:29:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeF-007rXA-I3; Thu, 09 Nov 2023 21:29:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeF-00GGuH-8y; Thu, 09 Nov 2023 21:29:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 12/12] bus: ts-nbus: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:42 +0100
Message-ID: <20231109202830.4124591-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JH5kPuzEZrv1BLWpBstXob4NKgRDBn8Mt+gM+m29Vns=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUD83Hvw2vn4606kwYrMwHfTvBMJmXhl8Ha7Z PXT4QIU/b2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A/AAKCRCPgPtYfRL+ TnV9CACkna96FEvGPjHKbIWT91Mj1tUEBnRGMqCGqw6W/lo2aTrmHVcEQ5y3V6UmiZx3GmOhAce uIYXR5phGMB/MUEKwsoZXjULKr361Sopu1KPeszQXhK5Dp7YjMywGlaEEJgOWa5gUedsPZnNG0j udv+CJZOHwB5l8wvUZ2Uj+jljRxFVpUmsy+hxxgTuLIqUqpImDnKVg5LgLQlThTwVaHi9Vp+DZJ L/QauhUZv+Fkwv9bdSWAj0byGSz0qVSm/UDi65CYvfnH4uAyjLmmei4mCWXwJ9A6nliYqeainvb 655/wplAawGhq6iNdGbLv9DTgAftmEDa5twCkjhYa11IAfa5
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
 drivers/bus/ts-nbus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 38c886dc2ed6..4fa932cb0915 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -331,7 +331,7 @@ static int ts_nbus_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ts_nbus_remove(struct platform_device *pdev)
+static void ts_nbus_remove(struct platform_device *pdev)
 {
 	struct ts_nbus *ts_nbus = dev_get_drvdata(&pdev->dev);
 
@@ -339,8 +339,6 @@ static int ts_nbus_remove(struct platform_device *pdev)
 	mutex_lock(&ts_nbus->lock);
 	pwm_disable(ts_nbus->pwm);
 	mutex_unlock(&ts_nbus->lock);
-
-	return 0;
 }
 
 static const struct of_device_id ts_nbus_of_match[] = {
@@ -351,7 +349,7 @@ MODULE_DEVICE_TABLE(of, ts_nbus_of_match);
 
 static struct platform_driver ts_nbus_driver = {
 	.probe		= ts_nbus_probe,
-	.remove		= ts_nbus_remove,
+	.remove_new	= ts_nbus_remove,
 	.driver		= {
 		.name	= "ts_nbus",
 		.of_match_table = ts_nbus_of_match,
-- 
2.42.0

