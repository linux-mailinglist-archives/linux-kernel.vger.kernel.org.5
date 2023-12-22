Return-Path: <linux-kernel+bounces-10103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 190F381CFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1CCB23D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B336B381DA;
	Fri, 22 Dec 2023 22:51:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E62E84F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMM-0005cI-Bt; Fri, 22 Dec 2023 23:51:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMK-000qvH-JV; Fri, 22 Dec 2023 23:51:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-000FfS-1y;
	Fri, 22 Dec 2023 23:51:13 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 07/13] irqchip/mvebu-pic: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:38 +0100
Message-ID:  <df977ad4c02ff913b01cdd6c348e7fae3e08e651.1703284359.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=YEdXLtjjB7MdLkwVRjWTzbmlfH5H3E2yBwtLiqFjuN8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhhK/qY6qVh1CQvCesFeEHW82L2SThLnfZpHqn YQVEAd4ZOmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYYSvwAKCRCPgPtYfRL+ ToKsB/0YopidcAoPuZVZY8pzovI6MHDYU0tVfCD6UxIrJpBC2C6kFSoxYL7QN8up16WNvLYE2lR f1gTuaISvFVhWpGshqK81Awjdo4FwaBqZQMEgvVWG3niOKVIZ9WRi+DhoFSh0/uml6a3+Q3YZ5V zopiut6A9xnm6NHJuXcB08ukkBF1uFnSPgEnCk0tZs027gIymP93N83affj48eHQLFkzr74/Qhs gjiH+VFZ3cr4ae03XZq4s5kGp4pL2TS/Y1qVlDNxCQD6OtPxGjNIeo6Rj8xNBL5dr58IANxom1A 1uMIbpQ1Hk3z7J/0DZVCkbhf0PcGbknLCaPIJx0rR6vyLuc1
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
 drivers/irqchip/irq-mvebu-pic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index ef3d3646ccc2..57e3f99b61f5 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -167,14 +167,12 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mvebu_pic_remove(struct platform_device *pdev)
+static void mvebu_pic_remove(struct platform_device *pdev)
 {
 	struct mvebu_pic *pic = platform_get_drvdata(pdev);
 
 	on_each_cpu(mvebu_pic_disable_percpu_irq, pic, 1);
 	irq_domain_remove(pic->domain);
-
-	return 0;
 }
 
 static const struct of_device_id mvebu_pic_of_match[] = {
@@ -185,7 +183,7 @@ MODULE_DEVICE_TABLE(of, mvebu_pic_of_match);
 
 static struct platform_driver mvebu_pic_driver = {
 	.probe  = mvebu_pic_probe,
-	.remove = mvebu_pic_remove,
+	.remove_new = mvebu_pic_remove,
 	.driver = {
 		.name = "mvebu-pic",
 		.of_match_table = mvebu_pic_of_match,
-- 
2.42.0


