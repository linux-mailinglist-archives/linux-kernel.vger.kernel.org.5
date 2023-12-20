Return-Path: <linux-kernel+bounces-6223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930AE81961B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FD41F24B95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC237BA53;
	Wed, 20 Dec 2023 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahFj4rtC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB964BA2B;
	Wed, 20 Dec 2023 01:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EE1C433C8;
	Wed, 20 Dec 2023 01:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703034898;
	bh=zsdzPRN0SiD7hT3wXMfa4wKmlukUIAOzXAVh0C3nQ8E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ahFj4rtCXaC7GT5onWH6gIxyYIH0v27hIhmFoFtCkaEk5n2LJM1lPrikOKLf5Yu7o
	 CXr4JICVMItoUNDPlXh2Y7jsEQwSQsUeaocUfpAP6YohTbuqpX8LDBVYo5AHf0XMn9
	 oNoDMCoOBJfQGaiS7nkh4g7FgrA7lgDMpIEgVetLZ2KrgHmyuOSapl6w+6yeg/7v8v
	 37CdB/DKVO6aVuICGCC4sZl1mNn9syDeZ/kh9jw4vtpgYkvMdxO8tIccRds2BTgozB
	 3tsuR/Vm1nnuQznKr0CEfIUUwQzE/z7Z+jNS6OZVDG7ll+vcYPdIon5aFZ+g/j/AVH
	 C0xx2is9zjNkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E3D5ECE10DA; Tue, 19 Dec 2023 17:14:57 -0800 (PST)
Date: Tue, 19 Dec 2023 17:14:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 7/7] rcu: Add CONFIG_RCU_SR_NORMAL_DEBUG_GP
Message-ID: <81e233e8-ea1e-4d59-992e-826b3c96ce01@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-8-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128080033.288050-8-urezki@gmail.com>

On Tue, Nov 28, 2023 at 09:00:33AM +0100, Uladzislau Rezki (Sony) wrote:
> This option enables additional debugging for detecting a grace
> period incompletion for synchronize_rcu() users. If a GP is not
> fully passed for any user, the warning message is emitted.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Much better, thank you, as this avoids the possibility of false positives
in production.  But to avoid potential bisection issues, could you please
fold this into the first patch?

							Thanx, Paul

> ---
>  kernel/rcu/Kconfig.debug | 12 ++++++++++++
>  kernel/rcu/tree.c        |  7 +++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 2984de629f74..3d44106ca1f0 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -143,4 +143,16 @@ config RCU_STRICT_GRACE_PERIOD
>  	  when looking for certain types of RCU usage bugs, for example,
>  	  too-short RCU read-side critical sections.
>  
> +config RCU_SR_NORMAL_DEBUG_GP
> +	bool "Debug synchronize_rcu() callers for a grace period completion"
> +	depends on DEBUG_KERNEL && RCU_EXPERT
> +	default n
> +	help
> +	  This option enables additional debugging for detecting a grace
> +	  period incompletion for synchronize_rcu() users. If a GP is not
> +	  fully passed for any user, the warning message is emitted.
> +
> +	  Say Y here if you want to enable such debugging
> +	  Say N if you are unsure.
> +
>  endmenu # "RCU Debugging"
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c0d3e46730e8..421bce4b8dd7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1547,7 +1547,8 @@ static void rcu_sr_normal_complete(struct llist_node *node)
>  		(struct rcu_head *) node, struct rcu_synchronize, head);
>  	unsigned long oldstate = (unsigned long) rs->head.func;
>  
> -	WARN_ONCE(!rcu_gp_is_expedited() && !poll_state_synchronize_rcu(oldstate),
> +	WARN_ONCE(IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP) &&
> +		!poll_state_synchronize_rcu(oldstate),
>  		"A full grace period is not passed yet: %lu",
>  		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
>  
> @@ -3822,7 +3823,9 @@ static void synchronize_rcu_normal(void)
>  	 * This code might be preempted, therefore take a GP
>  	 * snapshot before adding a request.
>  	 */
> -	rs.head.func = (void *) get_state_synchronize_rcu();
> +	if (IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP))
> +		rs.head.func = (void *) get_state_synchronize_rcu();
> +
>  	rcu_sr_normal_add_req(&rs);
>  
>  	/* Kick a GP and start waiting. */
> -- 
> 2.39.2
> 

