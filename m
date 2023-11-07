Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176D47E400C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjKGN0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbjKGN0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:26:44 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D5C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:26:38 -0800 (PST)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SPplz6PzZzMmTQ;
        Tue,  7 Nov 2023 21:22:07 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 7 Nov 2023 21:26:34 +0800
Message-ID: <6f0f3e42-ddf2-1bbf-ec80-bcbae41c700c@huawei.com>
Date:   Tue, 7 Nov 2023 21:26:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liwei (GF)" <liwei391@huawei.com>, xiafukun <xiafukun@huawei.com>,
        <liutie4@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Phil Auld <pauld@redhat.com>, <vschneid@redhat.com>,
        <vdonnefort@google.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>
From:   Yu Liao <liaoyu15@huawei.com>
Subject: [Bug report] A variant deadlock issue of CPU hot-unplug operation vs.
 the CFS bandwidth timer
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch [1] from tglx solved the deadlock issue reported by Xiongfeng [2],
but recently we discovered a variant of the deadlock issue.

[1] https://lore.kernel.org/all/87h6oqdq0i.ffs@tglx/
[2] https://lore.kernel.org/all/8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com/

(The following description is partially borrowed from the commit log of tglx)
	CPU1      			                 CPU2                      CPU3

T1 sets cfs_quota
   starts hrtimer cfs_bandwidth 'period_timer'
T1 is migrated to CPU3
						T2(worker thread) initiates
						offlining of CPU1
Hotplug operation starts
  ...
'period_timer' expires and is
re-enqueued on CPU1
  ...
take_cpu_down()
  CPU1 shuts down and does not handle timers
  anymore. They have to be migrated in the
  post dead hotplug steps by the control task.

						T2(worker thread) runs the
						post dead offline operation
										T1 holds lockA
										T1 is scheduled out
										//throttled by CFS bandwidth control
										T1 waits for 'period_timer' to expire
						T2(worker thread) waits for lockA

T1 waits there forever if it is scheduled out before it can execute the
hrtimer offline callback hrtimers_dead_cpu().
Thus T2 waits for lockA forever.

We discovered several different 'lockA'. This is a real example that occurs on
kernel 5.10, where 'lockA' is 'kernfs_mutex'.

	T1
PID: 743234  TASK: ffff0000c7182880  CPU: 0   COMMAND: "tree"
 #0 [ffffa00105fd7430] __switch_to at ffffa0010001bbb4
 #1 [ffffa00105fd7460] __schedule at ffffa001013e11f4
 #2 [ffffa00105fd7580] __cond_resched at ffffa001013e2278
 #3 [ffffa00105fd75a0] kmem_cache_alloc at ffffa00100589168
 #4 [ffffa00105fd75f0] security_inode_alloc at ffffa001007c9a64
 #5 [ffffa00105fd7620] inode_init_always at ffffa001006538fc
 #6 [ffffa00105fd7670] alloc_inode at ffffa001006566e4
 #7 [ffffa00105fd76a0] iget_locked at ffffa00100658378
 #8 [ffffa00105fd7770] kernfs_get_inode at ffffa0010075a244
 #9 [ffffa00105fd7790] kernfs_iop_lookup at ffffa0010075c530
#10 [ffffa00105fd77d0] __lookup_slow at ffffa0010062de68
#11 [ffffa00105fd78c0] walk_component at ffffa0010063595c
#12 [ffffa00105fd7990] path_lookupat at ffffa001006360fc
#13 [ffffa00105fd79f0] filename_lookup at ffffa00100638b60
#14 [ffffa00105fd7ba0] user_path_at_empty at ffffa00100638e40
#15 [ffffa00105fd7bd0] vfs_statx at ffffa00100621974
#16 [ffffa00105fd7cb0] __se_sys_newfstatat at ffffa001006223b4
#17 [ffffa00105fd7df0] __arm64_sys_newfstatat at ffffa00100622468
#18 [ffffa00105fd7e20] el0_svc_common.constprop.0 at ffffa00100036144
#19 [ffffa00105fd7e60] do_el0_svc at ffffa00100036368
#20 [ffffa00105fd7e80] el0_svc at ffffa001013d6cfc
#21 [ffffa00105fd7ea0] el0_sync_handler at ffffa001013d75fc
#22 [ffffa00105fd7fe0] el0_sync at ffffa0010001255c

	T2
PID: 240180  TASK: ffff0000f25ba880  CPU: 0   COMMAND: "kworker/0:7"
 #0 [ffffa00105e37710] __switch_to at ffffa0010001bbb4
 #1 [ffffa00105e37740] __schedule at ffffa001013e11f4
 #2 [ffffa00105e37860] schedule at ffffa001013e1a3c
 #3 [ffffa00105e37890] schedule_preempt_disabled at ffffa001013e2384
 #4 [ffffa00105e378a0] __mutex_lock.constprop.0 at ffffa001013e418c
 #5 [ffffa00105e379d0] __mutex_lock_slowpath at ffffa001013e4d48
 #6 [ffffa00105e379e0] mutex_lock at ffffa001013e4ec0
 #7 [ffffa00105e37a90] kernfs_find_and_get_ns at ffffa0010075c168
 #8 [ffffa00105e37ac0] sysfs_remove_group at ffffa00100764698
 #9 [ffffa00105e37af0] topology_remove_dev at ffffa00100d8f0a0
#10 [ffffa00105e37b00] cpuhp_invoke_callback at ffffa00100102fc4
#11 [ffffa00105e37ba0] _cpu_down at ffffa001013d89b8
#12 [ffffa00105e37c10] alloc_insn_page at ffffa0010006df98
#13 [ffffa00105e37c30] work_for_cpu_fn at ffffa00100139014
#14 [ffffa00105e37c50] process_one_work at ffffa00100141318
#15 [ffffa00105e37d50] worker_thread at ffffa00100141b7c
#16 [ffffa00105e37e50] kthread at ffffa0010014e5c8


