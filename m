Return-Path: <linux-kernel+bounces-53266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D2D84A2E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0001C23981
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E67487A4;
	Mon,  5 Feb 2024 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDap84gl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFE482CC;
	Mon,  5 Feb 2024 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159572; cv=none; b=VeCu1w7c3TnX4n38z71ZMKKKVSerUFuamJSdFJYL+FgsOROed9qWwJ21BMn3aC9XwuP2VaLKDNtDeM5I4sdK4Ab2GGjDe3yCq5r89440usQiI668sUuZKB7ir3FSEId5h7UlcpTnUxhb+oEFZNEquagn7daQC5eu2G0ZCin9n84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159572; c=relaxed/simple;
	bh=bQYlN6dlbdaq+WNtCgja2G3ihpO71CWagRR5E/44ecY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VxycM1pOPJ9ziqtGE3Nphd9gmQ+hvlmKY8vee2gLkIrQkv0we7m/CYJIyruTqoPQ52NGQz6TGdRlrSZ7uEd3vIoD0uXz12pbqlsDVP8A+gvLd9ORol7l28WkbnKJY+kGEvMJA9GmvS3Ndpe7S2sLv389XxwXo9RUmDkmi8xe+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDap84gl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707159570; x=1738695570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bQYlN6dlbdaq+WNtCgja2G3ihpO71CWagRR5E/44ecY=;
  b=ZDap84gl2nIUHE7Sjn/bwL9VRzHeJap1Dwz7TN+pqb0R9MnA2l4NKBAf
   1AeQTkT6gE3TrkPYuPi4cWdIV3sWG050z3TIVAZOgk4W3pMJDRwrYJIYL
   fXRz8fgzzUMFkX0/gTvh1oy70JBTGS2qOTNkSWiGTkBCtBLNFycDwDnii
   ztnrzOZztgrPhdFLMcy5RFE2zMxD7hyDGmsHu62KePgh0n/bF7Ff/T3zH
   vhD/u1HQ/2n0eObII7KdSWOfhDpXoMJrnNbwZ3wO9lqKrjvsn8xN1ZQYM
   eL+lkFKBa2034DDjQc8cY042K4mCvNzlVOISwWqHsEjssHJnl57YUI6ZG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11320384"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11320384"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="31879442"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2024 10:59:28 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 1/4] iio: hid-sensor-als: Assign channels dynamically
Date: Mon,  5 Feb 2024 10:59:23 -0800
Message-Id: <20240205185926.3030521-2-srinivas.pandruvada@linux.intel.com>
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

Instead of assuming that every channel defined statically by
als_channels[] is present, assign dynamically based on presence of the
respective usage id in the descriptor. This will allow to register ALS
with limited channel support. Append the timestamp as the last channel.

Update available_scan_mask to specify all channels which are present.

There is no intentional function changes done.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v5:
	- Move als_scan_mask to struct als_state
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

 drivers/iio/light/hid-sensor-als.c | 51 ++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index b6c4bef2a7bb..ed5c42aa7cca 100644
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
@@ -33,7 +34,15 @@ struct als_state {
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	int num_channels;
 	s64 timestamp;
+	unsigned long als_scan_mask[2];
+};
+
+/* The order of usage ids must match scan index starting from CHANNEL_SCAN_INDEX_INTENSITY */
+static const u32 als_usage_ids[] = {
+	HID_USAGE_SENSOR_LIGHT_ILLUM,
+	HID_USAGE_SENSOR_LIGHT_ILLUM,
 };
 
 static const u32 als_sensitivity_addresses[] = {
@@ -238,27 +247,38 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
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
+		st->als_scan_mask[0] |= BIT(i);
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
@@ -294,15 +314,7 @@ static int hid_als_probe(struct platform_device *pdev)
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
@@ -310,8 +322,15 @@ static int hid_als_probe(struct platform_device *pdev)
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
+	indio_dev->available_scan_masks = als_state->als_scan_mask;
+
 	indio_dev->info = &als_info;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.43.0


