Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013BB78054A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357950AbjHRFEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357949AbjHRFED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:04:03 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F1C35BD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:04:00 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-40ffb4476d8so3691801cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692335039; x=1692939839;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTJ52vvP7sru4Yfbn5BBG780IvtHDjCdGIGNJ2RnbKc=;
        b=O+PSSm9FEzlLQeDH2i1z3I/nTPQMsdg1KHsJQi06BFmwDrKp60fC5e7RBczW2sH4J7
         Dds5pdfuVlAbcJDYiwbpPK0wgNG3FzyJHdgdrjWNsqx3n786D0wiE20nvsZlp6uKLKjZ
         gjPBEs4RxahDE5Nedx5/AlU0021adwAkE34bWVo1DxtrkvC50+1m3OS3tDUe+xi6vIow
         BuAEb7/tDBaH78CpkD9Sf9ZWGewRsC+w91sDM8COpsxqwx4N672Mb7LU8rxmAqqdd6cx
         xV+GfSm8vKCLrqxgWHD0kBbJOkxCwhICVxg2oZF9Gb//6lcK0vCkRXDOKdyRja9QZMDy
         Wezw==
X-Gm-Message-State: AOJu0YxnrYJzrn71LWgGGNgVjw1oE1dx5Jkrmy2yE62rRqfCVLsah7ey
        fltWxz/X1lquvUu0TVCjwDc=
X-Google-Smtp-Source: AGHT+IEMWGT88peyUCMv/RSW17WfsRvRp1IVBQpBNY0IlmDbELEReTjjZCPS+mwB59SXWRRBiU++BA==
X-Received: by 2002:a05:622a:60b:b0:410:2b87:7e6a with SMTP id z11-20020a05622a060b00b004102b877e6amr2231172qta.35.1692335039142;
        Thu, 17 Aug 2023 22:03:59 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:7a9a])
        by smtp.gmail.com with ESMTPSA id ih14-20020a05622a6a8e00b00400a99b8b38sm305504qtb.78.2023.08.17.22.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 22:03:58 -0700 (PDT)
Date:   Fri, 18 Aug 2023 00:03:55 -0500
From:   David Vernet <void@manifault.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, kprateek.nayak@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [PATCH v3 0/7] sched: Implement shared runqueue in CFS
Message-ID: <20230818050355.GA5718@maniforge>
References: <20230809221218.163894-1-void@manifault.com>
 <ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:12:03PM +0530, Gautham R. Shenoy wrote:
> Hello David,

Hello Gautham,

Thanks a lot as always for running some benchmarks and analyzing these
changes.

> On Wed, Aug 09, 2023 at 05:12:11PM -0500, David Vernet wrote:
> > Changes
> > -------
> > 
> > This is v3 of the shared runqueue patchset. This patch set is based off
> > of commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
> > bandwidth in use") on the sched/core branch of tip.git.
> 
> 
> I tested the patches on Zen3 and Zen4 EPYC Servers like last time. I
> notice that apart from hackbench, every other bechmark is showing
> regressions with this patch series. Quick summary of my observations:

Just to verify per our prior conversation [0], was this latest set of
benchmarks run with boost disabled? Your analysis below seems to
indicate pretty clearly that v3 regresses some workloads regardless of
boost, but I did just want to double check regardless just to bear it in
mind when looking over the results.

[0]: https://lore.kernel.org/all/ZMn4dLePB45M5CGa@BLR-5CG11610CF.amd.com/

> * With shared-runqueue enabled, tbench and netperf both stop scaling
>   when we go beyond 32 clients and the scaling issue persists until
>   the system is overutilized. When the system is overutilized,
>   shared-runqueue is able to recover quite splendidly and outperform
>   tip.

Hmm, I still don't understand why we perform better when the system is
overutilized. I'd expect vanilla CFS to perform better than shared_runq
in such a scenario in general, as the system will be fully utilized
regardless.

