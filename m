Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3368375D793
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGUWhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGUWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9835A1;
        Fri, 21 Jul 2023 15:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A0A61DA7;
        Fri, 21 Jul 2023 22:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0582C433C8;
        Fri, 21 Jul 2023 22:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689979025;
        bh=JtgWv9gkBPTO/7duoIXZzImHZiRPR2Xkc9D0oLfDOBk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JoVHpeRvt3srOFXA2jb354adqL1WTBXimO/3s/1QSu8ZQayaZw3ztC5HTPvU1vhcy
         U0/IgCP+osmKT6VArwK2SQDQbHwQ6upGSQDCpUDRaa/sdvqVrqiirAdHjbpM7IHJfe
         7LYsg+/J9ChUmiG5Z3idC+wJydiBUJBNIZDouEoltKWn4LgVFlTnQR+r8rRauIhZ1G
         pVCFTK8fKXLm5u/5Kpz0PGJ6eIEe+6wT/03dFMSYeRJRp3UNaDOeRMhSNrKa7XfGjM
         24iV7erB8ooFeq+UGWU1zEHlm0OIPE3YHB2xlPLUWWmSoTahLNuQ58yV3rS6f75hrB
         x8VfcF3+TM80w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 74D24CE09E0; Fri, 21 Jul 2023 15:37:05 -0700 (PDT)
Date:   Fri, 21 Jul 2023 15:37:05 -0700
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
Subject: Re: [PATCH 1/2] rcu: Delete a redundant check in check_cpu_stall()
Message-ID: <11e9e09a-c47f-4690-a7c5-9a08913c3e5d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230721075716.857-1-thunder.leizhen@huaweicloud.com>
 <20230721075716.857-2-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721075716.857-2-thunder.leizhen@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 03:57:15PM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> j = jiffies;
> js = READ_ONCE(rcu_state.jiffies_stall);			(1)
> if (ULONG_CMP_LT(j, js))					(2)
> 	return;
> 
> if (cmpxchg(&rcu_state.jiffies_stall, js, jn) == js)		(3)
> 	didstall = true;
> 
> if (didstall && READ_ONCE(rcu_state.jiffies_stall) == jn) {	(4)
> 	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> 	WRITE_ONCE(rcu_state.jiffies_stall, jn);
> }
> 
> For ease of description, the pseudo code is extracted as above. First,
> assume that only one CPU is operating, the condition 'didstall' is true
> means that (3) succeeds. That is, the value of rcu_state.jiffies_stall
> must be 'jn'.
> 
> Then, assuming that another CPU is also operating at the same time, there
> are two cases:
> 1. That CPU sees the updated result at (1), it returns at (2).
> 2. That CPU does not see the updated result at (1), it fails at (3) and
>    cmpxchg returns jn. So that, didstall cannot be true.

The history behind this one is that there are races in which the stall
can end in the midst of check_cpu_stall().  For example, when the activity
of producing the stall warning breaks things loose.

And yes, long ago, I figured that if things had been static for so
many seconds, they were unlikely to change, and thus omitted any and
all synchronization.  The Linux kernel taught me better.  ;-)

							Thanx, Paul

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/rcu/tree_stall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index cc884cd49e026a3..371713f3f7d15d9 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -794,7 +794,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  			rcu_ftrace_dump(DUMP_ALL);
>  		didstall = true;
>  	}
> -	if (didstall && READ_ONCE(rcu_state.jiffies_stall) == jn) {
> +	if (didstall) {
>  		jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
>  		WRITE_ONCE(rcu_state.jiffies_stall, jn);
>  	}
> -- 
> 2.25.1
> 
