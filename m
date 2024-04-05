Return-Path: <linux-kernel+bounces-133092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB9899EB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A32C1F23F9F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A816D9AE;
	Fri,  5 Apr 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUbNjwdS"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46916D9B0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324855; cv=none; b=UvPpPWzo3b+8FQWAuzY7t1lOUu3R18Tu9dcZeBq1pAdrJlgdOXRAGcbvJlLNbP3t7PXfL0S00yv0s1srCfBlyVo6hUKQ2XqHV4hMddAugaZjTM7IU/BgaXY8fNOu/lA4Hyiu9iafYgpUQMs9d3S5zYnHDu0TqW39G1qjUqhL5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324855; c=relaxed/simple;
	bh=eHFqbIhCRlO8+eg0bsye3/gnRyfWteI0TtMg8FRqQjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpwZ5Ip21NgLh3VrinNxjA6CBo1H2CBdn8hhpddXQwGdymzQ7IJDT5Quo5p70VJgPkv5Yxd+wuIeVTD3uCeBGb4q4a83JzV5mPNw8LHpzgKBkltCsUQ6DY9dYXtc5KbH7D1HiCMt9rKpioV6OzDBn8bFHVfLl/s/kAXbogBhZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUbNjwdS; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-617d25b2bc4so5439597b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712324851; x=1712929651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDkodhxPHjCRcYuHL8QJdxmj/UyX4mSAQyu360+3BOI=;
        b=VUbNjwdSHuFql+0qqSA6ulfb92n/na/cVGs9xcWDSze4ziRSFHPv67sZK5aQUDeQsb
         3TuuRG5ceBVzSdQWK6ylm141wxF/YJSyp+7F71VKNBSU9GB0yjWMTL1R9JapJSI8Gv9m
         I1YxyWBxwMy9EqXxX8R1RPb6+AcZul2LuqH7ba1Yx/NabSMQyem5R3CkTZ1EEvowdeHa
         isOarVU/YLDKbyYy/URONSvQu5EcZOyIrMIBbLa5ZzP8Yt3T81nTcDtmT3TWN3wm7gb6
         4nPV0rPArcITIyCy945cZX7BGr6gY1nwBvjL1nNuQ7LjG+tRrC0uBdBtWdveKzp7pCJ0
         OsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712324851; x=1712929651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDkodhxPHjCRcYuHL8QJdxmj/UyX4mSAQyu360+3BOI=;
        b=AG/oDGozwLL0L3SQ3vmGKyII88vmEOEB+973o2Q4EdwCuiq8BeImFooVq9779XGjJ2
         1nTJ4e/5eUAPCK0PYyH1ztwNVXEXx8ek7DJVJbD2eFovZld7vzYDFgqCp3aDmP+rLm9o
         RN31/aNMubwZG0yvPKn7MdbllhHhHbk3DZDJn8SGOIaDXBhNxtKxmx6zl0f9qsSNeTK9
         8vj5z22f1PpuXbY8wwfvLV6Ie84Ccz+47Wo6TKBW/R84WzNlzb7gRvH7AgOok9jCGSb6
         Ybe1P8QP//oUFaM/5UFITYkEZu8oGTHBT3raya6H6WtgAgd1u1U2RjYuw9nwhAXkxhxw
         g7qw==
X-Forwarded-Encrypted: i=1; AJvYcCWVWN1SI82evz020469bGQK0lPDrVPZhyabjX4C5EHHSY7CIjSvcYG7jo/uB3eF4n5AVKuNE+60xfp/wF60H9XGg+5kamnUUOCGd/wP
X-Gm-Message-State: AOJu0YzJueS1nRZYIZu/FHng3YQlEdh4It4BIef2R+JoKRj0BXu6Nl5Q
	S8aD9Q9p6CbmPWto5okdlrQcU+topg3An3Rh1eV6X6lWXzklXYmq5KaGX7OVo+bYXTPheA5mFwX
	z5fDQwOr/PHTJw4awoG6HzYQHkF9IGaMivDT6
X-Google-Smtp-Source: AGHT+IETt+9jSDY6jbVQEtdOA/2Ue8S5T1KTCdTuvtcb7ogtZ6i7ZvA/55fNMoiVG+R35qGWCJRB01iqaNVA/qZfNAE=
X-Received: by 2002:a25:e30e:0:b0:dd0:2076:4706 with SMTP id
 z14-20020a25e30e000000b00dd020764706mr1142654ybd.31.1712324850962; Fri, 05
 Apr 2024 06:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404165404.3805498-1-surenb@google.com> <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
 <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
 <Zg8qstJNfK07siNn@casper.infradead.org> <jb25mtkveqf63bv74jhynf6ncxmums5s37esveqsv52yurh4z7@5q55ttv34bia>
 <20240404154150.c25ba3a0b98023c8c1eff3a4@linux-foundation.org>
 <jpaw4hdd73ngt7mvtcdryqscivx6m2ic76ikfkcopceb47becp@vox5czt5bec3>
 <CAJuCfpF10COO2nh1nt3CcaZOFe4iSXszsup+a0qAEQ1ngyy5tQ@mail.gmail.com> <20240405095327.ufsimeplwahh6mem@quack3>
