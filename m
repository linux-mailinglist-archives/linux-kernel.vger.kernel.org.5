Return-Path: <linux-kernel+bounces-52279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C59849637
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B351F21625
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3A125CD;
	Mon,  5 Feb 2024 09:17:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5EE125AF;
	Mon,  5 Feb 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124673; cv=none; b=F6DGYpjywpHJkvD8CDW56cqyL8Rmkg+OyTOkn0cx6pxO6vepWLGk2oAFOb0awV0wHcSAXeZ4CvuYfqXaDCQltB368zDaYBtYhYA7/j4+JNGnyodUKP0xz8cCDqpaDSMr1zzYKksKRxwyg3DAxEEL1Sk8NhqcHmqpXZE0O7zNPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124673; c=relaxed/simple;
	bh=XCbfBT5WPAPJsmmwuX3hRwQ/sWI5suce5+2EwKQixRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHSjSzJVFM1H6tPX9nbu/wZgfGHVEHNfRHK9kTFrga6tlI4wJX1Vg5pKxG2+OlFNSyHYnmvRdmt+ok/6EAnKVS/3gYBIl92Qxa78Udpn1q/yv6EMnjds9Y55IBykUUvhLOFmdalj1LSi94TIFGlms7kHZxaz2GOhyrNNn9ZO25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1845C1FB;
	Mon,  5 Feb 2024 01:18:32 -0800 (PST)
Received: from [10.1.32.28] (e133047.arm.com [10.1.32.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A7BD3F5A1;
	Mon,  5 Feb 2024 01:17:48 -0800 (PST)
Message-ID: <326b568d-d460-4a69-9336-28da328ffdcf@arm.com>
Date: Mon, 5 Feb 2024 09:17:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20240205022500.2232124-1-qyousef@layalina.io>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240205022500.2232124-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 02:25, Qais Yousef wrote:
> 10ms is too high for today's hardware, even low end ones. This default
> end up being used a lot on Arm machines at least. Pine64, mac mini and
> pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
> it's too high for all of them.
> 
> Change the default to 2ms which should be 'pessimistic' enough for worst
> case scenario, but not too high for platforms with fast DVFS hardware.
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..8207f7294cb6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>  		 * for platforms where transition_latency is in milliseconds, it
>  		 * ends up giving unrealistic values.
>  		 *
> -		 * Cap the default transition delay to 10 ms, which seems to be
> +		 * Cap the default transition delay to 2 ms, which seems to be
>  		 * a reasonable amount of time after which we should reevaluate
>  		 * the frequency.
>  		 */
> -		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
> +		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
>  	}
>  
>  	return LATENCY_MULTIPLIER;

Hi Qais,
as previously mentioned I'm working on improving iowait boost and while I'm not against
this patch per se it does make iowait boosting more aggressive. ((Doubling limited by rate_limit_us)
Since the boost is often applied when not useful (for Android e.g. periodic f2fs writebacks),
this might have some side effects. Please give me a couple of days for verifying any impact,
or did you do that already?

Kind Regards,
Christian

