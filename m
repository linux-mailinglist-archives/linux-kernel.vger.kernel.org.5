Return-Path: <linux-kernel+bounces-150730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1708AA3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086C41F21499
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE64818130C;
	Thu, 18 Apr 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UvUZ0NM5"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53995180A8D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471005; cv=none; b=WAKUASH2n+iIoWLa28B0np04+pthEptHcxEFx/eZZZZ2Yfv1a5NZ0wGShqbfuqNXik1zmXihFC7u3aS7NK6k8Mh2+5zbJIXro1peOnxAcV4Zx8GdoVMhX/fny7HgGjgPVHK1aOmqvIo/1aaXYWFUy2k9H+P+d1ZBM2276c4z17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471005; c=relaxed/simple;
	bh=s9iI3OKQXwaBu4CUf7G1NuE/rQMlTxloyWIe7jxfkJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCgYTaoFywZaTvLJdtivW2CTBSZ1FIBJxlF0fbtMRvpEu0f8fKkinIPxxqBPxb2dmP0iKddPXw4lwxU6+Yk2XcPfh9KZZdjH4StbDhT/Yx2W03S3/t3C/9ZOwJf+I35hIo9EJJdeIZmiJOGEEE0UioSOqwRqX8GMmDm4iYe8xpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UvUZ0NM5; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d3a470d5so1548739e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713471001; x=1714075801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp8BfU7cj3Avv6w7b6diX/CWBRB9qpT5rd/d7P5dcFg=;
        b=UvUZ0NM5tDw0b7dfYGOyzmF+386XnR4E3ZJUGqaULFdtdOnW2orR14YP8Ct13kH30I
         rAc6tt9hI1XNpLiYzUSCDUwpdj0JQhOw3Kgg+HpJX4MbYgv2MtuW+Y+frKJZ1JEi/U9T
         jpZlJt0IpHxtwrqDvuttPcv3didtW9+zlw3g+YMrcFZH3JMnHR5waRSkTYd88VnhOak8
         jNZqnJP3UDHVkbNjOt+qe2Oe1xFtXWqz3d4kXYsUdClk+Cc8V5+LcggCuCZkQaGsiTdp
         44429IL2Uxd5RSCMJQhJwklBaQt4oZlumW2yDBpq+XFfhsUJo4T5lq7bXibUzv8IG7/Q
         /kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713471001; x=1714075801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mp8BfU7cj3Avv6w7b6diX/CWBRB9qpT5rd/d7P5dcFg=;
        b=G9DEf9DmHPLMNvOxUUhg8fdxImBU+cgCH2BanIQbzOFYieLn0iU6SyvPvid1t/s3fB
         fvd1sZIJOl3zKtGiDX7AH+4V1cz6d0uloZcmYqiJYXxlu6aMGUMrOmJuILkHAQbBcsc+
         kbGpcdB80INpJGPPtZn9ClgPMGTGybA4njz58/ki69oj9tE/pvvKt32HpoV71GWoJJj/
         FoXzuzIJGVdzY72qxt0xfWQRGSUy6gavDTXg9D6CnE9pdDuL7ph1ymR+tmhumgprNLdd
         PUwc4ZL+wBLeu3eB0CRIRWq9jtdxGvysqoJiu5/OlBAsnuS7GMiPJc4OzLNH8AGGyXPF
         EIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiC5sioezYThLYcNpRbCsHhGZ0oRkD4r/9CE4cWwLvufxYiAOkpaGSMuTh8fQTH82zC/81rKELgwGkoj/mJbcYs819tIJhyBnwD5Bk
X-Gm-Message-State: AOJu0YxqjwovpTLea/T8ssnnIt36/7LNM36Fj/E9TqxyB4giT/GYHk0/
	+Q9/91PFr/hp26X4JXFkbfdIwJEXoqjtCLQNJg4xQgayv96WQnYgNRwhmfk2StMuxPbo2fSrLap
	/cTtbuYsHuNVp+ktyNAzfycaP4iWfG/eRffvVNXJ1SyN3PRyAgh6uLTs=
X-Google-Smtp-Source: AGHT+IGLDG+Dc0014dtU8+cIhp81ZKUWtv/7wQd5vaFrsMLyPtvkI6wgcg66uZWMynrXXfhRZfZa+0OQy8ad/+Cb/Og=
X-Received: by 2002:ac2:5d44:0:b0:518:baa1:381b with SMTP id
 w4-20020ac25d44000000b00518baa1381bmr46743lfd.50.1713471001029; Thu, 18 Apr
 2024 13:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
 <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
 <CAKEwX=NM1y-K1-Yw=CH3cM-8odER1PZBVoWo-rs7_OdjFG_puw@mail.gmail.com>
 <CAKEwX=MWPUf1NMGdn+1AkRdOUf25ifAbPyoP9zppPTx3U3Tv2Q@mail.gmail.com>
 <246c1f4d-af13-40fa-b968-fbaf36b8f91f@linux.dev> <20240417143324.GA1055428@cmpxchg.org>
 <4c3ppfjxnrqx6g52qvvhqzcc4pated2q5g4mi32l22nwtrkqfq@a4lk6s5zcwvb> <20240418124043.GC1055428@cmpxchg.org>