> * stream doesn't show any significant difference with the
>   shared-runqueue as expected.
> 
> * schbench shows no major regressions for the requests-per-second and
>   the request-latency until the system is completely saturated at
>   which point, I do see some improvements with the shared
>   runqueue. However, the wakeup-latency is bad when the system is
>   moderately utilized.
> 
> * mongodb shows 3.5% regression with shared runqueue enabled.

This is indeed surprising. I think I have a theory, as described below.

> 
> Please find the detailed results at the end of this mail.
> 
> Scalability for tbench and netperf
> ==================================
> I want to call out the reason for the scaling issues observed with
> tbench and netperf when the number of clients are between 32 to 256. I
> will use tbench here to illustrate the analysis.
> 
> As I had mentioned, in my response to Aaron's RFC,
> (https://lore.kernel.org/lkml/20230816024831.682107-2-aaron.lu@intel.com/#t)
> in the aforementioned cases, I could observe a bottleneck with
> update_cfs_group() and update_load_avg() which is due to the fact that
> we do a lot more task migrations when the shared runqueue is enabled.
> 
>   Overhead  Command  Shared Object     Symbol
> +   20.54%  tbench   [kernel.vmlinux]  [k] update_cfs_group
> +   15.78%  tbench   [kernel.vmlinux]  [k] update_load_avg
> 
> Applying Aaron's ratelimiting patch helps improve the
> scalability. Previously the throughput values for 32 clients, 64
> clients, 128 clients and 256 clients were very close to each other but
> with Aaron's patch, that improved. However, the regression still
> persisted.
> 
> ==================================================================
> Test          : tbench 
> Units         : Normalized throughput 
> Interpretation: Higher is better 
> Statistic     : AMean 
> ==================================================================
> Clients:  tip[pct imp](CV)       sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
>    32     1.00 [  0.00]( 2.90)     0.44 [-55.53]( 1.44)     0.98 [ -2.23]( 1.72)
>    64     1.00 [  0.00]( 1.02)     0.27 [-72.58]( 0.35)     0.74 [-25.64]( 2.43)
>   128     1.00 [  0.00]( 0.88)     0.19 [-81.29]( 0.51)     0.52 [-48.47]( 3.92)
>   256     1.00 [  0.00]( 0.28)     0.17 [-82.80]( 0.29)     0.88 [-12.23]( 1.76)

Just to make sure we're on the same page, "CV" here is the coefficient
of variation (i.e. standard deviation / mean), correct?

> With Aaron's fix, perf showed that there were a lot of samples for
> update_sd_lb_stats().
> 
> Samples: 8M of event 'ibs_op//', Event count (approx.): 28860989545448
>   Overhead  Command  Shared Object         Symbol
> -   13.00%  tbench   [kernel.vmlinux]      [k] update_sd_lb_stats.constprop.0
>    - 7.21% update_sd_lb_stats.constprop.0                                    
>       - 7.21% find_busiest_group                                                
>            load_balance                                                         
>          - newidle_balance                                                      
>             + 5.90% pick_next_task_fair                                         
>             + 1.31% balance_fair                                                
>    - 3.05% cpu_util                                                             
>       - 2.63% update_sd_lb_stats.constprop.0                                    
>            find_busiest_group                                                   
>            load_balance                                                         
>          + newidle_balance                                                      
>    - 1.67% idle_cpu                                                             
>       - 1.36% update_sd_lb_stats.constprop.0                                    
>            find_busiest_group                                                   
>            load_balance                                                         
>          - newidle_balance                                                      
>             + 1.11% pick_next_task_fair   
> 
> perf annotate shows the hotspot to be a harmless looking "add"
> instruction update_sg_lb_stats() which adds a value obtained from
> cfs_rq->avg.load_avg to sg->group_load.
> 
>        │     cfs_rq_load_avg():
>        │     return cfs_rq->avg.load_avg;
>   0.31 │       mov    0x220(%r8),%rax
>        │     update_sg_lb_stats():
>        │     sgs->group_load += load;
>  15.90 │       add    %rax,0x8(%r13)
>        │     cfs_rq_load_avg():
>        │     return cfs_rq->avg.load_avg;
> 
> So, I counted the number of times the CPUs call find_busiest_group()
> without and with shared_rq and the distribution is quite stark.
> 
> =====================================================
> per-cpu             :          Number of CPUs       :
> find_busiest_group  :----------------:--------------:
> count               :  without-sh.rq :  with-sh.rq  :
> =====================================:===============
> [      0 -  200000) :     77
> [ 200000 -  400000) :     41
> [ 400000 -  600000) :     64
> [ 600000 -  800000) :     63
> [ 800000 - 1000000) :     66
> [1000000 - 1200000) :     69
> [1200000 - 1400000) :     52
> [1400000 - 1600000) :     34              5
> [1600000 - 1800000) :     17		 31
> [1800000 - 2000000) :      6		 59
> [2000000 - 2200000) :     13		109
> [2200000 - 2400000) :      4		120
> [2400000 - 2600000) :      3		157
> [2600000 - 2800000) :      1		 29
> [2800000 - 3000000) :      1		  2
> [9200000 - 9400000) :      1
> 
> As you can notice, the number of calls to find_busiest_group() without
> the shared.rq is greater at the lower end of distribution, which
> implies fewer calls in total. With shared-rq enabled, the distribution
> is normal, but shifted to the right, which implies a lot more calls to
> find_busiest_group().

Huh, that's very much unexpected for obvious reasons -- we should be
hitting the load_balance() path _less_ due to scheduling tasks with the
shared_runq.

> To investigate further, where this is coming from, I reran tbench with
> sched-scoreboard (https://github.com/AMDESE/sched-scoreboard), and the
> schedstats shows the the total wait-time of the tasks on the runqueue
> *increases* by a significant amount when shared-rq is enabled.
> 
> Further, if you notice the newidle load_balance() attempts at the DIE
> and the NUMA domains, they are significantly higher when shared-rq is
> enabled. So it appears that a lot more time is being spent trying to
> do load-balancing when shared runqueue is enabled, which is counter
> intutitive.

Certainly agreed on it being counter intuitive. I wonder if this is due
to this change in the latest v3 revision [1]:

@@ -12093,6 +12308,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
+	/*
+	 * Skip <= LLC domains as they likely won't have any tasks if the
+	 * shared runq is empty.
+	 */
+	if (sched_feat(SHARED_RUNQ)) {
+		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
+		if (likely(sd))
+			sd = sd->parent;
+	}
+
 	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {

[1]: https://lore.kernel.org/all/20230809221218.163894-7-void@manifault.com/

I originally added this following Peter's suggestion in v2 [2] with the
idea that we'd skip the <= LLC domains when shared_runq is enabled, but
in hindsight, we also aren't walking the shared_runq list until we find
a task that can run on the current core. If there's a task, and it can't
run on the current core, we give up and proceed to the rest of
newidle_balance(). So it's possible that we're incorrectly assuming
there's no task in the current LLC because it wasn't enqueued at the
head of the shared_runq. I think we'd only want to add this improvement
if we walked the list as you tried in v1 of the patch set, or revert it
otherwise.

[2]: https://lore.kernel.org/lkml/20230711094547.GE3062772@hirez.programming.kicks-ass.net/

Would you be able to try running your benchmarks again with that change
removed, or with your original idea of walking the list added? I've
tried to reproduce this issue on my 7950x, as well as a single-socket /
CCX 26 core / 52 thread Cooper Lake host, but have been unable to. For
example, if I run funccount.py 'load_balance' -d 30 (from [3]) while
running the below netperf command on the Cooper Lake, this is what I
see:

for i in `seq 128`; do netperf -6 -t UDP_RR -c -C -l 60 & done

NO_SHARED_RUNQ
--------------
FUNC                                    COUNT
b'load_balance'                         39636


SHARED_RUNQ
-----------
FUNC                                    COUNT
b'load_balance'                         32345

[3]: https://github.com/iovisor/bcc/blob/master/tools/funccount.py

The stack traces also don't show us running load_balance() excessively.
Please feel free to share how you're running tbench as well and I can
try that on my end.

> ----------------------------------------------------------------------------------------------------
> Time elapsed (in jiffies)                                  :         39133,        39132           
> ----------------------------------------------------------------------------------------------------
> cpu:  all_cpus (avg) vs cpu:  all_cpus (avg)
> ----------------------------------------------------------------------------------------------------
> sched_yield count                                          :             0,            0           
> Legacy counter can be ignored                              :             0,            0           
> schedule called                                            :       9112673,      5014567  | -44.97|
> schedule left the processor idle                           :       4554145,      2460379  | -45.97|
> try_to_wake_up was called                                  :       4556347,      2552974  | -43.97|
> try_to_wake_up was called to wake up the local cpu         :          2227,         1350  | -39.38| 
> total runtime by tasks on this processor (in ns)           :   41093465125,  33816591424  | -17.71|
> total waittime by tasks on this processor (in ns)          :      21832848,   3382037232  |15390.59| <======
> total timeslices run on this cpu                           :       4558524,      2554181  | -43.97|
> 
> ----------------------------------------------------------------------------------------------------
> domain:  SMT (NO_SHARED_RUNQ vs SHARED_RUNQ)
> ----------------------------------------------------------------------------------------------------
> < ----------------------------------------  Category:  newidle ---------------------------------------- >
> load_balance count on cpu newly idle                       :        964585,       619463  | -35.78|
> load_balance found balanced on cpu newly idle              :        964573,       619303  | -35.80|
>   ->load_balance failed to find bsy q on cpu newly idle    :             0,            0           
>   ->load_balance failed to find bsy grp on cpu newly idle  :        964423,       617603  | -35.96|
> load_balance move task failed on cpu newly idle            :             5,          110  |2100.00|
> *load_balance success cnt on cpu newidle                   :             7,           50  | 614.29|
> pull_task count on cpu newly idle                          :             6,           48  | 700.00|
> *avg task pulled per successfull lb attempt (cpu newidle)  :       0.85714,      0.96000  |  12.00|
>   ->pull_task whn target task was cache-hot on cpu newidle :             0,            0           
> 
> ----------------------------------------------------------------------------------------------------
> domain:  MC (NO_SHARED_RUNQ vs SHARED_RUNQ)
> ----------------------------------------------------------------------------------------------------
> < ----------------------------------------  Category:  newidle ---------------------------------------- >
> load_balance count on cpu newly idle                       :        803080,       615613  | -23.34|
> load_balance found balanced on cpu newly idle              :        641630,       568818  | -11.35|
>   ->load_balance failed to find bsy q on cpu newly idle    :           178,          616  | 246.07|
>   ->load_balance failed to find bsy grp on cpu newly idle  :        641446,       568082  | -11.44|
> load_balance move task failed on cpu newly idle            :        161448,        46296  | -71.32|
> *load_balance success cnt on cpu newidle                   :             2,          499  |24850.00|
> pull_task count on cpu newly idle                          :             1,          498  |49700.00|
> *avg task pulled per successfull lb attempt (cpu newidle)  :       0.50000,      0.99800  |  99.60|
>   ->pull_task whn target task was cache-hot on cpu newidle :             0,            0           
> 
> ----------------------------------------------------------------------------------------------------
> domain:  DIE cpus = all_cpus (avg) vs domain:  DIE cpus = all_cpus (avg)
> ----------------------------------------------------------------------------------------------------
> < ----------------------------------------  Category:  newidle ---------------------------------------- >
> load_balance count on cpu newly idle                       :          2761,       566824  |20429.66| <======
> load_balance found balanced on cpu newly idle              :          1737,       284232  |16263.39|
>   ->load_balance failed to find bsy q on cpu newly idle    :             0,          537            
>   ->load_balance failed to find bsy grp on cpu newly idle  :          1736,       283427  |16226.44|
> load_balance move task failed on cpu newly idle            :          1023,       282021  |27468.04|
> *load_balance success cnt on cpu newidle                   :             1,          571  |57000.00|
> pull_task count on cpu newly idle                          :             0,          571           
> *avg task pulled per successfull lb attempt (cpu newidle)  :             0,            1           
>   ->pull_task whn target task was cache-hot on cpu newidle :             0,            0           
> 
> ----------------------------------------------------------------------------------------------------
> domain:  NUMA cpus = all_cpus (avg) vs domain:  NUMA cpus = all_cpus (avg)
> ----------------------------------------------------------------------------------------------------
> < ----------------------------------------  Category:  newidle ---------------------------------------- >
> load_balance count on cpu newly idle                       :            38,        47936  |126047.37| <======
> load_balance found balanced on cpu newly idle              :            20,        26628  |133040.00|
>   ->load_balance failed to find bsy q on cpu newly idle    :             0,            0             
>   ->load_balance failed to find bsy grp on cpu newly idle  :            20,        26531  |132555.00|
> load_balance move task failed on cpu newly idle            :            18,        21167  |117494.44|
> *load_balance success cnt on cpu newidle                   :             0,          141             
> pull_task count on cpu newly idle                          :             0,          140           
> *avg task pulled per successfull lb attempt (cpu newidle)  :             0,      0.99291           
>   ->pull_task whn target task was cache-hot on cpu newidle :             0,            0           
> 
> < ----------------------------------------  Wakeup info:  ---------------------------------------- >
> Wakeups on same                          CPU (avg)      :          2227,         1350  | -39.38|
> Wakeups on same         SMT cpus = all_cpus (avg)       :         85553,        30942  | -63.83|
> Wakeups on same         MC cpus = all_cpus (avg)        :       4468548,      2520585  | -43.59|
> Wakeups on same         DIE cpus = all_cpus (avg)       :             9,           60  | 566.67|
> Wakeups on same         NUMA cpus = all_cpus (avg)      :             8,           35  | 337.50|
> 
> Affine wakeups on same  SMT cpus = all_cpus (avg)       :         85484,        18848  | -77.95|
> Affine wakeups on same  MC cpus = all_cpus (avg)        :       4465108,      1511225  | -66.15| <======
> Affine wakeups on same  DIE cpus = all_cpus (avg)       :             1,          569  |56800.00:
> Affine wakeups on same  NUMA cpus = all_cpus (avg)      :             0,          140           
> 
> 
> 
> Detailed Results are as follows:
> =============================================================
> Test Machine : 2 Socket Zen4 with 128 cores per socket, SMT enabled.
> 
> tip                 : commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
>                       bandwidth in use")
> sh_rq_v3            : This patchset with SHARED_RUNQ feature enabled.
> 
> sh_rq_v3_tgload_fix : This patchset along with Aaron's patch
>                       (https://lore.kernel.org/lkml/20230816024831.682107-2-aaron.lu@intel.com/)
> 
> The trend is similar on a 2 Socket Zen3 with 64 cores per socket, SMT
> enabled. So, I am ommitting it.
> 
> ==================================================================
> Test          : hackbench 
> Units         : Normalized time in seconds 
> Interpretation: Lower is better 
> Statistic     : AMean 
> ==================================================================
> Case:        tip[pct imp](CV)        sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
>  1-groups     1.00 [  0.00]( 8.41)     0.96 [  3.63]( 6.04)     0.94 [  6.48]( 9.16)
>  2-groups     1.00 [  0.00](12.96)     0.96 [  4.46]( 9.76)     0.89 [ 11.02]( 8.28)
>  4-groups     1.00 [  0.00]( 2.90)     0.85 [ 14.77]( 9.18)     0.86 [ 14.35](13.26)
>  8-groups     1.00 [  0.00]( 1.06)     0.91 [  8.96]( 2.83)     0.94 [  6.34]( 2.02)
> 16-groups     1.00 [  0.00]( 0.57)     1.19 [-18.91]( 2.82)     0.74 [ 26.02]( 1.33)

Nice, this matches what I observed when running my benchmarks as well.

> ==================================================================
> Test          : tbench 
> Units         : Normalized throughput 
> Interpretation: Higher is better 
> Statistic     : AMean 
> ==================================================================
> Clients:   tip[pct imp](CV)      sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
>     1     1.00 [  0.00]( 0.26)     0.99 [ -1.25]( 0.13)     0.98 [ -2.15]( 0.49)
>     2     1.00 [  0.00]( 0.37)     0.98 [ -2.33]( 0.88)     0.98 [ -2.21]( 0.53)
>     4     1.00 [  0.00]( 0.66)     0.99 [ -1.32]( 0.91)     0.98 [ -2.12]( 0.79)
>     8     1.00 [  0.00]( 2.14)     0.99 [ -0.53]( 2.45)     1.00 [ -0.23]( 2.18)
>    16     1.00 [  0.00]( 1.08)     0.97 [ -3.37]( 2.12)     0.95 [ -5.28]( 1.92)
>    32     1.00 [  0.00]( 2.90)     0.44 [-55.53]( 1.44)     0.98 [ -2.23]( 1.72)
>    64     1.00 [  0.00]( 1.02)     0.27 [-72.58]( 0.35)     0.74 [-25.64]( 2.43)
>   128     1.00 [  0.00]( 0.88)     0.19 [-81.29]( 0.51)     0.52 [-48.47]( 3.92)
>   256     1.00 [  0.00]( 0.28)     0.17 [-82.80]( 0.29)     0.88 [-12.23]( 1.76)
>   512     1.00 [  0.00]( 2.78)     1.33 [ 33.50]( 4.12)     1.22 [ 22.33]( 2.59)
>  1024     1.00 [  0.00]( 0.46)     1.34 [ 34.27]( 0.37)     1.31 [ 31.36]( 1.65)
>  2048     1.00 [  0.00]( 0.75)     1.40 [ 40.42]( 0.05)     1.20 [ 20.09]( 1.98)
> 
> 
> ==================================================================
> Test          : stream (10 Runs)
> Units         : Normalized Bandwidth, MB/s 
> Interpretation: Higher is better 
> Statistic     : HMean 
> ==================================================================
> Test:     tip[pct imp](CV)      sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
>  Copy     1.00 [  0.00]( 0.84)     1.00 [ -0.22]( 0.59)     1.00 [  0.08]( 0.90)
> Scale     1.00 [  0.00]( 0.42)     1.00 [ -0.33]( 0.39)     1.00 [ -0.15]( 0.42)
>   Add     1.00 [  0.00]( 0.58)     1.00 [ -0.48]( 0.28)     1.00 [ -0.22]( 0.34)
> Triad     1.00 [  0.00]( 0.41)     0.99 [ -0.65]( 0.38)     1.00 [ -0.29]( 0.34)
> 
> 
> ==================================================================
> Test          : stream (100 runs)
> Units         : Normalized Bandwidth, MB/s 
> Interpretation: Higher is better 
> Statistic     : HMean 
> ==================================================================
> Test:     tip[pct imp](CV)       sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
>  Copy     1.00 [  0.00]( 0.52)     1.00 [ -0.16]( 0.45)     1.00 [  0.35]( 0.73)
> Scale     1.00 [  0.00]( 0.35)     1.00 [ -0.20]( 0.38)     1.00 [  0.07]( 0.34)
>   Add     1.00 [  0.00]( 0.37)     1.00 [ -0.07]( 0.42)     1.00 [  0.07]( 0.46)
> Triad     1.00 [  0.00]( 0.57)     1.00 [ -0.22]( 0.45)     1.00 [ -0.04]( 0.49)
> 
> 
> ==================================================================
> Test          : netperf 

Could you please share exactly how you're invoking netperf? Is this
with -t UDP_RR (which is what Aaron was running with), or the default?

[...]

As far as I can tell there weren't many changes between v2 and v3 that
could have caused this regression. I strongly suspect the heuristic I
mentioned above, especially with your analysis on us excessively calling
load_balance().

Thanks,
David
