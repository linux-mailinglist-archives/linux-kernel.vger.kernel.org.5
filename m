Return-Path: <linux-kernel+bounces-4354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5937817BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DEB281D42
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9C7409A;
	Mon, 18 Dec 2023 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kai625IU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F961E52B;
	Mon, 18 Dec 2023 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702931439; x=1734467439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3DZC0thtx+lpV/xVAPFqdSngEklAG5mK84qDgaJh9w=;
  b=Kai625IUZ8UgW7Pk24YRtOzfjjnLAoHJMSnywclBQPenRpyQ0CWOa6ln
   alAwa4K7Dsd+pSNdirynLHBMCwFMSS2Owb5X4ySWilb2Yo1N2EW7S85EY
   WOXLUgDg00ie+4m5LxpsjHMtFWxbEe3Z3gvJHTCO1k5ScjQPTBlsfClzw
   DqafALGBRaU1+FiF25KKCAetHsK4CpXzxw9uQwiAIsaLdOkmW9vrekow9
   rOtEMQOwTbk4SsUcNZRAPl/56dQBiQo/kJRm9y4YzMaTO6oa05hw7i5Vi
   X1t972QtMqAL2zH0JKGQekUQV0QtrlV5CP7NB2sXU2xNGUI4N+j2Q4pvX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="395289748"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="395289748"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="751879652"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="751879652"
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
Subject: [PATCH v2 1/3] iio: hid-sensor-als: Allocate channels dynamically
Date: Mon, 18 Dec 2023 12:30:24 -0800
Message-Id: <20231218203026.1156375-2-srinivas.pandruvada@linux.intel.com>
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

Instead of assuming that every channel defined statically by
als_channels[] is present, allocate dynamically based on presence of the
respective usage id in the descriptor. This will allow to register ALS
with limited channel support. Append the timestamp as the last channel.

There is no intentional function changes done.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
New change

 drivers/iio/light/hid-sensor-als.c | 57 ++++++++++++++++++------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 5cd27f04b45e..e57ad1946b56 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -236,14 +236,21 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 
 /* Parse report which is specific to an usage id*/
 static int als_parse_report(struct platform_device *pdev,
-				struct hid_sensor_hub_device *hsdev,
-				struct iio_chan_spec *channels,
-				unsigned usage_id,
-				struct als_state *st)
+			    struct hid_sensor_hub_device *hsdev,
+			    struct iio_chan_spec **channels_out,
+			    int *size_channels_out,
+			    unsigned int usage_id,
+			    struct als_state *st)
 {
-	int ret;
+	struct iio_chan_spec *channels;
+	int ret, index = 0;
 	int i;
 
+	channels = devm_kcalloc(&pdev->dev, ARRAY_SIZE(als_channels),
+				sizeof(als_channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
 	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {
 		ret = sensor_hub_input_get_attribute_info(hsdev,
 						HID_INPUT_REPORT,
@@ -251,9 +258,11 @@ static int als_parse_report(struct platform_device *pdev,
 						HID_USAGE_SENSOR_LIGHT_ILLUM,
 						&st->als[i]);
 		if (ret < 0)
-			return ret;
-		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
+			break;
 
+		channels[i] = als_channels[i];
+		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
+		++index;
 		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
 			st->als[i].report_id);
 	}
@@ -262,17 +271,24 @@ static int als_parse_report(struct platform_device *pdev,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
 
-	return ret;
+	*channels_out = channels;
+	*size_channels_out = index;
+
+	if (!index)
+		ret = -ENODEV;
+
+	return 0;
 }
 
 /* Function to initialize the processing for usage id */
 static int hid_als_probe(struct platform_device *pdev)
 {
-	int ret = 0;
+	int ret = 0, max_channel_index;
 	static const char *name = "als";
 	struct iio_dev *indio_dev;
 	struct als_state *als_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct als_state));
 	if (!indio_dev)
@@ -293,24 +309,21 @@ static int hid_als_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, als_channels,
-					   sizeof(als_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
-		return -ENOMEM;
-	}
-
-	ret = als_parse_report(pdev, hsdev,
-			       (struct iio_chan_spec *)indio_dev->channels,
-			       hsdev->usage,
-			       als_state);
+	ret = als_parse_report(pdev, hsdev, &channels, &max_channel_index,
+			       hsdev->usage, als_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		return ret;
 	}
 
-	indio_dev->num_channels =
-				ARRAY_SIZE(als_channels);
+	/* Add timestamp channel */
+	channels[max_channel_index] = als_channels[CHANNEL_SCAN_INDEX_TIMESTAMP];
+	channels[max_channel_index].scan_index = max_channel_index;
+
+	/* +1 for adding timestamp channel */
+	indio_dev->num_channels = max_channel_index + 1;
+
+	indio_dev->channels = channels;
 	indio_dev->info = &als_info;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.43.0