In-Reply-To: <20240418124043.GC1055428@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Apr 2024 13:09:22 -0700
Message-ID: <CAJD7tkaPMQqQtfxcLWraz-vnbAxZKxuJRJ7vKuDOCCXtpBSF1A@mail.gmail.com>
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Christian Heusel <christian@heusel.eu>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Seth Jennings <sjenning@redhat.com>, 
	Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>, 
	"Richard W.M. Jones" <rjones@redhat.com>, Mark W <instruform@gmail.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 5:40=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Apr 17, 2024 at 07:18:14PM +0200, Christian Heusel wrote:
> > On 24/04/17 10:33AM, Johannes Weiner wrote:
> > >
> > > Christian, can you please test the below patch on top of current
> > > upstream?
> > >
> >
> > Hey Johannes,
> >
> > I have applied your patch on top of 6.9-rc4 and it did solve the crash =
for
> > me, thanks for hacking together a fix so quickly! =F0=9F=A4=97
> >
> > Tested-By: Christian Heusel <christian@heusel.eu>
>
> Thanks for confirming it, and sorry about the breakage.
>
> Andrew, can you please use the updated changelog below?
>
> ---
>
> From 52f67f5fab6a743c2aedfc8e04a582a9d1025c28 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Thu, 18 Apr 2024 08:26:28 -0400
> Subject: [PATCH] mm: zswap: fix shrinker NULL crash with cgroup_disable=
=3Dmemory
>
> Christian reports a NULL deref in zswap that he bisected down to the
> zswap shrinker. The issue also cropped up in the bug trackers of
> libguestfs [1] and the Red Hat bugzilla [2].
>
> The problem is that when memcg is disabled with the boot time flag,
> the zswap shrinker might get called with sc->memcg =3D=3D NULL. This is
> okay in many places, like the lruvec operations. But it crashes in
> memcg_page_state() - which is only used due to the non-node accounting
> of cgroup's the zswap memory to begin with.
>
> Nhat spotted that the memcg can be NULL in the memcg-disabled case,
> and I was then able to reproduce the crash locally as well.
>
> [1] https://github.com/libguestfs/libguestfs/issues/139
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D2275252
>
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Cc: stable@vger.kernel.org      [v6.8]
> Link: https://lkml.kernel.org/r/20240417143324.GA1055428@cmpxchg.org
> Reported-by: Christian Heusel <christian@heusel.eu>
> Debugged-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Tested-By: Christian Heusel <christian@heusel.eu>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks for fixing this. A couple of comments/questions below, but anyway LG=
TM:

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index caed028945b0..6f8850c44b61 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1331,15 +1331,22 @@ static unsigned long zswap_shrinker_count(struct =
shrinker *shrinker,
>         if (!gfp_has_io_fs(sc->gfp_mask))
>                 return 0;
>
> -#ifdef CONFIG_MEMCG_KMEM
> -       mem_cgroup_flush_stats(memcg);
> -       nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHI=
FT;
> -       nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);
> -#else
> -       /* use pool stats instead of memcg stats */
> -       nr_backing =3D zswap_pool_total_size >> PAGE_SHIFT;
> -       nr_stored =3D atomic_read(&zswap_nr_stored);
> -#endif
> +       /*
> +        * For memcg, use the cgroup-wide ZSWAP stats since we don't
> +        * have them per-node and thus per-lruvec. Careful if memcg is
> +        * runtime-disabled: we can get sc->memcg =3D=3D NULL, which is o=
k
> +        * for the lruvec, but not for memcg_page_state().
> +        *
> +        * Without memcg, use the zswap pool-wide metrics.
> +        */
> +       if (!mem_cgroup_disabled()) {

With the current shrinker code, it seems like we cannot get sc->memcg
=3D=3D NULL unless mem_cgroup_disabled() is true indeed. However, maybe
it's better to check if sc->memcg is not NULL directly instead?

This would be more resilient in case the shrinker code changes and
passing sc->memcg =3D=3D NULL becomes possible in other cases (e.g. during
global shrinking). It seems like other shrinkers do this, for example
see count_shadow_nodes() and deferred_split_count().

I am also wondering if we should also check !mem_cgroup_is_root()
here? We can avoid the expensive global flush and use the global stats
directly in this case. I could also send a follow up patch for this if
that's preferred.

> +               mem_cgroup_flush_stats(memcg);
> +               nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> =
PAGE_SHIFT;
> +               nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);
> +       } else {
> +               nr_backing =3D zswap_pool_total_size >> PAGE_SHIFT;
> +               nr_stored =3D atomic_read(&zswap_nr_stored);
> +       }
>
>         if (!nr_stored)
>                 return 0;
> --
> 2.44.0

