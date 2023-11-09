Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4847E72CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345214AbjKIU3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345181AbjKIU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:14 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FC344B6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeF-00032b-I0; Thu, 09 Nov 2023 21:29:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeF-007rX3-3v; Thu, 09 Nov 2023 21:29:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeE-00GGu9-Qi; Thu, 09 Nov 2023 21:29:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 10/12] bus: ti-pwmss: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:40 +0100
Message-ID: <20231109202830.4124591-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IiUhWp+R9SDimNa6PMkD/UFH/SAwMLvdBfB4LRnQOD4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUD6GHJK2UFwCF/Nj5OAVtRMKGRi41NJClHLd QCvO1P2Y2WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A+gAKCRCPgPtYfRL+ Tg4NB/wKQHLtuGfz4DBpdTgoDFZ9LgEa1BARbMLRGcjq++n46VI0Z3vZ3CNHHEwE/n8S21AKns8 4K10rjdJJrv0fzcZEo/y2NVMQH7o+P+kClY4E5xCpODZ5puAV52P0d9nl82XpNLQTmCoK7BpY1B Sxnja46qIh32/iUOWwfIKJBy14LDCD5Lr3UuH3OIScd8XHD8SgD2OqYWpIGxI86LTd0BSrowN8d WAQglBy+YHMkvSLwZTbjw5si0pCYCnqkbCjmVa+k9mM0BJegS368NPNsc9wUujkIIdw8qDFUZtP cSdkHJkzFNMScrNy5+FC1FtG61vq7A7yAB/iOZeSKXSGYR0h
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
 drivers/bus/ti-pwmss.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/ti-pwmss.c b/drivers/bus/ti-pwmss.c
index 480a4de76cd4..4969c556e752 100644
--- a/drivers/bus/ti-pwmss.c
+++ b/drivers/bus/ti-pwmss.c
@@ -33,10 +33,9 @@ static int pwmss_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pwmss_remove(struct platform_device *pdev)
+static void pwmss_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static struct platform_driver pwmss_driver = {
@@ -45,7 +44,7 @@ static struct platform_driver pwmss_driver = {
 		.of_match_table	= pwmss_of_match,
 	},
 	.probe	= pwmss_probe,
-	.remove	= pwmss_remove,
+	.remove_new = pwmss_remove,
 };
 
 module_platform_driver(pwmss_driver);
-- 
2.42.0

