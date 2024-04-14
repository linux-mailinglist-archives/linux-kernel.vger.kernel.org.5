Return-Path: <linux-kernel+bounces-144259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB8D8A43B8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9004B1C21C34
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3061350D0;
	Sun, 14 Apr 2024 16:12:47 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFE134CC6;
	Sun, 14 Apr 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713111167; cv=none; b=H2rr0ulMr/5onj98fvu29ue/5R42MhIcb2dDkwmau+PFAHoCI+elGwCZOYVi92hHk+ChJl/m9Jvumh0h6c37RW7xAQs0M0tPj3HfzBvjGvxdNH3SAc8PAnU1zBrP+oG9+ZbQO4eG5JXqNwYKFX1827uE4fh5TgoYkJWFLEcyzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713111167; c=relaxed/simple;
	bh=HGpvSN9IquzD1ptuHegwUc3/9SIdlA8wVLboJkGQQtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pUuJWUiZk//OHZJ8xGZvNm7AhmSsm2velhPCSreCiBq6gOcTMnXZUaIisPuZiUzyttCioAWcN/gSHTEwhCkqxC0V+g0WZQ/ucNZH8kelNFz3Sy3Fawikz0Js1Ih7/B8U8RYU6O2q/M6D3GTs7NJHXP2SPLwmwzE/xoQbLvRMhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 89823100BC4;
	Sun, 14 Apr 2024 16:12:33 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v1] HID: playstation: DS4: Fix calibration workaround for clone devices
Date: Mon, 15 Apr 2024 01:12:23 +0900
Message-Id: <20240414161223.117654-1-max@enpas.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic in dualshock4_get_calibration_data() used uninitialised data
in case of a failed kzalloc() for the transfer buffer.

The solution is to group all business logic and all sanity checks
together, and jump only to the latter in case of an error.
While we're at it, factor out the axes' labelling, since it must happen
either way for input_report_abs() to succeed later on.

Thanks to Dan Carpenter for the Smatch static checker warning.

Fixes: a48a7cd85f55 ("HID: playstation: DS4: Don't fail on calibration data request")
Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-playstation.c | 63 ++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index edc46fc02e9a..998e79be45ac 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -1787,7 +1787,7 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 		buf = kzalloc(DS4_FEATURE_REPORT_CALIBRATION_SIZE, GFP_KERNEL);
 		if (!buf) {
 			ret = -ENOMEM;
-			goto no_buffer_tail_check;
+			goto transfer_failed;
 		}
 
 		/* We should normally receive the feature report data we asked
@@ -1807,6 +1807,7 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 
 				hid_warn(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
 				ret = -EILSEQ;
+				goto transfer_failed;
 			} else {
 				break;
 			}
@@ -1815,17 +1816,19 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 		buf = kzalloc(DS4_FEATURE_REPORT_CALIBRATION_BT_SIZE, GFP_KERNEL);
 		if (!buf) {
 			ret = -ENOMEM;
-			goto no_buffer_tail_check;
+			goto transfer_failed;
 		}
 
 		ret = ps_get_report(hdev, DS4_FEATURE_REPORT_CALIBRATION_BT, buf,
 				DS4_FEATURE_REPORT_CALIBRATION_BT_SIZE, true);
 
-		if (ret)
+		if (ret) {
 			hid_warn(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
+			goto transfer_failed;
+		}
 	}
 
-	/* Parse buffer. If the transfer failed, this safely copies zeroes. */
+	/* Transfer succeeded - parse the calibration data received. */
 	gyro_pitch_bias  = get_unaligned_le16(&buf[1]);
 	gyro_yaw_bias    = get_unaligned_le16(&buf[3]);
 	gyro_roll_bias   = get_unaligned_le16(&buf[5]);
@@ -1854,71 +1857,71 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 	acc_z_plus       = get_unaligned_le16(&buf[31]);
 	acc_z_minus      = get_unaligned_le16(&buf[33]);
 
+	/* Done parsing the buffer, so let's free it. */
+	kfree(buf);
+
 	/*
 	 * Set gyroscope calibration and normalization parameters.
 	 * Data values will be normalized to 1/DS4_GYRO_RES_PER_DEG_S degree/s.
 	 */
 	speed_2x = (gyro_speed_plus + gyro_speed_minus);
-	ds4->gyro_calib_data[0].abs_code = ABS_RX;
 	ds4->gyro_calib_data[0].bias = 0;
 	ds4->gyro_calib_data[0].sens_numer = speed_2x*DS4_GYRO_RES_PER_DEG_S;
 	ds4->gyro_calib_data[0].sens_denom = abs(gyro_pitch_plus - gyro_pitch_bias) +
 			abs(gyro_pitch_minus - gyro_pitch_bias);
 
