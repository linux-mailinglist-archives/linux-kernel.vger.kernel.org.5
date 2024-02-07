Return-Path: <linux-kernel+bounces-56947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7244E84D1A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF127B26F0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D385B135A55;
	Wed,  7 Feb 2024 18:43:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8B85C6B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331410; cv=none; b=pwO80u5zke3vowkzThcv27CPCA18PwpjIXxmFp6Ytz5uPK4wB8lMKZx4yBZyi9Sf7teyyY487gF2a0F/dFUXSSXY5QQW3cmDmUmPqEE2QoRPeJjc0AapI1uQXuNlL5BIlMCxv2oM1XE2YWTJT0ndyh3kQDBhDC01kLE4PQiz9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331410; c=relaxed/simple;
	bh=Nj1hfFsyjq6xs8JqMS+euEQwaY/7srUsVpEx0j3EMYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBt8zU0k6flPx6S04G+IsOsJmsfK2vAawMgxBr4EbXK2HHkIi5Tgk5tPmCXgPtLjUO2swTIHwctlKA4TjKppmC2R8PyLFHOhQ2IhCGA8eLimmdK4zpIaI5tRowa7t9Ly0PIpao256POeFlkGaKcCRZZ7r4NK6qwoIytSExBcVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt8-0007UO-6s; Wed, 07 Feb 2024 19:43:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt5-0054XY-3P; Wed, 07 Feb 2024 19:43:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt5-00HRsY-02;
	Wed, 07 Feb 2024 19:43:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/32] mtd: dataflash: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:26 +0100
Message-ID:  <38bf50b391c117621e406fa8cd00c4daef78615c.1707324794.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Nj1hfFsyjq6xs8JqMS+euEQwaY/7srUsVpEx0j3EMYE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86jMqw4ltSTXwLQoh9w6paW5SuiO+i/OQP4/ aOSlb/Cxo6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOowAKCRCPgPtYfRL+ TjrnCACykE5iNjuwUOalnLCibPbZzFNctipOmpqjUPC8qgwgD5BYLPLFNHhOX5G0Isz2+UbaG89 0AU2cfpxvSwpkFvt8Y0OkUYwClhioF+9d6lQ/qBoGXQ3VXQBlAB/L99vvk764QKk0dknR3ctVZn kNJi7XbxtiY8SWFYhs7xh/XQnKlb8spVTPs2P5XBok7m7S0FWuSVpQY8CWAvyucGjpEtSPYcxBc JE8tsv9mFFU3DGEPsy7l/9ZHo6yEjrinlOIpsESpd20SgfTKJ/8CuY28zfK58vmSCYy14oHgDGW jyuow/xCdY+iCtvbqNdMja+reRkwAfXFAxP8uaONYkVN5Ymt
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

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/devices/mtd_dataflash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 0c1b93303618..ec52277e3dd5 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -638,7 +638,7 @@ static int add_dataflash_otp(struct spi_device *spi, char *name, int nr_pages,
 
 	/* name must be usable with cmdlinepart */
 	sprintf(priv->name, "spi%d.%d-%s",
-			spi->master->bus_num, spi_get_chipselect(spi, 0),
+			spi->controller->bus_num, spi_get_chipselect(spi, 0),
 			name);
 
 	device = &priv->mtd;
-- 
2.43.0


