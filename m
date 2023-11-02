Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6A7DEBEC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348504AbjKBEhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348491AbjKBEhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:37:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585D1DC;
        Wed,  1 Nov 2023 21:37:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70D6C433C8;
        Thu,  2 Nov 2023 04:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698899821;
        bh=r1prF7q8EKkvrnoZX/1MuAe6CkHKKqbERBY23POhPrg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uPiKZ2QQgxU6HBnMqUE5AprgeqPqHPSJpaOCJHO+pZ8bk/yh6eyn3+1WAeFJAf7TR
         WdgSWx/2Z/O+kAzcEvrztboOK2YYcG6rAB8u8Gqnzer5AMwLyBUGjKCH/abmKMfyce
         pj1+aBJJTIsJXZhDLTlqrUzKqPGdn0TIZBWd/Ilhkv0xImwYzSmAvDxaPkBt88w97R
         t/HOy5Go6/5hPXKx5Vti1QczM5NRKTdS9PS4dFSfFStboLYktOXHpDx63I9vG0KjM8
         /qachse4hRy4SCUN6I79Rxm9mLXzrKx0T8Y6Noug3FsbdX4BBfnvJfSPfXGhmIXM7f
         hPRn8s7E8n/ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 95DEECE091E; Wed,  1 Nov 2023 21:37:01 -0700 (PDT)
Date:   Wed, 1 Nov 2023 21:37:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 3/3] doc: Add rcutree.rcu_normal_wake_from_gp to
 kernel-parameters.txt
Message-ID: <889e736a-c468-4600-ae1d-84aaa7330078@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231030131254.488186-1-urezki@gmail.com>
 <20231030131254.488186-4-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030131254.488186-4-urezki@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 02:12:54PM +0100, Uladzislau Rezki (Sony) wrote:
> This commit adds rcutree.rcu_normal_wake_from_gp description
> to the kernel-parameters.txt file.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Looks good aside from wordsmithing, thank you!

							Thanx, Paul

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 03a4bdb7512b..a9681d2492d3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5009,6 +5009,20 @@
>  			this kernel boot parameter, forcibly setting it
>  			to zero.
>  
> +	rcutree.rcu_normal_wake_from_gp= [KNL]
> +			Reduces a latency of synchronize_rcu() call. This approach
> +			maintains its own track of synchronize_rcu() callers, so it
> +			does not interact with regular callbacks because it does not
> +			use a call_rcu[_hurry]() path. Please note, this is for a
> +			normal grace period.
> +
> +			How to enable it:
> +
> +			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> +			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> +
> +			Default is 0.
> +
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous
>  			grace-period primitives such as call_rcu().
> -- 
> 2.30.2
> 
