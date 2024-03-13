Return-Path: <linux-kernel+bounces-101629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBEC87A9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6517EB232EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C44A07;
	Wed, 13 Mar 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eX0ymyI5"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300BC290A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340855; cv=none; b=XmFGh5A11cBwRyTkYf0IDv8x7JpyMuZ5gh4cRyzwOJFSIDkY/naWE4U+gAcYJMDzmDKx+ahvz2fgS3+OorHSESRYWNUkOdGXsMvkvKNwUW1Ht1H3NJK5F6xy6SEHPwohgI93HY6s6KHyVc2X25ILyUDXg8LK+O6t8+KZKzaPdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340855; c=relaxed/simple;
	bh=YSUjV/yHnDAZVgS3+ncJxNIQukG94Jfh316n+Q5XKik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNXFxCxbGERpJsFZ/i7A1SXTpCDKj6dW6p6AbtVLZSi7CxVIQKTOvRM80Y2JjaCULwJ9s0FRF/+pKcHxg1ijPBItT0eOCNZ0KNodG9n6sh++AHqKZGZTZqU8NY6Ikk4R93+nZShyEPwvO78cGqVAmO0C1AA6I8YzOSiyarqPDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=eX0ymyI5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-690be84583fso31662776d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710340853; x=1710945653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwH7Po5mYA7bjttrElAdnD+M7EOKKFjEG6xtlrYwvBg=;
        b=eX0ymyI5DeWKmGnbShb/DyQZD97bIJeXOh5GC86/Eaz6rVpzyksM13x2hLZsB7DsfX
         ZX8KT02phUVaAfGVTcGJEE37I1eUPVFZ9Iqa0heQxzgWbVfAOpoo82bwoQPpTCWwSQ3h
         FW4NnlrqntxdhWvhgT4R899DzEDYx5jhjbMgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710340853; x=1710945653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwH7Po5mYA7bjttrElAdnD+M7EOKKFjEG6xtlrYwvBg=;
        b=sGd2JucrPHLdYzR9XNdUD0EWFMywcZHBJJ9Ja34NqAKetCF2VxVFUnVBFXeGqfNPSP
         Ky8u7CrkE1HQolo1xKG6G9QUQOH1SaS5CugsroKEoIYqVIQ4YZM08hBUn9RbZWCOvA4K
         q3uGs8OPDHeYq9aNiuHAH9aD5/6YsPlqvsg+VyAQb3qyg7Hwj1lknnaNMiPgzWyxzyvg
         6kCf/Xjvjtd75ezqgQhursOS3qvID/9W7XsQ9p2uTs5ST+87Unfr8V3qmwt9sbyKLcRg
         OaUUc5mX8f89OT9q9RvwtWkSQ+x1DAO8O3ynNlcSNw3BwnGr/OwgbzIqpBveY27Jr2mS
         9hrw==
X-Forwarded-Encrypted: i=1; AJvYcCUMh85lQN00l41x02ILtAvnN/+RVjoLDeBoZU+CfCG61XOMTea7L5gnPscLoiyzYFGAKzQ7eoP9baNxTwk7EfNGopmOAVWNT1xaU/n5
X-Gm-Message-State: AOJu0YwB2SqCIUFH+pn9xF//jYt8E9h/w9rPbzCIfR4VvF1IKxktwtzO
	FqAF8YiCk4Riud3z6E2T+gX/WaFgAzPGmMj+0uJw3oT4WCpLZ4TcWmFlXSHfIM4=
X-Google-Smtp-Source: AGHT+IEAg+gYeWjVfARG1jte7Q1+PT2yH9Z+ZORju1u6/8TtwosWFHanvuMw8bwEDA1gsoId9YYe9A==
X-Received: by 2002:a0c:c445:0:b0:690:de2a:3f1f with SMTP id t5-20020a0cc445000000b00690de2a3f1fmr18603qvi.32.1710340852927;
        Wed, 13 Mar 2024 07:40:52 -0700 (PDT)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id c2-20020a0ceb42000000b00690cba72427sm3560137qvq.33.2024.03.13.07.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 07:40:52 -0700 (PDT)
Message-ID: <aa221e99-bf08-4d36-aef1-07ffc5e71516@joelfernandes.org>
Date: Wed, 13 Mar 2024 10:40:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Content-Language: en-US
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, paulmck@kernel.org,
 frederic@kernel.org, josh@joshtriplett.org, boqun.feng@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 neeraj.upadhyay@kernel.org
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Neeraj,

On 3/13/2024 4:32 AM, Neeraj Upadhyay wrote:
> When all wait heads are in use, which can happen when
> rcu_sr_normal_gp_cleanup_work()'s callback processing
> is slow, any new synchronize_rcu() user's rcu_synchronize
> node's processing is deferred to future GP periods. This
> can result in long list of synchronize_rcu() invocations
> waiting for full grace period processing, which can delay
> freeing of memory. Mitigate this problem by using first
> node in the list as wait tail when all wait heads are in use.
> While methods to speed up callback processing would be needed
> to recover from this situation, allowing new nodes to complete
> their grace period can help prevent delays due to a fixed
> number of wait head nodes.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---
>  kernel/rcu/tree.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9fbb5ab57c84..bdccce1ed62f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>   * for this new grace period. Given that there are a fixed
>   * number of wait nodes, if all wait nodes are in use
>   * (which can happen when kworker callback processing
> - * is delayed) and additional grace period is requested.
> - * This means, a system is slow in processing callbacks.
> - *
> - * TODO: If a slow processing is detected, a first node
> - * in the llist should be used as a wait-tail for this
> - * grace period, therefore users which should wait due
> - * to a slow process are handled by _this_ grace period
> - * and not next.
> + * is delayed), first node in the llist is used as wait
> + * tail for this grace period. This means, the first node
> + * has to go through additional grace periods before it is
> + * part of the wait callbacks. This should be ok, as
> + * the system is slow in processing callbacks anyway.
>   *
>   * Below is an illustration of how the done and wait
>   * tail pointers move from one set of rcu_synchronize nodes
> @@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
>  		return start_new_poll;
>  
>  	wait_head = rcu_sr_get_wait_head();
> -	if (!wait_head) {
> -		// Kick another GP to retry.
> +	if (wait_head) {
> +		/* Inject a wait-dummy-node. */
> +		llist_add(wait_head, &rcu_state.srs_next);
> +	} else {
> +		// Kick another GP for first node.
>  		start_new_poll = true;
> -		return start_new_poll;
> +		if (first == rcu_state.srs_done_tail)

small nit:
Does done_tail access here need smp_load_acquire() or READ_ONCE() to match the
other users?

Also if you don't mind could you please rebase your patch on top of mine [1] ? I
think it will otherwise trigger this warning in my patch:

WARN_ON_ONCE(!rcu);

Because I always assume there to be at least 2 wait heads at clean up time.

[1] https://lore.kernel.org/all/20240308224439.281349-1-joel@joelfernandes.org/

Thanks!

 - Joel


> +			return start_new_poll;
> +		wait_head = first;
>  	}
>  
> -	/* Inject a wait-dummy-node. */
> -	llist_add(wait_head, &rcu_state.srs_next);
> -
>  	/*
>  	 * A waiting list of rcu_synchronize nodes should be empty on
>  	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),

