Return-Path: <linux-kernel+bounces-35426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE0A8390E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD08A1C26BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054C05F850;
	Tue, 23 Jan 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ijxFNLai"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AAB5FBA9;
	Tue, 23 Jan 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018982; cv=none; b=AuXsG0gTj8hmV6aTf88Y7VwwChogjtx1u0qPQXeIFK0ThF63gmG49AKgM8AHcycFFvpQqTaSeQxrYQk28vjb8z7kcHiUUVld3CaTNDimB/SIQuWoqYGIJFnVOQzxL5SSdb8iGzxXmYZHounV3uv3chuiPmR/a3bq2Ai6ZwJcSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018982; c=relaxed/simple;
	bh=94SZBYaZTO4/sNif/RBEFxoGQReKWRqy8LjSg5Jym8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4qdlYDoRatEysI8+KiTxFeqsRolhKVkosdn9//OaWoiYnmkT13S+ne/oYq8Swdk7Uvh/UYJLlw31NPwt2/fmUEvWsCydHQu3oB5q08GvUgl77RopbP/3B+YzDOE53zrcNr14NROGyqTcxM7EGQweSI+cIt7D74Pd8BUf0PX23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ijxFNLai; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NE9JOZ008640;
	Tue, 23 Jan 2024 08:09:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706018959;
	bh=+ybfr0OoM3GQtNN9TtXR+Au1IlzzSJrrS1YIsTQQ/co=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ijxFNLai3tDgE8oFhtyF+hpZj+5oLwsxKZRJ6o+Vppjhzvoe+s6tvDKjd6zsin3Xs
	 wNecD7KoDGYSEoWP0bNYkJAWpum73oiZhgnWWkzLxuO3nei7g3y5zgrSDdAE776rGh
	 CIrnnF4quWtmnpt+KfKRXDGyu5wZ5ffmtcmpIvjQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NE9JZR003072
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 08:09:19 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 08:09:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 08:09:19 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NE9Ius034990;
	Tue, 23 Jan 2024 08:09:19 -0600
From: Andrew Davis <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 2/4] iio: health: afe4403: Use devm IIO helpers
Date: Tue, 23 Jan 2024 08:09:16 -0600
Message-ID: <20240123140918.215818-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123140918.215818-1-afd@ti.com>
References: <20240123140918.215818-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use a device lifecycle managed IIO helper functions. This helps prevent
mistakes like unregistering and freeing out of order in cleanup functions
and forgetting to unregister and free on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/iio/health/afe4403.c | 38 ++++++++----------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 9e9d6de2a7c83..1dbe48dae74ee 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -540,7 +540,7 @@ static int afe4403_probe(struct spi_device *spi)
 
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
-		ret = iio_trigger_register(afe->trig);
+		ret = devm_iio_trigger_register(afe->dev, afe->trig);
 		if (ret) {
 			dev_err(afe->dev, "Unable to register IIO trigger\n");
 			return ret;
@@ -553,46 +553,25 @@ static int afe4403_probe(struct spi_device *spi)
 						afe->trig);
 		if (ret) {
 			dev_err(afe->dev, "Unable to request IRQ\n");
-			goto err_trig;
+			return ret;
 		}
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					 afe4403_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(afe->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      afe4403_trigger_handler, NULL);
 	if (ret) {
 		dev_err(afe->dev, "Unable to setup buffer\n");
-		goto err_trig;
+		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(afe->dev, indio_dev);
 	if (ret) {
 		dev_err(afe->dev, "Unable to register IIO device\n");
-		goto err_buff;
+		return ret;
 	}
 
 	return 0;
-
-err_buff:
-	iio_triggered_buffer_cleanup(indio_dev);
-err_trig:
-	if (afe->irq > 0)
-		iio_trigger_unregister(afe->trig);
-
-	return ret;
-}
-
-static void afe4403_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct afe4403_data *afe = iio_priv(indio_dev);
-	int ret;
-
-	iio_device_unregister(indio_dev);
-
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	if (afe->irq > 0)
-		iio_trigger_unregister(afe->trig);
 }
 
 static const struct spi_device_id afe4403_ids[] = {
@@ -608,7 +587,6 @@ static struct spi_driver afe4403_spi_driver = {
 		.pm = pm_sleep_ptr(&afe4403_pm_ops),
 	},
 	.probe = afe4403_probe,
-	.remove = afe4403_remove,
 	.id_table = afe4403_ids,
 };
 module_spi_driver(afe4403_spi_driver);
-- 
2.39.2


