Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C88786F52
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbjHXMmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbjHXMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:41:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9232170C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692880900; x=1724416900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mW1/XHCL8jo5nLcGLbs562k5Z2uxGCBaekuKIwJh7Cg=;
  b=OVPFwutXec1RDRIWEyu7pZgxY8wez7x7amG0jZywVxrQGu6wITexIq+j
   7T+GMMCRuWVgnJYurhkCT94TllMmrMnmjqqmHceH4GceAXua/VrMUati/
   DLDZPtU1uGoVrqSlozVyTDZ9IWG5v9r0cgQJ51BDtF5EDO9IoHwUYcRGh
   6rTZEsEj5q00uUpMeeFic3RUc4vztXKDzATzepiq1izxhAfXbAJDZagvY
   1DKQqRJvSahrl3j43ynjRShJdtc2Hms/E6NQ7T3UngA/hZG3Bk3onboh5
   Ava4SSqqY1PDbH/4P9JdnVsw6XJDxDoh7YT5FFA+sYuDQXeaiY5br5YSS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="460783945"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="460783945"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="740161418"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="740161418"
Received: from mdziurdx-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.11.127])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:41:39 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     linux-kernel@vger.kernel.org, reinette.chatre@intel.com,
        fenghua.yu@intel.com
Cc:     ilpo.jarvinen@linux.intel.com
Subject: [PATCH 2/3] selftests/resctrl: Move run_benchmark() to a more fitting file
Date:   Thu, 24 Aug 2023 14:41:25 +0200
Message-ID: <69a1ed7c06c3c34a2e39b50ffcceb9774967203a.1692880423.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resctrlfs.c file contains mostly functions that interact in some way
with resctrl FS entries while functions inside resctrl_val.c deal with
measurements and benchmarking

Run_benchmark() function is located in resctrlfs.c file even though it's
purpose is not interacting with the resctrl FS but to execute cache
checking logic

Move run_benchmark() to resctrl_val.c just before resctrl_val() function
that makes use of run_benchmark()

Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 52 +++++++++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 52 -------------------
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index f0f6c5f6e98b..667542c084eb 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -621,6 +621,58 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
 	return 0;
 }
 
+/*
+ * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
+ *		   in specified signal. Direct benchmark stdio to /dev/null.
+ * @signum:	signal number
+ * @info:	signal info
+ * @ucontext:	user context in signal handling
+ *
+ * Return: void
+ */
+void run_benchmark(int signum, siginfo_t *info, void *ucontext)
+{
+	int operation, ret, memflush;
+	char **benchmark_cmd;
+	size_t span;
+	bool once;
+	FILE *fp;
+
+	benchmark_cmd = info->si_ptr;
+
+	/*
+	 * Direct stdio of child to /dev/null, so that only parent writes to
+	 * stdio (console)
+	 */
+	fp = freopen("/dev/null", "w", stdout);
+	if (!fp)
+		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
+
+	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
+		/* Execute default fill_buf benchmark */
+		span = strtoul(benchmark_cmd[1], NULL, 10);
+		memflush =  atoi(benchmark_cmd[2]);
+		operation = atoi(benchmark_cmd[3]);
+		if (!strcmp(benchmark_cmd[4], "true"))
+			once = true;
+		else if (!strcmp(benchmark_cmd[4], "false"))
+			once = false;
+		else
+			PARENT_EXIT("Invalid once parameter");
+
+		if (run_fill_buf(span, memflush, operation, once))
+			fprintf(stderr, "Error in running fill buffer\n");
+	} else {
+		/* Execute specified benchmark */
+		ret = execvp(benchmark_cmd[0], benchmark_cmd);
+		if (ret)
+			perror("wrong\n");
+	}
+
+	fclose(stdout);
+	PARENT_EXIT("Unable to run specified benchmark");
+}
+
 /*
  * resctrl_val:	execute benchmark and measure memory bandwidth on
  *			the benchmark
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index a6d0b632cbc6..e3c94614c086 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -291,58 +291,6 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
 	return 0;
 }
 
-/*
- * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
- *		   in specified signal. Direct benchmark stdio to /dev/null.
- * @signum:	signal number
- * @info:	signal info
- * @ucontext:	user context in signal handling
- *
- * Return: void
- */
-void run_benchmark(int signum, siginfo_t *info, void *ucontext)
-{
-	int operation, ret, memflush;
-	char **benchmark_cmd;
-	size_t span;
-	bool once;
-	FILE *fp;
-
-	benchmark_cmd = info->si_ptr;
-
-	/*
-	 * Direct stdio of child to /dev/null, so that only parent writes to
-	 * stdio (console)
-	 */
-	fp = freopen("/dev/null", "w", stdout);
-	if (!fp)
-		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
-
-	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
-		/* Execute default fill_buf benchmark */
-		span = strtoul(benchmark_cmd[1], NULL, 10);
-		memflush =  atoi(benchmark_cmd[2]);
-		operation = atoi(benchmark_cmd[3]);
-		if (!strcmp(benchmark_cmd[4], "true"))
-			once = true;
-		else if (!strcmp(benchmark_cmd[4], "false"))
-			once = false;
-		else
-			PARENT_EXIT("Invalid once parameter");
-
-		if (run_fill_buf(span, memflush, operation, once))
-			fprintf(stderr, "Error in running fill buffer\n");
-	} else {
-		/* Execute specified benchmark */
-		ret = execvp(benchmark_cmd[0], benchmark_cmd);
-		if (ret)
-			perror("wrong\n");
-	}
-
-	fclose(stdout);
-	PARENT_EXIT("Unable to run specified benchmark");
-}
-
 /*
  * create_grp - Create a group only if one doesn't exist
  * @grp_name:	Name of the group
-- 
2.42.0

