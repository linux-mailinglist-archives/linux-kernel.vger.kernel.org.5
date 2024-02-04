Return-Path: <linux-kernel+bounces-51651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E5848DEE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639E5283E51
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C122F02;
	Sun,  4 Feb 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIVK83DY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E2224F0;
	Sun,  4 Feb 2024 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051820; cv=none; b=h5M5wdDr9qFfqqNMxhHfV3a7UOUHyhFVh3ngGJZI6YQ+TkDIi4sJfae9bxWZr5yLIYDX3ZLH8mxeev/K3hctJol1LQNlsAkYChoRZ4cCbqp/6lTNtM/voiYspRSe89zPUuokhB3bNiHwRrWalRFL8l85Qnkb2h4VDGR1POIXcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051820; c=relaxed/simple;
	bh=8fnhD77OrfYlSgrNTIP4SG3uiae2nbEmB/qZ4EdFOqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZrP+VYEzE+NdIDn42yppqWELRdC/XnFC8xady/PREv8YRXxR/QUkumPCmp2bwAEKRPgcnEFCeB3G7BhIzsMkze08ugqJsKphaRC+BUW2mIZdbhKILNnDppn59CGVs+zQ80vh7pdgmnMr01bxT4qWlTMCr0jHYviG/OrhJ7pUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIVK83DY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707051819; x=1738587819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8fnhD77OrfYlSgrNTIP4SG3uiae2nbEmB/qZ4EdFOqI=;
  b=SIVK83DY6P9Lo1VBVIqSeIREfROgzBww+ZoVWn5UaGNuipmaDYQcpPib
   oEQu6bGiTrDCHbO5eK04G8QTZoAg0gfQrYsNKcXw0B9Be2HAoDXxRfbBc
   A/Jle8JsTo4863Per7ICszIY41KyLvmT4c5AB6AZ78D8+cmKfHv07ikF1
   6BgWo2PtBkUgybDtEMD6n56hM/YfLqv/+clm3uGHqyu6T8Eb6uKNyeqov
   QQmNTzreX78A4KO/LodyQkuXZyXp4doZ1lRc+Cu0Bi3gH9jxAT+G5av0w
   C8MxxnSAiay5+akqOjkOSfP4kyJ33aqBeNR5WOThS9nttELi9KCKwGX0o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4283242"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4283242"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 05:03:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="37918238"
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
Subject: [PATCH v4 3/4] iio: hid-sensor-als: Add light color temperature support
Date: Sun,  4 Feb 2024 05:03:31 -0800
Message-Id: <20240204130332.2635760-4-srinivas.pandruvada@linux.intel.com>
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

On some platforms, ambient color sensors also support light color
temperature. Add support of light color temperature.

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

 drivers/iio/light/hid-sensor-als.c | 21 +++++++++++++++++++++
 include/linux/hid-sensor-ids.h     |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 521af52b3f3b..0e9a25c51676 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -16,6 +16,7 @@
 enum {
 	CHANNEL_SCAN_INDEX_INTENSITY,
 	CHANNEL_SCAN_INDEX_ILLUM,
+	CHANNEL_SCAN_INDEX_COLOR_TEMP,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -42,6 +43,7 @@ struct als_state {
 static const u32 als_usage_ids[] = {
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
+	HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
 };
 
 static const u32 als_sensitivity_addresses[] = {
@@ -73,6 +75,16 @@ static const struct iio_chan_spec als_channels[] = {
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
 
@@ -113,6 +125,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
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
@@ -233,6 +250,10 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
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


