Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E687975A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbjIGPw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244551AbjIGPuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:50:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE1E5FE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:41:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5183A1F86B;
        Thu,  7 Sep 2023 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694101221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DihkP7FohQ1cEQLUmSH1+hOZhJb90COamatjtNcS8wM=;
        b=ksstOA+S+LLKWLi+irBlE6jIzjihBrirgKsPV9G95bWYQo+MK1pTTyhge9RGr86Gvnfi5F
        mEzNLuuCZZ7ErB4AvJ8/A/gYrQwxwS7fKUQq1Z+Yn16jDgjFtZanfa9Zdi+tovnWEoVlo2
        KlwnSeXKVELx7NOjjl8YRqKnOv2ANfA=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EC8BB2C143;
        Thu,  7 Sep 2023 15:40:20 +0000 (UTC)
Date:   Thu, 7 Sep 2023 17:40:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: hostile takeover: Re: [PATCH printk v2 3/8] printk: nbcon: Add
 acquire/release logic
Message-ID: <ZPnu5P3b74K1mYTu@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-4-john.ogness@linutronix.de>
 <ZNOKSFAGPxYFeeJT@alley>
 <87o7iqrvvx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7iqrvvx.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-08-29 12:28:10, John Ogness wrote:
> On 2023-08-09, Petr Mladek <pmladek@suse.com> wrote:
> >> Add per console acquire/release functionality. The console 'locked'
> >> state is a combination of multiple state fields:
> >> 
> >>   - Hostile takeover
> >> 
> >>       The new owner takes the console over without 'req_prio'
> >>       handshake.
> >> 
> >>       This is required when friendly handovers are not possible,
> >>       i.e. the higher priority context interrupted the owning
> >>       context on the same CPU or the owning context is not able
> >>       to make progress on a remote CPU.
> >
> > I always expected that there would be only one hostile takeover.
> > It would allow to take the lock a harsh way when the friendly
> > way fails.
> 
> You are referring to the hostile takeover when unsafe. A hostile
> takeover when safe is still considered a hostile takeover. (At least,
> until now that is how it was considered. More below...)

Yes.

Note: I did not distinguish much the "takeover" and "handover"
      words when thinking about the logic. They sound almost
      the same to me. I think that I have some partial dyslexia[*]
      or so.

      Also I had the words "hostile" and "harsh" connected with
      the "takeover when unsafe".

      As a result, I made a simplified mental model where
      "handover" and "takeover when safe" were equivalent.

      I am sorry if it caused some confusion. I see
      the difference now.


[*] This might be the reason why I am so sensitive on naming.

> >> All other policy decisions have to be made at the call sites:
> >> 
> >>   - What is marked as an unsafe section.
> >>   - Whether to spinwait if there is already an owner.
> >>   - Whether to attempt a hostile takeover when safe.
> >>   - Whether to attempt a hostile takeover when unsafe.
> >
> > But there seems to be actually two variants. How they are
> > supposed to be used, please?
> >
> > I would expect that a higher priority context would always
> > be able to takeover the lock when it is in a safe context.
> >
> > By other words, "hostile takeover when safe" would be
> > the standard behavior for context with a higher priority.
> 
> The difference is that with "hostile takeover when safe" there is a
> foreign CPU that still thinks it has the lock, even though it does not.

Strictly speaking, the foreign CPU should not expect that it owns
the lock when it is in a safe region. The "safe" means that
the hostile takeover is safe. And the new owner could use
the console without any risk.

My understanding was:

   + The lock allows to emit one record atomically.

   + The "safe region under the lock" marks code when the console
     is in a consistent state and any synchronized resources
     are not accessed.

   + Only a higher priority context might take over the lock
     in the "safe region". Then it might use the console device
     a safe way. And it is supposed to re-emit the interrupted
     record.


I think that the catch is in the "synchronized resources".
It is not only the console device but also the printk buffer.

I though that we needed the extra printk buffer in panic only
because of the harsh takeover when unsafe when the message is being
read and formatted.

And I though that the console drivers would handle characters
one by one. Then it might be safe to read one character
even in "safe" state.

