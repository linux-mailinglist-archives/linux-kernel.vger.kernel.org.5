Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC0675AC23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGTKiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGTKhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:37:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6BC10F1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bQIfEX3jdLPgeY6r+H0hIMqnc0pNiz7sqvIrDHFa7IQ=; b=pbv2n7m2GWEZBtUwG1Zlu+iUwU
        XdtJmruxFs8Sdaj8qYNh4o1G9EM19lSHqT86G5NP9ZayNsaV+KORG6qtEzr9Xu/n71gz4Srm4NO9k
        nAT9H05as1mDBZS7Tcn11DFA0dbvHyf0nXWiifVXVTim7/kiRWGFkTJDivq1Dl3niHQONjiNjuPVn
        LZ5hl7+vPbWTy7yB1vX6S2wdjNVZiM3/SbpZlWw11d8dK1XEXAkDJpeq9Iefb/KZVF6+dmGcotnks
        uwVZ26LU56LjpKeV/gZC6hrBLvNMhkW38j66bB/QMqFqFrhCcMrK+9dtOwCd9B1gj70+4iXoNx7r9
        2A05q+tA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMR2b-00FWew-1T;
        Thu, 20 Jul 2023 10:37:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A57E300346;
        Thu, 20 Jul 2023 12:37:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 643D02612ABE5; Thu, 20 Jul 2023 12:37:46 +0200 (CEST)
Date:   Thu, 20 Jul 2023 12:37:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arun KS <arunks.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arun KS <getarunks@gmail.com>, pmladek@suse.com,
        tglx@linutronix.de
Subject: Re: Question on sched_clock
Message-ID: <20230720103746.GC3569127@hirez.programming.kicks-ass.net>
References: <CAKZGPAOYPp3ANWfBWxcsT3TJdPt8jH-f2ZJzpin=UZ=-b_-QFg@mail.gmail.com>
 <CAKZGPAOY9uxvSTuta+4a41=GGqTxus8YDcv54T7iAL9P-fj_+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKZGPAOY9uxvSTuta+4a41=GGqTxus8YDcv54T7iAL9P-fj_+w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 03:54:56PM +0530, Arun KS wrote:
> CCing maintainers
> 
> On Wed, Jul 19, 2023 at 10:36 AM Arun KS <arunks.linux@gmail.com> wrote:
> >
> > Hi,
> >
> > Kernel’s printk uses local_clock() for timestamps and it is mapped to
> > sched_clock(). Two problems/requirements I see,
> >
> > One, Kernel’s printk timestamps start from 0, I want to change this to
> > match with actual time since boot.

You can fundamentally only consistently tell time since the clock gets
initialized. Starting at 0 is what you get.

> > Two, sched_clock() doesn’t account for time spend in low power
> > state(suspend to ram)

Why would we do that? The next person will complain that they don't want
this. Then another person complains they also want time spend in
suspend-to-disk, and another person wants a pony.

> >
> > Could workout patches to modify these behaviours and found working in
> > my system. But need to hear expert opinion on why this is not done in
> > the upstream.
> >
> > diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> > index 68d6c1190ac7..b63b2ded5727 100644
> > --- a/kernel/time/sched_clock.c
> > +++ b/kernel/time/sched_clock.c

This is only one of many sched_clock implementations...

> > @@ -190,7 +190,10 @@ sched_clock_register(u64 (*read)(void), int bits,
> > unsigned long rate)
> >         /* Update epoch for new counter and update 'epoch_ns' from old counter*/
> >         new_epoch = read();
> >         cyc = cd.actual_read_sched_clock();
> > -       ns = rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) &
> > rd.sched_clock_mask, rd.mult, rd.shift);
> > +       if (!cyc)
> > +               ns = cyc_to_ns(new_epoch, new_mult, new_shift)
> > +       else
> > +               ns = rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) &
> > rd.sched_clock_mask, rd.mult, rd.shift);
> >         cd.actual_read_sched_clock = read;
> >
> >         rd.read_sched_clock     = read;
> >
> > @@ -287,7 +290,6 @@ void sched_clock_resume(void)
> >  {
> >         struct clock_read_data *rd = &cd.read_data[0];
> >
> > -       rd->epoch_cyc = cd.actual_read_sched_clock();

And what if you've been suspended long enough to wrap the clock ?!?

> >         hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD);
> >         rd->read_sched_clock = cd.actual_read_sched_clock;
> >  }
> >
> > Regards,
> > Arun
