Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E780C97D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbjLKMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343576AbjLKMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:20:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B42100;
        Mon, 11 Dec 2023 04:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297213; x=1733833213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cxNgVJ/PcdwvPUNXmgeYJWokNuSFkR1LsjZSrf4aHqw=;
  b=T3qSwIEvzxU3k2xcCrxZMVR3wldRKIpMosRxqgMcvA/ee4nDikOJdNCH
   S0AEBFvJKY96aFMlNm6lHgsB6M5dYwf7QkaEdJ//T4LYT11/KYefmNfOH
   oswygmwUc2iwuKpiGXzOeUHqK/7JksGnNAK3GtnvzY2wiFsO7X6NJJwN9
   hkYBfyim1ABI52Ap/0uhZ+ZoAF33l8u7RnkxOsg6AUZQaKViHkkSsNqzs
   hxx/oElWZ29QQd9+oYGR7nSl15liUm4B3oL5zJo/j1uDVOU+KybYXr0kZ
   jcrtj8E74qfDIZpeSAQTvQ8O9n1MOg0MUa5lrpPsXDE3+le/2odoaMj2O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="374797142"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="374797142"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="896441099"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="896441099"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:07 -0800
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
Subject: [PATCH v3 10/29] selftests/resctrl: Exclude shareable bits from schemata in CAT test
Date:   Mon, 11 Dec 2023 14:18:07 +0200
Message-Id: <20231211121826.14392-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

v3:
- Tweak comments
- Make get_shareable_mask() static
---
 tools/testing/selftests/resctrl/cat_test.c  | 12 ++-
 tools/testing/selftests/resctrl/resctrl.h   |  2 +
 tools/testing/selftests/resctrl/resctrlfs.c | 89 +++++++++++++++++++++
 3 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index f18c95dda5d3..1e3c5432ecff 100644
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
+	/* Get the largest contiguous exclusive portion of the cache */
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
index 0e3a4da5f6ec..40baebb066aa 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -98,7 +98,9 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd);
 void mba_test_cleanup(void);
+unsigned long create_bit_mask(unsigned int start, unsigned int len);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
+int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 65e149038248..35425d00ede6 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -228,6 +228,44 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
 	return 0;
 }
 
+/*
+ * create_bit_mask- Create bit mask from start, len pair
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
+static int get_shareable_mask(const char *cache_type, unsigned long *shareable_mask)
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

