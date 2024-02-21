Return-Path: <linux-kernel+bounces-74475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7785D4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D482E1C231B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312384597C;
	Wed, 21 Feb 2024 09:54:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56E4122C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509264; cv=none; b=JiahHmt6F3XqTgyjlrZMgKkiEL+UrrpalHpBx2Owftsaw2pG1/vpyzEAQB9L9lwLyOsjpmMINu1x+me8tcGRUnTqveObKw95cUi64+VTVfmlBGyo5BUmAB0xdtD+cLEFV5WoHvPUL0+F1XxrXnyvvp/sQ6HHcRhyXUdlpQSuz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509264; c=relaxed/simple;
	bh=pBTwRO+68pmeBClQENCyiZhNulNXrYvaN43H1/Tgtwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHcsAhCt9o/vmWLsXIKLJnGEFqC1cQavYyj2Mk+XiFdubxtTKSsC2rqvDFByDrTAMhZhTl09Eg2EF9jOWSjXTdVeY+Mo6PIoZXlZjpq/CCSD3M5xCYqRUHVjaEhuOcG+NO+KF85Jqy3nO5sJnupeXdvnr+LA2SVX91HTx2ZJJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIq-0007Gn-0v; Wed, 21 Feb 2024 10:54:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIo-0020pY-Vl; Wed, 21 Feb 2024 10:54:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIo-008mZR-2u;
	Wed, 21 Feb 2024 10:54:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	Tomas Winkler <tomas.winkler@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] mei: vsc: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 10:53:49 +0100
Message-ID:  <8e14f0b1cea107e613fa0075b3379a9f1e7ef63f.1708508896.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=pBTwRO+68pmeBClQENCyiZhNulNXrYvaN43H1/Tgtwk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1cgw8NkD13QTQZX8go+76yoqIK8/+/4AehWyh LaTaGfMegmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdXIMAAKCRCPgPtYfRL+ Tn1CCACAxm+y17S67+v7bI8mm/v4cAoJwqrtu2QKtfu0YuxBlcn5sx32MLvVBzwpYWTI04lXdDL IAsSxCw5uKS++0JG/UuZY49PwAwU3khoLS+/sLug+5c0MGU18JxDJgYE1BfRaIEiMXnTphzjZHP //s4mBPUhibQi0+cG/B/6z8h1xJYjKHPVDfSAsxYpoXO6LbcE1v9/gKGVa0KxLJHh5/C7E7YEMf rUaH30or6kvvqJ9yDC8w7uAGjM7/PPOC73dePRaDsE3NkeaHLnsvyki+gV2VsHvU7cJa54HGPOB oNIkPYl1XYpkUupbfLCes3zwOK8d49og7fJbOZ/F4+/s4z2+
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
 drivers/misc/mei/platform-vsc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
index 8d303c6c0000..6c9f00bcb94b 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -384,7 +384,7 @@ static int mei_vsc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mei_vsc_remove(struct platform_device *pdev)
+static void mei_vsc_remove(struct platform_device *pdev)
 {
 	struct mei_device *mei_dev = platform_get_drvdata(pdev);
 
@@ -395,8 +395,6 @@ static int mei_vsc_remove(struct platform_device *pdev)
 	mei_disable_interrupts(mei_dev);
 
 	mei_deregister(mei_dev);
-
-	return 0;
 }
 
 static int mei_vsc_suspend(struct device *dev)
@@ -433,7 +431,7 @@ MODULE_DEVICE_TABLE(platform, mei_vsc_id_table);
 
 static struct platform_driver mei_vsc_drv = {
 	.probe = mei_vsc_probe,
-	.remove = mei_vsc_remove,
+	.remove_new = mei_vsc_remove,
 	.id_table = mei_vsc_id_table,
 	.driver = {
 		.name = MEI_VSC_DRV_NAME,
-- 
2.43.0


