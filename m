Return-Path: <linux-kernel+bounces-100850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97A6879E29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC562811C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D18143C50;
	Tue, 12 Mar 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu+JHrZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE152143732;
	Tue, 12 Mar 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281123; cv=none; b=ksg5w1PebgIXv3bXjGqiJ0Dymomrgo3ZqkDCOngoUKKD+PyxTVfy1Y5xUm99/2YNUnfCUnEyZX9QJXbJohgx9ZK4MjM4/w2wg7jALNRkufTLCUSDvePlQ4akzdseV0uGwV9u9Ak3FQowfZ10cRy55XKJp2BrPrHiJU0SlIrFJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281123; c=relaxed/simple;
	bh=94kWIXOlJLd1i+GSg4nJJloy882bkGtnVNLjrkLGM18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FalcyHg+fHjH0Qq4XhJHyEjsTcs1ZrElZAGeV4x5oslAvzbJ/zFBcDe6XMWzknuDXRcW2Uks/mUML3G8KTMfO/T1GHjgv19EdwE+PEir3i/ONrgjss81yrlmX7Vscf/DtY9NNG0bCDXkNqC9U9LRwaaPzeJlvk5/pbM0731PPVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu+JHrZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FBEC433C7;
	Tue, 12 Mar 2024 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710281122;
	bh=94kWIXOlJLd1i+GSg4nJJloy882bkGtnVNLjrkLGM18=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Xu+JHrZgO69R3xfqZKPbwMT5uA3/IweYZZRxuLz671QG//X6BPeei5WY3mhDZhcRF
	 aN4b9lBFmD/Ady/xPFDzS6/T8tsDWjaWN7kaJeFxGvrezQWVjBPrKo/CtttJXZHtJ/
	 P7BZJ3medWlBguplCEj8ATnGDZ5pldIeVOxCCrPZ66pyN1qABdk5ayO/lvQKHA3S/8
	 JeMvCg8ymM7iVzXUbD296FhIoRg4DCcTQyhzoevUhvtOQTYCTtoUhRRRk28laqkMPE
	 nYqOhRFIUr5G+R8tyCPcaAQ935J2k3QuNonwKcUi2btJY8SiUs2aWf0Cwjk6guTrW4
	 iTNmBjKolcuEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 051A6CE098C; Tue, 12 Mar 2024 15:05:22 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:05:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Remove unnecessary lazy_jiffies in
 call_rcu_tasks_generic_timer()
Message-ID: <d3762d8c-1996-4703-8fa2-f0b00febf2fb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240312113524.7654-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312113524.7654-1-qiang.zhang1211@gmail.com>

On Tue, Mar 12, 2024 at 07:35:24PM +0800, Zqiang wrote:
> The rcu_tasks_percpu structure's->lazy_timer is queued only when
> the rcu_tasks structure's->lazy_jiffies is not equal to zero in
> call_rcu_tasks_generic(), if the lazy_timer callback is invoked,
> that means the lazy_jiffes is not equal to zero, this commit
> therefore remove lazy_jiffies check in call_rcu_tasks_generic_timer().
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index b1254cf3c210..439e0b9a2656 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -299,7 +299,7 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
>  
>  	rtp = rtpcp->rtpp;
>  	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> -	if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
> +	if (!rcu_segcblist_empty(&rtpcp->cblist)) {

Good eyes!

But did you test with something like a WARN_ON_ONCE(rtp->lazy_jiffies)?

						Thanx, Paul

>  		if (!rtpcp->urgent_gp)
>  			rtpcp->urgent_gp = 1;
>  		needwake = true;
> -- 
> 2.17.1
> 

