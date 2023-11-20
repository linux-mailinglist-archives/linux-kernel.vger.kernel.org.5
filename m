Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696EE7F1191
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjKTLP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjKTLPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:15:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4CB10E2;
        Mon, 20 Nov 2023 03:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478928; x=1732014928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsN9ZlaOmiphawewtImMFNwBEk6HXc44WNYdCCMUuoQ=;
  b=kmeEtYJIylD2hEbDiNKxEF5ikHWtT9KPKHE+jyM/OlH0VvgXlFKhDFce
   noOAou83/NeFodJZeZBArEfAYQpKPEBdCgCnKDV3Kcew1Y3XvOSnXxsho
   OBV6jSmJxT+u7JBRMj2j0fuBNBrW9uQWF0FOCzkL+pR/t03jNVIQWitwx
   FXtsvWH87twqv2opVWgChud3FY4cGLlJB1SfoykVLzvJXFHkDBCCaiSXp
   dDhre/HU2Iklt28IvjXR0mXJ2JKt8ueGZW8G8We8cRvOp5rP8hsXKddI6
   DmNZd0h/Lr9amx5TLhqlbqL4pXOqlJR9rvjq7iQAAzNTCc4qgS7gx7JOq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13151915"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="13151915"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:15:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="832238220"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="832238220"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:15:21 -0800
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
Subject: [PATCH v2 11/26] selftests/resctrl: Remove nested calls in perf event handling
Date:   Mon, 20 Nov 2023 13:13:25 +0200
Message-Id: <20231120111340.7805-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf event handling has functions that are the sole caller of another
perf event handling related function:
  - reset_enable_llc_perf() calls perf_event_open_llc_miss()
  - perf_event_measure() calls get_llc_perf()

Remove the extra layer of calls to make the code easier to follow by
moving the code into the calling function.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 65 ++++++-------------------
 1 file changed, 14 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 6a754ea376c9..aea4f54d32bd 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -29,24 +29,13 @@ static void initialize_perf_event_attr(void)
 	pea_llc_miss.disabled = 1;
 }
 
+/* Start counters to log values */
 static void ioctl_perf_event_ioc_reset_enable(void)
 {
 	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
 	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
 }
 
-static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
-{
-	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
-				PERF_FLAG_FD_CLOEXEC);
-	if (fd_lm == -1) {
-		perror("Error opening leader");
-		return -1;
-	}
-
-	return 0;
-}
-
 static void initialize_llc_perf(void)
 {
 	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
@@ -62,42 +51,13 @@ static void initialize_llc_perf(void)
 
 static int reset_enable_llc_perf(pid_t pid, int cpu_no)
 {
-	int ret = 0;
-
-	ret = perf_event_open_llc_miss(pid, cpu_no);
-	if (ret < 0)
-		return ret;
-
-	/* Start counters to log values */
-	ioctl_perf_event_ioc_reset_enable();
-
-	return 0;
-}
-
-/*
- * get_llc_perf:	llc cache miss through perf events
- * @llc_perf_miss:	LLC miss counter that is filled on success
- *
- * Perf events like HW_CACHE_MISSES could be used to validate number of
- * cache lines allocated.
- *
- * Return: =0 on success.  <0 on failure.
- */
-static int get_llc_perf(__u64 *llc_perf_miss)
-{
-	int ret;
-
-	/* Stop counters after one span to get miss rate */
-
-	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
-
-	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
-	if (ret == -1) {
-		perror("Could not get llc misses through perf");
+	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
+	if (fd_lm == -1) {
+		perror("Error opening leader");
 		return -1;
 	}
 
-	*llc_perf_miss = rf_cqm.values[0].value;
+	ioctl_perf_event_ioc_reset_enable();
 
 	return 0;
 }
@@ -178,15 +138,18 @@ static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value
  */
 static int perf_event_measure(const char *filename, int bm_pid)
 {
-	__u64 llc_perf_miss = 0;
 	int ret;
 
-	ret = get_llc_perf(&llc_perf_miss);
-	if (ret < 0)
-		return ret;
+	/* Stop counters after one span to get miss rate */
+	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
 
-	ret = print_results_cache(filename, bm_pid, llc_perf_miss);
-	return ret;
+	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
+	if (ret == -1) {
+		perror("Could not get perf value");
+		return -1;
+	}
+
+	return print_results_cache(filename, bm_pid, rf_cqm.values[0].value);
 }
 
 /*
-- 
2.30.2

