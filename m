Return-Path: <linux-kernel+bounces-165790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE158B91A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CA91F22527
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B094E1DA;
	Wed,  1 May 2024 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hg48AugI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C051E481
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714602755; cv=none; b=CgnZ/Y71HvDXNYR9plIh7UKldPNBLoTEBPyhM3t3ycIuFa1dDwxKSEWWgGRUMwNrshSHhEqx/8EP9BHZbfAqzn3YBdQd/XHG6Hp+tt/L8WgRedkSqWOxESqDHg4XP+yXo83lTV8t+UJAZhUY++LlW71OfwO7Op5alTkVdTFw1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714602755; c=relaxed/simple;
	bh=2eREyX5dnodlvhycApy74OcpOFee785YKRKbVEzpQ+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2+/y1CRVUOehGplReVWK7jkSsbEDW7x8ajDfKxUv08cjTehWtjXxA0rv8cIiMFbnUCxLOVh9MyjWXYlVI2jA8xEZouvWju5S2Kg4wdSGRYb/XDwelAL6piGTUilyPhRZ85Gijh8tA0YRBuVCl+nofjOfkBy865H+TfMMK0O/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hg48AugI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48BFC072AA;
	Wed,  1 May 2024 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714602755;
	bh=2eREyX5dnodlvhycApy74OcpOFee785YKRKbVEzpQ+8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hg48AugIuJ/JXYNVkTjIohdJPJSvTOYk+E12XqAeWbCdmUW7ZE0Y9HT9EI+jX+Wit
	 voC0zz+THoKfHfj39mbNjEgCTEdn1OxMcRRLgpV0aXzgN85YIX1OEBQC5EhEwicJ1O
	 0QZzTPaR7s9QOdD5/0DrCjnDfccSHkbBpr8sBjM2ppmobDNyzvX6+QKBbwPky2eMU4
	 fbfI5wb5u5+Un0QuuEnXoOW8K2PcWaXTYKk88qnXHwgCIkHzaSr2o7D+gfkp3ubRsq
	 NmWHXBT8AKo0EClW4vrGQMfMZW22QsXjRR5GB8al0u48NKkc/pouAAwnDaaNn1G3Ne
	 r4ulvKU5lNe+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8F484CE1073; Wed,  1 May 2024 15:32:34 -0700 (PDT)
Date: Wed, 1 May 2024 15:32:34 -0700
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
Message-ID: <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop>
 <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop>
 <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
 <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop>

On Wed, May 01, 2024 at 02:49:17PM -0700, Paul E. McKenney wrote:
> On Wed, May 01, 2024 at 02:20:35PM -0700, Linus Torvalds wrote:
> > On Wed, 1 May 2024 at 14:06, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:

[ . . . ]

> > I'd love to see an extension where "const volatile" basically means
> > exactly that: the volatile tells the compiler that it can't
> > rematerialize by doing the load multiple times, but the "const" would
> > say that if the compiler sees two or more accesses, it can still CSE
> > them.

Except that "const volatile" already means "you cannot write to it,
and reads will not be fused".  :-/

> No promises, other than that if we don't ask, they won't say "yes".
> 
> Let me see what can be done.

From a semantics viewpoint __atomic_load_n(&x, __ATOMIC_RELAXED) would
work for loading from x.  The compilers that I tried currently do not
fuse loads, but they are allowed to do so.

Or is there something I am missing that would make this not work?
Aside from compilers not yet optimizing this case.

							Thanx, Paul

