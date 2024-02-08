Return-Path: <linux-kernel+bounces-57833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AE384DDFA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BE5B29634
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DF6D1CD;
	Thu,  8 Feb 2024 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C76K69iN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D536BFC2;
	Thu,  8 Feb 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387518; cv=none; b=RExouByf9IVe7f3andPuMgQJBbTVFKQtoAUGMxW0MaAXq3MCeqGwEfMdnk1/I6CKFVKOsOoKvO9F+oKfzcYSwm+FIraBCqJUAIE3o+MWKM0vjM74uWhHiHbBRdUQFFlEK45rARwk4QpFGIdik46TiUtMxOUKJxnNkyhlQEGk/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387518; c=relaxed/simple;
	bh=uhvalGSkL3ej/pnChIRBm8dpvY069eIscLpqr/mfNjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJMnAbWFv+6h8QP/6uXjVKD4K4WvEouVBqTmdUjgPdSTttE4mPYJDGNo73vdhC2PYD5KE8cqbnCO9+004Yp27r2kDFIHBvK5Wj1hhXnr5gmREiQiQZUmJCAwHvysPvWlG+fm6o2uinOush8HbEidWq3uAE1KLBFh1FWJ3p/oD2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C76K69iN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88635C433F1;
	Thu,  8 Feb 2024 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707387518;
	bh=uhvalGSkL3ej/pnChIRBm8dpvY069eIscLpqr/mfNjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C76K69iNT1RPa3juo5uWTFrboEuHrqgEw71QgP8AG9z6A+XLj9N8CsuxN+ouMcMFl
	 emRZGF8bxvsvczRwYW7qd8intl0G2z9uYZgSi5Qgv85epKaWTQ6IBI3ERkVWXbXvrb
	 1drZVUAoJjI1k466fauUMSU0TM8IQaH8vtVHFVXc=
Date: Thu, 8 Feb 2024 10:18:35 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sreenath Vijayan <sreenath.vijayan@sony.com>, john.ogness@linutronix.de,
	corbet@lwn.net, jirislaby@kernel.org, rdunlap@infradead.org,
	rostedt@goodmis.org, senozhatsky@chromium.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
	daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v4 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
Message-ID: <2024020845-antiquely-faculty-407d@gregkh>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
 <ZcOdLrOPiPJmCec5@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOdLrOPiPJmCec5@alley>

On Wed, Feb 07, 2024 at 04:09:34PM +0100, Petr Mladek wrote:
> On Thu 2024-02-01 13:12:41, Sreenath Vijayan wrote:
> > When terminal is unresponsive, one cannot use dmesg to view printk
> > ring buffer messages. Also, syslog services may be disabled,
> > to check the messages after a reboot, especially on embedded systems.
> > In this scenario, dump the printk ring buffer messages via sysrq
> > by pressing sysrq+D.
> 
> I would use sysrq-R and say that it replays the kernel log on
> consoles.
> 
> The word "dump" is ambiguous. People might thing that it calls
> dmesg dumpers.
> 
> Also the messages would be shown on the terminal only when
> console_loglevel is set to show all messages. This is done
> in __handle_sysrq(). But it is not done in the workqueue
> context.
> 
> Finally, the commit message should explain why workqueues are used
> and what are the limitations. Something like:
> 
> <add>
> The log is replayed using workqueues. The reason is that it has to
> be done a safe way (in compare with panic context).
> 
> This also means that the sysrq won't have the desired effect
> when the system is in so bad state that workqueues do not
> make any progress.
> </add>
> 
> Another reason might be that we do not want to do it in
> an interrupt context. But this reason is questionable.
> Many other sysrq commands do a complicate work and
> print many messages as well.
> 
> Another reason is that the function need to use console_lock()
> which can't be called in IRQ context. Maybe, we should use
> console_trylock() instead.
> 
> The function would replay the messages only when console_trylock()
> succeeds. Users could repeat the sysrq when it fails.
> 
> Idea:
> 
> Using console_trylock() actually might be more reliable than
> workqueues. console_trylock() might fail repeatably when:
> 
>     + the console_lock() owner is stuck. But workqueues would fail
>       in this case as well.
> 
>     + there is a flood of messages. In this case, replaying
>       the log would not help much.
> 
> Another advantage is that the consoles would be flushed
> in sysrq context with the manipulated console_loglevel.

I just remembered all the rt-changes coming down the pipe for
consoles/printk, is this going to mess with that?

And in thinking about it, the workqueue is a worry, sysrq is only
usually hit if you have a lockup, and this isn't going to work well
here, if at all, in that situation.

So when this option fails when people need it the most, perhaps it's not
worth adding?  When else would people want to use it?

thanks,

greg k-h

