Return-Path: <linux-kernel+bounces-33927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E23D837056
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E648293062
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390E60DC6;
	Mon, 22 Jan 2024 18:08:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26C6087D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946910; cv=none; b=PZFAm2UwhH6a3NpOYwz5ORQDONJHJEwfIv5I9o/z5uL46tXMVu9SlJRZsdR53xDpL6nB+94Tt/HZRKfnptFXVFCCTqz9bCqDlzIvqErK9FHod1Z0njq/z+v+9LeXCUHu54aSx1EAL9nC+olYh8QsiE14q/4fBsabIJMw+k7ezhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946910; c=relaxed/simple;
	bh=UNWg1cWkWl9ngD6vxLDzpVtm8ne2cP1Z0jV0US+oPSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqsDrqQvb3erHqgvbOzVEaYzYI3T+q5yZcdWUTW/QwNK2asfsdPTLlsOgor3ZSb0YbLscywxglovoG7qfGi3YrFxA9nlWE4CZKqzO5xTv7Q61P0YVeUiwgxQ7ti8z2EwvB1EEqLefdMzFu/tR1iQPRI/PE+VoUC3ud3AuZEeDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiU-0001lT-Bf; Mon, 22 Jan 2024 19:08:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiT-001ePN-9U; Mon, 22 Jan 2024 19:08:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiT-005Zwv-0g;
	Mon, 22 Jan 2024 19:08:13 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 03/33] iio: adc: ad_sigma_delta: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:06:58 +0100
Message-ID:  <d876d507cd392fbf69cb282c6c7bbbb24b516da0.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=UNWg1cWkWl9ngD6vxLDzpVtm8ne2cP1Z0jV0US+oPSg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7GzszQ0ByRSkTozFRdJW7WsTgTOZTKv0czF RAwPm0D6G6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6uxgAKCRCPgPtYfRL+ TqktB/9Hz9L3lVXeE/q8wrqbKWxY+tdEVpjbSfGSm0jn4GeEH9OdonfHIGDYhc09+HqvS8zHo1j Kk2zB3izM6KI5gd8WXt8D4phkFo7vGxb0cRuBs31kLzBlX6w+HatKbl2ANB/AAJ0U/X+1yp8olf BHQl/19Y55XaSddiJWQW9sXXRtXvPoYjdvTH8fLvPHcZw9/8Z9c5E2Up6p5PnYQ3JJhpB9tW+oY NRfmHtdKTzM7Fqx/O+3F8jdlkQerONgUorHAb4Pi3NtSix/QgrNr59NqIsBMHtTxqgupOLWYxvA PK+CcTd/1AyTI6ItXfPzhDjVYyafk2zrBONGhPH4NGVGZ1b9
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


