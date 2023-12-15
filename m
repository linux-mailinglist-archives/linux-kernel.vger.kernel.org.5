Return-Path: <linux-kernel+bounces-449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F269814140
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341A21C22482
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE376AA1;
	Fri, 15 Dec 2023 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WU+T1tu/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196CD2F1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEMHGDf017757;
	Fri, 15 Dec 2023 05:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=h72oyP5lJ//K4Yj9ANH66sGP73x7RL+evPfbPvPqthA=;
 b=WU+T1tu/hHB6OHpftmeXrj14mynQBIJVzbjrdnZ+1nwXkhLemQNZGRXNGtNjYB9MJ+qO
 kGDhzGGtEFbjJ3g0neIEJjHitK+zthxGXXlGpexm/Y+uhOaIphRq4KEOJD6XrpXkfArH
 2zKyiDtqfvOVsxgjclsj34QMUUl+bjnNk968w/B2+sOoXEBUHj20ZsPIOjFWhN5Snxz0
 dUK1SONBEjHUTmDxIrrFKD8yrUMldTC996+6aKxyLXPcFlQ7kd1GmS1L/gt2BcCGmnss
 m//ZJWcnOx8mVPVpU1dQzn3pyp+H/XfFboiGVzcPNPMJ7a2mr62bNDGaAdEVhiU4OSIO Mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5ccj0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 05:27:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BF50dBQ003124;
	Fri, 15 Dec 2023 05:27:00 GMT
Received: from localhost.localdomain (dhcp-10-191-129-185.vpn.oracle.com [10.191.129.185])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvepb97sh-1;
	Fri, 15 Dec 2023 05:26:59 +0000
From: Imran Khan <imran.f.khan@oracle.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH] sched: fair: reset task_group.load_avg when there are no running tasks.
Date: Fri, 15 Dec 2023 16:26:52 +1100
Message-Id: <20231215052652.917741-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150032
X-Proofpoint-ORIG-GUID: 2U11f6X-cDCrE3XvQmDNvPKkE0VkUT55
X-Proofpoint-GUID: 2U11f6X-cDCrE3XvQmDNvPKkE0VkUT55

It has been found that sometimes a task_group has some residual
load_avg even though the load average at each of its owned queues
i.e task_group.cfs_rq[cpu].avg.load_avg and task_group.cfs_rq[cpu].
tg_load_avg_contrib have become 0 for a long time.
Under this scenario if another task starts running in this task_group,
it does not get proper time share on CPU since pre-existing
load average of task group inversely impacts the new task's CPU share
on each CPU.

This change looks for the condition when a task_group has no running
tasks and sets the task_group's load average to 0 in such cases, so
that tasks that run in future under this task_group get the CPU time
in accordance with the current load.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---

So far I have encountered only one way of reproducing this issue which is
as follows:

1. Take a kvm guest (booted with 4 CPUs and can be scaled up to 124 CPUs) and 
create 2 custom cgroups: /sys/fs/cgroup/cpu/test_group_1 and /sys/fs/cgroup/
cpu/test_group_2

2. Assign a CPU intensive workload to each of these cgroups and start the
workload.

For my tests I am using following app:

int main(int argc, char *argv[])
{
        unsigned long count, i, val;
        if (argc != 2) {
              printf("usage: ./a.out <number of random nums to generate> \n");
              return 0;
        }

        count = strtoul(argv[1], NULL, 10);

        printf("Generating %lu random numbers \n", count);
        for (i = 0; i < count; i++) {
                val = rand();
                val = val % 2;
                //usleep(1);
        }
        printf("Generated %lu random numbers \n", count);
        return 0;
}
Also since the system is booted with 4 CPUs, in order to completely load the
system I am also launching 4 instances of same test app under:
/sys/fs/cgroup/cpu/

3. We can see that both of the cgroups get similar CPU time:

# systemd-cgtop --depth 1
Path                                 Tasks    %CPU  Memory  Input/s    Output/s
/                                      659      -     5.5G        -        -
/system.slice                            -      -     5.7G        -        -
/test_group_1                            4      -        -        -        -
/test_group_2                            3      -        -        -        -
/user.slice                             31      -    56.5M        -        -

Path                                 Tasks   %CPU   Memory  Input/s    Output/s
/                                      659  394.6     5.5G        -        -
/test_group_2                            3   65.7        -        -        -
/user.slice                             29   55.1    48.0M        -        -
/test_group_1                            4   47.3        -        -        -
/system.slice                            -    2.2     5.7G        -        -

Path                                 Tasks  %CPU    Memory  Input/s    Output/s
/                                      659  394.8     5.5G        -        -
/test_group_1                            4   62.9        -        -        -
/user.slice                             28   44.9    54.2M        -        -
/test_group_2                            3   44.7        -        -        -
/system.slice                            -    0.9     5.7G        -        -

