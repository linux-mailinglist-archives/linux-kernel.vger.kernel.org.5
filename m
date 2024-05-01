Return-Path: <linux-kernel+bounces-165786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABBF8B9192
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F531C2358E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5017165FDF;
	Wed,  1 May 2024 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCXCc3OC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6851C68D;
	Wed,  1 May 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601573; cv=none; b=SdOfJG0MkdfcU9mdjZr5yQ4djdPneAPSq5NDGcLlze2mM976v+5Xs2rAEh/aVimFSbKVUsdIk8V42NugTD96mhkqW7z2pZmG78XddDQbiNuR4bS8Qs/mdTf+Gs7+mXa0drP9HavvxOBEtKWgfSGmL1+zPRQELcTebSUPXJeLLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601573; c=relaxed/simple;
	bh=Ug3FQ7I2qR/RHww0ckNHp2CA4CIPVdT90yjcPc5ds/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnKuljarPxaeFXl3MREWE5BraBP+1XLccCiTFKz5MyjfJrc2hkf/ScRIE85Yle3O6IkzVGYoSWRchAFosdOa2wud4u20CO8OAy87eBBo3NPQNErgP6Hvp46So45BXT43Z2j4xSsJRIISV38YG6SDBmmbfocG226694vdSU9NjJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCXCc3OC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C65BC072AA;
	Wed,  1 May 2024 22:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714601572;
	bh=Ug3FQ7I2qR/RHww0ckNHp2CA4CIPVdT90yjcPc5ds/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gCXCc3OCNyr6+i3h4YTHs9KepSLe6n7aIrtfRjc0yAHqvWeildSuL6MWAYA37i3C5
	 jRrpQ4zd2eq/p/dpUQkoUYs52Cn4Im+Z+AogwoRh5jxXZityH0Y+8q0v8n0q9b7DsY
	 JwtpslpDaQW0EehLBq5b435NxyKJe9XNoOg0CeAv+a/YK+jgnMNt5+UwLD66pAQsYv
	 zMguRGrKKHK6EXaZpRSLWSsDhBTpdvXviFQsLg4/kbtTmDW+iUngl31YDx0HIiBfiR
	 QMCDcKJz3jXFJJPPTw+X30RCnZC95AFPy88KOwNmF9fciBSSTWyTvN7hCtwCslDzqA
	 QYxNlRWvDDdYg==
Date: Wed, 1 May 2024 15:12:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
 manjunath.b.patil@oracle.com
Subject: Re: [PATCH RFC] net/sched: adjust device watchdog timer to detect
 stopped queue at right time
Message-ID: <20240501151251.2eccb4d0@kernel.org>
In-Reply-To: <20240430140010.5005-1-praveen.kannoju@oracle.com>
References: <20240430140010.5005-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 19:30:10 +0530 Praveen Kumar Kannoju wrote:
> Applications are sensitive to long network latency, particularly
> heartbeat monitoring ones. Longer the tx timeout recovery higher the
> risk with such applications on a production machines. This patch
> remedies, yet honoring device set tx timeout.
> 
> Modify watchdog next timeout to be shorter than the device specified.
> Compute the next timeout be equal to device watchdog timeout less the
> how long ago queue stop had been done. At next watchdog timeout tx
> timeout handler is called into if still in stopped state. Either called
> or not called, restore the watchdog timeout back to device specified.

Idea makes sense, some comments on the code below.

> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 4a2c763e2d11..64e31f8b4ac1 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -506,18 +506,25 @@ static void dev_watchdog(struct timer_list *t)
>  			unsigned int timedout_ms = 0;
>  			unsigned int i;
>  			unsigned long trans_start;
> +			unsigned long next_check = 0;
> +			unsigned long current_jiffies;
>  
>  			for (i = 0; i < dev->num_tx_queues; i++) {
>  				struct netdev_queue *txq;
> +				current_jiffies = jiffies;

Not sure why you save current jiffies.

>  				txq = netdev_get_tx_queue(dev, i);
>  				trans_start = READ_ONCE(txq->trans_start);
> -				if (netif_xmit_stopped(txq) &&
> -				    time_after(jiffies, (trans_start +
> -							 dev->watchdog_timeo))) {
> -					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
> -					atomic_long_inc(&txq->trans_timeout);
> -					break;
> +				if (netif_xmit_stopped(txq)) {

please use continue instead of adding another indentation level

> +					if (time_after(current_jiffies, (trans_start +

wrap at 80 characters

> +								   dev->watchdog_timeo))) {
> +						timedout_ms = jiffies_to_msecs(current_jiffies -
> +										trans_start);
> +						atomic_long_inc(&txq->trans_timeout);
> +						break;
> +					}
> +					next_check = trans_start + dev->watchdog_timeo -
> +									current_jiffies;

this will give us "next_check" for last queue. Let's instead find the
oldest trans_start in the loop. Do:

		unsigned long oldest_start = jiffies;

then in the loop:

		oldest_start = min(...)

>  				}
>  			}
>  
> @@ -530,9 +537,11 @@ static void dev_watchdog(struct timer_list *t)
>  				dev->netdev_ops->ndo_tx_timeout(dev, i);
>  				netif_unfreeze_queues(dev);
>  			}
> +			if (!next_check)
> +				next_check = dev->watchdog_timeo;
>  			if (!mod_timer(&dev->watchdog_timer,
>  				       round_jiffies(jiffies +
> -						     dev->watchdog_timeo)))
> +						     next_check)))

then here you just need to swap jiffies for oldest_start

>  				release = false;
>  		}
>  	}


