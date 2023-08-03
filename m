Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF476E03D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjHCG3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjHCG3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:29:37 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98AC30FD;
        Wed,  2 Aug 2023 23:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691044131; x=1722580131;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DFY0fqBXzhCaoxpgSJyR6bWlanS6eXto8oIiZiMluPE=;
  b=kytnF7xg/OjDlxJQpP7DVi5Baf0pPf8OPMuJLkeW3c+Wg8v0x9fJQ7aV
   7O0NegkMeD3THdlk9SzDI00erMP9j8OMKoeAj9kiT8qVjZPbo/etR533U
   +qluWShOJc2tyAi9Xck8fac41zhNx8vfXboeKR52ohjNXpD+SgqY6rk0U
   7SfK6I/pdLI5pvTb0l36zsAyw7F3XFAV+cxf0lpg4kOwrCkA01p6Eogfr
   R3hd8Hs0m4vJ+CexRRQrVwhj/hyLoEVWaMMvy+PTXTp3wxrGQkENxwIGv
   TuUFRt6aTPIFmf9XaIxlJz6xonBAQTFLnWdBfOsfo0y9gBV32QvgjIND/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="400719360"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="400719360"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 23:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="799419874"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="799419874"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.36.218])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 23:28:45 -0700
Message-ID: <bbfd8e23-db63-61fc-4f9e-25e993345b57@intel.com>
Date:   Thu, 3 Aug 2023 09:28:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v4 4/7] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230802074948.136468-1-yangjihong1@huawei.com>
 <20230802074948.136468-5-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230802074948.136468-5-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/08/23 10:49, Yang Jihong wrote:
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
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>   Opening: dummy:u
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0x9 (PERF_COUNT_SW_DUMMY)
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
>  tools/perf/Documentation/perf-record.txt |  3 ++
>  tools/perf/builtin-record.c              | 45 +++++++++++++++++++++++-
>  2 files changed, 47 insertions(+), 1 deletion(-)
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
> index 3ff9d972225e..468afeaac52d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -908,10 +908,45 @@ static int record__config_off_cpu(struct record *rec)
>  	return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>  }
>  
> +static bool record__tracking_system_wide(struct record *rec)
> +{
> +	struct record_opts *opts = &rec->opts;
> +	struct evlist *evlist = rec->evlist;
> +	struct evsel *evsel;
> +
> +	/*
> +	 * If all (non-dummy) evsel have exclude_user,
> +	 * system_wide is not needed.
> +	 *
> +	 * all_kernel and all_user will overwrite exclude_kernel and
> +	 * exclude_user of attr in evsel__config(), here need to check
> +	 * all the three items.
> +	 *
> +	 * Sideband system wide if one of the following conditions is met:
> +	 *
> +	 *   - all_user is set, and there is a non-dummy event
> +	 *   - all_user and all_kernel are not set, and there is
> +	 *     a non-dummy event without exclude_user
> +	 */

Could start with:

	if (opts->all_kernel)
		return false;

> +	evlist__for_each_entry(evlist, evsel) {
> +		if (!evsel__is_dummy_event(evsel)) {
> +			if (opts->all_user)
> +				return true;
> +
> +			if (!opts->all_user && !opts->all_kernel &&

!opts->all_user is always true here

> +			    !evsel->core.attr.exclude_user)
> +				return true;

So then this could simply be:

			if (opts->all_user || !evsel->core.attr.exclude_user)
				return true;


> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static int record__config_tracking_events(struct record *rec)
>  {
>  	struct record_opts *opts = &rec->opts;
>  	struct evlist *evlist = rec->evlist;
> +	bool system_wide = false;
>  	struct evsel *evsel;
>  
>  	/*
> @@ -921,7 +956,15 @@ static int record__config_tracking_events(struct record *rec)
>  	 */
>  	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>  	    perf_pmus__num_core_pmus() > 1) {
> -		evsel = evlist__findnew_tracking_event(evlist, false);
> +
> +		/*
> +		 * User space tasks can migrate between CPUs, so when tracing
> +		 * selected CPUs, sideband for all CPUs is still needed.
> +		 */
> +		if (!!opts->target.cpu_list && record__tracking_system_wide(rec))
> +			system_wide = true;
> +
> +		evsel = evlist__findnew_tracking_event(evlist, system_wide);
>  		if (!evsel)
>  			return -ENOMEM;
>  

