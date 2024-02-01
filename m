Return-Path: <linux-kernel+bounces-48530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854F845D48
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271121F23B41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4813E7E109;
	Thu,  1 Feb 2024 16:29:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CE27E0F7;
	Thu,  1 Feb 2024 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804978; cv=none; b=UgUQUoihobVZanaun1GAlc+z2BFln2vOfEzmsKGMhtdG3FA+Gz2DxwbsMLs4f//fSzyvSvNArtt+6X0dEZfRayNMDcZ+49HkjkzDjU7J+lGC+eZIpIlzvp6oxnfBqF94JDijFmBu4zDlsZ4vdGnj5JaER98pJfJJ/Zvrh83HDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804978; c=relaxed/simple;
	bh=t/R3Rd5j1ZopSjwuU3Ihq0mN+ll9tFu0mR7SnKDgZhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5+Bi/w++aqvcKIVk0pSUAEbXESQ4ed24UjWIZm9ICnPWOhfSvp2UqN8ISS+k1hmLyfWttRkEu4kpEneB8c9VZ/oZMjRWm0wnrowc95E4TAttDwPKUgDYf1VbV9czvEtrgch2G6jcXfdJszYy5CMeuUqwdEYkFkBslhvEMR8ix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C7A1DA7;
	Thu,  1 Feb 2024 08:30:18 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC1A63F738;
	Thu,  1 Feb 2024 08:29:32 -0800 (PST)
Message-ID: <a4c616ff-12bf-592b-b74d-407013a68cb7@arm.com>
Date: Thu, 1 Feb 2024 16:29:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4 00/11] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Yicong Yang
 <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240111081914.3123-1-adrian.hunter@intel.com>
 <31bae596-ecb1-4b9c-9f1c-aaec4bcefd38@intel.com>
 <CAP-5=fUo96EABpH6=7i2cXFmZhAB2MM=UsnG-+vL4HJtLGS=bA@mail.gmail.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fUo96EABpH6=7i2cXFmZhAB2MM=UsnG-+vL4HJtLGS=bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 31/01/2024 16:53, Ian Rogers wrote:
> On Mon, Jan 29, 2024 at 4:49 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 11/01/24 10:19, Adrian Hunter wrote:
>>> Hi
>>>
>>> Hardware traces, such as instruction traces, can produce a vast amount of
>>> trace data, so being able to reduce tracing to more specific circumstances
>>> can be useful.
>>>
>>> The ability to pause or resume tracing when another event happens, can do
>>> that.
>>>
>>> These patches add such a facilty and show how it would work for Intel
>>> Processor Trace.
>>>
>>> Maintainers of other AUX area tracing implementations are requested to
>>> consider if this is something they might employ and then whether or not
>>> the ABI would work for them.
>>>
>>> Changes to perf tools are now (since V4) fleshed out.
>>>
>>>
>>> Changes in V4:
>>>
>>>     perf/core: Add aux_pause, aux_resume, aux_start_paused
>>>       Rename aux_output_cfg -> aux_action
>>>       Reorder aux_action bits from:
>>>               aux_pause, aux_resume, aux_start_paused
>>>       to:
>>>               aux_start_paused, aux_pause, aux_resume
>>>       Fix aux_action bits __u64 -> __u32
>>>
>>>     coresight: Have a stab at support for pause / resume
>>>       Dropped
>>>
>>>     perf tools
>>>       All new patches
>>>
>>> Changes in RFC V3:
>>>
>>>     coresight: Have a stab at support for pause / resume
>>>       'mode' -> 'flags' so it at least compiles
>>>
>>> Changes in RFC V2:
>>>
>>>       Use ->stop() / ->start() instead of ->pause_resume()
>>>       Move aux_start_paused bit into aux_output_cfg
>>>       Tighten up when Intel PT pause / resume is allowed
>>>       Add an example of how it might work for CoreSight
>>
>> Any more comments?
> 
> I think the tools side looks good. The parsing changes match the
> existing style. I wonder if it wouldn't be better to handle the valid
> strings (pause, resume, etc.) in the lexer rather than a separate
> parse function, but the pattern used matches the existing one. You can
> have my Acked-by on the tools changes, although the subtleties of ARM
> PMUs makes me somewhat nervous in this regard.
> 
> Thanks,
> Ian

Acked-by: James Clark <james.clark@arm.com>

I will get round to adding the Coresight support at some point. I
checked the new parsing in this version and it seems to work ok.

