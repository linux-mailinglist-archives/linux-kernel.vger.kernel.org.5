Return-Path: <linux-kernel+bounces-35427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D78390E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AB628E3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C75F864;
	Tue, 23 Jan 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZaWtHge3"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F55FDC8;
	Tue, 23 Jan 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018987; cv=none; b=IGZQ1IV3ihIyC6m+wHFkyAvw4imSv/c8TBAtPgbzhNRG30EIJzc96lMCPQG0W/BsNHLVPZLRJm4eLFluZcIfSZ4HQqk81BPQTfgb7Fm7vhLPA/6pHNaqvK6b0tv9jI4gCuaY9etaMQc/nEHetcU0IfiomruMv0q5o8joEdQoZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018987; c=relaxed/simple;
	bh=ZVwSX8hBbcyG6jlkyackNQ9w5I8lTGDkQfMizsNkTEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deNv51MQKFuKL1eWzZZkmc9cyGDnREmPRLlrLsopvMtEc0bTv6seujG/xUr98NW69j/oqHOBUwIm+61GBtXI35r6mBt6trn2/gCMlcZHvF8kq6jjgZemmwFzjHZ+LMldTVNc93+quR8IZeeMlwOmr8eIVK3IJleaw3rrKOvstvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZaWtHge3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NE9KtK031523;
	Tue, 23 Jan 2024 08:09:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706018960;
	bh=IIMacfmmzZD5CEfpZoAVBQCrv9WjJ7QV14EBtyNiVMc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZaWtHge3VEVMACQrPxv4lbwYQ7DsTsfFV+CQBzp9B/qIrWVpkYA/n2yKu88VXjAX2
	 AWAx6uvwV05DcwAOl9KGWL+UqJhiRJ4w8kckDAMtH2ULR4CltalIdp/EeYMheMtYRL
	 a3Abage53/6CS8ZqPtoEDtENw16bl4dh7/1LqRqo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NE9KV7113055
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 08:09:20 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 08:09:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 08:09:20 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NE9Iuu034990;
	Tue, 23 Jan 2024 08:09:19 -0600
From: Andrew Davis <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 4/4] iio: health: afe4404: Use devm IIO helpers
Date: Tue, 23 Jan 2024 08:09:18 -0600
Message-ID: <20240123140918.215818-4-afd@ti.com>
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
 drivers/iio/health/afe4404.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 75a513a92242c..7768b07ef7a6f 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -547,7 +547,7 @@ static int afe4404_probe(struct i2c_client *client)
 
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
-		ret = iio_trigger_register(afe->trig);
+		ret = devm_iio_trigger_register(afe->dev, afe->trig);
 		if (ret) {
 			dev_err(afe->dev, "Unable to register IIO trigger\n");
 			return ret;
@@ -564,42 +564,21 @@ static int afe4404_probe(struct i2c_client *client)
 		}
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					 afe4404_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(afe->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      afe4404_trigger_handler, NULL);
 	if (ret) {
 		dev_err(afe->dev, "Unable to setup buffer\n");
-		goto unregister_trigger;
+		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(afe->dev, indio_dev);
 	if (ret) {
 		dev_err(afe->dev, "Unable to register IIO device\n");
-		goto unregister_triggered_buffer;
+		return ret;
 	}
 
 	return 0;
-
-unregister_triggered_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-unregister_trigger:
-	if (afe->irq > 0)
-		iio_trigger_unregister(afe->trig);
-
-	return ret;
-}
-
-static void afe4404_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct afe4404_data *afe = iio_priv(indio_dev);
-	int ret;
-
-	iio_device_unregister(indio_dev);
-
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	if (afe->irq > 0)
-		iio_trigger_unregister(afe->trig);
 }
 
 static const struct i2c_device_id afe4404_ids[] = {
@@ -615,7 +594,6 @@ static struct i2c_driver afe4404_i2c_driver = {
 		.pm = pm_sleep_ptr(&afe4404_pm_ops),
 	},
 	.probe = afe4404_probe,
-	.remove = afe4404_remove,
 	.id_table = afe4404_ids,
 };
 module_i2c_driver(afe4404_i2c_driver);
-- 
2.39.2


