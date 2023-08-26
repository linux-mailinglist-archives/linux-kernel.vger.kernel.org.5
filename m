Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBDE7896DC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 15:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjHZNGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjHZNGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 09:06:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115971BCC;
        Sat, 26 Aug 2023 06:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CE260C19;
        Sat, 26 Aug 2023 13:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7284C433C8;
        Sat, 26 Aug 2023 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693055181;
        bh=BaWopcSK9rULsmtqhJkB5V82MS76XOq5bi827IJgjNM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZXB0gQhDhPEjWcYXWGEEaMMVwuXhV/h5wXPzAGkoDtZkiKP8IyD2voImyyCIPku1/
         qRIPuFP3h0YmE/bdLDYDm7558pkXIf6KKPl9WDF9GTLg8ImI0THl3VCx1O7wqaa371
         iTj6F94oBijgJXM/tJ6zDnneeWH8hAfEsW3NdruItdz9o18Mu+hH+V3+/1oQsziVc2
         mGIN1Cinn22IUBzhgVKXtKCSXfdMY+Wbl7CiO60sbaAItfZQtGyR10AloCJUJyyhmo
         VxyaV2Ensr20vDzfwnniZK3gaYYuJ4Vf1tOxMA24CTC1j4v25SdgdbXSbB3nWnhfQZ
         mDwrPXc2GFbgA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F215CE1349; Sat, 26 Aug 2023 06:06:20 -0700 (PDT)
Date:   Sat, 26 Aug 2023 06:06:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in
 rcu_nocb_toggle()
Message-ID: <7650aae0-36d2-467d-a2be-a96dabfcccae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230824084206.22844-1-qiang.zhang1211@gmail.com>
 <162989fe-5ed8-4d1f-8c99-144e2de532f5@paulmck-laptop>
 <CALm+0cVgg9u1-E+XrnbEyD75a_H3ifN9oB9j6xx0=cm8kuXE-Q@mail.gmail.com>
 <20e7f112-ff70-4ba7-b39f-a0fea499d8d7@paulmck-laptop>
 <CALm+0cV8GP_gbbiCwmKyMxE=Qm1pLVWXWkmHUjdaDS8L0hZgFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cV8GP_gbbiCwmKyMxE=Qm1pLVWXWkmHUjdaDS8L0hZgFw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 02:13:39PM +0800, Z qiang wrote:
> >
> > On Fri, Aug 25, 2023 at 10:28:37AM +0800, Z qiang wrote:
> > > >
> > > > On Thu, Aug 24, 2023 at 04:42:06PM +0800, Zqiang wrote:
> > > > > Currently, the maxcpu is set by traversing online CPUs, however, if
> > > > > the rcutorture.onoff_holdoff is set zero and onoff_interval is set
> > > > > non-zero, and the some CPUs with larger cpuid has been offline before
> > > > > setting maxcpu, for these CPUs, even if they are online again, also
> > > > > cannot be offload or deoffload.
> > > > >
> > > > > This commit therefore use for_each_possible_cpu() instead of
> > > > > for_each_online_cpu() in rcu_nocb_toggle().
> > > > >
> > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > ---
> > > > >  kernel/rcu/rcutorture.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > > index a58372bdf0c1..b75d0fe558ce 100644
> > > > > --- a/kernel/rcu/rcutorture.c
> > > > > +++ b/kernel/rcu/rcutorture.c
> > > > > @@ -2131,7 +2131,7 @@ static int rcu_nocb_toggle(void *arg)
> > > > >       VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
> > > > >       while (!rcu_inkernel_boot_has_ended())
> > > > >               schedule_timeout_interruptible(HZ / 10);
> > > > > -     for_each_online_cpu(cpu)
> > > > > +     for_each_possible_cpu(cpu)
> > > >
> > > > Last I checked, bad things could happen if the code attempted to
> > > > nocb_toggle a CPU that had not yet come online.  Has that changed?
> > >
> > > For example, there are 8 online CPUs in the system, before we traversing online
> > > CPUs and set maxcpu,  CPU7 has been offline, this causes us to miss nocb_toggle
> > > for CPU7(maxcpu=6)
> > >
> > > Even though we still use for_each_online_cpu(), the things described
> > > above also happen.  before we toggle the CPU, this CPU has been offline.
> >
> > Suppose we have a system whose possible CPUs are 0, 1, 2, and 3.  However,
> > only 0 and 1 are present in this system, and until some manual action is
> > taken, only 0 and 1 will ever be online.  (Yes, this really can happen!)
> > In that state, won't toggling CPU 2 and 3 result in failures?
> >
> 
> Agree.
> As long as we enabled rcutorture.onoff_interval,  regardless of whether we use
> online CPUs or possible CPUs to set maxcpu,  It is all possible to
> toggling the CPUs failure
> and print "NOCB: Cannot CB-offload offline CPU" log. but the failures
> due to CPU offline are acceptable.
> 
> but at least the toggling operation on CPU7 will not be missed. when
> CPU7 comes online again.
> 
> Would it be better to use for_each_present_cpu() ?

The problem we face is that RCU and rcutorture have no reasonable way
of knowing when the boot-time CPU bringup has completed.  If there was a
way of knowing that, then my approach would be to make rcutorture react
to a holdoff of zero by waiting for all the CPUs to come online.

Failing that, for_each_present_cpu() with a holdoff of zero will likely
get us transient failures between the time rcutorture starts and the
last CPU has come online.

Or is there now a way for in-kernel code know when boot-time CPU onlining
has completed?

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >                                                         Thanx, Paul
> >
> > > Thanks
> > > Zqiang
> > >
> > >
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > >               maxcpu = cpu;
> > > > >       WARN_ON(maxcpu < 0);
> > > > >       if (toggle_interval > ULONG_MAX)
> > > > > --
> > > > > 2.17.1
> > > > >
