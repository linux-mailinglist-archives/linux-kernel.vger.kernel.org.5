Return-Path: <linux-kernel+bounces-56777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4984CF07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E990D284AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652F0823BC;
	Wed,  7 Feb 2024 16:37:41 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595033CA;
	Wed,  7 Feb 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323860; cv=none; b=NowLc3Y4tzVEpgtAQSBrsT4En2O4335C0r9FDHV0SwhsciZXElnI8L2YItR35Lao3RIsWy4eHLaZ8mpuc7SmaS0Dz3+31DOcBdT+GWvYdQkXiNTkj9KgpPe8F1lbVbOAS0fqa/bkpHUcyl1iXol+9+Is1zKYytsdk3UW6YyBmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323860; c=relaxed/simple;
	bh=vqtUsSo5ghicGhv7xGcTyQ2ci1iQwKusQkLqNXAcFzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJDOYtwd/VghDpaals8pnlZZZy3oeZ5A60WmdRG1X7NrkAtcSbJ2hT8VTlX595Cx+OVdvv1OblU/6aScnp/vLIyPligyOZj3EQivCr6ablmKw1ejuy9R+egbSZpfXA34vlHnjDQqcAYu10gtjEfldVspPAM7VnkijrV5+NnChiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 5B9A4100BC4;
	Wed,  7 Feb 2024 16:37:34 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v2 3/5] HID: playstation: DS4: Don't fail on calibration data request
Date: Thu,  8 Feb 2024 01:36:45 +0900
Message-Id: <20240207163647.15792-4-max@enpas.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163647.15792-1-max@enpas.org>
References: <20240207163647.15792-1-max@enpas.org>
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
 drivers/hid/hid-playstation.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index df50ca4dab90..53bfc2828a61 100644
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
@@ -1796,26 +1798,27 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 					continue;
 				}
 
-				hid_err(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
+				hid_warn(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
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
-			hid_err(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
-			goto err_free;
-		}
+
+		if (ret)
+			hid_warn(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
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
 
@@ -2568,8 +2574,8 @@ static struct ps_device *dualshock4_create(struct hid_device *hdev)
 
 	ret = dualshock4_get_calibration_data(ds4);
 	if (ret) {
-		hid_err(hdev, "Failed to get calibration data from DualShock4\n");
-		goto err;
+		hid_warn(hdev, "Failed to get calibration data from DualShock4\n");
+		hid_warn(hdev, "Gyroscope and accelerometer will be inaccurate.\n");
 	}
 
 	ds4->gamepad = ps_gamepad_create(hdev, dualshock4_play_effect);
-- 
2.39.2


