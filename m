Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E935D789315
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjHZBaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjHZBaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89A1FC3;
        Fri, 25 Aug 2023 18:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D3AD64C0C;
        Sat, 26 Aug 2023 01:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFDAC433C8;
        Sat, 26 Aug 2023 01:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693013399;
        bh=vGGntP/JUdpGvY/07N+/3z2nUB9BkwpVwyJJTpsdfMg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kfGEfMYYKcbwI/jG6Ts2ZdQjxP0ZGKpC1ObuNtY/s/+odMnttVxTUOIVZyVnQAvCN
         ZWl3Qg5HEioZ9sjs2Z5ay74NVMCEdU6mQ5xwPEnD6HzJYMTSH4OmfNVCOXNBC9JZRS
         tkQtgh1U1/Fuxch1IsVEQab+aVZt/27cR29M2dhJExX6TDVlx5g5B5ODUfq6cE0ldG
         B0mudmV7MbnV9r2y2GWInggIvO4csOyWHcheSxYx2/EM0xZKZf9O2oIgeqbBcLzSWv
         hjB2saMxkQhaUE0xxjZx1OnNVR9D3TArIwAuXkkiJUZO9t58ohjGxf5X1W8TLev+wK
         Ll9d1aEpZ026A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3B4ABCE137E; Fri, 25 Aug 2023 18:29:57 -0700 (PDT)
Date:   Fri, 25 Aug 2023 18:29:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in
 rcu_nocb_toggle()
Message-ID: <20e7f112-ff70-4ba7-b39f-a0fea499d8d7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230824084206.22844-1-qiang.zhang1211@gmail.com>
 <162989fe-5ed8-4d1f-8c99-144e2de532f5@paulmck-laptop>
 <CALm+0cVgg9u1-E+XrnbEyD75a_H3ifN9oB9j6xx0=cm8kuXE-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cVgg9u1-E+XrnbEyD75a_H3ifN9oB9j6xx0=cm8kuXE-Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 10:28:37AM +0800, Z qiang wrote:
> >
> > On Thu, Aug 24, 2023 at 04:42:06PM +0800, Zqiang wrote:
> > > Currently, the maxcpu is set by traversing online CPUs, however, if
> > > the rcutorture.onoff_holdoff is set zero and onoff_interval is set
> > > non-zero, and the some CPUs with larger cpuid has been offline before
> > > setting maxcpu, for these CPUs, even if they are online again, also
> > > cannot be offload or deoffload.
> > >
> > > This commit therefore use for_each_possible_cpu() instead of
> > > for_each_online_cpu() in rcu_nocb_toggle().
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  kernel/rcu/rcutorture.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index a58372bdf0c1..b75d0fe558ce 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -2131,7 +2131,7 @@ static int rcu_nocb_toggle(void *arg)
> > >       VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
> > >       while (!rcu_inkernel_boot_has_ended())
> > >               schedule_timeout_interruptible(HZ / 10);
> > > -     for_each_online_cpu(cpu)
> > > +     for_each_possible_cpu(cpu)
> >
> > Last I checked, bad things could happen if the code attempted to
> > nocb_toggle a CPU that had not yet come online.  Has that changed?
> 
> For example, there are 8 online CPUs in the system, before we traversing online
> CPUs and set maxcpu,  CPU7 has been offline, this causes us to miss nocb_toggle
> for CPU7(maxcpu=6)
> 
> Even though we still use for_each_online_cpu(), the things described
> above also happen.  before we toggle the CPU, this CPU has been offline.

Suppose we have a system whose possible CPUs are 0, 1, 2, and 3.  However,
only 0 and 1 are present in this system, and until some manual action is
taken, only 0 and 1 will ever be online.  (Yes, this really can happen!)
In that state, won't toggling CPU 2 and 3 result in failures?

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >
> >                                                         Thanx, Paul
> >
> > >               maxcpu = cpu;
> > >       WARN_ON(maxcpu < 0);
> > >       if (toggle_interval > ULONG_MAX)
> > > --
> > > 2.17.1
> > >
