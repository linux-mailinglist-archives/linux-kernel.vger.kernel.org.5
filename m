Return-Path: <linux-kernel+bounces-103247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BDD87BCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068231F25C05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C3A5789B;
	Thu, 14 Mar 2024 12:34:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4440550A87;
	Thu, 14 Mar 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419678; cv=none; b=EnkHn4e9O8eh0xUViArp4tYvcQAW/BkavppiS9g1NsZDQskXjk1J3tk+y4K7qeiynGCkMtVFZ7W0FeJLiDOiwTcnjTP7EjwNIfgWjo6w4VhMYzCl1QAkDed13wQOkaZ6wOaJxdzBhqfNZ69v/I+/xdDI2flEHPoL6F2uosu1nMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419678; c=relaxed/simple;
	bh=/h9fFk1XTjWgWaiifBl0FurCH2uEbyC1rYJ1sSa+lq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irnt7iBBShYXr/Ib3GcW5HjgG++0DJG4C21SlA5uRKgV9/28sub3zjJgbXkqHy2++SWTu+vC3c5jYi/SgB0S4xtoJJ4OsWQpGcrkrvQibNtK94kIt5/lFX+DMPiGFzzrgiLJXcCVO2YtBQbypRjzqe41qBkLtAuVzh5Mx44MrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D6221007;
	Thu, 14 Mar 2024 05:35:11 -0700 (PDT)
Received: from [10.57.50.244] (unknown [10.57.50.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D58393F73F;
	Thu, 14 Mar 2024 05:34:32 -0700 (PDT)
Message-ID: <7ebe3c5f-577b-4c67-b8b9-14e8ed6429bf@arm.com>
Date: Thu, 14 Mar 2024 12:34:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] perf: Add capability for common event support
Content-Language: en-GB
To: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org
References: <cover.1710257512.git.robin.murphy@arm.com>
 <feb10873fe9e4e10b5ffbbe8e296c8a45632e3c2.1710257512.git.robin.murphy@arm.com>
 <94DB0209EA3D1C5F+b646f31e-15a1-4753-8309-687b5860863e@shingroup.cn>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <94DB0209EA3D1C5F+b646f31e-15a1-4753-8309-687b5860863e@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-03-14 8:09 am, Yang Jialong 杨佳龙 wrote:
> 
> 
> 在 2024/3/13 1:34, Robin Murphy 写道:
>> Many PMUs do not support common hardware/cache/etc. events and only
>> handle their own PMU-specific events. Since this only depends on
>> matching the event and PMU types, it's a prime candidate for a core
>> capability to save more event_init boilerplate in drivers.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   include/linux/perf_event.h | 1 +
>>   kernel/events/core.c       | 5 +++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index d2a15c0c6f8a..983201f21dd2 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -291,6 +291,7 @@ struct perf_event_pmu_context;
>>   #define PERF_PMU_CAP_NO_EXCLUDE            0x0040
>>   #define PERF_PMU_CAP_AUX_OUTPUT            0x0080
>>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE        0x0100
>> +#define PERF_PMU_CAP_NO_COMMON_EVENTS        0x0200
>>   struct perf_output_handle;
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index f0f0f71213a1..7ad80826c218 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -11649,6 +11649,11 @@ static int perf_try_init_event(struct pmu 
>> *pmu, struct perf_event *event)
>>       struct perf_event_context *ctx = NULL;
>>       int ret;
>> +    /* Short-circuit if we know the PMU won't want this event */
>> +    if (pmu->capabilities & PERF_PMU_CAP_NO_COMMON_EVENTS &&
>> +        event->attr.type != pmu->type)
>> +        return -ENOENT;
>> +
> 
>          /*
>           * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
>           * are often aliases for PERF_TYPE_RAW.
>           */
>          type = event->attr.type;
>          if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
>                  type = event->attr.config >> PERF_PMU_TYPE_SHIFT;
>                  if (!type) {
>                          type = PERF_TYPE_RAW;
>                  } else {
>                          extended_type = true;
>                          event->attr.config &= PERF_HW_EVENT_MASK;
>                  }
>          }
> 
> again:
>          rcu_read_lock();
>          pmu = idr_find(&pmu_idr, type);
>          rcu_read_unlock();
>          if (pmu) {
> Above code tells me it's possible that 'pmu->type != event->attr.type' 
> is true when event->attr.type equals to PERF_TYPE_HARDWARE or 
> PERF_TYPE_HW_CACHE, and pmu->type should equal to event->attr.config >> 
> PERF_PMU_TYPE_SHIFT.
> 
> We find the target pmu by event->attr.config >> PERF_PMU_TYPE_SHIFT.

And if that PMU doesn't actually support PERF_TYPE_HARDWARE or 
PERF_TYPE_HW_CACHE then it would reject the event, if the very next 
lines didn't already do that:

	if (event->attr.type != type && type != PERF_TYPE_RAW &&
	    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
		goto fail;

Either way it should be clear that there's no change of functionality 
here since the flow into perf_try_init_event() itself is untouched.

> Code added discard this option.

It would already be nonsensical for a driver to advertise 
PERF_PMU_CAP_EXTENDED_HW_TYPE to say it supports extended hardware 
events, but then reject all hardware events with a "event->attr.type != 
pmu->type" check in its event_init. Reworking the latter condition into 
PERF_PMU_CAP_NO_COMMON_EVENTS doesn't change that.

Thanks,
Robin.

> 
> And code tells me that no try. Target PMU is doubtless.
> 
> 
> 
> 
>>       if (!try_module_get(pmu->module))
>>           return -ENODEV;
> 

