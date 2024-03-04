Return-Path: <linux-kernel+bounces-91385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE37871083
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED79B20B77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F60D7C09A;
	Mon,  4 Mar 2024 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idzNyh1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25A7B3FA;
	Mon,  4 Mar 2024 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592983; cv=none; b=HRgNmaIJwSLdhGdHVQ+QgGcHHC9NVcHXGHG1VgCEoVSNql/KdvkEaQNr03YQ5CzO83Cz20+RFgAakkIcfqVuxx+tpwTkIsyK3yWNBAU5VnCOWn+vCj4qjjAvMCcV7/8S7F58zHkjr+xkBOTuKQ9/8La1MakEreiGXsskewtmQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592983; c=relaxed/simple;
	bh=Rca8aMJHIqobe+2cMX0r2HJ1hKWMth39li8Jrzh0q+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdevH/pcmOR+PLvLsAx5ku9H3E+2pr6zfUsrlIdpv2nxaN03oWYizj+vqtUTQTyX2QED+pWxcS9PPQxPt0M1/u+HwfkM/Bp9jkALVBaAO6hlijqLIR8kqEkzTkw2ngRIas5Qww3PXaQiKUNWwWSVrDa5THVoIZPQ3DPLZrRKFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idzNyh1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A81C433C7;
	Mon,  4 Mar 2024 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709592982;
	bh=Rca8aMJHIqobe+2cMX0r2HJ1hKWMth39li8Jrzh0q+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idzNyh1wbBFfPcAk+olSqkNX1veouQGtHnwbiW37ZtHp/r8KVR+WdaRL7YdT189KC
	 BhTyV7818bJg4H2CuIRcu39XeBNhDi41dbkyvWF/vPaA1ZeRyldnykaAjNPNXmmNEX
	 vAtViu02BG271a9Rf8zBWnrTyeV6/lsqUYfPT42bDr9pl98/TZ5I9FglR4R8yca76r
	 8XLdmujf7FB5L/fF8uh1DPtY+ZBnvMFp4m5lhsMTdSHBPyiWN1mUKp2g4EJ6PRurhh
	 RKUlOF63h6Sxx+fcfQ/iZYBypoXuF77PpO80F68zOXB+TP+bTas7po3FC1JrcXmAa+
	 itVaciyyOGvGw==
Date: Mon, 4 Mar 2024 23:56:19 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZeZRk-1Kx-s0Nz34@pavilion.home>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <Zd0ZtNu+Rt0qXkfS@lothringen>
 <Zd91pR0fjiCUZTtP@pc636>
 <ZeW2w08WZo4yapQp@localhost.localdomain>
 <ZeX1cXWKv2kirDXg@pc638.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeX1cXWKv2kirDXg@pc638.lan>

Le Mon, Mar 04, 2024 at 05:23:13PM +0100, Uladzislau Rezki a écrit :
> On Mon, Mar 04, 2024 at 12:55:47PM +0100, Frederic Weisbecker wrote:
> The easiest way is to drop the patch. To address it we can go with:
> 
> <snip>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 31f3a61f9c38..9aa2cd46583e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1661,16 +1661,8 @@ static void rcu_sr_normal_gp_cleanup(void)
>  	 * wait-head is released if last. The worker is not kicked.
>  	 */
>  	llist_for_each_safe(rcu, next, wait_tail->next) {
> -		if (rcu_sr_is_wait_head(rcu)) {
> -			if (!rcu->next) {
> -				rcu_sr_put_wait_head(rcu);
> -				wait_tail->next = NULL;
> -			} else {
> -				wait_tail->next = rcu;
> -			}
> -
> +		if (rcu_sr_is_wait_head(rcu))
>  			break;
> -		}
>  
>  		rcu_sr_normal_complete(rcu);
>  		// It can be last, update a next on this step.
> <snip>
> 
> i.e. the process of users from GP is still there. The work is triggered
> to perform a final complete(if there are users) + releasing wait-heads
> so we do not race anymore.

It's worth mentioning that this doesn't avoid scheduling the workqueue.
Except perhaps for the very first time rcu_sr_normal_gp_cleanup() is called,
the workqueue will always have to be scheduled at least in order to release the
wait_tail of the previous rcu_sr_normal_gp_cleanup() call.

But indeed you keep the optimization that performs the completions themselves
synchronously from the GP kthread if there aren't too many of them (which
probably is the case most of the time).

> I am OK with both cases. Dropping the patch will make it more simple
> for sure.

I am ok with both cases as well :-)

You choose. But note that the time spent doing the completions from the GP
kthread may come at the expense of delaying the start of the next grace period,
on which further synchronous RCU calls may in turn depend on...

Thanks.

> 
> --
> Uladzislau Rezki
> 
> 

