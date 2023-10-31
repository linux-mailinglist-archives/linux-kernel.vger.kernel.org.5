Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA7C7DC7E7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjJaIKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjJaIKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:10:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF4A6;
        Tue, 31 Oct 2023 01:10:36 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SKN3z5SQxzvQFr;
        Tue, 31 Oct 2023 16:05:35 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 31 Oct 2023 16:10:34 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf debug: List available options when no variable is specified
Date:   Tue, 31 Oct 2023 08:08:23 +0000
Message-ID: <20231031080823.1418025-1-yangjihong1@huawei.com>
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

Minor help message improvement for `perf --debug`

Before:

  # perf --debug
  No variable specified for --debug.

   Usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

After:

  # perf --debug
  No variable specified for --debug, available options: verbose,ordered-events,stderr,data-convert,perf-event-open.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/perf.c       | 4 +++-
 tools/perf/util/debug.c | 3 +++
 tools/perf/util/debug.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index d3fc8090413c..0fc4719e6825 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -279,7 +279,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			exit(0);
 		} else if (!strcmp(cmd, "--debug")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No variable specified for --debug.\n");
+				fprintf(stderr,
+					"No variable specified for --debug, available options: %s.\n",
+					perf_debug_options_string);
 				usage(perf_usage_string);
 			}
 			if (perf_debug_option((*argv)[1]))
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 88378c4c5dd9..e02f6d97b826 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -215,6 +215,9 @@ void trace_event(union perf_event *event)
 		     trace_event_printer, event);
 }
 
+const char perf_debug_options_string[] =
+	"verbose,ordered-events,stderr,data-convert,perf-event-open";
+
 static struct sublevel_option debug_opts[] = {
 	{ .name = "verbose",		.value_ptr = &verbose },
 	{ .name = "ordered-events",	.value_ptr = &debug_ordered_events},
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index f99468a7f681..b9b4d17a1845 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -13,6 +13,7 @@ extern int debug_peo_args;
 extern bool quiet, dump_trace;
 extern int debug_ordered_events;
 extern int debug_data_convert;
+extern const char perf_debug_options_string[];
 
 #ifndef pr_fmt
 #define pr_fmt(fmt) fmt
-- 
2.34.1

