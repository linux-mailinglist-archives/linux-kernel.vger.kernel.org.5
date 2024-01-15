Return-Path: <linux-kernel+bounces-26139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036082DBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F58B1F2292A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA317BAD;
	Mon, 15 Jan 2024 14:48:58 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF7175B2;
	Mon, 15 Jan 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 7859A10164D;
	Mon, 15 Jan 2024 14:48:52 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v1 4/7] HID: playstation: DS4: Don't fail on calibration data request
Date: Mon, 15 Jan 2024 23:45:35 +0900
Message-Id: <20240115144538.12018-5-max@enpas.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115144538.12018-1-max@enpas.org>
References: <20240115144538.12018-1-max@enpas.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some third-party controllers can't report calibration data for the
gyro/accelerometer.

We can still use the gamepad as-is, so let's do that.

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-playstation.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 12321cae4416..2bf44bd3cc8a 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -1778,8 +1778,10 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 		int retries;
 
 		buf = kzalloc(DS4_FEATURE_REPORT_CALIBRATION_SIZE, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
+		if (!buf) {
+			ret = -ENOMEM;
+			goto no_buffer_tail_check;
+		}
 
 		/* We should normally receive the feature report data we asked
 		 * for, but hidraw applications such as Steam can issue feature
@@ -1798,24 +1800,25 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 
 				hid_err(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
 				ret = -EILSEQ;
-				goto err_free;
 			} else {
 				break;
 			}
 		}
 	} else { /* Bluetooth */
 		buf = kzalloc(DS4_FEATURE_REPORT_CALIBRATION_BT_SIZE, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
+		if (!buf) {
+			ret = -ENOMEM;
+			goto no_buffer_tail_check;
+		}
 
 		ret = ps_get_report(hdev, DS4_FEATURE_REPORT_CALIBRATION_BT, buf,
 				DS4_FEATURE_REPORT_CALIBRATION_BT_SIZE, true);
-		if (ret) {
+
+		if (ret)
 			hid_err(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
-			goto err_free;
-		}
 	}
 
+	/* Parse buffer. If the transfer failed, this safely copies zeroes. */
 	gyro_pitch_bias  = get_unaligned_le16(&buf[1]);
 	gyro_yaw_bias    = get_unaligned_le16(&buf[3]);
 	gyro_roll_bias   = get_unaligned_le16(&buf[5]);
@@ -1867,6 +1870,11 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 	ds4->gyro_calib_data[2].sens_denom = abs(gyro_roll_plus - gyro_roll_bias) +
 			abs(gyro_roll_minus - gyro_roll_bias);
 
+	/* Done parsing the buffer, so let's free it. */
+	kfree(buf);
+
+no_buffer_tail_check:
+
 	/*
 	 * Sanity check gyro calibration data. This is needed to prevent crashes
 	 * during report handling of virtual, clone or broken devices not implementing
@@ -1919,8 +1927,6 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 		}
 	}
 
-err_free:
-	kfree(buf);
 	return ret;
 }
 
@@ -2571,7 +2577,7 @@ static struct ps_device *dualshock4_create(struct hid_device *hdev)
 	ret = dualshock4_get_calibration_data(ds4);
 	if (ret) {
 		hid_err(hdev, "Failed to get calibration data from DualShock4\n");
-		goto err;
+		hid_err(hdev, "Gyroscope and accelerometer will be inaccurate.\n");
 	}
 
 	ds4->gamepad = ps_gamepad_create(hdev, dualshock4_play_effect);
-- 
2.39.2


