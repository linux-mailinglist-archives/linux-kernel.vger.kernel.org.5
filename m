Return-Path: <linux-kernel+bounces-25594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD382D320
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE03B1F21380
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0511872;
	Mon, 15 Jan 2024 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KwML1vnH"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82517D5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-247.bstnma.fios.verizon.net [173.48.115.247])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40F2ZUVk013181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jan 2024 21:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1705286131; bh=nGSs9A/OQKM+DwGbB0yCNA2AmKHoEfpifzwjfANTesw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KwML1vnH98QwAtIBCuBWczuUMSCBMqWPyrxoZ0brxi6PovfnOox6oN/4af8UDV7wr
	 d/iOuICFqrkN3RRRTPTCuSH79ObTKucNZ6GzipJ5m5LTMMpKvEN6VAsNEMoAJ15juK
	 DKCx+qA0E1gHohchbgyJf8IV6+Bc6Vn90VaFmUCZVbFDspDnFzr4aaCR381IqUIsRF
	 IN15bMntxPJl39tSwFvyjkak7w0+tDi7gnYcWmmE8YKfBfj3K7Mvcj1+01DuoQraKP
	 LUAg/ut71H6P9yPCsrRHlevVWQl4y/TpvNVYmsB95YEJZV6bVTN/fzNb17w+0mQNyi
	 ojh1im5wCLqkQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 531A315C0278; Sun, 14 Jan 2024 21:35:30 -0500 (EST)
Date: Sun, 14 Jan 2024 21:35:30 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Dr. Henning Kopp" <hkopp22@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why does Linux not implement pthread_suspend() and
 pthread_resume()?
Message-ID: <20240115023530.GE911245@mit.edu>
References: <0219492d-3971-f8e0-8b46-22d442a2d442.ref@yahoo.de>
 <0219492d-3971-f8e0-8b46-22d442a2d442@yahoo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0219492d-3971-f8e0-8b46-22d442a2d442@yahoo.de>

On Sun, Jan 14, 2024 at 12:20:04PM +0100, Dr. Henning Kopp wrote:
> 
> I found one answer on stackoverflow [1] that mentions that pthread_suspend
> and pthread_resume_np is in the "Unix specification"

This is not correct.  It is *not* part of the Single Unix
Specification.  The listing what is in the SUS can be found here:

https://pubs.opengroup.org/onlinepubs/7908799/xsh/threads.html

HPUX seems to have implemented pthread_suspend, but it is not a formal
part of the Posix or Single Unix Specification's definition of Posix
Threads.

> I read "man 7 pthreads". It mentions that there are two Linux
> implementations of Posix threads, that differ in some details from the Posix
> spec. However, it does not mention suspending or resuming threads at all.

It states that LinuxThreads was shipped as part of glibc until 2.4.
Since 2.4, NPTL is the implementation that has been shipped.  Note
that glibc 2.4 was shipped in 2006.  This is just that man page is
quite old, and there is some information which is mostly ancient
history that hasn't been removed yet.  There is also comments about
various aspects of NPTL that weren't fully POSIX compliant until
various 2.6.x kernels --- well the Linux 3.0 kernel was released in
2011, so again, there's just a lot of stuff there which can be safely
ignored as no longer relevant.

> So my question is: What is the reason that Linux does not implement
> functions for suspending and resuming threads?

Quoting from the Linux Threads FAQ:

   E.4: How can I suspend and resume a thread from another thread?
   Solaris has the thr_suspend() and thr_resume() functions to do
   that; why don't you?
   
   The POSIX standard provides no mechanism by which a thread A can
   suspend the execution of another thread B, without cooperation from
   B. The only way to implement a suspend/restart mechanism is to have
   B check periodically some global variable for a suspend request and
   then suspend itself on a condition variable, which another thread
   can signal later to restart B.
   
   Notice that thr_suspend() is inherently dangerous and prone to race
   conditions. For one thing, there is no control on where the target
   thread stops: it can very well be stopped in the middle of a
   critical section, while holding mutexes. Also, there is no
   guarantee on when the target thread will actually stop. For these
   reasons, you'd be much better off using mutexes and conditions
   instead. The only situations that really require the ability to
   suspend a thread are debuggers and some kind of garbage collectors.

   https://www.enseignement.polytechnique.fr/profs/informatique/Leo.Liberti/public/computing/parallel/threads/linuxthreads/linuxthreads-FAQ.html#E

Yes, LinuxThreads has been obsolete since 2006.  But the rationale
that (a) suspending threads is dangerous, and handing a footgun to
application writesr might not be wise, and (b) therefore Posix
specification does not include the capability to suspend a thread, is
still true.

There is a non-standard way that you can suspend an individual thread
--- you need to get the Linux tid (note: *not* the pthread id; that's
different) and then you can send a SIGSTOP signal to the Linux thread
which will cause the kernel to suspend the thread, and you can send it
a SIGCONT thread that will cause the kernel to resume the thread.
This is not something that can be intercepted by the application, and
so there's nothing the Posix Thread library can do to make things
better for the application.  If the application happens to be in a
critical section, holding some mutex when it no longer is allowed to
run, it might cause your program to wedge until it the SIGCONT signal
is send to the thread, and this might not be what you want.

Cheers,

					- Ted