Hmm, I am actually not sure if nbcon_emit_next_record()
calls printk_get_next_message() and con->write_atomic(con, wctxt)
in "safe" or "unsafe" context.

I mean, I am not sure if the access to the printk buffer
is synchronized by the console lock or not. It would be nice
to document it and maybe add some assert_context_is_safe()/unsafe().

> > By other words, the difference between normal takeover and
> > "hostile takeover when safe" is that the 1st one has to
> > wait until the current owner calls nbcon_enter_unsafe().
> > But the result is the same. The current owner might
> > prematurely end after calling nbcon_enter_unsafe().

OK, there is one difference:

  + The "handover" passes the lock on well defined locations.

  + The "takeover when safe" can happen anywhere in the "safe"
    region.

And the "takeover when safe" is currently allowed only in
console_flush_on_panic(). It means that the lock is
passed to a higher priority context on well defined
locations most of the time. Which is a more conservative approach.

> > Maybe, this another relic from the initial more generic approach?
> 
> I suppose so. But then why not try the "hostile takeover when safe"
> first and only use the handover request as a fallback? Like this:
> 
> 1. try direct
> 2. try hostile takeover when safe
> 3. try handover
> 4. try hostile takeover when unsafe
> 
> Then we should remove the "hostile" label for #2 and just call it:
> 
> 1. try direct
> 2. try safe takeover
> 3. try handover
> 4. try hostile takeover

I rather meant:

  1. try direct
  2. try handover +
     try safe takeover in every waiting cycle
  3. try hostile takeover

But then it won't be a handover anymore.

Anyway, I would keep it as is for now. As mentioned above,
the current handover is more conservative approach because
the lock is passed on well defined locations.


> (I guess this is how you imagined things should be.)
> 
> >> +/**
> >> + * struct nbcon_context - Context for console acquire/release
> >> + * @console:		The associated console
> >> + * @spinwait_max_us:	Limit for spinwait acquire
> >> + * @prio:		Priority of the context
> >> + * @unsafe:		This context is in an unsafe section
> >
> > This seems to be an input value for try_acquire(). It is
> > controversial.
> >
> > I guess that it removes the need to call nbcon_enter_unsafe()
> > right after try_acquire_console().
> 
> Yes. It removes the "safe window" between try_acquire_console() and
> nbcon_enter_unsafe() by allowing to acquire and mark unsafe
> atomically. For example, this would be useful for the port_lock()
> wrapper we discussed. But it is not strictly necessary. I can remove it.
> 
> Below I answer your comments anyway.
> 
> > Hmm, this semantic is problematic:
> >
> >   1. The result would be non-paired enter_unsafe()/exit_unsafe()
> >      calls.
> 
> The paired calls are either:
> 
> try_acquire(unsafe=1) -> release()

We should not create such an API. It would be confusing. And it would
create strange code.

People, should be allowed enter/exit unsafe inside the lock.
If the lock sets unsafe by default then the code would
look like:

   try_acquire(unsafe=1)

     #do something synchronized

     exit_unsafe()
     # do something innocent
     enter_unsafe()

     #do something synchronized again

   release()

In this case, it would make more sense to implement the
opposite enter_safe() and exit_safe().

But this would be ugly. It would create the felling that
the code in this section might do anything because it is
safe. But it is actually the other way around.
The code in the "safe" section must be very careful because
it must be safe for takeover.

> or
> 
> try_acquire(unsafe=0) + enter_unsafe() -> exit_unsafe() + release()

I am not sure what is the difference between "+" and "->"

Anyway, IMHO, try_acquire() should always return with unsafe=0
(except for unsafe_takeover).

It would allow use enter_unsafe()/exit_unsafe() around
the sensitive code. They both will be in the same function
and "enter" will be before "exit".

BTW: The name enter_unsafe() somehow looks more acceptable than
     the reverted enter_safe(). It makes the feeling that we
     do something unsafe in this section which is actually true.

     I though about a better name then "unsafe" but I did
     not found any.


Best Regards,
Petr
