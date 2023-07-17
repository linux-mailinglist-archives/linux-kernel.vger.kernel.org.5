Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C7756646
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGQOZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGQOZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:25:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2ACC0;
        Mon, 17 Jul 2023 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689603941; x=1721139941;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9jbWPEK5mjyl/38fUXJs79bRqfkPrUlRieUxO7KNqQU=;
  b=hVa19YjndFq/3tAsWltxXJBii71JGM08dLRoRDbeQJuOsgbOBZ71fQhQ
   NIv4VAUQTB+kZKNXPxyTx03abrE/P9p2QnMce854RbZzO+i+JAN4ORlw9
   t9dkf3sqmnGFsuHJQ/VvdEfFTWhvRFXzVl17+QBHd6/jlUUB+pBHdTu7Z
   Csm7kw8EjyZhXd3XD9oBepRRWhtCBehSZ8k3tYQ6q4Sd8aMOez4YMEQQz
   3VBkll0ZYyzQfjX9ECqTjA7Jcy7SK8IynKTeaNAJ55plkb9pYdOYEpL9+
   QDwQo8atSFojGFarkNj2Xkoz/E0mazPPoO9XaRuk9Jb23nZcTp+TBqC5l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="365985440"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="365985440"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="758428944"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="758428944"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.223.8])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:25:33 -0700
Message-ID: <8591416b-77aa-fc9d-fe39-21c718600592@intel.com>
Date:   Mon, 17 Jul 2023 17:25:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/7] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-5-yangjihong1@huawei.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230715032915.97146-5-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/23 06:29, Yang Jihong wrote:
> User space tasks can migrate between CPUs, we need to track side-band
> events for all CPUs.
> 
> The specific scenarios are as follows:
> 
>          CPU0                                 CPU1
>   perf record -C 0 start
>                               taskA starts to be created and executed
>                                 -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>                                    events only deliver to CPU1
>                               ......
>                                 |
>                           migrate to CPU0
>                                 |
>   Running on CPU0    <----------/
>   ...
> 
>   perf record -C 0 stop
> 
> Now perf samples the PC of taskA. However, perf does not record the
> PERF_RECORD_COMM and PERF_RECORD_MMAP events of taskA.
> Therefore, the comm and symbols of taskA cannot be parsed.
> 
> The solution is to record sideband events for all CPUs when tracing
> selected CPUs. Because this modifies the default behavior, add related
> comments to the perf record man page.
> 
> The sys_perf_event_open invoked is as follows:
> 
>   # perf --debug verbose=3 record -e cpu-clock -C 1 true
>   <SNIP>
>   Opening: cpu-clock
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             136
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>   Opening: dummy:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             136
>     config                           0x9
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID|LOST
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     mmap                             1
>     comm                             1
>     task                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>   sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>   sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>   sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>   <SNIP>
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 3 +++
>  tools/perf/builtin-record.c              | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 680396c56bd1..dac53ece51ab 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -388,6 +388,9 @@ comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-
>  In per-thread mode with inheritance mode on (default), samples are captured only when
>  the thread executes on the designated CPUs. Default is to monitor all CPUs.
>  
> +User space tasks can migrate between CPUs, so when tracing selected CPUs,
> +a dummy event is created to track sideband for all CPUs.
> +
>  -B::
>  --no-buildid::
>  Do not save the build ids of binaries in the perf.data files. This skips
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ccbcb005e188..4a15b2e06f45 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -921,7 +921,12 @@ static int record__config_tracking_events(struct record *rec)
>  	 */
>  	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>  	    perf_pmus__num_core_pmus() > 1) {
> -		evsel = evlist__findnew_tracking_event(evlist, false);
> +
> +		/*
> +		 * User space tasks can migrate between CPUs, so when tracing
> +		 * selected CPUs, sideband for all CPUs is still needed.

So if all (non-dummy) evsel have exclude_user, then system_wide is not needed.

> +		 */
> +		evsel = evlist__findnew_tracking_event(evlist, !!opts->target.cpu_list);
>  		if (!evsel)
>  			return -ENOMEM;
>  

