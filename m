Return-Path: <linux-kernel+bounces-8644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A85D81BA91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9AA1C254CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4301539EC;
	Thu, 21 Dec 2023 15:22:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F164F1E9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9514B2F4;
	Thu, 21 Dec 2023 07:23:37 -0800 (PST)
Received: from [192.168.1.25] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4ECF3F64C;
	Thu, 21 Dec 2023 07:22:49 -0800 (PST)
Message-ID: <c09fb78b-5bf9-4c0b-b93f-10fd19a4ab36@arm.com>
Date: Thu, 21 Dec 2023 16:22:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/idle: Prevent stopping the tick when there is no
 cpuidle driver
Content-Language: en-US
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20231215130501.24542-1-anna-maria@linutronix.de>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231215130501.24542-1-anna-maria@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Anna-Maria,

On 12/15/23 14:05, Anna-Maria Behnsen wrote:
> When there is no cpuidle driver, the system tries to stop the tick even if
> the system is fully loaded. But stopping the tick is not for free and it
> decreases performance on a fully loaded system. As there is no (cpuidle)
> framework which brings CPU in a power saving state when nothing needs to be
> done, there is also no power saving benefit when stopping the tick.

Just in case is wasn't taken into consideration:
-
Stopping the tick isn't free on a busy system, but it should also cost
something to regularly handle ticks on each CPU of an idle system.

FWIU, disabling the ticks also allows to add a CPU to the 'nohz.idle_cpus_mask'
mask, which helps the idle load balancer picking an idle CPU to do load
balancing for all the idle CPUs (cf. kick_ilb()).

It seems better to do one periodic balancing for all the idle CPUs rather
than periodically waking-up all CPUs to try to balance.

-
I would have assumed that if the system was fully loaded, ticks would
not be stopped, or maybe I misunderstood the case.
I assume the wake-up latency would be improved if the tick doesn't
have to be re-setup again.

Regards,
Pierre

> 
> Therefore do not stop the tick when there is no cpuidle driver.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>   kernel/sched/idle.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 565f8374ddbb..fd111686aaf3 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -165,8 +165,6 @@ static void cpuidle_idle_call(void)
>   	 */
>   
>   	if (cpuidle_not_available(drv, dev)) {
> -		tick_nohz_idle_stop_tick();
> -
>   		default_idle_call();
>   		goto exit_idle;
>   	}

