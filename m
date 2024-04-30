Return-Path: <linux-kernel+bounces-164541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF248B7F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5851C23005
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A6181328;
	Tue, 30 Apr 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQDg3P8K"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27271802B5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498904; cv=none; b=HCxLkaGrpWjuH08JlOYffknow/6p82MZgcoCi2aD6iWdx6AIA7BLcw6OAVBeS7bLvOsvzOFvPuMXYJ+xpZ8RBrIq4qt7wz6JZFtI4dYZARnuLT27CWQAKyNjy9DJ0b9H9+YXgPSItgYTpHNavrXG9gbxlGIh4gFSsBa886hiqwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498904; c=relaxed/simple;
	bh=8YWdyvS2Ms1qseheIlyBeSHCXKMJCi8Tg2YpmVn/j5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yti2s1QbrXlJtPeBe0IZHabbqX+MuOhHE7HEo38kNqi+flBM4vkTnbixfL6+PUOj1j5gqwzt0w0VJTmem7N7ZEAPhlyJCFzBN6PzpP8cJb1d5BW389Y2216Z/7VOdr5N31mYQfTgtNlXhXr0C/U2k1KM5fbpd0u4la1RI5z0jeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQDg3P8K; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4702457ccbso794729366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714498901; x=1715103701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZ74h5LHi7baPDY6W1AyYYfznl65M9Axb+eFJNRztRw=;
        b=cQDg3P8K3gdq6g3vJVqejVp8aefX+09bSNJ9neN01VITn1svqAVOo0HDaCwRoNRn+s
         UNUn1heptWtlWaAr1w6vELsVbG0NeQxW3YV12z4zytAK1mdNbe0S4DXQ4y4Jj29jeSHZ
         7hLUYnPaJueVAKTwwnpxh1Dsq1PFcAyM1OqcSxCMU/zwFW6oAstG5nK1KXzBQvsjcC3j
         og4SpXQKUxVXjXwugwr+BNA6rtNjfWjbqjOL3YT7kAJGxBMq2nA6EG1z3g6dBtJAUFlM
         K7JqlLPMXIlEVd6XYn53FLF5pw1a48KVmi53RcPw2YJn6ic6imKXT4M/VDn77XBV4mR/
         FmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498901; x=1715103701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZ74h5LHi7baPDY6W1AyYYfznl65M9Axb+eFJNRztRw=;
        b=KRUmgB7PDT7ade9oASBDZ6OW8+PjmpomCp/OyRhJ+3nvCPc3FMaQPrRAsSwP7cpW4i
         9WUuEIiUKK/xF33clkqtzRRWva3ZsLEJYpwJ1jFDCc7Vr+Z6g+bYJmYwL01iMGJT7E/k
         1sRKMWN+aCZ82LqjyDrvpPK1g+/SBlIHDdrh1Fy99ZrAN9EA0zAvlXj2A42Q8olBgDh+
         BSVwdQk5pt1LxXva2qlGh8OeS4mQVZc9KT+rwbH6NpO4IUUsb3hKW6maDr1keJOSZJS4
         pnXtuns7hEgU6pDABwVCFuS/eSMxBPEUy38Rx8UCD1RB/0r9wiVUPlC9q8jD3OXmslo2
         8icg==
X-Forwarded-Encrypted: i=1; AJvYcCWe8LX9+kf9G1uu9nvrmUC2ztGDnI70I4xsDeiscwRKL867C/0jMFJ/pDDQ+HAtf+b8f3lH0qS8UsgkkKutCJh8DtO7UXsCddEMv0vZ
X-Gm-Message-State: AOJu0YyHb6pDuIq9aeyU5Chy2AA+YYEFSYUnqz7TJJh9x6xmwVz05Dpm
	+TsZ4uaJfOJDQHFyLSeFFlNSbbngljgIT7r2j/BYB37ogjQKjh+8hMB6FLMPJ4n+8YfG/2QI15h
	kOnxvSFDGHOnOnyMrllbNdPwgsG5r5jMrMBfB
X-Google-Smtp-Source: AGHT+IFyc0dDWDKpEZhiJHkKFTiLS5ZalTfSl0iDvjRFvqGrKJKyM2wd6xsG7YEzOa7HHXLpL3cYIYbxICWMfD1zYpA=
X-Received: by 2002:a17:906:880e:b0:a51:8145:6877 with SMTP id
 zh14-20020a170906880e00b00a5181456877mr282005ejb.37.1714498900595; Tue, 30
 Apr 2024 10:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
 <20240430060612.2171650-5-shakeel.butt@linux.dev> <CAJD7tkZnXY+Nbip8e6c7WC4qoYC21x=MHop_hT4NqYLKL8Fp6Q@mail.gmail.com>
 <u3okwix7ovvzzfossbmfalwpq23qa3bmv3secg7tpjk7ghyemq@w3ngvr526rc2>
In-Reply-To: <u3okwix7ovvzzfossbmfalwpq23qa3bmv3secg7tpjk7ghyemq@w3ngvr526rc2>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 30 Apr 2024 10:41:01 -0700
Message-ID: <CAJD7tkZh-bLHQhaPsU7h1WUmK3xwHVoacVcR=P55i+7d0FzfFw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] memcg: reduce memory for the lruvec and memcg stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, "T . J . Mercier" <tjmercier@google.com>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:38=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Apr 30, 2024 at 01:41:38AM -0700, Yosry Ahmed wrote:
> > On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> [...]
> > > +
> > > +#define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> > > +#define NR_MEMCG_STATS (NR_MEMCG_NODE_STAT_ITEMS + ARRAY_SIZE(memcg_=
stat_items))
> > > +static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
> >
> > NR_MEMCG_STATS and MEMCG_NR_STAT are awfully close and have different
> > meanings. I think we should come up with better names (sorry nothing
> > comes to mind) or add a comment to make the difference more obvious.
> >
>
> How about the following comment?

The comment LGTM. I prefer renaming them though if someone can come up
with better names.

>
> /*
>  * Please note that NR_MEMCG_STATS represents the number of memcg stats
>  * we store in memory while MEMCG_NR_STAT represents the max enum value
>  * of the memcg stats.
>  */
>
> > > +
> > > +static void init_memcg_stats(void)
> > > +{
> > > +       int8_t i, j =3D 0;
> > > +
> > > +       /* Switch to short once this failure occurs. */
> > > +       BUILD_BUG_ON(NR_MEMCG_STATS >=3D 127 /* INT8_MAX */);
> >
> > Should we use S8_MAX here too?
> >
>
> Yes. Andrew, can you please add the above comment and replacement of
> 127 with S8_MAX in the patch?
>
> [...]
> > >
> > > -       pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruve=
c);
> > > -       x =3D READ_ONCE(pn->lruvec_stats->state[idx]);
> > > +       i =3D memcg_stats_index(idx);
> > > +       if (i >=3D 0) {
> >
> > nit: we could return here if (i < 0) like you did in
> > memcg_page_state() and others below, less indentation. Same for
> > lruvec_page_state_local().
> >
>
> I have fixed this in the following patch which adds warnings.

Yeah I saw that after reviewing this one.

FWIW, *if* you respin this, fixing this here would reduce the diff
noise in the patch that adds the warnings.

