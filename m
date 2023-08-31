Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6F78E3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344594AbjHaAB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245549AbjHaAB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:01:57 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35715CC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:01:52 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-48fde7dae7dso102863e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693440111; x=1694044911;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2IiBMjfIGjHi4QdQd00uanD/L/RlNyxraz3B5OlXo8=;
        b=eK/F+J6oj0ZMDbFEa9zb7PSLtPYupgAJFY5njlh0luejk9ilImFlVSo4xtBy0554fi
         VaElBfTcD0F0nhc7EiXjmoHtfTWv5bKqngdzSxLVxuPnO6dyViPBuvvRlkIJQUETUjrb
         VTsQ6iE59wiVk8vV9rnSgNdWZpD6XAp3gWlMSwMA1tqBYiAuQMVkyZWq+vtK+BP3HcD4
         2gnj20AC3tVhSaywssHHuI7so+4810eVBN/1zqSonducrLjacNQ5sUmJ9YeE/BbCmTai
         CrA2oDtAA+kugVKwAVCCAkBOP08C2mlqQUSiha14Vjafet6OSuJtoEZ0FEVpyI08uf7j
         9QQg==
X-Gm-Message-State: AOJu0YyxSoMemLFlbXvT8bkXllyZefZjUkmXRvJsKFQdXL4HtXr6DG9+
        E14l+ly5aBcnrcLwSimk13M=
X-Google-Smtp-Source: AGHT+IGmLLGYBd74byiA07/Gh5m5M3c/RpCW9pFjvAuGwV1Q4S8gaoBmO6pFz0oypuUxztu8QDjCdg==
X-Received: by 2002:a67:fd45:0:b0:44d:4dd6:7966 with SMTP id g5-20020a67fd45000000b0044d4dd67966mr3406457vsr.34.1693440111112;
        Wed, 30 Aug 2023 17:01:51 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1c30])
        by smtp.gmail.com with ESMTPSA id b1-20020ac812c1000000b004109fb22216sm74458qtj.79.2023.08.30.17.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 17:01:50 -0700 (PDT)
Date:   Wed, 30 Aug 2023 19:01:47 -0500
From:   David Vernet <void@manifault.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com,
        tim.c.chen@intel.com
Subject: Re: [PATCH v3 7/7] sched: Shard per-LLC shared runqueues
Message-ID: <20230831000147.GA506447@maniforge>
References: <20230809221218.163894-1-void@manifault.com>
 <20230809221218.163894-8-void@manifault.com>
 <ZO7e5YaS71cXVxQN@chenyu5-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO7e5YaS71cXVxQN@chenyu5-mobl2>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 02:17:09PM +0800, Chen Yu wrote:
> Hi David,

Hi Chenyu,

Thank you for running these tests, and for your very in-depth analysis
and explanation of the performance you were observing.

> On 2023-08-09 at 17:12:18 -0500, David Vernet wrote:
> > The SHARED_RUNQ scheduler feature creates a FIFO queue per LLC that
> > tasks are put into on enqueue, and pulled from when a core in that LLC
> > would otherwise go idle. For CPUs with large LLCs, this can sometimes
> > cause significant contention, as illustrated in [0].
> > 
> > [0]: https://lore.kernel.org/all/c8419d9b-2b31-2190-3058-3625bdbcb13d@meta.com/
> > 
> > So as to try and mitigate this contention, we can instead shard the
> > per-LLC runqueue into multiple per-LLC shards.
> > 
> > While this doesn't outright prevent all contention, it does somewhat mitigate it.
> >
>  
> Thanks for this proposal to make idle load balance more efficient. As we
> dicussed previously, I launched hackbench on Intel Sapphire Rapids
> and I have some findings.
> 
> This platform has 2 sockets, each socket has 56C/112T. To avoid the
> run-run variance, only 1 socket is online, the cpufreq govenor is set to
> performance, the turbo is disabled, and C-states deeper than C1 are disabled.
> 
> hackbench
> =========
> case                    load            baseline(std%)  compare%( std%)
> process-pipe            1-groups         1.00 (  1.09)   +0.55 (  0.20)
> process-pipe            2-groups         1.00 (  0.60)   +3.57 (  0.28)
> process-pipe            4-groups         1.00 (  0.30)   +5.22 (  0.26)
> process-pipe            8-groups         1.00 (  0.10)  +43.96 (  0.26)
> process-sockets         1-groups         1.00 (  0.18)   -1.56 (  0.34)
> process-sockets         2-groups         1.00 (  1.06)  -12.37 (  0.11)
> process-sockets         4-groups         1.00 (  0.29)   +0.21 (  0.19)
> process-sockets         8-groups         1.00 (  0.06)   +3.59 (  0.39)
> 
> The 8 groups pipe mode has an impressive improvement, while the 2 groups sockets
> mode did see some regressions.
> 
> The possible reason to cause the regression is at the end of this reply, in
> case you want to see the conclusion directly : )

