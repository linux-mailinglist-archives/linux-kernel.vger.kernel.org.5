Return-Path: <linux-kernel+bounces-112189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC018876B6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61AEAB22551
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D19137E;
	Sat, 23 Mar 2024 02:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bDR22eLV"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BD2372
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711161657; cv=none; b=mbNkb1/+rCKOOvPI7U3KxTgTehxXemGvA4Pquo6OPCD+ORromsVFLFaVVGIzPFYVPQRnWid9QYWqQm8wDWAt0XWi3MeNgYYxykKA/+cjH1zTxdMAqW4A4e7r3PC/fzexEZ1fWgruRyqbVQsgQMmmObYaynUPvARKoFuxbzHLJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711161657; c=relaxed/simple;
	bh=uFP153Q5zmrb80cYlL0vZaMRUeDucvJmZ/hwtBqIa4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbLKugTChjSdIWvNlxEly0nAVQE1WSnFvAbnaHI/jaXPgLBBi/gsj/Gpf0f/HIMImdtwMe+CldvufH2TW81pUKDJSGEtC85aq2MluOSx+K8Z4FWNWmWUZkLY1lbnnq1E6eDPo+7icRCr4q8bkduSF+wTZWH4EU3NhA7v81KoWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bDR22eLV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d48ba4d5ecso34131171fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711161653; x=1711766453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubB5GX00NOgOmV4nuWF8+vu4MS8DTronHMCNxhdTyUg=;
        b=bDR22eLVuz9F7vlR0i95/iNdGHVE4Jq2iDkwWiqPEV167QkNeC6ylefrBqVm1rcFz8
         iPNlG/EWb2p0E3Iir1Sy3objM90X5A4XS73RRoaoKJlT7JjGWKLSImT7llIDtFRBu+xo
         M45aSy5rYR7dSRIJCxVB+JUbq8q9XDp1xzJHHGEeOPFpEAvUpHbQzYB4tuyXJ2YWhdK/
         bUh00MEarrnNoqtFFCeTRhUttRhAJqo9CeyxFs9ybYQXGUm/G+KNJ0eNuTYwmamu6fmk
         mYADBFXE66aNs+5z50UpuKQQkFNqhqE2Yc1dASbngm03ZXceBgsMyfbzaH7QaVQdKkei
         ql2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711161653; x=1711766453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubB5GX00NOgOmV4nuWF8+vu4MS8DTronHMCNxhdTyUg=;
        b=jL+HUY2gHNhEay7reT8u8z/cqBbPlhhXwHcMfzi3lMUgJFWS5qoveWUR7VKGB+HcXx
         SCNp8k/PQyXa45HgfDb3C9Jk15GwMtzZCiai/0nt+JPinmB4h91UfM6SKkcd/IH1e0q2
         wC3PxCfu7IeJijiDD9W0q9IWgJx0gP9mOQJpMxUY9FvpzYkh0SgH5IE2WUQDVHVM9A2o
         OFxDUJBSqH2pgqdks4PFRbLcSxwyaWoj37AQBLj4q//yCCglvKNNd4je0iABPaWhtdTU
         IM02LBeymZmmWzt5DlLHPNNks4/t17TJuAl296DztMNFuap9ZOHSYHrFqDYKDN8MuFqx
         EYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm9/bYvpqozQnY6rphtq4vR3cZWj+Vw82ZxVdrAEUQkA26Rl3wi3hRhDXYnXylJJ0ykxHqBI6pwbj3WGFFhd+Byi0Dbzh8zsFmvw1k
X-Gm-Message-State: AOJu0YwFvXarIJIfpEiXbc5o+qqjNCDzBB0kKQ/wNiXEQzeDbMTAokm9
	Dpgd4LvYCE/K8cJufOjvw5vm1K+13fUMP+7CLGsJ2FiVZpUbrpgaT/zxtRFE8NggJjp4tZttHJh
	XGovJHSX1/WHaIoMuCdl1jUPOMSLhdRDGFerToA==
X-Google-Smtp-Source: AGHT+IFFT6p2ImBUNbS0EynuAT9cROXdyN5l4NtKq00juO1PxjAfU6zQEBsUh/9zRUXPNFb3knrnkinHt5kXsOlgy54=
X-Received: by 2002:a19:6919:0:b0:513:a2d0:28c7 with SMTP id
 e25-20020a196919000000b00513a2d028c7mr201586lfc.16.1711161652556; Fri, 22 Mar
 2024 19:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322163939.17846-1-chengming.zhou@linux.dev>
 <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com>
 <CAGsJ_4yc-XB3+FkcZTy1aZ0n6ZKEkfWVYk_TjqqrdcROa5VYtA@mail.gmail.com>
 <Zf4HKUpKpDWZygni@google.com> <20240322234826.GA448621@cmpxchg.org>
 <CAJD7tkY2y_nGRq9ft80op6q0B3tfJvtyqYhS6t+x=TpyGy+AXg@mail.gmail.com>
 <CAJD7tkZqrrXuYTMYOAP+arMLeNayafFeLocWu7bJtDFHCYjwDA@mail.gmail.com>
 <20240323015543.GB448621@cmpxchg.org> <CAJD7tkYDh39_Pp-_TFFvduGbirx0MTRpC3p+Z6NuY14xtXiOYA@mail.gmail.com>
