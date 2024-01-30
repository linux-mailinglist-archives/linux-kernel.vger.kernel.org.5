Return-Path: <linux-kernel+bounces-45374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A37842F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958A1285470
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613D614AAA;
	Tue, 30 Jan 2024 22:10:23 +0000 (UTC)
Received: from queue02a.mail.zen.net.uk (queue02a.mail.zen.net.uk [212.23.3.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A807D402
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652623; cv=none; b=K7SXkMH1yzN4GAOwhLJvP5Sb7RC4TtoCFrn55ScwA598mHjEJBk6Zd+nZYyOC4I2yenAHCqUpL1Ofx16i9xWjC5xarcfBG37I/WqYREi3zMfkiauKIS6CPwLawGPJBYnZlJdfcv13g+uSjz+F05JvDgvaeZIU+STpk86+piohgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652623; c=relaxed/simple;
	bh=egCATovhY2sWjr4SZ7rEEw/pHeluU/gVzUPaAFXM0E8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WqEoUDLoSZu2by61QkMwNUsUoyMpoLet18ON1oXrwFZK6lurSUtS0e5yphPoEqb5UevdSWOqcdtSZMUtpiVUEAnwhKGyIV98aWNzsh/WDQRTwbznEoDumRBGDMeBKxNoabCylnACjUR5aJWl4iyhLP8PLB3GuV8GbZT85V03bfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.22] (helo=smarthost01c.ixn.mail.zen.net.uk)
	by queue02a.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1rUw3I-00Aqv8-Lx
	for linux-kernel@vger.kernel.org;
	Tue, 30 Jan 2024 21:53:56 +0000
Received: from [217.155.46.38] (helo=starbook..)
	by smarthost01c.ixn.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1rUw34-007gMb-5R;
	Tue, 30 Jan 2024 21:53:42 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] drivers/iio/accel/kxcjk-1013: Retrieve mount-matrix from ACPI
Date: Tue, 30 Jan 2024 21:53:33 +0000
Message-Id: <3d84078b55fdfa3625fcd36ee3681c265f816a9c.1706651571.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01c-IP: [217.155.46.38]
Feedback-ID: 217.155.46.38

Implement kxj_acpi_orientation to retrieve mount matrix
from ACPI ROTM method

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/iio/accel/kxcjk-1013.c | 87 ++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 894709286b0c..33d7394f32eb 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -619,6 +619,84 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+/*
+ * Support for getting accelerometer information from KIOX000A ACPI nodes.
+ *
+ */
+static bool kxj_acpi_orientation(struct device *dev,
+				 struct iio_mount_matrix *orientation)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	char *name, *str;
+	union acpi_object *obj, *elements;
+	acpi_status status;
+	int i, j, val[3];
+
+	if (acpi_has_method(adev->handle, "ROTM")) {
+		name = "ROTM";
+	} else {
+		return false;
+	}
+
+	status = acpi_evaluate_object(adev->handle, name, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
+		return false;
+	}
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3)
+		goto unknown_format;
+
+	elements = obj->package.elements;
+	for (i = 0; i < 3; i++) {
+		if (elements[i].type != ACPI_TYPE_STRING)
+			goto unknown_format;
+
+		str = elements[i].string.pointer;
+		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
+			goto unknown_format;
+
+		for (j = 0; j < 3; j++) {
+			switch (val[j]) {
+			case -1: str = "-1"; break;
+			case 0:  str = "0";  break;
+			case 1:  str = "1";  break;
+			default: goto unknown_format;
+			}
+			orientation->rotation[i * 3 + j] = str;
+		}
+	}
+
+	kfree(buffer.pointer);
+	return true;
+
+unknown_format:
+	dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
+	kfree(buffer.pointer);
+	return false;
+}
+
+static bool kxj1009_apply_acpi_orientation(struct device *dev,
+					  struct iio_mount_matrix *orientation)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev && acpi_dev_hid_uid_match(adev, "KIOX000A", NULL))
+		return kxj_acpi_orientation(dev, orientation);
+
+	return false;
+}
+#else
+static bool kxj1009_apply_acpi_orientation(struct device *dev,
+					  struct iio_mount_matrix *orientation)
+{
+	return false;
+}
+#endif
+
 static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 {
 	int ret;
@@ -1449,9 +1527,12 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	} else {
 		data->active_high_intr = true; /* default polarity */
 
-		ret = iio_read_mount_matrix(&client->dev, &data->orientation);
-		if (ret)
-			return ret;
+		if (!kxj1009_apply_acpi_orientation(&client->dev, &data->orientation)) {
+			ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+			if (ret)
+				return ret;
+		}
+
 	}
 
 	ret = devm_regulator_bulk_get_enable(&client->dev,
-- 
2.40.1