-	ds4->gyro_calib_data[1].abs_code = ABS_RY;
 	ds4->gyro_calib_data[1].bias = 0;
 	ds4->gyro_calib_data[1].sens_numer = speed_2x*DS4_GYRO_RES_PER_DEG_S;
 	ds4->gyro_calib_data[1].sens_denom = abs(gyro_yaw_plus - gyro_yaw_bias) +
 			abs(gyro_yaw_minus - gyro_yaw_bias);
 
-	ds4->gyro_calib_data[2].abs_code = ABS_RZ;
 	ds4->gyro_calib_data[2].bias = 0;
 	ds4->gyro_calib_data[2].sens_numer = speed_2x*DS4_GYRO_RES_PER_DEG_S;
 	ds4->gyro_calib_data[2].sens_denom = abs(gyro_roll_plus - gyro_roll_bias) +
 			abs(gyro_roll_minus - gyro_roll_bias);
 
-	/* Done parsing the buffer, so let's free it. */
-	kfree(buf);
-
-no_buffer_tail_check:
-
-	/*
-	 * Sanity check gyro calibration data. This is needed to prevent crashes
-	 * during report handling of virtual, clone or broken devices not implementing
-	 * calibration data properly.
-	 */
-	for (i = 0; i < ARRAY_SIZE(ds4->gyro_calib_data); i++) {
-		if (ds4->gyro_calib_data[i].sens_denom == 0) {
-			hid_warn(hdev, "Invalid gyro calibration data for axis (%d), disabling calibration.",
-					ds4->gyro_calib_data[i].abs_code);
-			ds4->gyro_calib_data[i].bias = 0;
-			ds4->gyro_calib_data[i].sens_numer = DS4_GYRO_RANGE;
-			ds4->gyro_calib_data[i].sens_denom = S16_MAX;
-		}
-	}
-
 	/*
 	 * Set accelerometer calibration and normalization parameters.
 	 * Data values will be normalized to 1/DS4_ACC_RES_PER_G g.
 	 */
 	range_2g = acc_x_plus - acc_x_minus;
-	ds4->accel_calib_data[0].abs_code = ABS_X;
 	ds4->accel_calib_data[0].bias = acc_x_plus - range_2g / 2;
 	ds4->accel_calib_data[0].sens_numer = 2*DS4_ACC_RES_PER_G;
 	ds4->accel_calib_data[0].sens_denom = range_2g;
 
 	range_2g = acc_y_plus - acc_y_minus;
-	ds4->accel_calib_data[1].abs_code = ABS_Y;
 	ds4->accel_calib_data[1].bias = acc_y_plus - range_2g / 2;
 	ds4->accel_calib_data[1].sens_numer = 2*DS4_ACC_RES_PER_G;
 	ds4->accel_calib_data[1].sens_denom = range_2g;
 
 	range_2g = acc_z_plus - acc_z_minus;
-	ds4->accel_calib_data[2].abs_code = ABS_Z;
 	ds4->accel_calib_data[2].bias = acc_z_plus - range_2g / 2;
 	ds4->accel_calib_data[2].sens_numer = 2*DS4_ACC_RES_PER_G;
 	ds4->accel_calib_data[2].sens_denom = range_2g;
 
+transfer_failed:
+	ds4->gyro_calib_data[0].abs_code = ABS_RX;
+	ds4->gyro_calib_data[1].abs_code = ABS_RY;
+	ds4->gyro_calib_data[2].abs_code = ABS_RZ;
+	ds4->accel_calib_data[0].abs_code = ABS_X;
+	ds4->accel_calib_data[1].abs_code = ABS_Y;
+	ds4->accel_calib_data[2].abs_code = ABS_Z;
+
+	/*
+	 * Sanity check gyro calibration data. This is needed to prevent crashes
+	 * during report handling of virtual, clone or broken devices not implementing
+	 * calibration data properly.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ds4->gyro_calib_data); i++) {
+		if (ds4->gyro_calib_data[i].sens_denom == 0) {
+			hid_warn(hdev, "Invalid gyro calibration data for axis (%d), disabling calibration.",
+					ds4->gyro_calib_data[i].abs_code);
+			ds4->gyro_calib_data[i].bias = 0;
+			ds4->gyro_calib_data[i].sens_numer = DS4_GYRO_RANGE;
+			ds4->gyro_calib_data[i].sens_denom = S16_MAX;
+		}
+	}
+
 	/*
 	 * Sanity check accelerometer calibration data. This is needed to prevent crashes
 	 * during report handling of virtual, clone or broken devices not implementing calibration
-- 
2.39.2


