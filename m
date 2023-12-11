Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C171B80C990
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343538AbjLKMVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343539AbjLKMVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:21:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8F0107;
        Mon, 11 Dec 2023 04:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297282; x=1733833282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YMYI9oid+K2JskdB22OfgPpbCZd/KLKqGl94ZNVAjLM=;
  b=hoDujIkZ7VLFcV+J9bokMn8y6fnAtu+aOfZ1R6C065tdMp2mklFwYGNL
   oLP7qaRrQU45umSdbGnOfCpjqTvpwa3OOAEzBXgdrW5wBmV3H37gF+UqU
   kbT+gH2XjcYKVoOE4CftKZ3BSQneb54Q5ihBNRQ8TrM7PiDCGuAaHI4aJ
   AAuhLZQXksgmRqhFwumeXzLwtvuZfH7seC5vLBPh6863K2PBKSP6aFaQ+
   0klNp+JpIf8sC9bb1oPKW4KEs5U7oHbxiQL54KIAWKro51XQSDzkXgTxf
   U3l1cCm0XIuFlJMz5Jrf614VyV9FxGIasAG4TGKdsCrpTtZXVQc5ji7Te
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="397429063"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="397429063"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="722766396"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="722766396"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:21:18 -0800
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
Subject: [PATCH v3 18/29] selftests/resctrl: Move cat_val() to cat_test.c and rename to cat_test()
Date:   Mon, 11 Dec 2023 14:18:15 +0200
Message-Id: <20231211121826.14392-19-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
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

The main CAT test function is called cat_val() and resides in cache.c
which is illogical.

Rename the function to cat_test() and move it into cat_test.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 90 ++--------------------
 tools/testing/selftests/resctrl/cat_test.c | 73 +++++++++++++++++-
 tools/testing/selftests/resctrl/resctrl.h  | 14 +++-
 3 files changed, 90 insertions(+), 87 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 335415eaa406..319d0cdd7225 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -3,16 +3,9 @@
 #include <stdint.h>
 #include "resctrl.h"
 
-struct perf_event_read {
-	__u64 nr;			/* The number of events */
-	struct {
-		__u64 value;		/* The value of the event */
-	} values[2];
-};
-
 char llc_occup_path[1024];
 
-static void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config)
+void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config)
 {
 	memset(pea, 0, sizeof(*pea));
 	pea->type = PERF_TYPE_HARDWARE;
@@ -35,13 +28,13 @@ static void perf_event_reset_enable(int pe_fd)
 	ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
 }
 
-static void perf_event_initialize_read_format(struct perf_event_read *pe_read)
+void perf_event_initialize_read_format(struct perf_event_read *pe_read)
 {
 	memset(pe_read, 0, sizeof(*pe_read));
 	pe_read->nr = 1;
 }
 
-static int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no)
+int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no)
 {
 	int pe_fd;
 
@@ -130,8 +123,8 @@ static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value
  *
  * Return: =0 on success. <0 on failure.
  */
-static int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
-			      const char *filename, int bm_pid)
+int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
+		       const char *filename, int bm_pid)
 {
 	int ret;
 
@@ -169,79 +162,6 @@ int measure_llc_resctrl(const char *filename, int bm_pid)
 	return print_results_cache(filename, bm_pid, llc_occu_resc);
 }
 
