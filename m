Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711C67A2D87
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbjIPCiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbjIPChw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:37:52 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4E5FA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:37:46 -0700 (PDT)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RnZwR0FPfz5B101
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 10:37:43 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4RnZwQ4t8Yz4xVbq;
        Sat, 16 Sep 2023 10:37:42 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl1.zte.com.cn with SMTP id 38G2beqw084113;
        Sat, 16 Sep 2023 10:37:40 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp06[null])
        by mapi (Zmail) with MAPI id mid14;
        Sat, 16 Sep 2023 10:37:41 +0800 (CST)
Date:   Sat, 16 Sep 2023 10:37:41 +0800 (CST)
X-Zmail-TransId: 2b08650514f5ffffffffa81-afa4a
X-Mailer: Zmail v1.0
Message-ID: <202309161037416349176@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <tglx@linutronix.de>, <peterz@infradead.org>
Cc:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBjcHUvaG90cGx1ZzogZG9udCBvZmZsaW5lIHRoZSBsYXN0IG5vbi1pc29sYXRlZCBDUFU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 38G2beqw084113
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 650514F7.000/4RnZwR0FPfz5B101
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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

Kernel should not panic when user managing CPUs with this
meaningless behavior, so we add a check for this, which
prevent user taking the last non-isolated CPU offline.

[   19.415123] WARNING: CPU: 4 PID: 80 at kernel/sched/topology.c:2366 build_sched_domains+0x120c/0x1408
[   19.430451] Call trace:
[   19.430792]  build_sched_domains+0x120c/0x1408
[   19.431334]  partition_sched_domains_locked+0x234/0x880
[   19.431878]  rebuild_sched_domains_locked+0x37c/0x798
[   19.432436]  rebuild_sched_domains+0x30/0x58
[   19.432902]  cpuset_hotplug_workfn+0x2a8/0x930
[   19.433383]  process_scheduled_works+0x178/0x3e0
[   19.433878]  worker_thread+0x174/0x2f0
[   19.435204] ---[ end trace 0000000000000000 ]---
[   19.438650] Unable to handle kernel paging request at virtual address fffe80027ab37080
[   19.456414]  partition_sched_domains_locked+0x318/0x880
[   19.456899]  rebuild_sched_domains_locked+0x37c/0x798
[   19.457361]  rebuild_sched_domains+0x30/0x58
[   19.457761]  cpuset_hotplug_workfn+0x2a8/0x930
[   19.458175]  process_scheduled_works+0x178/0x3e0
[   19.458599]  worker_thread+0x174/0x2f0
[   19.458948]  kthread+0x10c/0x128
[   19.459268]  ret_from_fork+0x10/0x20
[   19.459728] Code: 1a850042 b9441883 f862dae0 8b000021 (f945003b)

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
---
 kernel/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6de7c6bb74ee..09ecc19d2999 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1502,6 +1502,7 @@ static long __cpu_down_maps_locked(void *arg)
 static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 {
 	struct cpu_down_work work = { .cpu = cpu, .target = target, };
+	struct cpumask tmp_mask;

 	/*
 	 * If the platform does not support hotplug, report it explicitly to
@@ -1512,11 +1513,16 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	if (cpu_hotplug_disabled)
 		return -EBUSY;

+	/*
+	 * Ensure the last non-isolated CPU is not offlined.
+	 */
+	cpumask_and(&tmp_mask, cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
+
 	/*
 	 * Ensure that the control task does not run on the to be offlined
 	 * CPU to prevent a deadlock against cfs_b->period_timer.
 	 */
-	cpu = cpumask_any_but(cpu_online_mask, cpu);
+	cpu = cpumask_any_but(&tmp_mask, cpu);
 	if (cpu >= nr_cpu_ids)
 		return -EBUSY;
 	return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
-- 
2.15.2
