Return-Path: <linux-kernel+bounces-151893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078818AB56D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F8E1C21024
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5713BAFF;
	Fri, 19 Apr 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KG/p4V86"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90CA7494
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713553842; cv=none; b=TKPW+KCP0EpX5lomHVwwigkWFG9gNiej88ncVeNGRkpIKQNMglAR3rejcW9XzBVSNFuJTO2rBB8wEkwnFj25XsecrexcO5A5+nc8f/j+0TTip7L02ZdBXWFpLCKl2WeoF97r0eI8qTaqCzAYMtWlQPwGxSjVd6+a32Y1OKPHWRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713553842; c=relaxed/simple;
	bh=9nJp5X126w3GqvaWjUP/ZvbDKdqWMmW3+cyfWUwopzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiAMyYmm6ZfEyssordt+8g8nnGCQcEABSIEHWj51D/lW/J5tQAwM7sr22Sg9EVZ77ha2R5r7gMdwEsFHow6Eknh6abYQPZtkzZCXCNJ3zCDvOsjBJwajP1QxcGHMA15n4w6W4QU5+TLc4pHqvkUlGrBLAbBP7/gZYfA0kCPw5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KG/p4V86; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a558f2ea763so65964366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713553838; x=1714158638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJFtcGdhGKjEBBpWXj+iy28DWazemVM0Sr/i5zcF/Xc=;
        b=KG/p4V86DIsRVTS6cNE+N2hfl8t8udwQiEtE95wk/jkcXiwQ9DZBZV6/cY9lGF9i/F
         /9j5qfxLrXI777f2G6UscvTcyRIXKYB9ztAE/UBt5OUJQNzWngNoWXL51LO/l90mrZbO
         wECso0c+EtEqw7N4bFvfLeEFjemQtDkHiD1NpML7lcN3PsWJSYnqxdBK23eD1mKei6Uu
         wTnqg4SLbAhpbyxBRIvC8HdLuYX+gahKGDhRZugBGc8UoC+0E7fxSyWg3/q5zsFQVLt7
         kv/j9aZnDy5Rte3VdDoAy5e/Y0amF5PBzWhW0XIosPr/K73g64rB/esHeSDgEpvRnQz0
         Wf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713553838; x=1714158638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJFtcGdhGKjEBBpWXj+iy28DWazemVM0Sr/i5zcF/Xc=;
        b=dUOcqauiwsHAXr8koKct9VYgj4NMXBPHrPB7SSQcnz48n9BC1C0dUHUpIUsfNA42go
         q+MNtyeaODax78mvGZRqQWtkki9CDv/pKZUvwUsz9YfRR5blhUZ19JtrMPV7IklYhSNL
         Miy62g6dPQgrEG6eFYfVzdp4Z1ynp9xfrnxnDrXY/zroiXeGEoW2LXQDQuwmU93lRYZn
         e9YCByZhnxZk6htGJ2wXIDQ/QRW/zomXwaJkRlCrDbvyQZEPkLzqPuSZqAnBFAJOhcW2
         RAtsXW1pkoGLPQFMMDM8IlwEnJqiUaDIiK6yO3H+f4DsEIMhsv+EH2xWDrwAA9z3dTc5
         G41Q==
X-Forwarded-Encrypted: i=1; AJvYcCVh1qRD5c2FjDTqkq+Zgb+v0eDm5a7dVMoCtBMu3IZGiqs52PTii10+7SHfCE8GMXzFLcQVZAd651FH6AWi1jp8CNdJE8QPz0iMqPfI
X-Gm-Message-State: AOJu0YwgE5U9LoG0C0XIITadElEkj4i5UQaaZwbauMsfIuEBp/Bg91J3
	RUvsi9RBIi5rQOqWmFQbHkKzGMwDNbTEQHY3nCiWH+EdpWkb3eJBkq8TWEDpsYatOpgIlWph06o
	aCEx9ICeQ63ScURwsuTAyNxKm051KSknSrqQG
X-Google-Smtp-Source: AGHT+IExSU2QtTRid0+YRFdGQUwOihOm+cSrHE8ZuZNDhhMB/hnR+BAgCzxr8bHrjtAfhnlbAyR5OdrGT+33PVZSQFc=
X-Received: by 2002:a17:907:2d25:b0:a55:358f:783c with SMTP id
 gs37-20020a1709072d2500b00a55358f783cmr2276033ejc.24.1713553837773; Fri, 19
 Apr 2024 12:10:37 -0700 (PDT)
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
 <4c3ppfjxnrqx6g52qvvhqzcc4pated2q5g4mi32l22nwtrkqfq@a4lk6s5zcwvb>
 <20240418124043.GC1055428@cmpxchg.org> <CAJD7tkaPMQqQtfxcLWraz-vnbAxZKxuJRJ7vKuDOCCXtpBSF1A@mail.gmail.com>
 <20240419142231.GD1055428@cmpxchg.org>
