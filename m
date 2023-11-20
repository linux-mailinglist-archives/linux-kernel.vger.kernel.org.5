Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB11D7F1175
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjKTLO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjKTLOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:14:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4BEB;
        Mon, 20 Nov 2023 03:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478858; x=1732014858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oPd148SmWp/iUjrfvXH7JtKA59KsnXMqvq4QV8VYIOI=;
  b=Wj32LvqrBJItBLlrsMJSCegGaKe/SGOaCDm90XovIF24q5ehmCwJNLzj
   3nEQjBksuWRj670FcFDO0SBrWVc2+DkUfmYuOmAIkXI+37GavWnbZOHuS
   XYw9sR+b9UHUxUBknxO1nAC7aHG/5/+XZb27rQS31EmB2+F2pcFh+YH4t
   UdGac9C3Zf9UIBAkcmQ5rIbzeGQFz1NJgyF4yXPSaWbZZaAMZfQoVvRNS
   qeEgDhiaIi7J5zxKolAs84DG27B5bfan6/zF3kx+PFVuZD0ySZFYcnI9R
   HeeN72W3G4uH/V1jaSV3blIZooSE8HDQWDzCWJjMKV6ClYwhDKhZw9huN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="458095894"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="458095894"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="716179315"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="716179315"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:15 -0800
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
Subject: [PATCH v2 03/26] selftests/resctrl: Refactor fill_buf functions
Date:   Mon, 20 Nov 2023 13:13:17 +0200
Message-Id: <20231120111340.7805-4-ilpo.jarvinen@linux.intel.com>
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

There are unnecessary nested calls in fill_buf.c:
  - run_fill_buf() calls fill_cache()
  - alloc_buffer() calls malloc_and_init_memory()

Simplify the code flow and remove those unnecessary call levels by
moving the called code inside the calling function.

Resolve the difference in run_fill_buf() and fill_cache() parameter
name into 'buf_size' which is more descriptive than 'span'. Also, while
moving the allocation related code, rename 'p' into 'buf' to be
consistent in naming the variables.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 54 +++++++---------------
 tools/testing/selftests/resctrl/resctrl.h  |  2 +-
 2 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 6f32f44128e1..b9303a9d819b 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -51,29 +51,6 @@ static void mem_flush(unsigned char *buf, size_t buf_size)
 	sb();
 }
 
-static void *malloc_and_init_memory(size_t buf_size)
-{
-	void *p = NULL;
-	uint64_t *p64;
-	size_t s64;
-	int ret;
-
-	ret = posix_memalign(&p, PAGE_SIZE, buf_size);
-	if (ret < 0)
-		return NULL;
-
-	p64 = (uint64_t *)p;
-	s64 = buf_size / sizeof(uint64_t);
-
-	while (s64 > 0) {
-		*p64 = (uint64_t)rand();
-		p64 += (CL_SIZE / sizeof(uint64_t));
-		s64 -= (CL_SIZE / sizeof(uint64_t));
-	}
-
-	return p;
-}
-
 static int fill_one_span_read(unsigned char *buf, size_t buf_size)
 {
 	unsigned char *end_ptr = buf + buf_size;
@@ -137,12 +114,25 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
 
 static unsigned char *alloc_buffer(size_t buf_size, int memflush)
 {
-	unsigned char *buf;
+	void *buf = NULL;
+	uint64_t *p64;
+	size_t s64;
+	int ret;
 
-	buf = malloc_and_init_memory(buf_size);
-	if (!buf)
+	ret = posix_memalign(&buf, PAGE_SIZE, buf_size);
+	if (ret < 0)
 		return NULL;
 
+	/* Initialize the buffer */
+	p64 = buf;
+	s64 = buf_size / sizeof(uint64_t);
+
+	while (s64 > 0) {
+		*p64 = (uint64_t)rand();
+		p64 += (CL_SIZE / sizeof(uint64_t));
+		s64 -= (CL_SIZE / sizeof(uint64_t));
+	}
+
 	/* Flush the memory before using to avoid "cache hot pages" effect */
 	if (memflush)
 		mem_flush(buf, buf_size);
@@ -150,7 +140,7 @@ static unsigned char *alloc_buffer(size_t buf_size, int memflush)
 	return buf;
 }
 
-static int fill_cache(size_t buf_size, int memflush, int op, bool once)
+int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
 {
 	unsigned char *buf;
 	int ret;
@@ -164,16 +154,6 @@ static int fill_cache(size_t buf_size, int memflush, int op, bool once)
 	else
 		ret = fill_cache_write(buf, buf_size, once);
 	free(buf);
-
-	return ret;
-}
-
-int run_fill_buf(size_t span, int memflush, int op, bool once)
-{
-	size_t cache_size = span;
-	int ret;
-
-	ret = fill_cache(cache_size, memflush, op, once);
 	if (ret) {
 		printf("\n Error in fill cache\n");
 		return -1;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index a33f414f6019..08b95b5a4949 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -92,7 +92,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
-int run_fill_buf(size_t span, int memflush, int op, bool once);
+int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
 int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd);
 void tests_cleanup(void);
-- 
2.30.2

