Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48DF75EC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGXG6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGXG6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:58:16 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEA9E6B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:58:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vo2WTht_1690181877;
Received: from 30.97.48.76(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Vo2WTht_1690181877)
          by smtp.aliyun-inc.com;
          Mon, 24 Jul 2023 14:57:59 +0800
Message-ID: <70494547-a538-baf5-0554-6788ac2b45e8@linux.alibaba.com>
Date:   Mon, 24 Jul 2023 14:57:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   luoben@linux.alibaba.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        pbonzini@redhat.com, mikelley@microsoft.com, yu.c.chen@intel.com,
        "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Adjust CFS loadbalance to adapt QEMU CPU
 topology.
References: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
 <20230720085032.GB3569127@hirez.programming.kicks-ass.net>
 <6a70900a-649f-3a4d-2e47-61648bc95666@linux.alibaba.com>
 <CAKfTPtCmBL6aq9CaPvmhcyvGZtu=98crDyaHXRdwQxjyGtcDkQ@mail.gmail.com>
 <20230721091328.GE3630545@hirez.programming.kicks-ass.net>
In-Reply-To: <20230721091328.GE3630545@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/21 17:13, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Jul 21, 2023 at 10:33:44AM +0200, Vincent Guittot wrote:
> > On Fri, 21 Jul 2023 at 04:59, Kenan.Liu <Kenan.Liu@linux.alibaba.com> wrote:
> 
> >> The SMT topology in qemu native x86 CPU model is (0,1),…,(n,n+1),…,
> >> but nomarlly seen SMT topo in physical machine is like (0,n),(1,n+1),…,
> >> n means the total core number of the machine.
> >>
> >> The imbalance happens when the number of runnable threads is less
> >> than the number of hyperthreads, select_idle_core() would be called
> >> to decide which cpu be selected to run the waken-up task.
> >>
> >> select_idle_core() will return the checked cpu number if the whole
> >> core is idle. On the contrary, if any one HT of the core is busy,
> >> select_idle_core() would clear the whole core out from cpumask and
> >> check the next core.
> >>
> >> select_idle_core():
> >>       …
> >>       if (idle)
> >>           return core;
> >>
> >>       cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> >>       return -1;
> >>
> >> In this manner, except the very beginning of for_each_cpu_wrap() loop,
> >> HT with even ID number is always be checked at first, and be returned
> >> to the caller if the whole core is idle, so the odd indexed HT almost
> >> has no chance to be selected.
> >>
> >> select_idle_cpu():
> >>       …
> >>       for_each_cpu_wrap(cpu, cpus, target + 1) {
> >>           if (has_idle_core) {
> >>               i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>
> >> And this will NOT happen when the SMT topo is (0,n),(1,n+1),…, because
> >> when the loop starts from the bottom half of SMT number, HTs with larger
> >> number will be checked first, when it starts from the top half, their
> >> siblings with smaller number take the first place of inner core searching.
> >
> > But why is it a problem ? Your system is almost idle and 1 HT per core
> > is used. Who cares to select evenly one HT or the other as long as we
> > select an idle core in priority ?
> 
> Right, why is this a problem? Hyperthreads are supposed to be symmetric,
> it doesn't matter which of the two are active, the important thing is to
> only have one active if we can.
> 
> (Unlike Power7, they have asymmetric SMT)
> 

hi Peter and Vincent,

Some upper-level monitoring logic may take the CPU usage as a metric for
computing resource scaling. Imbalanced scheduling can create the illusion
of CPU resource scarcity, leading to more frequent triggering of resource
expansion by the upper-level scheduling system. However, this is actually
a waste of resources. So, we think this may be a problem.

Could you please take a further look at PATCH#2? We found that the default
'nr' value did not perform well under our scenario, and we believe that
adjustable variables would be more appropriate.

Our scenario is as follows:
16 processes are running in a 32 CPU VM, with 8 threads per process,
they are all running the same job. 

The expected result is that the CPU usage is evenly distributed, but
we found that even-numbered cores were used for scheduling decisions
and consumed more CPU resources (5%~20%), mainly because of the default
value of nr=4. In this scenario, we found that nr=2 is more suitable.

Thanks,
Ben
