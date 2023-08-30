Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2378DFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbjH3TIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbjH3JyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:54:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80551B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:54:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso31202665e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693389241; x=1693994041; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TQrf16cg+NiqdMGdtFVNJcxqedj4vde246HAhKjb6+Y=;
        b=SMBkeqqOQFDMPKH1I5KsrsGzYIz7jVfnkdI/okqApJgAzupnKzEZm3Mmr6sDG/888W
         PKWDiH+gG/VcE43uLOd8i9oBPLrwQcw6OmMoUrEZ1KPSa9e1Cbw4RlI3HgWlC5xz1icJ
         OuVqXdS2R+qryJOUc39u1AdlAHEdu7kv5XdjU04o7eETiHidsVKw0bpC6a73r/8iqgj+
         Sa5qlpg4uXJ4k/p2ZPssfw5kkH211lGURZCCUHKui5mQFGqieXw0zwrY34Gn1h7xWKti
         szqK0Y8/bVVff0JBtDtp5EprOoGFUczFpU8iszW0ceqnsQ6UJppOpWlSP+CvmRMwm+j8
         aH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693389241; x=1693994041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQrf16cg+NiqdMGdtFVNJcxqedj4vde246HAhKjb6+Y=;
        b=cCqgPPuacni0mUNo543b6HpVk3TCZfQbktNsD4ZNUAZ3yqJIONbgP4y4DTVsdWmO02
         EvG4zotADm5/lcm/zn58LLWgF4PCRjdxulpst3ripFFMNozS69Ayowk6+Ut4o5+ziK0/
         W9ABwbFRvllzRh9MR9l/1lHsScr2Zcuhdaqh6xoX8o/lifI45a5bxYXMmyTIkWNDS8ez
         rPNYbXk59Vvrt5hP2IZoLhBzO504R/g+mqtdW7cJAVr34lET1Rdv4Kn1x7JZ7YOV0au/
         IuC56L7iTBFULsv2xY7d7uHQ2eLDdsQumKVd9ZZzBGkLEedV8MQnB/ErqTBUa0mQMY5L
         RPrg==
X-Gm-Message-State: AOJu0YxZTEWG8ym/quSj5s+OURCf+5ulKVPR6oIX972pigeLbfdIFwQZ
        MdATgAvphZRe9AZPdPi56kVtOfCFjRF4AzDVQ+w=
X-Google-Smtp-Source: AGHT+IH+QX2uRpED63uPhWYhweJ0cWpNkPglQheXInf45HGQ9LkmLBDlmGod1hs8yCfFV8wKBunKpQ==
X-Received: by 2002:a05:600c:b57:b0:401:73b2:f039 with SMTP id k23-20020a05600c0b5700b0040173b2f039mr1530156wmr.7.1693389241342;
        Wed, 30 Aug 2023 02:54:01 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id z23-20020a1c4c17000000b00401d8181f8bsm1729781wmf.25.2023.08.30.02.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:54:00 -0700 (PDT)
Date:   Wed, 30 Aug 2023 10:53:59 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb: Flush console before entering kgdb on panic
Message-ID: <20230830095359.GA44243@aspen.lan>
References: <20230822131945.1.I5b460ae8f954e4c4f628a373d6e74713c06dd26f@changeid>
 <20230825100854.GC270740@aspen.lan>
 <CAD=FV=VHa1arysMgqZcGFGFi2N8i0BeKWD6BM8dSsg0Xq2LUFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VHa1arysMgqZcGFGFi2N8i0BeKWD6BM8dSsg0Xq2LUFQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 07:18:44AM -0700, Doug Anderson wrote:
