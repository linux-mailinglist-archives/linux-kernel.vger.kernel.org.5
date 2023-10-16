Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB877CAAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjJPOA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJPOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:00:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEA09B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:00:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32db188e254so894848f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697464820; x=1698069620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eDGQeCo8V2sN0t+O9GNO1jubu9jMmcOIokTbMoAoZDo=;
        b=bFxfjoLQ6UsRQvRt9P3Dr4gZetJrSZ76FEmQeKchxGQm3IMj/orNo7ByMLj+BrNOeR
         vFju/3KKhe2qkbWLHkQqwiuCHv3tG0kcEL4n8uYdmuij8oetlCLNbOxGcVnqaNiu5QmO
         hPLmyYSBVGotSKErNyCgJPOXPh7qwuagmEz9/ZvyT4rNcDpYxyF7zKEgkUTue2872zZQ
         YTTepw0DpttM1KtnMQA/tOnfOCFw/lTPfIya3+PNcPQxSFZDMKOJsO8+m0aGKYdPsHZi
         faNnBK6u8M8qXtHcpMhTnP7qZvNuGkGC6n2dk1JzOYK3VoNhMb8o5qvQn3dl+SbW6VtK
         yuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697464820; x=1698069620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDGQeCo8V2sN0t+O9GNO1jubu9jMmcOIokTbMoAoZDo=;
        b=jmU2pmGjz6LIlRx63XlVwK0P+snOYe35KdC9y+gorFpawvSBYCy/Q/u35Y7cXLbeGS
         pJB6C1SimP/85L/IzdgcaUGfwDj+F38RkNwTTS9A4+Hxy824p5szeJKss3ZdbzwjUA/X
         P9RwIWsUoXHWSFX39GPBhiGV3BM1BagiCpnlQ9BWCq9tu6lne+th+a5safMbcZQ7Ddn2
         XeqxNSYgrRoZ3z+0Bht10wE0z79VIkrl8ZV9OUrpQNxJPLFdb5a/uxHa20sgx5IPPk/W
         vnXQkzaQpeM2qs7rbaYoxrKdrh53NeJ/w/c9DmxBFAljoJ/lCmdGxMNGecfYl3e1TCSV
         wOfw==
X-Gm-Message-State: AOJu0Yy/dNRPJGgGTBsc6wRyQWqDUFKS5zHB6n9JbSAPIgDivLQnkf6j
        sVHhW5tf9swTXbwSMkQUTreZ0A==
X-Google-Smtp-Source: AGHT+IGJQJysehFTxAPwxBpw5JMtYiRjxXlCiE0L8eX1v9Nl7lopYTAwJFcz4ASvEhzaP4YRec0IoQ==
X-Received: by 2002:a5d:5f04:0:b0:32d:8872:aacb with SMTP id cl4-20020a5d5f04000000b0032d8872aacbmr13881089wrb.53.1697464820459;
        Mon, 16 Oct 2023 07:00:20 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bw14-20020a0560001f8e00b0032d886039easm13152255wrb.14.2023.10.16.07.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:00:20 -0700 (PDT)
Date:   Mon, 16 Oct 2023 15:00:18 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb: Flush console before entering kgdb on panic
Message-ID: <20231016140018.GA35190@aspen.lan>
References: <20230822131945.1.I5b460ae8f954e4c4f628a373d6e74713c06dd26f@changeid>
 <20230825100854.GC270740@aspen.lan>
 <CAD=FV=VHa1arysMgqZcGFGFi2N8i0BeKWD6BM8dSsg0Xq2LUFQ@mail.gmail.com>
 <20230830095359.GA44243@aspen.lan>
 <ZQrfGho-M9ZHQe9F@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQrfGho-M9ZHQe9F@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:01:30PM +0200, Petr Mladek wrote:
