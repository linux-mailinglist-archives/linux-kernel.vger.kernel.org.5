Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0363480708A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378406AbjLFNIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFNIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:08:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA60C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:08:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906E7C433C7;
        Wed,  6 Dec 2023 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701868114;
        bh=cIuC5yLY0juRRBFTl/trHmPylSyJkc8OJg85uqitwf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSYgcfQLprcUpodLygR7UEp7IEiv9o9ENgx/PO7Aymr3KW+HsEAJ3j8Az8dnNuJww
         GSQAavU6LLPc8FGQh2c6oLDR5SYip2slEBrVnk/DuE5eWlv7TRimWXHfwBnZDoIoa4
         Nqvawzeqe6NiTZPrHGTj3iNMXMl3u1rTARX2exkXA/XlamxszYsVJa+FHdreqLZh9j
         I8eL4e5T8YolNHXhl1GBbyR27S7Rpd0uUyxmpZu+bIDVtJP/oq++/zOuJY2O0yiz/p
         3mACHGvqfba4aBOL/mTLbCex4V3Tah+O+ylr35oLIzTyPoOuuy4d06bvN9o4q6YV9U
         SsjeJjY7DPjfQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 04A7B403EF; Wed,  6 Dec 2023 10:08:31 -0300 (-03)
Date:   Wed, 6 Dec 2023 10:08:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ayush Jain <ayush.jain3@amd.com>, Ian Rogers <irogers@google.com>
Cc:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, barnali@linux.ibm.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH] perf test: Retry without grouping for all metrics test
Message-ID: <ZXByT1K6enTh2EHT@kernel.org>
References: <20230614090710.680330-1-sandipan.das@amd.com>
 <1320e6e3-c029-2a8c-e8b7-2cfbb781518a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320e6e3-c029-2a8c-e8b7-2cfbb781518a@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 14, 2023 at 05:08:21PM +0530, Ayush Jain escreveu:
> On 6/14/2023 2:37 PM, Sandipan Das wrote:
> > There are cases where a metric uses more events than the number of
> > counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four data fabric
> > counters but the "nps1_die_to_dram" metric has eight events. By default,
> > the constituent events are placed in a group. Since the events cannot be
> > scheduled at the same time, the metric is not computed. The all metrics
> > test also fails because of this.

Humm, I'm not being able to reproduce here the problem, before applying
this patch:

[root@five ~]# grep -m1 "model name" /proc/cpuinfo
model name	: AMD Ryzen 9 5950X 16-Core Processor
[root@five ~]# perf test -vvv "perf all metrics test"
104: perf all metrics test                                           :
--- start ---
test child forked, pid 1379713
Testing branch_misprediction_ratio
Testing all_remote_links_outbound
Testing nps1_die_to_dram
Testing macro_ops_dispatched
Testing all_l2_cache_accesses
Testing all_l2_cache_hits
Testing all_l2_cache_misses
Testing ic_fetch_miss_ratio
Testing l2_cache_accesses_from_l2_hwpf
Testing l2_cache_misses_from_l2_hwpf
Testing op_cache_fetch_miss_ratio
Testing l3_read_miss_latency
Testing l1_itlb_misses
test child finished with 0
---- end ----
perf all metrics test: Ok
[root@five ~]#

[root@five ~]# perf stat -M nps1_die_to_dram -a sleep 2

 Performance counter stats for 'system wide':

                 0      dram_channel_data_controller_4   #  10885.3 MiB  nps1_die_to_dram       (49.96%)
        31,334,338      dram_channel_data_controller_1                                          (50.01%)
                 0      dram_channel_data_controller_6                                          (50.04%)
        54,679,601      dram_channel_data_controller_3                                          (50.04%)
        38,420,402      dram_channel_data_controller_0                                          (50.04%)
                 0      dram_channel_data_controller_5                                          (49.99%)
        54,012,661      dram_channel_data_controller_2                                          (49.96%)
                 0      dram_channel_data_controller_7                                          (49.96%)

       2.001465439 seconds time elapsed

[root@five ~]#

