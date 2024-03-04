Return-Path: <linux-kernel+bounces-90282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC5786FCDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D81B1C223F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174361BC44;
	Mon,  4 Mar 2024 09:13:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228EC1B27A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543617; cv=none; b=MxChbHjipmEWjB/ju4n4FlNqbZp/rdeoLWAc27gdvkBR/ljjsJszy65vbHCXZKZfBoBaKes9JAAiJDHLZPB07ynahXNS9IE3Pjy+OJvKZOpAOq0CvLavi152Kl7aVY2lKd9JL9OAY3L2q4k/EggB5IxW3pFLxy5XJP7dKfyrha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543617; c=relaxed/simple;
	bh=n4g6A/1gV2oAFkfciMKSmu9PWw+8nLkwQuD7vVTJDCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gmzmZMFF3rKFGNB2ZMtYJDTOXwz0Am6MvZgEPOTP6ICuUOeQV1wcP/QZZ11ygWvZlUoBRvlnE2Kvxg70RvvCU1rGheUeFec3XEKmOIMGBArO7Lq1hFFmG2c3ere1KxzN1WJ4p8JKD7cXHMTFUZWCRJPXvhMtBEgqPVlLqJjM2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rh4O3-00036d-5I; Mon, 04 Mar 2024 10:13:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rh4O2-004K1A-4l; Mon, 04 Mar 2024 10:13:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rh4O2-00GVS1-0B;
	Mon, 04 Mar 2024 10:13:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>,
	Min Li <min.li.xe@renesas.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ptp: fc3: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 10:13:25 +0100
Message-ID: <20240304091325.717546-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=n4g6A/1gV2oAFkfciMKSmu9PWw+8nLkwQuD7vVTJDCk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSnE7YdyRIIWl+xzPDn90I2o7MZD72Eyp/eP7Zuj4j2m osb28PvdzIaszAwcjHIiimy2DeuybSqkovsXPvvMswgViaQKQxcnAIwEeFE9n9a9/6u+WFWXOQv +u1UEtvRaxeZOk68tGDxeyXPoPo5Q/lAou71GwKNnq+37bJt0g9Y73Z9xsE1fzUMVwrkSqzwuX6 7IvfErr8OZWmtLh7K8hvyX+22C/SQNys8/Kev9DXvhxzbNiXrLG2rOwIFsb8dXgSLBK2PLFual6 mQ3yEV6Wndt5aJt6R2Ru2VADfN5yLTnGOn+Bjsj6nzSjGbq27HUT9Nzv5zhlNKyESNaE6rO19es Xu8z41L0ZTN4X2sscLpSWO5/N9JGblzrkrGRzklLlHPSPip3ruR67ieUwn/rtNxhydJftq+6pTu MqB/ZrawPdQUPdsi2yATPDnXKL875/HFcrGF1cp7DwMA
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
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

note this driver is currently only available in next.

Best regards
Uwe

 drivers/ptp/ptp_fc3.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
index 0e2286ba088a..6ef982862e27 100644
--- a/drivers/ptp/ptp_fc3.c
+++ b/drivers/ptp/ptp_fc3.c
@@ -996,13 +996,11 @@ static int idtfc3_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int idtfc3_remove(struct platform_device *pdev)
+static void idtfc3_remove(struct platform_device *pdev)
 {
 	struct idtfc3 *idtfc3 = platform_get_drvdata(pdev);
 
 	ptp_clock_unregister(idtfc3->ptp_clock);
-
-	return 0;
 }
 
 static struct platform_driver idtfc3_driver = {
@@ -1010,7 +1008,7 @@ static struct platform_driver idtfc3_driver = {
 		.name = "rc38xxx-phc",
 	},
 	.probe = idtfc3_probe,
-	.remove	= idtfc3_remove,
+	.remove_new = idtfc3_remove,
 };
 
 module_platform_driver(idtfc3_driver);

base-commit: 67908bf6954b7635d33760ff6dfc189fc26ccc89
-- 
2.43.0


