Return-Path: <linux-kernel+bounces-123244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F49989050F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07186293162
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F456137C35;
	Thu, 28 Mar 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZo6pxXF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337D54673;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642928; cv=none; b=E92fa8iIbswjTY0XauocDIvf1h48IQZu5L6sdaB4rqmzH+ChPjg/HqVk9CABoQcgkcnBVv/bNU1cxGPgD0Cj+0S5dSTchCXkNOAQ192GW3Z8AJ1Gm9lKIlZLF9oMw6j183cc/G7fnlEiYV5xCgYgoFK2ptXJrMHB7YOh98se+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642928; c=relaxed/simple;
	bh=dCZc/jEii72+NzqEeuXpC+RCbEkLGzC80WA8NGGJ0n8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SyJr7m1cY8+uOfKk/+gRa3bbdz9L1xP9Cdijn+KAEXfdrbtfMqPMtQpIu4ebhkkLBCaCd5hVX2vxmwp67rgoemANLB6KNb7fE2CfS8trqN5XCrhHTHGVGhVdy/uvciF9tgQOByJz6j34CJwlmzNmrtjKS25c94iNG5wfpnDerx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZo6pxXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97711C43601;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711642927;
	bh=dCZc/jEii72+NzqEeuXpC+RCbEkLGzC80WA8NGGJ0n8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eZo6pxXFWdeEvNe+/3FvroGHofYT2IqX+PmZ1bpVf4kEYgWmxooZbfrNlJrKizVdM
	 repBQc0LZ78TwmCM2Qz/Y0EPeZtls1FHTDdrMUDVZ6F3YpebPTNKFkQo27+V3q9DlJ
	 Rjys4HLlZvwe2GfvnwAys5TGl23/ezE19pknCDkWa04o6fr6LZFh/ymvdbUWz43vN7
	 eC77O0RTltNXurumC/bE31VRq1loPXmOPNZZLgrb94M+maujS9lhvgI4V1ASrce/YM
	 X8cJyP5R6STqjLdDW3sFJVpaQNBwUZFNjUfGJT4ohYdTkYsUDE6KJTy1Lizc0pqH61
	 jx6zWlCAT20PQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE8BCD1283;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 17:22:06 +0100
Subject: [PATCH v4 6/6] iio: common: scmi_iio: convert to dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-ltc2983-misc-improv-v4-6-0cc428c07cd5@analog.com>
References: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
In-Reply-To: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jyoti Bhayana <jbhayana@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711642925; l=3435;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=fNPiCbBBcgPGtymUHxCG0IpXbjRneBGghOMvhTO+DqU=;
 b=RUz+deQwQ5JZU8wRdkeVarQwg8rjLLVxLCJCg0hTcLAhRamfi700AZoSgPDMfGYQFvWCM1rnq
 nPuBHXir35YCu87W2kuAFwWJ/HfDmaQFfV6M3yN/AQYSpxPSC5QDA63
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Make use of dev_err_probe() and dev_errp_probe() to simplify error paths
during probe.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++-----------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 0c2caf3570db..30d58af02b4c 100644
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
+		return dev_errp_probe(&iiodev->dev, ret,
+				      "Error in registering sensor update notifier for sensor %s err %d",
+				      sensor->sensor_info->name, ret);
 
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



