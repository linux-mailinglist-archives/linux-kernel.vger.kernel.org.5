Return-Path: <linux-kernel+bounces-10102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B431581CFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22168B216BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35D0381D9;
	Fri, 22 Dec 2023 22:51:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51F2E853
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-0005bm-T8; Fri, 22 Dec 2023 23:51:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMK-000qvD-D7; Fri, 22 Dec 2023 23:51:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-000FfO-1L;
	Fri, 22 Dec 2023 23:51:13 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 06/13] irqchip/madera: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:37 +0100
Message-ID:  <64c2f79760c53f29651e7126418c407ff699317d.1703284359.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=oNyOtJmRK/PlWo4BKGbaCJgMzouADPvq3uSryPTzQhI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhhK9Y8lRVhNFkK9eJWWYKEZRt6Vy9FJ7h2sj6 VryWfbz2laJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYYSvQAKCRCPgPtYfRL+ TngFCACHKhMzBPTBKVocA6VfvDGmuukvynuqR9RfEljwyjneu/L12qaidTDwjPFQtNSEm6HZUBa K7ywfUFIwGDqS1YVFVeBCOV8jGXoZQ1+LY1U/MmzIzFuLOaUIu8bU2Rtqzq4dKUaXpuQFQ4XgN/ zHN+B6RKZtpT46Rivq79vpIoz+ujbj3zvTwiti73wKa72M9tvxC8H0l0UV1oqbQtq8wqtMMTNru aZL67AYTcfqSmIXXkOi0XtADOuwcMMChC1mY4F/J7L2+ro3Wf8NrGMpdohxtssProziTgnyhXrJ LUKLwQ6vOC4EWnqbFzHzpsKePslWuOr8y1HurRhaWAvl7i9V
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

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
 drivers/irqchip/irq-madera.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index 3eb1f8cdf674..b424c0a327f7 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -222,7 +222,7 @@ static int madera_irq_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int madera_irq_remove(struct platform_device *pdev)
+static void madera_irq_remove(struct platform_device *pdev)
 {
 	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
 
@@ -232,13 +232,11 @@ static int madera_irq_remove(struct platform_device *pdev)
 	 */
 	madera->irq_dev = NULL;
 	regmap_del_irq_chip(madera->irq, madera->irq_data);
-
-	return 0;
 }
 
 static struct platform_driver madera_irq_driver = {
 	.probe	= &madera_irq_probe,
-	.remove = &madera_irq_remove,
+	.remove_new = madera_irq_remove,
 	.driver = {
 		.name	= "madera-irq",
 		.pm	= &madera_irq_pm_ops,
-- 
2.42.0


