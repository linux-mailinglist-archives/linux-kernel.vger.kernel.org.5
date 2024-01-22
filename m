Return-Path: <linux-kernel+bounces-33918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D421483702F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134311C293B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE64605A8;
	Mon, 22 Jan 2024 18:08:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C625FF0C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946905; cv=none; b=sa1qRj21AUTEieOEEmjjK61E8KyphDmozNBqq375+4yUKHU+TCjVoAnc1Tu3jLLWYp8zD7m5jdJYL0+rnyUCw1T6csOfmMS0c30cRHpi1CEqvSIJZgljUP4TPja5ugl4x1GBBpZMMAMUbF7PrRRBsaQHRnwQY87stQkQ0XIYvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946905; c=relaxed/simple;
	bh=mvkeOe3/BbLvpNEiWVNLyrW1b8wBgb11O+XXVA/j11Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q97iGYdRMvWKMXEUsutq2HZDlSljPC7IlPyvdziFGtrGABTw/4rNkwkqEcA/K7xT7B3WQQBt+09IfBwhr9v9IQduRhdTBEnQNeOzDTsolwtnv1+opPjW25lGZheUbQU2eSEjH/3uKRDZgcuMZUFC17wfSToJ5MNBbAWe6qAuQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-00023a-Kk; Mon, 22 Jan 2024 19:08:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-001eQh-LE; Mon, 22 Jan 2024 19:08:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-005ZyR-1r;
	Mon, 22 Jan 2024 19:08:17 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/33] spi: spidev: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:19 +0100
Message-ID:  <750a11c6de7f05d4a2b67bd0755ffec9c685ef00.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=mvkeOe3/BbLvpNEiWVNLyrW1b8wBgb11O+XXVA/j11Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7fuoBn6fzRmbFYDJIj2kALvEOLDrp6km3Hg 4tYXzqXfJKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u3wAKCRCPgPtYfRL+ Ts1/CACCRASPL+iccfwcaVlzRk+w7x5SN7bd+3c8RwXU/uUDeQ7iJpN5pLzhjBx1W31sSQ/i1+4 daiiNxgP/bTbAaDmtjAPzACu9qBTERw5mSZiWpG0AWwW3F2fAU/dtLc34aUgKvcdabi7GoKcmyx /sKUxN9rla7/vuSeKJRtIXD0C+MiYs++tyu7PRLbYR3C4hqSJ7I7LRGy9D5CIzkK2sRTcwCn86Z Yo7VPFPjS7quusoKxFeRy3Osb1V/W6oycNfoWs26JvSaWXodXK1LKl9BOaa9QNPSIaN13Edb6x1 79G5UeM98EvCTKH1pPr709fNrxEGsSqXRQvz6CELWQci2BjM
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 655f2c959cd4..95fb5f1c91c1 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -802,7 +802,7 @@ static int spidev_probe(struct spi_device *spi)
 		spidev->devt = MKDEV(SPIDEV_MAJOR, minor);
 		dev = device_create(&spidev_class, &spi->dev, spidev->devt,
 				    spidev, "spidev%d.%d",
-				    spi->master->bus_num, spi_get_chipselect(spi, 0));
+				    spi->controller->bus_num, spi_get_chipselect(spi, 0));
 		status = PTR_ERR_OR_ZERO(dev);
 	} else {
 		dev_dbg(&spi->dev, "no minor number available!\n");
-- 
2.43.0


