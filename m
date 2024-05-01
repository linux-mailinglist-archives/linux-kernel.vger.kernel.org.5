Return-Path: <linux-kernel+bounces-165776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C76F8B9129
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47C01F246E5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F6165FC1;
	Wed,  1 May 2024 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGVtthAq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D14D5BF
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714600158; cv=none; b=YybcINNrZKcHepGtoFEB2785VAfD5CFpWqyPR35Bkv93HmbNeZ1q8OgYzLkxUIaCcdrE1Lj/KgdD1myE9lcm/dMt/01aN6WyUAh5FyNvNi6qGg+ADsukrV+CKBj7W5CAMuVvTHcoLVcfuCIyqquI0oxtDlQ7/FPsjywOsC2hZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714600158; c=relaxed/simple;
	bh=T0e6v2EEGGmGQq2DG+fHGV5WDwv7F/hfovJ40/z0/Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnamLwdRbsx+W/aoQ8ZkIwZrhv+1bMxYezl7Afunue3/tPi5/tBoIcIohh6NVBqYk6PIhWfVr/5g9n/XL3IH7GNQNhug+Ps/aUHbycbxbCmewjwIFndMxpIj6NIVtpeZafKvOzUFpVT8P4BIPpZVxb2Uz2Br14wH70r0Yu6VXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGVtthAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9A4C072AA;
	Wed,  1 May 2024 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714600158;
	bh=T0e6v2EEGGmGQq2DG+fHGV5WDwv7F/hfovJ40/z0/Zg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dGVtthAq1OTTQR3QC38kzQA9ogfbxze0/eX5Qgu7ICvOK3Um1LgWVVzlDv0X9yq0C
	 kqFIjgAAVsZRtReZru9aGxaHjNMaMbNbPsKxd+jDS1A508lLEIdEBizVr7Y9rpGRtm
	 0jCAeNR0Q+vGYosDS9q4wR8jWiY7LLX7pW1Q+iDakGzFiVuAuG7Tut2DYUZZQ+/om9
	 CLSu0TP/aKe+EztSB3CAVNiTikzM4nH7kwvt+Wx8idbNkYXRUm+Rjazg04RomKECTR
	 HDOlxfSb8DFKdVSovFdqtngYxbiihbK3cNy7yiiEnFESFiOhlNFN5Ttd7XccZU4vd1
	 xPeyXh7wZnDow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 926D2CE1073; Wed,  1 May 2024 14:49:17 -0700 (PDT)
Date: Wed, 1 May 2024 14:49:17 -0700
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
Message-ID: <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop>
 <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop>
 <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>

On Wed, May 01, 2024 at 02:20:35PM -0700, Linus Torvalds wrote:
> On Wed, 1 May 2024 at 14:06, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So it would be something like
> >
> >         const struct file_operations    * __data_racy f_op;
> >
> > and only the load of f_op would be volatile - not the pointer itself.
> 
> Noe that in reality, we'd actually prefer the compiler to treat that
> "__data_racy" as volatile in the sense of "don't reload this value",
> but at the same time be the opposite of volatile in the sense that
> using one read multiple times is actually a good idea.
> 
> IOW, the problem is rematerialization ("read the value more than once
> when there is just one access in the source"), not strictly a "read
> the value separately each time it is accessed".
> 
> We've actually had that before: it's not that we want each access to
> force a read from memory, we want to avoid a TOCTOU race.
> 
> Many of our "READ_ONCE()" uses are of that kind, and using "volatile"
> sadly generates horrible code, but is the only way to tell the
> compiler to not ever rematerialize the value by loading it _twice_.
> 
> I'd love to see an extension where "const volatile" basically means
> exactly that: the volatile tells the compiler that it can't
> rematerialize by doing the load multiple times, but the "const" would
> say that if the compiler sees two or more accesses, it can still CSE
> them.

No promises, other than that if we don't ask, they won't say "yes".

Let me see what can be done.

							Thanx, Paul

> Oh well. Thankfully it's not a hugely common code generation problem.
> It comes up every once in a while, and I think the last time this
> worry came up, I think we had gcc people tell us that they don't
> actually ever rematerialize loads from memory.
> 
> Of course, that was an implementation issue, not a guarantee.
> 
>                            Linus

