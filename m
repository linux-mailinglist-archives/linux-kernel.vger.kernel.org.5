Return-Path: <linux-kernel+bounces-165692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6B58B8FD9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE76BB216D6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6A313956C;
	Wed,  1 May 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewOhrqTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8351607A3
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714589156; cv=none; b=co44sHcv3ZTqzUIkz8LqO7D9IrfLXTKDMLrFyjGw13Pzz8IKloA3iad0L8W9vIpMe8ufW9IEQ4+5X/zmQ/fiMxzX2gKueUhOVTeLVelgRW/TpzArRkCTHcARQFFJo7Ii6p94r6jPKbz7QeoVSYeCFzTQuoJ7LXjvz9DsbEd3yZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714589156; c=relaxed/simple;
	bh=czYdOvcdvRy9Re4Fp1KxwHOqIKvgSIBGT48df6nVEhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpeW1sTDGDSnG8a++lfev83UveTLR/xSuxA1kCpF2BnNGIIHfuyJBhJaQHDvYV84K70uQLLMYH0rbveYGZvi7k7ya4U5Qh+1zKXOU981ZFnGAEIMpxLc1KGz3oUyxDWA+Ekmbj/S/5s37wMNGvgETbKAPpsvKerETTtP+n6kM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewOhrqTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28765C072AA;
	Wed,  1 May 2024 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714589156;
	bh=czYdOvcdvRy9Re4Fp1KxwHOqIKvgSIBGT48df6nVEhk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ewOhrqTf4yrqRuloONJ49CBDLrob8MstHsbUadY4p0X3nlblYUtLAW6Px/peMHccy
	 dYGLwsGbZEQSD/hN5pkt7JKTFqIl9aCnY7/VwJd8EWhcAFzI0gggPvNaSAHjI+kwjg
	 tndIx3I41DOv2A3zqsKldBW8HgfHVpJYEICEXOWLfBv2rJhkNnGGvoT/UWjH/72LKL
	 kp8jApHx5EX8eSqEJVJFPvRZqap+g99BR5plyJ9wV6/IW4uUgHslHohWA28N4g5v7V
	 tJ5eHu0oGbSojchjASmVTXsZJFXEkvMt7CozFFB9sXcDynxciic9QYQORq015ZToT2
	 9gXu1Nlla2svQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B9D9ECE0C37; Wed,  1 May 2024 11:45:55 -0700 (PDT)
Date: Wed, 1 May 2024 11:45:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marco Elver <elver@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
Message-ID: <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
 <2023053005-alongside-unvisited-d9af@gregkh>
 <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh>
 <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>

On Mon, Apr 29, 2024 at 08:38:28AM -0700, Linus Torvalds wrote:
> On Mon, 29 Apr 2024 at 06:56, Marco Elver <elver@google.com> wrote:
> >
> > A WRITE_ONCE() / READ_ONCE() pair would do it here. What should we use instead?
> 
> Why would we annotate a "any other code generation is insane" issues at all?
> 
> When we do chained pointer loads in
> 
>     file->f_op->op()
> 
> and we say "I don't care what value I get for the middle one", I don't
> see the value in annotating that at all.

In code that isn't being actively developed, sticks to known patterns (as
above), or hides the lockless accesses behind a good API, this can make
a lot of sense.  And I certainly have talked to a few people who feel
that KCSAN is nothing but an irritant, and are not willing to make any
concessions whatsoever to it.  In fact, many of them seem to wish that
it would disappear completely.  Of course, that wish is their privilege.

But in RCU, new patterns are often being created, and so I am quite
happy to give KCSAN additional information in order to help it help me.
I am also quite happy to run KCSAN with its most aggressive settings,
also to help it help me.  In my experience, it is way easier having KCSAN
spot a data-race bug than to have to find it the hard way, but perhaps I
am just showing my age.  In addition, KCSAN does a tireless and thorough
(if somewhat simple-minded) code review of the full RCU code base,
and can easily be persuaded to do so each and every day, if desired.
Just *you* try doing that manually, whatever your age!  ;-)

Plus, the documentation benefits are significant.  "Wait, which of
these unmarked accesses is to a shared variable?"  In the wee hours of
the morning while chasing a bug.  Especially if the person doing the
chasing is an innocent bystander who is not already an expert on the
code currently being investigated.  :-/

Oddly enough, the simplest concurrency designs also want a maximally
aggressive KCSAN.  If you are using pure locking with absolutely no
lockless accesses, then any data race at all is a bug.  Again, it is
a lot easier for KCSAN to tell you that you forgot to acquire the lock
than to find out the hard way.

> There is no compiler that will sanely and validly do a pointer chain
> load by *anything* but a load. And it doesn't matter to us if it then
> spills and reloads, it will *STILL* be a load.
> 
> We're not talking about "extract different bits in separate
> operations". We're talking about following one pointer that can point
> to two separate static values.
> 
> Reality matters. A *lot* more than some "C standard" that we already
> have ignored for decades because it's not strong enough.

Agreed, but it also appears that different developers and maintainers in
different parts of the kernel are looking for different things from KCSAN.

To illustrate my personal concerns, I confess to being a bit disgusted by
those pontificating on software reliability, especially when they compare
it unfavorably to things like house construction.  The difference is of
course that the average house is not under active attack by nation states.
In contrast, whether we like it or not, the Linux kernel is under active
attack by nation states, organized crime, and who knows what all else.
For RCU at least, I will take all the help I can get, even if it requires
me to do a little bit of work up front.

In short, I for one do greatly value KCSAN's help.  Along with that of
a great many other tools, none of which are perfect, but all of which
are helpful.

							Thanx, Paul

