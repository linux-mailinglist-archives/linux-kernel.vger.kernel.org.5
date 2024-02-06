Return-Path: <linux-kernel+bounces-54505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0184B012
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C38284567
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5185512CDB5;
	Tue,  6 Feb 2024 08:37:33 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7B12BF0F;
	Tue,  6 Feb 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208652; cv=none; b=ZE3Ty9Py6tGF2SKR4dQGgI2hZzK/d/KkStcqCe15Bsg+UzpHPlbU+3WB+bKeHPJrR7wx545Ipwnm6ZfX683Yju1ZUUd91KqBEJqlWtTg/2honQtE7O+xaqcVaTHi7y3b5STT8fX0J0rJ/D2ngCmMDM/MAHSbRtw+wnEzH+JTd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208652; c=relaxed/simple;
	bh=zdWxmqTwFrfRIDgAj0sfZeAbu8v57sL5+EShC9x6of8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWWuRudfE0NHDPGUTvMq74ncv6LYCawIlvKt9BN6BMG1eGG/+Zfa4gLnrbJGWxWOX1sOxD7i79ZLfCy1ptApqjHaG7ESXq/Z0tZfDfnLuBcD5teWtkRATIPiVwa1hM4rKARZZ0IRZkyP4dya5mH+aIBXDa8z4g4qmNdz3vIrQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TTc6F23Nzz1xmt7;
	Tue,  6 Feb 2024 16:36:21 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C31F140382;
	Tue,  6 Feb 2024 16:37:27 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 16:37:27 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH v2 4/5] perf sched: Move curr_pid and cpu_last_switched initialization to perf_sched__{lat|map|replay}()
Date: Tue, 6 Feb 2024 08:32:27 +0000
Message-ID: <20240206083228.172607-5-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206083228.172607-1-yangjihong1@huawei.com>
References: <20240206083228.172607-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)

The curr_pid and cpu_last_switched are used only for the
'perf sched replay/latency/map'. Put their initialization in
perf_sched__{lat|map|replay () to reduce unnecessary actions in other
commands.

Simple functional testing:

  # perf sched record perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.209 [sec]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 16.456 MB perf.data (147907 samples) ]

  # perf sched lat

   -------------------------------------------------------------------------------------------------------------------------------------------
    Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |
   -------------------------------------------------------------------------------------------------------------------------------------------
    sched-messaging:(401) |   2990.699 ms |    38705 | avg:   0.661 ms | max:  67.046 ms | max start: 456532.624830 s | max end: 456532.691876 s
    qemu-system-x86:(7)   |    179.764 ms |     2191 | avg:   0.152 ms | max:  21.857 ms | max start: 456532.576434 s | max end: 456532.598291 s
    sshd:48125            |      0.522 ms |        2 | avg:   0.037 ms | max:   0.046 ms | max start: 456532.514610 s | max end: 456532.514656 s
  <SNIP>
    ksoftirqd/11:82       |      0.063 ms |        1 | avg:   0.005 ms | max:   0.005 ms | max start: 456532.769366 s | max end: 456532.769371 s
    kworker/9:0-mm_:34624 |      0.233 ms |       20 | avg:   0.004 ms | max:   0.007 ms | max start: 456532.690804 s | max end: 456532.690812 s
    migration/13:93       |      0.000 ms |        1 | avg:   0.004 ms | max:   0.004 ms | max start: 456532.512669 s | max end: 456532.512674 s
   -----------------------------------------------------------------------------------------------------------------
    TOTAL:                |   3180.750 ms |    41368 |
   ---------------------------------------------------

  # echo $?
  0

  # perf sched map
    *A0                                                               456532.510141 secs A0 => migration/0:15
    *.                                                                456532.510171 secs .  => swapper:0
     .  *B0                                                           456532.510261 secs B0 => migration/1:21
     .  *.                                                            456532.510279 secs
  <SNIP>
     L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7 *L7  .   .   .   .    456532.785979 secs
     L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7 *L7  .   .   .    456532.786054 secs
     L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7 *L7  .   .    456532.786127 secs
     L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7 *L7  .    456532.786197 secs
     L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7  L7 *L7   456532.786270 secs
  # echo $?
  0

  # perf sched replay
  run measurement overhead: 108 nsecs
  sleep measurement overhead: 66473 nsecs
  the run test took 1000002 nsecs
  the sleep test took 1082686 nsecs
  nr_run_events:        49334
  nr_sleep_events:      50054
  nr_wakeup_events:     34701
  target-less wakeups:  165
  multi-target wakeups: 766
  task      0 (             swapper:         0), nr_events: 15419
  task      1 (             swapper:         1), nr_events: 1
  task      2 (             swapper:         2), nr_events: 1
  <SNIP>
  task    715 (     sched-messaging:    110248), nr_events: 1438
  task    716 (     sched-messaging:    110249), nr_events: 512
  task    717 (     sched-messaging:    110250), nr_events: 500
  task    718 (     sched-messaging:    110251), nr_events: 537
  task    719 (     sched-messaging:    110252), nr_events: 823
  ------------------------------------------------------------
  #1  : 1325.288, ravg: 1325.29, cpu: 7823.35 / 7823.35
  #2  : 1363.606, ravg: 1329.12, cpu: 7655.53 / 7806.56
  #3  : 1349.494, ravg: 1331.16, cpu: 7544.80 / 7780.39
  #4  : 1311.488, ravg: 1329.19, cpu: 7495.13 / 7751.86
  #5  : 1309.902, ravg: 1327.26, cpu: 7266.65 / 7703.34
  #6  : 1309.535, ravg: 1325.49, cpu: 7843.86 / 7717.39
  #7  : 1316.482, ravg: 1324.59, cpu: 7854.41 / 7731.09
  #8  : 1366.604, ravg: 1328.79, cpu: 7955.81 / 7753.57
  #9  : 1326.286, ravg: 1328.54, cpu: 7466.86 / 7724.90
  #10 : 1356.653, ravg: 1331.35, cpu: 7566.60 / 7709.07
  # echo $?
  0

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-sched.c | 94 +++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 33 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b56a573ed06c..b248c433529a 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3167,14 +3167,44 @@ static void perf_sched__merge_lat(struct perf_sched *sched)
 	}
 }
 
