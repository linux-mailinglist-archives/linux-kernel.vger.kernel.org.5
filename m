Return-Path: <linux-kernel+bounces-159023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D40518B283E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00996B224AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38FA433C9;
	Thu, 25 Apr 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI/qXLRC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1539ADB;
	Thu, 25 Apr 2024 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070295; cv=none; b=Jo6MzCNFzc4J+m7eMBaMo3FQPp/yAsqy+Lks+6JB7s3e5hhaXy4yepDng0oIETUBEBAMXzjLN/glJqiPNWHNOhgqbylDtEkBkk0cK+rRbwy8UBLvy2+WzYxs+59vCkbULWRTwviYnXk/CaEKnSJ5yvuDugwJYrc2vvZa5FT45Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070295; c=relaxed/simple;
	bh=c1juNV6d9khwyuVKGtY9nbG2b4qc9lBgkvtrWgmodnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipQZCUKK1SPhksbMEs9AjZatW68yUe2fZPc6WhlHzAcmzt9mt3Bve0ryM1VbraM0VTQ1fhcucZVLthvN/uYoLipkF5jJKpJhCwaDN5ilx6jagmQqWt8uSJ080kdI7bEK3dgBUozwNQHy2cjNbdkJ5g7KRDaSE7TjngJ8/jaItA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI/qXLRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0306C113CC;
	Thu, 25 Apr 2024 18:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714070294;
	bh=c1juNV6d9khwyuVKGtY9nbG2b4qc9lBgkvtrWgmodnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PI/qXLRCq99NSnholM088iL/MH86KZY83CCJrw1ZN44W6fqKDaPAAu8YOD74eNCwU
	 WeQ+i3xFOEgWY1U9PvvE5la1RwO+k27lpvXhgzx4BVb5UiI09SJ1JT4JiiBaiC6AYe
	 FWkR1mhFzjijoPfFWxle4glu49g7OfvHWXq4HiUoUXGHDpIrHGESC0pw+hL4I6Ax6d
	 xCx0dZvIzWuSB4RvYmCTlpnYWpgJIjpyO3cf1xQheV6oxjcbnOblFEnlPX6e9RCZqF
	 SVRKaxyx1E9EoS0z9I/jYt9IT8dwKkcv2ee3hJhP76dj3hEzT8JE0MmZ9jClRWBMN2
	 i43v9gle9oJ7w==
Date: Thu, 25 Apr 2024 15:38:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Yang Jihong <yangjihong1@huawei.com>, Kaige Ye <ye@kaige.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: Remove evlist__add_default_attrs use
 strings
Message-ID: <ZiqjETgUVbOjob6-@x1>
References: <20240409162746.2388013-1-irogers@google.com>
 <ebffeac3-8758-4674-bad7-8a8d24c14b6f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebffeac3-8758-4674-bad7-8a8d24c14b6f@linux.intel.com>

On Thu, Apr 18, 2024 at 09:13:15AM -0400, Liang, Kan wrote:
> On 2024-04-09 12:27 p.m., Ian Rogers wrote:
> > add_default_atttributes would add evsels by having pre-created
> > perf_event_attr, however, this needed fixing for hybrid as the
> > extended PMU type was necessary for each core PMU. The logic for this
> > was in an arch specific x86 function and wasn't present for ARM,
> > meaning that default events weren't being opened on all PMUs on
> > ARM. Change the creation of the default events to use parse_events and
> > strings as that will open the events on all PMUs.
> > 
> > Rather than try to detect events on PMUs before parsing, parse the
> > event but skip its output in stat-display.
> > 
> > The previous order of hardware events was: cycles,
> > stalled-cycles-frontend, stalled-cycles-backend, instructions. As
> > instructions is a more fundamental concept the order is changed to:
> > instructions, cycles, stalled-cycles-frontend, stalled-cycles-backend.
> > 
> > Closes: https://lore.kernel.org/lkml/CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> I got the confirmation that the re-order is ok for their tools.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

This one is only partially applying, can you please check?

