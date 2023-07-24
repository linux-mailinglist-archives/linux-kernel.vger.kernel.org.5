Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0711475EA51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 06:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjGXECx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 00:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGXECw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 00:02:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BBDB0;
        Sun, 23 Jul 2023 21:02:50 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R8RJb52YwzHqc0;
        Mon, 24 Jul 2023 12:00:15 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 12:02:47 +0800
Date:   Mon, 24 Jul 2023 12:02:29 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     Changbin Du <changbin.du@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH v3 0/3] perf: add new option '--workload-attr' to set
 workload sched_policy/priority/mask
Message-ID: <20230724040229.eipq7i43v4xcrq3p@M910t>
References: <20230718033355.2960912-1-changbin.du@huawei.com>
 <5889e93b-5ee3-8d59-c2fb-bce7070a1ab2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5889e93b-5ee3-8d59-c2fb-bce7070a1ab2@intel.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 01:00:58PM +0300, Adrian Hunter wrote:
> On 18/07/23 06:33, Changbin Du wrote:
> > This adds a new option '--workload-attr' to set the sched_policy/priority/mask
> > of the workload to reduce system noise.
> > 
> > $ sudo perf stat --workload-attr fifo,40,0-3:7 -- ls
> 
> Not really sold on the need for this, but maybe it could be
> simpler.
> What about just adding a hook for a command (e.g. script) to
> run before exec'ing the workload e.g.
> 
> --configure-workload=blah.sh
> 
> results in perf doing system("blah.sh 12345") where 12345
> is the workload PID.
> 
> Then maybe you could do:
> 
> --configure-workload="taskset -p 0x3"
>
Acctually, we already have such option for perf-stat.

	--post <command>  command to run after to the measured command
        --pre <command>   command to run prior to the measured command

By involving a shell script we can do more complex setup. But sometimes I just
need to set sched attributes. For example, to investigate the impact of
various compiler optimizations. In this case, I don't want a script. This is the
original purpose I try to add this new option.

> 
> > 
> > Please see patch 1/2 for more details.
> > 
> > v3:
> >   - replace taskset with --workload-attr option in documents and tests.
> > v2:
> >   - Use cpu list spec instead of cpu mask number.
> >   - Update documents.
> > 
> > Changbin Du (3):
> >   perf cpumap: Add __perf_cpu_map__new and perf_cpu_map__2_cpuset
> >   perf: add new option '--workload-attr' to set workload
> >     sched_policy/priority/mask
> >   perf: replace taskset with --workload-attr option
> > 
> >  tools/lib/perf/cpumap.c                       |  45 ++++++-
> >  tools/lib/perf/include/perf/cpumap.h          |   4 +
> >  tools/lib/perf/libperf.map                    |   2 +
> >  tools/perf/Documentation/intel-hybrid.txt     |   2 +-
> >  tools/perf/Documentation/perf-record.txt      |   7 ++
> >  tools/perf/Documentation/perf-stat.txt        |   8 +-
> >  tools/perf/builtin-record.c                   |  26 ++++
> >  tools/perf/builtin-stat.c                     |  18 +++
> >  tools/perf/tests/cpumap.c                     |  23 ++++
> >  .../tests/shell/stat_bpf_counters_cgrp.sh     |   2 +-
> >  tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
> >  tools/perf/tests/shell/test_data_symbol.sh    |   2 +-
> >  tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
> >  tools/perf/util/evlist.c                      | 117 ++++++++++++++++++
> >  tools/perf/util/evlist.h                      |   3 +
> >  tools/perf/util/target.h                      |   9 ++
> >  16 files changed, 263 insertions(+), 9 deletions(-)
> > 
> 

-- 
Cheers,
Changbin Du