I read through everything, and it all made sense. I'll reply to your
conclusion below.

> To investigate the regression, I did slight hack on the hackbench, by renaming
> the workload to sender and receiver.
> 
> When it is in 2 groups mode, there would be 2 groups of senders and receivers.
> Each group has 14 senders and 14 receivers. So there are totally 56 tasks running
> on 112 CPUs. In each group, sender_i sends package to receiver_j  ( i, j belong to [1,14] )
> 
> 
> 1. Firstly use 'top' to monitor the CPU utilization:
> 
>    When shared_runqueue is disabled, many CPUs are 100%, while the other
>    CPUs remain 0%.
>    When shared_runqueue is enabled, most CPUs are busy and the utilization is
>    in 40%~60%.
> 
>    This means that shared_runqueue works as expected.
> 
> 2. Then the bpf wakeup latency is monitored:
> 
> tracepoint:sched:sched_wakeup,
> tracepoint:sched:sched_wakeup_new
> {
>         if (args->comm == "sender") {
>                 @qstime[args->pid] = nsecs;
>         }
>         if (args->comm == "receiver") {
>                 @qrtime[args->pid] = nsecs;
>         }
> }
> 
> tracepoint:sched:sched_switch
> {
>         if (args->next_comm == "sender") {
>                 $ns = @qstime[args->next_pid];
>                 if ($ns) {
>                         @sender_wakeup_lat = hist((nsecs - $ns) / 1000);
>                         delete(@qstime[args->next_pid]);
>                 }
>         }
>         if (args->next_comm == "receiver") {
>                 $ns = @qrtime[args->next_pid];
>                 if ($ns) {
>                         @receiver_wakeup_lat = hist((nsecs - $ns) / 1000);
>                         delete(@qstime[args->next_pid]);
>                 }
>         }
> }
> 
> 
> It shows that, the wakeup latency of the receiver has been increased a little
> bit. But consider that this symptom is the same when the hackbench is in pipe mode,
> and there is no regression in pipe mode, the wakeup latency overhead might not be
> the cause of the regression.
> 
> 3. Then FlameGraph is used to compare the bottleneck.
> There is still no obvious difference noticed. One obvious bottleneck is the atomic
> write to a memory cgroup page count(and runqueue lock contention is not observed).
> The backtrace:
> 
> obj_cgroup_charge_pages;obj_cgroup_charge;__kmem_cache_alloc_node;
> __kmalloc_node_track_caller;kmalloc_reserve;__alloc_skb;
> alloc_skb_with_frags;sock_alloc_send_pskb;unix_stream_sendmsg
> 
> However there is no obvious ratio difference between with/without shared runqueue
> enabled. So this one might not be the cause.
> 
> 4. Check the wakeup task migration count
> 
> Borrow the script from Aaron:
> kretfunc:select_task_rq_fair
> {
>         $p = (struct task_struct *)args->p;
>         if ($p->comm == "sender") {
>                 if ($p->thread_info.cpu != retval) {
>                         @wakeup_migrate_sender = count();
>                 } else {
>                         @wakeup_prev_sender = count();
>                 }
>         }
>         if ($p->comm == "receiver") {
>                 if ($p->thread_info.cpu != retval) {
>                         @wakeup_migrate_receiver = count();
>                 } else {
>                         @wakeup_prev_receiver = count();
>                 }
>         }
> }
> 
> Without shared_runqueue enabled, the wakee task are mostly woken up on it
> previous running CPUs.
> With shared_runqueue disabled, the wakee task are mostly woken up on a
> completely different idle CPUs.
> 
> This reminds me that, is it possible the regression was caused by the broken
> cache locallity?
> 
> 
> 5. Check the L2 cache miss rate.
> perf stat -e l2_rqsts.references,l2_request.miss sleep 10
> The results show that the L2 cache miss rate is nearly the same with/without
> shared_runqueue enabled.

As mentioned below, I expect it would be interesting to also collect
icache / iTLB numbers. In my experience, poor uop cache locality will
also result in poor icache locality, though of course that depends on a
lot of other factors like alignment, how many (un)conditional branches
you have within some byte window, etc. If alignment, etc were the issue
though, we'd likely observe this also without SHARED_RUNQ.

