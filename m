Return-Path: <linux-kernel+bounces-153412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E28ACDD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE942856AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550D14F9E4;
	Mon, 22 Apr 2024 13:08:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1A4145342;
	Mon, 22 Apr 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791307; cv=none; b=U3dEVAsZl8kz3tjl/t9CNOp7HEuFn12c/vwkdmV5jjWrYRiCpz0On06D6b7Y5q5iC9Xb3rQ3ipiH/WBVN7lVUYoxD6/P2tG+hlsa2PxygLo/leukk5MQhlhFtIg5mUJLenb+SruJ3+rpZoTIHKJpPbLGKBOs8+CmnJvWgVKOKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791307; c=relaxed/simple;
	bh=JQA7FoV2rCBHsCh6taw49FYkdJ+buGF53QhW+Zam8bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHqybA//+QnkkGaG6SjGBDXFAU0KEmqPqQMOLxSbgVKhhLL59cADLlvK9shJqlSQiJ3PEXXu69VFZ8lXiwfgrSmuU6Rzdymdl+25+8tbOhf5x4G7IOWmPchL+fPj45zg8vA9xdt2+ucZlCo+wFr3COZ3rn7mWBcUUF6+LePXNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57717339;
	Mon, 22 Apr 2024 06:08:48 -0700 (PDT)
Received: from [192.168.1.216] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A6723F73F;
	Mon, 22 Apr 2024 06:08:16 -0700 (PDT)
Message-ID: <1dd3692d-dd2c-428f-a7f7-e263d1d5e5c8@arm.com>
Date: Mon, 22 Apr 2024 14:08:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] perf: Allow adding fixed random jitter to the
 alternate sampling period
To: Ben Gainey <ben.gainey@arm.com>
Cc: ak@linux.intel.com, will@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
References: <20240422104929.264241-1-ben.gainey@arm.com>
 <20240422104929.264241-3-ben.gainey@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240422104929.264241-3-ben.gainey@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/04/2024 11:49, Ben Gainey wrote:
> This change modifies the core perf overflow handler, adding some small
> random jitter to each sample period whenever an event switches between the
> two alternate sample periods. A new flag is added to perf_event_attr to
> opt into this behaviour.
> 
> This change follows the discussion in [1], where it is recognized that it
> may be possible for certain patterns of execution to end up with biased
> results.
> 
> [1] https://lore.kernel.org/linux-perf-users/Zc24eLqZycmIg3d2@tassilo/
> 
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>
> ---
>  include/uapi/linux/perf_event.h |  3 ++-
>  kernel/events/core.c            | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 5c1701d091cf..dd3697a4b300 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -461,7 +461,8 @@ struct perf_event_attr {
>  				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
>  				remove_on_exec :  1, /* event is removed from task on exec */
>  				sigtrap        :  1, /* send synchronous SIGTRAP on event */
> -				__reserved_1   : 26;
> +				jitter_alternate_period : 1, /* add a limited amount of jitter on each alternate period */
> +				__reserved_1   : 25;
>  
>  	union {
>  		__u32		wakeup_events;	  /* wakeup every n events */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 07f1f931e18e..079ae520e836 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -15,6 +15,7 @@
>  #include <linux/idr.h>
>  #include <linux/file.h>
>  #include <linux/poll.h>
> +#include <linux/random.h>
>  #include <linux/slab.h>
>  #include <linux/hash.h>
>  #include <linux/tick.h>
> @@ -9546,6 +9547,8 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
>  	return true;
>  }
>  
> +# define MAX_ALT_SAMPLE_PERIOD_JITTER 16
> +

Is 16 enough to make a difference with very large alternate periods? I'm
wondering if it's worth making it customisable and instead of adding the
boolean option add a 16 bit jitter field. Or the option could still be a
boolean but the jitter value is some ratio of the alt sample period, like:

  get_random_u32_below(max(16, alternative_sample_period >> 4))

>  /*
>   * Generic event overflow handling, sampling.
>   */
> @@ -9573,7 +9576,10 @@ static int __perf_event_overflow(struct perf_event *event,
>  	if (event->attr.alternative_sample_period) {
>  		bool using_alt = hwc->using_alternative_sample_period;
>  		u64 sample_period = (using_alt ? event->attr.sample_period
> -					       : event->attr.alternative_sample_period);
> +					       : event->attr.alternative_sample_period)
> +				  + (event->attr.jitter_alternate_period
> +					? get_random_u32_below(MAX_ALT_SAMPLE_PERIOD_JITTER)
> +					: 0);
>  
>  		hwc->sample_period = sample_period;
>  		hwc->using_alternative_sample_period = !using_alt;
> @@ -12503,6 +12509,9 @@ SYSCALL_DEFINE5(perf_event_open,
>  		}
>  	}
>  
> +	if (attr.jitter_alternate_period && !attr.alternative_sample_period)
> +		return -EINVAL;
> +
>  	/* Only privileged users can get physical addresses */
>  	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR)) {
>  		err = perf_allow_kernel(&attr);

