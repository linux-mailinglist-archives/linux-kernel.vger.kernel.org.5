Return-Path: <linux-kernel+bounces-56931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B4B84D18B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938131C219F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A915612B179;
	Wed,  7 Feb 2024 18:43:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D385C40
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331404; cv=none; b=BLXUJ2thQINeDZnO2NNJxYgCxDW1/epAqQNw3IaSTtBzX3JzywlsedAZ2lFJrXtlrWp1AdrtTl8sZfrqvIOV7c1WYwVtDdrGBFZJK1C9wygC1GGbS9aDdpmTnoRp7q+ggKu4OQZMFZ/bsY1JCwsRCX6gPovPL0Et0whgC78CCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331404; c=relaxed/simple;
	bh=V9fXmo/wji/+Qk23ejom1WKCUrS23v2L7b4iJfa3OQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNvMHccbr9OCYohC0R3sSzprAcXQzane2z93rCylGlEovj1UCUmcyMn8MH2vi9E8VldNjeD+ZkSLziLl92UJWCxHKYJ7c8m8UhzZEfNiqghj5sR0Yy4rMm+NvgE5+O/gkXJVrad7FzAxXQgVCngjo+AkgJKts/7RAZGDeq6QrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0007PI-4K; Wed, 07 Feb 2024 19:43:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt2-0054Wx-6n; Wed, 07 Feb 2024 19:43:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt2-00HRrt-0O;
	Wed, 07 Feb 2024 19:43:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 03/32] iio: adc: ad_sigma_delta: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:17 +0100
Message-ID:  <de866d09c80c89816df62602ba4ba8ba30e9971f.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2991; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=V9fXmo/wji/+Qk23ejom1WKCUrS23v2L7b4iJfa3OQA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86ZyKdlBJFXTkRaTlW3JxU4uHlkNtqdRalfX 42PXw+zc2WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOmQAKCRCPgPtYfRL+ TgpoB/sG42rH0oJy7cNU1GO6xZc88KNodEBcy21UcMIEmp921dWqScaoL/tW/QS+Y7Eio0qP9PO 22kR4swKLlPypEABX4367G5P5VdtFe1Zeh7vNZEhhUJtEdDTHx4k6rk2ukk/UBHAfT8MlMbDBlA ymLmuDBbsxlvxs7EixDi73Ylo1IZ5EDMm0eJDdpyKfpOGZX3RA8XcJUwDrYIHoYA3M0Vme8qLHP DnhNfwgUEjkgjfAKsfaDVdM6S/0y7AB2b/k4GZwR+tZ8+inbjrEbAtUKac1swdAbUmMedwlAJYV JwooqnM+mTbr3MzmSFfY22lzxZ/uHxaV8O6q4A9KwucT3RMB
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

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/ad_sigma_delta.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7e2192870743..55442eddf57c 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -212,7 +212,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	if (ret)
 		return ret;
 
-	spi_bus_lock(sigma_delta->spi->master);
+	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
 	reinit_completion(&sigma_delta->completion);
@@ -235,7 +235,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 	sigma_delta->bus_locked = false;
-	spi_bus_unlock(sigma_delta->spi->master);
+	spi_bus_unlock(sigma_delta->spi->controller);
 
 	return ret;
 }
@@ -287,7 +287,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 	ad_sigma_delta_set_channel(sigma_delta, chan->address);
 
-	spi_bus_lock(sigma_delta->spi->master);
+	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
 	reinit_completion(&sigma_delta->completion);
@@ -322,7 +322,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 	sigma_delta->bus_locked = false;
-	spi_bus_unlock(sigma_delta->spi->master);
+	spi_bus_unlock(sigma_delta->spi->controller);
 	iio_device_release_direct_mode(indio_dev);
 
 	if (ret)
@@ -387,7 +387,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 
 	sigma_delta->samples_buf = samples_buf;
 
-	spi_bus_lock(sigma_delta->spi->master);
+	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
 
@@ -401,7 +401,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return 0;
 
 err_unlock:
-	spi_bus_unlock(sigma_delta->spi->master);
+	spi_bus_unlock(sigma_delta->spi->controller);
 
 	return ret;
 }
@@ -426,7 +426,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 
 	ad_sigma_delta_disable_all(sigma_delta);
 	sigma_delta->bus_locked = false;
-	return spi_bus_unlock(sigma_delta->spi->master);
+	return spi_bus_unlock(sigma_delta->spi->controller);
 }
 
 static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
-- 
2.43.0


