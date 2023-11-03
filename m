Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4F7DFE2D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjKCCyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCCyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:54:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0340E19E;
        Thu,  2 Nov 2023 19:54:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0F4C433C7;
        Fri,  3 Nov 2023 02:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698980057;
        bh=WjCKWJ96urD0RbWA8/NzLzQQE0vm/ybcf+n2HE8KzMM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VIJo5VYhf0/+2yGmAK/8Ial6PVc66jrWJv5Tu8ZWmaJiYG+UmMEgB2HxLd9fbaTdk
         n/npQ+/R5ZaDRzkim5/xuC3dpP7eIfJEjFsp/UQ+TloEcsdretgP4UuNjM2iA0rqqN
         viknD057v7MHZVo3VplCjrDMrXyKs1iDppRmVg1EUgmQZYRkTP/+h4vzOFSQyOGTyM
         Rke6VvWeqnBA+co2eOmwxnODGAd9JuVcCchNstmxuimW98UoQWQw3pgpWt6mTFtu0M
         lN/kQsbWEle8ZFyE4QY4bzZKn0cj79ur7lp8245fogSBLZVXXoz0j+TybbT6mUl0E8
         pQqnCW+hyeppQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 22C33CE0F7A; Thu,  2 Nov 2023 19:54:17 -0700 (PDT)
Date:   Thu, 2 Nov 2023 19:54:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, boqun.feng@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Force quiescent states only for ongoing grace period
Message-ID: <9f15280f-45a3-4e3f-832d-cea5c77eb449@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231101033507.21651-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101033507.21651-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:35:07AM +0800, Zqiang wrote:
> Currently, when running the rcutorture testing, if the fqs_task
> kthread was created, the periodic fqs operations will be performed,
> regardless of whether the grace-period is ongoing. however, if there
> is no ongoing grace-period, invoke the rcu_force_quiescent_state() has
> no effect, because when the new grace-period starting, will clear all
> flags int rcu_state.gp_flags in rcu_gp_init(). this commit therefore add
> rcu_gp_in_progress() check in rcu_force_quiescent_state(), if there is
> no ongoing grace-period, return directly.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Nice optimization, but one question below.

						Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index aa4c808978b8..5b4279ef66da 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2338,6 +2338,8 @@ void rcu_force_quiescent_state(void)
>  	struct rcu_node *rnp;
>  	struct rcu_node *rnp_old = NULL;
>  
> +	if (!rcu_gp_in_progress())
> +		return;

Suppose that the grace period that was in progress above ends right
at this point in the code.  We will still do the useless grace
forcing of quiescent states.  Which means that this code path
does need to be tested.

So, when you run rcutorture with this change, how often has the
grace period ended before this function returns?  If that happens
reasonably often, say more than once per minute or so, then this
works nicely.  If not, we do need to do something to make sure
that that code path gets tested.

Thoughts?

>  	/* Funnel through hierarchy to reduce memory contention. */
>  	rnp = raw_cpu_read(rcu_data.mynode);
>  	for (; rnp != NULL; rnp = rnp->parent) {
> -- 
> 2.17.1
> 
