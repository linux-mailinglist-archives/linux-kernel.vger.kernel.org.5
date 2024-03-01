Return-Path: <linux-kernel+bounces-87839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5DB86D9CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732BE284E8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B60D405FE;
	Fri,  1 Mar 2024 02:33:25 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AE73FE23
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260405; cv=none; b=W8IrC0yTOwiXn8FjE/ATWp8s0HtY7Dq8+btb/oGKSUG4dtWaxWPUJLjAZNP4BD86N5JYk9sscqhOOwZ2vXPjgh6EN3NhHsWoIP+gYhzUZ1z7jYugYgTgomYsnL6rcrrsZFPik2oaOAkUvBeDBywerrqVO4Due9D4kr++FD3AZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260405; c=relaxed/simple;
	bh=iZ+aQa0XNT8LUz/3ls5SxUXbAIgi8tHpYdadT1LDUtU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qGqxUL4gFVHD6Tavdz+xsxdZlPFMcQhG1NZOahss6AXOeWHRMHPMCiIxPqtXv1tb/KJOOqCaho9dcq5xD7+gLCsi0vP1YeHuLEpLbPVnp1V7E93nr/tRwlPSDmBa/mNJPzIvUarKXTpdh7/ZfIvMfzWLbAkPQ4RGza9FqGG47uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TmBsk1yYCzvWCX;
	Fri,  1 Mar 2024 10:31:06 +0800 (CST)
Received: from canpemm500006.china.huawei.com (unknown [7.192.105.130])
	by mail.maildlp.com (Postfix) with ESMTPS id 06DCD140258;
	Fri,  1 Mar 2024 10:33:18 +0800 (CST)
Received: from huawei.com (10.67.174.116) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 1 Mar
 2024 10:33:17 +0800
From: Zheng Zucheng <zhengzucheng@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <wuyun.abel@bytedance.com>,
	<joshdon@google.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sched/fair: Fix task migrated to isolated cpus
Date: Fri, 1 Mar 2024 02:31:09 +0000
Message-ID: <20240301023109.336707-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)

On the wakeup path with hyperthreading, select cpu only looks at
task->cpus_ptr to see if the task can run on the target cpu. If isolcpus
kernel parameter is set, and isolated cpus will be part of mask
task->cpus_ptr, tasks were migrated to our isolated cpus.

Steps to reproduce on my 32-CPU hyperthreads machine:
1. with boot parameter: "isolcpus=0,1"
   (thread lists: 0,16 and 1,17)
2. cgcreate -g cpuset:test
   echo 0-31 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
   echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
   cgexec -g cpuset:test "test_threads"
3. some threads will be migrated to the isolated cpu0/1.

Fix it by checking the valid domain mask in select_idle_smt() and
select_idle_core()

Fixes: 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
Fixes: 3e6efe87cd5c ("sched/fair: Remove redundant check in select_idle_smt()")
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..e6552c77e0f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7289,7 +7289,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu = cpu;
 					break;
 				}
@@ -7297,7 +7297,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 
@@ -7311,12 +7311,12 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, int target)
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	int cpu;
 
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
-		if (cpu == target)
+		if (cpu == target || !cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
@@ -7341,7 +7341,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -7591,7 +7591,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, prev);
+			i = select_idle_smt(p, sd, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.34.1


