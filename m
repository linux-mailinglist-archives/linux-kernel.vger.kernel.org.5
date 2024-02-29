Return-Path: <linux-kernel+bounces-87655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A486D705
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742381C21496
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027D45035;
	Thu, 29 Feb 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btrkPg86"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804B16FF47
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247061; cv=none; b=Y/OMLTwWgeGb0r+7w6P4WvGzL15nbV251C3CMHKRugfPr8Fy8OLLkKZIr2jWlt6qh1cUdPvfWZ0j/QEKVDHiMGj2XHvzvpextkZsHAdusSiWouwScGaulUeSWJ5poetEf3tipi+No7iNr7DVSq6JEheGo0HHuzl9HDfSGhM2jck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247061; c=relaxed/simple;
	bh=9+Jyl74W/UG9ViSeIngcAQlFgZ6C2IO6ZA8HmHI0n1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTK1s/zL9qLjP6f+9ipnuH0cfm5e8GbxNFkbMN/Pqszgy93oz2C+6u+4K23OzLENy8vSMxjIaxxH4vtXm3uDmTnWFqDBS/97aIyv1vsrI3Pd4rZmEOAwFPkoVtHBLKjIp9PzeHl/ycNXGZk3QjDR9HtpVO04fHdafuXAMQVRMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btrkPg86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D9BC433C7;
	Thu, 29 Feb 2024 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709247061;
	bh=9+Jyl74W/UG9ViSeIngcAQlFgZ6C2IO6ZA8HmHI0n1g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=btrkPg86fofsCqm0DZY5N0GTVls/r9585BKlfMFUeiAaBB4Q1kH3Rl4rjeXfafb71
	 s+NqIbZGE14gk9qOx+mhhQmRzXarK/5K180UErElOPI+h+5jrc3Sx7HJ0oCDuSWgJM
	 mTM85Wq/D/fTAVCUYVdCeZnLfRE4V88K5a0kZHgNmjot0B0z+vvM9BiAcjHMBVc0u2
	 LRi1aq56sW5g9lJdNIES41x9d1igbraTkDodBQDWC7yOs+MGB9wlU3nafdEbGvjHKe
	 1Pm4C7QFyDHeaXhonI7SJiARu4GQgl/lULDutQE0B8BRDOOgc2UWuJPqDQNnSwy+AR
	 yPiDFUQLE7AIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A0150CE0B6C; Thu, 29 Feb 2024 14:51:00 -0800 (PST)
Date: Thu, 29 Feb 2024 14:51:00 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: READ_ONCE: was: Re: [PATCH printk v2 19/26] printk: Avoid
 console_lock dance if no legacy or boot consoles
Message-ID: <e6787ec7-5ac0-4ee4-a42b-41d3ae6cf8ef@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-20-john.ogness@linutronix.de>
 <ZeCueLN0avUV0Yhr@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeCueLN0avUV0Yhr@alley>