In-Reply-To: <CAJD7tkYDh39_Pp-_TFFvduGbirx0MTRpC3p+Z6NuY14xtXiOYA@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Sat, 23 Mar 2024 10:40:38 +0800
Message-ID: <CACSyD1P2GNmfhU4jghqEnrHi-9kHjLMJM_j_kxcQ=fsEgg7cwA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] mm: add folio in swapcache if swapin
 from zswap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>, chengming.zhou@linux.dev, 
	nphamcs@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 10:03=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Fri, Mar 22, 2024 at 6:55=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Fri, Mar 22, 2024 at 05:14:37PM -0700, Yosry Ahmed wrote:
> > > [..]
> > > > > > I don't think we want to stop doing exclusive loads in zswap du=
e to this
> > > > > > interaction with zram, which shouldn't be common.
> > > > > >
> > > > > > I think we can solve this by just writing the folio back to zsw=
ap upon
> > > > > > failure as I mentioned.
> > > > >
> > > > > Instead of storing again, can we avoid invalidating the entry in =
the
> > > > > first place if the load is not "exclusive"?
> > > > >
> > > > > The reason for exclusive loads is that the ownership is transferr=
ed to
> > > > > the swapcache, so there is no point in keeping our copy. With an
> > > > > optimistic read that doesn't transfer ownership, this doesn't
> > > > > apply. And we can easily tell inside zswap_load() if we're dealin=
g
> > > > > with a swapcache read or not by testing the folio.
> > > > >
> > > > > The synchronous read already has to pin the swp_entry_t to be saf=
e,
> > > > > using swapcache_prepare(). That blocks __read_swap_cache_async() =
which
> > > > > means no other (exclusive) loads and no invalidates can occur.
> > > > >
> > > > > The zswap entry is freed during the regular swap_free() path, whi=
ch
> > > > > the sync fault calls on success. Otherwise we keep it.
> > > >
> > > > I thought about this, but I was particularly worried about the need=
 to
> > > > bring back the refcount that was removed when we switched to only
> > > > supporting exclusive loads:
> > > > https://lore.kernel.org/lkml/20240201-b4-zswap-invalidate-entry-v2-=
6-99d4084260a0@bytedance.com/
> > > >
> > > > It seems to be that we don't need it, because swap_free() will free
> > > > the entry as you mentioned before anyone else has the chance to loa=
d
> > > > it or invalidate it. Writeback used to grab a reference as well, bu=
t
> > > > it removes the entry from the tree anyway and takes full ownership =
of
> > > > it then frees it, so that should be okay.
> > > >
> > > > It makes me nervous though to be honest. For example, not long ago
> > > > swap_free() didn't call zswap_invalidate() directly (used to happen=
 to
> > > > swap slots cache draining). Without it, a subsequent load could rac=
e
> > > > with writeback without refcount protection, right? We would need to
> > > > make sure to backport 0827a1fb143f ("mm/zswap: invalidate zswap ent=
ry
> > > > when swap entry free") with the fix to stable for instance.
> > > >
> > > > I can't find a problem with your diff, but it just makes me nervous=
 to
> > > > have non-exclusive loads without a refcount.
> > > >
> > > > >
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index 535c907345e0..686364a6dd86 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
> > > > >         swp_entry_t swp =3D folio->swap;
> > > > >         pgoff_t offset =3D swp_offset(swp);
> > > > >         struct page *page =3D &folio->page;
> > > > > +       bool swapcache =3D folio_test_swapcache(folio);
> > > > >         struct zswap_tree *tree =3D swap_zswap_tree(swp);
> > > > >         struct zswap_entry *entry;
> > > > >         u8 *dst;
> > > > > @@ -1634,7 +1635,8 @@ bool zswap_load(struct folio *folio)
> > > > >                 spin_unlock(&tree->lock);
> > > > >                 return false;
> > > > >         }
> > > > > -       zswap_rb_erase(&tree->rbroot, entry);
> > > > > +       if (swapcache)
> > > > > +               zswap_rb_erase(&tree->rbroot, entry);
> > >
> > > On second thought, if we don't remove the entry from the tree here,
> > > writeback could free the entry from under us after we drop the lock
> > > here, right?
> >
> > The sync-swapin does swapcache_prepare() and holds SWAP_HAS_CACHE, so
> > racing writeback would loop on the -EEXIST in __read_swap_cache_async()=
.
> > (Or, if writeback wins the race, sync-swapin fails on swapcache_prepare=
()
> > instead and bails on the fault.)
> >
> > This isn't coincidental. The sync-swapin needs to, and does, serialize
> > against the swap entry moving into swapcache or being invalidated for
> > it to be safe. Which is the same requirement that zswap ops have.
>
> You are right. Even if swap_free() isn't called under SWAP_HAS_CACHE's
> protection, a subsequent load will also be protected by SWAP_HAS_CACHE
> (whether it's swapped in with sync swapin or throught the swapcache)
> -- so it would be protected against writeback as well. Now it seems
> like we may have been able to drop the refcount even without exclusive
> loads..?
>
> Anyway, I think your fix is sound. Zhongkun, do you mind confirming
> that the diff Johannes sent fixes the problem for you?

OK=EF=BC=8C I will try it and come back in a few hours.

Thanks for the solution, it sounds great.

