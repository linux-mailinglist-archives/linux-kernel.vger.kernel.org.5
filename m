Return-Path: <linux-kernel+bounces-25532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7A682D1FE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 20:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F861C209B7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 19:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183A211CA0;
	Sun, 14 Jan 2024 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="N01dN+PV"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A43F9D8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-247.bstnma.fios.verizon.net [173.48.115.247])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40EJh2ka006080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jan 2024 14:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1705261384; bh=a75MRiqS9CjUQICmsOz6vLm4VvbBzhVgndG6jX7qNGk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=N01dN+PVpl/brM0NjN29+9kPca7ppSxnfjf60nGIVY9NprZlJwjxjxKKMVC/nNp2+
	 B0rjauTe60PGS6437w0vG/rduGC6fSKZTnwckmKszNMq+KVTzJ4NCzHFnkz7DOgYeF
	 bN6wT8RRl+pMMlnGhXPiiHqn1MMSOPqBOpg0/aDm4889x+vEuGyXKVCjkN1Lf1SsYP
	 PFNxyT+dylCS77yrA1iJasIrTUW6/qYG7po3nnX9O+KAz2R6HcNUiMp199c4ClN++z
	 IbX7KGnnQwMllq7FfbHfeyfFefhCywSpBXJdLPFg5pWAHecZNgF9kuZkEm5LRyXgTn
	 WKLhstsa4HUtA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 170EB15C0278; Sun, 14 Jan 2024 14:43:02 -0500 (EST)
Date: Sun, 14 Jan 2024 14:43:02 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        baijiaju1990@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH] tty: fix atomicity violation in n_tty_read
Message-ID: <20240114194302.GC911245@mit.edu>
References: <20240112125801.2650-1-2045gemini@gmail.com>
 <2024011212-disbelief-respect-5230@gregkh>
 <CAOPYjvZYdPSiZ+jX4vhwPQ3AKRvW15XT1znAa8vd9a6DVoor5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPYjvZYdPSiZ+jX4vhwPQ3AKRvW15XT1znAa8vd9a6DVoor5w@mail.gmail.com>

On Sat, Jan 13, 2024 at 12:59:11AM +0800, Gui-Dong Han wrote:
> 
> I apologize for any confusion caused by my reference to Linux 5.17 in
> the patch description. I'm currently working on a project involving
> kernel static analysis to identify atomicity violations, and part of
> this work involves comparison with a previous study that supports up
> to Linux 5.17. Therefore, I initially ran my tool on 5.17 to filter
> potential bugs that are still unaddressed in the upstream. I want to
> clarify that the patch was developed and tested on linux-next. I
> realize now that this may have led to misunderstandings, and I will
> ensure clearer communication in future submissions.
> My experience with Linux kernel contributions is still growing, and I
> acknowledge that my recent submission might have been hasty and lacked
> thorough consideration, especially regarding the critical nature of
> n_tty_read and the potential impacts of the patch, like performance
> concerns. I will take more care in future assessments before
> submitting patches and continue to familiarize myself with the rules
> and practices of the Linux kernel community.

In general, static analysis tools need to be supplemented by an
attempt to understand what the code is trying to do.  This code is
related to the packet mode, which is related to pseudo-tty's --- *not*
the linux serial driver.

From the man page for tty_ioctl:

       TIOCPKT
              Argument: const int *argp

              Enable (when *argp is nonzero) or disable packet mode.
              Can be applied to the master side of a pseudoterminal
              only (and will return ENOTTY otherwise).  In packet
              mode, each subsequent read(2) will return a packet that
              either contains a single nonzero control byte, or has a
              single byte containing zero ('\0') followed by data
              written on the slave side of the pseudoterminal.  If the
              first byte is not TI‐ OCPKT_DATA (0), it is an OR of one
              or more of the following bits:

              TIOCPKT_FLUSHREAD    The read queue for the terminal is flushed.
              TIOCPKT_FLUSHWRITE   The write queue for the terminal is flushed.
              TIOCPKT_STOP         Output to the terminal is stopped.
              TIOCPKT_START        Output to the terminal is restarted.
              TIOCPKT_DOSTOP       The start and stop characters are ^S/^Q.

              TIOCPKT_NOSTOP       The start and stop characters are not ^S/^Q.

              While  packet  mode is in use, the presence of control status informa‐
              tion to be read from the master side may be detected  by  a  select(2)
              for exceptional conditions or a poll(2) for the POLLPRI event.

              This  mode  is used by rlogin(1) and rlogind(8) to implement a remote-
              echoed, locally ^S/^Q flow-controlled remote login.

The n_tty_read() function is called by the userspace program on the
master side of the pty pair.  This is not, strictly speaking a hot
path; it's not on the interrupt service path of the serial driver, for
example.  So it's unliklely that "fixing" this problem is going to
result an measurable performance impact.

It's also the case that not taking the spinlock before checking the
packet mode is not necessarily going to be disastrous.  Yes, it might
mean that when the user types ^S, sshd might not stop sending
characters to the client right away, and the status report about the
status of the pty gets delayed by a millisecond or two.

So it's actually *not* a big deal.  Now, if you want to make the
argument that it would be nice if these sorts of "false positives" are
suppressed so that it's easier to find real bugs, that's one thing.
But if you're looking at proof that your static checker is actually
fixing Real Bugs (tm), this is probably not the best example.

Cheers,

					- Ted