Path                                 Tasks  %CPU    Memory  Input/s     Output/s
/                                      659  394.4     5.5G        -        -
/test_group_2                            3   58.8        -        -        -
/test_group_1                            4   51.9        -        -        -
/user.slice                              30   39.3    59.6M        -        -
/system.slice                            -    1.9     5.7G        -        -

Path                                 Tasks  %CPU     Memory  Input/s    Output/s
/                                      659  394.7     5.5G        -        -
/test_group_1                            4   60.9        -        -        -
/test_group_2                            3   57.9        -        -        -
/user.slice                             28   43.5    36.9M        -        -
/system.slice                            -    3.0     5.7G        -        -

Path                                 Tasks  %CPU     Memory  Input/s     Output/s
/                                      659  395.0     5.5G        -        -
/test_group_1                            4   66.8        -        -        -
/test_group_2                            3   56.3        -        -        -
/user.slice                             29   43.1    51.8M        -        -
/system.slice                            -    0.7     5.7G        -        -

4. Now move systemd-udevd to one of these test groups, say test_group_1, and 
perform scale up to 124 CPUs followed by scale down back to 4 CPUs from the
host side.

5. Run the same workload i.e 4 instances of CPU hogger under /sys/fs/cgroup/cpu
and one instance of  CPU hogger each in /sys/fs/cgroup/cpu/test_group_1 and
/sys/fs/cgroup/test_group_2.
It is seen that test_group_1 (the one where systemd-udevd was moved) is getting
much less CPU than the test_group_2, even though at this point of time both of
these groups have only CPU hogger running.

#systemd-cgtop --depth 1
Path                                   Tasks   %CPU   Memory  Input/s   Output/s
/                                      1219     -     5.4G        -        -
/system.slice                           -       -     5.6G        -        -
/test_group_1                           4       -        -        -        -
/test_group_2                           3       -        -        -        -
/user.slice                            26       -    91.3M        -        -

Path                                   Tasks  %CPU     Memory  Input/s   Output/s
/                                      1221  394.3     5.4G        -        -
/test_group_2                             3   82.7        -        -        -
/test_group_1                             4   14.3        -        -        -
/system.slice                             -    0.8     5.6G        -        -
/user.slice                              26    0.4    91.2M        -        -

Path                                   Tasks  %CPU    Memory  Input/s    Output/s
/                                      1221  394.6     5.4G        -        -
/test_group_2                             3   67.4        -        -        -
/system.slice                             -   24.6     5.6G        -        -
/test_group_1                             4   12.5        -        -        -
/user.slice                              26    0.4    91.2M        -        -

Path                                  Tasks  %CPU    Memory  Input/s    Output/s
/                                     1221  395.2     5.4G        -        -
/test_group_2                            3   60.9        -        -        -
/system.slice                            -   27.9     5.6G        -        -
/test_group_1                            4   12.2        -        -        -
/user.slice                             26    0.4    91.2M        -        -

Path                                  Tasks  %CPU    Memory  Input/s    Output/s
/                                     1221  395.2     5.4G        -        -
/test_group_2                            3   69.4        -        -        -
/test_group_1                            4   13.9        -        -        -
/user.slice                             28    1.6    92.0M        -        -
/system.slice                            -    1.0     5.6G        -        -

Path                                  Tasks  %CPU    Memory  Input/s    Output/s
/                                      1221  395.6     5.4G        -        -
/test_group_2                             3   59.3        -        -        -
/test_group_1                             4   14.1        -        -        -
/user.slice                              28    1.3    92.2M        -        -
/system.slice                             -    0.7     5.6G        -        -

Path                                  Tasks  %CPU    Memory  Input/s    Output/s
/                                      1221  395.5     5.4G        -        -
/test_group_2                            3   67.2        -        -        -
/test_group_1                            4   11.5        -        -        -
/user.slice                             28    1.3    92.5M        -        -
/system.slice                            -    0.6     5.6G        -        -

Path                                  Tasks  %CPU    Memory  Input/s    Output/s
/                                      1221  395.1     5.4G        -        -
/test_group_2                             3   76.8        -        -        -
/test_group_1                             4   12.9        -        -        -
/user.slice                              28    1.3    92.8M        -        -
/system.slice                             -    1.2     5.6G        -        -

From sched_debug data it is seen that in bad case the load.weight of per-cpu
sched entities corresponding to test_group_1 has reduced significantly and
also load_avg of test_group_1 remains much higher than that of test_group_2,
even though systemd-udevd stopped running long time back and at this point of
time both cgroups just have the cpu hogger app as running entity. 

