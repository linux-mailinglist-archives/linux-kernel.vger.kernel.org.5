Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD87C00D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjJJPxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjJJPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:53:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553893;
        Tue, 10 Oct 2023 08:53:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569FFC433C7;
        Tue, 10 Oct 2023 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953217;
        bh=dJilxtsFO/qehFaC1MAIXeHjdS9M64JARVtLJnq4Gcs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KkgRaUufLL5SjMzVSiyv0sN529gh9ETW+Ycgy2Z/tjdr0zoKaJhjr3wUZono0wTT4
         x5ALHQiuMwfHlS9s4BqJ1ZZGXCYpR4H6608KKTPubfx17Keh5C/Ho1BujqiDszPuyk
         gU4H9vPRK5wKEURRuhEAIV/6dIzSYXuOgqNpZaXXwcETkZMR/96K85UYAqj0nDozs2
         VvRq+XG2w5Nk5GJVAFy4AfdwbQlnl5khQsL4QDhgYDG3PPTthLjfrGFWXYUZsflH+C
         S/4mlO6t595T0zWCTlnLvArov8i0o4Wv/JRjjVl4y3RPtbHknUUBJCry5TO/IIHlPV
         xd4aVmz8NRx3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E3074CE0D02; Tue, 10 Oct 2023 08:53:36 -0700 (PDT)
Date:   Tue, 10 Oct 2023 08:53:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 23/23] locktorture: Check the correct variable for
 allocation failure
Message-ID: <b9a976f6-c002-4e3d-8c6d-cef3953bd3a7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231010115921.988766-1-frederic@kernel.org>
 <20231010115921.988766-24-frederic@kernel.org>
 <97ecfb49-e500-45f4-86bb-769b2d32e91c@paulmck-laptop>
 <beaba092-8545-43c9-9b65-6386f718cb01@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beaba092-8545-43c9-9b65-6386f718cb01@kadam.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 05:07:00PM +0300, Dan Carpenter wrote:
> On Tue, Oct 10, 2023 at 06:55:40AM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 10, 2023 at 01:59:21PM +0200, Frederic Weisbecker wrote:
> > > From: Dan Carpenter <dan.carpenter@linaro.org>
> > > 
> > > There is a typo so this checks the wrong variable.  "chains" plural vs
> > > "chain" singular.  We already know that "chains" is non-zero.
> > > 
> > > Fixes: 7f993623e9eb ("locktorture: Add call_rcu_chains module parameter")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > A name change to increase the Hamming distance would of course also be
> > good, though less urgent.  ;-)
> 
> "Hamming distance" is such a great phrase.  I'm going to use that every
> time I complain about confusingly similar variable names going forward.

Glad you like it!

But the horrible thing is that I first heard that phrase back in
the 1970s, and I am the guilty party who created these particular
too-similar variable names.  (Why has the phrase fallen out of favor?
No idea, really, but one guess has to do with the fact that current
error-correcting codes must deal with different probabilities of different
bits flipping in different directions, so you would instead needs a
weirdly weighted variant of Hamming distance to accomplish anything with
modern error-correcting codes.)

But how about something like the following?

							Thanx, paul

------------------------------------------------------------------------

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 991496afc0d9..48fd4562a754 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -126,7 +126,7 @@ struct call_rcu_chain {
 	struct rcu_head crc_rh;
 	bool crc_stop;
 };
-struct call_rcu_chain *call_rcu_chain;
+struct call_rcu_chain *call_rcu_chain_list;
 
 /* Forward reference. */
 static void lock_torture_cleanup(void);
@@ -1106,12 +1106,12 @@ static int call_rcu_chain_init(void)
 
 	if (call_rcu_chains <= 0)
 		return 0;
-	call_rcu_chain = kcalloc(call_rcu_chains, sizeof(*call_rcu_chain), GFP_KERNEL);
-	if (!call_rcu_chain)
+	call_rcu_chain_list = kcalloc(call_rcu_chains, sizeof(*call_rcu_chain_list), GFP_KERNEL);
+	if (!call_rcu_chain_list)
 		return -ENOMEM;
 	for (i = 0; i < call_rcu_chains; i++) {
-		call_rcu_chain[i].crc_stop = false;
-		call_rcu(&call_rcu_chain[i].crc_rh, call_rcu_chain_cb);
+		call_rcu_chain_list[i].crc_stop = false;
+		call_rcu(&call_rcu_chain_list[i].crc_rh, call_rcu_chain_cb);
 	}
 	return 0;
 }
@@ -1121,13 +1121,13 @@ static void call_rcu_chain_cleanup(void)
 {
 	int i;
 
-	if (!call_rcu_chain)
+	if (!call_rcu_chain_list)
 		return;
 	for (i = 0; i < call_rcu_chains; i++)
-		smp_store_release(&call_rcu_chain[i].crc_stop, true);
+		smp_store_release(&call_rcu_chain_list[i].crc_stop, true);
 	rcu_barrier();
-	kfree(call_rcu_chain);
-	call_rcu_chain = NULL;
+	kfree(call_rcu_chain_list);
+	call_rcu_chain_list = NULL;
 }
 
 static struct notifier_block lock_torture_stall_block;
