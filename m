Return-Path: <linux-kernel+bounces-53269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACD884A2EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68D228B130
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1E4CB46;
	Mon,  5 Feb 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVT3+r+v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C648783;
	Mon,  5 Feb 2024 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159574; cv=none; b=gGu6u4C+ncadMrGKWZrYE1lzs8n5Qexj7NMMgVD94CXTiLeXYKAurSUMOueN5XTwxIRlFaYJo3mqf56mZ/k4sBmCYt3wPlu5BVxqjOACcJPuHs2a9UEv2NhgKdpEaJwjd0iUOQngqXu+Y6vi/MaNFp3AtIMs/GMuw1BAlDOUwJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159574; c=relaxed/simple;
	bh=QNmSf9FjffWDC7IlX3FZxCVIQSQApsSGNGFX5xhujI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbTgoSvinLj3x56+fjiM0AXAcYcvIl9NAmGz+/iHlyzj74HXEk7N6XZHIt8lrJRmBXJKvX1A1+mJUERAfkM+Ke//z4wNwawoYiMXQmsqlOciDZA9EhfmcumF11jC0dBYLjwwMIMQWVV7bR8836EXGyS6Ka0WrrVFH76f7oBc1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVT3+r+v; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707159572; x=1738695572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QNmSf9FjffWDC7IlX3FZxCVIQSQApsSGNGFX5xhujI8=;
  b=iVT3+r+veRdtGUL1mblPf07iKeYPJ1QHMyw6/3PRRSrduMWTDCYFjSpf
   tinNiM8OMwME1r+7VfxGNGLJkfaDuvxKBT6SZGYOvJdMv/ZhN0PtRU9nB
   M7rBEFgM7KJLfiWtbkDRaeZWwaZ+lvMTmsSO2UYsJCuMGmtgU6UM67Zm3
   okmVIAgCRHcwWfdOhG5gRlbNXQlmMMqsa2gDxE4j/fYRn8KxbBkP1YDAy
   Ew5Mi3aKQ4FxwdrG0rzBz8LUOtxwoOhJigrq9KJFoveS+w9R9rL6hFJu9
   zCW65JYpTotVTp8/QTY/CApiSRYUCkAmNJ1ANjUpXfCFbEhB8o7YUybYZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11320400"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11320400"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:59:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="31879451"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2024 10:59:29 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 4/4] iio: hid-sensor-als: Add light chromaticity support
Date: Mon,  5 Feb 2024 10:59:26 -0800
Message-Id: <20240205185926.3030521-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205185926.3030521-1-srinivas.pandruvada@linux.intel.com>
References: <20240205185926.3030521-1-srinivas.pandruvada@linux.intel.com>
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
v5:
        No change
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
index c17902823629..260281194f61 100644
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
 
@@ -45,6 +47,8 @@ static const u32 als_usage_ids[] = {
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
 	HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
+	HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X,
+	HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y,
 };
 
 static const u32 als_sensitivity_addresses[] = {
@@ -86,6 +90,30 @@ static const struct iio_chan_spec als_channels[] = {
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
 
@@ -129,6 +157,16 @@ static int als_read_raw(struct iio_dev *indio_dev,
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
@@ -253,6 +291,14 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
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


