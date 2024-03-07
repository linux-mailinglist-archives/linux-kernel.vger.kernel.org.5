Return-Path: <linux-kernel+bounces-95996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3149C8755CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B521C2210E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43045131E31;
	Thu,  7 Mar 2024 18:08:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761D131E2A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834932; cv=none; b=WbgggNB+avt/0jTZ2H79SPHpXx/SmcWJzCw/eNngWR1WuMAM2rEcwZLGTmY5ossBnR4zUEdCBmUCShKM4YdKvLynk9Er38hjMhss+ca7EkZPc+zdEJdGSeRDnV0lNeS2T2Y/eNyymmXA5F9LkAulHaETisxa9nuAfPa8uAKYCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834932; c=relaxed/simple;
	bh=aToy140gqF3n09AGPZG2SbhqM1wg4qiIdXe7W2yzoUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fVSC+9ppqLY7FgTv11Ufo6woDjYkZ/LNkdOU7lopLv38PA6yLxltqF3KFt3B3/MfUu/TldfA+tGWtjG+SM9haxhgTIyuhW98sS0BHk/AsSdeRgcR0NvG3V1bB3ZJKHT+0HDk4Q30XfbZPmtni2z3AQ0OAp21x5WgJSAwnMFdirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riIAe-0005Qr-0A; Thu, 07 Mar 2024 19:08:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riIAc-004zYI-RB; Thu, 07 Mar 2024 19:08:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riIAc-001SqJ-2O;
	Thu, 07 Mar 2024 19:08:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] cdrom: gdrom: Convert to platform remove callback returning void
Date: Thu,  7 Mar 2024 19:08:37 +0100
Message-ID: <20240307180837.190626-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=aToy140gqF3n09AGPZG2SbhqM1wg4qiIdXe7W2yzoUM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6gKlUjORVJ9gghCsgYNWLNes507fpa8GigU4n 6r/NV8YxrWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeoCpQAKCRCPgPtYfRL+ TpfqB/9hJfEHJJtSPmcAkDy3a8jtu5yHJPeXczLEM7zvoyW3vCGYhxnQK4dNkKmXC55qUvej/R7 JwdYhkL00XwfrxGpVc38b6Ff/cLvrGFC0IotU6Uaa/en1FEv3GQXu9607B7em1hbrPV1z94zxLP oF8jHHTXxk7nL52NzDH+HC0KCqFuio/YEP7F4ON4veIlZ8FnF6VLluuVgkqQg4h0OZpys1tWyu5 qJ0dRLaHEOdn1xCCV+ghAebWw/gGTGcHoW75lUQvO2OBDPLMjF2fIkilDCZGfgpIY9wxzHlA/dy AUH2FS8gcotkl268N3hbdMd10AU4cvI62xvPGQhuOHGpwJoX
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

there doesn't seem to exist a dedicated maintainer entry. The last few commits
were created by Jens.

Best regards
Uwe

 drivers/cdrom/gdrom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 9398beeb5d1e..eefdd422ad8e 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -831,7 +831,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	return err;
 }
 
-static int remove_gdrom(struct platform_device *devptr)
+static void remove_gdrom(struct platform_device *devptr)
 {
 	blk_mq_free_tag_set(&gd.tag_set);
 	free_irq(HW_EVENT_GDROM_CMD, &gd);
@@ -842,13 +842,11 @@ static int remove_gdrom(struct platform_device *devptr)
 	unregister_cdrom(gd.cd_info);
 	kfree(gd.cd_info);
 	kfree(gd.toc);
-
-	return 0;
 }
 
 static struct platform_driver gdrom_driver = {
 	.probe = probe_gdrom,
-	.remove = remove_gdrom,
+	.remove_new = remove_gdrom,
 	.driver = {
 			.name = GDROM_DEV_NAME,
 	},

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0


