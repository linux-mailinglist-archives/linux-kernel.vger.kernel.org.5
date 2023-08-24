Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207F8787101
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbjHXOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbjHXOBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:01:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2354F1BCD;
        Thu, 24 Aug 2023 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692885710; x=1724421710;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OXqsjRaerq3RRQ7ej7dGE6vPdNrHCZ6fWASkg7r8exk=;
  b=CPGM8r2sYHCk3Ff9ZAuZ9i0O5blqkYNJN3sZJSZPHEmHgfzI9DKDezRv
   sM/QWq47zMtHkM2HkDwY9D3drQFQJneHEnEGp8tubJ5ugu4nlwbzOCmox
   BUYTPtwgN2tqmonRbT6x/AsPLJGug66ctlAwS8/yQ5Ify/CYEkbc+CxvR
   9XY2XF6nZbgL3axvBjieMWHds1Pw1u3JkZ7xcFI276zRzFoPIIiC2H0uN
   Ntb/a/eFhOldbuv5AxmsAQWL+wwtXhHhBfz2aR7MGrfKxgMDaWGBnDyrd
   RAKde1svbL2vXa/Te72s8CpZg9jKKpXsSY3B2WWGRBsrv1v9fnvVrzO8h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="377187743"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="377187743"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="730607246"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="730607246"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2023 06:33:12 -0700
Received: from [10.209.149.74] (kliang2-mobl1.ccr.corp.intel.com [10.209.149.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B831F5808BA;
        Thu, 24 Aug 2023 06:33:10 -0700 (PDT)
Message-ID: <6913f6d8-7f01-f132-5375-e82b8aa2e0b9@linux.intel.com>
Date:   Thu, 24 Aug 2023 09:33:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/3] perf pmus: Add scan that ignores duplicates, use
 for perf list
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230814163757.3077138-1-irogers@google.com>
 <20230814163757.3077138-3-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230814163757.3077138-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-14 12:37 p.m., Ian Rogers wrote:
> When there are multiple PMUs that differ only by suffix, by default
> just list the first one and skip all others. As the PMUs are sorted,
> the scan routine checks that the PMU names match and the numbers are
> consecutive. 

The suffix number may not be consecutive, especially for SPR and later
platforms. Because the IDs are from the discovery table now, which is
assigned by the HW. The physic IDs are not guaranteed to be consecutive.

I don't think there is a plan to change it to logical IDs. Because
sometimes people want to know the physic IDs. So they can locate the
specific unit quickly.

Thanks,
Kan

> If "-v" is passed to "perf list" then list all PMUs.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-list.c      |  8 +++++
>  tools/perf/util/pmus.c         | 54 ++++++++++++++++++++++++++++++++--
>  tools/perf/util/print-events.h |  1 +
>  3 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 7fec2cca759f..8fe4ddf02c14 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -423,6 +423,13 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
>  	strbuf_release(&buf);
>  }
>  
> +static bool default_skip_duplicate_pmus(void *ps)
> +{
> +	struct print_state *print_state = ps;
> +
> +	return !print_state->long_desc;
> +}
> +
>  int cmd_list(int argc, const char **argv)
>  {
>  	int i, ret = 0;
> @@ -434,6 +441,7 @@ int cmd_list(int argc, const char **argv)
>  		.print_end = default_print_end,
>  		.print_event = default_print_event,
>  		.print_metric = default_print_metric,
> +		.skip_duplicate_pmus = default_skip_duplicate_pmus,
>  	};
>  	const char *cputype = NULL;
>  	const char *unit_name = NULL;
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 3581710667b0..5073843aca19 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -275,6 +275,50 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
>  	return NULL;
>  }
>  
> +static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
> +{
> +	bool use_core_pmus = !pmu || pmu->is_core;
> +	int last_pmu_name_len = 0;
> +	unsigned long last_pmu_num = 0;
> +	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
> +
> +	if (!pmu) {
> +		pmu_read_sysfs(/*core_only=*/false);
> +		pmu = list_prepare_entry(pmu, &core_pmus, list);
> +	} else
> +		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &last_pmu_num);
> +
> +	if (use_core_pmus) {
> +		list_for_each_entry_continue(pmu, &core_pmus, list) {
> +			unsigned long pmu_num = 0;
> +			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
> +
> +			if (last_pmu_name_len == pmu_name_len &&
> +			    (last_pmu_num + 1 == pmu_num) &&
> +			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
> +				last_pmu_num++;
> +				continue;
> +			}
> +			return pmu;
> +		}
> +		pmu = NULL;
> +		pmu = list_prepare_entry(pmu, &other_pmus, list);
> +	}
> +	list_for_each_entry_continue(pmu, &other_pmus, list) {
> +		unsigned long pmu_num = 0;
> +		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
> +
> +		if (last_pmu_name_len == pmu_name_len &&
> +		    (last_pmu_num + 1 == pmu_num) &&
> +		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
> +			last_pmu_num++;
> +			continue;
> +		}
> +		return pmu;
> +	}
> +	return NULL;
> +}
> +
>  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
>  {
>  	struct perf_pmu *pmu = NULL;
> @@ -429,10 +473,16 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>  	int printed = 0;
>  	int len, j;
>  	struct sevent *aliases;
> +	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
> +
> +	if (print_cb->skip_duplicate_pmus(print_state))
> +		scan_fn = perf_pmus__scan_skip_duplicates;
> +	else
> +		scan_fn = perf_pmus__scan;
>  
>  	pmu = NULL;
>  	len = 0;
> -	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> +	while ((pmu = scan_fn(pmu)) != NULL) {
>  		list_for_each_entry(event, &pmu->aliases, list)
>  			len++;
>  		if (pmu->selectable)
> @@ -445,7 +495,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>  	}
>  	pmu = NULL;
>  	j = 0;
> -	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> +	while ((pmu = scan_fn(pmu)) != NULL) {
>  		bool is_cpu = pmu->is_core;
>  
>  		list_for_each_entry(event, &pmu->aliases, list) {
> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
> index d7fab411e75c..bf4290bef0cd 100644
> --- a/tools/perf/util/print-events.h
> +++ b/tools/perf/util/print-events.h
> @@ -26,6 +26,7 @@ struct print_callbacks {
>  			const char *expr,
>  			const char *threshold,
>  			const char *unit);
> +	bool (*skip_duplicate_pmus)(void *print_state);
>  };
>  
>  /** Print all events, the default when no options are specified. */