> I did not check the L3 miss rate, because:
>    3.1 there is only 1 socket of CPUs online
>    3.2 the working set the hackbench is 56 * 100 * 300000, which is nearly
>        the same as LLC cache size.
> 
> 6. As mentioned in step 3, the bottleneck is a atomic write to a global
>    variable. Then use perf c2c to check if there is any false/true sharing.
> 
>    According to the result, the total number and average cycles of local HITM
>    is low.So this might indicate that this is not a false sharing or true
>    sharing issue.
> 
> 
> 7. Then use perf topdown to dig into the detail. The methodology is at
>    https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
> 
> 
>    When shared runqueue is disabled:
> 
>     #     65.2 %  tma_backend_bound
>     #      2.9 %  tma_bad_speculation
>     #     13.1 %  tma_frontend_bound
>     #     18.7 %  tma_retiring
> 
> 
> 
>    When shared runqueue is enabled:
> 
>     #     52.4 %  tma_backend_bound
>     #      3.3 %  tma_bad_speculation
>     #     20.5 %  tma_frontend_bound
>     #     23.8 %  tma_retiring
>     
> 
> We can see that, the ratio of frontend_bound has increased from 13.1% to
> 20.5%.  As a comparison, this ratio does not increase when the hackbench
> is in pipe mode.
> 
> Then further dig into the deeper level of frontend_bound:
> 
> When shared runqueue is disabled:
> #      6.9 %  tma_fetch_latency   ---->  #      7.3 %  tma_ms_switches
>                                   |
>                                   ---->  #      7.1 %  tma_dsb_switches
> 
> 
> When shared runqueue is enabled:
> #     11.6 %  tma_fetch_latency   ----> #      6.7 %  tma_ms_switches
>                                   |
>                                   ----> #      7.8 %  tma_dsb_switches
> 
> 
> 1. The DSB(Decode Stream Buffer) switches count increases
>    from 13.1% * 6.9% * 7.1% to 20.5% * 11.6% * 7.8%

Indeed, these switches are quite costly from what I understand.

> 2. The MS(Microcode Sequencer) switches count increases
>    from 13.1% * 6.9% * 7.3% to 20.5% * 11.6% * 6.7%
> 
> DSB is the cached decoded uops, which is similar to L1 icache,
> except that icache has the original instructions, while DSB has the
> decoded one. DSB reflects the instruction footprint. The increase
> of DSB switches mean that, the cached buffer has been thrashed a lot.
> 
> MS is to decode the complex instructions, the increase of MS switch counter
> usually means that the workload is running some complex instruction.
> that the workload is running complex instructions.
> 
> In summary:
> 
> So the scenario to cause this issue I'm thinking of is:
> Task migration increases the DSB switches count. With shared_runqueue enabled,
> the task could be migrated to different CPUs more offen. And it has to fill its
> new uops into the DSB, but that DSB has already been filled by the old task's
> uops. So DSB switches is triggered to decode the new macro ops. This is usually
> not a problem if the workload runs some simple instructions. However if
> this workload's instruction footprint increases, task migration might break
> the DSB uops locality, which is similar to L1/L2 cache locality.

Interesting. As mentioned above, I expect we also see an increase in
iTLB and icache misses?

This is something we deal with in HHVM. Like any other JIT engine /
compiler, it is heavily front-end CPU bound, and has very poor icache,
iTLB, and uop cache locality (also lots of branch resteers, etc).
SHARED_RUNQ actually helps this workload quite a lot, as explained in
the cover letter for the patch series. It makes sense that it would: uop
locality is really bad even without increasing CPU util. So we have no
reason not to migrate the task and hop on a CPU.

> I wonder, if SHARED_RUNQ can consider that, if a task is a long duration one,
> say, p->avg_runtime >= sysctl_migration_cost, maybe we should not put such task
> on the per-LLC shared runqueue? In this way it will not be migrated too offen
> so as to keep its locality(both in terms of L1/L2 cache and DSB).

I'm hesitant to apply such heuristics to the feature. As mentioned
above, SHARED_RUNQ works very well on HHVM, despite its potential hit to
icache / iTLB / DSB locality. Those hhvmworker tasks run for a very long
time, sometimes upwards of 20+ms. They also tend to have poor L1 cache
locality in general even when they're scheduled on the same core they
were on before they were descheduled, so we observe better performance
if the task is migrated to a fully idle core rather than e.g. its
hypertwin if it's available. That's not something we can guarantee with
SHARED_RUNQ, but it hopefully illustrates the point that it's an example
of a workload that would suffer with such a heuristic.

Another point to consider is that performance implications that are a
result of Intel micro architectural details don't necessarily apply to
everyone. I'm not as familiar with the instruction decode pipeline on
AMD chips like Zen4. I'm sure they have a uop cache, but the size of
that cache, alignment requirements, the way that cache interfaces with
e.g. their version of the MITE / decoder, etc, are all going to be quite
different.

In general, I think it's difficult for heuristics like this to suit all
possible workloads or situations (not that you're claiming it is). My
preference is to keep it as is so that it's easier for users to build a
mental model of what outcome they should expect if they use the feature.
Put another way: As a user of this feature, I'd be a lot more surprised
to see that I enabled it and CPU util stayed low, vs. enabling it and
seeing higher CPU util, but also degraded icache / iTLB locality.

Let me know what you think, and thanks again for investing your time
into this.

Thanks,
David
