Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A793A7F1188
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjKTLPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjKTLPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:15:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C75136;
        Mon, 20 Nov 2023 03:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478911; x=1732014911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FNHy54dIhFqpYBQdUdEJaKVZqyF8p5tUZlvi/WMNsXg=;
  b=k4Nc6SRU4KiqWsWtGs5nH5BSqhaYs2/ypxpxJ45l21gTCrpSx9bKSSRC
   qfG2y/2Xh7xC5SqSZP8rYaDde5jcV0QhCQIOxZMx4lB06pKmYjN+9y9Wh
   SC/uE7j+5L6oPPXOgdjTHeFU9lWw81dfchGagpjmOK0A24chEVocwHdoM
   886LTZv3LU8nc5/ulxD3DenWEw9HZH2jpYkup3vvjcf/BgEVmVP08XbpJ
   TBXA4qBZs06NFH/CDU8KGEw7ckXaVScoCZ0heKHg+8GtPg8BPxV/sBRlN
   XyWxBtARmKIKdVPeLRi7NmARDL0XTRGE904/PIY8/pmO+Ly9azttAY0aY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394447098"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394447098"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1013559150"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="1013559150"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:47 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 07/26] selftests/resctrl: Exclude shareable bits from schemata in CAT test
Date:   Mon, 20 Nov 2023 13:13:21 +0200
Message-Id: <20231120111340.7805-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CAT test doesn't take shareable bits into account, i.e., the test might
be sharing cache with some devices (e.g., graphics).

Introduce get_mask_no_shareable() and use it to provision an
environment for CAT test where the allocated LLC is isolated better.
Excluding shareable_bits may create hole(s) into the cbm_mask, thus add
a new helper count_contiguous_bits() to find the longest contiguous set
of CBM bits.

create_bit_mask() is needed by an upcoming CAT test rewrite so make it
available in resctrl.h right away.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c  | 12 ++-
 tools/testing/selftests/resctrl/resctrl.h   |  3 +
 tools/testing/selftests/resctrl/resctrlfs.c | 89 +++++++++++++++++++++
 3 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index cfcdb7bd600f..2c8b37c0a179 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -89,15 +89,19 @@ void cat_test_cleanup(void)
 
 int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
+	unsigned long full_cache_mask, long_mask;
 	unsigned long l_mask, l_mask_1;
 	int ret, pipefd[2], sibling_cpu_no;
 	unsigned long cache_total_size = 0;
-	unsigned long long_mask;
 	int count_of_bits;
 	char pipe_message;
 	size_t span;
 
-	ret = get_full_cbm(cache_type, &long_mask);
+	ret = get_full_cbm(cache_type, &full_cache_mask);
+	if (ret)
+		return ret;
+	/* Get the exclusive portion of the cache */
+	ret = get_mask_no_shareable(cache_type, &long_mask);
 	if (ret)
 		return ret;
 
@@ -136,7 +140,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	/* Set param values for parent thread which will be allocated bitmask
 	 * with (max_bits - n) bits
 	 */
-	span = cache_portion_size(cache_total_size, l_mask, long_mask);
+	span = cache_portion_size(cache_total_size, l_mask, full_cache_mask);
 	strcpy(param.ctrlgrp, "c2");
 	strcpy(param.mongrp, "m2");
 	strcpy(param.filename, RESULT_FILE_NAME2);
@@ -158,7 +162,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		param.mask = l_mask_1;
 		strcpy(param.ctrlgrp, "c1");
 		strcpy(param.mongrp, "m1");
-		span = cache_portion_size(cache_total_size, l_mask_1, long_mask);
+		span = cache_portion_size(cache_total_size, l_mask_1, full_cache_mask);
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 57fe42f4eda2..a911b08fa595 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -99,7 +99,10 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd);
 void mba_test_cleanup(void);
+unsigned long create_bit_mask(unsigned int start, unsigned int len);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
+int get_shareable_mask(const char *cache_type, unsigned long *shareable_mask);
+int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 1ea610fa65b1..3a9ed918d657 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -228,6 +228,44 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
 	return 0;
 }
 
+/*
+ * create_bit_mask- Create bit mask from start,len pair
+ * @start:	LSB of the mask
+ * @len		Number of bits in the mask
+ */
+unsigned long create_bit_mask(unsigned int start, unsigned int len)
+{
+	return ((1UL << len) - 1UL) << start;
+}
+
+/*
+ * count_contiguous_bits - Returns the longest train of bits in a bit mask
+ * @val		A bit mask
+ * @start	The location of the least-significant bit of the longest train
+ *
+ * Return:	The length of the contiguous bits in the longest train of bits
+ */
+static unsigned int count_contiguous_bits(unsigned long val, unsigned int *start)
+{
+	unsigned long last_val;
+	unsigned int count = 0;
+
+	while (val) {
+		last_val = val;
+		val &= (val >> 1);
+		count++;
+	}
+
+	if (start) {
+		if (count)
+			*start = ffsl(last_val) - 1;
+		else
+			*start = 0;
+	}
+
+	return count;
+}
+
 /*
  * get_full_cbm - Get full Cache Bit Mask (CBM)
  * @cache_type:	Cache type as "L2" or "L3"
@@ -254,6 +292,57 @@ int get_full_cbm(const char *cache_type, unsigned long *mask)
 	return 0;
 }
 
+/*
+ * get_shareable_mask - Get shareable mask from shareable_bits
+ * @cache_type:		Cache type as "L2" or "L3"
+ * @shareable_mask:	Shareable mask returned as unsigned long
+ *
+ * Return: = 0 on success, < 0 on failure.
+ */
+int get_shareable_mask(const char *cache_type, unsigned long *shareable_mask)
+{
+	char mask_path[PATH_MAX];
+
+	if (!cache_type)
+		return -1;
+
+	snprintf(mask_path, sizeof(mask_path), "%s/%s/shareable_bits",
+		 INFO_PATH, cache_type);
+
+	return get_bit_mask(mask_path, shareable_mask);
+}
+
+/*
+ * get_mask_no_shareable - Get Cache Bit Mask (CBM) without shareable bits
+ * @cache_type:		Cache type as "L2" or "L3"
+ * @mask:		The largest exclusive portion of the cache out of the
+ *			full CBM, returned as unsigned long
+ *
+ * Parts of a cache may be shared with other devices such as GPU. This function
+ * calculates the largest exclusive portion of the cache where no other devices
+ * besides CPU have access to the cache portion.
+ *
+ * Return: = 0 on success, < 0 on failure.
+ */
+int get_mask_no_shareable(const char *cache_type, unsigned long *mask)
+{
+	unsigned long full_mask, shareable_mask;
+	unsigned int start, len;
+
+	if (get_full_cbm(cache_type, &full_mask) < 0)
+		return -1;
+	if (get_shareable_mask(cache_type, &shareable_mask) < 0)
+		return -1;
+
+	len = count_contiguous_bits(full_mask & ~shareable_mask, &start);
+	if (!len)
+		return -1;
+
+	*mask = create_bit_mask(start, len);
+
+	return 0;
+}
+
 /*
  * get_core_sibling - Get sibling core id from the same socket for given CPU
  * @cpu_no:	CPU number
-- 
2.30.2

