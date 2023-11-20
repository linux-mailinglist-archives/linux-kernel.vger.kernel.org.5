Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1B7F11A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjKTLRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjKTLRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:17:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C108170F;
        Mon, 20 Nov 2023 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478984; x=1732014984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xPmGr7tpOJkUFCgjC5RUy87oirL30OKjxVb4BLpr69M=;
  b=LBboshScG0hI3ZXgHmNWeYpb+wGGc+koxiljQv8VYZ12o0mFVCW64BZE
   NFJC92xaYhFc2DQHjRXav5rqEafC8Rxyot1BXwqaxhj0EpiOclYdfmv0a
   rsAaDvIeRXVai+CMBfSB+qlSihkJA0wS+yfyJlciPaU9fb1OJuCVJCZa1
   KfUY/fAozAXgylpmctLFh2KDyGtoyfqCkjfmKRQOoGYQNTI+5b6ShSRqh
   3yNikpzZM6o4YVUYCOwQQmduqpou2ZzY49QBiBoAIHJsS5LHM7k5oVbs6
   Y6ihuRNwF8yNAjiT28orDbz5/KOoW7z9FcFs8mJkHAW9dZ6ArATtFLt6k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="388737175"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="388737175"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="759761378"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="759761378"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:06 -0800
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
Subject: [PATCH v2 16/26] selftests/resctrl: Open perf fd before start & add error handling
Date:   Mon, 20 Nov 2023 13:13:30 +0200
Message-Id: <20231120111340.7805-17-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf fd (pe_fd) is opened, reset, and enabled during every test the CAT
selftest runs. Also, ioctl(pe_fd, ...) calls are not error checked even
if ioctl() could return an error.

Open perf fd only once before the tests and only reset and enable the
counter within the test loop. Add error checking to pe_fd ioctl()
calls.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 19 +++++++++++++++----
 tools/testing/selftests/resctrl/cat_test.c | 14 +++++++-------
 tools/testing/selftests/resctrl/resctrl.h  |  1 +
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 29d70fc11f4e..012da5952cd6 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -22,10 +22,19 @@ void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config)
 }
 
 /* Start counters to log values */
-static void perf_event_reset_enable(int pe_fd)
+int perf_event_reset_enable(int pe_fd)
 {
-	ioctl(pe_fd, PERF_EVENT_IOC_RESET, 0);
-	ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
+	int ret;
+
+	ret = ioctl(pe_fd, PERF_EVENT_IOC_RESET, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 void perf_event_initialize_read_format(struct perf_event_read *pe_read)
@@ -129,7 +138,9 @@ int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
 	int ret;
 
 	/* Stop counters after one span to get miss rate */
-	ioctl(pe_fd, PERF_EVENT_IOC_DISABLE, 0);
+	ret = ioctl(pe_fd, PERF_EVENT_IOC_DISABLE, 0);
+	if (ret < 0)
+		return ret;
 
 	ret = read(pe_fd, pe_read, sizeof(*pe_read));
 	if (ret == -1) {
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 7e1c383f9119..cfda87667b46 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -145,6 +145,9 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
 
 	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
 	perf_event_initialize_read_format(&pe_read);
+	pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
+	if (pe_fd < 0)
+		return pe_fd;
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
@@ -155,11 +158,10 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
 		}
 		if (ret < 0)
 			break;
-		pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
-		if (pe_fd < 0) {
-			ret = -1;
-			break;
-		}
+
+		ret = perf_event_reset_enable(pe_fd);
+		if (ret)
+			goto pe_close;
 
 		if (run_fill_buf(span, memflush, operation, true)) {
 			fprintf(stderr, "Error-running fill buffer\n");
@@ -171,8 +173,6 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
 		ret = perf_event_measure(pe_fd, &pe_read, param->filename, bm_pid);
 		if (ret)
 			goto pe_close;
-
-		close(pe_fd);
 	}
 
 	return ret;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 5626482b41cf..fe07b732cbd9 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -124,6 +124,7 @@ int get_core_sibling(int cpu_no);
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
 int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no);
+int perf_event_reset_enable(int pe_fd);
 int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
 		       const char *filename, int bm_pid);
 int measure_llc_resctrl(const char *filename, int bm_pid);
-- 
2.30.2

