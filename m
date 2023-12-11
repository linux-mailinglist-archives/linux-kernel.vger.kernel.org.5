Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8615F80D22E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbjLKQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344504AbjLKQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:38:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE7498
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:39:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CDAC433C9;
        Mon, 11 Dec 2023 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702312740;
        bh=JGP5scqqz/G1q85Ox8Gnu7cOnTT2TgsJaikSLnT5GoE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qkPPYIgeeegC+BG9xu4cWmc+FxTsPG8qWSIlwVmQDnotTPPLlkZ6S/Tx/LWM/rJid
         T2wN5wxab7kGy6FQbGByGJLcbffVuaLq/1sISpO8nIo5YOfjKDhfQF0OnOf5GYbYOS
         O8Gq2tCoJit6UGJe8ZwhIU+cBHPWm+d9Pk45ec/GNMPuXwPyYu/dvAxwNnSVGps5AL
         MVe8RMB/0/KwiKrHp0Qtgb7xqw9vfZjeTur8Ewf13Sam7rXroYiSkcb6fCMgE49q15
         ZmEnfZ7nVJAS+6hC6Rsu0Pj1WkL0WevQiom/8qEPGarOhLRYDxvsg0CdGi1G5v9Bb+
         1QuHPWtXgxmvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C1A5ECE0569; Mon, 11 Dec 2023 08:38:59 -0800 (PST)
Date:   Mon, 11 Dec 2023 08:38:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/8] rcu: Fix expedited GP deadlock (and cleanup some
 nocb stuff)
Message-ID: <0be847d6-804e-4f9d-9eb4-beee9efb6c78@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231208220545.7452-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208220545.7452-1-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 11:05:37PM +0100, Frederic Weisbecker wrote:
> TREE04 can trigger a writer stall if run with memory pressure. This
> is due to a circular dependency between waiting for expedited grace
> period and polling on expedited grace period when workqueues go back
> to mayday serialization.
> 
> Here is a proposal fix.

The torture.sh "acceptance test" with KCSAN and --duration 30 ran
fine except for this in TREE09:

kernel/rcu/tree_nocb.h:1785:13: error: unused function '__call_rcu_nocb_wake' [-Werror,-Wunused-function]

My guess is that the declaration of __call_rcu_nocb_wake() in
kernel/rcu/tree.h needs an "#ifdef CONFIG_SMP", but you might have a
better fix.

						Thanx, Paul

> Frederic Weisbecker (8):
>   rcu/nocb: Make IRQs disablement symetric
>   rcu/nocb: Re-arrange call_rcu() NOCB specific code
>   rcu/exp: Fix RCU expedited parallel grace period kworker allocation
>     failure recovery
>   rcu/exp: Handle RCU expedited grace period kworker allocation failure
>   rcu: s/boost_kthread_mutex/kthread_mutex
>   rcu/exp: Make parallel exp gp kworker per rcu node
>   rcu/exp: Handle parallel exp gp kworkers affinity
>   rcu/exp: Remove rcu_par_gp_wq
> 
>  kernel/rcu/rcu.h         |   5 -
>  kernel/rcu/tree.c        | 222 +++++++++++++++++++++++++--------------
>  kernel/rcu/tree.h        |  12 +--
>  kernel/rcu/tree_exp.h    |  81 +++-----------
>  kernel/rcu/tree_nocb.h   |  38 ++++---
>  kernel/rcu/tree_plugin.h |  52 ++-------
>  6 files changed, 191 insertions(+), 219 deletions(-)
> 
> -- 
> 2.42.1
> 
