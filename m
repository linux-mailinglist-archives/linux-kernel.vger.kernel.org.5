Return-Path: <linux-kernel+bounces-46381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E8C843EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3491F2E28B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEF778679;
	Wed, 31 Jan 2024 11:49:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9175762CD;
	Wed, 31 Jan 2024 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701779; cv=none; b=jIDcmi/Ack/f10Cz2ro4aQVrW0FPwp0nl45ZIiQygS09F59ZHlOuI9iYohs1kr1rbudW5Po7Fa/or/MyX1aBUPYbzPk7J8drtOpAEvzuigxWDWnIl/3bk0NixezK7Z+0L4ige68TUXkJFVgZfJGfYx2ao3yaZtY9kq/ur2RjnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701779; c=relaxed/simple;
	bh=nNBvwGN3Qzrse8P9zdKsKXcXa8SriG4C7OAqUvqwmBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=U7MxAX8kvjoedUYOVmXOolnCqndrSCqj9OBgf7bnHhL59cNAmlJhznqlQFZevfrP9VA+3vLEPRklZc6ME8nsvo+eshqLpMnw/9NAYm67LMbQCVnlZ/R8T3AgN6ZDrkUbRxssq440+ec4YT7Sn5YrfaLY2WetwHZY1dfsGATbOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D088CDA7;
	Wed, 31 Jan 2024 03:50:20 -0800 (PST)
Received: from [192.168.1.216] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AC3A3F738;
	Wed, 31 Jan 2024 03:49:34 -0800 (PST)
Message-ID: <9dd303cb-0455-d8ac-ce0c-f4a8320b787b@arm.com>
Date: Wed, 31 Jan 2024 11:49:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/2] perf parse-events: Improve error location of terms
 cloned from an event
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20240131063048.492010-1-irogers@google.com>
 <20240131063048.492010-2-irogers@google.com>
From: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, tchen168@asu.edu,
 Michael Petlan <mpetlan@redhat.com>
In-Reply-To: <20240131063048.492010-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/01/2024 06:30, Ian Rogers wrote:
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

Hi Ian,

I went to test this, but since b30d4f0b6954 ("perf parse-events:
Additional error reporting") I don't get this size error message
anymore, just a "bad event/PMU not found" type error. I'm not sure if
this is something Arm specific, or you're seeing the same thing?

Before b30d4f0b6954:

  $ perf record -e bus_access_rd/long=2
  event syntax error: '..ss_rd/long=2/'
                                  \___ value too big for format, maximum
                                       is 1

  Initial error:
  event syntax error: 'bus_access_rd/long=2/'
                     \___ Cannot find PMU `bus_access_rd'. Missing
                          kernel support?
  Run 'perf list' for a list of valid events

   Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
      available events

After b30d4f0b6954:

  $ perf record -e bus_access_rd/long=2
  event syntax error: '..ss_rd/long=2/'
                                  \___ Bad event or PMU

  Unabled to find PMU or event on a PMU of 'bus_access_rd'

  Initial error:
  event syntax error: 'bus_access_rd/long=2/'
                     \___ Cannot find PMU `bus_access_rd'. Missing
                          kernel support?

  Run 'perf list' for a list of valid events

   Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
      available events