-/*
- * cache_val:		execute benchmark and measure LLC occupancy resctrl
- * and perf cache miss for the benchmark
- * @param:		parameters passed to cache_val()
- * @span:		buffer size for the benchmark
- *
- * Return:		0 when the test was run, < 0 on error.
- */
-int cat_val(struct resctrl_val_param *param, size_t span)
-{
-	int memflush = 1, operation = 0, ret = 0;
-	char *resctrl_val = param->resctrl_val;
-	struct perf_event_read pe_read;
-	struct perf_event_attr pea;
-	pid_t bm_pid;
-	int pe_fd;
-
-	if (strcmp(param->filename, "") == 0)
-		sprintf(param->filename, "stdio");
-
-	bm_pid = getpid();
-
-	/* Taskset benchmark to specified cpu */
-	ret = taskset_benchmark(bm_pid, param->cpu_no);
-	if (ret)
-		return ret;
-
-	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
-	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
-				      resctrl_val);
-	if (ret)
-		return ret;
-
-	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
-	perf_event_initialize_read_format(&pe_read);
-
-	/* Test runs until the callback setup() tells the test to stop. */
-	while (1) {
-		ret = param->setup(param);
-		if (ret == END_OF_TESTS) {
-			ret = 0;
-			break;
-		}
-		if (ret < 0)
-			break;
-
-		pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
-		if (pe_fd < 0) {
-			ret = -1;
-			break;
-		}
-
-		if (run_fill_buf(span, memflush, operation, true)) {
-			fprintf(stderr, "Error-running fill buffer\n");
-			ret = -1;
-			goto pe_close;
-		}
-
-		sleep(1);
-		ret = perf_event_measure(pe_fd, &pe_read, param->filename, bm_pid);
-		if (ret)
-			goto pe_close;
-
-		close(pe_fd);
-	}
-
-	return ret;
-
-pe_close:
-	close(pe_fd);
-	return ret;
-}
-
 /*
  * show_cache_info - Show generic cache test information
  * @no_of_bits:		Number of bits
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 516eaa08e967..bfb607b13491 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -111,6 +111,77 @@ void cat_test_cleanup(void)
 	remove(RESULT_FILE_NAME2);
 }
 
+/*
+ * cat_test - Execute CAT benchmark and measure cache misses
+ * @param:		Parameters passed to cat_test()
+ * @span:		Buffer size for the benchmark
+ *
+ * Return:		0 when the test was run, < 0 on error.
+ */
+static int cat_test(struct resctrl_val_param *param, size_t span)
+{
+	int memflush = 1, operation = 0, ret = 0;
+	char *resctrl_val = param->resctrl_val;
+	struct perf_event_read pe_read;
+	struct perf_event_attr pea;
+	pid_t bm_pid;
+	int pe_fd;
+
+	if (strcmp(param->filename, "") == 0)
+		sprintf(param->filename, "stdio");
+
+	bm_pid = getpid();
+
+	/* Taskset benchmark to specified cpu */
+	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	if (ret)
+		return ret;
+
+	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				      resctrl_val);
+	if (ret)
+		return ret;
+
+	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
+	perf_event_initialize_read_format(&pe_read);
+
+	/* Test runs until the callback setup() tells the test to stop. */
+	while (1) {
+		ret = param->setup(param);
+		if (ret == END_OF_TESTS) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+		pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
+		if (pe_fd < 0) {
+			ret = -1;
+			break;
+		}
+
+		if (run_fill_buf(span, memflush, operation, true)) {
+			fprintf(stderr, "Error-running fill buffer\n");
+			ret = -1;
+			goto pe_close;
+		}
+
+		sleep(1);
+		ret = perf_event_measure(pe_fd, &pe_read, param->filename, bm_pid);
+		if (ret)
+			goto pe_close;
+
+		close(pe_fd);
+	}
+
+	return ret;
+
+pe_close:
+	close(pe_fd);
+	return ret;
+}
+
 int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
 	unsigned long full_cache_mask, long_mask;
@@ -194,7 +265,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	remove(param.filename);
 
-	ret = cat_val(&param, span);
+	ret = cat_test(&param, span);
 	if (ret == 0)
 		ret = check_results(&param, span);
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 9aac7b66ada8..6635d5c1908a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -66,6 +66,13 @@ struct resctrl_val_param {
 	int		(*setup)(struct resctrl_val_param *param);
 };
 
+struct perf_event_read {
+	__u64 nr;			/* The number of events */
+	struct {
+		__u64 value;		/* The value of the event */
+	} values[2];
+};
+
 #define MBM_STR			"mbm"
 #define MBA_STR			"mba"
 #define CMT_STR			"cmt"
@@ -105,13 +112,18 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
-int cat_val(struct resctrl_val_param *param, size_t span);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
 int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
+
+void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
+void perf_event_initialize_read_format(struct perf_event_read *pe_read);
+int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no);
+int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
+		       const char *filename, int bm_pid);
 int measure_llc_resctrl(const char *filename, int bm_pid);
 void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool lines);
 
-- 
2.30.2

