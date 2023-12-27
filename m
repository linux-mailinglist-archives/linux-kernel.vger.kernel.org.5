Return-Path: <linux-kernel+bounces-12260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479181F216
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A465B2294C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D49482DC;
	Wed, 27 Dec 2023 21:03:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F347F7C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3K-0000pG-42; Wed, 27 Dec 2023 22:02:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3I-001wF0-KN; Wed, 27 Dec 2023 22:02:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-001ZVY-24;
	Wed, 27 Dec 2023 22:02:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 05/12] mailbox: mtk-cmdq: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:33 +0100
Message-ID:  <f09086fb0576e17c5b06ea5a75e1098fb24030ec.1703710628.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gNPFN0uAuZF4HtjtcHLTvZm1u6vrMLv8Z7jJatbefZk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDr7aKKKkVi7JPQZLLyFYy5nVbjgdGseMIZH +nO7DQaZKSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ6wAKCRCPgPtYfRL+ TirnCACWp3emXtbPKi6jzWJqse5aOSB0rU4Fj6ztni02KHtV0f8QZ8mlamimBQs1wwAFg3JamtL vtLD4W2EKwQr/k7CfonS4FAniuFJo5arz0+UqychTpBJ9ZY1vjHltDudQ6NyiqSbuNfEQ9znAID QYQCNrizRfXOn+Da8HpY0QMUoj3HEsb3SyzjnE8dDrM0aZcGGcUlKbKUq5ZzPKBEbYgKxVB7VCi ZkKEV1DeW1j9lqvyr6x6b9w95nbTQiClhVqqDKA0jEgJkeZDfpnRVaMXM9cz6uVPhREyAUtTDQ5 6JE6oYD9RAd4NQ3d/t5saKBBj1HXwkt1vcbwzKv24K8YHXqc
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
 drivers/mailbox/mtk-cmdq-mailbox.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index de862e9137d5..c9009b729ab2 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -367,7 +367,7 @@ static int cmdq_resume(struct device *dev)
 	return 0;
 }
 
-static int cmdq_remove(struct platform_device *pdev)
+static void cmdq_remove(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 
@@ -378,7 +378,6 @@ static int cmdq_remove(struct platform_device *pdev)
 		cmdq_runtime_suspend(&pdev->dev);
 
 	clk_bulk_unprepare(cmdq->pdata->gce_num, cmdq->clocks);
-	return 0;
 }
 
 static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
@@ -761,7 +760,7 @@ static const struct of_device_id cmdq_of_ids[] = {
 
 static struct platform_driver cmdq_drv = {
 	.probe = cmdq_probe,
-	.remove = cmdq_remove,
+	.remove_new = cmdq_remove,
 	.driver = {
 		.name = "mtk_cmdq",
 		.pm = &cmdq_pm_ops,
-- 
2.43.0