⬢[acme@toolbox perf-tools-next]$ patch -p1 < v2_20240409_irogers_perf_stat_remove_evlist__add_default_attrs_use_strings.mbx 
patching file tools/perf/arch/x86/util/evlist.c
patching file tools/perf/builtin-stat.c
Hunk #2 FAILED at 1972.
Hunk #3 FAILED at 1988.
Hunk #4 FAILED at 2026.
Hunk #5 succeeded at 2636 (offset 5 lines).
3 out of 5 hunks FAILED -- saving rejects to file tools/perf/builtin-stat.c.rej
patching file tools/perf/util/evlist.c
patching file tools/perf/util/evlist.h
patching file tools/perf/util/stat-display.c
⬢[acme@toolbox perf-tools-next]$

- Arnaldo
 
> Thanks,
> Kan
> 
> > ---
> > v2. Avoid unnecessary newlines for skipped events. Add commit message
> >     comment wrt hardware events being reordered.
> > ---
> >  tools/perf/arch/x86/util/evlist.c |  74 +-------
> >  tools/perf/builtin-stat.c         | 291 ++++++++++++------------------
> >  tools/perf/util/evlist.c          |  43 -----
> >  tools/perf/util/evlist.h          |  12 --
> >  tools/perf/util/stat-display.c    |   4 +
> >  5 files changed, 119 insertions(+), 305 deletions(-)
> > 
> > diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> > index b1ce0c52d88d..fb8e314aa364 100644
> > --- a/tools/perf/arch/x86/util/evlist.c
> > +++ b/tools/perf/arch/x86/util/evlist.c
> > @@ -1,78 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include <stdio.h>
> > -#include "util/pmu.h"
> > -#include "util/pmus.h"
> > -#include "util/evlist.h"
> > -#include "util/parse-events.h"
> > -#include "util/event.h"
> > +#include <string.h>
> > +#include "../../../util/evlist.h"
> > +#include "../../../util/evsel.h"
> >  #include "topdown.h"
> >  #include "evsel.h"
> >  
> > -static int ___evlist__add_default_attrs(struct evlist *evlist,
> > -					struct perf_event_attr *attrs,
> > -					size_t nr_attrs)
> > -{
> > -	LIST_HEAD(head);
> > -	size_t i = 0;
> > -
> > -	for (i = 0; i < nr_attrs; i++)
> > -		event_attr_init(attrs + i);
> > -
> > -	if (perf_pmus__num_core_pmus() == 1)
> > -		return evlist__add_attrs(evlist, attrs, nr_attrs);
> > -
> > -	for (i = 0; i < nr_attrs; i++) {
> > -		struct perf_pmu *pmu = NULL;
> > -
> > -		if (attrs[i].type == PERF_TYPE_SOFTWARE) {
> > -			struct evsel *evsel = evsel__new(attrs + i);
> > -
> > -			if (evsel == NULL)
> > -				goto out_delete_partial_list;
> > -			list_add_tail(&evsel->core.node, &head);
> > -			continue;
> > -		}
> > -
> > -		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> > -			struct perf_cpu_map *cpus;
> > -			struct evsel *evsel;
> > -
> > -			evsel = evsel__new(attrs + i);
> > -			if (evsel == NULL)
> > -				goto out_delete_partial_list;
> > -			evsel->core.attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
> > -			cpus = perf_cpu_map__get(pmu->cpus);
> > -			evsel->core.cpus = cpus;
> > -			evsel->core.own_cpus = perf_cpu_map__get(cpus);
> > -			evsel->pmu_name = strdup(pmu->name);
> > -			list_add_tail(&evsel->core.node, &head);
> > -		}
> > -	}
> > -
> > -	evlist__splice_list_tail(evlist, &head);
> > -
> > -	return 0;
> > -
> > -out_delete_partial_list:
> > -	{
> > -		struct evsel *evsel, *n;
> > -
> > -		__evlist__for_each_entry_safe(&head, n, evsel)
> > -			evsel__delete(evsel);
> > -	}
> > -	return -1;
> > -}
> > -
> > -int arch_evlist__add_default_attrs(struct evlist *evlist,
> > -				   struct perf_event_attr *attrs,
> > -				   size_t nr_attrs)
> > -{
> > -	if (!nr_attrs)
> > -		return 0;
> > -
> > -	return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
> > -}
> > -
> >  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
> >  {
> >  	if (topdown_sys_has_perf_metrics() &&
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 65388c57bb5d..e7de32a8c10c 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1944,130 +1944,25 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
> >  }
> >  
> >  /*
> > - * Add default attributes, if there were no attributes specified or
> > + * Add default events, if there were no attributes specified or
> >   * if -d/--detailed, -d -d or -d -d -d is used:
> >   */
> > -static int add_default_attributes(void)
> > +static int add_default_events(void)
> >  {
> > -	struct perf_event_attr default_attrs0[] = {
> > -
> > -  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
> > -  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CONTEXT_SWITCHES	},
> > -  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CPU_MIGRATIONS		},
> > -  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_PAGE_FAULTS		},
> > -
> > -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_CPU_CYCLES		},
> > -};
> > -	struct perf_event_attr frontend_attrs[] = {
> > -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_FRONTEND	},
> > -};
> > -	struct perf_event_attr backend_attrs[] = {
> > -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_BACKEND	},
> > -};
> > -	struct perf_event_attr default_attrs1[] = {
> > -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_INSTRUCTIONS		},
> > -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS	},
> > -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_MISSES		},
> > -
> > -};
> > -
> > -/*
> > - * Detailed stats (-d), covering the L1 and last level data caches:
> > - */
> > -	struct perf_event_attr detailed_attrs[] = {
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_LL			<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_LL			<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> > -};
> > -
> > -/*
> > - * Very detailed stats (-d -d), covering the instruction cache and the TLB caches:
> > - */
> > -	struct perf_event_attr very_detailed_attrs[] = {
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_L1I		<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_L1I		<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_DTLB		<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_DTLB		<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_ITLB		<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_ITLB		<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> > -
> > -};
> > +	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
> > +	struct parse_events_error err;
> > +	struct evlist *evlist = evlist__new();
> > +	struct evsel *evsel;
> > +	int ret = 0;
> >  
> > -/*
> > - * Very, very detailed stats (-d -d -d), adding prefetch events:
> > - */
> > -	struct perf_event_attr very_very_detailed_attrs[] = {
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> > -
> > -  { .type = PERF_TYPE_HW_CACHE,
> > -    .config =
> > -	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
> > -	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
> > -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> > -};
> > +	if (!evlist)
> > +		return -ENOMEM;
> >  
> > -	struct perf_event_attr default_null_attrs[] = {};
> > -	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
> > +	parse_events_error__init(&err);
> >  
> >  	/* Set attrs if no event is selected and !null_run: */
> >  	if (stat_config.null_run)
> > -		return 0;
> > +		goto out;
> >  
> >  	if (transaction_run) {
> >  		/* Handle -T as -M transaction. Once platform specific metrics
> > @@ -2077,15 +1972,17 @@ static int add_default_attributes(void)
> >  		 */
> >  		if (!metricgroup__has_metric(pmu, "transaction")) {
> >  			pr_err("Missing transaction metrics\n");
> > -			return -1;
> > +			ret = -1;
> > +			goto out;
> >  		}
> > -		return metricgroup__parse_groups(evsel_list, pmu, "transaction",
> > +		ret = metricgroup__parse_groups(evlist, pmu, "transaction",
> >  						stat_config.metric_no_group,
> >  						stat_config.metric_no_merge,
> >  						stat_config.metric_no_threshold,
> >  						stat_config.user_requested_cpu_list,
> >  						stat_config.system_wide,
> >  						&stat_config.metric_events);
> > +		goto out;
> >  	}
> >  
> >  	if (smi_cost) {
> > @@ -2093,32 +1990,36 @@ static int add_default_attributes(void)
> >  
> >  		if (sysfs__read_int(FREEZE_ON_SMI_PATH, &smi) < 0) {
> >  			pr_err("freeze_on_smi is not supported.\n");
> > -			return -1;
> > +			ret = -1;
> > +			goto out;
> >  		}
> >  
> >  		if (!smi) {
> >  			if (sysfs__write_int(FREEZE_ON_SMI_PATH, 1) < 0) {
> > -				fprintf(stderr, "Failed to set freeze_on_smi.\n");
> > -				return -1;
> > +				pr_err("Failed to set freeze_on_smi.\n");
> > +				ret = -1;
> > +				goto out;
> >  			}
> >  			smi_reset = true;
> >  		}
> >  
> >  		if (!metricgroup__has_metric(pmu, "smi")) {
> >  			pr_err("Missing smi metrics\n");
> > -			return -1;
> > +			ret = -1;
> > +			goto out;
> >  		}
> >  
> >  		if (!force_metric_only)
> >  			stat_config.metric_only = true;
> >  
> > -		return metricgroup__parse_groups(evsel_list, pmu, "smi",
> > +		ret = metricgroup__parse_groups(evlist, pmu, "smi",
> >  						stat_config.metric_no_group,
> >  						stat_config.metric_no_merge,
> >  						stat_config.metric_no_threshold,
> >  						stat_config.user_requested_cpu_list,
> >  						stat_config.system_wide,
> >  						&stat_config.metric_events);
> > +		goto out;
> >  	}
> >  
> >  	if (topdown_run) {
> > @@ -2131,105 +2032,137 @@ static int add_default_attributes(void)
> >  		if (!max_level) {
> >  			pr_err("Topdown requested but the topdown metric groups aren't present.\n"
> >  				"(See perf list the metric groups have names like TopdownL1)\n");
> > -			return -1;
> > +			ret = -1;
> > +			goto out;
> >  		}
> >  		if (stat_config.topdown_level > max_level) {
> >  			pr_err("Invalid top-down metrics level. The max level is %u.\n", max_level);
> > -			return -1;
> > -		} else if (!stat_config.topdown_level)
> > +			ret = -1;
> > +			goto out;
> > +		} else if (!stat_config.topdown_level) {
> >  			stat_config.topdown_level = 1;
> > -
> > +		}
> >  		if (!stat_config.interval && !stat_config.metric_only) {
> >  			fprintf(stat_config.output,
> >  				"Topdown accuracy may decrease when measuring long periods.\n"
> >  				"Please print the result regularly, e.g. -I1000\n");
> >  		}
> >  		str[8] = stat_config.topdown_level + '0';
> > -		if (metricgroup__parse_groups(evsel_list,
> > +		if (metricgroup__parse_groups(evlist,
> >  						pmu, str,
> >  						/*metric_no_group=*/false,
> >  						/*metric_no_merge=*/false,
> >  						/*metric_no_threshold=*/true,
> >  						stat_config.user_requested_cpu_list,
> >  						stat_config.system_wide,
> > -						&stat_config.metric_events) < 0)
> > -			return -1;
> > +						&stat_config.metric_events) < 0) {
> > +			ret = -1;
> > +			goto out;
> > +		}
> >  	}
> >  
> >  	if (!stat_config.topdown_level)
> >  		stat_config.topdown_level = 1;
> >  
> > -	if (!evsel_list->core.nr_entries) {
> > +	if (!evlist->core.nr_entries) {
> >  		/* No events so add defaults. */
> >  		if (target__has_cpu(&target))
> > -			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
> > +			ret = parse_events(evlist, "cpu-clock", &err);
> > +		else
> > +			ret = parse_events(evlist, "task-clock", &err);
> > +		if (ret)
> > +			goto out;
> > +
> > +		ret = parse_events(evlist,
> > +				"context-switches,"
> > +				"cpu-migrations,"
> > +				"page-faults,"
> > +				"instructions,"
> > +				"cycles,"
> > +				"stalled-cycles-frontend,"
> > +				"stalled-cycles-backend,"
> > +				"branches,"
> > +				"branch-misses",
> > +				&err);
> > +		if (ret)
> > +			goto out;
> >  
> > -		if (evlist__add_default_attrs(evsel_list, default_attrs0) < 0)
> > -			return -1;
> > -		if (perf_pmus__have_event("cpu", "stalled-cycles-frontend")) {
> > -			if (evlist__add_default_attrs(evsel_list, frontend_attrs) < 0)
> > -				return -1;
> > -		}
> > -		if (perf_pmus__have_event("cpu", "stalled-cycles-backend")) {
> > -			if (evlist__add_default_attrs(evsel_list, backend_attrs) < 0)
> > -				return -1;
> > -		}
> > -		if (evlist__add_default_attrs(evsel_list, default_attrs1) < 0)
> > -			return -1;
> >  		/*
> >  		 * Add TopdownL1 metrics if they exist. To minimize
> >  		 * multiplexing, don't request threshold computation.
> >  		 */
> >  		if (metricgroup__has_metric(pmu, "Default")) {
> >  			struct evlist *metric_evlist = evlist__new();
> > -			struct evsel *metric_evsel;
> > -
> > -			if (!metric_evlist)
> > -				return -1;
> >  
> > +			if (!metric_evlist) {
> > +				ret = -ENOMEM;
> > +				goto out;
> > +			}
> >  			if (metricgroup__parse_groups(metric_evlist, pmu, "Default",
> >  							/*metric_no_group=*/false,
> >  							/*metric_no_merge=*/false,
> >  							/*metric_no_threshold=*/true,
> >  							stat_config.user_requested_cpu_list,
> >  							stat_config.system_wide,
> > -							&stat_config.metric_events) < 0)
> > -				return -1;
> > -
> > -			evlist__for_each_entry(metric_evlist, metric_evsel) {
> > -				metric_evsel->skippable = true;
> > -				metric_evsel->default_metricgroup = true;
> > +							&stat_config.metric_events) < 0) {
> > +				ret = -1;
> > +				goto out;
> >  			}
> > -			evlist__splice_list_tail(evsel_list, &metric_evlist->core.entries);
> > +
> > +			evlist__for_each_entry(metric_evlist, evsel)
> > +				evsel->default_metricgroup = true;
> > +
> > +			evlist__splice_list_tail(evlist, &metric_evlist->core.entries);
> >  			evlist__delete(metric_evlist);
> >  		}
> > -
> > -		/* Platform specific attrs */
> > -		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
> > -			return -1;
> >  	}
> >  
> >  	/* Detailed events get appended to the event list: */
> >  
> > -	if (detailed_run <  1)
> > -		return 0;
> > -
> > -	/* Append detailed run extra attributes: */
> > -	if (evlist__add_default_attrs(evsel_list, detailed_attrs) < 0)
> > -		return -1;
> > -
> > -	if (detailed_run < 2)
> > -		return 0;
> > -
> > -	/* Append very detailed run extra attributes: */
> > -	if (evlist__add_default_attrs(evsel_list, very_detailed_attrs) < 0)
> > -		return -1;
> > -
> > -	if (detailed_run < 3)
> > -		return 0;
> > -
> > -	/* Append very, very detailed run extra attributes: */
> > -	return evlist__add_default_attrs(evsel_list, very_very_detailed_attrs);
> > +	if (!ret && detailed_run >=  1) {
> > +		/*
> > +		 * Detailed stats (-d), covering the L1 and last level data
> > +		 * caches:
> > +		 */
> > +		ret = parse_events(evlist,
> > +				"L1-dcache-loads,"
> > +				"L1-dcache-load-misses,"
> > +				"LLC-loads,"
> > +				"LLC-load-misses",
> > +				&err);
> > +	}
> > +	if (!ret && detailed_run >=  2) {
> > +		/*
> > +		 * Very detailed stats (-d -d), covering the instruction cache
> > +		 * and the TLB caches:
> > +		 */
> > +		ret = parse_events(evlist,
> > +				"L1-icache-loads,"
> > +				"L1-icache-load-misses,"
> > +				"dTLB-loads,"
> > +				"dTLB-load-misses,"
> > +				"iTLB-loads,"
> > +				"iTLB-load-misses",
> > +				&err);
> > +	}
> > +	if (!ret && detailed_run >=  3) {
> > +		/*
> > +		 * Very, very detailed stats (-d -d -d), adding prefetch events:
> > +		 */
> > +		ret = parse_events(evlist,
> > +				"L1-dcache-prefetches,"
> > +				"L1-dcache-prefetch-misses",
> > +				&err);
> > +	}
> > +out:
> > +	if (!ret) {
> > +		evlist__for_each_entry(evlist, evsel)
> > +			evsel->skippable = true;
> > +	}
> > +	parse_events_error__exit(&err);
> > +	evlist__splice_list_tail(evsel_list, &evlist->core.entries);
> > +	evlist__delete(evlist);
> > +	return ret;
> >  }
> >  
> >  static const char * const stat_record_usage[] = {
> > @@ -2736,7 +2669,7 @@ int cmd_stat(int argc, const char **argv)
> >  		}
> >  	}
> >  
> > -	if (add_default_attributes())
> > +	if (add_default_events())
> >  		goto out;
> >  
> >  	if (stat_config.cgroup_list) {
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 55a300a0977b..de498ba5ac1c 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -314,49 +314,6 @@ struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
> >  }
> >  #endif
> >  
> > -int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
> > -{
> > -	struct evsel *evsel, *n;
> > -	LIST_HEAD(head);
> > -	size_t i;
> > -
> > -	for (i = 0; i < nr_attrs; i++) {
> > -		evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries + i);
> > -		if (evsel == NULL)
> > -			goto out_delete_partial_list;
> > -		list_add_tail(&evsel->core.node, &head);
> > -	}
> > -
> > -	evlist__splice_list_tail(evlist, &head);
> > -
> > -	return 0;
> > -
> > -out_delete_partial_list:
> > -	__evlist__for_each_entry_safe(&head, n, evsel)
> > -		evsel__delete(evsel);
> > -	return -1;
> > -}
> > -
> > -int __evlist__add_default_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
> > -{
> > -	size_t i;
> > -
> > -	for (i = 0; i < nr_attrs; i++)
> > -		event_attr_init(attrs + i);
> > -
> > -	return evlist__add_attrs(evlist, attrs, nr_attrs);
> > -}
> > -
> > -__weak int arch_evlist__add_default_attrs(struct evlist *evlist,
> > -					  struct perf_event_attr *attrs,
> > -					  size_t nr_attrs)
> > -{
> > -	if (!nr_attrs)
> > -		return 0;
> > -
> > -	return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
> > -}
> > -
> >  struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
> >  {
> >  	struct evsel *evsel;
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index cb91dc9117a2..947a78cbd7f0 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -100,18 +100,6 @@ void evlist__delete(struct evlist *evlist);
> >  void evlist__add(struct evlist *evlist, struct evsel *entry);
> >  void evlist__remove(struct evlist *evlist, struct evsel *evsel);
> >  
> > -int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs);
> > -
> > -int __evlist__add_default_attrs(struct evlist *evlist,
> > -				     struct perf_event_attr *attrs, size_t nr_attrs);
> > -
> > -int arch_evlist__add_default_attrs(struct evlist *evlist,
> > -				   struct perf_event_attr *attrs,
> > -				   size_t nr_attrs);
> > -
> > -#define evlist__add_default_attrs(evlist, array) \
> > -	arch_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
> > -
> >  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs);
> >  
> >  int evlist__add_dummy(struct evlist *evlist);
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index bfc1d705f437..b117a2716306 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -936,6 +936,10 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
> >  	struct perf_cpu cpu;
> >  	int idx;
> >  
> > +	/* Skip events added by default that may not be supported. */
> > +	if (!counter->supported && counter->skippable)
> > +		return true;
> > +
> >  	/*
> >  	 * Skip value 0 when enabling --per-thread globally,
> >  	 * otherwise it will have too many 0 output.

