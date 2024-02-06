Return-Path: <linux-kernel+bounces-54507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086784B013
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755151C24607
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE612D148;
	Tue,  6 Feb 2024 08:37:33 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F212BF0C;
	Tue,  6 Feb 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208652; cv=none; b=CopzsllwKlSbkOsfdW6fl02iQBkctbJBAkvOd/pjcQq/lKaolAHBeZzEMwjaDq9BJ+WR2bdu7hjbwhYGLRLCftbVnoB4xJYLXchNGyD2YLTeyGXl3ke+xNywaqMLc9mWRjgpyGVhvoW1uMcjgzzd8+vl0SW1wOxnetgD+nDlFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208652; c=relaxed/simple;
	bh=GD182B84c75sEn+FAFQpkVm/e1Dq6ZO4k6F2hsOQWsA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uVr9iLgNApiPzS3VJrtEzUeVSEE7gDI7UKOh1GVwuyNe9DWDEMzxjv3tze88HIJmYc/R8zygWsiwf3InbIkmK5d7RVYPIropSJiqCvZguEbjCb0x0Xj3pWNnMOT0euthgF0LGUmfzBLFjo248HfT6Kdy9w8b0DULI8E9eb7KR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TTc2B2BhDz1FK8K;
	Tue,  6 Feb 2024 16:32:50 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id BB2551A016B;
	Tue,  6 Feb 2024 16:37:25 +0800 (CST)
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
Subject: [PATCH v2 0/5] perf sched: Minor optimizations for resource initialization
Date: Tue, 6 Feb 2024 08:32:23 +0000
Message-ID: <20240206083228.172607-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
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

start_work_mutex, work_done_wait_mutex, curr_thread, curr_pid, and
cpu_last_switched are initialized together in cmd_sched(),
but for different perf sched subcommands, some actions are unnecessary,
especially perf sched record.
This series of patches initialize only required resources for different
subcommands.

