Return-Path: <linux-kernel+bounces-154820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA48AE179
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3281C214FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3648604B3;
	Tue, 23 Apr 2024 09:55:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71545DF0D;
	Tue, 23 Apr 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866157; cv=none; b=OjeI4TUOuj3qkQvsYXE6/BL10KrXLThgdZmNFZMPYUz/wDykpMVE8aJV1QigHahLPlykNN6bItxvXDnL9SGV42CWn/EUJlWaTXdaJEgyNPM4h4TnEw/RMHk0nAvN3PEtxyfzUOM+V5tt/KO6fhSXReyfqEvhFjvSEbRSy+Lnguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866157; c=relaxed/simple;
	bh=0b4ffIoB+s5OkM8ToBVt2cHVP10AzJ57eNLzRntkYLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFG+p+lDJFWsu9WUk26cd7mOMonp0c68NtNR5um3LHhIkYhSjJG5+7pWDlVxUUhzOPnaaYmjd7EoVKfdWRPwdoivqe+uDrCRbLNcWV7mPU6Lo1opjds2qvAYSvCpqgE52gUM+YxnK/IQ9bet2roa3/ygZ9ccP8cAaKr09oZe2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5366339;
	Tue, 23 Apr 2024 02:56:21 -0700 (PDT)
Received: from [192.168.1.216] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0E203F7BD;
	Tue, 23 Apr 2024 02:55:50 -0700 (PDT)
Message-ID: <e1bfb006-0226-4be4-9058-7c86da0e36e3@arm.com>
Date: Tue, 23 Apr 2024 10:55:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] perf: Allow adding fixed random jitter to the
 alternate sampling period
To: Ben Gainey <Ben.Gainey@arm.com>
Cc: "acme@kernel.org" <acme@kernel.org>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 Mark Rutland <Mark.Rutland@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "will@kernel.org" <will@kernel.org>, "irogers@google.com"
 <irogers@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240422104929.264241-1-ben.gainey@arm.com>
 <20240422104929.264241-3-ben.gainey@arm.com>
 <1dd3692d-dd2c-428f-a7f7-e263d1d5e5c8@arm.com>
 <50f8e635667f2c0b389f882bc3f881552ea77e68.camel@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <50f8e635667f2c0b389f882bc3f881552ea77e68.camel@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/04/2024 15:40, Ben Gainey wrote:
> On Mon, 2024-04-22 at 14:08 +0100, James Clark wrote:
>>
>>
>> On 22/04/2024 11:49, Ben Gainey wrote:
>>> This change modifies the core perf overflow handler, adding some
>>> small
>>> random jitter to each sample period whenever an event switches
>>> between the
>>> two alternate sample periods. A new flag is added to
>>> perf_event_attr to
>>> opt into this behaviour.
>>>
>>> This change follows the discussion in [1], where it is recognized
>>> that it
>>> may be possible for certain patterns of execution to end up with
>>> biased
>>> results.
>>>
>>> [1] https://lore.kernel.org/linux-perf-
>>> users/Zc24eLqZycmIg3d2@tassilo/
>>>
>>> Signed-off-by: Ben Gainey <ben.gainey@arm.com>
>>> ---
>>>  include/uapi/linux/perf_event.h |  3 ++-
>>>  kernel/events/core.c            | 11 ++++++++++-
>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/perf_event.h
>>> b/include/uapi/linux/perf_event.h
>>> index 5c1701d091cf..dd3697a4b300 100644
>>> --- a/include/uapi/linux/perf_event.h
>>> +++ b/include/uapi/linux/perf_event.h
>>> @@ -461,7 +461,8 @@ struct perf_event_attr {
>>>   inherit_thread :  1, /* children only inherit if cloned with
>>> CLONE_THREAD */
>>>   remove_on_exec :  1, /* event is removed from task on exec */
>>>   sigtrap        :  1, /* send synchronous SIGTRAP on event */
>>> - __reserved_1   : 26;
>>> + jitter_alternate_period : 1, /* add a limited amount of jitter on
>>> each alternate period */
>>> + __reserved_1   : 25;
>>>
>>>   union {
>>>   __u32 wakeup_events;   /* wakeup every n events */
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 07f1f931e18e..079ae520e836 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/idr.h>
>>>  #include <linux/file.h>
>>>  #include <linux/poll.h>
>>> +#include <linux/random.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/hash.h>
>>>  #include <linux/tick.h>
>>> @@ -9546,6 +9547,8 @@ static inline bool sample_is_allowed(struct
>>> perf_event *event, struct pt_regs *r
>>>   return true;
>>>  }
>>>
>>> +# define MAX_ALT_SAMPLE_PERIOD_JITTER 16
>>> +
>>
>> Is 16 enough to make a difference with very large alternate periods?
>> I'm
>> wondering if it's worth making it customisable and instead of adding
>> the
>> boolean option add a 16 bit jitter field. Or the option could still
>> be a
>> boolean but the jitter value is some ratio of the alt sample period,
>> like:
>>
>>   get_random_u32_below(max(16, alternative_sample_period >> 4))
>>
> 
> I don't really have a strong opinion; in all my time I've never seen an
> Arm PMU produce a precise and constant period anyway, so this may be
> more useful in the case the architecture is able to support precise
> sampling. In any case it's is likely to be specific to a particular
> workload / configuration anyway.
> 
> The main downside I can see for making it configurable is that the
> compiler cannot then optimise the get_random call as well as for a
> constant, which may be undesirable on this code path.
> 
> 

Hmmm I see, I didn't expect get_random_u32_below() to have such
different implementations depending on whether it was a constant or not.
You don't have to remove the constant though, it could be:

 get_random_u32() & (jitter_power_of_2_max - 1)

If you're really worried about optimising this path, then generating the
jitter with some rotate/xor/mask operation is probably much faster. I
don't think the requirements are for it to actually be "random", but
just something to perturb it, even a badly distributed random number
would be fine.

But also yes I don't have a particularly strong opinion either. Just
that if someone does have a justification for a configurable value in
the future, depending on how that's implemented it could make the new
jitter boolean redundant which would be annoying.

