Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23E7DCB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjJaK5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:57:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EBE83;
        Tue, 31 Oct 2023 03:57:37 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SKRpy59WRz1P7f8;
        Tue, 31 Oct 2023 18:54:34 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 31 Oct 2023 18:57:34 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf tools: Add --debug-file option to redirect debug output
Date:   Tue, 31 Oct 2023 10:55:23 +0000
Message-ID: <20231031105523.1472558-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, debug messages is output to stderr, add --debug-file option to
support redirection to a specified file.

Some test scenarios:

  # perf --list-opts
  --help --version --exec-path --html-path --paginate --no-pager --debugfs-dir --buildid-dir --list-cmds --list-opts --debug --debug-file

  # perf --debug-file
  No path given for --debug-file.

   Usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

  # perf --debug-file /sys/perf.log record -v true
  Open debug file '/sys/perf.log' failed: Permission denied

   Usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

  # perf --debug-file /tmp/perf.log record -v true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.013 MB perf.data (26 samples) ]
  # cat /tmp/perf.log
  DEBUGINFOD_URLS=
  Using CPUID GenuineIntel-6-3E-4
  nr_cblocks: 0
  affinity: SYS
  mmap flush: 1
  comp level: 0
  mmap size 528384B
  Control descriptor is not initialized
  mmap size 528384B
  Looking at the vmlinux_path (8 entries long)
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
  symbol:unmap_start file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:unmap_complete file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:map_start file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:map_complete file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:reloc_start file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:reloc_complete file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:init_start file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:init_complete file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:lll_lock_wait_private file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:lll_lock_wait file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:setjmp file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:longjmp file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:longjmp_target file:(null) line:0 offset:0 return:0 lazy:(null)
  failed to write feature HYBRID_TOPOLOGY

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/Documentation/perf.txt |  3 +++
 tools/perf/perf.c                 | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index ba3df49c169d..a7cf7bc2f968 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -64,6 +64,9 @@ OPTIONS
           perf-event-open  - Print perf_event_open() arguments and
                              return value
 
+--debug-file::
+	Write debug output to a specified file.
+
 DESCRIPTION
 -----------
 Performance counters for Linux are a new kernel-based subsystem
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index d3fc8090413c..921bee0a6437 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -39,6 +39,7 @@
 #include <linux/zalloc.h>
 
 static int use_pager = -1;
+static FILE *debug_fp = NULL;
 
 struct cmd_struct {
 	const char *cmd;
@@ -162,6 +163,19 @@ static void commit_pager_choice(void)
 	}
 }
 
+static int set_debug_file(const char *path)
+{
+	debug_fp = fopen(path, "w");
+	if (!debug_fp) {
+		fprintf(stderr, "Open debug file '%s' failed: %s\n",
+			path, strerror(errno));
+		return -1;
+	}
+
+	debug_set_file(debug_fp);
+	return 0;
+}
+
 struct option options[] = {
 	OPT_ARGUMENT("help", "help"),
 	OPT_ARGUMENT("version", "version"),
@@ -174,6 +188,7 @@ struct option options[] = {
 	OPT_ARGUMENT("list-cmds", "list-cmds"),
 	OPT_ARGUMENT("list-opts", "list-opts"),
 	OPT_ARGUMENT("debug", "debug"),
+	OPT_ARGUMENT("debug-file", "debug-file"),
 	OPT_END()
 };
 
@@ -287,6 +302,18 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 
 			(*argv)++;
 			(*argc)--;
+		} else if (!strcmp(cmd, "--debug-file")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No path given for --debug-file.\n");
+				usage(perf_usage_string);
+			}
+
+			if (set_debug_file((*argv)[1]))
+				usage(perf_usage_string);
+
+			(*argv)++;
+			(*argc)--;
+
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(perf_usage_string);
@@ -547,5 +574,8 @@ int main(int argc, const char **argv)
 	fprintf(stderr, "Failed to run command '%s': %s\n",
 		cmd, str_error_r(errno, sbuf, sizeof(sbuf)));
 out:
+	if (debug_fp)
+		fclose(debug_fp);
+
 	return 1;
 }
-- 
2.34.1

