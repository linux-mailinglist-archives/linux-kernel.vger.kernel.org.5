Return-Path: <linux-kernel+bounces-53268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD684A2E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494861C21E24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A7495CB;
	Mon,  5 Feb 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2f+sgUH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41531482DB;
	Mon,  5 Feb 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159572; cv=none; b=aXxK94eRqVCjrY1C+fyhBe7iZymPyvRc3b85t6tUZi2GsJtlcPbPwxyq3KR+9KSkCANVR5MmX1Wq8PJEYhX4VsRSiU81gRL+HQMIawLuvSVqg2jp0ZkKMc+pMYqEYRmrScGFuaD4BiOstxVDYSOYlU7ZK59h+kpd+ENcB/7965s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159572; c=relaxed/simple;
	bh=cB5gQgDrAgQIpJclgZYRkO9vSJtOG3M66a2Hh0BO8pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ab2BcOFKc6LCcoknKSeGmCf4p1jd8ru+UEk6II5TpDOxbyVpEaS7WChfuNBkE+iV78ql66nmV5FAHohb1NGSwwJzckKESNGJSkkkssWDhzCR2LmdeXaltWyUV5UcQoFf6fTkzEvgAECRTCoKwuPydsDgxLlyHoNqDU3ua7LRDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2f+sgUH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707159571; x=1738695571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cB5gQgDrAgQIpJclgZYRkO9vSJtOG3M66a2Hh0BO8pY=;
  b=e2f+sgUHBD7e+VPYorD84jpPGmek6So5xlMzz8VvA2JQH5smUFFi8VpR
   AC1ckAPHQ01aY4JaiHA9YLE+Nji7P4OTEsexfH6ZivdMEAtq6hYv7JpN2
   3qDp/PBEtmSzrFdDJ0fo7LAEEKh+L6uLPLZc+w8R6oR3dZYYf2xEx2e2J
   WPEYTUynwK+qS49DSe6aNRCy7hjSh73q1/nDDN3PdyHN6WQkePb9ksTre
   JYQIlYCbaKgqDZWj8jUKHcAIVQ6eOy7dXNHctg7fpuf3BwwHj1WFmgAXU
   KAX7l2hYanCrIou2bV8QJl/G7xPQAKiJXAnDOqLKjOxbFpcrAbRBHALXr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11320395"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11320395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:59:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="31879449"
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
Subject: [PATCH v5 3/4] iio: hid-sensor-als: Add light color temperature support
Date: Mon,  5 Feb 2024 10:59:25 -0800
Message-Id: <20240205185926.3030521-4-srinivas.pandruvada@linux.intel.com>
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

On some platforms, ambient color sensors also support light color
temperature. Add support of light color temperature.

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

 drivers/iio/light/hid-sensor-als.c | 21 +++++++++++++++++++++
 include/linux/hid-sensor-ids.h     |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 144c02fbbbc0..c17902823629 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -16,6 +16,7 @@
 enum {
 	CHANNEL_SCAN_INDEX_INTENSITY,
 	CHANNEL_SCAN_INDEX_ILLUM,
+	CHANNEL_SCAN_INDEX_COLOR_TEMP,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -43,6 +44,7 @@ struct als_state {
 static const u32 als_usage_ids[] = {
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
+	HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
 };
 
 static const u32 als_sensitivity_addresses[] = {
@@ -74,6 +76,16 @@ static const struct iio_chan_spec als_channels[] = {
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
 
@@ -112,6 +124,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
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
@@ -232,6 +249,10 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
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


