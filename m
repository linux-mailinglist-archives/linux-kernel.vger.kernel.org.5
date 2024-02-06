Return-Path: <linux-kernel+bounces-54506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236DF84B011
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50756288B1C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50412C813;
	Tue,  6 Feb 2024 08:37:33 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362831A60;
	Tue,  6 Feb 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208652; cv=none; b=mcjaSYjlLiYnCD6LbC6dJeYKxdjoPTXwAZRn619ofQXGvNt4Rdr45tPg9RqvAdZoDi2/4glLgqA/Gt74OkUuk0WT+GH02/UUVQQCwOQF0YosGBMG3sTkT69LwpHWne1Q/Uc3dg6gOQ4XNkYaAfNAvHrgASSb5MIX2eJ8slRhcfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208652; c=relaxed/simple;
	bh=akxPEgyMnsMulfBbKHAmf+qbvnaNRYhrNfJ8MDEIybA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZ8OcjLKhPrQkoWFzgBsdcX01A1dNxF3Yxf2wtxwBVh9X67C5iRZdCeKc+pBvVut9Afa7aW8mIopYKW4DfSnLREErfniDK1FIwQHNBBiicquuVvN+fY+aGuU3nCRwffeZUxuoqbq+KOpCxY66y4NebB8XR0sevWKJDhwZKXSVls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TTc6x19cRzLnZ9;
	Tue,  6 Feb 2024 16:36:57 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 33EE11400DA;
	Tue,  6 Feb 2024 16:37:26 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 16:37:25 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH v2 1/5] perf sched: Move start_work_mutex and work_done_wait_mutex initialization to perf_sched__replay()
Date: Tue, 6 Feb 2024 08:32:24 +0000
Message-ID: <20240206083228.172607-2-yangjihong1@huawei.com>
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

The start_work_mutex and work_done_wait_mutex are used only for the
'perf sched replay'. Put their initialization in perf_sched__replay () to
reduce unnecessary actions in other commands.

Simple functional testing:

  # perf sched record perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.197 [sec]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 14.952 MB perf.data (134165 samples) ]

  # perf sched replay
  run measurement overhead: 108 nsecs
  sleep measurement overhead: 65658 nsecs
  the run test took 999991 nsecs
  the sleep test took 1079324 nsecs
  nr_run_events:        42378
  nr_sleep_events:      43102
  nr_wakeup_events:     31852
  target-less wakeups:  17
  multi-target wakeups: 712
  task      0 (             swapper:         0), nr_events: 10451
  task      1 (             swapper:         1), nr_events: 3
  task      2 (             swapper:         2), nr_events: 1
  <SNIP>
  task    717 (     sched-messaging:     74483), nr_events: 152
  task    718 (     sched-messaging:     74484), nr_events: 1944
  task    719 (     sched-messaging:     74485), nr_events: 73
  task    720 (     sched-messaging:     74486), nr_events: 163
  task    721 (     sched-messaging:     74487), nr_events: 942
  task    722 (     sched-messaging:     74488), nr_events: 78
  task    723 (     sched-messaging:     74489), nr_events: 1090
  ------------------------------------------------------------
  #1  : 1366.507, ravg: 1366.51, cpu: 7682.70 / 7682.70
  #2  : 1410.072, ravg: 1370.86, cpu: 7723.88 / 7686.82
  #3  : 1396.296, ravg: 1373.41, cpu: 7568.20 / 7674.96
  #4  : 1381.019, ravg: 1374.17, cpu: 7531.81 / 7660.64
  #5  : 1393.826, ravg: 1376.13, cpu: 7725.25 / 7667.11
  #6  : 1401.581, ravg: 1378.68, cpu: 7594.82 / 7659.88
  #7  : 1381.337, ravg: 1378.94, cpu: 7371.22 / 7631.01
  #8  : 1373.842, ravg: 1378.43, cpu: 7894.92 / 7657.40
  #9  : 1364.697, ravg: 1377.06, cpu: 7324.91 / 7624.15
  #10 : 1363.613, ravg: 1375.72, cpu: 7209.55 / 7582.69
  # echo $?
  0

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-sched.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 42d5fc5d6b7b..08dec557e6be 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3285,15 +3285,20 @@ static int perf_sched__map(struct perf_sched *sched)
 
 static int perf_sched__replay(struct perf_sched *sched)
 {
+	int ret;
 	unsigned long i;
 
+	mutex_init(&sched->start_work_mutex);
+	mutex_init(&sched->work_done_wait_mutex);
+
 	calibrate_run_measurement_overhead(sched);
 	calibrate_sleep_measurement_overhead(sched);
 
 	test_calibrations(sched);
 
-	if (perf_sched__read_events(sched))
-		return -1;
+	ret = perf_sched__read_events(sched);
+	if (ret)
+		goto out_mutex_destroy;
 
 	printf("nr_run_events:        %ld\n", sched->nr_run_events);
 	printf("nr_sleep_events:      %ld\n", sched->nr_sleep_events);
@@ -3318,7 +3323,11 @@ static int perf_sched__replay(struct perf_sched *sched)
 
 	sched->thread_funcs_exit = true;
 	destroy_tasks(sched);
-	return 0;
+
+out_mutex_destroy:
+	mutex_destroy(&sched->start_work_mutex);
+	mutex_destroy(&sched->work_done_wait_mutex);
+	return ret;
 }
 
 static void setup_sorting(struct perf_sched *sched, const struct option *options,
@@ -3556,8 +3565,6 @@ int cmd_sched(int argc, const char **argv)
 	unsigned int i;
 	int ret = 0;
 
-	mutex_init(&sched.start_work_mutex);
-	mutex_init(&sched.work_done_wait_mutex);
 	sched.curr_thread = calloc(MAX_CPUS, sizeof(*sched.curr_thread));
 	if (!sched.curr_thread) {
 		ret = -ENOMEM;
@@ -3645,8 +3652,6 @@ int cmd_sched(int argc, const char **argv)
 	free(sched.curr_pid);
 	free(sched.cpu_last_switched);
 	free(sched.curr_thread);
-	mutex_destroy(&sched.start_work_mutex);
-	mutex_destroy(&sched.work_done_wait_mutex);
 
 	return ret;
 }
-- 
2.34.1