Simple functional testing:

  # perf sched record perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.204 [sec]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 14.868 MB perf.data (133947 samples) ]

  # perf sched latency

   -------------------------------------------------------------------------------------------------------------------------------------------
    Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |
   -------------------------------------------------------------------------------------------------------------------------------------------
    qemu-system-x86:(3)   |      2.753 ms |       10 | avg:   0.963 ms | max:   8.526 ms | max start: 457541.695704 s | max end: 457541.704230 s
    sched-messaging:(401) |   2995.481 ms |    36312 | avg:   0.944 ms | max: 111.551 ms | max start: 457541.645349 s | max end: 457541.756900 s
    rcu_sched:14          |      0.402 ms |       32 | avg:   0.266 ms | max:   7.996 ms | max start: 457541.581363 s | max end: 457541.589359 s
    sshd:48125            |      0.461 ms |        2 | avg:   0.033 ms | max:   0.036 ms | max start: 457541.584374 s | max end: 457541.584410 s
    perf:112408           |      2.321 ms |        2 | avg:   0.031 ms | max:   0.032 ms | max start: 457541.846874 s | max end: 457541.846906 s
  <SNIP>
    ksoftirqd/1:22        |      0.704 ms |        3 | avg:   0.005 ms | max:   0.005 ms | max start: 457541.845388 s | max end: 457541.845393 s
    kworker/15:0-mm:61886 |      0.227 ms |       21 | avg:   0.005 ms | max:   0.006 ms | max start: 457541.739187 s | max end: 457541.739193 s
    kworker/13:1-ev:92643 |      0.249 ms |       22 | avg:   0.005 ms | max:   0.006 ms | max start: 457541.768695 s | max end: 457541.768701 s
    kworker/12:1-ev:61202 |      0.418 ms |       40 | avg:   0.005 ms | max:   0.007 ms | max start: 457541.739679 s | max end: 457541.739687 s
   -----------------------------------------------------------------------------------------------------------------
    TOTAL:                |   3007.424 ms |    36776 |
   ---------------------------------------------------

  # echo $?
  0

  # perf sched map
    *A0                                                               457541.580856 secs A0 => migration/0:15
    *.                                                                457541.580886 secs .  => swapper:0
     .  *B0                                                           457541.581018 secs B0 => migration/1:21
     .  *.                                                            457541.581050 secs
     .   .  *C0                                                       457541.581147 secs C0 => migration/2:27
     .   .  *.                                                        457541.581174 secs
     .   .   .  *D0                                                   457541.581259 secs D0 => migration/3:33
  <SNIP>
     E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7 *E7  .   .   .   .    457541.847783 secs
     E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7 *E7  .   .   .    457541.847873 secs
     E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7 *E7  .   .    457541.847954 secs
     E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7 *E7  .    457541.848034 secs
     E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7  E7 *E7   457541.848108 secs
  # echo $?
  0

  # perf sched replay
  run measurement overhead: 108 nsecs
  sleep measurement overhead: 65244 nsecs
  the run test took 1000002 nsecs
  the sleep test took 1079677 nsecs
  nr_run_events:        40700
  nr_sleep_events:      41415
  nr_wakeup_events:     31601
  target-less wakeups:  15
  multi-target wakeups: 805
  task      0 (             swapper:         0), nr_events: 7307
  task      1 (             swapper:         1), nr_events: 1
  task      2 (             swapper:         2), nr_events: 1
  <SNIP>
  task    713 (     sched-messaging:    112809), nr_events: 987
  task    714 (     sched-messaging:    112810), nr_events: 2706
  ------------------------------------------------------------
  #1  : 1298.443, ravg: 1298.44, cpu: 8281.74 / 8281.74
  #2  : 1316.426, ravg: 1300.24, cpu: 7577.61 / 8211.32
  #3  : 1323.864, ravg: 1302.60, cpu: 7932.48 / 8183.44
  #4  : 1329.423, ravg: 1305.29, cpu: 7646.17 / 8129.71
  #5  : 1321.419, ravg: 1306.90, cpu: 7669.90 / 8083.73
  #6  : 1322.082, ravg: 1308.42, cpu: 7755.66 / 8050.92
  #7  : 1324.330, ravg: 1310.01, cpu: 7361.51 / 7981.98
  #8  : 1312.489, ravg: 1310.26, cpu: 7170.11 / 7900.80
  #9  : 1312.002, ravg: 1310.43, cpu: 7176.40 / 7828.36
  #10 : 1311.737, ravg: 1310.56, cpu: 7121.14 / 7757.63
  # echo $?
  0

  # perf sched script
              perf  112408 [000] 457541.580826: sched:sched_stat_runtime: comm=perf pid=112408 runtime=53050 [ns] vruntime=621244222333 [ns]
              perf  112408 [000] 457541.580831:       sched:sched_waking: comm=migration/0 pid=15 prio=0 target_cpu=000
              perf  112408 [000] 457541.580853: sched:sched_stat_runtime: comm=perf pid=112408 runtime=24379 [ns] vruntime=621244246712 [ns]
              perf  112408 [000] 457541.580856:       sched:sched_switch: prev_comm=perf prev_pid=112408 prev_prio=120 prev_state=R+ ==> next_comm=migration/0 next_pid=15 next_prio=0
  <SNIP>
           swapper       0 [012] 457541.847873:       sched:sched_switch: prev_comm=swapper/12 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=112408 next_prio=120
           swapper       0 [013] 457541.847954:       sched:sched_switch: prev_comm=swapper/13 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=112408 next_prio=120
           swapper       0 [014] 457541.848034:       sched:sched_switch: prev_comm=swapper/14 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=112408 next_prio=120
           swapper       0 [015] 457541.848108:       sched:sched_switch: prev_comm=swapper/15 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=112408 next_prio=120
  # echo $?
  0

  # perf sched timehist
  Samples do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
    457541.580856 [0000]  perf[112408]                        0.000      0.000      0.000
    457541.580886 [0000]  migration/0[15]                     0.000      0.024      0.029
    457541.581018 [0001]  perf[112408]                        0.000      0.000      0.000
    457541.581050 [0001]  migration/1[21]                     0.000      0.006      0.032
    457541.581147 [0002]  perf[112408]                        0.000      0.000      0.000
    457541.581174 [0002]  migration/2[27]                     0.000      0.005      0.026
  <SNIP>
    457541.847623 [0009]  <idle>                              0.010      0.000      1.489
    457541.847704 [0010]  <idle>                              0.012      0.000      1.777
    457541.847783 [0011]  <idle>                              0.233      0.000      1.213
    457541.847873 [0012]  <idle>                              0.008      0.000     24.188
    457541.847954 [0013]  <idle>                              0.009      0.000      1.734
    457541.848034 [0014]  <idle>                              0.009      0.000      2.969
    457541.848108 [0015]  <idle>                              0.220      0.000      1.205
  # echo $?
  0

Changes since v1:
 - Change goto labels name to out_put_xxx in perf_sched__map().
 - Use zfree to replace free.
 - Add fixes tag and reviewed-by tag for Arnaldo.

Yang Jihong (5):
  perf sched: Move start_work_mutex and work_done_wait_mutex
    initialization to perf_sched__replay()
  perf sched: Fix memory leak in perf_sched__map()
  perf sched: Move curr_thread initialization to perf_sched__map()
  perf sched: Move curr_pid and cpu_last_switched initialization to
    perf_sched__{lat|map|replay}()
  perf thread_map: Free strlist on normal path in
    thread_map__new_by_tid_str()

 tools/perf/builtin-sched.c   | 163 ++++++++++++++++++++++-------------
 tools/perf/util/thread_map.c |   2 +-
 2 files changed, 105 insertions(+), 60 deletions(-)

-- 
2.34.1


