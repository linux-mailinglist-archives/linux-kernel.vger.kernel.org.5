Return-Path: <linux-kernel+bounces-74910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825A85DFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A98E1C242BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DF67FBAB;
	Wed, 21 Feb 2024 14:38:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4337C0B8;
	Wed, 21 Feb 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526330; cv=none; b=C3lEbrRaNsU2N/aKGprU+alLHxhe8cEygsoMsQk2nlDqM3NRvbe1CnjZdnP9udjYV1WQFQ6TVCK0P94wIClEbdnMy9axKA0nHiyuN5rHJA9jHWNTFWDiomdFafc9A3uMHk3kObZRZlTPGSSaIHg5aWXdHg267pI7dphpQrlSY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526330; c=relaxed/simple;
	bh=5YDxSVqC1zF2NM/ES7mlAm2LSM0vCdSoAN168O/YwvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HklnfQRIpEKqOIqjdq0YU7H99O7QjmVELrbiumTL2S8HDe8o+1stpC+giN2egilEyR8ymNgZkdmU7i1bPYbsQkx2e2eXu9GIpriYnZvhmC2Vk8WPdboYzNgCuuJjPbJsvT2Vl/JGlmHjsKQajgT6mIhy1gx96tNIgN0MH98OlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79489C433C7;
	Wed, 21 Feb 2024 14:38:48 +0000 (UTC)
Message-ID: <4fa62e4f-9768-4434-8f7b-24aa3b2a3490@xs4all.nl>
Date: Wed, 21 Feb 2024 15:38:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media/cec/core: fix task hung in cec_claim_log_addrs
Content-Language: en-US, nl
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 mchehab@kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000006d96200611de3986@google.com>
 <tencent_941B48254CBA00BB4933069E391B6E4B5408@qq.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <tencent_941B48254CBA00BB4933069E391B6E4B5408@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 15:20, Edward Adam Davis wrote:
> After unlocking adap->lock in cec_claim_log_addrs(), cec_claim_log_addrs() may
> re-enter, causing this issue to occur.

But if it is called again, then it should hit this at the start of the function:

        if (WARN_ON(adap->is_configuring || adap->is_configured))
                return;

I'm still not sure what causes the KASAN hung task since I cannot seem to reproduce
it, and because it is hard for me to find enough time to dig into this.

Regards,

	Hans

> 
> In the thread function cec_config_thread_func() adap->lock is also used, so there
> is no need to unlock adap->lock in cec_claim_log_addrs(), and then use adap->lock
> in cec_config_thread_func() to protect.
> 
> Reported-and-tested-by: syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/media/cec/core/cec-adap.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
> index 5741adf09a2e..21b3ff504524 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -1436,7 +1436,6 @@ static int cec_config_thread_func(void *arg)
>  	int err;
>  	int i, j;
>  
> -	mutex_lock(&adap->lock);
>  	dprintk(1, "physical address: %x.%x.%x.%x, claim %d logical addresses\n",
>  		cec_phys_addr_exp(adap->phys_addr), las->num_log_addrs);
>  	las->log_addr_mask = 0;
> @@ -1565,7 +1564,6 @@ static int cec_config_thread_func(void *arg)
>  	}
>  	adap->kthread_config = NULL;
>  	complete(&adap->config_completion);
> -	mutex_unlock(&adap->lock);
>  	call_void_op(adap, configured);
>  	return 0;
>  
> @@ -1577,7 +1575,6 @@ static int cec_config_thread_func(void *arg)
>  	adap->must_reconfigure = false;
>  	adap->kthread_config = NULL;
>  	complete(&adap->config_completion);
> -	mutex_unlock(&adap->lock);
>  	return 0;
>  }
>  
> @@ -1602,9 +1599,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
>  		adap->kthread_config = NULL;
>  		adap->is_configuring = false;
>  	} else if (block) {
> -		mutex_unlock(&adap->lock);
>  		wait_for_completion(&adap->config_completion);
> -		mutex_lock(&adap->lock);
>  	}
>  }
>  


