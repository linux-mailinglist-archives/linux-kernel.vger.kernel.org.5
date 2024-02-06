Return-Path: <linux-kernel+bounces-55548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAD084BDFA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF642B238A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F114012;
	Tue,  6 Feb 2024 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ9O6z0o"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8787F13FF0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246915; cv=none; b=QmBqrk1I9R4LayODDi5rGBEAsa+euMpuEKeIsNk/P0TtLC554GYj0xvJu3Mt7GyKiictzhRHydalEX07T9iWbzfRdXIJhqIr3g6e3jJ88PipjWa9ArV6B1v+ic6eiagoOxnXIDgNRh8Us4a9WEJA979knuVG0ShhhSg+ee+V2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246915; c=relaxed/simple;
	bh=EKchfM0k0x9G+mP/tT4BFMnrvyBjteJPVzpfpdDc/ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKwtJLIph16ewQl8h7tazT0/mbpkvCOsxiA9xpcVvAXU7bT6L/QimysNp99m4SOiDTh95l3+gMpwYYaraVYR1YgvEnzQuPHmBGwlzy5/KKSImlT6gi3mOfw1AhHdOX0MKxQnqFUIaw73vnytI35kdw8bmC1A8y+ONRxxQmazxAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ9O6z0o; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso320665839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 11:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707246912; x=1707851712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wsz0Wlc4vOmHkQP1isB38YzA7dUn46KRxyW9pALPJs=;
        b=OJ9O6z0oZv95J0wxlDYHweHMPpDz6hhirvnnEby5d6ZrNEDbT0SG+HsT0+2IZvp0KQ
         UqYWL/evzdKuLqEqYdXq3Ipzz5bfVJeCHVS5SGHs9qDtEa6gu1EZTNx0fBtwkuTdFMfd
         ceANhUzmOi4PJLgX16isXmQAAH8Iezw676rENpKjWnEkThqN1Tnj0oyQTaIy30bLWY//
         AgpTcrkR9kdFCYnBK+RMfc5JkSVCM9qIjvaju/JavuTJ9miTGSkT7vruiE006m8KNdNA
         n/qUWKpiwsBZr3PD3vLARGRXHuVuAyyBoez8OCJHF3XiTKh17g/FUZbwBeOs9vYo9BDW
         l0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707246912; x=1707851712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wsz0Wlc4vOmHkQP1isB38YzA7dUn46KRxyW9pALPJs=;
        b=ioca2UqWG3eBynwJOUMrdO5WGBEnIDYBTwWnYev577hZp3XFMOZoK5zLZu5l/WVBqK
         wb9ylC1Nt36CsgkEM/mzcD5kxtRnEamCVwvcbN9gILIpXOSvSCAJJN1apbPYHDZ2J71p
         U9YJV+3Kj3zaaiT0vqJIid8R7Iy5q2KMl+pJ3scidpVSQSePTaRQ5EiN/pjsMAqD7Bky
         /JjeTyIQJmkODI8zR0ecKTo15IDPOoQhT5Se//ZHxSk53WBbJKx55qACgHA1x4F7ySzD
         Xj4B3xSm3EqHqlcqMqmsN6QY3pDd7E+yPGBHidgGs3VQmmhnJhMw5brxUINXoUJCKKRU
         tS9Q==
X-Gm-Message-State: AOJu0YzZAIoYd+c8MMkuX2XwN1rVfHV2uj99tJ/3GGemVM/oYPV0DC0h
	URaBRb3SDOeUaeSfuddkRfJZ6mE1eiSX1O6ygefPVHT4K9BW20TmpwgPA3iha10z5yMc+kPbP2r
	Fonvm3ErWr8cNCZcvsu1DhzzVDCw=
X-Google-Smtp-Source: AGHT+IHlB8CJJPWY88CqhoWUKjaAkgIVZp+aqU0RIbX9eCa1vXpYoHi02dOBWlBwM4d/o/7WyzuvduoXswrwtwDUP1Y=
X-Received: by 2002:a05:6e02:1d97:b0:363:b6cc:dd69 with SMTP id
 h23-20020a056e021d9700b00363b6ccdd69mr3765433ila.28.1707246912449; Tue, 06
 Feb 2024 11:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206180855.3987204-1-nphamcs@gmail.com> <20240206185145.GA97483@cmpxchg.org>
