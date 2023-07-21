Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8A75D7A7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGUWpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGUWpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:45:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BA83A86;
        Fri, 21 Jul 2023 15:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFFA661DA7;
        Fri, 21 Jul 2023 22:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF70C433C7;
        Fri, 21 Jul 2023 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689979544;
        bh=laRv+88wjjpHhHhYfLumJkXL3NcEacG+YNj/KogaWHw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sILDCG+Nyv2MjbxqdB0F9NtfAnW/bHyrBpTTczIsVnZ6hD0mIF8OXUv+y+RAIDjmc
         33Fs4/QilZWF/xqmpQwIxY95Sr5I23O03Mw2CiLNxIiCnB1cGq4SLIcXElTjTSO387
         aOLBnd0zyyrR0FSZT9BQYRl5iF7hPk0MG57buI+Mp6eb74WcmxUVY6gG102VkFvegh
         OwIiqc6UqJgVPk0vI0Cw4SgmIb62wftEBSoQcIGIuXIUg+YXHVKQdPe8BbOwZteuBq
         jREMjvgreFUG4ndSiBVcobMRZ0LqBNGkdrJ9r6jPUhn/JpnoRW58Y1ClZfsQvMeJx7
         bPdMuk0HSl9bA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BEF8CCE09E0; Fri, 21 Jul 2023 15:45:43 -0700 (PDT)
Date:   Fri, 21 Jul 2023 15:45:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     thunder.leizhen@huaweicloud.com
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 2/2] rcu: Simplify check_cpu_stall()
Message-ID: <3a275469-63aa-4929-acbc-28b7ea4b7bc9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230721075716.857-1-thunder.leizhen@huaweicloud.com>
 <20230721075716.857-3-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721075716.857-3-thunder.leizhen@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 03:57:16PM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> The code and comments of self detected and other detected are the same
> except the output function. Combine the same parts to avoid duplication.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

This looks like a nice simplification, thank you!

Please make this not depend on the earlier patch and resend.

							Thanx, Paul

> ---
>  kernel/rcu/tree_stall.h | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 371713f3f7d15d9..0ade7f9dcaa18da 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -711,7 +711,7 @@ static void print_cpu_stall(unsigned long gps)
>  
>  static void check_cpu_stall(struct rcu_data *rdp)
>  {
> -	bool didstall = false;
> +	bool self_detected;
>  	unsigned long gs1;
>  	unsigned long gs2;
>  	unsigned long gps;
> @@ -758,10 +758,10 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  		return; /* No stall or GP completed since entering function. */
>  	rnp = rdp->mynode;
>  	jn = jiffies + ULONG_MAX / 2;
> +	self_detected = READ_ONCE(rnp->qsmask) & rdp->grpmask;
>  	if (rcu_gp_in_progress() &&
> -	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
> +	    (self_detected || ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY)) &&
>  	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> -
>  		/*
>  		 * If a virtual machine is stopped by the host it can look to
>  		 * the watchdog like an RCU stall. Check to see if the host
> @@ -770,31 +770,17 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  		if (kvm_check_and_clear_guest_paused())
>  			return;
>  
> -		/* We haven't checked in, so go dump stack. */
> -		print_cpu_stall(gps);
> -		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
> -			rcu_ftrace_dump(DUMP_ALL);
> -		didstall = true;
> -
> -	} else if (rcu_gp_in_progress() &&
> -		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
> -		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> -
> -		/*
> -		 * If a virtual machine is stopped by the host it can look to
> -		 * the watchdog like an RCU stall. Check to see if the host
> -		 * stopped the vm.
> -		 */
> -		if (kvm_check_and_clear_guest_paused())
> -			return;
> +		if (self_detected) {
> +			/* We haven't checked in, so go dump stack. */
> +			print_cpu_stall(gps);
> +		} else {
> +			/* They had a few time units to dump stack, so complain. */
> +			print_other_cpu_stall(gs2, gps);
> +		}
>  
> -		/* They had a few time units to dump stack, so complain. */
> -		print_other_cpu_stall(gs2, gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
>  			rcu_ftrace_dump(DUMP_ALL);
> -		didstall = true;
> -	}
> -	if (didstall) {
> +
>  		jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
>  		WRITE_ONCE(rcu_state.jiffies_stall, jn);
>  	}
> -- 
> 2.25.1
> 
