Return-Path: <linux-kernel+bounces-14790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAA1822260
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D3B1C22A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A11516406;
	Tue,  2 Jan 2024 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dl9CJUJO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2D516403;
	Tue,  2 Jan 2024 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704225720; x=1735761720;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ZzNLwZei4UTjNUVOOX20ifwyIcGd2ynpP3sXx3hreLM=;
  b=dl9CJUJOAJZy6lyTF8mZr5qQa8Y+8zDDYKZKVBcq46m7jADRx5yyHX+Q
   5OPatWz9JoJB0HzKp737PL9dygGXoVdZpFrKq0kYb6Q4B9NbIVx8a1HMF
   g6o9ebh70GfAQySd6tLfWFNrMm18MSH8MlYF/H8MbirzkoYq/KWucoYLr
   lShJtUVhpyX/ceA+cALgNEVgiiwT6HgrXplaakAorqRrPUIWbIBT7gEYM
   FqYdPPm6ZriNlb0bhRBLNJX51BygO7xhXtBZvkgLSzmIKmsKW+ufdvlDd
   PajMs/9PHTxOEV53ybHI21q+sCT5It9bOkExJZLCCgVB1y0l9qsspJiny
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="15556598"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="15556598"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 12:02:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="845664807"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="845664807"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 12:01:58 -0800
Received: from [10.212.82.180] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A2565580BF8;
	Tue,  2 Jan 2024 12:01:56 -0800 (PST)
Message-ID: <cbc91c86-e6ea-4a97-8b61-5594d3cdbc81@linux.intel.com>
Date: Tue, 2 Jan 2024 15:01:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf stat: Fix hard coded ll miss units
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guillaume Endignoux <guillaumee@google.com>
References: <20231211181242.1721059-1-irogers@google.com>
 <CAP-5=fVWZ7etZq7YBU1HGMnyJ6wsZ3zok9JuS7eWQsTKuqzrAA@mail.gmail.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVWZ7etZq7YBU1HGMnyJ6wsZ3zok9JuS7eWQsTKuqzrAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-01-02 2:34 p.m., Ian Rogers wrote:
> On Mon, Dec 11, 2023 at 10:13 AM Ian Rogers <irogers@google.com> wrote:
>>
>> Copy-paste error where LL cache misses are reported as l1i.
>>
>> Suggested-by: Guillaume Endignoux <guillaumee@google.com>
>> Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
>> Signed-off-by: Ian Rogers <irogers@google.com>
>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> Ping. Trivial 1 character fix but no reviews :-(
> 
> Thanks,
> Ian
> 
>> ---
>>  tools/perf/util/stat-shadow.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>> index 1c5c3eeba4cf..e31426167852 100644
>> --- a/tools/perf/util/stat-shadow.c
>> +++ b/tools/perf/util/stat-shadow.c
>> @@ -264,7 +264,7 @@ static void print_ll_miss(struct perf_stat_config *config,
>>         static const double color_ratios[3] = {20.0, 10.0, 5.0};
>>
>>         print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, color_ratios,
>> -                   "of all L1-icache accesses");
>> +                   "of all LL-cache accesses");
>>  }
>>
>>  static void print_dtlb_miss(struct perf_stat_config *config,
>> --
>> 2.43.0.472.g3155946c3a-goog
>>
> 

