Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19347BFE8C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjJJNzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjJJNzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:55:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A89E;
        Tue, 10 Oct 2023 06:55:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5121AC433C8;
        Tue, 10 Oct 2023 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696946141;
        bh=CAC3ydJqdRBVcEoBwK9bf67K3RO2fxSTF5IMiNQO4dg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pZ5IVSp/ybAsYDh+hx4w80XtSoyiLhJiumboqq+iPlqTNn9eJarj1uDzYk6xgiEbI
         Vq7fUkNTHi2wE15vKo9fwJMLyOXrDKf6/ULWdUShAE/fWprfbziD5D0yjxt6r4SwUn
         lV1RpCL0H681Q+gSiswgQUBR9jtF1gu0hZ9y8AheVt1KYKPnrf2HZU6HG6DAc1/i86
         Qz7O3IIOJygTKD6ombCkvx6tYUwrDcrODM75WOX3m2CFQ3lL6FDISusfe7/4Mf6IiR
         irWI5sydAAFcpHqsOCjZgW7ImjbXEZSoxViPKsOR5thF7rH57nH+d6Cg6Q1DdAJymF
         sVlc3OdAYK18g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EB10BCE0C54; Tue, 10 Oct 2023 06:55:40 -0700 (PDT)
Date:   Tue, 10 Oct 2023 06:55:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 23/23] locktorture: Check the correct variable for
 allocation failure
Message-ID: <97ecfb49-e500-45f4-86bb-769b2d32e91c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231010115921.988766-1-frederic@kernel.org>
 <20231010115921.988766-24-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010115921.988766-24-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 01:59:21PM +0200, Frederic Weisbecker wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> 
> There is a typo so this checks the wrong variable.  "chains" plural vs
> "chain" singular.  We already know that "chains" is non-zero.
> 
> Fixes: 7f993623e9eb ("locktorture: Add call_rcu_chains module parameter")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

A name change to increase the Hamming distance would of course also be
good, though less urgent.  ;-)

> ---
>  kernel/locking/locktorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index a3abcd136f56..69d3cd2cfc3b 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -1075,7 +1075,7 @@ static int call_rcu_chain_init(void)
>  	if (call_rcu_chains <= 0)
>  		return 0;
>  	call_rcu_chain = kcalloc(call_rcu_chains, sizeof(*call_rcu_chain), GFP_KERNEL);
> -	if (!call_rcu_chains)
> +	if (!call_rcu_chain)
>  		return -ENOMEM;
>  	for (i = 0; i < call_rcu_chains; i++) {
>  		call_rcu_chain[i].crc_stop = false;
> -- 
> 2.34.1
> 
