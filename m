Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EAE78B43B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjH1PSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjH1PRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB11E0;
        Mon, 28 Aug 2023 08:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A186B63BDF;
        Mon, 28 Aug 2023 15:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760FAC433C8;
        Mon, 28 Aug 2023 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693235870;
        bh=LFmmgGX7MzR1QCcy36wnq6eefcim8ud30MHJeHSrAIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUngBpFSGQhGUNp+MLtxwQqKljVZxD4VgjJLc3cef3M/Qe87GgOv3Z+32JEwet67d
         meocIgWmbcwJNwcr2Do5xPdJap1L0dc3tKm3l7OLROfBbEhIybuo+31Jgyr9AUYIKG
         jGKl1q2aVz9JozwTWqu1cOkXe+GaIT4gAntk/72a2MTEMxvSL05viaCyW/61Z+ZxL0
         hqwqlDTc6lRfnoCmWmTFmcac8KKp3zFYmnIXMgOoqwBr2lrdqqfKliHT/lE82X07do
         vttMSZ9SxBi0OmP43EgEnz/hI27z9sGEduYUVv4C6LW3/Rr2PwdqCXpl1sGTAJ4jJY
         kbNCTDBb5/coQ==
Date:   Mon, 28 Aug 2023 17:17:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Z qiang <qiang.zhang1211@gmail.com>, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in
 rcu_nocb_toggle()
Message-ID: <ZOy6mfw5Yr7hsi3i@2a01cb09806c67d6fe4a366cc09da8f8.ipv6.abo.wanadoo.fr>
References: <20230824084206.22844-1-qiang.zhang1211@gmail.com>
 <162989fe-5ed8-4d1f-8c99-144e2de532f5@paulmck-laptop>
 <CALm+0cVgg9u1-E+XrnbEyD75a_H3ifN9oB9j6xx0=cm8kuXE-Q@mail.gmail.com>
 <20e7f112-ff70-4ba7-b39f-a0fea499d8d7@paulmck-laptop>
 <CALm+0cV8GP_gbbiCwmKyMxE=Qm1pLVWXWkmHUjdaDS8L0hZgFw@mail.gmail.com>
 <7650aae0-36d2-467d-a2be-a96dabfcccae@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7650aae0-36d2-467d-a2be-a96dabfcccae@paulmck-laptop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Aug 26, 2023 at 06:06:20AM -0700, Paul E. McKenney a écrit :
> On Sat, Aug 26, 2023 at 02:13:39PM +0800, Z qiang wrote:
> > >
> > > On Fri, Aug 25, 2023 at 10:28:37AM +0800, Z qiang wrote:
> > > > >
> > > > > On Thu, Aug 24, 2023 at 04:42:06PM +0800, Zqiang wrote:
> > > > > > Currently, the maxcpu is set by traversing online CPUs, however, if
> > > > > > the rcutorture.onoff_holdoff is set zero and onoff_interval is set
> > > > > > non-zero, and the some CPUs with larger cpuid has been offline before
> > > > > > setting maxcpu, for these CPUs, even if they are online again, also
> > > > > > cannot be offload or deoffload.
> > > > > >
> > > > > > This commit therefore use for_each_possible_cpu() instead of
> > > > > > for_each_online_cpu() in rcu_nocb_toggle().
> > > > > >
> > > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > > ---
> > > > > >  kernel/rcu/rcutorture.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > > > index a58372bdf0c1..b75d0fe558ce 100644
> > > > > > --- a/kernel/rcu/rcutorture.c
> > > > > > +++ b/kernel/rcu/rcutorture.c
> > > > > > @@ -2131,7 +2131,7 @@ static int rcu_nocb_toggle(void *arg)
> > > > > >       VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
> > > > > >       while (!rcu_inkernel_boot_has_ended())
> > > > > >               schedule_timeout_interruptible(HZ / 10);
> > > > > > -     for_each_online_cpu(cpu)
> > > > > > +     for_each_possible_cpu(cpu)
> > > > >
> > > > > Last I checked, bad things could happen if the code attempted to
> > > > > nocb_toggle a CPU that had not yet come online.  Has that changed?
> > > >
> > > > For example, there are 8 online CPUs in the system, before we traversing online
> > > > CPUs and set maxcpu,  CPU7 has been offline, this causes us to miss nocb_toggle
> > > > for CPU7(maxcpu=6)
> > > >
> > > > Even though we still use for_each_online_cpu(), the things described
> > > > above also happen.  before we toggle the CPU, this CPU has been offline.
> > >
> > > Suppose we have a system whose possible CPUs are 0, 1, 2, and 3.  However,
> > > only 0 and 1 are present in this system, and until some manual action is
> > > taken, only 0 and 1 will ever be online.  (Yes, this really can happen!)
> > > In that state, won't toggling CPU 2 and 3 result in failures?
> > >
> > 
> > Agree.
> > As long as we enabled rcutorture.onoff_interval,  regardless of whether we use
> > online CPUs or possible CPUs to set maxcpu,  It is all possible to
> > toggling the CPUs failure
> > and print "NOCB: Cannot CB-offload offline CPU" log. but the failures
> > due to CPU offline are acceptable.
> > 
> > but at least the toggling operation on CPU7 will not be missed. when
> > CPU7 comes online again.
> > 
> > Would it be better to use for_each_present_cpu() ?
> 
> The problem we face is that RCU and rcutorture have no reasonable way
> of knowing when the boot-time CPU bringup has completed.  If there was a
> way of knowing that, then my approach would be to make rcutorture react
> to a holdoff of zero by waiting for all the CPUs to come online.
> 
> Failing that, for_each_present_cpu() with a holdoff of zero will likely
> get us transient failures between the time rcutorture starts and the
> last CPU has come online.
> 
> Or is there now a way for in-kernel code know when boot-time CPU onlining
> has completed?

We don't need to wait for all CPUs to be online though. Toggling
already handles well failures due to offline CPUs and since toggling
happens concurrently with offlining in rcutorture, we already see lots
of failures reported in the logs.

Thanks.
