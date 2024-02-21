Return-Path: <linux-kernel+bounces-74479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0785D503
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45255287402
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F43C46B80;
	Wed, 21 Feb 2024 09:54:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521C45943
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509266; cv=none; b=fGM4qLYRjlYQ0ttuL5FJ4K7pCXga9XBtsHrEQNfrE27P+rGKXEEXGWO7BfVzxokXJpSE0vQmz2J//u2SUuwzVJzI5ONzQLOHYylZhmyaTxSc37l65riCTACyyJ3SqwmQI52JC0hP/D+l8u5cEjmxWSwGtXBnogXqk4iWG69OVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509266; c=relaxed/simple;
	bh=Y12US4C+WpRtTcOYvQXBN1eT1BAAVd09UhWYjrdPEuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Igd7EuZw+DHv/s+3GsNlM14UfliZTaDckgcUGlVXbV+3Q57EfE/PrjU2bQrOHJBS3Kpn2hxavuEVhC06xdteY8xNEuWoQ0VUpmusbxjS/cLyips8t4gY4CfkqC402Vstd+hpgwdJaoSU3htpYav5beNvXCcCuxi2+EajPGgi2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0007GU-44; Wed, 21 Feb 2024 10:54:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIo-0020pL-Cd; Wed, 21 Feb 2024 10:54:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIo-008mZ5-0z;
	Wed, 21 Feb 2024 10:54:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] misc: atmel-ssc: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 10:53:45 +0100
Message-ID:  <45719fc31bb893bb9ab1450057e9cb7f399e9ee2.1708508896.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Y12US4C+WpRtTcOYvQXBN1eT1BAAVd09UhWYjrdPEuA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1cgr2tbo0Q/3qRAJuARuaXItbnWGugcp9POOK W5AvGtmhbqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdXIKwAKCRCPgPtYfRL+ TnN6CACloQR+H7u0kOPEPLRucMXlrOPNZwitEdE/qVCXMT1E8X6LEmDLkoSUCW4dkuX33c1t/4Q GxSJ57XRUTivvl07ita9G85rDW/qdzXeDRA2WVdfn7002TSZUb91TjSfA7Zb23aC0l0QBp/e36v LxM6TnMFGa14GmvuKdIwDACXLr8D3qchqvdHF0an1Ze2Y9Ad26MOgSZejPYfNi2YxEGB1y+TgwA GL270oYjPgPziv9fTufK7RcDRSYEDOOatU6p57nVJ9qmaKJI5AOgoXcwWRmhZN6We/owjE8GcCH ueBVQCjvLGLnQy8HLnbUaq4W4eCtpqmlE/Tno3azHtM1YwI9
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
 drivers/misc/atmel-ssc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index ee590c4a1537..6eac0f335915 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -251,7 +251,7 @@ static int ssc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ssc_remove(struct platform_device *pdev)
+static void ssc_remove(struct platform_device *pdev)
 {
 	struct ssc_device *ssc = platform_get_drvdata(pdev);
 
@@ -260,8 +260,6 @@ static int ssc_remove(struct platform_device *pdev)
 	mutex_lock(&user_lock);
 	list_del(&ssc->list);
 	mutex_unlock(&user_lock);
-
-	return 0;
 }
 
 static struct platform_driver ssc_driver = {
@@ -271,7 +269,7 @@ static struct platform_driver ssc_driver = {
 	},
 	.id_table	= atmel_ssc_devtypes,
 	.probe		= ssc_probe,
-	.remove		= ssc_remove,
+	.remove_new	= ssc_remove,
 };
 module_platform_driver(ssc_driver);
 
-- 
2.43.0


