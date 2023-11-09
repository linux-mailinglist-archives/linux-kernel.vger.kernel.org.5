Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEED7E72CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbjKIU3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbjKIU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:14 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D20A4686
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeE-00030M-UT; Thu, 09 Nov 2023 21:29:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeE-007rWv-FX; Thu, 09 Nov 2023 21:29:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeE-00GGtr-6M; Thu, 09 Nov 2023 21:29:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 08/12] bus: tegra-aconnect: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:38 +0100
Message-ID: <20231109202830.4124591-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=DCjzLmArjbIJmgPamQIMNlOs/ctX6rWbk9ESzC1W4p0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUD4qCwJcPbaNAqXFcVETTV8fpOGPLhYz/HBV 3qBjiDFghSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A+AAKCRCPgPtYfRL+ TnudB/4y0ylnfR8RGKM3J73U2ukapU5VJE27ezW0BBv0q99gi/DvxL6BG/gf/qLmu/QKtjFVwuI w9XxhH35DErsI5m3HsqiBf5PM+nM2gsCwWNuNdyEVp7L3tdXMzHvjH2SlKCaeAFG4PA7dKgBXRd 28gR/EGQcKC07X2eweUoRmf6v0sSVsLES3fWxiN7D+mfVZzB7vcQIKfTVson87cQQ+x6zB3XrfI F9L9kN2S2Y6MQBFFXM/0sTtZnu8WSZu10bBMP2zhKi79HZOt76JXmRSlBRKBJSi5Dqhav2zaAFU hmmEbWaHxNd8kdfEUWNN0aqSVyRdeUur8hf1GX6Dqvcsn16j
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
 drivers/bus/tegra-aconnect.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/tegra-aconnect.c b/drivers/bus/tegra-aconnect.c
index ac58142301f4..de80008bff92 100644
--- a/drivers/bus/tegra-aconnect.c
+++ b/drivers/bus/tegra-aconnect.c
@@ -53,11 +53,9 @@ static int tegra_aconnect_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_aconnect_remove(struct platform_device *pdev)
+static void tegra_aconnect_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static int tegra_aconnect_runtime_resume(struct device *dev)
@@ -106,7 +104,7 @@ MODULE_DEVICE_TABLE(of, tegra_aconnect_of_match);
 
 static struct platform_driver tegra_aconnect_driver = {
 	.probe = tegra_aconnect_probe,
-	.remove = tegra_aconnect_remove,
+	.remove_new = tegra_aconnect_remove,
 	.driver = {
 		.name = "tegra-aconnect",
 		.of_match_table = tegra_aconnect_of_match,
-- 
2.42.0

