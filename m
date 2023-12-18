Return-Path: <linux-kernel+bounces-4356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54661817BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17F01F24FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E6674E17;
	Mon, 18 Dec 2023 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfKE9U+K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CED77348D;
	Mon, 18 Dec 2023 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702931441; x=1734467441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/z1pNX0oVmvs23LZ0KScjYRgJYnFouhSUNo7dpC3TA=;
  b=VfKE9U+KXfJTGHuR0FR0gv9nAOaiex49H2cfkKnJK87KOOClaBu14Nbk
   goBtEwUVyo6QjXxM2HjfsTTbw/PBzU4Phh/Z94ghunRSJnD1KCsamhP3D
   pMJ8ekTWIeztnlkKl0tptlstPWwdRVOPciTtz2ZFBp5LHctjZy9L7JEpq
   +MNNvJsGHCWzIg8XBCLtsyBYE3rFqrIM3gX+dy20J8o/UWOfRJa0VBEe3
   /xtSAnRR4K/t5NNMcK/DV6KvBAERR533nBklCvAklC6LHyAY9EhoTS4rG
   bhTHRiBlBr9A28AiHhteoTSy7uERLfd9linosmlfDJcs56ejIOgt6zcSO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="395289757"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="395289757"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="751879654"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="751879654"
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
Subject: [PATCH v2 3/3] iio: hid-sensor-als: Add light chromaticity support
Date: Mon, 18 Dec 2023 12:30:26 -0800
Message-Id: <20231218203026.1156375-4-srinivas.pandruvada@linux.intel.com>
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

In most cases, ambient color sensors also support the x and y light
colors, which represent the coordinates on the CIE 1931 chromaticity
diagram. Thus, add light chromaticity x and y.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
Original patch from Basavaraj Natikar <Basavaraj.Natikar@amd.com> is
modified to prevent failure when the new usage id is not found in the
descriptor.

 drivers/iio/light/hid-sensor-als.c | 68 +++++++++++++++++++++++++++++-
 include/linux/hid-sensor-ids.h     |  3 ++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 8d6beacc338a..6e2793fa515c 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -17,6 +17,8 @@ enum {
 	CHANNEL_SCAN_INDEX_INTENSITY,
 	CHANNEL_SCAN_INDEX_ILLUM,
 	CHANNEL_SCAN_INDEX_COLOR_TEMP,
+	CHANNEL_SCAN_INDEX_CHROMATICITY_X,
+	CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -76,6 +78,30 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
 	},
+	{
+		.type = IIO_CHROMATICITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
+		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X,
+	},
+	{
+		.type = IIO_CHROMATICITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
+		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
@@ -119,6 +145,16 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
 			break;
+		case  CHANNEL_SCAN_INDEX_CHROMATICITY_X:
+			report_id = als_state->als[chan->scan_index].report_id;
+			min = als_state->als[chan->scan_index].logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X;
+			break;
+		case  CHANNEL_SCAN_INDEX_CHROMATICITY_Y:
+			report_id = als_state->als[chan->scan_index].report_id;
+			min = als_state->als[chan->scan_index].logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y;
+			break;
 		default:
 			report_id = -1;
 			break;
@@ -243,6 +279,14 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
 		ret = 0;
 		break;
+	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X:
+		als_state->scan.illum[CHANNEL_SCAN_INDEX_CHROMATICITY_X] = sample_data;
+		ret = 0;
+		break;
+	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y:
+		als_state->scan.illum[CHANNEL_SCAN_INDEX_CHROMATICITY_Y] = sample_data;
+		ret = 0;
+		break;
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
@@ -303,11 +347,33 @@ static int als_parse_report(struct platform_device *pdev,
 		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
 		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
 
+skip_temp_channel:
+	for (i = 0; i < 2; i++) {
+		int next_scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X + i;
+
+		ret = sensor_hub_input_get_attribute_info(hsdev,
+				HID_INPUT_REPORT, usage_id,
+				HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X + i,
+				&st->als[next_scan_index]);
+		if (ret < 0)
+			goto skip_chromaticity_channel;
+
+		channels[index++] = als_channels[CHANNEL_SCAN_INDEX_CHROMATICITY_X + i];
+
+		als_adjust_channel_bit_mask(channels,
+					CHANNEL_SCAN_INDEX_CHROMATICITY_X + i,
+					st->als[next_scan_index].size);
+
+		dev_dbg(&pdev->dev, "als %x:%x\n",
+			st->als[next_scan_index].index,
+			st->als[next_scan_index].report_id);
+	}
+
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
 
-skip_temp_channel:
+skip_chromaticity_channel:
 	*channels_out = channels;
 	*size_channels_out = index;
 
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 8af4fb3e0254..6730ee900ee1 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -22,6 +22,9 @@
 #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
 #define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
+#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY			0x2004d3
+#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X			0x2004d4
+#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y			0x2004d5
 
 /* PROX (200011) */
 #define HID_USAGE_SENSOR_PROX                                   0x200011
-- 
2.43.0