In-Reply-To: <20240206185145.GA97483@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 6 Feb 2024 11:15:01 -0800
Message-ID: <CAKEwX=Ok0CNjbvdhb6MYHKhgdfxMvOExNd=FtsTdrhfXbgrv7w@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap_state: update zswap LRU's protection range
 with the folio locked
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, yosryahmed@google.com, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 10:51=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Feb 06, 2024 at 10:08:55AM -0800, Nhat Pham wrote:
> > When a folio is swapped in, the protection size of the corresponding
> > zswap LRU is incremented, so that the zswap shrinker is more
> > conservative with its reclaiming action. This field is embedded within
> > the struct lruvec, so updating it requires looking up the folio's memcg
> > and lruvec. However, currently this lookup can happen after the folio i=
s
> > unlocked, for instance if a new folio is allocated, and
> > swap_read_folio() unlocks the folio before returning. In this scenario,
> > there is no stability guarantee for the binding between a folio and its
> > memcg and lruvec:
> >
> > * A folio's memcg and lruvec can be freed between the lookup and the
> >   update, leading to a UAF.
> > * Folio migration can clear the now-unlocked folio's memcg_data, which
> >   directs the zswap LRU protection size update towards the root memcg
> >   instead of the original memcg. This was recently picked up by the
> >   syzbot thanks to a warning in the inlined folio_lruvec() call.
> >
> > Move the zswap LRU protection range update above the swap_read_folio()
> > call, and only when a new page is allocated, to prevent this.
> >
> > Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/000000000000ae47f90610803260@google=
com/
> > Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure=
")
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> Looks great, thanks for updating it!
>
> One more thing I just realized:
>
> > ---
> >  mm/swap_state.c | 10 ++++++----
> >  mm/zswap.c      |  1 +
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index e671266ad772..7255c01a1e4e 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -680,9 +680,10 @@ struct folio *swap_cluster_readahead(swp_entry_t e=
ntry, gfp_t gfp_mask,
> >       /* The page was likely read above, so no need for plugging here *=
/
> >       folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
> >                                       &page_allocated, false);
> > -     if (unlikely(page_allocated))
> > +     if (unlikely(page_allocated)) {
> > +             zswap_folio_swapin(folio);
> >               swap_read_folio(folio, false, NULL);
> > -     zswap_folio_swapin(folio);
> > +     }
> >       return folio;
> >  }
> >
> > @@ -855,9 +856,10 @@ static struct folio *swap_vma_readahead(swp_entry_=
t targ_entry, gfp_t gfp_mask,
> >       /* The folio was likely read above, so no need for plugging here =
*/
> >       folio =3D __read_swap_cache_async(targ_entry, gfp_mask, mpol, tar=
g_ilx,
> >                                       &page_allocated, false);
> > -     if (unlikely(page_allocated))
> > +     if (unlikely(page_allocated)) {
> > +             zswap_folio_swapin(folio);
> >               swap_read_folio(folio, false, NULL);
> > -     zswap_folio_swapin(folio);
> > +     }
> >       return folio;
> >  }
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 4aea03285532..8c548f73d52e 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -827,6 +827,7 @@ void zswap_folio_swapin(struct folio *folio)
> >       struct lruvec *lruvec;
> >
> >       if (folio) {
> > +             VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >               lruvec =3D folio_lruvec(folio);
> >               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_prot=
ected);
> >       }
>
> The NULL check is now also no longer necessary.
>
> It used to be called unconditionally, even if
> __read_swap_cache_async() failed and returned NULL.
>
> However, page_allocated =3D=3D true implies success. That newly allocated
> and locked folio is always returned.

Ah yeah, I forgot the context of that :) Just sent a fixlet to do away
with the check. Thanks for picking that out!

