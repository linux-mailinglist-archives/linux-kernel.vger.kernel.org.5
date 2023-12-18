Return-Path: <linux-kernel+bounces-4355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4560E817BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E98281A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDC740B7;
	Mon, 18 Dec 2023 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwTrY/uT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C673468;
	Mon, 18 Dec 2023 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702931440; x=1734467440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4xfQLvOA6h4DeKq4ZpmyG5CweHJHYge/PXh7jEm08TU=;
  b=XwTrY/uTVvt1+a4PyPnMDEEF1igoecOlnTbc8wOgv39hcsE5lkCKjBMV
   0jetyKzwSikx2VfHwvYmlq4yB+sBYi9i7MRLKKF2cXx4ENpspU/pepYP3
   PnyU0U6JyWWAJ7PrjqMz4Ro5jN7AYJvi+xwxCrzq2QLLOTx6Ui8dOlvTd
   LOoJozmM/sNtuQv0oEEnj4PT/7kVZO+hwTqiU8Odl2/izx7yhSTEM2SkS
   X9niY8R1BJUxb2jczTQLI3TK5obA92BQ23VIHPJ/GpB9ve6HfhM0Ex1OQ
   PONyh/njpI8eraJAgsMHzRJQ0gl+Q/AWNT56v1A+4l979FU/ovtG0WiDu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="395289753"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="395289753"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="751879653"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="751879653"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2023 12:30:37 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/3] iio: hid-sensor-als: Add light color temperature support
Date: Mon, 18 Dec 2023 12:30:25 -0800
Message-Id: <20231218203026.1156375-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231218203026.1156375-1-srinivas.pandruvada@linux.intel.com>
References: <20231218203026.1156375-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

In most cases, ambient color sensors also support light color temperature.
As a result, add support of light color temperature.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
Original patch from Basavaraj Natikar <Basavaraj.Natikar@amd.com> is
modified to prevent failure when the new usage id is not found in the
descriptor.

 drivers/iio/light/hid-sensor-als.c | 41 ++++++++++++++++++++++++++++--
 include/linux/hid-sensor-ids.h     |  1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index e57ad1946b56..8d6beacc338a 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -14,8 +14,9 @@
 #include "../common/hid-sensors/hid-sensor-trigger.h"
 
 enum {
-	CHANNEL_SCAN_INDEX_INTENSITY = 0,
-	CHANNEL_SCAN_INDEX_ILLUM = 1,
+	CHANNEL_SCAN_INDEX_INTENSITY,
+	CHANNEL_SCAN_INDEX_ILLUM,
+	CHANNEL_SCAN_INDEX_COLOR_TEMP,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -65,6 +66,16 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
 	},
+	{
+		.type = IIO_COLORTEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
+		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
@@ -103,6 +114,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
+		case  CHANNEL_SCAN_INDEX_COLOR_TEMP:
+			report_id = als_state->als[chan->scan_index].report_id;
+			min = als_state->als[chan->scan_index].logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
+			break;
 		default:
 			report_id = -1;
 			break;
@@ -223,6 +239,10 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
 		ret = 0;
 		break;
+	case HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE:
+		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
+		ret = 0;
+		break;
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
@@ -267,10 +287,27 @@ static int als_parse_report(struct platform_device *pdev,
 			st->als[i].report_id);
 	}
 
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+				usage_id,
+				HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
+				&st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
+	if (ret < 0)
+		goto skip_temp_channel;
+
+	channels[index++] = als_channels[CHANNEL_SCAN_INDEX_COLOR_TEMP];
+
+	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
+				st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
+
+	dev_dbg(&pdev->dev, "als %x:%x\n",
+		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
+		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
+
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
 
+skip_temp_channel:
 	*channels_out = channels;
 	*size_channels_out = index;
 
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 13b1e65fbdcc..8af4fb3e0254 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -21,6 +21,7 @@
 #define HID_USAGE_SENSOR_ALS					0x200041
 #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
+#define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
 
 /* PROX (200011) */
 #define HID_USAGE_SENSOR_PROX                                   0x200011
-- 
2.43.0


