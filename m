Return-Path: <linux-kernel+bounces-24388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E082BBE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67414285C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1645D730;
	Fri, 12 Jan 2024 07:40:38 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6F5D726
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TBD2G4yTNzSnT4;
	Fri, 12 Jan 2024 15:39:34 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id BE6651402C7;
	Fri, 12 Jan 2024 15:40:28 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 15:40:28 +0800
Message-ID: <44fa61a6-9ceb-0ebb-141f-0e2e703db47d@huawei.com>
Date: Fri, 12 Jan 2024 15:40:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] tick/broadcast-hrtimer: Prevent the timer device on
 broadcast duty CPU from being disabled
Content-Language: en-US
To: <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC: <liwei391@huawei.com>, <wangxiongfeng2@huawei.com>, <frederic@kernel.org>,
	<mingo@kernel.org>
References: <20231218025844.55675-1-liaoyu15@huawei.com>
From: Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <20231218025844.55675-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)

Hi Thomas,

Kindly ping..

On 2023/12/18 10:58, Yu Liao wrote:
> It was found that running the LTP hotplug stress test on a aarch64
> system could produce rcu_sched stall warnings.
> 
> The issue is the following:
> 
> CPU1 (owns the broadcast hrtimer)	CPU2
> 
> 				tick_broadcast_enter()
> 				//shut down local timer device
> 				...
> 				tick_broadcast_exit()
> 				//exits with tick_broadcast_force_mask set,
> 				timer device remains disabled
> 
> 				initiates offlining of CPU1
> take_cpu_down()
> //CPU1 shuts down and does
> not send broadcast IPI anymore
> 				takedown_cpu()
> 				  hotplug_cpu__broadcast_tick_pull()
> 				  //move broadcast hrtimer to this CPU
> 				    clockevents_program_event()
> 				      bc_set_next()
> 					hrtimer_start()
> 					//does not call hrtimer_reprogram()
> 					to program timer device if expires
> 					equals dev->next_event, so the timer
> 					device remains disabled.
> 
> CPU2 takes over the broadcast duty but local timer device is disabled,
> causing many CPUs to become stuck.
> 
> Fix this by calling tick_program_event() to reprogram the local timer
> device in this scenario.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  kernel/time/tick-broadcast-hrtimer.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
> index e28f9210f8a1..6a4a612581fb 100644
> --- a/kernel/time/tick-broadcast-hrtimer.c
> +++ b/kernel/time/tick-broadcast-hrtimer.c
> @@ -42,10 +42,22 @@ static int bc_shutdown(struct clock_event_device *evt)
>   */
>  static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
>  {
> +	ktime_t next_event = this_cpu_ptr(&tick_cpu_device)->evtdev->next_event;
> +
>  	/*
> -	 * This is called either from enter/exit idle code or from the
> -	 * broadcast handler. In all cases tick_broadcast_lock is held.
> -	 *
> +	 * This can be called from CPU offline operation to move broadcast
> +	 * assignment. If tick_broadcast_force_mask is set, the CPU local
> +	 * timer device may be disabled. And hrtimer_reprogram() will not
> +	 * called if the timer is not the first expiring timer. Reprogram
> +	 * the cpu local timer device to ensure we can take over the
> +	 * broadcast duty.
> +	 */
> +	if (tick_check_broadcast_expired() && expires >= next_event)
> +		tick_program_event(next_event, 1);
> +
> +	/*
> +	 * This is called from enter/exit idle code, broadcast handler or
> +	 * CPU offline operation. In all cases tick_broadcast_lock is held.
>  	 * hrtimer_cancel() cannot be called here neither from the
>  	 * broadcast handler nor from the enter/exit idle code. The idle
>  	 * code can run into the problem described in bc_shutdown() and the


