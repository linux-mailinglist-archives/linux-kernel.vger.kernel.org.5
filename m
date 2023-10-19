Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4B7CEE71
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjJSDg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjJSDg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:36:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9501D119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:36:22 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S9tbg6VQqz15NYC;
        Thu, 19 Oct 2023 11:33:35 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 11:36:19 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <tim.c.chen@linux.intel.com>,
        <yu.c.chen@intel.com>, <gautham.shenoy@amd.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <kprateek.nayak@amd.com>,
        <wuyun.abel@bytedance.com>
Subject: [PATCH v11 3/3] sched/fair: Use candidate prev/recent_used CPU if scanning failed for cluster wakeup
Date:   Thu, 19 Oct 2023 11:33:23 +0800
Message-ID: <20231019033323.54147-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231019033323.54147-1-yangyicong@huawei.com>
References: <20231019033323.54147-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Chen Yu reports a hackbench regression of cluster wakeup when
hackbench threads equal to the CPU number [1]. Analysis shows
it's because we wake up more on the target CPU even if the
prev_cpu is a good wakeup candidate and leads to the decrease
of the CPU utilization.

Generally if the task's prev_cpu is idle we'll wake up the task
on it without scanning. On cluster machines we'll try to wake up
the task in the same cluster of the target for better cache
affinity, so if the prev_cpu is idle but not sharing the same
cluster with the target we'll still try to find an idle CPU within
the cluster. This will improve the performance at low loads on
cluster machines. But in the issue above, if the prev_cpu is idle
but not in the cluster with the target CPU, we'll try to scan an
idle one in the cluster. But since the system is busy, we're
likely to fail the scanning and use target instead, even if
the prev_cpu is idle. Then leads to the regression.

This patch solves this in 2 steps:
o record the prev_cpu/recent_used_cpu if they're good wakeup
  candidates but not sharing the cluster with the target.
o on scanning failure use the prev_cpu/recent_used_cpu if
  they're recorded as idle

[1] https://lore.kernel.org/all/ZGzDLuVaHR1PAYDt@chenyu5-mobl1/

Reported-by: Chen Yu <yu.c.chen@intel.com>
Closes: https://lore.kernel.org/all/ZGsLy83wPIpamy6x@chenyu5-mobl1/
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 kernel/sched/fair.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02d842df5294..d508d1999ecc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7346,7 +7346,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	bool has_idle_core = false;
 	struct sched_domain *sd;
 	unsigned long task_util, util_min, util_max;
-	int i, recent_used_cpu;
+	int i, recent_used_cpu, prev_aff = -1;
 
 	/*
 	 * On asymmetric system, update task utilization because we will check
@@ -7379,6 +7379,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 		if (cpus_share_resources(prev, target))
 			return prev;
+
+		prev_aff = prev;
 	}
 
 	/*
@@ -7411,6 +7413,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 		if (cpus_share_resources(recent_used_cpu, target))
 			return recent_used_cpu;
+	} else {
+		recent_used_cpu = -1;
 	}
 
 	/*
@@ -7451,6 +7455,17 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	/*
+	 * For cluster machines which have lower sharing cache like L2 or
+	 * LLC Tag, we tend to find an idle CPU in the target's cluster
+	 * first. But prev_cpu or recent_used_cpu may also be a good candidate,
+	 * use them if possible when no idle CPU found in select_idle_cpu().
+	 */
+	if ((unsigned int)prev_aff < nr_cpumask_bits)
+		return prev_aff;
+	if ((unsigned int)recent_used_cpu < nr_cpumask_bits)
+		return recent_used_cpu;
+
 	return target;
 }
 
-- 
2.24.0

