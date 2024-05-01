Return-Path: <linux-kernel+bounces-165701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493678B8FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840AF1C2106C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CB416089A;
	Wed,  1 May 2024 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyGL4Tmy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1551607BB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714590150; cv=none; b=isiZ98SKbsUTcGozoZ27CkoT3NS/6KqF3BUCRB5jBCvWF7GT3S7ja+pDS/yJNoUVYQ+45/PeQbFQlAy2aysrfjTaBl/aNCdrXrV81H1RXnV03Y7fdy50JLDrACRu0tDHmof2c5b2gP5AbCHvZRSMspbIB74/GpHjDP8nROqhKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714590150; c=relaxed/simple;
	bh=9udOA9Ep/XqlHS3m8QRVgy6nVeB1FOn7sChRztjh8K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKI/CeaxKg4IxPiBaQMq0ZkUiOyCUfF6uhH1HK3ndvuNlvyXA4CngNB70ig6uPgavPGXrx+S90tZq4z8dBjMGMv2vp9Z8Kx8Eva0ciSOxHDBt7/lk9wkfMxKU4tu0Z1hFaoc55genO7spjwRLrAgpzLH/lhLDj3zZkBnQMhHQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyGL4Tmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74A8C32789;
	Wed,  1 May 2024 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714590149;
	bh=9udOA9Ep/XqlHS3m8QRVgy6nVeB1FOn7sChRztjh8K4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WyGL4TmydGYnrzJF2iDWXIPDWO8MdKBPdA4c9INgSzW+YAgYfJdIiIagJ4pFQY0nk
	 fSvOvsnAgDLi2zIijIfVdljbxzLoiXITlPT+4gKvWnu7tpHCj0RXrfQAmgBwt3mVLw
	 HiBHV0JHvghRgd0GNZmmf9X4pmR/A/HHx4GwuJQNi5wA6wo1LHNuG4+n5udUTneVgl
	 C0Pufi9Dy8w+rnTbdx7rMcRzfhng1A05CiKvSk/G9s72t3iZZI40Y8vOAR9AnPyE+G
	 WcuKjHukgigWlu1yDShuy1luOpIrifOoHnaXSNkWkyq0qxe+4ZEzxZ+ZqRFaloFyoN
	 mchXMNJEog+Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 76CB0CE0C37; Wed,  1 May 2024 12:02:29 -0700 (PDT)
Date: Wed, 1 May 2024 12:02:29 -0700
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
Message-ID: <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh>
 <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop>
 <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>

On Wed, May 01, 2024 at 11:56:26AM -0700, Linus Torvalds wrote:
> On Wed, 1 May 2024 at 11:46, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > In short, I for one do greatly value KCSAN's help.  Along with that of
> > a great many other tools, none of which are perfect, but all of which
> > are helpful.
> 
> It's not that I don't value what KCSAN does, but I really think this
> is a KCSAN issue.
> 
> I absolutely *detest* these crazy "randomly add data race annotations".
> 
> Could we instead annotate particular structure fields? I don't want to
> mark things actually "volatile", because that then causes the compiler
> to generate absolutely horrendous code. But some KCSAN equivalent of
> "this field has data races, and we don't care" kind of annotation
> would be lovely..

That would give the poor sleep-deprived innocent bystander some way
to figure out which fields were shared, so that does sound like a good
improvement!

I would naively expect that KCSAN's ability to handle volatile fields
would make this doable, but there is much that I do not know about
KCSAN internals.  So I must defer to Marco on this one.

							Thanx, Paul

