Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0060876B1F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjHAKf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjHAKfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:35:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C4A1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:35:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4E8DC21D46;
        Tue,  1 Aug 2023 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690886119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s4jvNMMJaVfHsPcDt/hM+4NwJdt2P+i12kiw0ruP2v4=;
        b=lqMsP6qcoi+MClM/EXd75xo9W/pwEYyrnhDcAtG+0zWuU+DLTTP0pEjpB2T0IArJSqwv4o
        SWOba9h128USY1hknRqCxuwSlnpKp/fzW2Ue3xKJP20vpYWEZsV8DqR56h7rHveAYL6kA5
        OZGyI/BxNqiZa1R/Ql2zt04Hbm346ss=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D3BE52C143;
        Tue,  1 Aug 2023 10:35:18 +0000 (UTC)
Date:   Tue, 1 Aug 2023 12:35:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/8] printk: Add non-BKL (nbcon) console basic
 infrastructure
Message-ID: <ZMjf4vz9RqTvOzr8@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-2-john.ogness@linutronix.de>
 <ZMPU8YPHzJ8Q2V9W@alley>
 <87o7jv92tt.fsf@jogness.linutronix.de>
 <ZMfVyOKbYZKG9nUJ@alley>
 <87cz07ak9n.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz07ak9n.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-31 22:45:00, John Ogness wrote:
> On 2023-07-31, Petr Mladek <pmladek@suse.com> wrote:
> >>> #define have_serialized_console (have_legacy_console || have_boot_console)
> >> 
> >> This macro is not about having a serialized console. The first
> >> sentence in the comment describes it best. It is just to signal if we
> >> need to do the console lock/unlock dance to generate console output.
> >> 
> >> Something like "need_bkl_dance" would be a better name, but it
> >> doesn't sound very technical.
> >
> > I see.
> >
> > Question: Will console_lock() serialize the early-boot handling
> > 	of non-BKL conosles? I mean the direct flush in vprintk_emit().
> 
> Initially there will be no nbcon consoles that support CON_BOOT. This
> means that there are no nbcon consoles in "early boot". The only reason
> that nbcon consoles and legacy boot consoles would co-exist (aside from
> the brief moment before boot consoles are unregistered) is if
> keep_bootcon is used.
> 
> As long as a boot console is registered, nbcon consoles are also bound
> to console_lock() serialization. We have no choice until we can safely
> link boot consoles to regular consoles.
> 
> I think this will be ok for the first release. The 8250 will not become
> less reliable in early boot. And once the boot console is unregistered,
> the 8250 nbcon console will be able to fly.

Makes sense. Thanks a lot for explanation.

> > At lest, the v1 patch set called cons_atomic_flush() in vprintk_emit()
> > without taking outside console_lock().
> 
> Yes. But in the v1 patch set, console_is_usable() returns false for
> nbcon consoles if there is a boot console registered. So the
> cons_atomic_flush() in vprintk_emit() would not end up printing
> anything.
> 
> As per your v1 feedback, that check will no longer be in
> console_is_usable(), but instead will be further out in higher level
> code.

I see.

> We have 3 scenarios that I would like to easily identify using global
> variable(s).
> 
> 1. There are only nbcon consoles. The console lock never needs to be
> taken.
> 
> 2. There are nbcon consoles and regular legacy consoles. The console
> lock must be taken to serialize only the regular legacy consoles. There
> are separate code paths (without the console lock) that will take care
> of nbcon atomic printing and nbcon threaded printing.
> 
> 3. There are nbcon consoles and boot consoles. The console lock must be
> taken to serialize all consoles.
> 
> Perhaps rather than using 2 booleans and a macro, we just use a single
> atomic_t that describes the console serialization mode? The effect is
> the same, but maybe it makes the intention of the code a bit easier to
> understand?
> 
> SERMOD_BOOTCON      = 0,
> SERMOD_WITH_LEGACY  = 1,
> SERMOD_ONLY_NBCON   = 2,

IMHO, this is not ideal. Most locations would need to do the console
lock/unlock dance in both '0' and '1' mode. It can be solved by
"sermode <= SERMOD_WITH_LEGACY" but then it would not be clear
what are the modes below '1'.

> Or maybe describe the modes based on their behavior rather than their
> condition:
> 
> SERMOD_ONLY_CONSOLE_LOCK  = 0,
> SERMOD_ALSO_CONSOLE_LOCK  = 1,
> SERMOD_NO_CONSOLE_LOCK    = 2,

The might be more practical. But I think that the original variables
were better after all. Well, what about renaming the macro

  #define need_legacy_console_flush (have_legacy_console || have_boot_console)

or

  #define need_console_lock (have_legacy_console || have_boot_console)

I personally prefer "need_legacy_console_flush". Well, I am not sure
if it would fit all use cases.

> >>>    + Update console_flush_all() description. Mention that it flushes
> >>>      only serialized consoles
> >> 
> >> Agreed. It is only responsible for bkl dance flushing.
> >
> > Will it flush only legacy consoles? Or will it flush also non-BKL
> > consoles during the early boot?
> 
> It will also flush nbcon consoles if a boot console is registered.
> 
> > I think that it is wrong even after adding the nbcon check. The code
> > looks like this at the end of this patchset:
> >
> > 			/*
> > 			 * If consoles are not usable, it cannot be expected
> > 			 * that they make forward progress, so only increment
> > 			 * @diff for usable consoles.
> > 			 */
> > 			if (!console_is_usable(c))
> > 				continue;
> >
> > 			if (flags & CON_NBCON)
> > 				printk_seq = nbcon_seq_read(c);
> > 			else if (locked)
> > 				printk_seq = c->seq;
> > 			else
> > 				continue;
> >
> > I guess that the "else-continue" path will never happen. But when
> > it happens then pr_flush() would ignore a usable console and it looks
> > wrong.
> 
> My reason for keeping the "if locked" was to remind the developer that
> the console lock must be held in order to safely read @console->seq.

I see.

> But you are right that it makes things look awkward. I will just change the
> code to:
> 
> 			if (flags & CON_NBCON)
> 				printk_seq = nbcon_seq_read(c);
> 			else
> 				printk_seq = c->seq;
> 
> There is already a comment at the console_lock() explaining why it is
> taken. That is enough.

This looks better to me.

Best Regards,
Petr
