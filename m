Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEC7FAA96
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjK0Tte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjK0Ttb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:49:31 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA5E1B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:49:34 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-77d6f853ba0so367597485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701114573; x=1701719373;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yMZ21Vv0xvcKghq5LqzCC+djagngV6vHmqnn/NeDWM=;
        b=hb9DjTN/Qb7OPXNF2kbtBFYRNzNxN6DHUrg3d2QxJ4p3JUzZ6L0a39P9DjbHImOAQ3
         opZXYFuQVvcpa6LYfYjBjiWhpT5j1qJhhWy9/jkvFEgt7tyrKSV5aBln6ej4EGAV8/ML
         /KjnOfPE4uv4WU5jAmVT6kkPzwK/spw89MhGhvgJj3kdgUNKI2DAcyLyv1OOcWIvEwqq
         0YG0n0yxj8cUm8smw7iMFd+nEz/fUWACnLum8py0qOeEs5xccw9vzc0eVjHHIEfe3pPI
         AF9PmkWmcqEkON2UL0hH6x+zkdHCqSGBQfQyaQXErtsVrcd7Uw/xBwQUtMV8dqfSFP+I
         Wr0w==
X-Gm-Message-State: AOJu0YxDMoy45msJKKehWi1oa4oDsp29CjxQe79PjeJgG3oRjGPnwAR0
        8BgPmqiJoHOdo28vZj3e9g8=
X-Google-Smtp-Source: AGHT+IFmqE3GsOGOyeLxv71+h/qeq8MmFb2sUeEqe4SATw9q3TX7vdC5ycBki9L4iIcSxF/wJySKog==
X-Received: by 2002:a05:620a:468d:b0:77d:72cf:c47 with SMTP id bq13-20020a05620a468d00b0077d72cf0c47mr21423515qkb.35.1701114573238;
        Mon, 27 Nov 2023 11:49:33 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id re19-20020a05620a8e1300b0077731466526sm3926295qkn.70.2023.11.27.11.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:49:32 -0800 (PST)
Date:   Mon, 27 Nov 2023 13:49:29 -0600
From:   David Vernet <void@manifault.com>
To:     Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] sched: Implement shared runqueue in CFS
Message-ID: <20231127194929.GA5421@maniforge>
References: <20230809221218.163894-1-void@manifault.com>
 <fd7370aeef50c50228b817e817872921b33fc5fe.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7370aeef50c50228b817e817872921b33fc5fe.camel@linux.vnet.ibm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 01:58:34PM +0530, Aboorva Devarajan wrote:
> On Wed, 2023-08-09 at 17:12 -0500, David Vernet wrote:
> 
> Hi David,
> 
> I have been benchmarking the patch-set on POWER9 machine to understand
> its impact. However, I've run into a recurring hard-lockups in
> newidle_balance, specifically when SHARED_RUNQ feature is enabled. It
> doesn't happen all the time, but it's something worth noting. I wanted
> to inform you about this, and I can provide more details if needed.

Hello Aboorva,

Thank you for testing out this patch set and for the report. One issue
that v4 will correct is that the shared_runq list could become corrupted
if you enable and disable the feature, as a stale task could remain in
the list after the feature has been disabled. I'll be including a fix
for that in v4, which I'm currently benchmarking, but other stuff keeps
seeming to preempt it.

By any chance, did you run into this when you were enabling / disabling
the feature? Or did you just enable it once and then hit this issue
after some time, which would indicate a different issue? I'm trying to
repro using ab, but haven't been successful thus far. If you're able to
repro consistently, it might be useful to run with CONFIG_LIST_DEBUG=y.

Thanks,
David

