Return-Path: <linux-kernel+bounces-2792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499FD8161F0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE141C216FD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195CE487A4;
	Sun, 17 Dec 2023 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjPTWR1F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D4481B2;
	Sun, 17 Dec 2023 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702843635; x=1734379635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VOlAD3t+Tnt7lLyRm63wkBFybRFTuMraU7FgX/QhCBk=;
  b=bjPTWR1F54dGVJjzC5y+1S/c+9tRiVYTS8idoS4xoA4VeMlhMeNy2hoJ
   Kel0oIFRvjqOrSp9cyRijNWnpVHPUP8O8LIJ6scu+7o0RltcQ+4zE0B/8
   sT/5EUXnnxidf2FFfKOW5GiXEqDnA1pl2Fv9amgrOmj+jTN43lKxrbteS
   ZxgY1AQxS4PcZ/jFLuO7j9y6nNYeFLS7Bm0N6ncmDtOgooL2r7RgdjLcr
   /AWVmGEou3FWB63sf3+oyyf2nDWJ8M0kfA6nfYgqeOYzXC6pqgKp/b03f
   os46IFvrWQivGMvgmkF1SRPsXLfG7wlFgi2q8wdMek6elvxg5WTATYZvZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="398214903"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="398214903"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 12:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="1022539227"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="1022539227"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2023 12:07:12 -0800
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
Subject: [PATCH 1/2] Revert "iio: hid-sensor-als: Add light chromaticity support"
Date: Sun, 17 Dec 2023 12:07:02 -0800
Message-Id: <20231217200703.719876-2-srinivas.pandruvada@linux.intel.com>
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

This reverts commit ee3710f39f9d0ae5137a866138d005fe1ad18132.

This commit assumes that every HID descriptor for ALS sensor has
presence of usage id ID HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X and
HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y. When the above usage ids are
absent,  driver probe fails. This breaks ALS sensor functionality on
many platforms.

Till we have a good solution, revert this commit.

Reported-by: Thomas Weißschuh <thomas@t-8ch.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218223
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/light/hid-sensor-als.c | 63 ------------------------------
 include/linux/hid-sensor-ids.h     |  3 --
 2 files changed, 66 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index f17304b54468..d44b3f30ae4a 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -17,8 +17,6 @@ enum {
 	CHANNEL_SCAN_INDEX_INTENSITY,
 	CHANNEL_SCAN_INDEX_ILLUM,
 	CHANNEL_SCAN_INDEX_COLOR_TEMP,
-	CHANNEL_SCAN_INDEX_CHROMATICITY_X,
-	CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -78,30 +76,6 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
 	},
-	{
-		.type = IIO_CHROMATICITY,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
-		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X,
-	},
-	{
-		.type = IIO_CHROMATICITY,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
-		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
-	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
@@ -145,16 +119,6 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
 			break;
-		case  CHANNEL_SCAN_INDEX_CHROMATICITY_X:
-			report_id = als_state->als[chan->scan_index].report_id;
-			min = als_state->als[chan->scan_index].logical_minimum;
-			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X;
-			break;
-		case  CHANNEL_SCAN_INDEX_CHROMATICITY_Y:
-			report_id = als_state->als[chan->scan_index].report_id;
-			min = als_state->als[chan->scan_index].logical_minimum;
-			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y;
-			break;
 		default:
 			report_id = -1;
 			break;
@@ -279,14 +243,6 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
 		ret = 0;
 		break;
-	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X:
-		als_state->scan.illum[CHANNEL_SCAN_INDEX_CHROMATICITY_X] = sample_data;
-		ret = 0;
-		break;
-	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y:
-		als_state->scan.illum[CHANNEL_SCAN_INDEX_CHROMATICITY_Y] = sample_data;
-		ret = 0;
-		break;
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
@@ -335,25 +291,6 @@ static int als_parse_report(struct platform_device *pdev,
 		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
 		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
 
-	for (i = 0; i < 2; i++) {
-		int next_scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X + i;
-
-		ret = sensor_hub_input_get_attribute_info(hsdev,
-				HID_INPUT_REPORT, usage_id,
-				HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X + i,
-				&st->als[next_scan_index]);
-		if (ret < 0)
-			return ret;
-
-		als_adjust_channel_bit_mask(channels,
-					CHANNEL_SCAN_INDEX_CHROMATICITY_X + i,
-					st->als[next_scan_index].size);
-
-		dev_dbg(&pdev->dev, "als %x:%x\n",
-			st->als[next_scan_index].index,
-			st->als[next_scan_index].report_id);
-	}
-
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 6730ee900ee1..8af4fb3e0254 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -22,9 +22,6 @@
 #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
 #define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
-#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY			0x2004d3
-#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X			0x2004d4
-#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y			0x2004d5
 
 /* PROX (200011) */
 #define HID_USAGE_SENSOR_PROX                                   0x200011
-- 
2.43.0


