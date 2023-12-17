Return-Path: <linux-kernel+bounces-2793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34B28161F1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5920C282F5B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C148CD7;
	Sun, 17 Dec 2023 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UefXz/pT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DC481B9;
	Sun, 17 Dec 2023 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702843636; x=1734379636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysVCu8D1IX+AkHLJxM3YJ5xRnguUxX+A14T9pX7RtKQ=;
  b=UefXz/pT8PFZHhoFSqe+Odl7jplt5Y17kpMPw+V9rvUKcbCWfoujDi50
   sWy6MzMYv3nLXlo6oGZldXtm+vAHhDA2resetaVPvDeV7jCSataG7sWk8
   FtQD1aA1/RBeu3DqtIcQk4AGrJXgPwCan5dknEonY9UU+9MwjhY4WO7/L
   ALUuGXzfDNxddw1QXKeYqnVDJnIicMeti6d1NPazJag+JvHZMq90m2NAX
   Sk9uX6TjVNefFDpm/OxwrHpEO8kMvXll9A1vjMfbEx9ET10xfcOj/hNGZ
   /FzXHiBSRjdCus95cA1k9d0TSeV73nKVxfuA2CrF7KQ58Rjcv5TClN58F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="398214909"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="398214909"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 12:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="1022539231"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="1022539231"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2023 12:07:14 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Revert "iio: hid-sensor-als: Add light color temperature support"
Date: Sun, 17 Dec 2023 12:07:03 -0800
Message-Id: <20231217200703.719876-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217200703.719876-1-srinivas.pandruvada@linux.intel.com>
References: <20231217200703.719876-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 5f05285df691b1e82108eead7165feae238c95ef.

This commit assumes that every HID descriptor for ALS sensor has
presence of usage id ID HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE.
When the above usage id is absent,  driver probe fails. This breaks
ALS sensor functionality on many platforms.

Till we have a good solution, revert this commit.

Reported-by: Thomas Weißschuh <thomas@t-8ch.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218223
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/light/hid-sensor-als.c | 37 ++----------------------------
 include/linux/hid-sensor-ids.h     |  1 -
 2 files changed, 2 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index d44b3f30ae4a..5cd27f04b45e 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -14,9 +14,8 @@
 #include "../common/hid-sensors/hid-sensor-trigger.h"
 
 enum {
-	CHANNEL_SCAN_INDEX_INTENSITY,
-	CHANNEL_SCAN_INDEX_ILLUM,
-	CHANNEL_SCAN_INDEX_COLOR_TEMP,
+	CHANNEL_SCAN_INDEX_INTENSITY = 0,
+	CHANNEL_SCAN_INDEX_ILLUM = 1,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -66,16 +65,6 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
 	},
-	{
-		.type = IIO_COLORTEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
-		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
-	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
@@ -114,11 +103,6 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
-		case  CHANNEL_SCAN_INDEX_COLOR_TEMP:
-			report_id = als_state->als[chan->scan_index].report_id;
-			min = als_state->als[chan->scan_index].logical_minimum;
-			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
-			break;
 		default:
 			report_id = -1;
 			break;
@@ -239,10 +223,6 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
 		ret = 0;
 		break;
-	case HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE:
-		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
-		ret = 0;
-		break;
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
@@ -278,19 +258,6 @@ static int als_parse_report(struct platform_device *pdev,
 			st->als[i].report_id);
 	}
 
-	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
-				usage_id,
-				HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
-				&st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
-	if (ret < 0)
-		return ret;
-	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
-				st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
-
-	dev_dbg(&pdev->dev, "als %x:%x\n",
-		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
-		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
-
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 8af4fb3e0254..13b1e65fbdcc 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -21,7 +21,6 @@
 #define HID_USAGE_SENSOR_ALS					0x200041
 #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
-#define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
 
 /* PROX (200011) */
 #define HID_USAGE_SENSOR_PROX                                   0x200011
-- 
2.43.0