> -----------------------------------------
> 
> Some inital information regarding the hard-lockup:
> 
> Base Kernel:
> -----------
> 
> Base kernel is upto commit 88c56cfeaec4 ("sched/fair: Block nohz
> tick_stop when cfs bandwidth in use").
> 
> Patched Kernel:
> -------------
> 
> Base Kernel + v3 (shared runqueue patch-set)(
> https://lore.kernel.org/all/20230809221218.163894-1-void@manifault.com/
> )
> 
> The hard-lockup moslty occurs when running the Apache2 benchmarks with
> ab (Apache HTTP benchmarking tool) on the patched kernel. However, this
> problem is not exclusive to the mentioned benchmark and only occurs
> while the SHARED_RUNQ feature is enabled. Disabling SHARED_RUNQ feature
> prevents the occurrence of the lockup.
> 
> ab (Apache HTTP benchmarking tool): 
> https://httpd.apache.org/docs/2.4/programs/ab.html
> 
> Hardlockup with Patched Kernel:
> ------------------------------
> 
> [ 3289.727912][  C123] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [ 3289.727943][  C123] rcu: 	124-...0: (1 GPs behind) idle=f174/1/0x4000000000000000 softirq=12283/12289 fqs=732
> [ 3289.727976][  C123] rcu: 	(detected by 123, t=2103 jiffies, g=127061, q=5517 ncpus=128)
> [ 3289.728008][  C123] Sending NMI from CPU 123 to CPUs 124:
> [ 3295.182378][  C123] CPU 124 didn't respond to backtrace IPI, inspecting paca.
> [ 3295.182403][  C123] irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 15 (ksoftirqd/124)
> [ 3295.182421][  C123] Back trace of paca->saved_r1 (0xc000000de13e79b0) (possibly stale):
> [ 3295.182437][  C123] Call Trace:
> [ 3295.182456][  C123] [c000000de13e79b0] [c000000de13e7a70] 0xc000000de13e7a70 (unreliable)
> [ 3295.182477][  C123] [c000000de13e7ac0] [0000000000000008] 0x8
> [ 3295.182500][  C123] [c000000de13e7b70] [c000000de13e7c98] 0xc000000de13e7c98
> [ 3295.182519][  C123] [c000000de13e7ba0] [c0000000001da8bc] move_queued_task+0x14c/0x280
> [ 3295.182557][  C123] [c000000de13e7c30] [c0000000001f22d8] newidle_balance+0x648/0x940
> [ 3295.182602][  C123] [c000000de13e7d30] [c0000000001f26ac] pick_next_task_fair+0x7c/0x680
> [ 3295.182647][  C123] [c000000de13e7dd0] [c0000000010f175c] __schedule+0x15c/0x1040
> [ 3295.182675][  C123] [c000000de13e7ec0] [c0000000010f26b4] schedule+0x74/0x140
> [ 3295.182694][  C123] [c000000de13e7f30] [c0000000001c4994] smpboot_thread_fn+0x244/0x250
> [ 3295.182731][  C123] [c000000de13e7f90] [c0000000001bc6e8] kthread+0x138/0x140
> [ 3295.182769][  C123] [c000000de13e7fe0] [c00000000000ded8] start_kernel_thread+0x14/0x18
> [ 3295.182806][  C123] rcu: rcu_sched kthread starved for 544 jiffies! g127061 f0x0 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=66
> [ 3295.182845][  C123] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> [ 3295.182878][  C123] rcu: RCU grace-period kthread stack dump:
> 
> -----------------------------------------
> 
> [ 3943.438625][  C112] watchdog: CPU 112 self-detected hard LOCKUP @ _raw_spin_lock_irqsave+0x4c/0xc0
> [ 3943.438631][  C112] watchdog: CPU 112 TB:115060212303626, last heartbeat TB:115054309631589 (11528ms ago)
> [ 3943.438673][  C112] CPU: 112 PID: 2090 Comm: kworker/112:2 Tainted: G        W    L     6.5.0-rc2-00028-g7475adccd76b #51
> [ 3943.438676][  C112] Hardware name: 8335-GTW POWER9 (raw) 0x4e1203 opal:skiboot-v6.5.3-35-g1851b2a06 PowerNV
> [ 3943.438678][  C112] Workqueue:  0x0 (events)
> [ 3943.438682][  C112] NIP:  c0000000010ff01c LR: c0000000001d1064 CTR: c0000000001e8580
> [ 3943.438684][  C112] REGS: c000007fffb6bd60 TRAP: 0900   Tainted: G        W    L      (6.5.0-rc2-00028-g7475adccd76b)
> [ 3943.438686][  C112] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24082222  XER: 00000000
> [ 3943.438693][  C112] CFAR: 0000000000000000 IRQMASK: 1 
> [ 3943.438693][  C112] GPR00: c0000000001d1064 c000000e16d1fb20 c0000000014e8200 c000000e092fed3c 
> [ 3943.438693][  C112] GPR04: c000000e16d1fc58 c000000e092fe3c8 00000000000000e1 fffffffffffe0000 
> [ 3943.438693][  C112] GPR08: 0000000000000000 00000000000000e1 0000000000000000 c00000000299ccd8 
> [ 3943.438693][  C112] GPR12: 0000000024088222 c000007ffffb8300 c0000000001bc5b8 c000000deb46f740 
> [ 3943.438693][  C112] GPR16: 0000000000000008 c000000e092fe280 0000000000000001 c000007ffedd7b00 
> [ 3943.438693][  C112] GPR20: 0000000000000001 c0000000029a1280 0000000000000000 0000000000000001 
> [ 3943.438693][  C112] GPR24: 0000000000000000 c000000e092fed3c c000000e16d1fdf0 c00000000299ccd8 
> [ 3943.438693][  C112] GPR28: c000000e16d1fc58 c0000000021fbf00 c000007ffee6bf00 0000000000000001 
> [ 3943.438722][  C112] NIP [c0000000010ff01c] _raw_spin_lock_irqsave+0x4c/0xc0
> [ 3943.438725][  C112] LR [c0000000001d1064] task_rq_lock+0x64/0x1b0
> [ 3943.438727][  C112] Call Trace:
> [ 3943.438728][  C112] [c000000e16d1fb20] [c000000e16d1fb60] 0xc000000e16d1fb60 (unreliable)
> [ 3943.438731][  C112] [c000000e16d1fb50] [c000000e16d1fbf0] 0xc000000e16d1fbf0
> [ 3943.438733][  C112] [c000000e16d1fbf0] [c0000000001f214c] newidle_balance+0x4bc/0x940
> [ 3943.438737][  C112] [c000000e16d1fcf0] [c0000000001f26ac] pick_next_task_fair+0x7c/0x680
> [ 3943.438739][  C112] [c000000e16d1fd90] [c0000000010f175c] __schedule+0x15c/0x1040
> [ 3943.438743][  C112] [c000000e16d1fe80] [c0000000010f26b4] schedule+0x74/0x140
> [ 3943.438747][  C112] [c000000e16d1fef0] [c0000000001afd44] worker_thread+0x134/0x580
> [ 3943.438749][  C112] [c000000e16d1ff90] [c0000000001bc6e8] kthread+0x138/0x140
> [ 3943.438753][  C112] [c000000e16d1ffe0] [c00000000000ded8] start_kernel_thread+0x14/0x18
> [ 3943.438756][  C112] Code: 63e90001 992d0932 a12d0008 3ce0fffe 5529083c 61290001 7d001
> 
> -----------------------------------------
> 
> System configuration:
> --------------------
> 
> # lscpu
> Architecture:                    ppc64le
> Byte Order:                      Little Endian
> CPU(s):                          128
> On-line CPU(s) list:             0-127
> Thread(s) per core:              4
> Core(s) per socket:              16
> Socket(s):                       2
> NUMA node(s):                    8
> Model:                           2.3 (pvr 004e 1203)
> Model name:                      POWER9 (raw), altivec supported
> Frequency boost:                 enabled
> CPU max MHz:                     3800.0000
> CPU min MHz:                     2300.0000
> L1d cache:                       1 MiB
> L1i cache:                       1 MiB
> NUMA node0 CPU(s):               64-127
> NUMA node8 CPU(s):               0-63
> NUMA node250 CPU(s):             
> NUMA node251 CPU(s):             
> NUMA node252 CPU(s):             
> NUMA node253 CPU(s):             
> NUMA node254 CPU(s):             
> NUMA node255 CPU(s):             
> 
> # uname -r
> 6.5.0-rc2-00028-g7475adccd76b
> 
> # cat /sys/kernel/debug/sched/features
> GENTLE_FAIR_SLEEPERS START_DEBIT NO_NEXT_BUDDY LAST_BUDDY
> CACHE_HOT_BUDDY WAKEUP_PREEMPTION NO_HRTICK NO_HRTICK_DL NO_DOUBLE_TICK
> NONTASK_CAPACITY TTWU_QUEUE NO_SIS_PROP SIS_UTIL NO_WARN_DOUBLE_CLOCK
> RT_PUSH_IPI NO_RT_RUNTIME_SHARE NO_LB_MIN ATTACH_AGE_LOAD WA_IDLE
> WA_WEIGHT WA_BIAS UTIL_EST UTIL_EST_FASTUP NO_LATENCY_WARN ALT_PERIOD
> BASE_SLICE HZ_BW SHARED_RUNQ
> 
> -----------------------------------------
> 
> Please let me know if I've missed anything here. I'll continue
> investigating and share any additional information I find.
> 
> Thanks and Regards,
> Aboorva
> 
> 
> > Changes
> > -------
> > 
> > This is v3 of the shared runqueue patchset. This patch set is based
> > off
> > of commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
> > bandwidth in use") on the sched/core branch of tip.git.
> > 
> > v1 (RFC): 
> > https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/
> > v2: 
> > https://lore.kernel.org/lkml/20230710200342.358255-1-void@manifault.com/
> > 
> > v2 -> v3 changes:
> > - Don't leave stale tasks in the lists when the SHARED_RUNQ feature
> > is
> >   disabled (Abel Wu)
> > 
> > - Use raw spin lock instead of spinlock_t (Peter)
> > 
> > - Fix return value from shared_runq_pick_next_task() to match the
> >   semantics expected by newidle_balance() (Gautham, Abel)
> > 
> > - Fold patch __enqueue_entity() / __dequeue_entity() into previous
> > patch
> >   (Peter)
> > 
> > - Skip <= LLC domains in newidle_balance() if SHARED_RUNQ is enabled
> >   (Peter)
> > 
> > - Properly support hotplug and recreating sched domains (Peter)
> > 
> > - Avoid unnecessary task_rq_unlock() + raw_spin_rq_lock() when src_rq
> > ==
> >   target_rq in shared_runq_pick_next_task() (Abel)
> > 
> > - Only issue list_del_init() in shared_runq_dequeue_task() if the
> > task
> >   is still in the list after acquiring the lock (Aaron Lu)
> > 
> > - Slightly change shared_runq_shard_idx() to make it more likely to
> > keep
> >   SMT siblings on the same bucket (Peter)
> > 
> > v1 -> v2 changes:
> > - Change name from swqueue to shared_runq (Peter)
> > 
> > - Shard per-LLC shared runqueues to avoid contention on scheduler-
> > heavy
> >   workloads (Peter)
> > 
> > - Pull tasks from the shared_runq in newidle_balance() rather than in
> >   pick_next_task_fair() (Peter and Vincent)
> > 
> > - Rename a few functions to reflect their actual purpose. For
> > example,
> >   shared_runq_dequeue_task() instead of swqueue_remove_task() (Peter)
> > 
> > - Expose move_queued_task() from core.c rather than migrate_task_to()
> >   (Peter)
> > 
> > - Properly check is_cpu_allowed() when pulling a task from a
> > shared_runq
> >   to ensure it can actually be migrated (Peter and Gautham)
> > 
> > - Dropped RFC tag
> > 
> > Overview
> > ========
> > 
> > The scheduler must constantly strike a balance between work
> > conservation, and avoiding costly migrations which harm performance
> > due
> > to e.g. decreased cache locality. The matter is further complicated
> > by
> > the topology of the system. Migrating a task between cores on the
> > same
> > LLC may be more optimal than keeping a task local to the CPU, whereas
> > migrating a task between LLCs or NUMA nodes may tip the balance in
> > the
> > other direction.
> > 
> > With that in mind, while CFS is by and large mostly a work conserving
> > scheduler, there are certain instances where the scheduler will
> > choose
> > to keep a task local to a CPU, when it would have been more optimal
> > to
> > migrate it to an idle core.
> > 
> > An example of such a workload is the HHVM / web workload at Meta.
> > HHVM
> > is a VM that JITs Hack and PHP code in service of web requests. Like
> > other JIT / compilation workloads, it tends to be heavily CPU bound,
> > and
> > exhibit generally poor cache locality. To try and address this, we
> > set
> > several debugfs (/sys/kernel/debug/sched) knobs on our HHVM
> > workloads:
> > 
> > - migration_cost_ns -> 0
> > - latency_ns -> 20000000
> > - min_granularity_ns -> 10000000
> > - wakeup_granularity_ns -> 12000000
> > 
> > These knobs are intended both to encourage the scheduler to be as
> > work
> > conserving as possible (migration_cost_ns -> 0), and also to keep
> > tasks
> > running for relatively long time slices so as to avoid the overhead
> > of
> > context switching (the other knobs). Collectively, these knobs
> > provide a
> > substantial performance win; resulting in roughly a 20% improvement
> > in
> > throughput. Worth noting, however, is that this improvement is _not_
> > at
> > full machine saturation.
> > 
> > That said, even with these knobs, we noticed that CPUs were still
> > going
> > idle even when the host was overcommitted. In response, we wrote the
> > "shared runqueue" (SHARED_RUNQ) feature proposed in this patch set.
> > The
> > idea behind SHARED_RUNQ is simple: it enables the scheduler to be
> > more
> > aggressively work conserving by placing a waking task into a sharded
> > per-LLC FIFO queue that can be pulled from by another core in the LLC
> > FIFO queue which can then be pulled from before it goes idle.
> > 
> > With this simple change, we were able to achieve a 1 - 1.6%
> > improvement
> > in throughput, as well as a small, consistent improvement in p95 and
> > p99
> > latencies, in HHVM. These performance improvements were in addition
> > to
> > the wins from the debugfs knobs mentioned above, and to other
> > benchmarks
> > outlined below in the Results section.
> > 
> > Design
> > ======
> > 
> > Note that the design described here reflects sharding, which is the
> > implementation added in the final patch of the series (following the
> > initial unsharded implementation added in patch 6/7). The design is
> > described that way in this commit summary as the benchmarks described
> > in
> > the results section below all reflect a sharded SHARED_RUNQ.
> > 
> > The design of SHARED_RUNQ is quite simple. A shared_runq is simply a
> > list of struct shared_runq_shard objects, which itself is simply a
> > struct list_head of tasks, and a spinlock:
> > 
> > struct shared_runq_shard {
> > 	struct list_head list;
> > 	raw_spinlock_t lock;
> > } ____cacheline_aligned;
> > 
> > struct shared_runq {
> > 	u32 num_shards;
> > 	struct shared_runq_shard shards[];
> > } ____cacheline_aligned;
> > 
> > We create a struct shared_runq per LLC, ensuring they're in their own
> > cachelines to avoid false sharing between CPUs on different LLCs, and
> > we
> > create a number of struct shared_runq_shard objects that are housed
> > there.
> > 
> > When a task first wakes up, it enqueues itself in the
> > shared_runq_shard
> > of its current LLC at the end of enqueue_task_fair(). Enqueues only
> > happen if the task was not manually migrated to the current core by
> > select_task_rq(), and is not pinned to a specific CPU.
> > 
> > A core will pull a task from the shards in its LLC's shared_runq at
> > the
> > beginning of newidle_balance().
> > 
> > Difference between SHARED_RUNQ and SIS_NODE
> > ===========================================
> > 
> > In [0] Peter proposed a patch that addresses Tejun's observations
> > that
> > when workqueues are targeted towards a specific LLC on his Zen2
> > machine
> > with small CCXs, that there would be significant idle time due to
> > select_idle_sibling() not considering anything outside of the current
> > LLC.
> > 
> > This patch (SIS_NODE) is essentially the complement to the proposal
> > here. SID_NODE causes waking tasks to look for idle cores in
> > neighboring
> > LLCs on the same die, whereas SHARED_RUNQ causes cores about to go
> > idle
> > to look for enqueued tasks. That said, in its current form, the two
> > features at are a different scope as SIS_NODE searches for idle cores
> > between LLCs, while SHARED_RUNQ enqueues tasks within a single LLC.
> > 
> > The patch was since removed in [1], and we compared the results to
> > SHARED_RUNQ (previously called "swqueue") in [2]. SIS_NODE did not
> > outperform SHARED_RUNQ on any of the benchmarks, so we elect to not
> > compare against it again for this v2 patch set.
> > 
> > [0]: 
> > https://lore.kernel.org/all/20230530113249.GA156198@hirez.programming.kicks-ass.net/
> > [1]: 
> > https://lore.kernel.org/all/20230605175636.GA4253@hirez.programming.kicks-ass.net/
> > [2]: 
> > https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/
> > 
> > Worth noting as well is that pointed out in [3] that the logic behind
> > including SIS_NODE in the first place should apply to SHARED_RUNQ
> > (meaning that e.g. very small Zen2 CPUs with only 3/4 cores per LLC
> > should benefit from having a single shared_runq stretch across
> > multiple
> > LLCs). I drafted a patch that implements this by having a minimum LLC
> > size for creating a shard, and stretches a shared_runq across
> > multiple
> > LLCs if they're smaller than that size, and sent it to Tejun to test
> > on
> > his Zen2. Tejun reported back that SIS_NODE did not seem to make a
> > difference:
> > 
> > [3]: 
> > https://lore.kernel.org/lkml/20230711114207.GK3062772@hirez.programming.kicks-ass.net/
> > 
> > 			    o____________o__________o
> > 			    |    mean    | Variance |
> > 			    o------------o----------o
> > Vanilla:		    | 108.84s    | 0.0057   |
> > NO_SHARED_RUNQ:		    | 108.82s    | 0.119s   |
> > SHARED_RUNQ:		    | 108.17s    | 0.038s   |
> > SHARED_RUNQ w/ SIS_NODE:    | 108.87s    | 0.111s   |
> > 			    o------------o----------o
> > 
> > I similarly tried running kcompile on SHARED_RUNQ with SIS_NODE on my
> > 7950X Zen3, but didn't see any gain relative to plain SHARED_RUNQ
> > (though
> > a gain was observed relative to NO_SHARED_RUNQ, as described below).
> > 
> > Results
> > =======
> > 
> > Note that the motivation for the shared runqueue feature was
> > originally
> > arrived at using experiments in the sched_ext framework that's
> > currently
> > being proposed upstream. The ~1 - 1.6% improvement in HHVM throughput
> > is similarly visible using work-conserving sched_ext schedulers (even
> > very simple ones like global FIFO).
> > 
> > In both single and multi socket / CCX hosts, this can measurably
> > improve
> > performance. In addition to the performance gains observed on our
> > internal web workloads, we also observed an improvement in common
> > workloads such as kernel compile and hackbench, when running shared
> > runqueue.
> > 
> > On the other hand, some workloads suffer from SHARED_RUNQ. Workloads
> > that hammer the runqueue hard, such as netperf UDP_RR, or schbench -L
> > -m 52 -p 512 -r 10 -t 1. This can be mitigated somewhat by sharding
> > the
> > shared datastructures within a CCX, but it doesn't seem to eliminate
> > all
> > contention in every scenario. On the positive side, it seems that
> > sharding does not materially harm the benchmarks run for this patch
> > series; and in fact seems to improve some workloads such as kernel
> > compile.
> > 
> > Note that for the kernel compile workloads below, the compilation was
> > done by running make -j$(nproc) built-in.a on several different types
> > of
> > hosts configured with make allyesconfig on commit a27648c74210 ("afs:
> > Fix setting of mtime when creating a file/dir/symlink") on Linus'
> > tree
> > (boost and turbo were disabled on all of these hosts when the
> > experiments were performed).
> > 
> > Finally, note that these results were from the patch set built off of
> > commit ebb83d84e49b ("sched/core: Avoid multiple calling
> > update_rq_clock() in __cfsb_csd_unthrottle()") on the sched/core
> > branch
> > of tip.git for easy comparison with the v2 patch set results. The
> > patches in their final form from this set were rebased onto commit
> > 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs bandwidth in
> > use") on the sched/core branch of tip.git.
> > 
> > === Single-socket | 16 core / 32 thread | 2-CCX | AMD 7950X Zen4 ===
> > 
> > CPU max MHz: 5879.8818
> > CPU min MHz: 3000.0000
> > 
> > Command: make -j$(nproc) built-in.a
> > 			    o____________o__________o
> > 			    |    mean    | Variance |
> > 			    o------------o----------o
> > NO_SHARED_RUNQ:		    | 581.95s    | 2.639s   |
> > SHARED_RUNQ:		    | 577.02s    | 0.084s   |
> > 			    o------------o----------o
> > 
> > Takeaway: SHARED_RUNQ results in a statistically significant ~.85%
> > improvement over NO_SHARED_RUNQ. This suggests that enqueuing tasks
> > in
> > the shared runqueue on every enqueue improves work conservation, and
> > thanks to sharding, does not result in contention.
> > 
> > Command: hackbench --loops 10000
> >                             o____________o__________o
> >                             |    mean    | Variance |
> >                             o------------o----------o
> > NO_SHARED_RUNQ:             | 2.2492s    | .00001s  |
> > SHARED_RUNQ:		    | 2.0217s    | .00065s  |
> >                             o------------o----------o
> > 
> > Takeaway: SHARED_RUNQ in both forms performs exceptionally well
> > compared
> > to NO_SHARED_RUNQ here, beating it by over 10%. This was a surprising
> > result given that it seems advantageous to err on the side of
> > avoiding
> > migration in hackbench given that tasks are short lived in sending
> > only
> > 10k bytes worth of messages, but the results of the benchmark would
> > seem
> > to suggest that minimizing runqueue delays is preferable.
> > 
> > Command:
> > for i in `seq 128`; do
> >     netperf -6 -t UDP_RR -c -C -l $runtime &
> > done
> >                             o_______________________o
> >                             | Throughput | Variance |
> >                             o-----------------------o
> > NO_SHARED_RUNQ:             | 25037.45   | 2243.44  |
> > SHARED_RUNQ:                | 24952.50   | 1268.06  |
> >                             o-----------------------o
> > 
> > Takeaway: No statistical significance, though it is worth noting that
> > there is no regression for shared runqueue on the 7950X, while there
> > is
> > a small regression on the Skylake and Milan hosts for SHARED_RUNQ as
> > described below.
> > 
> > === Single-socket | 18 core / 36 thread | 1-CCX | Intel Skylake ===
> > 
> > CPU max MHz: 1601.0000
> > CPU min MHz: 800.0000
> > 
> > Command: make -j$(nproc) built-in.a
> > 			    o____________o__________o
> > 			    |    mean    | Variance |
> > 			    o------------o----------o
> > NO_SHARED_RUNQ:		    | 1517.44s   | 2.8322s  |
> > SHARED_RUNQ:		    | 1516.51s   | 2.9450s  |
> > 			    o------------o----------o
> > 
> > Takeaway: There's on statistically significant gain here. I observed
> > what I claimed was a .23% win in v2, but it appears that this is not
> > actually statistically significant.
> > 
> > Command: hackbench --loops 10000
> >                             o____________o__________o
> >                             |    mean    | Variance |
> >                             o------------o----------o
> > NO_SHARED_RUNQ:             | 5.3370s    | .0012s   |
> > SHARED_RUNQ:		    | 5.2668s    | .0033s   |
> >                             o------------o----------o
> > 
> > Takeaway: SHARED_RUNQ results in a ~1.3% improvement over
> > NO_SHARED_RUNQ. Also statistically significant, but smaller than the
> > 10+% improvement observed on the 7950X.
> > 
> > Command: netperf -n $(nproc) -l 60 -t TCP_RR
> > for i in `seq 128`; do
> >         netperf -6 -t UDP_RR -c -C -l $runtime &
> > done
> >                             o_______________________o
> >                             | Throughput | Variance |
> >                             o-----------------------o
> > NO_SHARED_RUNQ:             | 15699.32   | 377.01   |
> > SHARED_RUNQ:                | 14966.42   | 714.13   |
> >                             o-----------------------o
> > 
> > Takeaway: NO_SHARED_RUNQ beats SHARED_RUNQ by ~4.6%. This result
> > makes
> > sense -- the workload is very heavy on the runqueue, so enqueuing
> > tasks
> > in the shared runqueue in __enqueue_entity() would intuitively result
> > in
> > increased contention on the shard lock.
> > 
> > === Single-socket | 72-core | 6-CCX | AMD Milan Zen3 ===
> > 
> > CPU max MHz: 700.0000
> > CPU min MHz: 700.0000
> > 
> > Command: make -j$(nproc) built-in.a
> > 			    o____________o__________o
> > 			    |    mean    | Variance |
> > 			    o------------o----------o
> > NO_SHARED_RUNQ:		    | 1568.55s   | 0.1568s  |
> > SHARED_RUNQ:		    | 1568.26s   | 1.2168s  |
> > 			    o------------o----------o
> > 
> > Takeaway: No statistically significant difference here. It might be
> > worth experimenting with work stealing in a follow-on patch set.
> > 
> > Command: hackbench --loops 10000
> >                             o____________o__________o
> >                             |    mean    | Variance |
> >                             o------------o----------o
> > NO_SHARED_RUNQ:             | 5.2716s    | .00143s  |
> > SHARED_RUNQ:		    | 5.1716s    | .00289s  |
> >                             o------------o----------o
> > 
> > Takeaway: SHARED_RUNQ again wins, by about 2%.
> > 
> > Command: netperf -n $(nproc) -l 60 -t TCP_RR
> > for i in `seq 128`; do
> >         netperf -6 -t UDP_RR -c -C -l $runtime &
> > done
> >                             o_______________________o
> >                             | Throughput | Variance |
> >                             o-----------------------o
> > NO_SHARED_RUNQ:             | 17482.03   | 4675.99  |
> > SHARED_RUNQ:                | 16697.25   | 9812.23  |
> >                             o-----------------------o
> > 
> > Takeaway: Similar to the Skylake runs, NO_SHARED_RUNQ still beats
> > SHARED_RUNQ, this time by ~4.5%. It's worth noting that in v2, the
> > NO_SHARED_RUNQ was only ~1.8% faster. The variance is very high here,
> > so
> > the results of this benchmark should be taken with a large grain of
> > salt (noting that we do consistently see NO_SHARED_RUNQ on top due to
> > not contending on the shard lock).
> > 
> > Finally, let's look at how sharding affects the following schbench
> > incantation suggested by Chris in [4]:
> > 
> > schbench -L -m 52 -p 512 -r 10 -t 1
> > 
> > [4]: 
> > https://lore.kernel.org/lkml/c8419d9b-2b31-2190-3058-3625bdbcb13d@meta.com/
> > 
> > The TL;DR is that sharding improves things a lot, but doesn't
> > completely
> > fix the problem. Here are the results from running the schbench
> > command
> > on the 18 core / 36 thread single CCX, single-socket Skylake:
> > 
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > -----------------------------------------------------------------
> > class name         con-bounces    contentions       waittime-
> > min   waittime-max waittime-total   waittime-avg    acq-
> > bounces   acquisitions   holdtime-min   holdtime-max holdtime-
> > total   holdtime-avg
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > -----------------------------------------------------------------
> > 
> > &shard-
> > >lock:      31510503       31510711           0.08          19.98    
> >     168932319.64     5.36            31700383      31843851       0.0
> > 3           17.50        10273968.33      0.32
> > ------------
> > &shard->lock       15731657          [<0000000068c0fd75>]
> > pick_next_task_fair+0x4dd/0x510
> > &shard->lock       15756516          [<000000001faf84f9>]
> > enqueue_task_fair+0x459/0x530
> > &shard->lock          21766          [<00000000126ec6ab>]
> > newidle_balance+0x45a/0x650
> > &shard->lock            772          [<000000002886c365>]
> > dequeue_task_fair+0x4c9/0x540
> > ------------
> > &shard->lock          23458          [<00000000126ec6ab>]
> > newidle_balance+0x45a/0x650
> > &shard->lock       16505108          [<000000001faf84f9>]
> > enqueue_task_fair+0x459/0x530
> > &shard->lock       14981310          [<0000000068c0fd75>]
> > pick_next_task_fair+0x4dd/0x510
> > &shard->lock            835          [<000000002886c365>]
> > dequeue_task_fair+0x4c9/0x540
> > 
> > These results are when we create only 3 shards (16 logical cores per
> > shard), so the contention may be a result of overly-coarse sharding.
> > If
> > we run the schbench incantation with no sharding whatsoever, we see
> > the
> > following significantly worse lock stats contention:
> > 
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > ----
> > class name        con-bounces    contentions         waittime-
> > min   waittime-max waittime-total         waittime-avg    acq-
> > bounces   acquisitions   holdtime-min  holdtime-max holdtime-
> > total   holdtime-avg
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > ----
> > 
> > &shard-
> > >lock:     117868635      118361486           0.09           393.01  
> >      1250954097.25          10.57           119345882     119780601  
> >     0.05          343.35       38313419.51      0.32
> > ------------
> > &shard->lock       59169196          [<0000000060507011>]
> > __enqueue_entity+0xdc/0x110
> > &shard->lock       59084239          [<00000000f1c67316>]
> > __dequeue_entity+0x78/0xa0
> > &shard->lock         108051          [<00000000084a6193>]
> > newidle_balance+0x45a/0x650
> > ------------
> > &shard->lock       60028355          [<0000000060507011>]
> > __enqueue_entity+0xdc/0x110
> > &shard->lock         119882          [<00000000084a6193>]
> > newidle_balance+0x45a/0x650
> > &shard->lock       58213249          [<00000000f1c67316>]
> > __dequeue_entity+0x78/0xa0
> > 
> > The contention is ~3-4x worse if we don't shard at all. This roughly
> > matches the fact that we had 3 shards on the first workload run
> > above.
> > If we make the shards even smaller, the contention is comparably much
> > lower:
> > 
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > ----------------------------------------------------------
> > class name         con-bounces    contentions   waittime-
> > min  waittime-max waittime-total   waittime-avg   acq-
> > bounces   acquisitions   holdtime-min  holdtime-max holdtime-
> > total   holdtime-avg
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > ----------------------------------------------------------
> > 
> > &shard-
> > >lock:      13839849       13877596      0.08          13.23        5
> > 389564.95       0.39           46910241      48069307       0.06     
> >      16.40        16534469.35      0.34
> > ------------
> > &shard->lock           3559          [<00000000ea455dcc>]
> > newidle_balance+0x45a/0x650
> > &shard->lock        6992418          [<000000002266f400>]
> > __dequeue_entity+0x78/0xa0
> > &shard->lock        6881619          [<000000002a62f2e0>]
> > __enqueue_entity+0xdc/0x110
> > ------------
> > &shard->lock        6640140          [<000000002266f400>]
> > __dequeue_entity+0x78/0xa0
> > &shard->lock           3523          [<00000000ea455dcc>]
> > newidle_balance+0x45a/0x650
> > &shard->lock        7233933          [<000000002a62f2e0>]
> > __enqueue_entity+0xdc/0x110
> > 
> > Interestingly, SHARED_RUNQ performs worse than NO_SHARED_RUNQ on the
> > schbench
> > benchmark on Milan as well, but we contend more on the rq lock than
> > the
> > shard lock:
> > 
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > -----------------------------------------------------------
> > class name         con-bounces    contentions   waittime-
> > min  waittime-max waittime-total   waittime-avg   acq-
> > bounces   acquisitions   holdtime-min   holdtime-max holdtime-
> > total   holdtime-avg
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > -----------------------------------------------------------
> > 
> > &rq-
> > >__lock:       9617614        9656091       0.10          79.64      
> >   69665812.00      7.21           18092700      67652829       0.11  
> >          82.38        344524858.87     5.09
> > -----------
> > &rq->__lock        6301611          [<000000003e63bf26>]
> > task_rq_lock+0x43/0xe0
> > &rq->__lock        2530807          [<00000000516703f0>]
> > __schedule+0x72/0xaa0
> > &rq->__lock         109360          [<0000000011be1562>]
> > raw_spin_rq_lock_nested+0xa/0x10
> > &rq->__lock         178218          [<00000000c38a30f9>]
> > sched_ttwu_pending+0x3d/0x170
> > -----------
> > &rq->__lock        3245506          [<00000000516703f0>]
> > __schedule+0x72/0xaa0
> > &rq->__lock        1294355          [<00000000c38a30f9>]
> > sched_ttwu_pending+0x3d/0x170
> > &rq->__lock        2837804          [<000000003e63bf26>]
> > task_rq_lock+0x43/0xe0
> > &rq->__lock        1627866          [<0000000011be1562>]
> > raw_spin_rq_lock_nested+0xa/0x10
> > 
> > .....................................................................
> > .....................................................................
> > ........................................................
> > 
> > &shard-
> > >lock:       7338558       7343244       0.10          35.97        7
> > 173949.14       0.98           30200858      32679623       0.08     
> >       35.59        16270584.52      0.50
> > ------------
> > &shard->lock        2004142          [<00000000f8aa2c91>]
> > __dequeue_entity+0x78/0xa0
> > &shard->lock        2611264          [<00000000473978cc>]
> > newidle_balance+0x45a/0x650
> > &shard->lock        2727838          [<0000000028f55bb5>]
> > __enqueue_entity+0xdc/0x110
> > ------------
> > &shard->lock        2737232          [<00000000473978cc>]
> > newidle_balance+0x45a/0x650
> > &shard->lock        1693341          [<00000000f8aa2c91>]
> > __dequeue_entity+0x78/0xa0
> > &shard->lock        2912671          [<0000000028f55bb5>]
> > __enqueue_entity+0xdc/0x110
> > 
> > .....................................................................
> > .....................................................................
> > .........................................................
> > 
> > If we look at the lock stats with SHARED_RUNQ disabled, the rq lock
> > still
> > contends the most, but it's significantly less than with it enabled:
> > 
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > --------------------------------------------------------------
> > class name          con-bounces    contentions   waittime-
> > min   waittime-max waittime-total   waittime-avg    acq-
> > bounces   acquisitions   holdtime-min   holdtime-max holdtime-
> > total   holdtime-avg
> > -------------------------------------------------------------------
> > -------------------------------------------------------------------
> > --------------------------------------------------------------
> > 
> > &rq-
> > >__lock:        791277         791690        0.12           110.54   
> >     4889787.63       6.18            1575996       62390275       0.1
> > 3           112.66       316262440.56     5.07
> > -----------
> > &rq->__lock         263343          [<00000000516703f0>]
> > __schedule+0x72/0xaa0
> > &rq->__lock          19394          [<0000000011be1562>]
> > raw_spin_rq_lock_nested+0xa/0x10
> > &rq->__lock           4143          [<000000003b542e83>]
> > __task_rq_lock+0x51/0xf0
> > &rq->__lock          51094          [<00000000c38a30f9>]
> > sched_ttwu_pending+0x3d/0x170
> > -----------
> > &rq->__lock          23756          [<0000000011be1562>]
> > raw_spin_rq_lock_nested+0xa/0x10
> > &rq->__lock         379048          [<00000000516703f0>]
> > __schedule+0x72/0xaa0
> > &rq->__lock            677          [<000000003b542e83>]
> > __task_rq_lock+0x51/0xf0
> > 
> > Worth noting is that increasing the granularity of the shards in
> > general
> > improves very runqueue-heavy workloads such as netperf UDP_RR and
> > this
> > schbench command, but it doesn't necessarily make a big difference
> > for
> > every workload, or for sufficiently small CCXs such as the 7950X. It
> > may
> > make sense to eventually allow users to control this with a debugfs
> > knob, but for now we'll elect to choose a default that resulted in
> > good
> > performance for the benchmarks run for this patch series.
> > 
> > Conclusion
> > ==========
> > 
> > SHARED_RUNQ in this form provides statistically significant wins for
> > several types of workloads, and various CPU topologies. The reason
> > for
> > this is roughly the same for all workloads: SHARED_RUNQ encourages
> > work
> > conservation inside of a CCX by having a CPU do an O(# per-LLC
> > shards)
> > iteration over the shared_runq shards in an LLC. We could similarly
> > do
> > an O(n) iteration over all of the runqueues in the current LLC when a
> > core is going idle, but that's quite costly (especially for larger
> > LLCs), and sharded SHARED_RUNQ seems to provide a performant middle
> > ground between doing an O(n) walk, and doing an O(1) pull from a
> > single
> > per-LLC shared runq.
> > 
> > For the workloads above, kernel compile and hackbench were clear
> > winners
> > for SHARED_RUNQ (especially in __enqueue_entity()). The reason for
> > the
> > improvement in kernel compile is of course that we have a heavily
> > CPU-bound workload where cache locality doesn't mean much; getting a
> > CPU
> > is the #1 goal. As mentioned above, while I didn't expect to see an
> > improvement in hackbench, the results of the benchmark suggest that
> > minimizing runqueue delays is preferable to optimizing for L1/L2
> > locality.
> > 
> > Not all workloads benefit from SHARED_RUNQ, however. Workloads that
> > hammer the runqueue hard, such as netperf UDP_RR, or schbench -L -m
> > 52
> > -p 512 -r 10 -t 1, tend to run into contention on the shard locks;
> > especially when enqueuing tasks in __enqueue_entity(). This can be
> > mitigated significantly by sharding the shared datastructures within
> > a
> > CCX, but it doesn't eliminate all contention, as described above.
> > 
> > Worth noting as well is that Gautham Shenoy ran some interesting
> > experiments on a few more ideas in [5], such as walking the
> > shared_runq
> > on the pop path until a task is found that can be migrated to the
> > calling CPU. I didn't run those experiments in this patch set, but it
> > might be worth doing so.
> > 
> > [5]: 
> > https://lore.kernel.org/lkml/ZJkqeXkPJMTl49GB@BLR-5CG11610CF.amd.com/
> > 
> > Gautham also ran some other benchmarks in [6], which we may want to
> > again try on this v3, but with boost disabled.
> > 
> > [6]: 
> > https://lore.kernel.org/lkml/ZLpMGVPDXqWEu+gm@BLR-5CG11610CF.amd.com/
> > 
> > Finally, while SHARED_RUNQ in this form encourages work conservation,
> > it
> > of course does not guarantee it given that we don't implement any
> > kind
> > of work stealing between shared_runq's. In the future, we could
> > potentially push CPU utilization even higher by enabling work
> > stealing
> > between shared_runq's, likely between CCXs on the same NUMA node.
> > 
> > Originally-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Signed-off-by: David Vernet <void@manifault.com>
> > 
> > David Vernet (7):
> >   sched: Expose move_queued_task() from core.c
> >   sched: Move is_cpu_allowed() into sched.h
> >   sched: Check cpu_active() earlier in newidle_balance()
> >   sched: Enable sched_feat callbacks on enable/disable
> >   sched/fair: Add SHARED_RUNQ sched feature and skeleton calls
> >   sched: Implement shared runqueue in CFS
> >   sched: Shard per-LLC shared runqueues
> > 
> >  include/linux/sched.h   |   2 +
> >  kernel/sched/core.c     |  52 ++----
> >  kernel/sched/debug.c    |  18 ++-
> >  kernel/sched/fair.c     | 340
> > +++++++++++++++++++++++++++++++++++++++-
> >  kernel/sched/features.h |   1 +
> >  kernel/sched/sched.h    |  56 ++++++-
> >  kernel/sched/topology.c |   4 +-
> >  7 files changed, 420 insertions(+), 53 deletions(-)
> > 
> 
