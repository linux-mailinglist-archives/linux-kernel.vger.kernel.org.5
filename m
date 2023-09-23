Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31087ABF58
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjIWJcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjIWJcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:32:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EFA136;
        Sat, 23 Sep 2023 02:32:12 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rt3jB6BFHzMljc;
        Sat, 23 Sep 2023 17:28:30 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 23 Sep 2023 17:32:08 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 4/4] perf bench messaging: Kill child processes when exit abnormally in process mode
Date:   Sat, 23 Sep 2023 09:30:37 +0000
Message-ID: <20230923093037.961232-5-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923093037.961232-1-yangjihong1@huawei.com>
References: <20230923093037.961232-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When exit abnormally in process mode, customize SIGINT and SIGTERM signal
handler to kill the forked child processes.

Before:

  # perf bench sched messaging -l 1000000 -g 1 &
  [1] 8519
  # # Running 'sched/messaging' benchmark:

  # pgrep sched-messaging | wc -l
  41
  # kill -15 8519
  [1]+  Terminated              perf bench sched messaging -l 1000000 -g 1
  # pgrep sched-messaging | wc -l
  40

After:

  # perf bench sched messaging -l 1000000 -g 1 &
  [1] 8472
  # # Running 'sched/messaging' benchmark:

  # pgrep sched-messaging | wc -l
  41
  # kill -15 8472
  [1]+  Exit 1                  perf bench sched messaging -l 1000000 -g 1
  # pgrep sched-messaging | wc -l
  0

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/bench/sched-messaging.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 04ffaabdd45b..e2b8938b7dc3 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -36,6 +36,7 @@ static bool use_pipes = false;
 static unsigned int nr_loops = 100;
 static bool thread_mode = false;
 static unsigned int num_groups = 10;
+static unsigned int total_children = 0;
 static struct list_head sender_contexts = LIST_HEAD_INIT(sender_contexts);
 static struct list_head receiver_contexts = LIST_HEAD_INIT(receiver_contexts);
 
@@ -60,6 +61,8 @@ union messaging_worker {
 	pid_t pid;
 };
 
+static union messaging_worker *worker_tab;
+
 static void fdpair(int fds[2])
 {
 	if (use_pipes) {
@@ -260,6 +263,17 @@ static unsigned int group(union messaging_worker *worker,
 	return num_fds * 2;
 }
 
+static void sig_handler(int sig __maybe_unused)
+{
+	unsigned int i;
+
+	/*
+	 * When exit abnormally, kill all forked child processes.
+	 */
+	for (i = 0; i  < total_children; i++)
+		kill(worker_tab[i].pid, SIGKILL);
+}
+
 static const struct option options[] = {
 	OPT_BOOLEAN('p', "pipe", &use_pipes,
 		    "Use pipe() instead of socketpair()"),
@@ -277,12 +291,11 @@ static const char * const bench_sched_message_usage[] = {
 
 int bench_sched_messaging(int argc, const char **argv)
 {
-	unsigned int i, total_children;
+	unsigned int i;
 	struct timeval start, stop, diff;
 	unsigned int num_fds = 20;
 	int readyfds[2], wakefds[2];
 	char dummy;
-	union messaging_worker *worker_tab;
 	struct sender_context *pos, *n;
 
 	argc = parse_options(argc, argv, options,
@@ -295,7 +308,11 @@ int bench_sched_messaging(int argc, const char **argv)
 	fdpair(readyfds);
 	fdpair(wakefds);
 
-	total_children = 0;
+	if (!thread_mode) {
+		signal(SIGINT, sig_handler);
+		signal(SIGTERM, sig_handler);
+	}
+
 	for (i = 0; i < num_groups; i++)
 		total_children += group(worker_tab + total_children, num_fds,
 					readyfds[1], wakefds[0]);
-- 
2.34.1

