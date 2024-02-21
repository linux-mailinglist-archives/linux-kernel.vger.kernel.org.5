Return-Path: <linux-kernel+bounces-74471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C4D85D4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CD51C23779
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDB33FB2C;
	Wed, 21 Feb 2024 09:54:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5173FB22
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509261; cv=none; b=Nqc8su8iiRHjHv9xLqI+qztzVu+ik350ZWyZB1kdfKvTJcAC5312x+eADPIJJtv2KlQiBPrxv6tWuf5lQiVuOUQ39VZC1WEYRI2xH5BL/bAWljMReUMQ1VLcdCmWzMLM8iprSzGIE7LSr48e1o9AfK40OYnuzmPvx89XPuGthMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509261; c=relaxed/simple;
	bh=ir78vHUD8SOpgHLYnJu/TctAQqKxSR//CX4Gftp+PpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIljlpyBRxm6Nk/BHN+/mhP9SPcaX0bioeMuVshx6fFGgFFQ4U+1ZHAcOTPtVUBn+2grWpVUy1z4g/AAjVadH/a0u1ZIMVcuVENgek7Y55BXLF7R9CvAic/LdkI79e/B3M03u5TUiEa0JGYQOyAPSwbJ3X/PowTDR/sOKua6K/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0007Gx-Gz; Wed, 21 Feb 2024 10:54:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0020pc-4K; Wed, 21 Feb 2024 10:54:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-008mZV-0B;
	Wed, 21 Feb 2024 10:54:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] misc: open-dice: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 10:53:50 +0100
Message-ID:  <8e7179794ffbcaa4ad3d0db50cc4aa03f377fc8c.1708508896.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ir78vHUD8SOpgHLYnJu/TctAQqKxSR//CX4Gftp+PpY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1cgxxQVwARjfqVxgcJw3tXAI+x5CthZ2JXeuX Ph3s96a2UWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdXIMQAKCRCPgPtYfRL+ Tl/4B/oDzrUTvZhPFmAHuCemhm9wCHb2gzHHLh8/xzfjRirJyt1OK4OSn80BF3Fj6lJ/QC9UIIa VWVwciSnaQ/sbGJl5HfT7LmcggyYQJwLj3SYMD0PnBcKNE3anhI2I2M+zsmbH+F5Tyb3rITMq5V b09z6B2AxH7mV+RpaNEMBqIxfNb8z/rbcUZfJuRm20nHEJ4Rc9E4zWvU49ulXImF8l/+fRK/U8A xRzIgeQ3oXKx/5w33e6iLPMUcytIefLP1TV74ngh5mKrbee6t3y+c84IjH+q1WDodDPI2dIAmx7 XXZIEbS89r+gDjyCfxz6j2EO0NX9Q9P3JtRTahMPQeBPlLSz
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
 drivers/misc/open-dice.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
index d279a4f195e2..1e3eb2aa44d9 100644
--- a/drivers/misc/open-dice.c
+++ b/drivers/misc/open-dice.c
@@ -165,12 +165,11 @@ static int __init open_dice_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int open_dice_remove(struct platform_device *pdev)
+static void open_dice_remove(struct platform_device *pdev)
 {
 	struct open_dice_drvdata *drvdata = platform_get_drvdata(pdev);
 
 	misc_deregister(&drvdata->misc);
-	return 0;
 }
 
 static const struct of_device_id open_dice_of_match[] = {
@@ -179,7 +178,7 @@ static const struct of_device_id open_dice_of_match[] = {
 };
 
 static struct platform_driver open_dice_driver = {
-	.remove = open_dice_remove,
+	.remove_new = open_dice_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = open_dice_of_match,
-- 
2.43.0


