Return-Path: <linux-kernel+bounces-166827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0418BA01F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A71B28857B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17AE172BC1;
	Thu,  2 May 2024 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lRMm4d8O"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04B16FF2B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673697; cv=none; b=qjl+Nh8mLe6Sq3OeA+880HpmuTfEaRBgb/FlhI67oHRz+APcF+PqYRxWeFF7taDcW4crTNVCJsXLyYmgrd1dibk0k9eFH0mqU+/x5Tt2KdA4tZ61v65n1RF0OPSVPIxb5FTkofk1FDs2awRjsndropKlyRo7jaByjUJEsA0/2Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673697; c=relaxed/simple;
	bh=YoJFzgY7p1NKm94W467Kl9UkLkc4xTsT4UF50wV/ekY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKymClVvTHLAKDO0BND46eaeEV4U2HTa8xNFmtRUWDNRvSiT3DVFmJHuTXmghJ/VIGbMB8NxDgoQJYCF55KjgyzAMo+PfLK133RU1YsnZ384rn1POyLVETrDqPhPRGlJmkwrtarVzHwsX2pLgBjB5yWKM2fSbfnUI2PMnKXfWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lRMm4d8O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QZy81ykq8OJZJBea1Ve4W5aphIuVf2I+J1Ov16wYfZA=; b=lRMm4d8OjpyCEjRGZXYGHj+dLM
	wACF3cLWIzB/G2qm4snoeoStB+uqqOCwx7AfD4xVG46dwtyR2MjTdz4E+A1VV8EjtFQwYMtlB8Jn5
	ujOAr1WE6lxuY+IJB4r2s8lXC/uyWny/lp/DRYkX58vx/pm8dVuqh7xLaWFaiJiXwNftG1Xn/6wWs
	d7AblKGmlOGbgrhgPKR81uzRC5zFzDplNYrG5NA2hTA9JJxx9hcOdgvSU6RtHcKneKgFAXCczU3l6
	2UUCqZWSLtRkkj0RcyEQwrQQYKflgDkBkk4lsNpRjGadv7+9ec8Q1MjM1LC0959WE/3rCoG13/wS+
	a3AU1o/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2axB-009clW-01;
	Thu, 02 May 2024 18:14:45 +0000
Date: Thu, 2 May 2024 19:14:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Marco Elver <elver@google.com>, paulmck@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
Message-ID: <20240502181444.GF2118490@ZenIV>
References: <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop>
 <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop>
 <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CANpmjNNo_jyTPrgPVCeSfgvsX-fK8x0H81zbBA6LZMVNodO6GA@mail.gmail.com>
 <b13ab60e-503a-4c11-8a99-0ccccce33c6c@I-love.SAKURA.ne.jp>
 <CAHk-=wi_QBG68QshO1e-xK-jt0ZFsMpZczEJe4nQMu+U7q_7EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_QBG68QshO1e-xK-jt0ZFsMpZczEJe4nQMu+U7q_7EQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 02, 2024 at 10:29:52AM -0700, Linus Torvalds wrote:

> Yes, this is unusual. The *common* thing is to mark pointers as being
> volatile. But this really is something entirely different from that.

The common thing is to mark pointers are pointers to volatile;
calling them "volatile pointers" is common and incorrect, and the only
reason why that sloppy turn of phrase persists is that real "volatile
pointers" are rare...

Marco,
	struct foo volatile *p;
declares p as a (non-volatile) pointer to volatile struct foo.
	struct foo * volatile p;
declares p as volatile pointer to (non-volatile) struct foo.

The former is a statement about the objects whose addresses might
be stored in p; the latter is a statement about the object p itself.

Replace volatile with const and it becomes easier to experiment with:
	char const *p;
	char s[] = "barf";
	char * const q = s;
	...
	p = "yuck"; 	- fine, p itself can be modified
	*p = 'a';	- error *p can not be modified, it's an l-value of type const char
	q = s + 1;	- error, can't modify q
	*q = 'a';	- fine, *q is l-value of type char
	p = q;		- fine, right-hand side of assignment loses the top
			  qualifier, so q (const pointer to char as l-value)
			  becomes a plain pointer to char, which can be
			  converted to pointer to const char, and stored in
			  p (l-value of type pointer to const char)
	strlen(q);	- almost the same story, except that it's passing
			  an argument rather than assignment; they act the
			  same way.
	strcpy(q, "s");	- almost the same, except that here the type of
			  argument is pointer to char rather than pointer to
			  const char (strlen() promises not to modify the
			  string passed to it, strcpy() obviously doesn't)
	strcpy(p, "s");	- error; pointer to char converts to a pointer
			  to const char, but not the other way round.

The situations where you want a const (or volatile) pointer (as opposed to
pointer to const or volatile object) are rare, but this is exactly what
you are asking for - you want to say that the value of 'f_op' member
in any struct file can change at any time.  That value is an address of
some instance of struct file_operations and what you want to express is
the property of f_op member itself, not that of the objects whose addresses
might end up stored there.

So having a driver do
	const struct file_operations *ops = file->f_op;
is fine - it's basically "take the value of 'file'; it will be an address
of some struct file instance.  Fetch 'f_op' from that instance, without
any assumptions of the stability of that member.  Use whatever value
you find there as initial value of 'ops'".

That's fine, and since nobody is going to change 'ops' itself behind your
back, you don't need any qualifiers on it.  The type of 'ops' here is
"(unqualified) pointer to const struct file_operations".