In-Reply-To: <20240419142231.GD1055428@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Apr 2024 12:10:01 -0700
Message-ID: <CAJD7tkYOwO-LLrboSfz-wLJC+FD+ctaJ2KuZoUfiL6S3t0y7ow@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 7:22=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Apr 18, 2024 at 01:09:22PM -0700, Yosry Ahmed wrote:
> > On Thu, Apr 18, 2024 at 5:40=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
org> wrote:
> > >
> > > On Wed, Apr 17, 2024 at 07:18:14PM +0200, Christian Heusel wrote:
> > > > On 24/04/17 10:33AM, Johannes Weiner wrote:
> > > > >
> > > > > Christian, can you please test the below patch on top of current
> > > > > upstream?
> > > > >
> > > >
> > > > Hey Johannes,
> > > >
> > > > I have applied your patch on top of 6.9-rc4 and it did solve the cr=
ash for
> > > > me, thanks for hacking together a fix so quickly! =F0=9F=A4=97
> > > >
> > > > Tested-By: Christian Heusel <christian@heusel.eu>
> > >
> > > Thanks for confirming it, and sorry about the breakage.
> > >
> > > Andrew, can you please use the updated changelog below?
> > >
> > > ---
> > >
> > > From 52f67f5fab6a743c2aedfc8e04a582a9d1025c28 Mon Sep 17 00:00:00 200=
1
> > > From: Johannes Weiner <hannes@cmpxchg.org>
> > > Date: Thu, 18 Apr 2024 08:26:28 -0400
> > > Subject: [PATCH] mm: zswap: fix shrinker NULL crash with cgroup_disab=
le=3Dmemory
> > >
> > > Christian reports a NULL deref in zswap that he bisected down to the
> > > zswap shrinker. The issue also cropped up in the bug trackers of
> > > libguestfs [1] and the Red Hat bugzilla [2].
> > >
> > > The problem is that when memcg is disabled with the boot time flag,
> > > the zswap shrinker might get called with sc->memcg =3D=3D NULL. This =
is
> > > okay in many places, like the lruvec operations. But it crashes in
> > > memcg_page_state() - which is only used due to the non-node accountin=
g
> > > of cgroup's the zswap memory to begin with.
> > >
> > > Nhat spotted that the memcg can be NULL in the memcg-disabled case,
> > > and I was then able to reproduce the crash locally as well.
> > >
> > > [1] https://github.com/libguestfs/libguestfs/issues/139
> > > [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D2275252
> > >
> > > Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressu=
re")
> > > Cc: stable@vger.kernel.org      [v6.8]
> > > Link: https://lkml.kernel.org/r/20240417143324.GA1055428@cmpxchg.org
> > > Reported-by: Christian Heusel <christian@heusel.eu>
> > > Debugged-by: Nhat Pham <nphamcs@gmail.com>
> > > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > > Tested-By: Christian Heusel <christian@heusel.eu>
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Thanks for fixing this. A couple of comments/questions below, but anywa=
y LGTM:
> >
> > Acked-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > > ---
> > >  mm/zswap.c | 25 ++++++++++++++++---------
> > >  1 file changed, 16 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index caed028945b0..6f8850c44b61 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1331,15 +1331,22 @@ static unsigned long zswap_shrinker_count(str=
uct shrinker *shrinker,
> > >         if (!gfp_has_io_fs(sc->gfp_mask))
> > >                 return 0;
> > >
> > > -#ifdef CONFIG_MEMCG_KMEM
> > > -       mem_cgroup_flush_stats(memcg);
> > > -       nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE=
_SHIFT;
> > > -       nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);
> > > -#else
> > > -       /* use pool stats instead of memcg stats */
> > > -       nr_backing =3D zswap_pool_total_size >> PAGE_SHIFT;
> > > -       nr_stored =3D atomic_read(&zswap_nr_stored);
> > > -#endif
> > > +       /*
> > > +        * For memcg, use the cgroup-wide ZSWAP stats since we don't
> > > +        * have them per-node and thus per-lruvec. Careful if memcg i=
s
> > > +        * runtime-disabled: we can get sc->memcg =3D=3D NULL, which =
is ok
> > > +        * for the lruvec, but not for memcg_page_state().
> > > +        *
> > > +        * Without memcg, use the zswap pool-wide metrics.
> > > +        */
> > > +       if (!mem_cgroup_disabled()) {
> >
> > With the current shrinker code, it seems like we cannot get sc->memcg
> > =3D=3D NULL unless mem_cgroup_disabled() is true indeed. However, maybe
> > it's better to check if sc->memcg is not NULL directly instead?
> >
> > This would be more resilient in case the shrinker code changes and
> > passing sc->memcg =3D=3D NULL becomes possible in other cases (e.g. dur=
ing
> > global shrinking). It seems like other shrinkers do this, for example
> > see count_shadow_nodes() and deferred_split_count().
>
> Eh, I'm not sure it's better or worse, so it's a bit hard to care. We
> shouldn't get NULL here when memcg is enabled, and if somebody
> introduces that bug it's better to catch it early than run into subtle
> priority inversions when the kernel is deployed to millions of hosts.

No strong opinion here, I just thought consistency with other
shrinkers would be nice.

>
> > I am also wondering if we should also check !mem_cgroup_is_root()
> > here? We can avoid the expensive global flush and use the global stats
> > directly in this case. I could also send a follow up patch for this if
> > that's preferred.
>
> I'd rather not proliferate more memcg internals in this code. If this
> is a concern, optimizing it in the flush and stat functions would make
> more sense. Reclaim already flushes the subtree before getting here,
> so odds are good this is a no-op in most cases.

I agree that with per-memcg thresholding, it is very unlikely that
this flush does anything.

FWIW, if it turns out to be a problem, optimizing it in the flush
functions would not be as straightforward, because the memcg code is
not aware that zswap has up-to-date global versions of the stats.

Anyway, let's table this until someone actually complains, just seemed
to me like a low hanging fruit.