+static int setup_cpus_switch_event(struct perf_sched *sched)
+{
+	unsigned int i;
+
+	sched->cpu_last_switched = calloc(MAX_CPUS, sizeof(*(sched->cpu_last_switched)));
+	if (!sched->cpu_last_switched)
+		return -1;
+
+	sched->curr_pid = malloc(MAX_CPUS * sizeof(*(sched->curr_pid)));
+	if (!sched->curr_pid) {
+		zfree(&sched->cpu_last_switched);
+		return -1;
+	}
+
+	for (i = 0; i < MAX_CPUS; i++)
+		sched->curr_pid[i] = -1;
+
+	return 0;
+}
+
+static void free_cpus_switch_event(struct perf_sched *sched)
+{
+	zfree(&sched->curr_pid);
+	zfree(&sched->cpu_last_switched);
+}
+
 static int perf_sched__lat(struct perf_sched *sched)
 {
+	int rc = -1;
 	struct rb_node *next;
 
 	setup_pager();
 
+	if (setup_cpus_switch_event(sched))
+		return rc;
+
 	if (perf_sched__read_events(sched))
-		return -1;
+		goto out_free_cpus_switch_event;
 
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
@@ -3203,7 +3233,11 @@ static int perf_sched__lat(struct perf_sched *sched)
 	print_bad_events(sched);
 	printf("\n");
 
-	return 0;
+	rc = 0;
+
+out_free_cpus_switch_event:
+	free_cpus_switch_event(sched);
+	return rc;
 }
 
 static int setup_map_cpus(struct perf_sched *sched)
@@ -3270,9 +3304,12 @@ static int perf_sched__map(struct perf_sched *sched)
 	if (!sched->curr_thread)
 		return rc;
 
-	if (setup_map_cpus(sched))
+	if (setup_cpus_switch_event(sched))
 		goto out_free_curr_thread;
 
+	if (setup_map_cpus(sched))
+		goto out_free_cpus_switch_event;
+
 	if (setup_color_pids(sched))
 		goto out_put_map_cpus;
 
@@ -3296,6 +3333,9 @@ static int perf_sched__map(struct perf_sched *sched)
 	zfree(&sched->map.comp_cpus);
 	perf_cpu_map__put(sched->map.cpus);
 
+out_free_cpus_switch_event:
+	free_cpus_switch_event(sched);
+
 out_free_curr_thread:
 	zfree(&sched->curr_thread);
 	return rc;
@@ -3309,6 +3349,10 @@ static int perf_sched__replay(struct perf_sched *sched)
 	mutex_init(&sched->start_work_mutex);
 	mutex_init(&sched->work_done_wait_mutex);
 