[root@five ~]# perf stat -v -M nps1_die_to_dram -a sleep 2
Using CPUID AuthenticAMD-25-21-0
metric expr dram_channel_data_controller_0 + dram_channel_data_controller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_data_controller_6 + dram_channel_data_controller_7 for nps1_die_to_dram
found event dram_channel_data_controller_4
found event dram_channel_data_controller_1
found event dram_channel_data_controller_6
found event dram_channel_data_controller_3
found event dram_channel_data_controller_0
found event dram_channel_data_controller_5
found event dram_channel_data_controller_2
found event dram_channel_data_controller_7
Parsing metric events 'dram_channel_data_controller_4/metric-id=dram_channel_data_controller_4/,dram_channel_data_controller_1/metric-id=dram_channel_data_controller_1/,dram_channel_data_controller_6/metric-id=dram_channel_data_controller_6/,dram_channel_data_controller_3/metric-id=dram_channel_data_controller_3/,dram_channel_data_controller_0/metric-id=dram_channel_data_controller_0/,dram_channel_data_controller_5/metric-id=dram_channel_data_controller_5/,dram_channel_data_controller_2/metric-id=dram_channel_data_controller_2/,dram_channel_data_controller_7/metric-id=dram_channel_data_controller_7/'
dram_channel_data_controller_4 -> amd_df/metric-id=dram_channel_data_controller_4,dram_channel_data_controller_4/
dram_channel_data_controller_1 -> amd_df/metric-id=dram_channel_data_controller_1,dram_channel_data_controller_1/
Multiple errors dropping message: Cannot find PMU `dram_channel_data_controller_1'. Missing kernel support? (<no help>)
dram_channel_data_controller_6 -> amd_df/metric-id=dram_channel_data_controller_6,dram_channel_data_controller_6/
Multiple errors dropping message: Cannot find PMU `dram_channel_data_controller_6'. Missing kernel support? (<no help>)
dram_channel_data_controller_3 -> amd_df/metric-id=dram_channel_data_controller_3,dram_channel_data_controller_3/
Multiple errors dropping message: Cannot find PMU `dram_channel_data_controller_3'. Missing kernel support? (<no help>)
dram_channel_data_controller_0 -> amd_df/metric-id=dram_channel_data_controller_0,dram_channel_data_controller_0/
Multiple errors dropping message: Cannot find PMU `dram_channel_data_controller_0'. Missing kernel support? (<no help>)
dram_channel_data_controller_5 -> amd_df/metric-id=dram_channel_data_controller_5,dram_channel_data_controller_5/
Multiple errors dropping message: Cannot find PMU `dram_channel_data_controller_5'. Missing kernel support? (<no help>)
dram_channel_data_controller_2 -> amd_df/metric-id=dram_channel_data_controller_2,dram_channel_data_controller_2/
Multiple errors dropping message: Cannot find PMU `dram_channel_data_controller_2'. Missing kernel support? (<no help>)
dram_channel_data_controller_7 -> amd_df/metric-id=dram_channel_data_controller_7,dram_channel_data_controller_7/
Matched metric-id dram_channel_data_controller_4 to dram_channel_data_controller_4
Matched metric-id dram_channel_data_controller_1 to dram_channel_data_controller_1
Matched metric-id dram_channel_data_controller_6 to dram_channel_data_controller_6
Matched metric-id dram_channel_data_controller_3 to dram_channel_data_controller_3
Matched metric-id dram_channel_data_controller_0 to dram_channel_data_controller_0
Matched metric-id dram_channel_data_controller_5 to dram_channel_data_controller_5
Matched metric-id dram_channel_data_controller_2 to dram_channel_data_controller_2
Matched metric-id dram_channel_data_controller_7 to dram_channel_data_controller_7
Control descriptor is not initialized
dram_channel_data_controller_4: 0 2001175127 999996394
dram_channel_data_controller_1: 32346663 2001169897 1000709803
dram_channel_data_controller_6: 0 2001168377 1001193443
dram_channel_data_controller_3: 47551247 2001166947 1001198122
dram_channel_data_controller_0: 38975242 2001165217 1001182923
dram_channel_data_controller_5: 0 2001163067 1000464054
dram_channel_data_controller_2: 49934162 2001160907 999974934
dram_channel_data_controller_7: 0 2001150317 999968825

 Performance counter stats for 'system wide':

                 0      dram_channel_data_controller_4   #  10297.2 MiB  nps1_die_to_dram       (49.97%)
        32,346,663      dram_channel_data_controller_1                                          (50.01%)
                 0      dram_channel_data_controller_6                                          (50.03%)
        47,551,247      dram_channel_data_controller_3                                          (50.03%)
        38,975,242      dram_channel_data_controller_0                                          (50.03%)
                 0      dram_channel_data_controller_5                                          (49.99%)
        49,934,162      dram_channel_data_controller_2                                          (49.97%)
                 0      dram_channel_data_controller_7                                          (49.97%)

       2.001196512 seconds time elapsed

[root@five ~]#

What am I missing?

Ian, I also stumbled on this:

