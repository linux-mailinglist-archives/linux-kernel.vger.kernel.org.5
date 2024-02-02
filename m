Return-Path: <linux-kernel+bounces-50246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9ED847642
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4141F27A48
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E2D14C596;
	Fri,  2 Feb 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpMKqthZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2814C590;
	Fri,  2 Feb 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895360; cv=none; b=MdjfSDbVRqXY0AuL8TckjgIY+IjGyabvOTgjNWb05PSEsAOH/EexZN4vhanY/+UQ5nKGKFhBVcwzJHXhzb2rcSvbVgpRJY63JfCQv9AfW/kQ+UTOD8A+siaZ4qu+y5G+oRdRY9S3ZdhgpzHGmN20IRdZTUE+qEQYECa3gKrz6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895360; c=relaxed/simple;
	bh=UYyH8TykNOaf9eOepP88xxy1k+wbxKRjO1XaaKsDlu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/lJ+Vg1lntNWVwBNRRyIXSmSvtF17GcCVaSg5cFkfSsoKXskessK4MxQxyH55QIcfDibrtMFWj7qxexe2C8SQLC4fUTHYGPbRezMVyjXwE55Nsyc0UpDPN4Y1Hx222CB5O+UuOpkr2nY0MAZ+ChgsfhCtiY0hg/2MEmEdfAuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpMKqthZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5E9C43390;
	Fri,  2 Feb 2024 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706895360;
	bh=UYyH8TykNOaf9eOepP88xxy1k+wbxKRjO1XaaKsDlu4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rpMKqthZp0ja71+tULbyWb3/Fp6LyDNeEBn2lwOeVfzAzfeFhmqKp004qfJSoklEK
	 UeXLHMIDa4xYdIvJODlvLMXpBcVSsQsqgNHPRq9mrlynVJGf2aluagBA/HR1c4hna0
	 3Uqf9NPav27xB5syWiDfsNHwvcyb4a0+4mDmSTIBiZ8nbIzTbc8WAOgE9rb3WMANRE
	 WHPFrVgOgMbHA84qx+Z819PWwwQuFcnbHP81wXhodK4qfdldzabcxgsVNga6b7rHxN
	 nRD3Hm/Aw7TDIkblsnbx8Ax6pM1Q0rkNbmbHz6uszKpiovoxbVsac0gcujdXF5xpLP
	 U1V9ChB/ClDHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D1B0ACE2250; Fri,  2 Feb 2024 09:35:59 -0800 (PST)
Date: Fri, 2 Feb 2024 09:35:59 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <4a0b8cfc-f15e-4201-9e1c-d8479611488d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <87le83ara7.fsf@jogness.linutronix.de>
 <7b5a386e-2dcf-49f1-a8e9-c46d2a9f8800@paulmck-laptop>
 <87zfwibxzy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfwibxzy.fsf@jogness.linutronix.de>

On Fri, Feb 02, 2024 at 06:08:25PM +0106, John Ogness wrote:
> On 2024-02-02, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> The printk ringbuffer contents would certainly be interesting.
> >> 
> >> If you build the GDB scripts (CONFIG_GDB_SCRIPTS) then you will have:
> >> 
> >> (gdb) lx-dmesg
> >
> > This says no such command even though I do have CONFIG_GDB_SCRIPTS=y
> > in my .config.
> 
> You actually need to build them as well. The target is "scripts_gdb"
> 
> And you probably need to add:
> 
> add-auto-load-safe-path /path/to/your/kernel/build/directory
> 
> to your .gdbinit
> 
> (This is documented in Documentation/dev-tools/gdb-kernel-debugging.rst)

Thank you!  Next time I am in a similar situation, I will pay more
attention to the documentation.

> >> As an alternative, you could copy the contents of
> >> Documentation/admin-guide/kdump/gdbmacros.txt into your .gdbinit and
> >> then will have:
> >> 
> >> (gdb) dmesg
> >
> > This one hangs.
> 
> :-/ I will look into this.
> 
> > On the other hand, next-20240202 doesn't show the problem.  No idea
> > what might have changed.  :-/
> 
> Did you check the backtrace on all the "threads"? I would expect one of
> them has tty in it and is probably deadlocked. There are known problems
> that if a WARN or lockdep triggers while holding the port lock, that CPU
> will deadlock itself. That has the effect that no output is generated,
> but all the other CPUs will run fine. And even printk() calls will
> happily store into the ringbuffer because they use trylock for printing
> and the deadlocked CPU will be holding the lock.

Again, thank you, and another thing for me to try should this start
happening again.

							Thanx, Paul

