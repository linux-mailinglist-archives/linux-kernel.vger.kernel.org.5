Return-Path: <linux-kernel+bounces-126845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAAA893EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8551F2141F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4642C47A66;
	Mon,  1 Apr 2024 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7Wj+joC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2F1CA8F;
	Mon,  1 Apr 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987754; cv=none; b=Q9wt5ON1BL9WPlJIxwsUiLsK+xa3SsDC8OSE3//nMLZIt2Wt9AG7IpX1bNGFAbrsVnZBBBSdLmpFHo+vPSUmt7SW0dCF8nVKMktJiN5ewnHCnVDKLCby3BbUcueR55kHlfhsSWQz+9yO4UhsLdpKgCFHF2cpUmRw6w4lxISS7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987754; c=relaxed/simple;
	bh=h0f1QZU12xDzELX/ESgt04e2YtnmDFzqm36XGRsVg7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq/fHsrkUGGi/8UjZK8K0eu81nmrS8gh3WrkQLzAXaApZ06zRf3tZ2MRV03xJHchaFTa5wJ5iAllRB4kuvtnmo0Kw0eYQGP/CXM2PWck11GU9Mg8x8J6H4MxCm0o9PAqJYFXx5wRyHybF8TJ/zUq/TlLkU9rdw6ugyyWAFOUP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7Wj+joC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494DEC43390;
	Mon,  1 Apr 2024 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711987754;
	bh=h0f1QZU12xDzELX/ESgt04e2YtnmDFzqm36XGRsVg7w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=c7Wj+joC0bR9gxqC0smfVeJMV6DCGhASjvFbiWnxFCX4gwZUaAGI2Tz9GV3CA0t5C
	 R2RGWwxrzh8dfTcSS5+zubHUGEdJUW8wldVRmMuEf6sU+eviovGfu7P2LRzUu5Cp7t
	 kPEEZ1QNvAzqWEDokkTQNGLM0nkjDCqSp6I85yafzOVUTZ+2LLfj591fYVBYnPQbYy
	 rT/p/9XXO2UbBP4gI6+NpwlvndSLJxmfd41UNpH9sCK+2/lHiBrnVmIXQV6nXIETGK
	 zRd+fLOHcJIaYtPbcFstXOUv+u+YTscsvhhdZ3DfpTd7fL4+v2tZidISCJVXlsfB0O
	 RTjN2yuNhRS1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D5D5DCE0738; Mon,  1 Apr 2024 09:09:13 -0700 (PDT)
Date: Mon, 1 Apr 2024 09:09:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Make the rcu_gp_slow_register/unregister()
 be used only for rcutype test
Message-ID: <9c1624cf-5c7e-4717-9f0c-ba6cbbba08ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240329045245.16456-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329045245.16456-1-qiang.zhang1211@gmail.com>

On Fri, Mar 29, 2024 at 12:52:45PM +0800, Zqiang wrote:
> The rcu_gp_slow_register/unregister() is only valid for tests which
> the torture_type is rcu, this commit therefore generates gp_slow_register
> and gp_slow_unregister function pointers in rcu_torture_ops structures,
> and operates only when the function pointer exists.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Good point, queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 8654e99bd4a3..32f1c4e932eb 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -382,6 +382,8 @@ struct rcu_torture_ops {
>  	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
>  	int (*stall_dur)(void);
>  	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
> +	void (*gp_slow_register)(atomic_t *rgssp);
> +	void (*gp_slow_unregister)(atomic_t *rgssp);
>  	long cbflood_max;
>  	int irq_capable;
>  	int can_boost;
> @@ -570,6 +572,8 @@ static struct rcu_torture_ops rcu_ops = {
>  	.check_boost_failed	= rcu_check_boost_fail,
>  	.stall_dur		= rcu_jiffies_till_stall_check,
>  	.get_gp_data		= rcutorture_get_gp_data,
> +	.gp_slow_register	= rcu_gp_slow_register,
> +	.gp_slow_unregister	= rcu_gp_slow_unregister,
>  	.irq_capable		= 1,
>  	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
>  	.extendables		= RCUTORTURE_MAX_EXTEND,
> @@ -3343,12 +3347,12 @@ rcu_torture_cleanup(void)
>  			pr_info("%s: Invoking %pS().\n", __func__, cur_ops->cb_barrier);
>  			cur_ops->cb_barrier();
>  		}
> -		rcu_gp_slow_unregister(NULL);
> +		if (cur_ops->gp_slow_unregister)
> +			cur_ops->gp_slow_unregister(NULL);
>  		return;
>  	}
>  	if (!cur_ops) {
>  		torture_cleanup_end();
> -		rcu_gp_slow_unregister(NULL);
>  		return;
>  	}
>  
> @@ -3447,7 +3451,8 @@ rcu_torture_cleanup(void)
>  	else
>  		rcu_torture_print_module_parms(cur_ops, "End of test: SUCCESS");
>  	torture_cleanup_end();
> -	rcu_gp_slow_unregister(&rcu_fwd_cb_nodelay);
> +	if (cur_ops->gp_slow_unregister)
> +		cur_ops->gp_slow_unregister(NULL);
>  }
>  
>  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> @@ -3929,7 +3934,8 @@ rcu_torture_init(void)
>  	if (object_debug)
>  		rcu_test_debug_objects();
>  	torture_init_end();
> -	rcu_gp_slow_register(&rcu_fwd_cb_nodelay);
> +	if (cur_ops->gp_slow_register)
> +		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
>  	return 0;
>  
>  unwind:
> -- 
> 2.17.1
> 

