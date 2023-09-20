Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000B17A7C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjITMBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjITMBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:01:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA80CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:01:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4C8D521C2E;
        Wed, 20 Sep 2023 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695211291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5xcG+pg3ggPPiHzf1hL2muaBJy0Lc1rt0ORYdQHbrg=;
        b=P85aQFX+7HY80Y6OsnPhF7kbTjbzj1nmeSmY/5H3Q0g/IDOJhi2y/EEK1ZTJitrMfJoJOJ
        2s9lNkdsGHu86HqD7nmOXVcvCO5jIhl6OmGd6U0SIruLm+F/vK7ntjEGnnrOHsSv9f0wqi
        MmnLsRbZol6W7y3o0lJwit/xYvgFxNg=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DF1B12C142;
        Wed, 20 Sep 2023 12:01:30 +0000 (UTC)
Date:   Wed, 20 Sep 2023 14:01:30 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb: Flush console before entering kgdb on panic
Message-ID: <ZQrfGho-M9ZHQe9F@alley>
References: <20230822131945.1.I5b460ae8f954e4c4f628a373d6e74713c06dd26f@changeid>
 <20230825100854.GC270740@aspen.lan>
 <CAD=FV=VHa1arysMgqZcGFGFi2N8i0BeKWD6BM8dSsg0Xq2LUFQ@mail.gmail.com>
 <20230830095359.GA44243@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830095359.GA44243@aspen.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-08-30 10:53:59, Daniel Thompson wrote:
> On Fri, Aug 25, 2023 at 07:18:44AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Aug 25, 2023 at 3:09 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 01:19:46PM -0700, Douglas Anderson wrote:
> > > > When entering kdb/kgdb on a kernel panic, it was be observed that the
> > > > console isn't flushed before the `kdb` prompt came up. Specifically,
> > > > when using the buddy lockup detector on arm64 and running:
> > > >   echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> > > >
> > > > I could see:
> > > >   [   26.161099] lkdtm: Performing direct entry HARDLOCKUP
> > > >   [   32.499881] watchdog: Watchdog detected hard LOCKUP on cpu 6
> > > >   [   32.552865] Sending NMI from CPU 5 to CPUs 6:
> > > >   [   32.557359] NMI backtrace for cpu 6
> > > >   ... [backtrace for cpu 6] ...
> > > >   [   32.558353] NMI backtrace for cpu 5
> > > >   ... [backtrace for cpu 5] ...
> > > >   [   32.867471] Sending NMI from CPU 5 to CPUs 0-4,7:
> > > >   [   32.872321] NMI backtrace forP cpuANC: Hard LOCKUP
> > > >
> > > >   Entering kdb (current=..., pid 0) on processor 5 due to Keyboard Entry
> > > >   [5]kdb>
> > > >
> > > > As you can see, backtraces for the other CPUs start printing and get
> > > > interleaved with the kdb PANIC print.
> > > >
> > > > Let's replicate the commands to flush the console in the kdb panic
> > > > entry point to avoid this.
> > > >
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > >  kernel/debug/debug_core.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > > > index d5e9ccde3ab8..3a904d8697c8 100644
> > > > --- a/kernel/debug/debug_core.c
> > > > +++ b/kernel/debug/debug_core.c
> > > > @@ -1006,6 +1006,9 @@ void kgdb_panic(const char *msg)
> > > >       if (panic_timeout)
> > > >               return;
> > > >
> > > > +     debug_locks_off();
> > > > +     console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> > > > +
> > > >       if (dbg_kdb_mode)
> > > >               kdb_printf("PANIC: %s\n", msg);
> > >
> > > I'm somewhat included to say *this* (calling kdb_printf() when not
> > > actually in the debugger) is the cause of the problem. kdb_printf()
> > > does some pretty horid things to the console and isn't intended to
> > > run while the system is active.
> > >
> > > I'd therefore be more tempted to defer the print to the b.p. trap
> > > handler itself and make this part of kgdb_panic() look more like:
> > >
> > >         kgdb_panic_msg = msg;
> > >         kgdb_breakpoint();
> > >         kgdb_panic_msg = NULL;
> >
> > Unfortunately I think that only solves half the problem. As a quick
> > test, I tried simply commenting out the "kdb_printf" line in
> > kgdb_panic(). While that avoids the interleaved panic message and
> > backtrace, it does nothing to actually get the backtraces printed out
> > before you end up in kdb. As an example, this is what happened when I
> > used `echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT` and
> > had the "kdb_printf" in kgdb_panic() commented out:
> >
> > [   72.658424] lkdtm: Performing direct entry HARDLOCKUP
> > [   82.181857] watchdog: Watchdog detected hard LOCKUP on cpu 6
> > ...
> > [   82.234801] Sending NMI from CPU 5 to CPUs 6:
> > [   82.239296] NMI backtrace for cpu 6
> > ... [ stack trace for CPU 6 ] ...
> > [   82.240294] NMI backtrace for cpu 5
> > ... [ stack trace for CPU 5 ] ...
> > [   82.576443] Sending NMI from CPU 5 to CPUs 0-4,7:
> > [   82.581291] NMI backtrace
> > Entering kdb (current=0xffffff80da5a1080, pid 6978) on processor 5 due
> > to Keyboard Entry
> > [5]kdb>
> >
> > As you can see, I don't see the traces for CPUs 0-4 and 7. Those do
> > show up if I use the "dmesg" command but it's a bit of a hassle to run
> > "dmesg" to look for any extra debug messages every time I drop in kdb.
> >
> > I guess perhaps that part isn't obvious from the commit message?
> 
> I figured it was a risk.
> 
> In fact it's an area where my instinct to honour console messages and my
> instinct to get into the kernel as soon as possible after the decision
> to invoke it has been made come into conflict.
> 
> In other words does it matter that the console buffers are not flushed
> before entering kgdb? However having thought about it for a little while
> (and knowing the console code tends to be written to be decently robust)
> I can come to the view the flushing is best.

Just for record. I wondered if there was bug in printk() that the
backtraces were not flushed. And I think that it is because they
are printed in NMI context where the conosle handling is deferred.

From this POV, the explicit flush makes perfect sense.

Best Regards,
Petr