In-Reply-To: <20240405095327.ufsimeplwahh6mem@quack3>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 5 Apr 2024 06:47:17 -0700
Message-ID: <CAJuCfpHG5U5Radv+_D3nD3OxAgqzBa_Za28+RS=NTG53Y=xpsg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
To: Jan Kara <jack@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, joro@8bytes.org, will@kernel.org, 
	trond.myklebust@hammerspace.com, anna@kernel.org, arnd@arndb.de, 
	herbert@gondor.apana.org.au, davem@davemloft.net, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, tytso@mit.edu, jack@suse.com, 
	dennis@kernel.org, tj@kernel.org, cl@linux.com, jakub@cloudflare.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	vbabka@suse.cz, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:53=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 04-04-24 16:16:15, Suren Baghdasaryan wrote:
> > On Thu, Apr 4, 2024 at 4:01=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Thu, Apr 04, 2024 at 03:41:50PM -0700, Andrew Morton wrote:
> > > > On Thu, 4 Apr 2024 18:38:39 -0400 Kent Overstreet <kent.overstreet@=
linux.dev> wrote:
> > > >
> > > > > On Thu, Apr 04, 2024 at 11:33:22PM +0100, Matthew Wilcox wrote:
> > > > > > On Thu, Apr 04, 2024 at 03:17:43PM -0700, Suren Baghdasaryan wr=
ote:
> > > > > > > Ironically, checkpatch generates warnings for these type cast=
s:
> > > > > > >
> > > > > > > WARNING: unnecessary cast may hide bugs, see
> > > > > > > http://c-faq.com/malloc/mallocnocast.html
> > > > > > > #425: FILE: include/linux/dma-fence-chain.h:90:
> > > > > > > + ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_=
chain),
> > > > > > > GFP_KERNEL))
> > > > > > >
> > > > > > > I guess I can safely ignore them in this case (since we cast =
to the
> > > > > > > expected type)?
> > > > > >
> > > > > > I find ignoring checkpatch to be a solid move 99% of the time.
> > > > > >
> > > > > > I really don't like the codetags.  This is so much churn, and i=
t could
> > > > > > all be avoided by just passing in _RET_IP_ or _THIS_IP_ dependi=
ng on
> > > > > > whether we wanted to profile this function or its caller.  vmal=
loc
> > > > > > has done it this way since 2008 (OK, using __builtin_return_add=
ress())
> > > > > > and lockdep has used _THIS_IP_ / _RET_IP_ since 2006.
> > > > >
> > > > > Except you can't. We've been over this; using that approach for t=
racing
> > > > > is one thing, using it for actual accounting isn't workable.
> > > >
> > > > I missed that.  There have been many emails.  Please remind us of t=
he
> > > > reasoning here.
> > >
> > > I think it's on the other people claiming 'oh this would be so easy i=
f
> > > you just do it this other way' to put up some code - or at least more
> > > than hot takes.
> > >
> > > But, since you asked - one of the main goals of this patchset was to =
be
> > > fast enough to run in production, and if you do it by return address
> > > then you've added at minimum a hash table lookup to every allocate an=
d
> > > free; if you do that, running it in production is completely out of t=
he
> > > question.
> > >
> > > Besides that - the issues with annotating and tracking the correct
> > > callsite really don't go away, they just shift around a bit. It's tru=
e
> > > that the return address approach would be easier initially, but that'=
s
> > > not all we're concerned with; we're concerned with making sure
> > > allocations get accounted to the _correct_ callsite so that we're giv=
ing
> > > numbers that you can trust, and by making things less explicit you ma=
ke
> > > that harder.
> > >
> > > Additionally: the alloc_hooks() macro is for more than this. It's als=
o
> > > for more usable fault injection - remember every thread we have where
> > > people are begging for every allocation to be __GFP_NOFAIL - "oh, err=
or
> > > paths are hard to test, let's just get rid of them" - never mind that
> > > actually do have to have error paths - but _per callsite_ selectable
> > > fault injection will actually make it practical to test memory error
> > > paths.
> > >
> > > And Kees working on stuff that'll make use of the alloc_hooks() macro
> > > for segregating kmem_caches.
> >
> > Yeah, that pretty much summarizes it. Note that we don't have to make
> > the conversions in this patch and accounting will still work but then
> > all allocations from different callers will be accounted to the helper
> > function and that's less useful than accounting at the call site.
> > It's a sizable churn but the conversions are straight-forward and we
> > do get accurate, performant and easy to use memory accounting.
>
> OK, fair enough. I guess I can live with the allocation macros in jbd2 if
> type safety is preserved. But please provide a short summary of why we ne=
ed
> these macros (e.g. instead of RET_IP approach) in the changelog (or at
> least a link to some email explaining this if the explanation would get t=
oo
> long). Because I was wondering about the same as Andrew (and yes, this is
> because I wasn't really following the huge discussion last time).

Ack. I'll write up the explanation or if there is a good one already
in our previous discussion will add a link to it. Thanks!

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

