Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A423A75EA44
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGXDud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXDua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:50:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D9483;
        Sun, 23 Jul 2023 20:50:27 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R8R3V26V0zVjfm;
        Mon, 24 Jul 2023 11:48:54 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 11:50:23 +0800
Date:   Mon, 24 Jul 2023 11:50:06 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Ian Rogers <irogers@google.com>
CC:     Changbin Du <changbin.du@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: add new option '--workload-attr' to set workload
 sched_policy/priority/mask
Message-ID: <20230724035006.5vje3jzhmedyljas@M910t>
References: <20230713085831.395112-1-changbin.du@huawei.com>
 <b1127b63-6c6a-e42e-ce6c-cf4f24bbc5a1@intel.com>
 <20230714071914.3jro4kfcvhun2ptd@M910t>
 <CAP-5=fV49y9y8Q3-3rhACMQJiQ+nAh0RfysT8bhpJ5_AOqLScw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV49y9y8Q3-3rhACMQJiQ+nAh0RfysT8bhpJ5_AOqLScw@mail.gmail.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:55:39AM -0700, Ian Rogers wrote:
> On Fri, Jul 14, 2023 at 12:19 AM Changbin Du <changbin.du@huawei.com> wrote:
> >
> > On Fri, Jul 14, 2023 at 10:06:31AM +0300, Adrian Hunter wrote:
> > > On 13/07/23 11:58, Changbin Du wrote:
> > > > To get consistent benchmarking results, sometimes we need to set the
> > > > sched_policy/priority/mask of the workload to reduce system noise.
> > > >
> > > > For example, CPU binding is required on big.little system.
> > > >
> > > >   $ perf stat -r 10 -- taskset -c 0 ls
> > > >
> > > > Nevertheless, the 'taskset' is also counted here.
> > > >
> > > > To get away of the middleman, this adds a new option '--workload-attr' to
> > > > do the same jobs for stat and record commands.
> > > >
> > > >   $ sudo perf stat --workload-attr fifo,40,0x1 -- ls
> > > >
> > > > Above will make 'ls' run on CPU #0 with fifo scheduler and realtime
> > > > priority is 40.
> > >
> > > Aren't there ways to set up a process then start perf using -p <pid>
> > > then let the process continue.
> > >
> > By that you need a mechanism to pause the new spawnned process and wait perf to
> > attach. Or setup the sched properties by the app itself. But sometimes we just
> > simply want to run the app through and measure some events. With
> > --workload-attr, we do not need extra setup works.
> 
> To my naive eyes this looks to be a broadly useful addition. Some thoughts:
>  - "cpu-mask" as the command line argument name, this is "-C" and
> "--cpu" elsewhere, so perhaps just "cpu" as the mask is perhaps
> confusing.
I changed the name of third field to cpu-list, and use perf_cpu_map_new() to
parse the list. This api doesn't accept a mask.

        --workload-attr <sched_policy[,priority][,cpu-list]>
                          setup target workload (the <command>) attributes:

                                sched_policy: other|fifo|rr|batch|idle
                                priority: scheduling priority for fifo|rr, nice value for other
                                cpu-list: CPU affinity. e.g. 1-2:4 is processors #1, #2, and #4

>  - could we get a test? Perhaps add a case to tools/perf/tests/shell/stat.sh:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/stat.sh?h=perf-tools-next
> 
No problem, I will add a testcase there.

> Thanks,
> Ian
> 
> > --
> > Cheers,
> > Changbin Du

-- 
Cheers,
Changbin Du