> On Wed 2023-08-30 10:53:59, Daniel Thompson wrote:
> > On Fri, Aug 25, 2023 at 07:18:44AM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Fri, Aug 25, 2023 at 3:09 AM Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 01:19:46PM -0700, Douglas Anderson wrote:
> > > > > When entering kdb/kgdb on a kernel panic, it was be observed that the
> > > > > console isn't flushed before the `kdb` prompt came up. Specifically,
> > > > > when using the buddy lockup detector on arm64 and running:
> > > > >   echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> > > > >
> > > > > I could see:
> > > > >   [   26.161099] lkdtm: Performing direct entry HARDLOCKUP
> > > > >   [   32.499881] watchdog: Watchdog detected hard LOCKUP on cpu 6
> > > > >   [   32.552865] Sending NMI from CPU 5 to CPUs 6:
> > > > >   [   32.557359] NMI backtrace for cpu 6
> > > > >   ... [backtrace for cpu 6] ...
> > > > >   [   32.558353] NMI backtrace for cpu 5
> > > > >   ... [backtrace for cpu 5] ...
> > > > >   [   32.867471] Sending NMI from CPU 5 to CPUs 0-4,7:
> > > > >   [   32.872321] NMI backtrace forP cpuANC: Hard LOCKUP
> > > > >
> > > > >   Entering kdb (current=..., pid 0) on processor 5 due to Keyboard Entry
> > > > >   [5]kdb>
> > > > >
> > > > > As you can see, backtraces for the other CPUs start printing and get
> > > > > interleaved with the kdb PANIC print.
> > > > >
> > > > > Let's replicate the commands to flush the console in the kdb panic
> > > > > entry point to avoid this.
> > > > >
> > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > ---
> > > > >
> > > > >  kernel/debug/debug_core.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > > > > index d5e9ccde3ab8..3a904d8697c8 100644
> > > > > --- a/kernel/debug/debug_core.c
> > > > > +++ b/kernel/debug/debug_core.c
> > > > > @@ -1006,6 +1006,9 @@ void kgdb_panic(const char *msg)
> > > > >       if (panic_timeout)
> > > > >               return;
> > > > >
> > > > > +     debug_locks_off();
> > > > > +     console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> > > > > +
> > > > >       if (dbg_kdb_mode)
> > > > >               kdb_printf("PANIC: %s\n", msg);
> > > >
> > > > I'm somewhat included to say *this* (calling kdb_printf() when not
> > > > actually in the debugger) is the cause of the problem. kdb_printf()
> > > > does some pretty horid things to the console and isn't intended to
> > > > run while the system is active.
> > > >
> > > > I'd therefore be more tempted to defer the print to the b.p. trap
> > > > handler itself and make this part of kgdb_panic() look more like:
> > > >
> > > >         kgdb_panic_msg = msg;
> > > >         kgdb_breakpoint();
> > > >         kgdb_panic_msg = NULL;
> > >
> > > Unfortunately I think that only solves half the problem. As a quick
> > > test, I tried simply commenting out the "kdb_printf" line in
> > > kgdb_panic(). While that avoids the interleaved panic message and
> > > backtrace, it does nothing to actually get the backtraces printed out
> > > before you end up in kdb. As an example, this is what happened when I
> > > used `echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT` and
> > > had the "kdb_printf" in kgdb_panic() commented out:
> > >
> > > [   72.658424] lkdtm: Performing direct entry HARDLOCKUP
> > > [   82.181857] watchdog: Watchdog detected hard LOCKUP on cpu 6
> > > ...
> > > [   82.234801] Sending NMI from CPU 5 to CPUs 6:
> > > [   82.239296] NMI backtrace for cpu 6
> > > ... [ stack trace for CPU 6 ] ...
> > > [   82.240294] NMI backtrace for cpu 5
> > > ... [ stack trace for CPU 5 ] ...
> > > [   82.576443] Sending NMI from CPU 5 to CPUs 0-4,7:
> > > [   82.581291] NMI backtrace
> > > Entering kdb (current=0xffffff80da5a1080, pid 6978) on processor 5 due
> > > to Keyboard Entry
> > > [5]kdb>
> > >
> > > As you can see, I don't see the traces for CPUs 0-4 and 7. Those do
> > > show up if I use the "dmesg" command but it's a bit of a hassle to run
> > > "dmesg" to look for any extra debug messages every time I drop in kdb.
> > >
> > > I guess perhaps that part isn't obvious from the commit message?
> >
> > I figured it was a risk.
> >
> > In fact it's an area where my instinct to honour console messages and my
> > instinct to get into the kernel as soon as possible after the decision
> > to invoke it has been made come into conflict.
> >
> > In other words does it matter that the console buffers are not flushed
> > before entering kgdb? However having thought about it for a little while
> > (and knowing the console code tends to be written to be decently robust)
> > I can come to the view the flushing is best.
>
> Just for record. I wondered if there was bug in printk() that the
> backtraces were not flushed. And I think that it is because they
> are printed in NMI context where the conosle handling is deferred.
>
> From this POV, the explicit flush makes perfect sense.

Agreed... and (with apologies for the length of time to get this
done):
Applied!


Thanks

Daniel.
