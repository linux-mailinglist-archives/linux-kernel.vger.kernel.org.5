Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519487ABF56
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjIWJcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjIWJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:32:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBA9197;
        Sat, 23 Sep 2023 02:32:10 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rt3j02QvyzNngT;
        Sat, 23 Sep 2023 17:28:20 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 23 Sep 2023 17:32:07 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 2/4] perf bench messaging: Factor out create_worker()
Date:   Sat, 23 Sep 2023 09:30:35 +0000
Message-ID: <20230923093037.961232-3-yangjihong1@huawei.com>
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

Refactor the create_worker() helper:
1. Modify the return value and use pthread pointer as a parameter to
   facilitate value assignment in create_worker().
2. The thread worker creation and process worker creation are abstracted
   into independent helpers.

No functional change.

Test result:

  # perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 6.332 [sec]
  # perf bench sched messaging -t
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver threads per group
  # 10 groups == 400 threads run

       Total time: 5.545 [sec]

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/bench/sched-messaging.c | 50 ++++++++++++++++--------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 6a33118c8f9b..ad8596bed77a 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -139,30 +139,12 @@ static void *receiver(struct receiver_context* ctx)
 	return NULL;
 }
 
-static pthread_t create_worker(void *ctx, void *(*func)(void *))
+static void create_thread_worker(pthread_t *thread,
+				 void *ctx, void *(*func)(void *))
 {
 	pthread_attr_t attr;
-	pthread_t childid;
 	int ret;
 
-	if (!thread_mode) {
-		/* process mode */
-		/* Fork the receiver. */
-		switch (fork()) {
-		case -1:
-			err(EXIT_FAILURE, "fork()");
-			break;
-		case 0:
-			(*func) (ctx);
-			exit(0);
-			break;
-		default:
-			break;
-		}
-
-		return (pthread_t)0;
-	}
-
 	if (pthread_attr_init(&attr) != 0)
 		err(EXIT_FAILURE, "pthread_attr_init:");
 
@@ -171,12 +153,32 @@ static pthread_t create_worker(void *ctx, void *(*func)(void *))
 		err(EXIT_FAILURE, "pthread_attr_setstacksize");
 #endif
 
-	ret = pthread_create(&childid, &attr, func, ctx);
+	ret = pthread_create(thread, &attr, func, ctx);
 	if (ret != 0)
 		err(EXIT_FAILURE, "pthread_create failed");
 
 	pthread_attr_destroy(&attr);
-	return childid;
+}
+
+static void create_process_worker(void *ctx, void *(*func)(void *))
+{
+	/* Fork the receiver. */
+	pid_t pid = fork();
+
+	if (pid == -1) {
+		err(EXIT_FAILURE, "fork()");
+	} else if (pid == 0) {
+		(*func) (ctx);
+		exit(0);
+	}
+}
+
+static void create_worker(pthread_t *thread, void *ctx, void *(*func)(void *))
+{
+	if (!thread_mode)
+		return create_process_worker(ctx, func);
+	else
+		return create_thread_worker(thread, ctx, func);
 }
 
 static void reap_worker(pthread_t id)
@@ -226,7 +228,7 @@ static unsigned int group(pthread_t *pth,
 		ctx->ready_out = ready_out;
 		ctx->wakefd = wakefd;
 
-		pth[i] = create_worker(ctx, (void *)receiver);
+		create_worker(pth + i, ctx, (void *)receiver);
 
 		snd_ctx->out_fds[i] = fds[1];
 		if (!thread_mode)
@@ -239,7 +241,7 @@ static unsigned int group(pthread_t *pth,
 		snd_ctx->wakefd = wakefd;
 		snd_ctx->num_fds = num_fds;
 
-		pth[num_fds + i] = create_worker(snd_ctx, (void *)sender);
+		create_worker(pth + num_fds + i, snd_ctx, (void *)sender);
 	}
 
 	/* Close the fds we have left */
-- 
2.34.1

