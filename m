Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906667B565B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbjJBPiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbjJBPiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:38:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C3793;
        Mon,  2 Oct 2023 08:38:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391E1C433C7;
        Mon,  2 Oct 2023 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261092;
        bh=zkVDhHmdG/HenpAh9KSbmzG6yizVpjgt+Q9FTI3CzxA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DIHu2sKIpFWyW99niQioOPuOxRZTzm8CdaTpxDYdgbEHOz76PWGg76/9oK36p6w2+
         ooKzkeyWiENKOcIxg/upZ0hc/2Dg2uXrPTv4/o+cbfICm6HlMI5qXTE5Rpqs3W907S
         fmYiJx4SSXuWII46frnnKLWlQzIT3bLFEZJb5iYJkHiD7Blnx5zbKzF+NvH9H6mgCc
         dAnJdKbN+JiaN1bSIzwjyz8OPM86YoJnJuaBy+2CARcJfYDzp1gqsP9Jy6JSF7JdAI
         q0ngD8myDXCKNTIn/KAZPuHGzu8b0g+esEOpdZwzmZzbN5SZFXkTSVbnt2LjpPdyo4
         PZXrzwXWSvflQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BF8D8CE0CCF; Mon,  2 Oct 2023 08:38:11 -0700 (PDT)
Date:   Mon, 2 Oct 2023 08:38:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 01/10] rcu: Use rcu_segcblist_segempty() instead of open
 coding it
Message-ID: <9f42c0ad-80ab-442a-9d10-1b09597f2078@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908203603.5865-2-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:35:54PM +0200, Frederic Weisbecker wrote:
> This makes the code more readable.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcu_segcblist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index f71fac422c8f..1693ea22ef1b 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -368,7 +368,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
>  	smp_mb(); /* Ensure counts are updated before callback is entrained. */
>  	rhp->next = NULL;
>  	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
> -		if (rsclp->tails[i] != rsclp->tails[i - 1])
> +		if (!rcu_segcblist_segempty(rsclp, i))
>  			break;
>  	rcu_segcblist_inc_seglen(rsclp, i);
>  	WRITE_ONCE(*rsclp->tails[i], rhp);
> @@ -551,7 +551,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  	 * as their ->gp_seq[] grace-period completion sequence number.
>  	 */
>  	for (i = RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
> -		if (rsclp->tails[i] != rsclp->tails[i - 1] &&
> +		if (!rcu_segcblist_segempty(rsclp, i) &&
>  		    ULONG_CMP_LT(rsclp->gp_seq[i], seq))
>  			break;
>  
> -- 
> 2.41.0
> 
