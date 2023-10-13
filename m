Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5767C7F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjJMIBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjJMIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:01:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D959C2;
        Fri, 13 Oct 2023 01:01:28 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S6JlP2TdXzVlWf;
        Fri, 13 Oct 2023 15:57:53 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 13 Oct 2023 16:01:25 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf data: Increase RLIMIT_NOFILE limit when open too many files in perf_data__create_dir()
Date:   Fri, 13 Oct 2023 07:59:45 +0000
Message-ID: <20231013075945.698874-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If using parallel threads to collect data, perf record needs at least 6 fds
per CPU. (one for sys_perf_event_open, four for pipe msg and ack of the
pipe, see record__thread_data_open_pipes(), and one for open perf.data.XXX)
For an environment with more than 100 cores, if perf record uses both
`-a` and `--threads` options, it is easy to exceed the upper limit of the
file descriptor number, when we run out of them try to increase the limits.

Before:
  $ ulimit -n
  1024
  $ lscpu | grep 'On-line CPU(s)'
  On-line CPU(s) list:                0-159
  $ perf record --threads -a sleep 1
  Failed to create data directory: Too many open files

After:
  $ ulimit -n
  1024
  $ lscpu | grep 'On-line CPU(s)'
  On-line CPU(s) list:                0-159
  $ perf record --threads -a sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.394 MB perf.data (1576 samples) ]
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/data.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index fc16299c915f..098f9e3bb2e7 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -17,6 +17,7 @@
 #include "util.h" // rm_rf_perf_data()
 #include "debug.h"
 #include "header.h"
+#include "evsel.h"
 #include <internal/lib.h>
 
 static void close_dir(struct perf_data_file *files, int nr)
@@ -35,6 +36,7 @@ void perf_data__close_dir(struct perf_data *data)
 
 int perf_data__create_dir(struct perf_data *data, int nr)
 {
+	enum rlimit_action set_rlimit = NO_CHANGE;
 	struct perf_data_file *files = NULL;
 	int i, ret;
 
@@ -54,11 +56,21 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 			goto out_err;
 		}
 
+retry_open:
 		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
 		if (ret < 0) {
+			/*
+			 * If using parallel threads to collect data,
+			 * perf record needs at least 6 fds per CPU.
+			 * When we run out of them try to increase the limits.
+			 */
+			if (errno == EMFILE && evsel__increase_rlimit(&set_rlimit))
+				goto retry_open;
+
 			ret = -errno;
 			goto out_err;
 		}
+		set_rlimit = NO_CHANGE;
 
 		file->fd = ret;
 	}
-- 
2.34.1

