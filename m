Return-Path: <linux-kernel+bounces-155466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2934D8AEAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45A328B271
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71C13D2A8;
	Tue, 23 Apr 2024 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCPN5i6U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13A13C676;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885643; cv=none; b=CbErouB2tmA3rWgW1+xCrLZOvMuvhQFzxiacxzhhy1p6Iassxxckdpm79wHaIBqNSMQUxonreW5MoKBBKIAM25EcLuzBrd/LZ4wpb+zcDqgkx1c+JOCX9tFUs+Q00hKb/pqavYczzEh9v+eTtcREoqfbuX1twx/rbzL294DvPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885643; c=relaxed/simple;
	bh=daWyLQmhXixnMBBEbyIlhAgaxicpslZZ0+ILNyeGPzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7yquQFgJsV4//LR9lYGED1Oy/FlDoigInp1te1358c8nMKSA6Aqnpeuoh3l0TTqNnt6Ex+mqJ0GjhBTHdDvUYwMKngO9rCBF9pRKJsOfpckFN9VW4HK9AzjpwWAArOzQbEWg/8mMIRp8JjCPxFmlyggg9SVNV8iK7NMkChYrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCPN5i6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62FB1C4AF0A;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713885643;
	bh=daWyLQmhXixnMBBEbyIlhAgaxicpslZZ0+ILNyeGPzU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TCPN5i6UbvhdkvBt0Us4vgrYZkPqrs6LP2P/Aml3dGG0qEHNc2+pQ+5UQ07NhCDsP
	 +r1NCD1PLacLHGb+FSr8c5c7Oj/J5OQmwy8FjtHhuiM+9m6NPJQavIn7ZS7vTWp/Fv
	 H1eU2Ki2ko7wWNT/MA2S6s7Z61HdSW4P2tJyZqSlGNrCgZqnwG/IEhAlhiVkp06604
	 AWRh/0c52Z3M+8KezBbmSSrgHSq1+rFB2FI40H+xra+rEcdMZk7Rw7q+aJB+3i+Ub3
	 LuWe5kVYvRZdoejNOTT8tGPqXi52QBPbJUHfY9ldfCh4RQRvyriYOtaxPYLO8r7Gua
	 JybvCkUCsXnKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC27C19F4F;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Apr 2024 17:20:33 +0200
Subject: [PATCH v2 4/4] iio: common: scmi_iio: convert to dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-dev-add_dev_errp_probe-v2-4-12f43c5d8b0d@analog.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
In-Reply-To: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
To: Petr Mladek <pmladek@suse.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Jyoti Bhayana <jbhayana@google.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713885641; l=3433;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ClJ3sRzkiojLcrvi0KpVZa+uYfx+C5zcG1LAl2kp8n8=;
 b=VN2nBviGoxHI3FJL9V7BAJfS9jU4cTEgtov2PPD9aWEKmHMliTcjcuctwHjvXVoKDRXsFq0lz
 APclNLIVmvbAAXJetoYeEU2tFiuLJPg5k8W5ParKCVUhDC+dXv26xUR
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Make use of dev_err_probe() and dev_err_ptr_probe() to simplify error paths
during probe.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++-----------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 0c2caf3570db..841eda79a8cc 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -626,12 +626,10 @@ scmi_alloc_iiodev(struct scmi_device *sdev,
 				SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
 				&sensor->sensor_info->id,
 				&sensor->sensor_update_nb);
-	if (ret) {
-		dev_err(&iiodev->dev,
-			"Error in registering sensor update notifier for sensor %s err %d",
-			sensor->sensor_info->name, ret);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return dev_err_ptr_probe(&iiodev->dev, ret,
+					 "Error in registering sensor update notifier for sensor %s err %d",
+					 sensor->sensor_info->name, ret);
 
 	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
 	iiodev->channels = iio_channels;
@@ -653,10 +651,9 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 		return -ENODEV;
 
 	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
-	if (IS_ERR(sensor_ops)) {
-		dev_err(dev, "SCMI device has no sensor interface\n");
-		return PTR_ERR(sensor_ops);
-	}
+	if (IS_ERR(sensor_ops))
+		return dev_err_probe(dev, PTR_ERR(sensor_ops),
+				     "SCMI device has no sensor interface\n");
 
 	nr_sensors = sensor_ops->count_get(ph);
 	if (!nr_sensors) {
@@ -667,8 +664,8 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 	for (i = 0; i < nr_sensors; i++) {
 		sensor_info = sensor_ops->info_get(ph, i);
 		if (!sensor_info) {
-			dev_err(dev, "SCMI sensor %d has missing info\n", i);
-			return -EINVAL;
+			return dev_err_probe(dev, -EINVAL,
+					     "SCMI sensor %d has missing info\n", i);
 		}
 
 		/* This driver only supports 3-axis accel and gyro, skipping other sensors */
@@ -683,29 +680,25 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 		scmi_iio_dev = scmi_alloc_iiodev(sdev, sensor_ops, ph,
 						 sensor_info);
 		if (IS_ERR(scmi_iio_dev)) {
-			dev_err(dev,
-				"failed to allocate IIO device for sensor %s: %ld\n",
-				sensor_info->name, PTR_ERR(scmi_iio_dev));
-			return PTR_ERR(scmi_iio_dev);
+			return dev_err_probe(dev, PTR_ERR(scmi_iio_dev),
+					     "failed to allocate IIO device for sensor %s: %ld\n",
+					     sensor_info->name, PTR_ERR(scmi_iio_dev));
 		}
 
 		err = devm_iio_kfifo_buffer_setup(&scmi_iio_dev->dev,
 						  scmi_iio_dev,
 						  &scmi_iio_buffer_ops);
 		if (err < 0) {
-			dev_err(dev,
-				"IIO buffer setup error at sensor %s: %d\n",
-				sensor_info->name, err);
-			return err;
+			return dev_err_probe(dev, err,
+					     "IIO buffer setup error at sensor %s: %d\n",
+					     sensor_info->name, err);
 		}
 
 		err = devm_iio_device_register(dev, scmi_iio_dev);
-		if (err) {
-			dev_err(dev,
-				"IIO device registration failed at sensor %s: %d\n",
-				sensor_info->name, err);
-			return err;
-		}
+		if (err)
+			return dev_err_probe(dev, err,
+					     "IIO device registration failed at sensor %s: %d\n",
+					     sensor_info->name, err);
 	}
 	return err;
 }

-- 
2.44.0



