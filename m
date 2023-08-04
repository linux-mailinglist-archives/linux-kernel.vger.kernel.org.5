Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662E476FCF3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjHDJNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjHDJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:12:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B035246
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691140163; x=1722676163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I3ZENAHe7Oen+mjPad36DJ7HKb4Se9mPnDSl4djH1Bk=;
  b=WF/rVAsgKSYr3tEoEwudBnugscD21cwYOp6gfCyz8tf+1ARMz6q15ny3
   MqmPUC8MXTAgvruMq39C2dCDTKhrmhh6AlFkSUeVeV9gQYwLSldtz4l3y
   Np5mZ3IZc2qJmFaSwCLcQOX+li96ZCE33CQapI44YKks7NC0HBL5lCkvH
   yvDRHp9VVKpcd6LopJ74C14EpLpxTj8IBB/oFZQipbVm+HpDXeL3OUF5B
   F9GHRsMhrJfUzTQw/nOV0Xy1GwtHZ3NPk6eoQAFesfu8uZ/FPMU/TkmDE
   JG1z4rPjCi2sN/KyjuW7WhkEJ5N1zq9P3ZATxQwKB92U9bb/OxsUHdW//
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="360164068"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="360164068"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 02:09:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="795332566"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="795332566"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.118])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 02:09:20 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        srinivas.pandruvada@intel.com
Subject: [PATCH] sched/fair: Skip cpus with no sched domain attached during NOHZ idle balance
Date:   Fri,  4 Aug 2023 17:08:58 +0800
Message-Id: <20230804090858.7605-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem statement
-----------------
When using cgroup isolated partition to isolate cpus including cpu0, it
is observed that cpu0 is woken up frequenctly but doing nothing. This is
not good for power efficiency.

<idle>-0     [000]   616.491602: hrtimer_cancel:       hrtimer=0xffff8e8fdf623c10
<idle>-0     [000]   616.491608: hrtimer_start:        hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0 expires=615996000000 softexpires=615996000000
<idle>-0     [000]   616.491616: rcu_utilization:      Start context switch
<idle>-0     [000]   616.491618: rcu_utilization:      End context switch
<idle>-0     [000]   616.491637: tick_stop:            success=1 dependency=NONE
<idle>-0     [000]   616.491637: hrtimer_cancel:       hrtimer=0xffff8e8fdf623c10
<idle>-0     [000]   616.491638: hrtimer_start:        hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0 expires=616420000000 softexpires=616420000000

The above pattern repeats every one or multiple ticks, results in total
2000+ wakeups on cpu0 in 60 seconds, when running workload on the
cpus that are not in the isolated partition.

Rootcause
---------
In NOHZ mode, an active cpu either sends an IPI or touches the idle
cpu's polling flag to wake it up, so that the idle cpu can pull tasks
from the busy cpu. The logic for selecting the target cpu is to use the
first idle cpu that presents in both nohz.idle_cpus_mask and
housekeeping_cpumask.

In the above scenario, when cpu0 is in the cgroup isolated partition,
its sched domain is deteched, but it is still available in both of the
above cpumasks. As a result, cpu0
1. is always selected when kicking idle load balance
2. is woken up from the idle loop
3. calls __schedule() but cannot find any task to pull because it is not
   in any sched_domain, thus it does nothing and reenters idle.

Solution
--------
Fix the problem by skipping cpus with no sched domain attached during
NOHZ idle balance.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3e25be58e2b..ea3185a46962 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11340,6 +11340,9 @@ static inline int find_new_ilb(void)
 		if (ilb == smp_processor_id())
 			continue;
 
+		if (unlikely(on_null_domain(cpu_rq(ilb))))
+			continue;
+
 		if (idle_cpu(ilb))
 			return ilb;
 	}
-- 
2.34.1

