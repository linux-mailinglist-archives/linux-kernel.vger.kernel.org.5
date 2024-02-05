Return-Path: <linux-kernel+bounces-52805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB739849CDD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F7E1C225FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368B28DD1;
	Mon,  5 Feb 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSKObrQk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF0208CF;
	Mon,  5 Feb 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142880; cv=none; b=GewXDi18/GKjcojfn/+IFjRgwfofd1ipGvJ0fK5dPpOEMK7Jnkwh2fI6ZPe+JMBxO1lwtF3VpCnJaxWeXI+Mzy9CodBq3hJ7txu3yhWD2mTjrdUfmdrWlo5ItTtf/PsUaPY0VGgsbMt0CgeI1ATQa9R6f7rT4oQ+GTqkCEZF+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142880; c=relaxed/simple;
	bh=3u7KbHsX+S1QjgtfeJzugUV7lXXZ4kqS58K2NntdhR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqOqu7WC9cYlgajuvzNRQW+yJI4xKCj2cSvt+OEJBxZt/2kNx/mEr3SLDzMm5nfagwwqAoNUI7b4rPhgcCsEESgwSojVnFtJalOVpErLnq/PeuMhQ8GYxa7BpcrTN1fGJG9HxnGdQh7gKPXWgWns2c20rhusaUUnCU9RAiL6bOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSKObrQk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707142878; x=1738678878;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3u7KbHsX+S1QjgtfeJzugUV7lXXZ4kqS58K2NntdhR8=;
  b=iSKObrQkIht4t6MC4rH/9ZxhjKr8obwv+7yVeMnsmtyUlt/aXbWcGEhG
   dkV5hMrZyoGYuzoWUnscBecrg+7i+j4yybIfDWM9xFQ1F1G8mrn2XC5CG
   H5jAYFgqynqW8wF8nP0jv/kzLiHHQt7FXz95mS3aR/p1KuktsPdnKKcVk
   wZ3BQJaslAyeEdYW1pe8Y/tbfzAcNXZ2iNCS6wX/SXcYfDDkJtvGAsKGH
   sF8fNFx4usJbuzlaaYB58tXH22YM0OMLM2ccuxqGToFOoBP+jIq0bJjDS
   14Y5pGGL47qzmzgNeV+C5022ZhXPUbEUOhQeKWD3Gr3BvNgw66xYtHfLB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="23011006"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="23011006"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="823869533"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="823869533"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.164])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:21:14 -0800
Message-ID: <f772572f-964b-426f-bd81-722ac77485de@intel.com>
Date: Mon, 5 Feb 2024 16:21:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Fix small negative period being ignored
Content-Language: en-US
To: Luo Gengkun <luogengkun2@huawei.com>
Cc: mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org
References: <20240116083915.2859302-1-luogengkun2@huawei.com>
 <66cdc5f9-a09a-4841-8fca-252b7c78114b@intel.com>
 <cc68c4f2-564a-4c42-942f-d45e71f3ef7f@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <cc68c4f2-564a-4c42-942f-d45e71f3ef7f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/01/24 09:21, Luo Gengkun wrote:
> 
> 
> 在 2024/1/19 15:36, Adrian Hunter 写道:
>> On 16/01/24 10:39, Luo Gengkun wrote:
>>> In perf_adjust_period, we will first calculate period, and then use
>>> this period to calculate delta. However, when delta is less than 0,
>>> there will be a deviation compared to when delta is greater than or
>>> equal to 0. For example, when delta is in the range of [-14,-1], the
>>> range of delta = delta + 7 is between [-7,6], so the final value of
>>> delta/8 is 0. Therefore, the impact of -1 and -2 will be ignored.
>>> This is unacceptable when the target period is very short, because
>>> we will lose a lot of samples.
>>>
>>> Here are some tests and analyzes:
>>> before:
>>>    # perf record -e cs -F 1000  ./a.out
>>>    [ perf record: Woken up 1 times to write data ]
>>>    [ perf record: Captured and wrote 0.022 MB perf.data (518 samples) ]
>>>
>>>    # perf script
>>>    ...
>>>    a.out     396   257.956048:         23 cs:  ffffffff81f4eeec schedul>
>>>    a.out     396   257.957891:         23 cs:  ffffffff81f4eeec schedul>
>>>    a.out     396   257.959730:         23 cs:  ffffffff81f4eeec schedul>
>>>    a.out     396   257.961545:         23 cs:  ffffffff81f4eeec schedul>
>>>    a.out     396   257.963355:         23 cs:  ffffffff81f4eeec schedul>
>>>    a.out     396   257.965163:         23 cs:  ffffffff81f4eeec schedul>
>>>    a.out     396   257.966973:         23 cs:  ffffffff81f4eeec schedul>
>>>    a.out     396   257.968785:         23 cs:  ffffffff81f4eeec schedul>
>>>    a.out     396   257.970593:         23 cs:  ffffffff81f4eeec schedul>
>>>    ...
>>>
>>> after:
>>>    # perf record -e cs -F 1000  ./a.out
>>>    [ perf record: Woken up 1 times to write data ]
>>>    [ perf record: Captured and wrote 0.058 MB perf.data (1466 samples) ]
>>>
>>>    # perf script
>>>    ...
>>>    a.out     395    59.338813:         11 cs:  ffffffff81f4eeec schedul>
>>>    a.out     395    59.339707:         12 cs:  ffffffff81f4eeec schedul>
>>>    a.out     395    59.340682:         13 cs:  ffffffff81f4eeec schedul>
>>>    a.out     395    59.341751:         13 cs:  ffffffff81f4eeec schedul>
>>>    a.out     395    59.342799:         12 cs:  ffffffff81f4eeec schedul>
>>>    a.out     395    59.343765:         11 cs:  ffffffff81f4eeec schedul>
>>>    a.out     395    59.344651:         11 cs:  ffffffff81f4eeec schedul>
>>>    a.out     395    59.345539:         12 cs:  ffffffff81f4eeec schedul>
>>>    a.out     395    59.346502:         13 cs:  ffffffff81f4eeec schedul>
>>>    ...
>>>
>>> test.c
>>>
>>> int main() {
>>>          for (int i = 0; i < 20000; i++)
>>>                  usleep(10);
>>>
>>>          return 0;
>>> }
>>>
>>>    # time ./a.out
>>>    real    0m1.583s
>>>    user    0m0.040s
>>>    sys     0m0.298s
>>>
>>> The above results were tested on x86-64 qemu with KVM enabled using
>>> test.c as test program. Ideally, we should have around 1500 samples,
>>> but the previous algorithm had only about 500, whereas the modified
>>> algorithm now has about 1400. Further more, the new version shows 1
>>> sample per 0.001s, while the previous one is 1 sample per 0.002s.This
>>> indicates that the new algorithm is more sensitive to small negative
>>> values compared to old algorithm.
>>>
>>> Fixes: bd2b5b12849a ("perf_counter: More aggressive frequency adjustment")
>>> Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
>>
>> It seems better, and the maths makes sense, so:
>>
>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>>
>> But the test case still seems to give unexpected results. Usually:
>>
>>    # time taskset --cpu 1 ./test
>>    real    0m 1.25s
>>    user    0m 0.03s
>>    sys     0m 0.00
>>    # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.051 MB perf.data (1290 samples) ]
>>
>> But occasionally:
>>
>>    # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.010 MB perf.data (204 samples) ]
>>    # perf script
>>    ...
>>    test   865   265.377846:         16 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.378900:         15 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.379845:         14 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.380770:         14 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.381647:         15 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.382638:         16 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.383647:         16 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.384704:         15 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.385649:         14 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.386578:        152 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.396383:        154 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.406183:        154 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.415839:        154 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.425445:        154 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.435052:        154 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.444708:        154 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.454314:        154 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.463970:        154 cs:  ffffffff832e927b schedule+0x2b
>>    test   865   265.473577:        154 cs:  ffffffff832e927b schedule+0x2b
>>    ...
>>
>>
>>
> It seems that the unexpected results is caused by Timer Interrupts not coming every TICK_NSEC.
> 
> I guess this is due to system idleness.

