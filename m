Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0271A75DDF5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGVRlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768D82699;
        Sat, 22 Jul 2023 10:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D09D60BA0;
        Sat, 22 Jul 2023 17:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616E6C433C7;
        Sat, 22 Jul 2023 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690047655;
        bh=kiCfJdeGX5yhKNyQrI6BAr+nYft+EbJO9huApEPteK0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZnsZpE4LDyp367SCFY+0DwEWjYp9MFI3PRAJsi9a/8h0RIPAQTyYRvsCxoK/O73dv
         92n9TZTYnJtLkI5D8eCjlfjDdAAeft3RMixDGLITFMTmgF1oZ5PFssU76CgwCeTwXS
         8nWZahB1+vkIS3zsgXq8J/ABsT/EkNAk2TjiYRnObDFVOoChIVHTaz0yINUsXne/1i
         vjpL9RgeSDCcqoqGaUp7jYJbY8J6+Q4BlstbU67Ux+BDbvkTdRdENKb75weWFxSuBO
         4CRMKW2agBTQw2duE8zT9LODV9izMzpIjlKzH2i6+tsLAmSZi5yt4F91EMza7JX+23
         GcFyZ3NkUkLjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EC79BCE0902; Sat, 22 Jul 2023 10:40:54 -0700 (PDT)
Date:   Sat, 22 Jul 2023 10:40:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, osh@joshtriplett.org, boqun.feng@gmail.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on
 rcu_report_qs_rdp
Message-ID: <faf07eef-0a51-49f3-be48-0433952171ad@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230721121534.44328-1-ppbuk5246@gmail.com>
 <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
 <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 10:23:26AM +0100, Yun Levi wrote:
> Hi, Paul.
> 
> Thanks for looking into this :)
> 
> 
> > Except that rcu_report_qs_rdp() is invoked with interrupts enabled,
> > which means that there is some possibility of state changes up to the
> > raw_spin_lock_irqsave_rcu_node(rnp, flags) statement.
> >
> > So, did you check whether RCU's interrupt paths change this state?
> 
> In my narrow view,
> only a new gp started, cpu_no_qs.b.norm changes as true in the path of
> rcu_sched_clock_irq.
> But in that case, rcu_report_qs_rdp isn't called.
> 
> Did I understand your question well and are there any missed paths I didn't see?

Suppose that the scheduler-clock interrupt invoking rcu_sched_clock_irq()
happened just before the lock was acquired in rcu_report_qs_rdp().
Suppose further that the RCU grace-period kthread started a new grace
period just before that interrupt occurred.  Then mightn't that interrupt
notice the new grace period and set ->cpu_no_qs.b.norm to true before
fully returning?

							Thanx, Paul

> > Why not start with something like this?
> >
> >         if (!WARN_ON_ONCE(!rdp->cpu_no_qs.b.norm) ||
> >             rdp->gp_seq != rnp->gp_seq || rdp->gpwrap) {
> >
> 
> Yes. but with different message
