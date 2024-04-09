Return-Path: <linux-kernel+bounces-136516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D4189D50E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2087B1F22485
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FAB7E798;
	Tue,  9 Apr 2024 09:03:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F125339A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653401; cv=none; b=n8eDuY1BZDriuFDjKsokZTTtIjHiDtBUPAGPnkuaG8UNH2i0qRYNlsXg79YhLK/qRLC7XfJuGymUfB3ONIepYmi5Hz/ttfYxcVPL6VTv5lSLcma0D3HP++wCqd3HqgDMbVqhAcf1WxqCYjfpW+R25HGXJPRQsncztjQ8+umU/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653401; c=relaxed/simple;
	bh=vi4m312x4kVDts/5E1BrX8edzkMoKg9FVUzNpNUyKYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNJH85OKczM8QCaxP1MMF1p2Ogtpj1xGcAk5tsQ4srS66rP0qhdoUTBZfIyZZI1/xM8fCFW/B5weEsEpfmXO7BsO5EVwK9OP8A4G9G775Hvjna4ZEBwjLUb2dBcS3iDX1pedjRiVo0Mdc0oaTRBZFfV/0wka0SAvUeSazuTAmk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ru7No-0001rD-Vl; Tue, 09 Apr 2024 11:03:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ru7Nm-00BGyH-5y; Tue, 09 Apr 2024 11:03:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ru7Nm-00GqCV-0J;
	Tue, 09 Apr 2024 11:03:10 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andy@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] auxdisplay: seg-led-gpio: Convert to platform remove callback returning void
Date: Tue,  9 Apr 2024 11:03:07 +0200
Message-ID: <20240409090306.29284-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2311; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vi4m312x4kVDts/5E1BrX8edzkMoKg9FVUzNpNUyKYI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFQRK/qOJl5sDCIBE3KgvzJ1OvKHnybIlCDcpy 1ii/Aea3diJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhUESgAKCRCPgPtYfRL+ TtTHB/0clZaHwrfkkyud5xK020JK+eGJxmBKuPdOVOa96Y8Wl6JXHe5fB1yGNwk/Llg/mJDWj/z RlnDcZ6EpWo3F/86nLRKTMixCl6kegGyDxdpp7Tm3cABpHrZ62qXzVTuSV/NIAh+V+UNyRwREba WUjbudfVRPB4X3hBKmnMzmALr0gMCfozNjtfXmbw1ZfOmjq6n9IePGsoyiPz+9INmKaMdCsAeyw UodPCKSv7oyql0tAMmp77LQe/0dumqsFaAmEVHosWiYfEDAMbjE02UNHMVxnQtHzq2jeM76aB0Q wdC/9fkdfpGwxU70rhA8g8eCZlJmFHX23YLk12jZTTSyp3UR
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
 drivers/auxdisplay/seg-led-gpio.c | 6 ++----

Hello,

the drivers below of drivers/auxdisplay were already converted to struct
platform_driver::remove_new during the v6.9-rc1 development cycle. This
driver was added for v6.9-rc1 still using the old prototype.

There are still more drivers to be converted, so there is from my side
no need to get this into v6.9, but the next merge window would be nice.

Best regards
Uwe
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/auxdisplay/seg-led-gpio.c b/drivers/auxdisplay/seg-led-gpio.c
index 35a8dbb1e9d2..183ab3011cbb 100644
--- a/drivers/auxdisplay/seg-led-gpio.c
+++ b/drivers/auxdisplay/seg-led-gpio.c
@@ -81,14 +81,12 @@ static int seg_led_probe(struct platform_device *pdev)
 	return linedisp_register(&priv->linedisp, dev, 1, &seg_led_linedisp_ops);
 }
 
-static int seg_led_remove(struct platform_device *pdev)
+static void seg_led_remove(struct platform_device *pdev)
 {
 	struct seg_led_priv *priv = platform_get_drvdata(pdev);
 
 	cancel_delayed_work_sync(&priv->work);
 	linedisp_unregister(&priv->linedisp);
-
-	return 0;
 }
 
 static const struct of_device_id seg_led_of_match[] = {
@@ -99,7 +97,7 @@ MODULE_DEVICE_TABLE(of, seg_led_of_match);
 
 static struct platform_driver seg_led_driver = {
 	.probe = seg_led_probe,
-	.remove = seg_led_remove,
+	.remove_new = seg_led_remove,
 	.driver = {
 		.name = "seg-led-gpio",
 		.of_match_table = seg_led_of_match,

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.43.0


