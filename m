Return-Path: <linux-kernel+bounces-48270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A40845963
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B534296771
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CF85D467;
	Thu,  1 Feb 2024 13:54:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CBC5CDEE;
	Thu,  1 Feb 2024 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795681; cv=none; b=lJHouiv0B1gz2ArVqB8ieXUoRAza132RKieKdpJ/+956vwpzp6+NnFXsm5jSqw2h/7ugWnU+urcEzm/iTYwfESADsHoywdM7k/OTZeaCkH2nPQNPAMsPH/nI/u90tVhTytSt0954B9YHeLXqwzn0Yj5owJJW98GcZHB94GrYVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795681; c=relaxed/simple;
	bh=6FczZ0VQ709m5DpMCw3jObhCo/9EEQJjT+b7Zh1i64A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JTFticme/jDi0wKmfgBsGoL8oqVpoeL9BggGRDLPohLD7bJgSTW0mCtxo21Ak4FnVxV7dIRhDZADElbacFd3PZtZYxcGt0MhMD5AEnaBM4mTUdFbIwHTZPz8jX/aTAOLC3KxYn7bjlPwmIGzNFkct9U7q4fuy/vDESsomdCvXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56421DA7;
	Thu,  1 Feb 2024 05:55:21 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD2943F762;
	Thu,  1 Feb 2024 05:54:35 -0800 (PST)
Message-ID: <f98d310e-5e25-2e71-0159-7b598d15f1ee@arm.com>
Date: Thu, 1 Feb 2024 13:54:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] perf parse-events: Improve error location of terms
 cloned from an event
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20240131134940.593788-1-irogers@google.com>
 <20240131134940.593788-2-irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, tchen168@asu.edu,
 Michael Petlan <mpetlan@redhat.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240131134940.593788-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/01/2024 13:49, Ian Rogers wrote:
> A PMU event/alias will have a set of format terms that replace it when
> an event is parsed. The location of the terms is their position when
> parsed for the event/alias either from sysfs or json. This location is
> of little use when an event fails to parse as the error will be given
> in terms of the location in the string of events parsed not the json
> or sysfs string. Fix this by making the cloned terms location that of
> the event/alias.
> 
> If a cloned term from an event/alias is invalid the bad format is hard
> to determine from the error string. Add the name of the bad format
> into the error string.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
> These fixes were inspired by the poor error output in:
> https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2401300733310.11354@Diego/
> ---
>  tools/perf/util/pmu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 355f813f960d..437386dedd5c 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -657,7 +657,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
>  	return 0;
>  }
>  
> -static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
> +static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, struct list_head *terms)
>  {
>  	struct parse_events_term *term, *cloned;
>  	struct parse_events_terms clone_terms;
> @@ -675,6 +675,7 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
>  		 * which we don't want for implicit terms in aliases.
>  		 */
>  		cloned->weak = true;
> +		cloned->err_term = cloned->err_val = err_loc;
>  		list_add_tail(&cloned->list, &clone_terms.terms);
>  	}
>  	list_splice_init(&clone_terms.terms, terms);
> @@ -1363,8 +1364,8 @@ static int pmu_config_term(const struct perf_pmu *pmu,
>  
>  			parse_events_error__handle(err, term->err_val,
>  				asprintf(&err_str,
> -				    "value too big for format, maximum is %llu",
> -				    (unsigned long long)max_val) < 0
> +				    "value too big for format (%s), maximum is %llu",
> +				    format->name, (unsigned long long)max_val) < 0
>  				    ? strdup("value too big for format")
>  				    : err_str,
>  				    NULL);
> @@ -1518,7 +1519,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
>  		alias = pmu_find_alias(pmu, term);
>  		if (!alias)
>  			continue;
> -		ret = pmu_alias_terms(alias, &term->list);
> +		ret = pmu_alias_terms(alias, term->err_term, &term->list);
>  		if (ret) {
>  			parse_events_error__handle(err, term->err_term,
>  						strdup("Failure to duplicate terms"),