On Thu, Feb 29, 2024 at 05:19:04PM +0100, Petr Mladek wrote:
> Adding Paul into Cc.
> 
> On Sun 2024-02-18 20:03:19, John Ogness wrote:
> > Currently the console lock is used to attempt legacy-type
> > printing even if there are no legacy or boot consoles registered.
> > If no such consoles are registered, the console lock does not
> > need to be taken.
> > 
> > Add tracking of legacy console registration and use it with
> > boot console tracking to avoid unnecessary code paths, i.e.
> > do not use the console lock if there are no boot consoles
> > and no legacy consoles.
> > 
> > --- a/kernel/printk/internal.h
> > +++ b/kernel/printk/internal.h
> > @@ -44,6 +44,16 @@ enum printk_info_flags {
> >  };
> >  
> >  extern struct printk_ringbuffer *prb;
> > +extern bool have_legacy_console;
> > +extern bool have_boot_console;
> > +
> > +/*
> > + * Specifies if the console lock/unlock dance is needed for console
> > + * printing. If @have_boot_console is true, the nbcon consoles will
> > + * be printed serially along with the legacy consoles because nbcon
> > + * consoles cannot print simultaneously with boot consoles.
> > + */
> > +#define printing_via_unlock (have_legacy_console || have_boot_console)
> >  
> >  __printf(4, 0)
> >  int vprintk_store(int facility, int level,
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -463,6 +463,13 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
> >  /* syslog_lock protects syslog_* variables and write access to clear_seq. */
> >  static DEFINE_MUTEX(syslog_lock);
> >  
> > +/*
> > + * Specifies if a legacy console is registered. If legacy consoles are
> > + * present, it is necessary to perform the console_lock/console_unlock dance
> > + * whenever console flushing should occur.
> > + */
> > +bool have_legacy_console;
> > +
> >  /*
> >   * Specifies if a boot console is registered. If boot consoles are present,
> >   * nbcon consoles cannot print simultaneously and must be synchronized by
> > @@ -3790,22 +3807,28 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
> >  	seq = prb_next_reserve_seq(prb);
> >  
> >  	/* Flush the consoles so that records up to @seq are printed. */
> > -	console_lock();
> > -	console_unlock();
> > +	if (printing_via_unlock) {
> > +		console_lock();
> > +		console_unlock();
> > +	}
> >  
> >  	for (;;) {
> >  		unsigned long begin_jiffies;
> >  		unsigned long slept_jiffies;
> >  
> > +		locked = false;
> >  		diff = 0;
> >  
> > -		/*
> > -		 * Hold the console_lock to guarantee safe access to
> > -		 * console->seq. Releasing console_lock flushes more
> > -		 * records in case @seq is still not printed on all
> > -		 * usable consoles.
> > -		 */
> > -		console_lock();
> > +		if (printing_via_unlock) {
> > +			/*
> > +			 * Hold the console_lock to guarantee safe access to
> > +			 * console->seq. Releasing console_lock flushes more
> > +			 * records in case @seq is still not printed on all
> > +			 * usable consoles.
> > +			 */
> > +			console_lock();
> > +			locked = true;
> > +		}
> >  
> >  		cookie = console_srcu_read_lock();
> >  		for_each_console_srcu(c) {
> > @@ -3836,7 +3860,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
> >  		if (diff != last_diff && reset_on_progress)
> >  			remaining_jiffies = timeout_jiffies;
> >  
> > -		console_unlock();
> > +		if (locked)
> > +			console_unlock();
> 
> Is this actually safe?
> 
> What prevents the compiler from optimizing out the "locked" variable
> and reading "printing_via_unlock" once again here?
> 
> It is not exactly the same but it is similar to "invented loads"
> described at
> https://lwn.net/Articles/793253/#Invented%20Loads
> 
> The writes affecting printing_via_unlock are not synchronized
> by console_lock().

If there are no compiler barriers between those two regions of code,
that could happen.  Compiler barriers are of course barrier(), but also
almost all atomic and locking operations.

But without comments, any intervening compiler barriers might well be
removed in some future bug-fix effort.  Let's face it, that could happen
even with comments.

> Should we do the following?
> 
> /*
>  * Specifies if the console lock/unlock dance is needed for console
>  * printing. If @have_boot_console is true, the nbcon consoles will
>  * be printed serially along with the legacy consoles because nbcon
>  * consoles cannot print simultaneously with boot consoles.
>  *
>  * Prevent compiler speculations when checking the values.
>  */
> #define printing_via_unlock (READ_ONCE(have_legacy_console) ||     \
> 			     READ_ONCE(have_boot_console))
> 
> 
> or
> 
> 		if (printing_via_unlock) {
> 		[...]
> 			WRITE_ONCE(locked, true);
> 		}
> 
> Or am I too paranoid?

Not by my standards, not that this would be saying much.  ;-)

I prefer the approach adding the READ_ONCE(), especially if "locked"
happens to be a local variable.

							Thanx, Paul

