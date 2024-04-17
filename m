Return-Path: <linux-kernel+bounces-147811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5538B8A79F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF952837F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672C04C63;
	Wed, 17 Apr 2024 00:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IdMlxcoS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2B4685
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713315163; cv=none; b=L7ce+ybtO8Ns1dqfngqiKBe3u6XSIRdqO2oxIm65Q1VbHI+QKts/fQl+XkuNNC7jpIXI2UFpqMXXVHFVrHSmYn4eG/IeVYpPjVOQoceG1Qos2d8XJA4+iUk6qWnr9RST6Wj+NF3LCim0Mw5vSbxFRtNZkM1vvW7WHbnpXTr80Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713315163; c=relaxed/simple;
	bh=e1EPCuZbmnrFKsbEiCC06D0fNmgHNQLwamMpq9kTdY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEH2yarSoSUDChzFiNdwbe9OfJDPKIQiBo7LSqSh6cnnnP6P38DRqwvSeZLTt/jY4LplEX74BXeKO9KxzjMP3ZO9DeRQaOs2kqfc6Dj4pIk1q4zt7ZfVqULdghj6vM6wuoq0LOjupo6JjzGHO31qMw7gIwYA7Zb2ZP6c9lm0oFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IdMlxcoS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W/lt/7F3YMgBxFhWQpb6au2alhEkVHW3mXdf7i1b0d8=; b=IdMlxcoSJxENRvWy3JaJd0s41p
	8Z0BpLEngBBBrZiJo8Mz7QSH98XAmDIf0RgO9yyPycn5pxcuOWb0Fr4KJLQwUqG2Uq2vHm15snIjg
	sjm2st80U3LL5+fmR5wM7RYyAwkiRxfvfzGXVTLeKFvCoYMXARTBmP9p6/GkCWd68fzIyJIyGsbC1
	qA6bhVq8vkaC3bSF0K1UGTslVqYzJUc4Y5mN6Yg6RohHOMLmwHbOcf/fgLcdAowoEXw9eORP8x967
	xfcZDou/sNLXNEIIKnusDWmkKecDrbAkPqTmSEu+X6XLVMSjiltCck3EGjxlg+IVEf/pO4VKRaMc7
	q06uajcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwtXI-00000001n0m-3xUF;
	Wed, 17 Apr 2024 00:52:29 +0000
Date: Wed, 17 Apr 2024 01:52:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] Enable -Wshadow=local for kernel/sched
Message-ID: <Zh8dTOZ_YxeGhp-L@casper.infradead.org>
References: <20220302043451.2441320-1-willy@infradead.org>
 <202404161413.8B4810C5@keescook>
 <CAHk-=wg7+dfpEvDnTnB-eR9QRZ2VySbxOEHbYqL3Ai5wwkon5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7+dfpEvDnTnB-eR9QRZ2VySbxOEHbYqL3Ai5wwkon5Q@mail.gmail.com>

On Tue, Apr 16, 2024 at 05:29:02PM -0700, Linus Torvalds wrote:
> On Tue, 16 Apr 2024 at 14:15, Kees Cook <keescook@chromium.org> wrote:
> >
> > I was looking at -Wshadow=local again, and remembered this series. It
> > sounded like things were close, but a tweak was needed. What would be
> > next to get this working?
> 
> So what is the solution to
> 
>     #define MAX(a,b) ({ \
>         typeof(a) __a = (a); \
>         typeof(b) __b = (b); \
>         __a > __b ? __a : __b; \
>     })

#define __MAX(a, __a, b, __b) ({	\
	typeof(a) __a = (a);		\
	typeof(b) __b = (b);		\
	__a > __b ? __a : __b;		\
})

#define MAX(a, b)	__MAX(a, UNIQUE_ID(a), b, UNIQUE_ID(b))

At least, I think that was the plan.  This was two years ago and I've
mostly forgotten.

>     int test(int a, int b, int c)
>     {
>         return MAX(a, MAX(b,c));
>     }
> 
> where -Wshadow=all causes insane warnings that are bogus garbage?
> 
> Honestly, Willy's patch-series is a hack to avoid this kind of very
> natural nested macro pattern.
> 
> But it's a horrible hack, and it does it by making the code actively worse.
> 
> Here's the deal: if we can't handle somethng like the above without
> warning, -Wshadow isn't getting enabled.
> 
> Because we don't write worse code because of bad warnings.
> 
> IOW, what is the sane way to just say "this variable can shadow the
> use site, and it's fine"?
> 
> Without that kind of out, I don't think -Wshadow=local is workable.
> 
>               Linus

