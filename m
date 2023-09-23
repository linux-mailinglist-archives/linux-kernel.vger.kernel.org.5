Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F457ABF57
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjIWJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjIWJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:32:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81F219E;
        Sat, 23 Sep 2023 02:32:10 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rt3kt6Xkfz15NKS;
        Sat, 23 Sep 2023 17:29:58 +0800 (CST)
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
Subject: [PATCH 3/4] perf bench messaging: Store chlid process pid when creating worker for process mode
Date:   Sat, 23 Sep 2023 09:30:36 +0000
Message-ID: <20230923093037.961232-4-yangjihong1@huawei.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To save pid of child processes when creating worker:
1. The messaging worker is changed to `union` type to store thread id and
   process pid.
2. Save child process pid in create_process_worker().
3. Rename `pth_tab` as `work_tab`.

Test result:

  # perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 6.744 [sec]
  # perf bench sched messaging -t
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver threads per group
  # 10 groups == 400 threads run

       Total time: 5.788 [sec]

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/bench/sched-messaging.c | 47 +++++++++++++++++-------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index ad8596bed77a..04ffaabdd45b 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -55,6 +55,11 @@ struct receiver_context {
 	int wakefd;
 };
 
+union messaging_worker {
+	pthread_t thread;
+	pid_t pid;
+};
+
 static void fdpair(int fds[2])
 {
 	if (use_pipes) {
@@ -139,7 +144,7 @@ static void *receiver(struct receiver_context* ctx)
 	return NULL;
 }
 
-static void create_thread_worker(pthread_t *thread,
+static void create_thread_worker(union messaging_worker *worker,
 				 void *ctx, void *(*func)(void *))
 {
 	pthread_attr_t attr;
@@ -153,35 +158,37 @@ static void create_thread_worker(pthread_t *thread,
 		err(EXIT_FAILURE, "pthread_attr_setstacksize");
 #endif
 
-	ret = pthread_create(thread, &attr, func, ctx);
+	ret = pthread_create(&worker->thread, &attr, func, ctx);
 	if (ret != 0)
 		err(EXIT_FAILURE, "pthread_create failed");
 
 	pthread_attr_destroy(&attr);
 }
 
-static void create_process_worker(void *ctx, void *(*func)(void *))
+static void create_process_worker(union messaging_worker *worker,
+				  void *ctx, void *(*func)(void *))
 {
 	/* Fork the receiver. */
-	pid_t pid = fork();
+	worker->pid = fork();
 
-	if (pid == -1) {
+	if (worker->pid == -1) {
 		err(EXIT_FAILURE, "fork()");
-	} else if (pid == 0) {
+	} else if (worker->pid == 0) {
 		(*func) (ctx);
 		exit(0);
 	}
 }
 
-static void create_worker(pthread_t *thread, void *ctx, void *(*func)(void *))
+static void create_worker(union messaging_worker *worker,
+			  void *ctx, void *(*func)(void *))
 {
 	if (!thread_mode)
-		return create_process_worker(ctx, func);
+		return create_process_worker(worker, ctx, func);
 	else
-		return create_thread_worker(thread, ctx, func);
+		return create_thread_worker(worker, ctx, func);
 }
 
-static void reap_worker(pthread_t id)
+static void reap_worker(union messaging_worker *worker)
 {
 	int proc_status;
 	void *thread_status;
@@ -192,12 +199,12 @@ static void reap_worker(pthread_t id)
 		if (!WIFEXITED(proc_status))
 			exit(1);
 	} else {
-		pthread_join(id, &thread_status);
+		pthread_join(worker->thread, &thread_status);
 	}
 }
 
 /* One group of senders and receivers */
-static unsigned int group(pthread_t *pth,
+static unsigned int group(union messaging_worker *worker,
 		unsigned int num_fds,
 		int ready_out,
 		int wakefd)
@@ -228,7 +235,7 @@ static unsigned int group(pthread_t *pth,
 		ctx->ready_out = ready_out;
 		ctx->wakefd = wakefd;
 
-		create_worker(pth + i, ctx, (void *)receiver);
+		create_worker(worker + i, ctx, (void *)receiver);
 
 		snd_ctx->out_fds[i] = fds[1];
 		if (!thread_mode)
@@ -241,7 +248,7 @@ static unsigned int group(pthread_t *pth,
 		snd_ctx->wakefd = wakefd;
 		snd_ctx->num_fds = num_fds;
 
-		create_worker(pth + num_fds + i, snd_ctx, (void *)sender);
+		create_worker(worker + num_fds + i, snd_ctx, (void *)sender);
 	}
 
 	/* Close the fds we have left */
@@ -275,14 +282,14 @@ int bench_sched_messaging(int argc, const char **argv)
 	unsigned int num_fds = 20;
 	int readyfds[2], wakefds[2];
 	char dummy;
-	pthread_t *pth_tab;
+	union messaging_worker *worker_tab;
 	struct sender_context *pos, *n;
 
 	argc = parse_options(argc, argv, options,
 			     bench_sched_message_usage, 0);
 
-	pth_tab = malloc(num_fds * 2 * num_groups * sizeof(pthread_t));
-	if (!pth_tab)
+	worker_tab = malloc(num_fds * 2 * num_groups * sizeof(union messaging_worker));
+	if (!worker_tab)
 		err(EXIT_FAILURE, "main:malloc()");
 
 	fdpair(readyfds);
@@ -290,7 +297,7 @@ int bench_sched_messaging(int argc, const char **argv)
 
 	total_children = 0;
 	for (i = 0; i < num_groups; i++)
-		total_children += group(pth_tab + total_children, num_fds,
+		total_children += group(worker_tab + total_children, num_fds,
 					readyfds[1], wakefds[0]);
 
 	/* Wait for everyone to be ready */
@@ -306,7 +313,7 @@ int bench_sched_messaging(int argc, const char **argv)
 
 	/* Reap them all */
 	for (i = 0; i < total_children; i++)
-		reap_worker(pth_tab[i]);
+		reap_worker(worker_tab + i);
 
 	gettimeofday(&stop, NULL);
 
@@ -334,7 +341,7 @@ int bench_sched_messaging(int argc, const char **argv)
 		break;
 	}
 
-	free(pth_tab);
+	free(worker_tab);
 	list_for_each_entry_safe(pos, n, &sender_contexts, list) {
 		list_del_init(&pos->list);
 		free(pos);
-- 
2.34.1

