Return-Path: <linux-kernel+bounces-160298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A018B3B92
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D351A1C23BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19249149011;
	Fri, 26 Apr 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="myC72MAE"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786E148854
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145540; cv=none; b=kjUs//MVbJHacTzPPC131lJyFgGp4/Fu2JoU799ACosJZJCMbe5q0k8R37fNmF7xy52rrSunitclz5+WuAAmAmtAloQuaY6YwzfIb4bX2FpDurHGKLSRG7UUcFZdelY+Sr3AfFjPp18kMJ3x7gIx8kobbln7w1SohvlPXmFzvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145540; c=relaxed/simple;
	bh=DbV+zobexYg0znYqLnhPnqemiMr2YzUJ8flgCq0Rwas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rANqxdlPQLLpQcIDxgs3ab0jhKG84hwiE972snHOJJCX2hE6MaVgjOkV4rMmqk1SMZeOUmKZ5f2mhTc0a4UPfgUFXKGDudHakoub7nXZyn0GhQcnSEHrA+U1Q1wTH4JM+vjD0eM2aIols4N2YsV/PMTcIak6rNgRRCe394un1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=myC72MAE; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de467733156so2456327276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714145538; x=1714750338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AS7F2S8/cotcGn6q7tGA+zdknX79HwQNovwoIzqrUUg=;
        b=myC72MAEY2pD9iy2JCa1YY5ORR1Sbc3W46dFS+7ago7Gff2DO1vLOA8xUDO8WAbWn3
         Vy1tQgXS8G2W+AFrBEd7OUw6A59INIcwlMcEQ+UGhkQtYjRNc6Ec6sYAFq0jAT7DlGYa
         LYHA+UX1NaCOF0GcOFgVwEAzbkTgzOWS23wLQ4aj4SFWc5SgY82c3Ml9t93HTExEJIyV
         pmv4ZZTd1lYBix1MgfaKq66b6bf+ChjTdrmAKLh2UhAti9m7ojkgJtt3qF0xsj7yv65v
         e75kva+U51OMskXtheKQM2XCgC5GCdOkd8j/vxWKCdJTS8vOC5y/eGMS8noGfhhLLPt+
         Cdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145538; x=1714750338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AS7F2S8/cotcGn6q7tGA+zdknX79HwQNovwoIzqrUUg=;
        b=PTfYay1dMHDSvWtF6szH1HcD7DyzD/dMohnNXEPD2YDJQC+qaAdD+PLCZPmB/n6OkB
         4L5hIb/zF+EbmUV1QgR8ETcsxBlds/7w4OLkO9tmdFHfVTzpiWRL+f+cu98JL70DEp3A
         6gMiFch5iLrVG8VXJ6vZgBGFRxug+jKcfz/KwO7BnWMo7d4zn+8vXnOYxKc3InWR4Qhp
         ZbIpV3wUJHNLBH7lsA4KFI2cS7DlxqE8KNAXxEE60I7PFKoZa9VW4p09MvW4b9+pgrYR
         UsW5lo9u38pnpw21msXyx4oRmtz7y0jYyw6lRHFSlmqj31yIcAyAl88DtikMbrfb+9S0
         k2yw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHyvh/NEq3ubYE3stUIvSVAr+AXUPJWqYd+HJyOV6AhIufjBaf7XFlFoQz2kb/12CDb9015QGFhVN/8olHief5cunsoh8fiam/ZnP
X-Gm-Message-State: AOJu0YyMgWx1mEIqwBYQ82XbzvshmNw0qRgIAvgQA63mJ5nj2wEQflhV
	xl/I7rv6+wg8p5rlfG8xt5zQNw4g/wpjfJaXsIPKEwOvGMwj6z6+eCPKoaCroiU50R8v6Fzb7sU
	RS1rS3rNd/YLIKi1uDgO4Mfi8MUhhrPpR0HLX
X-Google-Smtp-Source: AGHT+IEbMHZmUoliwhZDi51Mi8cRiHlfjY/QQEfE15qe+QlxN4TZHCdoAoldZKGr4HHtMlg+YKOHqObI+mDnD/6gxOk=
X-Received: by 2002:a25:dbd3:0:b0:de5:ad49:3e2b with SMTP id
 g202-20020a25dbd3000000b00de5ad493e2bmr2218945ybf.37.1714145537300; Fri, 26
 Apr 2024 08:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410170621.2011171-1-peterx@redhat.com> <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n> <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n> <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org> <ZiuzikG6-jDpbitv@casper.infradead.org>
 <CAJuCfpH+O0NYtTrGKSY6FjBOcWpyKXB+_4rsSRjcewSXUWVfCQ@mail.gmail.com> <ZivILlyRv7rNMldQ@casper.infradead.org>
In-Reply-To: <ZivILlyRv7rNMldQ@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Apr 2024 08:32:06 -0700
Message-ID: <CAJuCfpEqJV9Lv+36xNK+vnpsR5DhQ0kCK3CW7tLFWbbbSCH8yg@mail.gmail.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:28=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Apr 26, 2024 at 08:07:45AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Apr 26, 2024 at 7:00=E2=80=AFAM Matthew Wilcox <willy@infradead=
org> wrote:
> > > Intel's 0day got back to me with data and it's ridiculously good.
> > > Headline figure: over 3x throughput improvement with vm-scalability
> > > https://lore.kernel.org/all/202404261055.c5e24608-oliver.sang@intel.c=
om/
> > >
> > > I can't see why it's that good.  It shouldn't be that good.  I'm
> > > seeing big numbers here:
> > >
> > >       4366 =C4=85  2%    +565.6%      29061        perf-stat.overall.=
cycles-between-cache-misses
> > >
> > > and the code being deleted is only checking vma->vm_ops and
> > > vma->anon_vma.  Surely that cache line is referenced so frequently
> > > during pagefault that deleting a reference here will make no differen=
ce
> > > at all?
> >
> > That indeed looks overly good. Sorry, I didn't have a chance to run
> > the benchmarks on my side yet because of the ongoing Android bootcamp
> > this week.
>
> No problem.  Darn work getting in the way of having fun ;-)
>
> > > I still don't understand why we have to take the mmap_sem less often.
> > > Is there perhaps a VMA for which we have a NULL vm_ops, but don't set
> > > an anon_vma on a page fault?
> >
> > I think the only path in either do_anonymous_page() or
> > do_huge_pmd_anonymous_page() that skips calling anon_vma_prepare() is
> > the "Use the zero-page for reads" here:
> > https://elixir.bootlin.com/linux/latest/source/mm/memory.c#L4265. I
> > didn't look into this particular benchmark yet but will try it out
> > once I have some time to benchmark your change.
>
> Yes, Liam and I had just brainstormed that as being a plausible
> explanation too.  I don't know how frequent it is to use anon memory
> read-only.  Presumably it must happen often enough that we've bothered
> to implement the zero-page optimisation.  But probably not nearly as
> often as this benchmark makes it happen ;-)

I also wonder if some of this improvement can be attributed to the
last patch in your series
(https://lore.kernel.org/all/20240426144506.1290619-5-willy@infradead.org/)=
.
I assume it was included in the 0day testing?

