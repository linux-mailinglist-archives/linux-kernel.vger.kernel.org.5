Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D557975F422
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjGXLCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjGXLCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:02:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC3188;
        Mon, 24 Jul 2023 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196528; x=1721732528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IctMq3br23eXnIOPxaHEk5MUrLAMEQPmIQZh4PnfpIo=;
  b=mlGSB5U1X+slgG+DdR5jLJBl4bFi7cZRdP2uwZRvCNTbcfBZxF8aWW1m
   L+trTPS0m3z/VgXrvGWFYv3HOaYCjk/Je1BlEhexYDWoY6pjVPHOdX+PC
   vbU+rBV2m0sAvMstF0LZCpMDREKlxdIEc5HDxsG4vF0icbjj9wymm04YF
   znvRHCaTFJh6vZxRUIL1nJARBwRmK+0JzOet0mzn/oBRDKMifqXo057OS
   OZKXcv4r5RtF+chN8Kk7bEwucNS2MokkBuUQSWUSGuh4FjUPQEKHZWTI0
   ZZJ2Pv2NO/7IGKogr0zQpmPDarlm+AyWAWDq5ngPKigfNXV2EWAECOMGW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347012823"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347012823"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775353"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775353"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:01:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BD4FD195; Mon, 24 Jul 2023 14:02:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v3 1/4] iio: core: Use sysfs_match_string() helper
Date:   Mon, 24 Jul 2023 14:02:01 +0300
Message-Id: <20230724110204.46285-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_match_string() helper instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 71 +++++++++++++++------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 5f337f59330c..b153adc5bc84 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1397,50 +1397,42 @@ static ssize_t label_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(label);
 
+static const char * const clock_names[] = {
+	[CLOCK_REALTIME]	 	= "realtime",
+	[CLOCK_MONOTONIC]	 	= "monotonic",
+	[CLOCK_PROCESS_CPUTIME_ID]	= "process_cputime_id",
+	[CLOCK_THREAD_CPUTIME_ID]	= "thread_cputime_id",
+	[CLOCK_MONOTONIC_RAW]	 	= "monotonic_raw",
+	[CLOCK_REALTIME_COARSE]	 	= "realtime_coarse",
+	[CLOCK_MONOTONIC_COARSE] 	= "monotonic_coarse",
+	[CLOCK_BOOTTIME]	 	= "boottime",
+	[CLOCK_REALTIME_ALARM]		= "realtime_alarm",
+	[CLOCK_BOOTTIME_ALARM]		= "boottime_alarm",
+	[CLOCK_SGI_CYCLE]		= "sgi_cycle",
+	[CLOCK_TAI]		 	= "tai",
+};
+
 static ssize_t current_timestamp_clock_show(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
 	const struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	const clockid_t clk = iio_device_get_clock(indio_dev);
-	const char *name;
-	ssize_t sz;
 
 	switch (clk) {
 	case CLOCK_REALTIME:
-		name = "realtime\n";
-		sz = sizeof("realtime\n");
-		break;
 	case CLOCK_MONOTONIC:
-		name = "monotonic\n";
-		sz = sizeof("monotonic\n");
-		break;
 	case CLOCK_MONOTONIC_RAW:
-		name = "monotonic_raw\n";
-		sz = sizeof("monotonic_raw\n");
-		break;
 	case CLOCK_REALTIME_COARSE:
-		name = "realtime_coarse\n";
-		sz = sizeof("realtime_coarse\n");
-		break;
 	case CLOCK_MONOTONIC_COARSE:
-		name = "monotonic_coarse\n";
-		sz = sizeof("monotonic_coarse\n");
-		break;
 	case CLOCK_BOOTTIME:
-		name = "boottime\n";
-		sz = sizeof("boottime\n");
-		break;
 	case CLOCK_TAI:
-		name = "tai\n";
-		sz = sizeof("tai\n");
 		break;
 	default:
 		BUG();
 	}
 
-	memcpy(buf, name, sz);
-	return sz;
+	return sysfs_emit(buf, "%s\n", clock_names[clk]);
 }
 
 static ssize_t current_timestamp_clock_store(struct device *dev,
@@ -1450,22 +1442,23 @@ static ssize_t current_timestamp_clock_store(struct device *dev,
 	clockid_t clk;
 	int ret;
 
-	if (sysfs_streq(buf, "realtime"))
-		clk = CLOCK_REALTIME;
-	else if (sysfs_streq(buf, "monotonic"))
-		clk = CLOCK_MONOTONIC;
-	else if (sysfs_streq(buf, "monotonic_raw"))
-		clk = CLOCK_MONOTONIC_RAW;
-	else if (sysfs_streq(buf, "realtime_coarse"))
-		clk = CLOCK_REALTIME_COARSE;
-	else if (sysfs_streq(buf, "monotonic_coarse"))
-		clk = CLOCK_MONOTONIC_COARSE;
-	else if (sysfs_streq(buf, "boottime"))
-		clk = CLOCK_BOOTTIME;
-	else if (sysfs_streq(buf, "tai"))
-		clk = CLOCK_TAI;
-	else
+	ret = sysfs_match_string(clock_names, buf);
+	if (ret < 0)
+		return ret;
+	clk = ret;
+
+	switch (clk) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+	case CLOCK_REALTIME_COARSE:
+	case CLOCK_MONOTONIC_COARSE:
+	case CLOCK_BOOTTIME:
+	case CLOCK_TAI:
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	ret = iio_device_set_clock(dev_to_iio_dev(dev), clk);
 	if (ret)
-- 
2.40.0.1.gaa8946217a0b

