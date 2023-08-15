Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FC677CF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbjHOPla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbjHOPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:41:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A39BE61;
        Tue, 15 Aug 2023 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114077; x=1723650077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lWHTVMVVzUsh687F017zJbmNhEj8Fz4h52xIxzZXMOY=;
  b=NfvOQJNE2AJ/0l0K2jvUEWTGeT54uA14Mn/VlLa7TjqdzIIqmEZ4L+vs
   i1bhLYfssDzRg4/Ltt2OJzg2H+ZjbcTHniU9s/N3Hzy3BK7cvWBKjtd2e
   UHEIIMcPGTVAkNt34fF+qF9YSYSpXLNAbvBhKJ3G/tWdsSoW3+CztPRHq
   8GVK3yd5zZ1Q1B2JWNktM5olvOpLw25vrHIfR8xGvsPqyfC3NfJPb5wx9
   /bpdcIYnularxuiuvKanC0Emr03ule2oD1UEdx5zEXR/neWc9rcHzmflu
   YdLfDyKPj2T9F4cQ4kmkbdwa3thp/hlZ9RNe957fxQ/9xXOkH4f+MXdAI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="351896974"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="351896974"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727406715"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="727406715"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2023 08:41:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 72389C84; Tue, 15 Aug 2023 18:41:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 3/3] iio: hid-sensor: Use aligned data type for timestamp
Date:   Tue, 15 Aug 2023 18:40:27 +0300
Message-Id: <20230815154027.12468-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
References: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use aligned_s64 for the timestamp field.

Note, the actual data is signed, hence with this we also amend that.
While at it, drop redundant __alignment directive.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c              | 3 +--
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 2 +-
 drivers/iio/humidity/hid-sensor-humidity.c           | 2 +-
 drivers/iio/light/hid-sensor-als.c                   | 2 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c         | 2 +-
 drivers/iio/orientation/hid-sensor-rotation.c        | 4 ++--
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 drivers/iio/pressure/hid-sensor-press.c              | 2 +-
 drivers/iio/temperature/hid-sensor-temperature.c     | 2 +-
 9 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 5eac7ea19993..f739589564c5 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -25,10 +25,9 @@ struct accel_3d_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info accel[ACCEL_3D_CHANNEL_MAX];
-	/* Ensure timestamp is naturally aligned */
 	struct {
 		u32 accel_val[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 698c50da1f10..a7050a6328d6 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -27,7 +27,7 @@ struct gyro_3d_state {
 	struct hid_sensor_hub_attribute_info gyro[GYRO_3D_CHANNEL_MAX];
 	struct {
 		u32 gyro_val[GYRO_3D_CHANNEL_MAX];
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index fa0fe404a70a..0e484b78b735 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -18,7 +18,7 @@ struct hid_humidity_state {
 	struct hid_sensor_hub_attribute_info humidity_attr;
 	struct {
 		s32 humidity_data;
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index eb1aedad7edc..8a906d95edd4 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -27,7 +27,7 @@ struct als_state {
 	struct hid_sensor_hub_attribute_info als_illum;
 	struct {
 		u32 illum[CHANNEL_SCAN_INDEX_MAX];
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index ba5b581d5b25..3e5f2c58dfa9 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -29,7 +29,7 @@ struct incl_3d_state {
 	struct hid_sensor_hub_attribute_info incl[INCLI_3D_CHANNEL_MAX];
 	struct {
 		u32 incl_val[INCLI_3D_CHANNEL_MAX];
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index a033699910e8..864ecbcad26e 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -19,8 +19,8 @@ struct dev_rot_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info quaternion;
 	struct {
-		s32 sampled_vals[4] __aligned(16);
-		u64 timestamp __aligned(8);
+		s32 sampled_vals[4];
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 07c30d217255..48005b568dd9 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -39,7 +39,7 @@ struct hinge_state {
 	const char *labels[CHANNEL_SCAN_INDEX_MAX];
 	struct {
 		u32 hinge_val[3];
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 
 	int scale_pre_decml;
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index a9215eb32d70..a964c7b65402 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -24,7 +24,7 @@ struct press_state {
 	struct hid_sensor_hub_attribute_info press_attr;
 	struct {
 		u32 press_data;
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index d40f235af1d4..32f4b13fd554 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -18,7 +18,7 @@ struct temperature_state {
 	struct hid_sensor_hub_attribute_info temperature_attr;
 	struct {
 		s32 temperature_data;
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
-- 
2.40.0.1.gaa8946217a0b

