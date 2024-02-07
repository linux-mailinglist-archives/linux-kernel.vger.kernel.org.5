Return-Path: <linux-kernel+bounces-56950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5984D1AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38ED21F2174E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9BF13667D;
	Wed,  7 Feb 2024 18:43:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979A12C533
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331412; cv=none; b=hd94cV26mgky/o8H+Zmrt5BSSrdxtdI20ZUQJxEpDJCsElQ5fAzlbsUUt5hcCvJcJbJ930er2GURBfZOf9Nqr6boFNQ/IajXqxp2zvOF1VCdQAMWFeB7S4evkbZZtrrUb6RwL5w5QApd9isbttelPwweibQ9Fv7aL8VNeUeCmTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331412; c=relaxed/simple;
	bh=3uWg1dj8JY2x4YbDK4pPCpaqGziQ38xKtIysd488qoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bf2JtJyqg4In7xL4fWz6SEJs7PFdfOafBVRRiYNz5ZlHHCe2HWrhx9ZZDKpafl0S/1CnBJ754/s7Up1ehx2pA+CC8Q2IwMgc4EojiWVZk2y60/Go1Fh0Wg9AbuckvWFOO3asZ29nOjFeWK5Fu6welGRiliFShJxlOKS9a7wwpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt5-0007Sd-Gt; Wed, 07 Feb 2024 19:43:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0054XU-TT; Wed, 07 Feb 2024 19:43:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-00HRsU-2e;
	Wed, 07 Feb 2024 19:43:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/32] mmc: mmc_spi: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:25 +0100
Message-ID:  <a9c95759cf77a19c160d1d497c76ac5770c67684.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3uWg1dj8JY2x4YbDK4pPCpaqGziQ38xKtIysd488qoY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86iRgaXsnAONPwKcmuWcccjOTtI4N+LZaa3r vFnNuQq3YeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOogAKCRCPgPtYfRL+ TuGiB/4q83A3nbw2iRt8SUETQFwrm/YEhFpxFYwZ1pvftS7tqTK4D+okPck/OcXlQTFGX06Zcpl AYSRQUlRCEfjgyOn1yC3CYsT3dLPS879Y63xknQy3AiEOuTH7V20cldVljtwQV5YftBbugq28xn y/HUZhpyefhnnvbpca7Ghu+CtTg+8BeGDUelSW7vylKSdShiFD7F6Le6OIEwjrAny2SIN6194qo g1mSV9BD7CepqbONlfsGdqc9QDqDm7S5TsHNTyxSIMS4OiQPWfxNrRaVt3P4lYKAaLs0wrJHhMa nkUh9TPQj6RN6+KHZ75lTA3ym06Wxqrwls28Uryyx8FrseF5
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

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/host/mmc_spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index b8dda8160c4e..bf35761f783a 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -935,7 +935,7 @@ static void mmc_spi_request(struct mmc_host *mmc, struct mmc_request *mrq)
 #endif
 
 	/* request exclusive bus access */
-	spi_bus_lock(host->spi->master);
+	spi_bus_lock(host->spi->controller);
 
 crc_recover:
 	/* issue command; then optionally data and stop */
@@ -967,7 +967,7 @@ static void mmc_spi_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 	/* release the bus */
-	spi_bus_unlock(host->spi->master);
+	spi_bus_unlock(host->spi->controller);
 
 	mmc_request_done(host->mmc, mrq);
 }
@@ -1157,7 +1157,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	/* We rely on full duplex transfers, mostly to reduce
 	 * per-transfer overheads (by making fewer transfers).
 	 */
-	if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
 		return -EINVAL;
 
 	/* MMC and SD specs only seem to care that sampling is on the
-- 
2.43.0