+	ret = setup_cpus_switch_event(sched);
+	if (ret)
+		goto out_mutex_destroy;
+
 	calibrate_run_measurement_overhead(sched);
 	calibrate_sleep_measurement_overhead(sched);
 
@@ -3316,7 +3360,7 @@ static int perf_sched__replay(struct perf_sched *sched)
 
 	ret = perf_sched__read_events(sched);
 	if (ret)
-		goto out_mutex_destroy;
+		goto out_free_cpus_switch_event;
 
 	printf("nr_run_events:        %ld\n", sched->nr_run_events);
 	printf("nr_sleep_events:      %ld\n", sched->nr_sleep_events);
@@ -3342,6 +3386,9 @@ static int perf_sched__replay(struct perf_sched *sched)
 	sched->thread_funcs_exit = true;
 	destroy_tasks(sched);
 
+out_free_cpus_switch_event:
+	free_cpus_switch_event(sched);
+
 out_mutex_destroy:
 	mutex_destroy(&sched->start_work_mutex);
 	mutex_destroy(&sched->work_done_wait_mutex);
@@ -3580,21 +3627,7 @@ int cmd_sched(int argc, const char **argv)
 		.switch_event	    = replay_switch_event,
 		.fork_event	    = replay_fork_event,
 	};
-	unsigned int i;
-	int ret = 0;
-
-	sched.cpu_last_switched = calloc(MAX_CPUS, sizeof(*sched.cpu_last_switched));
-	if (!sched.cpu_last_switched) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	sched.curr_pid = malloc(MAX_CPUS * sizeof(*sched.curr_pid));
-	if (!sched.curr_pid) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	for (i = 0; i < MAX_CPUS; i++)
-		sched.curr_pid[i] = -1;
+	int ret;
 
 	argc = parse_options_subcommand(argc, argv, sched_options, sched_subcommands,
 					sched_usage, PARSE_OPT_STOP_AT_NON_OPTION);
@@ -3605,9 +3638,9 @@ int cmd_sched(int argc, const char **argv)
 	 * Aliased to 'perf script' for now:
 	 */
 	if (!strcmp(argv[0], "script")) {
-		ret = cmd_script(argc, argv);
+		return cmd_script(argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
-		ret = __cmd_record(argc, argv);
+		return __cmd_record(argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
 		sched.tp_handler = &lat_ops;
 		if (argc > 1) {
@@ -3616,7 +3649,7 @@ int cmd_sched(int argc, const char **argv)
 				usage_with_options(latency_usage, latency_options);
 		}
 		setup_sorting(&sched, latency_options, latency_usage);
-		ret = perf_sched__lat(&sched);
+		return perf_sched__lat(&sched);
 	} else if (!strcmp(argv[0], "map")) {
 		if (argc) {
 			argc = parse_options(argc, argv, map_options, map_usage, 0);
@@ -3625,7 +3658,7 @@ int cmd_sched(int argc, const char **argv)
 		}
 		sched.tp_handler = &map_ops;
 		setup_sorting(&sched, latency_options, latency_usage);
-		ret = perf_sched__map(&sched);
+		return perf_sched__map(&sched);
 	} else if (strlen(argv[0]) > 2 && strstarts("replay", argv[0])) {
 		sched.tp_handler = &replay_ops;
 		if (argc) {
@@ -3633,7 +3666,7 @@ int cmd_sched(int argc, const char **argv)
 			if (argc)
 				usage_with_options(replay_usage, replay_options);
 		}
-		ret = perf_sched__replay(&sched);
+		return perf_sched__replay(&sched);
 	} else if (!strcmp(argv[0], "timehist")) {
 		if (argc) {
 			argc = parse_options(argc, argv, timehist_options,
@@ -3649,21 +3682,16 @@ int cmd_sched(int argc, const char **argv)
 				parse_options_usage(NULL, timehist_options, "w", true);
 			if (sched.show_next)
 				parse_options_usage(NULL, timehist_options, "n", true);
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 		ret = symbol__validate_sym_arguments();
 		if (ret)
-			goto out;
+			return ret;
 
-		ret = perf_sched__timehist(&sched);
+		return perf_sched__timehist(&sched);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
 
-out:
-	free(sched.curr_pid);
-	free(sched.cpu_last_switched);
-
-	return ret;
+	return 0;
 }
-- 
2.34.1


