Return-Path: <linux-kernel+bounces-51649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C62C848DE8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512D41C21DE5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ABA225D7;
	Sun,  4 Feb 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXTYukgb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3622325;
	Sun,  4 Feb 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051818; cv=none; b=tp5Cry5KnlzITfP+zbRp0JSM2NeGzPYGtGWOSjg+JBDiUwr7DGg2tqKqzMZbqshfREYqMN85uczSKBEEjSkbeHQXbO4JRbo06PiL4Ic/hfeG66Ja7VuFE71cHBwSPA3Mzq33J8PbS3cLWwCqJbkLXmG9mbD5e/tVOLrvGjb/+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051818; c=relaxed/simple;
	bh=lNNajHM2ZbJsmQich664qba2NNtdh8efYODt6o7e9ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gl1if9Zj4a4t2NCsoetTYUsUpupFCPwHuQynClmbiIF0jb3yOEe/HHHbPi/8lSdZuGbPwE28GHX03PkY/KzK0ZRID0GG63FQuEd656aZWcTMBNkkUjZaYfGKDDUJnFgh+F0o91zBu7u0QGD69svkDSgLrwT9AU6NUJc2df38c/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXTYukgb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707051817; x=1738587817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lNNajHM2ZbJsmQich664qba2NNtdh8efYODt6o7e9ng=;
  b=ZXTYukgbNRFmCmj+QFLvRCuT7Z/8PzI03/xz/y6wrSRVEIBXB/uo64Kj
   Z3uRaMuTZSruOnaEljVA/4zYbN3qhgggMNzl/l/wjmchIqBjOIlxQpqu6
   f9Y2040OJmRheYd4WKne6XlySZBfo8jYxqoPasUbGcRKCtClQXtcXw9PL
   K5CPTzgqgpPBOT2OFd4xGIJwR1VH9Ql/vGwMkkw/a/2UujZMqUEunb2+V
   7wd+gONIZAsn7zzRvpwRX+EUmNubkR1t/H1ROu4hnzhZ85eeKqHlzW7N8
   PM7LwE4X9hUiGobiwfqag993jsPcW17RIOeOx0QbpEJtKX4kODjmd4TXf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4283234"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4283234"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 05:03:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="37918236"
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
Subject: [PATCH v4 1/4] iio: hid-sensor-als: Assign channels dynamically
Date: Sun,  4 Feb 2024 05:03:29 -0800
Message-Id: <20240204130332.2635760-2-srinivas.pandruvada@linux.intel.com>
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

Instead of assuming that every channel defined statically by
als_channels[] is present, assign dynamically based on presence of the
respective usage id in the descriptor. This will allow to register ALS
with limited channel support. Append the timestamp as the last channel.

Update available_scan_mask to specify all channels which are present.

There is no intentional function changes done.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v4:
Addressed comments from Jonthan:
	- Use available_scan_masks
	- timestamp location is fixed and left gaps in sample data for absent channels
	- Use CHANNEL_SCAN_INDEX_MAX as limit to check presence of usage ids, otherwise
	  it will miss newer channels added in subsequent patches.
v3:
Addressed comments from Jonthan:
	- Remove channel allocation and move to iio_priv()
	- Parse all usage IDs in a single loop and continue
	for failure. This way the temperature and chromaticity
	will not need any special processing to parse usage ids.
	- Don't leave empty channel indexes

v2:
New change

 drivers/iio/light/hid-sensor-als.c | 52 +++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index b6c4bef2a7bb..d3b892c0e307 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -25,6 +25,7 @@ struct als_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info als[CHANNEL_SCAN_INDEX_MAX];
+	struct iio_chan_spec channels[CHANNEL_SCAN_INDEX_MAX + 1];
 	struct {
 		u32 illum[CHANNEL_SCAN_INDEX_MAX];
 		u64 timestamp __aligned(8);
@@ -33,9 +34,16 @@ struct als_state {
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	int num_channels;
 	s64 timestamp;
 };
 
+/* The order of usage ids must match scan index starting from CHANNEL_SCAN_INDEX_INTENSITY */
+static const u32 als_usage_ids[] = {
+	HID_USAGE_SENSOR_LIGHT_ILLUM,
+	HID_USAGE_SENSOR_LIGHT_ILLUM,
+};
+
 static const u32 als_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_DATA_LIGHT,
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
@@ -68,6 +76,8 @@ static const struct iio_chan_spec als_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
+static unsigned long als_scan_mask[] = {0, 0};
+
 /* Adjust channel real bits based on report descriptor */
 static void als_adjust_channel_bit_mask(struct iio_chan_spec *channels,
 					int channel, int size)
@@ -238,27 +248,38 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int als_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				struct iio_chan_spec *channels,
 				unsigned usage_id,
 				struct als_state *st)
 {
-	int ret;
+	struct iio_chan_spec *channels;
+	int ret, index = 0;
 	int i;
 
-	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {
+	channels = st->channels;
+
+	for (i = 0; i < CHANNEL_SCAN_INDEX_MAX; ++i) {
 		ret = sensor_hub_input_get_attribute_info(hsdev,
 						HID_INPUT_REPORT,
 						usage_id,
-						HID_USAGE_SENSOR_LIGHT_ILLUM,
+						als_usage_ids[i],
 						&st->als[i]);
 		if (ret < 0)
-			return ret;
-		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
+			continue;
+
+		channels[index] = als_channels[i];
+		als_scan_mask[0] |= BIT(i);
+		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
+		++index;
 
 		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
 			st->als[i].report_id);
 	}
 
+	st->num_channels = index;
+	/* Return success even if one usage id is present */
+	if (index)
+		ret = 0;
+
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
@@ -294,15 +315,7 @@ static int hid_als_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, als_channels,
-					   sizeof(als_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
-		return -ENOMEM;
-	}
-
 	ret = als_parse_report(pdev, hsdev,
-			       (struct iio_chan_spec *)indio_dev->channels,
 			       hsdev->usage,
 			       als_state);
 	if (ret) {
@@ -310,8 +323,15 @@ static int hid_als_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->num_channels =
-				ARRAY_SIZE(als_channels);
+	/* Add timestamp channel */
+	als_state->channels[als_state->num_channels] = als_channels[CHANNEL_SCAN_INDEX_TIMESTAMP];
+
+	/* +1 for adding timestamp channel */
+	indio_dev->num_channels = als_state->num_channels + 1;
+
+	indio_dev->channels = als_state->channels;
+	indio_dev->available_scan_masks = als_scan_mask;
+
 	indio_dev->info = &als_info;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.43.0


