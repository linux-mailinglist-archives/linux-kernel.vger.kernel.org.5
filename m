Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4A75D03C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGURAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGURAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:00:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483802D77;
        Fri, 21 Jul 2023 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689958820; x=1721494820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5nJHjGERAW3jaXOKzutpblot6hKhdh8NmrgkghAWl1s=;
  b=dG7VBNAYX/Ldi1EXZKu3gKexBGtTDt3rUvfKueJL3HAw+4+lpUffy7g+
   OBB2sKvKChX4+MjdRCi9zWL/sePKYmDMrltaKtpuO0ZwdPgoRF+Wu68kB
   +MTlDoElTwTwFygKDxIJB4yWEsF6lmXJlVSsj4gCJFvfLlqMpuPsyCbMi
   k8gEra+rbPOb2oCaE/cCgYStrJQBzOAw7M/cdbx7buzyQdFKbVWBwNg1x
   Xy8/7OsHWaujERvGBa20JrXm35Ipd0AEsCfkLBPwAQENH28Z+WwvLJOcj
   QudIKMSgWkEyOHM88c2oTq1C5d052U50NacG9sUVV7fAcvtE2gUK64/lU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453443908"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="453443908"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 10:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="675106518"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="675106518"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2023 10:00:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 426A542D; Fri, 21 Jul 2023 20:00:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2 2/8] iio: core: Use sysfs_match_string() helper
Date:   Fri, 21 Jul 2023 20:00:16 +0300
Message-Id: <20230721170022.3461-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_match_string() helper instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 81 +++++++++++++--------------------
 1 file changed, 31 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6cca86fd0ef9..4e45740331ee 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1400,50 +1400,32 @@ static ssize_t label_show(struct device *dev, struct device_attribute *attr,
 
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
 
-	switch (clk) {
-	case CLOCK_REALTIME:
-		name = "realtime\n";
-		sz = sizeof("realtime\n");
-		break;
-	case CLOCK_MONOTONIC:
-		name = "monotonic\n";
-		sz = sizeof("monotonic\n");
-		break;
-	case CLOCK_MONOTONIC_RAW:
-		name = "monotonic_raw\n";
-		sz = sizeof("monotonic_raw\n");
-		break;
-	case CLOCK_REALTIME_COARSE:
-		name = "realtime_coarse\n";
-		sz = sizeof("realtime_coarse\n");
-		break;
-	case CLOCK_MONOTONIC_COARSE:
-		name = "monotonic_coarse\n";
-		sz = sizeof("monotonic_coarse\n");
-		break;
-	case CLOCK_BOOTTIME:
-		name = "boottime\n";
-		sz = sizeof("boottime\n");
-		break;
-	case CLOCK_TAI:
-		name = "tai\n";
-		sz = sizeof("tai\n");
-		break;
-	default:
+	if (clk < 0 && clk >= ARRAY_SIZE(clock_names))
 		BUG();
-	}
 
-	memcpy(buf, name, sz);
-	return sz;
+	return sysfs_emit(buf, "%s\n", clock_names[clk]);
 }
 
 static ssize_t current_timestamp_clock_store(struct device *dev,
@@ -1453,22 +1435,21 @@ static ssize_t current_timestamp_clock_store(struct device *dev,
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
+
+	switch (ret) {
+	case CLOCK_PROCESS_CPUTIME_ID:
+	case CLOCK_THREAD_CPUTIME_ID:
+	case CLOCK_REALTIME_ALARM:
+	case CLOCK_BOOTTIME_ALARM:
+	case CLOCK_SGI_CYCLE:
 		return -EINVAL;
+	default:
+		clk = ret;
+		break;
+	}
 
 	ret = iio_device_set_clock(dev_to_iio_dev(dev), clk);
 	if (ret)
-- 
2.40.0.1.gaa8946217a0b

