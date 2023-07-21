Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CB875D6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGUVnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjGUVnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F703A86;
        Fri, 21 Jul 2023 14:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A61B861D9E;
        Fri, 21 Jul 2023 21:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A65C433C7;
        Fri, 21 Jul 2023 21:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689975828;
        bh=5OypTY92vR4ii5FD5NdPd22+sYnRdWN6NGC5ng0U2No=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=M5aI52EmmH2dyMkJeZpuhvn8b99Z/c8eBlHhZ5LvSz78tdVK0EZ71qcGTjKnzn3Aq
         q1fyq+kMuzFhs6RFP3XxjLKR8hq74R8mErvhlLqTFb75jlzSlqezJfSMKPbtupxJd/
         bQG1QhoCrxYdkiinZ/DcCnhRtHtIRWsvsn8rZQnYD2xTRzWTZRZkXd88gKHrOjMSCF
         YjClnzwVtOnutwjPKVegC/DsEMjiN0jFxQ/c1PS5CMTWkm8nILsVNUasLhxLeCqQiG
         J9uXtOmqgSDiYd1su4l+aJYiI15JssKHAmMfHBttVlcgzvN9ZevOMN9JE+I7qY6HG1
         9jtQZoTyvuZNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C580CE09E0; Fri, 21 Jul 2023 14:43:47 -0700 (PDT)
Date:   Fri, 21 Jul 2023 14:43:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, osh@joshtriplett.org, boqun.feng@gmail.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on
 rcu_report_qs_rdp
Message-ID: <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230721121534.44328-1-ppbuk5246@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721121534.44328-1-ppbuk5246@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 01:15:33PM +0100, Levi Yun wrote:
> Wherever rcu_report_qs_rdp is called, cpu_no_qs.norm value is false.
> Therefore, Remove unnecessary check in rcu_report_qs_rdp.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>

Why not start with something like this?

	if (!WARN_ON_ONCE(!rdp->cpu_no_qs.b.norm) ||
	    rdp->gp_seq != rnp->gp_seq || rdp->gpwrap) {

Except that rcu_report_qs_rdp() is invoked with interrupts enabled,
which means that there is some possibility of state changes up to the
raw_spin_lock_irqsave_rcu_node(rnp, flags) statement.

So, did you check whether RCU's interrupt paths change this state?

						Thanx, Paul

> ---
>  kernel/rcu/tree.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1449cb69a0e0..d840596e9903 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1962,8 +1962,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
>  	rnp = rdp->mynode;
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -	if (rdp->cpu_no_qs.b.norm || rdp->gp_seq != rnp->gp_seq ||
> -	    rdp->gpwrap) {
> +	if (rdp->gp_seq != rnp->gp_seq || rdp->gpwrap) {
> 
>  		/*
>  		 * The grace period in which this quiescent state was
> --
> 2.37.2
