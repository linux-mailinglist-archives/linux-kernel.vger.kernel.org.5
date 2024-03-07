Return-Path: <linux-kernel+bounces-95741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CCC8751F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761211F265CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A17E1E525;
	Thu,  7 Mar 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMB3+pz8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2E1B96E;
	Thu,  7 Mar 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822090; cv=none; b=UuiJxnirQZ36IWWEyFMMpmNp2zc4+3cyi4It/Wu8ZuIFeXRrlROwg515UlrO5RtHsgfB+7k2Tva84jYRLaFyh9qp829LhnAv6s3hIhRDxhcJ4Z9vHbSILvMfs5685M1Q+LXZNiH6/pLoiV5/F25xxsb10W2KaOsLjYCwazL9KqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822090; c=relaxed/simple;
	bh=vJuI5mBdP+Bu2oOxq3NaWAoAvqNCz5fIZ0+M1GDcD7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QG/apGtjiLM8gJ93ZIDQcjV4K8Qkhh1D6tpFrWCc5TLY7NXPvHoUFhcxDdrcBYy9d6v5jPHRQC9qAE9CcnjP+ACHmQKv87WCopcg5A2UQ3eWZ++IeDBCk+ReD4BiBXpX28N2+7h5mQA1jlWztllpsl7S1siyi10OvS8QnlvIsUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMB3+pz8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709822089; x=1741358089;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=vJuI5mBdP+Bu2oOxq3NaWAoAvqNCz5fIZ0+M1GDcD7Y=;
  b=IMB3+pz8tOwNX/rTY23aIEDWmPpxbdTO0NLjfbkFeu/CH8oB6TcRVBL7
   7Ttw7/EGfwDfiQtO8280+u2eeqF8NeUyAqpzGclgiumAZV4xiRSR3wvd6
   WxTwWb1IVeW9xDdiyiYKeGL8qe4ErYBdi5a7Ts9TGw017jmqAYfPuHD6U
   R4A/C7wDCLPEFhE4lLxSJ/O//p3/znft9NBJ2o82MkwWqyUsQlB7ODUWj
   QDpX26zsRtPtM9zx9AvEmd+Tnmbl7Uy9rATWCod30qLcw0iD3fXL83X4C
   3rkxdMHOE/FCNfn7bdeyktOMwafbcq6IfuCnou71BOXfVlt2qXWGsQ9Ok
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15214245"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15214245"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 06:34:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="10197849"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 06:34:43 -0800
Received: from [10.213.180.166] (kliang2-mobl1.ccr.corp.intel.com [10.213.180.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E3782580D54;
	Thu,  7 Mar 2024 06:34:40 -0800 (PST)
Message-ID: <f8f6df3a-2061-4ee1-8d69-735361f83cdd@linux.intel.com>
Date: Thu, 7 Mar 2024 09:34:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] perf list: Give more details about raw event
 encodings
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Yang Jihong <yangjihong1@huawei.com>, James Clark <james.clark@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307081412.3933750-1-irogers@google.com>
 <20240307081412.3933750-5-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240307081412.3933750-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-07 3:14 a.m., Ian Rogers wrote:
> List all the PMUs, not just the first core one, and list real format
> specifiers with value ranges.
> 
> Before:
> ```
> $ perf list
> ...
>   rNNN                                               [Raw hardware event descriptor]
>   cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
>        [(see 'man perf-list' on how to encode it)]
>   mem:<addr>[/len][:access]                          [Hardware breakpoint]
> ...
> ```
> 
> After:
> ```
> $ perf list
> ...
>   rNNN                                               [Raw hardware event descriptor]
>   cpu/event=0..255,pc,edge,.../modifier              [Raw hardware event descriptor]
>        [(see 'man perf-list' or 'man perf-record' on how to encode it)]
>   breakpoint//modifier                               [Raw hardware event descriptor]
>   cstate_core/event=0..0xffffffffffffffff/modifier   [Raw hardware event descriptor]
>   cstate_pkg/event=0..0xffffffffffffffff/modifier    [Raw hardware event descriptor]
>   i915/i915_eventid=0..0x1fffff/modifier             [Raw hardware event descriptor]
>   intel_bts//modifier                                [Raw hardware event descriptor]
>   intel_pt/ptw,event,cyc_thresh=0..15,.../modifier   [Raw hardware event descriptor]
>   kprobe/retprobe/modifier                           [Raw hardware event descriptor]
>   msr/event=0..0xffffffffffffffff/modifier           [Raw hardware event descriptor]
>   power/event=0..255/modifier                        [Raw hardware event descriptor]
>   software//modifier                                 [Raw hardware event descriptor]

Software apparently is not a raw hardware event. Ideally, we should have
a consist name. E.g.,
software//modifier	[Raw Software event descriptor]
tracepoint//modifier	[Raw Tracepoint event descriptor]

If it's too complex, I guess using [event descriptor] or just dropping
it should be OK for me as well.

>   tracepoint//modifier                               [Raw hardware event descriptor]
>   uncore_arb/event=0..255,edge,inv,.../modifier      [Raw hardware event descriptor]
>   uncore_cbox/event=0..255,edge,inv,.../modifier     [Raw hardware event descriptor]
>   uncore_clock/event=0..255/modifier                 [Raw hardware event descriptor]
>   uncore_imc_free_running/event=0..255,umask=0..255/modifier[Raw hardware event descriptor]
>   uprobe/ref_ctr_offset=0..0xffffffff,retprobe/modifier[Raw hardware event descriptor]
>   mem:<addr>[/len][:access]                          [Hardware breakpoint]
> ...
> ```
> 
> With '--details' provide more details on the formats encoding:
> ```
>   cpu/event=0..255,pc,edge,.../modifier              [Raw hardware event descriptor]
>        [(see 'man perf-list' or 'man perf-record' on how to encode it)]
>         cpu/event=0..255,pc,edge,offcore_rsp=0..0xffffffffffffffff,ldlat=0..0xffff,inv,
>         umask=0..255,frontend=0..0xffffff,cmask=0..255,config=0..0xffffffffffffffff,
>         config1=0..0xffffffffffffffff,config2=0..0xffffffffffffffff,config3=0..0xffffffffffffffff,
>         name=string,period=number,freq=number,branch_type=(u|k|hv|any|...),time,
>         call-graph=(fp|dwarf|lbr),stack-size=number,max-stack=number,nr=number,inherit,no-inherit,
>         overwrite,no-overwrite,percore,aux-output,aux-sample-size=number/modifier
>   breakpoint//modifier                               [Raw hardware event descriptor]
>         breakpoint//modifier
>   cstate_core/event=0..0xffffffffffffffff/modifier   [Raw hardware event descriptor]
>         cstate_core/event=0..0xffffffffffffffff/modifier
>   cstate_pkg/event=0..0xffffffffffffffff/modifier    [Raw hardware event descriptor]
>         cstate_pkg/event=0..0xffffffffffffffff/modifier
>   i915/i915_eventid=0..0x1fffff/modifier             [Raw hardware event descriptor]
>         i915/i915_eventid=0..0x1fffff/modifier
>   intel_bts//modifier                                [Raw hardware event descriptor]
>         intel_bts//modifier
>   intel_pt/ptw,event,cyc_thresh=0..15,.../modifier   [Raw hardware event descriptor]
>         intel_pt/ptw,event,cyc_thresh=0..15,pt,notnt,branch,tsc,pwr_evt,fup_on_ptw,cyc,noretcomp,
>         mtc,psb_period=0..15,mtc_period=0..15/modifier
>   kprobe/retprobe/modifier                           [Raw hardware event descriptor]
>         kprobe/retprobe/modifier
>   msr/event=0..0xffffffffffffffff/modifier           [Raw hardware event descriptor]
>         msr/event=0..0xffffffffffffffff/modifier
>   power/event=0..255/modifier                        [Raw hardware event descriptor]
>         power/event=0..255/modifier
>   software//modifier                                 [Raw hardware event descriptor]
>         software//modifier
>   tracepoint//modifier                               [Raw hardware event descriptor]
>         tracepoint//modifier
>   uncore_arb/event=0..255,edge,inv,.../modifier      [Raw hardware event descriptor]
>         uncore_arb/event=0..255,edge,inv,umask=0..255,cmask=0..31/modifier
>   uncore_cbox/event=0..255,edge,inv,.../modifier     [Raw hardware event descriptor]
>         uncore_cbox/event=0..255,edge,inv,umask=0..255,cmask=0..31/modifier
>   uncore_clock/event=0..255/modifier                 [Raw hardware event descriptor]
>         uncore_clock/event=0..255/modifier
>   uncore_imc_free_running/event=0..255,umask=0..255/modifier[Raw hardware event descriptor]
>         uncore_imc_free_running/event=0..255,umask=0..255/modifier
>   uprobe/ref_ctr_offset=0..0xffffffff,retprobe/modifier[Raw hardware event descriptor]
>         uprobe/ref_ctr_offset=0..0xffffffff,retprobe/modifier
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c          | 55 +++++++++++++++++++-
>  tools/perf/util/pmu.h          |  3 ++
>  tools/perf/util/pmus.c         | 94 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmus.h         |  1 +
>  tools/perf/util/print-events.c | 18 +------
>  5 files changed, 153 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 24be587e3537..904725f03d29 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1603,6 +1603,55 @@ bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name)
>  	return false;
>  }
>  
> +int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_callback cb)
> +{
> +	static const char *const terms[] = {
> +		"config=0..0xffffffffffffffff",
> +		"config1=0..0xffffffffffffffff",
> +		"config2=0..0xffffffffffffffff",
> +		"config3=0..0xffffffffffffffff",
> +		"name=string",
> +		"period=number",
> +		"freq=number",
> +		"branch_type=(u|k|hv|any|...)",
> +		"time",
> +		"call-graph=(fp|dwarf|lbr)",
> +		"stack-size=number",
> +		"max-stack=number",
> +		"nr=number",
> +		"inherit",
> +		"no-inherit",
> +		"overwrite",
> +		"no-overwrite",
> +		"percore",
> +		"aux-output",
> +		"aux-sample-size=number",
> +	};

I think it's very likely we forget to update the const table when
introducing a new term. In the parse-events.c, there is
config_term_names[] to restore the name of terms. Can it be shared here?
So every time a new term is introduced, the perf list can be updated
automatically.

Thanks,
Kan
> +	struct perf_pmu_format *format;
> +	int ret;
> +
> +	list_for_each_entry(format, &pmu->format, list) {
> +		perf_pmu_format__load(pmu, format);
> +		ret = cb(state, format->name, (int)format->value, format->bits);
> +		if (ret)
> +			return ret;
> +	}
> +	if (!pmu->is_core)
> +		return 0;
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(terms); i++) {
> +		int config = PERF_PMU_FORMAT_VALUE_CONFIG;
> +
> +		if (i < PERF_PMU_FORMAT_VALUE_CONFIG_END)
> +			config = i;
> +
> +		ret = cb(state, terms[i], config, /*bits=*/NULL);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  bool is_pmu_core(const char *name)
>  {
>  	return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sysfs_pmu_core(name);
> @@ -1697,8 +1746,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  	pmu_add_cpu_aliases(pmu);
>  	list_for_each_entry(event, &pmu->aliases, list) {
>  		size_t buf_used;
> +		int pmu_name_len;
>  
>  		info.pmu_name = event->pmu_name ?: pmu->name;
> +		pmu_name_len = skip_duplicate_pmus
> +			? pmu_name_len_no_suffix(info.pmu_name, /*num=*/NULL)
> +			: (int)strlen(info.pmu_name);
>  		info.alias = NULL;
>  		if (event->desc) {
>  			info.name = event->name;
> @@ -1723,7 +1776,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  		info.encoding_desc = buf + buf_used;
>  		parse_events_terms__to_strbuf(&event->terms, &sb);
>  		buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
> -				"%s/%s/", info.pmu_name, sb.buf) + 1;
> +				"%.*s/%s/", pmu_name_len, info.pmu_name, sb.buf) + 1;
>  		info.topic = event->topic;
>  		info.str = sb.buf;
>  		info.deprecated = event->deprecated;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index e35d985206db..9f5284b29ecf 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -196,6 +196,8 @@ struct pmu_event_info {
>  };
>  
>  typedef int (*pmu_event_callback)(void *state, struct pmu_event_info *info);
> +typedef int (*pmu_format_callback)(void *state, const char *name, int config,
> +				   const unsigned long *bits);
>  
>  void pmu_add_sys_aliases(struct perf_pmu *pmu);
>  int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
> @@ -215,6 +217,7 @@ int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, p
>  int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load);
>  void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
>  bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
> +int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_callback cb);
>  
>  bool is_pmu_core(const char *name);
>  bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 16505071d362..89b15ddeb24e 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -16,6 +16,7 @@
>  #include "pmus.h"
>  #include "pmu.h"
>  #include "print-events.h"
> +#include "strbuf.h"
>  
>  /*
>   * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
> @@ -503,6 +504,99 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>  	zfree(&aliases);
>  }
>  
> +struct build_format_string_args {
> +	struct strbuf short_string;
> +	struct strbuf long_string;
> +	int num_formats;
> +};
> +
> +static int build_format_string(void *state, const char *name, int config,
> +			       const unsigned long *bits)
> +{
> +	struct build_format_string_args *args = state;
> +	unsigned int num_bits;
> +	int ret1, ret2 = 0;
> +
> +	(void)config;
> +	args->num_formats++;
> +	if (args->num_formats > 1) {
> +		strbuf_addch(&args->long_string, ',');
> +		if (args->num_formats < 4)
> +			strbuf_addch(&args->short_string, ',');
> +	}
> +	num_bits = bits ? bitmap_weight(bits, PERF_PMU_FORMAT_BITS) : 0;
> +	if (num_bits <= 1) {
> +		ret1 = strbuf_addf(&args->long_string, "%s", name);
> +		if (args->num_formats < 4)
> +			ret2 = strbuf_addf(&args->short_string, "%s", name);
> +	} else if (num_bits > 8) {
> +		ret1 = strbuf_addf(&args->long_string, "%s=0..0x%llx", name,
> +				   ULLONG_MAX >> (64 - num_bits));
> +		if (args->num_formats < 4) {
> +			ret2 = strbuf_addf(&args->short_string, "%s=0..0x%llx", name,
> +					   ULLONG_MAX >> (64 - num_bits));
> +		}
> +	} else {
> +		ret1 = strbuf_addf(&args->long_string, "%s=0..%llu", name,
> +				  ULLONG_MAX >> (64 - num_bits));
> +		if (args->num_formats < 4) {
> +			ret2 = strbuf_addf(&args->short_string, "%s=0..%llu", name,
> +					   ULLONG_MAX >> (64 - num_bits));
> +		}
> +	}
> +	return ret1 < 0 ? ret1 : (ret2 < 0 ? ret2 : 0);
> +}
> +
> +void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, void *print_state)
> +{
> +	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
> +	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
> +	struct perf_pmu *pmu = NULL;
> +
> +	if (skip_duplicate_pmus)
> +		scan_fn = perf_pmus__scan_skip_duplicates;
> +	else
> +		scan_fn = perf_pmus__scan;
> +
> +	while ((pmu = scan_fn(pmu)) != NULL) {
> +		struct build_format_string_args format_args = {
> +			.short_string = STRBUF_INIT,
> +			.long_string = STRBUF_INIT,
> +			.num_formats = 0,
> +		};
> +		int len = pmu_name_len_no_suffix(pmu->name, /*num=*/NULL);
> +		const char *desc = "(see 'man perf-list' or 'man perf-record' on how to encode it)";
> +
> +		if (!pmu->is_core)
> +			desc = NULL;
> +
> +		strbuf_addf(&format_args.short_string, "%.*s/", len, pmu->name);
> +		strbuf_addf(&format_args.long_string, "%.*s/", len, pmu->name);
> +		perf_pmu__for_each_format(pmu, &format_args, build_format_string);
> +
> +		if (format_args.num_formats > 3)
> +			strbuf_addf(&format_args.short_string, ",.../modifier");
> +		else
> +			strbuf_addf(&format_args.short_string, "/modifier");
> +
> +		strbuf_addf(&format_args.long_string, "/modifier");
> +		print_cb->print_event(print_state,
> +				/*topic=*/NULL,
> +				/*pmu_name=*/NULL,
> +				format_args.short_string.buf,
> +				/*event_alias=*/NULL,
> +				/*scale_unit=*/NULL,
> +				/*deprecated=*/false,
> +				"Raw hardware event descriptor",
> +				desc,
> +				/*long_desc=*/NULL,
> +				format_args.long_string.buf);
> +
> +		strbuf_release(&format_args.short_string);
> +		strbuf_release(&format_args.long_string);
> +	}
> +}
> +
>  bool perf_pmus__have_event(const char *pname, const char *name)
>  {
>  	struct perf_pmu *pmu = perf_pmus__find(pname);
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 94d2a08d894b..eec599d8aebd 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -18,6 +18,7 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
>  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
>  
>  void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
> +void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, void *print_state);
>  bool perf_pmus__have_event(const char *pname, const char *name);
>  int perf_pmus__num_core_pmus(void);
>  bool perf_pmus__supports_extended_type(void);
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index e0d2b49bab66..3a7f14fe2390 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -416,8 +416,6 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
>   */
>  void print_events(const struct print_callbacks *print_cb, void *print_state)
>  {
> -	char *tmp;
> -
>  	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
>  			event_symbols_hw, PERF_COUNT_HW_MAX);
>  	print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
> @@ -441,21 +439,7 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
>  			/*long_desc=*/NULL,
>  			/*encoding_desc=*/NULL);
>  
> -	if (asprintf(&tmp, "%s/t1=v1[,t2=v2,t3 ...]/modifier",
> -		     perf_pmus__scan_core(/*pmu=*/NULL)->name) > 0) {
> -		print_cb->print_event(print_state,
> -				/*topic=*/NULL,
> -				/*pmu_name=*/NULL,
> -				tmp,
> -				/*event_alias=*/NULL,
> -				/*scale_unit=*/NULL,
> -				/*deprecated=*/false,
> -				event_type_descriptors[PERF_TYPE_RAW],
> -				"(see 'man perf-list' on how to encode it)",
> -				/*long_desc=*/NULL,
> -				/*encoding_desc=*/NULL);
> -		free(tmp);
> -	}
> +	perf_pmus__print_raw_pmu_events(print_cb, print_state);
>  
>  	print_cb->print_event(print_state,
>  			/*topic=*/NULL,

