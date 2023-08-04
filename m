Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7E476FA91
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjHDG6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjHDG6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:58:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F9C2726;
        Thu,  3 Aug 2023 23:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691132322; x=1722668322;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DC+aSwk9YnFVH7MkhoK82dZt2umfCmnFdvzsTav5abM=;
  b=CG3vMeQWx4YhyKVno0D91RCDaiG4rWcZAHQOnzwmY4McxI8c7DUn5lq+
   iAUOzvkR7jJb1nFbesClCoCfb5y7SWZFFNwRfDZyRdoUlktPLS967/tfv
   E3CweN5uzPlyTDruKuFo88liclrIJ2l0oRQTgv1BQIU5MHvKz4czqIl6v
   4fm7iZqtSNptcfkpoFI8puOaR0TRO82WYv43qO8Tt6ZEuY+rU2b7Ve07b
   TPq7O/bfFn5bikwgFJr8amKi2VIF7HfiWGUS/9EdS+LGjifAydp1tPkOq
   IvqL/8rqWm28ssUTk7BtT2RWzi45EVkxKf4cfeG1amP6VQf4vL2kVT7hS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349679933"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="349679933"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060611958"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="1060611958"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.129])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:58:37 -0700
Message-ID: <b8741176-dc9c-1ddb-6bb5-85293f3c61f7@intel.com>
Date:   Fri, 4 Aug 2023 09:58:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v5 3/7] perf record: Move setting dummy tracking before
 record__init_thread_masks()
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230804020741.99806-1-yangjihong1@huawei.com>
 <20230804020741.99806-4-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230804020741.99806-4-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/08/23 05:07, Yang Jihong wrote:
> When dummy tracking go system wide, the mmap cpu mask is changed.
> Therefore, needs to be placed before record__init_thread_masks().
> Dummy tracking has been set in record__open(), move it before
> record__init_thread_masks() and add a helper for unified processing.
> 
> The sys_perf_event_open invoked is as follows:
> 
>   # perf --debug verbose=3 record -e cpu-clock -D 100 true
>   <SNIP>
>   Opening: cpu-clock
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 10318  cpu 0  group_fd -1  flags 0x8 = 5
>   sys_perf_event_open: pid 10318  cpu 1  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid 10318  cpu 2  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid 10318  cpu 3  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid 10318  cpu 4  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid 10318  cpu 5  group_fd -1  flags 0x8 = 11
>   sys_perf_event_open: pid 10318  cpu 6  group_fd -1  flags 0x8 = 12
>   sys_perf_event_open: pid 10318  cpu 7  group_fd -1  flags 0x8 = 13
>   Opening: dummy:u
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0x9 (PERF_COUNT_SW_DUMMY)
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|IDENTIFIER
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     mmap                             1
>     comm                             1
>     enable_on_exec                   1
>     task                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 10318  cpu 0  group_fd -1  flags 0x8 = 14
>   sys_perf_event_open: pid 10318  cpu 1  group_fd -1  flags 0x8 = 15
>   sys_perf_event_open: pid 10318  cpu 2  group_fd -1  flags 0x8 = 16
>   sys_perf_event_open: pid 10318  cpu 3  group_fd -1  flags 0x8 = 17
>   sys_perf_event_open: pid 10318  cpu 4  group_fd -1  flags 0x8 = 18
>   sys_perf_event_open: pid 10318  cpu 5  group_fd -1  flags 0x8 = 19
>   sys_perf_event_open: pid 10318  cpu 6  group_fd -1  flags 0x8 = 20
>   sys_perf_event_open: pid 10318  cpu 7  group_fd -1  flags 0x8 = 21
>   <SNIP>
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/builtin-record.c | 59 +++++++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ca83599cc50c..3ff9d972225e 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -908,6 +908,37 @@ static int record__config_off_cpu(struct record *rec)
>  	return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>  }
>  
> +static int record__config_tracking_events(struct record *rec)
> +{
> +	struct record_opts *opts = &rec->opts;
> +	struct evlist *evlist = rec->evlist;
> +	struct evsel *evsel;
> +
> +	/*
> +	 * For initial_delay, system wide or a hybrid system, we need to add a
> +	 * dummy event so that we can track PERF_RECORD_MMAP to cover the delay
> +	 * of waiting or event synthesis.
> +	 */
> +	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
> +	    perf_pmus__num_core_pmus() > 1) {
> +		evsel = evlist__findnew_tracking_event(evlist, false);
> +		if (!evsel)
> +			return -ENOMEM;
> +
> +		/*
> +		 * Enable the dummy event when the process is forked for
> +		 * initial_delay, immediately for system wide.
> +		 */
> +		if (opts->target.initial_delay && !evsel->immediate &&
> +		    !target__has_cpu(&opts->target))
> +			evsel->core.attr.enable_on_exec = 1;
> +		else
> +			evsel->immediate = 1;
> +	}
> +
> +	return 0;
> +}
> +
>  static bool record__kcore_readable(struct machine *machine)
>  {
>  	char kcore[PATH_MAX];
> @@ -1288,28 +1319,6 @@ static int record__open(struct record *rec)
>  	struct record_opts *opts = &rec->opts;
>  	int rc = 0;
>  
> -	/*
> -	 * For initial_delay, system wide or a hybrid system, we need to add a
> -	 * dummy event so that we can track PERF_RECORD_MMAP to cover the delay
> -	 * of waiting or event synthesis.
> -	 */
> -	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
> -	    perf_pmus__num_core_pmus() > 1) {
> -		pos = evlist__findnew_tracking_event(evlist, false);
> -		if (!pos)
> -			return -ENOMEM;
> -
> -		/*
> -		 * Enable the dummy event when the process is forked for
> -		 * initial_delay, immediately for system wide.
> -		 */
> -		if (opts->target.initial_delay && !pos->immediate &&
> -		    !target__has_cpu(&opts->target))
> -			pos->core.attr.enable_on_exec = 1;
> -		else
> -			pos->immediate = 1;
> -	}
> -
>  	evlist__config(evlist, opts, &callchain_param);
>  
>  	evlist__for_each_entry(evlist, pos) {
> @@ -4235,6 +4244,12 @@ int cmd_record(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	err = record__config_tracking_events(rec);
> +	if (err) {
> +		pr_err("record__config_tracking_events failed, error %d\n", err);
> +		goto out;
> +	}
> +
>  	err = record__init_thread_masks(rec);
>  	if (err) {
>  		pr_err("Failed to initialize parallel data streaming masks\n");