[root@five ~]# perf stat -M dram_channel_data_controller_4
Cannot find metric or group `dram_channel_data_controller_4'
^C
 Performance counter stats for 'system wide':

        284,908.91 msec cpu-clock                        #   32.002 CPUs utilized
         6,485,456      context-switches                 #   22.763 K/sec
               719      cpu-migrations                   #    2.524 /sec
            32,800      page-faults                      #  115.125 /sec
   189,779,273,552      cycles                           #    0.666 GHz                         (83.33%)
     2,893,165,259      stalled-cycles-frontend          #    1.52% frontend cycles idle        (83.33%)
    24,807,157,349      stalled-cycles-backend           #   13.07% backend cycles idle         (83.33%)
    99,286,488,807      instructions                     #    0.52  insn per cycle
                                                  #    0.25  stalled cycles per insn     (83.33%)
    24,120,737,678      branches                         #   84.661 M/sec                       (83.33%)
     1,907,540,278      branch-misses                    #    7.91% of all branches             (83.34%)

       8.902784776 seconds time elapsed


[root@five ~]#
[root@five ~]# perf stat -e dram_channel_data_controller_4
^C
 Performance counter stats for 'system wide':

                 0      dram_channel_data_controller_4

       1.189638741 seconds time elapsed


[root@five ~]#

I.e. -M should bail out at that point (Cannot find metric or group `dram_channel_data_controller_4'), no?

- Arnaldo

> > Before announcing failure, the test can try multiple options for each
> > available metric. After system-wide mode fails, retry once again with
> > the "--metric-no-group" option.
> > 
> > E.g.
> > 
> >    $ sudo perf test -v 100
> > 
> > Before:
> > 
> >    100: perf all metrics test                                           :
> >    --- start ---
> >    test child forked, pid 672731
> >    Testing branch_misprediction_ratio
> >    Testing all_remote_links_outbound
> >    Testing nps1_die_to_dram
> >    Metric 'nps1_die_to_dram' not printed in:
> >    Error:
> >    Invalid event (dram_channel_data_controller_4) in per-thread mode, enable system wide with '-a'.
> >    Testing macro_ops_dispatched
> >    Testing all_l2_cache_accesses
> >    Testing all_l2_cache_hits
> >    Testing all_l2_cache_misses
> >    Testing ic_fetch_miss_ratio
> >    Testing l2_cache_accesses_from_l2_hwpf
> >    Testing l2_cache_misses_from_l2_hwpf
> >    Testing op_cache_fetch_miss_ratio
> >    Testing l3_read_miss_latency
> >    Testing l1_itlb_misses
> >    test child finished with -1
> >    ---- end ----
> >    perf all metrics test: FAILED!
> > 
> > After:
> > 
> >    100: perf all metrics test                                           :
> >    --- start ---
> >    test child forked, pid 672887
> >    Testing branch_misprediction_ratio
> >    Testing all_remote_links_outbound
> >    Testing nps1_die_to_dram
> >    Testing macro_ops_dispatched
> >    Testing all_l2_cache_accesses
> >    Testing all_l2_cache_hits
> >    Testing all_l2_cache_misses
> >    Testing ic_fetch_miss_ratio
> >    Testing l2_cache_accesses_from_l2_hwpf
> >    Testing l2_cache_misses_from_l2_hwpf
> >    Testing op_cache_fetch_miss_ratio
> >    Testing l3_read_miss_latency
> >    Testing l1_itlb_misses
> >    test child finished with 0
> >    ---- end ----
> >    perf all metrics test: Ok
> > 
> 
> Issue gets resolved after applying this patch
> 
>   $ ./perf test 102 -vvv
>   $102: perf all metrics test                                           :
>   $--- start ---
>   $test child forked, pid 244991
>   $Testing branch_misprediction_ratio
>   $Testing all_remote_links_outbound
>   $Testing nps1_die_to_dram
>   $Testing all_l2_cache_accesses
>   $Testing all_l2_cache_hits
>   $Testing all_l2_cache_misses
>   $Testing ic_fetch_miss_ratio
>   $Testing l2_cache_accesses_from_l2_hwpf
>   $Testing l2_cache_misses_from_l2_hwpf
>   $Testing l3_read_miss_latency
>   $Testing l1_itlb_misses
>   $test child finished with 0
>   $---- end ----
>   $perf all metrics test: Ok
> 
> > Reported-by: Ayush Jain <ayush.jain3@amd.com>
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> 
> Tested-by: Ayush Jain <ayush.jain3@amd.com>
> 
> > ---
> >   tools/perf/tests/shell/stat_all_metrics.sh | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> > index 54774525e18a..1e88ea8c5677 100755
> > --- a/tools/perf/tests/shell/stat_all_metrics.sh
> > +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> > @@ -16,6 +16,13 @@ for m in $(perf list --raw-dump metrics); do
> >     then
> >       continue
> >     fi
> > +  # Failed again, possibly there are not enough counters so retry system wide
> > +  # mode but without event grouping.
> > +  result=$(perf stat -M "$m" --metric-no-group -a sleep 0.01 2>&1)
> > +  if [[ "$result" =~ ${m:0:50} ]]
> > +  then
> > +    continue
> > +  fi
> >     # Failed again, possibly the workload was too small so retry with something
> >     # longer.
> >     result=$(perf stat -M "$m" perf bench internals synthesize 2>&1)
> 
> Thanks & Regards,
> Ayush Jain

-- 

- Arnaldo
