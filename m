Return-Path: <linux-kernel+bounces-17820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1737482532C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0C2854FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDE22D035;
	Fri,  5 Jan 2024 12:00:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E812CCB2;
	Fri,  5 Jan 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F053C15;
	Fri,  5 Jan 2024 04:00:51 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.86.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BCE43F64C;
	Fri,  5 Jan 2024 04:00:03 -0800 (PST)
Date: Fri, 5 Jan 2024 12:00:00 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf x86 test: Update hybrid expectations
Message-ID: <ZZfvQOl82ehC-rEY@FVFF77S0Q05N>
References: <20240103170159.1435753-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103170159.1435753-1-irogers@google.com>

On Wed, Jan 03, 2024 at 09:01:58AM -0800, Ian Rogers wrote:
> The legacy events cpu-cycles and instructions have sysfs event
> equivalents on x86 (see /sys/devices/cpu_core/events). As sysfs/JSON
> events are now higher in priority than legacy events this causes the
> hybrid test expectations not to be met. To fix this switch to legacy
> events that don't have sysfs versions, namely cpu-cycles becomes
> cycles and instructions becomes branches.
> 
> Fixes: a24d9d9dc096 ("perf parse-events: Make legacy events lower priority than sysfs/JSON")
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZYbm5L7tw7bdpDpE@kernel.org/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/tests/hybrid.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

For both patches:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
> index eb152770f148..05a5f81e8167 100644
> --- a/tools/perf/arch/x86/tests/hybrid.c
> +++ b/tools/perf/arch/x86/tests/hybrid.c
> @@ -47,7 +47,7 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
>  	evsel = evsel__next(evsel);
>  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS));
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  	return TEST_OK;
>  }
> @@ -102,7 +102,7 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
>  	evsel = evsel__next(evsel);
>  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS));
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> @@ -171,27 +171,27 @@ struct evlist_test {
>  
>  static const struct evlist_test test__hybrid_events[] = {
>  	{
> -		.name  = "cpu_core/cpu-cycles/",
> +		.name  = "cpu_core/cycles/",
>  		.check = test__hybrid_hw_event_with_pmu,
>  		/* 0 */
>  	},
>  	{
> -		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
> +		.name  = "{cpu_core/cycles/,cpu_core/branches/}",
>  		.check = test__hybrid_hw_group_event,
>  		/* 1 */
>  	},
>  	{
> -		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
> +		.name  = "{cpu-clock,cpu_core/cycles/}",
>  		.check = test__hybrid_sw_hw_group_event,
>  		/* 2 */
>  	},
>  	{
> -		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
> +		.name  = "{cpu_core/cycles/,cpu-clock}",
>  		.check = test__hybrid_hw_sw_group_event,
>  		/* 3 */
>  	},
>  	{
> -		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
> +		.name  = "{cpu_core/cycles/k,cpu_core/branches/u}",
>  		.check = test__hybrid_group_modifier1,
>  		/* 4 */
>  	},
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

