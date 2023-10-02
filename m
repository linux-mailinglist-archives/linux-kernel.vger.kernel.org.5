Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175307B5BDB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjJBULg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJBULf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:11:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1B3AC;
        Mon,  2 Oct 2023 13:11:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2590C433C8;
        Mon,  2 Oct 2023 20:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696277491;
        bh=ncy0wGCJ2hjg3VoApdm7ly5waa7mSKZO5dkfG6H7ffI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tv8Bnt3SwTOSbyTlHiMANimfqbRCq6Iq097sOUqA/sdsvl/arSp0xe0lJJTMwtmbd
         4aMIzPWq8A48XMFBGBlfmjB6sfxVB0Bh4vpgi4sEiMvdVyHhBn44XYAXgbUGnHVqP2
         rDgAsPXhfES5zGuSjE9b3Xf5ppqYRBDPixp8BToTXmOKaF9YM8jpCGWqxe8iBts4jH
         0km++HpV8WqwlwmsDG0Z34Uv8Sgae6KRMpAIYVV0XNApAJCoY/U0YvN5+5SHccZGs5
         sVPTpW7bljjoJJyxpwpsngRfwCkJdVunVJKL9jNXoO8wPyNgPdNwYcwxYiASnpEacy
         DQUALCusRN7sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4417ECE0591; Mon,  2 Oct 2023 13:11:31 -0700 (PDT)
Date:   Mon, 2 Oct 2023 13:11:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Paasch <cpaasch@apple.com>, stable@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: kmemleak: Ignore kmemleak false positives when
 RCU-freeing objects
Message-ID: <e715c26a-61b9-4815-8cb6-d18839cd98f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230930174657.800551-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930174657.800551-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 05:46:56PM +0000, Joel Fernandes (Google) wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Since the actual slab freeing is deferred when calling kvfree_rcu(), so
> is the kmemleak_free() callback informing kmemleak of the object
> deletion. From the perspective of the kvfree_rcu() caller, the object is
> freed and it may remove any references to it. Since kmemleak does not
> scan RCU internal data storing the pointer, it will report such objects
> as leaks during the grace period.
> 
> Tell kmemleak to ignore such objects on the kvfree_call_rcu() path. Note
> that the tiny RCU implementation does not have such issue since the
> objects can be tracked from the rcu_ctrlblk structure.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://lore.kernel.org/all/F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com/
> Cc: <stable@vger.kernel.org>
> Tested-by: Christoph Paasch <cpaasch@apple.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cb1caefa8bd0..24423877962c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -31,6 +31,7 @@
>  #include <linux/bitops.h>
>  #include <linux/export.h>
>  #include <linux/completion.h>
> +#include <linux/kmemleak.h>
>  #include <linux/moduleparam.h>
>  #include <linux/panic.h>
>  #include <linux/panic_notifier.h>
> @@ -3388,6 +3389,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  		success = true;
>  	}
>  
> +	/*
> +	 * The kvfree_rcu() caller considers the pointer freed at this point
> +	 * and likely removes any references to it. Since the actual slab
> +	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
> +	 * this object (no scanning or false positives reporting).
> +	 */
> +	kmemleak_ignore(ptr);
> +
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
>  		schedule_delayed_monitor_work(krcp);
> -- 
> 2.42.0.582.g8ccd20d70d-goog
> 
