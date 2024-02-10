Return-Path: <linux-kernel+bounces-60471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B885055B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7CE286181
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEA65D483;
	Sat, 10 Feb 2024 16:40:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9E5C8E9
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583254; cv=none; b=ZqysewzqQqZsWivv5joxfGUtt37S1Ri129IAJuSDigzGKhLQhPSm4Q8e7pkaDpQDSth/ikmaaKJizAgRGo09bctWhILoAr+JhxpcTckPtP2IV12itEzK5B3EvtxmHKLuekrDorNzLbAX7BWXFhEnNWO1HvXc5Ct4O2F3VgU6IYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583254; c=relaxed/simple;
	bh=CscG4XnYZ8gB9jKhA67cDKdK7kHCrNVWFAz8jn8AnuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTz0el4Rq+Z8+UK7/dJJNcCc97eTxQaMgU2QXFxVDCr9snKWXNksIUHcoMrjuJggLtPAXrdvdfUAPQ6DGkOBYXEW3uZR25LFyaGitjMwxe72Bv+CMT2WWFP7GDxLsOEIX5JnqAhZ8fDzAmdGSnyYv/e8bIVHZMQJdNyOH5vh2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOt-0001IA-CA; Sat, 10 Feb 2024 17:40:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOq-005i4A-RJ; Sat, 10 Feb 2024 17:40:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOq-002ERB-2S;
	Sat, 10 Feb 2024 17:40:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Rob Herring <robh@kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] spi: ppc4xx: Fix fallout from rename in struct spi_bitbang
Date: Sat, 10 Feb 2024 17:40:07 +0100
Message-ID: <20240210164006.208149-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
References: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CscG4XnYZ8gB9jKhA67cDKdK7kHCrNVWFAz8jn8AnuU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTjy15sdrJY9F8jIO+Kaaan0NOrB2xWBTr4/95UcFTOh JfFZt+5TkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAm0v2P/X/MGgUFI9ZodhFJ fU2vSK+abYtF5jtV+9/5f7bMWWXXht99awwil9p0hPjNqKxiUMnn4L/mKDA34Mn3NP8g+17Pu71 lWzZsFOCOj9sr+nHS2euG+WLO+qHeXz4Wx9SLyT1SSVt3QlS32k3/p49a7+xZr+8v5mjillqmeC znvMW/dlbtyJV1yT3yz7gyZrx9x1YSyP49t2SBgMx3E+aqXQ93CxW+ut6zLv3XrNMdpVKNzmev9 YpmXOk38d59Y8OrS5Enn8krHLLocj+0Y/d5sbt/21exnnlqeNz35YtDbVIMLm/aZuxuOnN/AUek Plf6lZ/uMhbi6z2DHC5rZhiruiyc9srR6LaNHrcdX0YKAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

I failed to adapt this driver because it's not enabled in a powerpc
allmodconfig build and also wasn't hit by my grep expertise. Fix
accordingly.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402100815.XQXw9XCF-lkp@intel.com/
Fixes: 2259233110d9 ("spi: bitbang: Follow renaming of SPI "master" to "controller"")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-ppc4xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 2290b40459ef..2d5536efa9f8 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -364,22 +364,22 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 
 	/* Setup the state for the bitbang driver */
 	bbp = &hw->bitbang;
-	bbp->master = hw->host;
+	bbp->ctlr = hw->host;
 	bbp->setup_transfer = spi_ppc4xx_setupxfer;
 	bbp->txrx_bufs = spi_ppc4xx_txrx;
 	bbp->use_dma = 0;
-	bbp->master->setup = spi_ppc4xx_setup;
-	bbp->master->cleanup = spi_ppc4xx_cleanup;
-	bbp->master->bits_per_word_mask = SPI_BPW_MASK(8);
-	bbp->master->use_gpio_descriptors = true;
+	bbp->ctlr->setup = spi_ppc4xx_setup;
+	bbp->ctlr->cleanup = spi_ppc4xx_cleanup;
+	bbp->ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	bbp->ctlr->use_gpio_descriptors = true;
 	/*
 	 * The SPI core will count the number of GPIO descriptors to figure
 	 * out the number of chip selects available on the platform.
 	 */
-	bbp->master->num_chipselect = 0;
+	bbp->ctlr->num_chipselect = 0;
 
 	/* the spi->mode bits understood by this driver: */
-	bbp->master->mode_bits =
+	bbp->ctlr->mode_bits =
 		SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST;
 
 	/* Get the clock for the OPB */
-- 
2.43.0