It looks like the period is adjusted at the tick only
for active tasks, so a task that is asleep a lot, like
the test case, could go a number of ticks without being
adjusted by perf_adjust_freq_unthr_context().

> I tried the patch and it should have fixed the issue.

Maybe also:

@@ -9523,7 +9532,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 
 		hwc->freq_time_stamp = now;
 
-		if (delta > 0 && delta < 2*TICK_NSEC)
+		if (delta > 0 && delta != now)
 			perf_adjust_period(event, delta, hwc->last_period, true);
 	}


> 
> You can give it a try as well.
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h index afb028c54f33..2708f1d0692c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -265,6 +265,7 @@ struct hw_perf_event {
>        * State for freq target events, see __perf_event_overflow() and
>        * perf_adjust_freq_unthr_context().
>        */
> +    u64                freq_tick_stamp;
>       u64                freq_time_stamp;
>       u64                freq_count_stamp;
>   #endif
> diff --git a/kernel/events/core.c b/kernel/events/core.c index cad50d3439f1..fe0d9b470365 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4112,7 +4112,7 @@ perf_adjust_freq_unthr_context(struct
> perf_event_context *ctx, bool unthrottle)
>   {
>       struct perf_event *event;
>       struct hw_perf_event *hwc;
> -    u64 now, period = TICK_NSEC;
> +    u64 now, period, tick_stamp;
>       s64 delta;
> 
>       /*
> @@ -4151,6 +4151,10 @@ perf_adjust_freq_unthr_context(struct
> perf_event_context *ctx, bool unthrottle)
>            */
>           event->pmu->stop(event, PERF_EF_UPDATE);
> 
> +        tick_stamp = perf_clock();
> +        period = tick_stamp - hwc->freq_tick_stamp;
> +        hwc->freq_tick_stamp = tick_stamp;
> +
>           now = local64_read(&event->count);
>           delta = now - hwc->freq_count_stamp;
>           hwc->freq_count_stamp = now;
> @@ -4162,8 +4166,14 @@ perf_adjust_freq_unthr_context(struct
> perf_event_context *ctx, bool unthrottle)
>            * to perf_adjust_period() to avoid stopping it
>            * twice.
>            */
> -        if (delta > 0)
> -            perf_adjust_period(event, period, delta, false);
> +        if (delta > 0) {
> +            /*
> +             * we skip first tick adjust period
> +             */
> +            if (likely(period != tick_stamp)) {
> +                perf_adjust_period(event, period, delta, false);
> +            }
> +        }
> 
>           event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
>       next:
> 
>>> ---
>>>   kernel/events/core.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 683dc086ef10..cad50d3439f1 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -4078,7 +4078,11 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
>>>       period = perf_calculate_period(event, nsec, count);
>>>         delta = (s64)(period - hwc->sample_period);
>>> -    delta = (delta + 7) / 8; /* low pass filter */
>>> +    if (delta >= 0)
>>> +        delta += 7;
>>> +    else
>>> +        delta -= 7;
>>> +    delta /= 8; /* low pass filter */
>>>         sample_period = hwc->sample_period + delta;
>>>   
>>


