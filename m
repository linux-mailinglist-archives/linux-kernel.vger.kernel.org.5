Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE147CBE9D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjJQJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjJQJKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:10:21 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7DF5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:10:03 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S8p8m5kccz8Xrdy;
        Tue, 17 Oct 2023 17:10:00 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 39H99oNn026671;
        Tue, 17 Oct 2023 17:09:50 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 17 Oct 2023 17:09:53 +0800 (CST)
Date:   Tue, 17 Oct 2023 17:09:53 +0800 (CST)
X-Zmail-TransId: 2b03652e4f616c5-5a37d
X-Mailer: Zmail v1.0
Message-ID: <202310171709530660462@zte.com.cn>
In-Reply-To: <87lec9l3mi.ffs@tglx>
References: 202309161037416349176@zte.com.cn,87lec9l3mi.ffs@tglx
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <tglx@linutronix.de>
Cc:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <jiang.xuexin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIFYyXSBjcHUvaG90cGx1ZzogZG9udCBvZmZsaW5lIHRoZSBsYXN0IG5vbi1pc29sYXRlZCBDUFU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 39H99oNn026671
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 652E4F68.001/4S8p8m5kccz8Xrdy
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

If system has some isolate cpus with "isolcpus=" parameter,
and user try to offline all the non-isolated CPUs, kernel will
first report a warning and then panic when taking the last
non-isolated CPU offline.

When offline the last non-isolate cpu,
cpuset_hotplug_workfn()
  rebuild_sched_domains_locked()
    ndoms = generate_sched_domains(&doms, &attr);
      cpumask_and(doms[0], top_cpuset.effective_cpus,
                  housekeeping_cpumask(HK_FLAG_DOMAIN));

As isolated cpus are excluded, "doms" passes to partition_sched_domains_locked()
will be an empty cpumask.

WARNING: CPU: 4 PID: 80 at kernel/sched/topology.c:2366 build_sched_domains+0x120c/0x1408
Call trace:
 build_sched_domains+0x120c/0x1408
 partition_sched_domains_locked+0x234/0x880
 rebuild_sched_domains_locked+0x37c/0x798
 rebuild_sched_domains+0x30/0x58
 cpuset_hotplug_workfn+0x2a8/0x930
 process_scheduled_works+0x178/0x3e0
 worker_thread+0x174/0x2f0
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address fffe80027ab37080
 partition_sched_domains_locked+0x318/0x880
 rebuild_sched_domains_locked+0x37c/0x798
 rebuild_sched_domains+0x30/0x58
 cpuset_hotplug_workfn+0x2a8/0x930
 process_scheduled_works+0x178/0x3e0
 worker_thread+0x174/0x2f0
 kthread+0x10c/0x128
 ret_from_fork+0x10/0x20
Code: 1a850042 b9441883 f862dae0 8b000021 (f945003b)

Kernel should not panic when user managing CPUs with this
meaningless behavior, so we add a check for this, which
prevent user taking the last non-isolated CPU offline.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
---
 kernel/cpu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6de7c6bb74ee..94430ea8b4a5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1515,11 +1515,14 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	/*
 	 * Ensure that the control task does not run on the to be offlined
 	 * CPU to prevent a deadlock against cfs_b->period_timer.
+	 * Also keep at least one housekeeping cpu onlined to avoid generating
+	 * an empty sched_domain span.
 	 */
-	cpu = cpumask_any_but(cpu_online_mask, cpu);
-	if (cpu >= nr_cpu_ids)
-		return -EBUSY;
-	return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
+	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN)) {
+		if (cpu != work.cpu)
+			return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
+	}
+	return -EBUSY;
 }

 static int cpu_down(unsigned int cpu, enum cpuhp_state target)
-- 
2.15.2
