Return-Path: <linux-kernel+bounces-1245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7C4814C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3BB1C22C60
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF503A8C0;
	Fri, 15 Dec 2023 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkTbs8Sv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95F36AE0;
	Fri, 15 Dec 2023 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702656142; x=1734192142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T9RSzfQqw97u35cP02echEw6kn4/I1wBERkazpCYse0=;
  b=EkTbs8SvvR7AaB51QsNZO88wzFpbWK5raXEw/acUXUV3+d3DjA1jgrk+
   rmgNV49L3O87SFWyKtzk4qdGELRTCc//CjlAMp3aHWOv0AObN3OWqfaPJ
   uJF5lsNU7AmFdAxnYdh5PZciJyOhH3EwPSlieYLRCxBYRBeKvCEidN7wO
   o48T3FvxoqVgxp+8W/clSVr4nNd0oJ7iyWos+NldW8PcK0rPdTkL8ebZR
   88b0gEpP72/eOOWXCtA91DzGst29IB0DgtnkBO0YjwvhX6VaKRks8KakH
   tmxmneJ2X4zKUb4nHMu7aaxOF6UkwBjeWmRzm5FRkzCwVCrVvVSjEUJrK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="13973685"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="13973685"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:02:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="948010121"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="948010121"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2023 08:02:20 -0800
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
Subject: [PATCH] iio: light: hid-sensor-als: Avoid failure for chromaticity support
Date: Fri, 15 Dec 2023 08:01:59 -0800
Message-Id: <20231215160159.648963-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With the commit ee3710f39f9d ("iio: hid-sensor-als: Add light chromaticity
support"), there is an assumption that the every HID ALS descriptor has
support of usage ids for chromaticity support. If they are not present,
probe fails for the driver . This breaks ALS functionality on majority of
platforms.

It is possible that chromaticity usage ids are not present. When not
present, restrict number of IIO channels to not include support for
chromaticity and continue.

Fixes: ee3710f39f9d ("iio: hid-sensor-als: Add light chromaticity support")
Reported-by: Thomas Weißschuh <thomas@t-8ch.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218223
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/light/hid-sensor-als.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index f17304b54468..9941b0b927c7 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -303,11 +303,14 @@ static int als_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
 				unsigned usage_id,
-				struct als_state *st)
+				struct als_state *st,
+				int *max_channels)
 {
 	int ret;
 	int i;
 
+	*max_channels = CHANNEL_SCAN_INDEX_MAX;
+
 	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {
 		ret = sensor_hub_input_get_attribute_info(hsdev,
 						HID_INPUT_REPORT,
@@ -326,8 +329,12 @@ static int als_parse_report(struct platform_device *pdev,
 				usage_id,
 				HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
 				&st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		*max_channels = CHANNEL_SCAN_INDEX_ILLUM;
+		ret = 0;
+		goto skip_color_chromaticity;
+	}
+
 	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
 				st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
 
@@ -354,6 +361,7 @@ static int als_parse_report(struct platform_device *pdev,
 			st->als[next_scan_index].report_id);
 	}
 
+skip_color_chromaticity:
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
@@ -364,7 +372,7 @@ static int als_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_als_probe(struct platform_device *pdev)
 {
-	int ret = 0;
+	int ret = 0, max_channels;
 	static const char *name = "als";
 	struct iio_dev *indio_dev;
 	struct als_state *als_state;
@@ -398,15 +406,15 @@ static int hid_als_probe(struct platform_device *pdev)
 
 	ret = als_parse_report(pdev, hsdev,
 			       (struct iio_chan_spec *)indio_dev->channels,
-			       hsdev->usage,
-			       als_state);
+			       hsdev->usage, als_state, &max_channels);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		return ret;
 	}
 
-	indio_dev->num_channels =
-				ARRAY_SIZE(als_channels);
+	/* +1 to include time stamp */
+	indio_dev->num_channels = max_channels + 1;
+
 	indio_dev->info = &als_info;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.25.1


