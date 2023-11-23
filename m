Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E327F65A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbjKWRmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKWRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:42:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F099D7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:42:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AC9C433CA;
        Thu, 23 Nov 2023 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700761333;
        bh=wybC9NjaiAT+ygrEqCj1gw53nZJCWLLQbHdCCoiI/ig=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GBdkpKlpgH7AqaOJ59Z5kDNAyx7ZXldXmt4Bp5Candjvu78uXT43J9978CjQuoFhu
         y5zGm3I6G+0ML0KaJSApyOKMZMP28QzA2SGy/Eu6ASH3htPcjxRkHZYXB54hza6rpF
         bglT3uCnajq0KnPc/BRZ+8NXKmgMQLrJFoz5yIzdCfUFXX7QDEV3jW+oSEvJ+d6EEy
         E37lvDGqFnLAXUXnlBJUfQ2pfj33+oAd+kNZ8wWG1JqKDo3bK+dvQfpi/syL+nppPq
         rvwGzGYw9zlRHoCN9TSftKcjTHyJwChX6qHe9tD66kEjeqNnjsiCiMT1U+K9z5qlnB
         1h6u9mWqppoiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EEF54CE0D0D; Thu, 23 Nov 2023 09:42:12 -0800 (PST)
Date:   Thu, 23 Nov 2023 09:42:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Message-ID: <4ec83bf4-4c56-4f47-8473-151b57b80840@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231121205304.315146-1-qyousef@layalina.io>
 <811b2157-1009-4339-8ff2-0433512f3094@paulmck-laptop>
 <20231121214415.ovoskvbjarzpxi6e@airbuntu>
 <8ad4e628-7a88-490c-a54d-df09f851f189@paulmck-laptop>
 <20231121221556.vtpmboamgszbt3jf@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121221556.vtpmboamgszbt3jf@airbuntu>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:15:56PM +0000, Qais Yousef wrote:
> On 11/22/23 15:26, Paul E. McKenney wrote:
> 
> > > Either way; I'll follow what the crowd wants too :-)
> > 
> > Usually a wise choice.  ;-)
> > 
> > But I must defer to the people using it.
> 
> >From Android PoV I'd like to be able to boot with default disabled and allow
> people to opt-in. At least for the time being until we have confidence no one
> is caught with surprise if this caused unexpected problems.
> 
> In the future it might default to on once it gets wider usage and testing.
> 
> So having a new Kconfig to DEFAULT_OFF sounds good to me to enable a compile
> time switch to pick the default with a boot time to further control.
> 
> Which would be my plan for v2 unless I hear another suggestion in the coming
> week (where I hope people would have had a chance to look and think about it).

Sounds good to me!  Silence will be interpreted as assent.  ;-)

							Thanx, Paul

> > > No need for the rcu_barrier() then? Only reason why we use the _cb flavour
> > 
> > The module_param() parameters are processed during early boot, before
> > the boot CPU has enabled interrupts.  In fact, before rcu_init()
> > is invoked, which is in turn long before the scheduler has started.
> > Calling rcu_barrier() that early is not so good for your kernel's
> > actuarial statistics.
> 
> Ah, I missed that it is done that early.
> 
> > 
> > I am guessing that the module_param_cb() processing happens somewhat
> > later in the kernel's lifetime.
> 
> 
> Thanks!
> 
> --
> Qais Yousef
