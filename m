Return-Path: <linux-kernel+bounces-51652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D079848DEF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B9C1C2227D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5BD23753;
	Sun,  4 Feb 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fk4zosb9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF16225B2;
	Sun,  4 Feb 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051820; cv=none; b=bZSmK4j0lio1CZbkFU9Xm8vvM4aSWMnVVDbDh3/Pp/dGNLWzjXBmEwOSSHAyyK1OgFMBL6AZbePj9TLsIPsZfW0LzEMHvy4LS9y5daWtLZ2zVxzb5/qrm2zGJWqA/LY7ZMjLkIZjSNTGbclSXDx3AdIahjlGq6bLEyQGyERsYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051820; c=relaxed/simple;
	bh=o+MLxNwdYDEWL72WUVGfFqEKzezdCrwJjfIxUtiL0yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2c7XxhLAf1XbQKWHbZzp7/dJkM0dQIRPcxLFBVGEIUOL3udH4PpzJxC9M3ZHQU/PNIcj1TMJK/wv78j3hKkIZffSqMazb32NuZdPPeF/iCoI2F3xQ+khjjPnWYycvCiUW7/OtyUWjOHizA73+NI9VZjI2QV72UljvB1NwqbxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fk4zosb9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707051819; x=1738587819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+MLxNwdYDEWL72WUVGfFqEKzezdCrwJjfIxUtiL0yE=;
  b=Fk4zosb9jbxBCSkl+9ADtCMFzLQufmnqKZ9dQLIbRTkXfu5mCxE9yjYK
   1s9R/hzLZLNL/95ekvnd5ncK/ek4jHZtTPfcuLM/3J8mQrFf7KmwKTk4y
   16zH1Mi//QQ5TD5nz9LXb5OE2GRSauurWXuYl+CxcVZ9cpZ0d7ruMZ6li
   xrPxYLUt904s0mYgGA1lBR2UzYkxs2RNwVoNW/ysuoU7P6k7Qm0prayuD
   KOE77nwz9xaGE7M35mSYLxZhZQTKQ/8Wk2jPkzPAPu+YPz1NLwe42UE9T
   h5sAtBU9aKnzKRo7H7p2BO8x9VxwCyVTObWn6hp5ixag31RYNSiTrBT3L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4283247"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4283247"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 05:03:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="37918239"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orviesa001.jf.intel.com with ESMTP; 04 Feb 2024 05:03:34 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 4/4] iio: hid-sensor-als: Add light chromaticity support
Date: Sun,  4 Feb 2024 05:03:32 -0800
Message-Id: <20240204130332.2635760-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204130332.2635760-1-srinivas.pandruvada@linux.intel.com>
References: <20240204130332.2635760-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

On some platforms, ambient color sensors also support the x and y light
colors, which represent the coordinates on the CIE 1931 chromaticity
diagram. Add light chromaticity x and y.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v4:
  - Index is fixed for each channel instead of packing for absent channels

v3:
Simplilified as no special processing is required in als_parse_report()

v2:
Original patch from Basavaraj Natikar <Basavaraj.Natikar@amd.com> is
modified to prevent failure when the new usage id is not found in the
descriptor.

 drivers/iio/light/hid-sensor-als.c | 46 ++++++++++++++++++++++++++++++
 include/linux/hid-sensor-ids.h     |  3 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 0e9a25c51676..3c8f707c18cf 100644
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
 
@@ -44,6 +46,8 @@ static const u32 als_usage_ids[] = {
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
 	HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
+	HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X,
+	HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y,
 };
 
 static const u32 als_sensitivity_addresses[] = {
@@ -85,6 +89,30 @@ static const struct iio_chan_spec als_channels[] = {
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
 
@@ -130,6 +158,16 @@ static int als_read_raw(struct iio_dev *indio_dev,
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
@@ -254,6 +292,14 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
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


