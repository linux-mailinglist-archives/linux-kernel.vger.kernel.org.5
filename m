Return-Path: <linux-kernel+bounces-7279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF081A4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E37B271C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E34A4A99E;
	Wed, 20 Dec 2023 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjzGhrxb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EC0495F4;
	Wed, 20 Dec 2023 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703089032; x=1734625032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HfcgBMjat6uOjZsfcpcsfMsNfxWov1WpYHIcIXAxJGc=;
  b=BjzGhrxbb0MUvKdkvdsDHNRAdv0MYmhJ58DjtCI2FRBtasq3B8KwqEPv
   ZwPLcKa8uOXQyM+H60/H4REwezY82iQJbeogjDkF7Ah4i/r4oZuOCHh/n
   u9PMJmDSDqge9+da8W8S8Tipr0dtBy5lfIalwGl/BfGEf5nNI+4zxjsxf
   vRrGWYz4M/OrnBdIua8xp1bQQuO0sBFHyFZuIwJSyXevJ1StZKofDxxmf
   G8TUQHAPyT6uP9AwqoLDbRvJMWfOIq3LAebzEMTZvPplxJvBDijjxY0qg
   vP9fPBP2XyFjBXYS/V1VKpM01C+CaW/Bft4iR5tHe899pJBN+Feadz+uJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="393006985"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="393006985"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 08:17:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="24624658"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 08:17:03 -0800
Message-ID: <b37d6e3b-d9e2-48aa-b7e8-10a85c3f7aa8@intel.com>
Date: Wed, 20 Dec 2023 18:16:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V2 1/4] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
To: James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Yicong Yang
 <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20231208172449.35444-1-adrian.hunter@intel.com>
 <20231208172449.35444-2-adrian.hunter@intel.com>
 <0bbbcdb5-41eb-dd07-660a-2e5e4a0d59f0@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <0bbbcdb5-41eb-dd07-660a-2e5e4a0d59f0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/23 17:54, James Clark wrote:
> 
> 
> On 08/12/2023 17:24, Adrian Hunter wrote:
>> Hardware traces, such as instruction traces, can produce a vast amount of
>> trace data, so being able to reduce tracing to more specific circumstances
>> can be useful.
>>
>> The ability to pause or resume tracing when another event happens, can do
>> that.
>>
>> Add ability for an event to "pause" or "resume" AUX area tracing.
>>
>> Add aux_pause bit to perf_event_attr to indicate that, if the event
>> happens, the associated AUX area tracing should be paused. Ditto
>> aux_resume. Do not allow aux_pause and aux_resume to be set together.
>>
>> Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
>> event that it should start in a "paused" state.
>>
>> Add aux_paused to struct perf_event for AUX area events to keep track of
>> the "paused" state. aux_paused is initialized to aux_start_paused.
>>
>> Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
>> callbacks. Call as needed, during __perf_event_output(). Add
>> aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
>> handler. Pause/resume in NMI context will miss out if it coincides with
>> another pause/resume.
>>
>> To use aux_pause or aux_resume, an event must be in a group with the AUX
>> area event as the group leader.
>>
>> Example (requires Intel PT and tools patches also):
>>
>>  $ perf record --kcore -e '{intel_pt/aux-start-paused/k,syscalls:sys_enter_newuname/aux-resume/,syscalls:sys_exit_newuname/aux-pause/}' uname
> 
> I think it might be useful to have an aux-toggle option as well, and
> then you could do sampling if you put it on a PMU counter with an
> interval. Unless you can make two events for the same counter with
> different intervals, and one does resume and the other does pause? I'm
> not sure if that would work?

There is already ->snapshot_aux() for sampling. Is that what you mean?

> 
> Other than that it looks ok. I got Coresight working with a couple of
> changes to what you posted on here, but that can always be done more
> thoroughly later if we leave PERF_PMU_CAP_AUX_PAUSE off Coresight for now.

Thanks a lot for looking at this!


