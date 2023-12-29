Return-Path: <linux-kernel+bounces-13078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 636AB81FF6D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F231F246EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6D6111A4;
	Fri, 29 Dec 2023 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2vnLVg+E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="az6qwdc1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D911194;
	Fri, 29 Dec 2023 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 Dec 2023 12:29:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703852950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7iw5J69JNIg0jg0PpftxKrv+J7HCN9qpztlt7NAF90=;
	b=2vnLVg+E0aUnFhPz8cd5BuiQVP5PKCqOpO24xeEU9Ee2UqTJRB73tqp4dYLAhgtFTe87tc
	fEXzHUTV40qHNSF2uQWCEZC5V6TjqS/wg6xEO51YO414ZYTq/Pg9t4ZV9tnN39RUXgHK4H
	H5FphMOhMMXEDRsb+Ab0jrAkiRRVR1jNtH5ZhKKWbg6QSKoS3HzS0GVTQkcxxizOX0RGHk
	afmkFWUq/bcVTNmPElzSPJLxAxHQ2Yi4N3l4qJJLL281QQJByvzAtJjAaUpPDc2n5p/Hyo
	KAXqbMdwlEPL+FhxKBEcRibqqemZHhMakeRsitHch/JM7zK853zr6T/aW/RCkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703852950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7iw5J69JNIg0jg0PpftxKrv+J7HCN9qpztlt7NAF90=;
	b=az6qwdc1PBuaL6C9YK5CLX8xPdWqfoszhQVJU0EeGKnWaDqeN6xQoM3MkFKEAA+tTomUBU
	bgctsRV5+pkArTAA==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix tg->load when offlining a CPU
Cc: Imran Khan <imran.f.khan@oracle.com>, Aaron Lu <aaron.lu@intel.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231223111545.62135-1-vincent.guittot@linaro.org>
References: <20231223111545.62135-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170385294882.398.15127942014439138238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     f60a631ab9ed5df15e446269ea515f2b8948ba0c
Gitweb:        https://git.kernel.org/tip/f60a631ab9ed5df15e446269ea515f2b8948ba0c
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 21 Dec 2023 17:40:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Dec 2023 13:22:03 +01:00

sched/fair: Fix tg->load when offlining a CPU

When a CPU is taken offline, the contribution of its cfs_rqs to task_groups'
load may remain and will negatively impact the calculation of the share of
the online CPUs.

To fix this bug, clear the contribution of an offlining CPU to task groups'
load and skip its contribution while it is inactive.

Here's the reproducer of the anomaly, by Imran Khan:

	"So far I have encountered only one rather lengthy way of reproducing this issue,
	which is as follows:

	1. Take a KVM guest (booted with 4 CPUs and can be scaled up to 124 CPUs) and
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

	It can be seen that test_group_1 (the one where systemd-udevd was moved) is getting
	much less CPU time than the test_group_2, even though at this point of time both of
	these groups have only CPU hogger running:

        # systemd-cgtop --depth 1
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

	From sched_debug data it can be seen that in bad case the load.weight of per-CPU
	sched entities corresponding to test_group_1 has reduced significantly and
	also load_avg of test_group_1 remains much higher than that of test_group_2,
	even though systemd-udevd stopped running long time back and at this point of
	time both cgroups just have the CPU hogger app as running entity."

[ mingo: Added details from the original discussion, plus minor edits to the patch. ]

Reported-by: Imran Khan <imran.f.khan@oracle.com>
Tested-by: Imran Khan <imran.f.khan@oracle.com>
Tested-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Imran Khan <imran.f.khan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lore.kernel.org/r/20231223111545.62135-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 52 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63..43c1216 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4096,6 +4096,10 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	if (cfs_rq->tg == &root_task_group)
 		return;
 
+	/* rq has been offline and doesn't contribute to the share anymore: */
+	if (!cpu_active(cpu_of(rq_of(cfs_rq))))
+		return;
+
 	/*
 	 * For migration heavy workloads, access to tg->load_avg can be
 	 * unbound. Limit the update rate to at most once per ms.
@@ -4112,6 +4116,49 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	}
 }
 
+static inline void clear_tg_load_avg(struct cfs_rq *cfs_rq)
+{
+	long delta;
+	u64 now;
+
+	/*
+	 * No need to update load_avg for root_task_group, as it is not used.
+	 */
+	if (cfs_rq->tg == &root_task_group)
+		return;
+
+	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
+	delta = 0 - cfs_rq->tg_load_avg_contrib;
+	atomic_long_add(delta, &cfs_rq->tg->load_avg);
+	cfs_rq->tg_load_avg_contrib = 0;
+	cfs_rq->last_update_tg_load_avg = now;
+}
+
+/* CPU offline callback: */
+static void __maybe_unused clear_tg_offline_cfs_rqs(struct rq *rq)
+{
+	struct task_group *tg;
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * The rq clock has already been updated in
+	 * set_rq_offline(), so we should skip updating
+	 * the rq clock again in unthrottle_cfs_rq().
+	 */
+	rq_clock_start_loop_update(rq);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(tg, &task_groups, list) {
+		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+
+		clear_tg_load_avg(cfs_rq);
+	}
+	rcu_read_unlock();
+
+	rq_clock_stop_loop_update(rq);
+}
+
 /*
  * Called within set_task_rq() right before setting a task's CPU. The
  * caller only guarantees p->pi_lock is held; no other assumptions,
@@ -4408,6 +4455,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
 
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
 
+static inline void clear_tg_offline_cfs_rqs(struct rq *rq) {}
+
 static inline int propagate_entity_load_avg(struct sched_entity *se)
 {
 	return 0;
@@ -12413,6 +12462,9 @@ static void rq_offline_fair(struct rq *rq)
 
 	/* Ensure any throttled groups are reachable by pick_next_task */
 	unthrottle_offline_cfs_rqs(rq);
+
+	/* Ensure that we remove rq contribution to group share: */
+	clear_tg_offline_cfs_rqs(rq);
 }
 
 #endif /* CONFIG_SMP */