I put some traces in update_tg_load_avg to check why load_avg was much higher
for test_group_1 and from there, I saw that even after systemd-udevd has
stopped and we are yet to launch the CPU hoggers, test_group_1 has got some
load average like shown in following snippet (I have changed the format of 
trace to limit the number of columns here):

  <idle>-0   [000] d.s.  1824.372593: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664
  <idle>-0   [000] d.s.  1824.380572: update_tg_load_avg.constprop.124:
	 tg_path = /test_group_1 
  <idle>-0   [000] d.s.  1824.380573: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664
  <idle>-0   [000] d.s.  1824.384563: update_tg_load_avg.constprop.124:
	 tg_path = /test_group_1
  <idle>-0   [000] d.s.  1824.384563: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664
  <idle>-0   [000] d.s.  1824.391564: update_tg_load_avg.constprop.124:
	 tg_path = /test_group_1
  <idle>-0   [000] d.s.  1824.391564: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664
  <idle>-0   [000] d.s.  1824.398569: update_tg_load_avg.constprop.124:
	 tg_path = /test_group_1
  <idle>-0   [000] d.s.  1824.398569: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664
.....................
.....................
  xfsaild/dm-3-1623    [001] d... 1824.569615: update_tg_load_avg.constprop.124:
	 tg_path = /test_group_1
  xfsaild/dm-3-1623    [001] d... 1824.569617: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664
...................
...................
  sh-195050  [000] d.s.  1824.756563: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664
  <idle>-0   [000] d.s.  1824.757570: update_tg_load_avg.constprop.124:
	 tg_path = /test_group_1
  <idle>-0   [000] d.s.  1824.757571: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664
  <idle>-0   [000] d.s.  1824.761566: update_tg_load_avg.constprop.124:
	 tg_path = /test_group_1
  <idle>-0   [000] d.s.  1824.761566: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664
  <idle>-0   [000] d.s.  1824.765567: update_tg_load_avg.constprop.124:
	 tg_path = /test_group_1
  <idle>-0   [000] d.s.  1824.765568: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664
  <idle>-0   [000] d.s.  1824.769562: update_tg_load_avg.constprop.124:
	 tg_path = /test_group_1
  <idle>-0   [000] d.s.  1824.769563: update_tg_load_avg.constprop.124:
	 cfs_rq->avg.load_avg=0, cfs_rq->tg_load_avg_contrib=0 tg->load_avg=4664

Now when CPU hogger is launched again in test_group_1, this pre-existing
tg->load_avg gets added to load contribution of cpu hogger and results in a
situation where both cgroups are running the same work load but very different
task_group.load_avg which in turn results in these cgroups getting very
different amount of time on CPU.

Apologies for this long description of the issue, but I have found only one way
of reproducing this issue and using this way issue can be reproduced with 100%
strike rate, so I thought of providing as much info as possible.

I have kept the change as RFC as I was not sure if the load_avg should be
dragged down to 0 in one go (as being done in this change) or should it be
pulled back in steps like making it half of the previous value each time.


 kernel/sched/fair.c  | 17 +++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..c34d9e7abb96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3572,6 +3572,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 		account_numa_enqueue(rq, task_of(se));
 		list_add(&se->group_node, &rq->cfs_tasks);
+		atomic_long_inc(&task_group(task_of(se))->cfs_nr_running);
 	}
 #endif
 	cfs_rq->nr_running++;
@@ -3587,6 +3588,7 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	if (entity_is_task(se)) {
 		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
 		list_del_init(&se->group_node);
+		atomic_long_dec(&task_group(task_of(se))->cfs_nr_running);
 	}
 #endif
 	cfs_rq->nr_running--;
@@ -4104,6 +4106,20 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
 		return;
 
+	/*
+	 * If number of running tasks for a task_group is 0, pull back its
+	 * load_avg to 0 as well.
+	 * This avoids the situation where a freshly forked task in a cgroup,
+	 * with some residual load_avg but with no running tasks, gets less
+	 * CPU time because of pre-existing load_avg of task_group.
+	 */
+	if (!atomic_long_read(&cfs_rq->tg->cfs_nr_running)
+	    && atomic_long_read(&cfs_rq->tg->load_avg)) {
+		atomic_long_set(&cfs_rq->tg->load_avg, 0);
+		cfs_rq->last_update_tg_load_avg = now;
+		return;
+	}
+
 	delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
 	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
 		atomic_long_add(delta, &cfs_rq->tg->load_avg);
@@ -12808,6 +12824,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	atomic_long_set(&tg->cfs_nr_running, 0);
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg), tg_cfs_bandwidth(parent));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..c3390bdb8400 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -370,6 +370,7 @@ struct task_group {
 	 */
 	atomic_long_t		load_avg ____cacheline_aligned;
 #endif
+	atomic_long_t           cfs_nr_running ____cacheline_aligned;
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
-- 
2.34.1