> Hi,
>
> On Fri, Aug 25, 2023 at 3:09 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Tue, Aug 22, 2023 at 01:19:46PM -0700, Douglas Anderson wrote:
> > > When entering kdb/kgdb on a kernel panic, it was be observed that the
> > > console isn't flushed before the `kdb` prompt came up. Specifically,
> > > when using the buddy lockup detector on arm64 and running:
> > >   echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> > >
> > > I could see:
> > >   [   26.161099] lkdtm: Performing direct entry HARDLOCKUP
> > >   [   32.499881] watchdog: Watchdog detected hard LOCKUP on cpu 6
> > >   [   32.552865] Sending NMI from CPU 5 to CPUs 6:
> > >   [   32.557359] NMI backtrace for cpu 6
> > >   ... [backtrace for cpu 6] ...
> > >   [   32.558353] NMI backtrace for cpu 5
> > >   ... [backtrace for cpu 5] ...
> > >   [   32.867471] Sending NMI from CPU 5 to CPUs 0-4,7:
> > >   [   32.872321] NMI backtrace forP cpuANC: Hard LOCKUP
> > >
> > >   Entering kdb (current=..., pid 0) on processor 5 due to Keyboard Entry
> > >   [5]kdb>
> > >
> > > As you can see, backtraces for the other CPUs start printing and get
> > > interleaved with the kdb PANIC print.
> > >
> > > Let's replicate the commands to flush the console in the kdb panic
> > > entry point to avoid this.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  kernel/debug/debug_core.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > > index d5e9ccde3ab8..3a904d8697c8 100644
> > > --- a/kernel/debug/debug_core.c
> > > +++ b/kernel/debug/debug_core.c
> > > @@ -1006,6 +1006,9 @@ void kgdb_panic(const char *msg)
> > >       if (panic_timeout)
> > >               return;
> > >
> > > +     debug_locks_off();
> > > +     console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> > > +
> > >       if (dbg_kdb_mode)
> > >               kdb_printf("PANIC: %s\n", msg);
> >
> > I'm somewhat included to say *this* (calling kdb_printf() when not
> > actually in the debugger) is the cause of the problem. kdb_printf()
> > does some pretty horid things to the console and isn't intended to
> > run while the system is active.
> >
> > I'd therefore be more tempted to defer the print to the b.p. trap
> > handler itself and make this part of kgdb_panic() look more like:
> >
> >         kgdb_panic_msg = msg;
> >         kgdb_breakpoint();
> >         kgdb_panic_msg = NULL;
>
> Unfortunately I think that only solves half the problem. As a quick
> test, I tried simply commenting out the "kdb_printf" line in
> kgdb_panic(). While that avoids the interleaved panic message and
> backtrace, it does nothing to actually get the backtraces printed out
> before you end up in kdb. As an example, this is what happened when I
> used `echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT` and
> had the "kdb_printf" in kgdb_panic() commented out:
>
> [   72.658424] lkdtm: Performing direct entry HARDLOCKUP
> [   82.181857] watchdog: Watchdog detected hard LOCKUP on cpu 6
> ...
> [   82.234801] Sending NMI from CPU 5 to CPUs 6:
> [   82.239296] NMI backtrace for cpu 6
> ... [ stack trace for CPU 6 ] ...
> [   82.240294] NMI backtrace for cpu 5
> ... [ stack trace for CPU 5 ] ...
> [   82.576443] Sending NMI from CPU 5 to CPUs 0-4,7:
> [   82.581291] NMI backtrace
> Entering kdb (current=0xffffff80da5a1080, pid 6978) on processor 5 due
> to Keyboard Entry
> [5]kdb>
>
> As you can see, I don't see the traces for CPUs 0-4 and 7. Those do
> show up if I use the "dmesg" command but it's a bit of a hassle to run
> "dmesg" to look for any extra debug messages every time I drop in kdb.
>
> I guess perhaps that part isn't obvious from the commit message?

I figured it was a risk.

In fact it's an area where my instinct to honour console messages and my
instinct to get into the kernel as soon as possible after the decision
to invoke it has been made come into conflict.

In other words does it matter that the console buffers are not flushed
before entering kgdb? However having thought about it for a little while
(and knowing the console code tends to be written to be decently robust)
I can come to the view the flushing is best.


> Should I send a new version with an updated commit message indicating
> that it's not just the jumbled text that's a problem but also the lack
> of stack traces?

No real need.

I don't really like seeing kdb_printf() being called from here but
having reviewed a bit of console code I think we can might be able
to use the new infrastructure to make kdb_printf() a slightly less
hateful ;-).


Daniel.
