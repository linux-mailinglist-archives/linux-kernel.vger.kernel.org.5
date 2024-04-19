Return-Path: <linux-kernel+bounces-151828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED18AB47B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3E4283189
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B432513AD1E;
	Fri, 19 Apr 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXUBRGPT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBF61E502;
	Fri, 19 Apr 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713548360; cv=none; b=doDAG64QnSLqJeHEncXjjiVRceIqlfZ2V+RBg5CgOl8aWde8MMAr6hazplHikzlaCaawKVeDPj/BqaY1WBgyvihi0NZrAYEp1c44BqpIuEZxprkWTdbFvHMR865wSJa4MKnaTfchGFWQ7CNrd8VTShdYfZNhckdEhPbHy5C+tww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713548360; c=relaxed/simple;
	bh=egomz0dkv+9Z1yRTjfyd7lOlDCkC6LjVsnzKLTSQhBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEf5MhKvLEOr9eXG2vJXTgL42/Ls48hL/ReufH1KSGRJtC3SUjejVGkXfGmr/He62uHeCPShrxm/Poh+ujddeSNk5vBW9+stDLmT1m7tJNquIQ5Olz02FQo8OZ9FoEx7dcAgI9dFSpgVp9IXdT+VxzwhSE89u0op1Eevb8n6U7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXUBRGPT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713548358; x=1745084358;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=egomz0dkv+9Z1yRTjfyd7lOlDCkC6LjVsnzKLTSQhBY=;
  b=iXUBRGPTp3TgcAZVHpwrzV9SfalPm9s89MvcDX1VmxpKrmcXLQQoHXSS
   jpf0h3wlkbRfaYNNoGG/AO62RK24Roqm20EW+mK86YckLWJ57k/IxQBu4
   tbeEvEEVdbgS7MV97CznDdnOtFz6NbdsLUmGRgPXpX2Igj60GqkEtaP+Z
   CDRCA8kOj9h4qWghrJqusnlIU+Q39OO0cACHyEKCh7a47ukOww8NOfjf3
   x+cmgKv8jvNmzXnwER/Jyej5NjXVZUYbOJ3VXtLIjEkB8rgtKH7ce8a/y
   2wTjAW6jOrJCaKBSRjB8Vd6XuczOOKOKwnNGn7Arj8FKC0hMss2enqqPE
   g==;
X-CSE-ConnectionGUID: aqDWnyfoQ66ProuzRbKOcw==
X-CSE-MsgGUID: 1c9h5nybT/y1TuGds297oA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9024728"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="9024728"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:39:17 -0700
X-CSE-ConnectionGUID: eVE5Zi8ATUCma1WZUlKQQw==
X-CSE-MsgGUID: cJCMK+1XRheZCLYcEQK02w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="46692820"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:39:17 -0700
Received: from [10.212.13.6] (kliang2-mobl1.ccr.corp.intel.com [10.212.13.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 813DB206DFDC;
	Fri, 19 Apr 2024 10:39:15 -0700 (PDT)
Message-ID: <7665c86e-b785-4052-9022-49fe8577c303@linux.intel.com>
Date: Fri, 19 Apr 2024 13:39:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Avoid hard coded metrics in stat std output
 test
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417183219.1208493-1-irogers@google.com>
 <c68bf005-af20-4995-86d5-a62e171763e3@linux.intel.com>
 <CAP-5=fUG_b6e9Q=qMFMtuKpzvz7D1xoLXNxeyfqwyX8qSsBwsg@mail.gmail.com>
 <b48c2040-7ee9-40a4-a97e-54bcb82cfc3e@linux.intel.com>
 <CAP-5=fV-mGX7QXT4G=VyzWjL5_AJuZ_69aj6JYbV8NVhuy-8TA@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fV-mGX7QXT4G=VyzWjL5_AJuZ_69aj6JYbV8NVhuy-8TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-04-19 11:23 a.m., Ian Rogers wrote:
> On Fri, Apr 19, 2024 at 8:09 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-04-19 10:40 a.m., Ian Rogers wrote:
>>> On Fri, Apr 19, 2024 at 6:54 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024-04-17 2:32 p.m., Ian Rogers wrote:
>>>>> Hard coded metric names fail on ARM testing.
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>> ---
>>>>>  tools/perf/tests/shell/stat+std_output.sh | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
>>>>> index cbf2894b2c84..845f83213855 100755
>>>>> --- a/tools/perf/tests/shell/stat+std_output.sh
>>>>> +++ b/tools/perf/tests/shell/stat+std_output.sh
>>>>> @@ -13,7 +13,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_outputstd.XXXXX)
>>>>>
>>>>>  event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
>>>>>  event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
>>>>> -skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound")
>>>>> +skip_metric=($(perf list --raw Default 2> /dev/null))
>>>>
>>>>
>>>> The "perf list --raw Default" only gives the topdown metrics.
>>>> The "stalled cycles per insn" is not covered.
>>>> The check should skip the line of "stalled cycles per insn" as well.
>>>>
>>>>      3,856,436,920 stalled-cycles-frontend   #   74.09% frontend cycles idle
>>>>      1,600,790,871 stalled-cycles-backend    #   30.75% backend  cycles idle
>>>>      2,603,501,247 instructions              #    0.50  insns per cycle
>>>>                                              #    1.48  stalled cycles
>>>> per insn
>>>>        484,357,498 branches                  #  283.455 M/sec
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-stat.c#n24
>>>>
>>>> The newer Intel CPU doesn't have the stalled-cycles-* events. But it
>>>> seems power and older x86 CPU have the events.
>>>
>>> Oh, sigh. This test should really ignore lines like that. How much do
>>> we care about these metrics? The RISC-V event parsing change:
>>> https://lore.kernel.org/lkml/20240416061533.921723-1-irogers@google.com/
>>> means that legacy hardware events will be uncommon and we need to
>>> adapt the hard coded metrics in stat-shadow.c to json ones. Once they
>>> are json metrics they will be in Default.
>>
>> It seems except the newer Intel CPU, all the other ARCHs support the two
>> stalled-cycles-* events and the metric. For Intel, there are Topdown
>> metrics. But it seems an important metrics for the other ARCHs.
>>
>> RISC-V
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/riscv_pmu_sbi.c#n134
>> Power
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/perf/power9-pmu.c#n279
>> Arm
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_pmuv3.c#n53
>>
>> So almost all json files have to be updated. I'm not sure if it's a
>> practical way to fix the issue.
> 
> So I'd very much like to get rid of the hard coded metrics:
>  - they don't use or respect event groups,
>  - their ad hoc printing can introduce extra metric results
> unexpectedly in output,
>  - they fall outside of optimizations like Weilin's metric event grouping work.
> I'm hoping the python json generation of metrics makes their removal practical:
> https://lore.kernel.org/lkml/20240314055919.1979781-1-irogers@google.com/
>

It seems I wasn't listed in the Cc list, so it's missed in my main
inbox. But I was added to the same series for the Arm and AMD. :)

I will take a look at the patches.

> That's a lot to get landed for this fix:
>  - 40+ patches for python based json generation.
>  - 10+ patches for parse events changes.
> So I think a version that hard codes ignoring the hard coded metrics
> is in order.

Sounds good to me.

Thanks,
Kan

