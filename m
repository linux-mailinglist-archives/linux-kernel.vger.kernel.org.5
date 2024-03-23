Return-Path: <linux-kernel+bounces-112174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC1388768E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EA7283E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A003E1113;
	Sat, 23 Mar 2024 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04mMOXfF"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAFA31
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711159394; cv=none; b=Q6tzX3nEBNi7BM8uXDCKHT+2z6LLDPn9d2f3EV0OMEFuLRr/3/TMrm1hDXVcrDMRVIJ8d0mFJwApWFFDKGn0mUFHBwZa2opiECbpPoIHX4wLgsYWXxPqWRwLdmmsowfAnWx3Ei1HuEBnLZSIt5g05i7aOdrqx6jZejYxBg6LSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711159394; c=relaxed/simple;
	bh=PettcqWlhbLkUH15Mgj0z7O32KlctYX/2zcO3X/L0+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxQy321DHqHAmmipJVFVjR7+lrSyBDehk2jQ9OM1tN+sX8jkNBiq4lksiuyy6IWy3Er6274FNovocGUY4UO/U72rlzsQ12fq0ODsipMucvww19me0G4AcHr6TUpa79kyeoDA99MgOJvumF0RzDXpfFnCySLKUR6LZ6xgBBiJZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=04mMOXfF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a47062136c0so339617666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711159391; x=1711764191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoB0K5WRFoGSmH+ex0ygkzLKqvVpzKWZj9b/agl7fXE=;
        b=04mMOXfFsIiCMQsEgvj34xVpT0psXc9T9kwUGGLT+KdybhexA6Gqlc7HCPkmmSoh7R
         OrUvaM9He0bmkJy0XcbdcSkE8XXhUfX8ViZaKXq4IUdooyOPBL4nbD1wtk4TusNlwEcj
         +oaiyHPIyatN8wegtdixEK9QSvi5RSPOvF8DqlBbJ4aSTkvT9FgDCQZV1Qa23IqtI9j1
         UiDmGIAZvLoYIzX0Up1zTqGZVasLT+ktAUckYPj+fCqbrFVq5Q7EBxT/VekOCj2/7vjb
         QOGT/t5PyFI07e53ePxlN2UhMMqm9x55h7UAWxKOsagP2G9sh9Nqsz4HaMTKb8MsXWDm
         QZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711159391; x=1711764191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoB0K5WRFoGSmH+ex0ygkzLKqvVpzKWZj9b/agl7fXE=;
        b=BaiLcviKrMTBQoDAvMHbNYpeuEScsJTiSLnb14orduY1YlDNskX9KwRUund78Fy529
         rWLCpITUbZv7i3O7i5PwApR3Bz3qTWGQNbeM7Kbq7ZlNBlP5R5vKsXyGXqf2z+wzAFkj
         bwcXzTjvTbspBCRSnfxEAizIEimWMRBGrQ2Am0FmfZKud41lSVygtxqtx4MwbWpn4Mar
         5J7naFGmOgSwQvPvTrv4fzW3yXRTz05fnc9HcG0C1brWO59CXV+/Ty/GTtJh1kENgwAh
         yEwW5HzzJNVXRBJAg7rZfJVlz5ojQp+lpp3GJr7ZhxmwpmTc5NURRr8knZ1//lvp50HG
         A8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWHR4/hQCZfFtzDI8KSstYwWbiKvdMWsjhIqmdo9NuEnoOwxDWHmCBFu6ccH826iia/ZeiIR9D3kUd74BMchNXH/dsfUWnWDtp+HD/h
X-Gm-Message-State: AOJu0YywO9D0aCZD4F2epQYtLd37a6QI0/pncVzDCZlcNnBoGn7rKmAV
	6hH14rdRvk9nt0zy+HvQZ0GCIyJhp845O17Rxt2ARGBSG52IYe05gichGV91n9THNScB2CTF1Rq
	Zi+HpgaK9N53TRRS283kxkR33z3gQrnq4fd9r
X-Google-Smtp-Source: AGHT+IHyypD8b8GJHGjP/pBrCz9FExVb/Ctv2KcYhB73bzJ/Uj6b8xtxInJB4aZ9YcjO4SyK4oq3NjSp7+9IJ/aoJwU=
X-Received: by 2002:a17:906:2846:b0:a46:954a:aa14 with SMTP id
 s6-20020a170906284600b00a46954aaa14mr946344ejc.67.1711159391127; Fri, 22 Mar
 2024 19:03:11 -0700 (PDT)
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
 <CAJD7tkZqrrXuYTMYOAP+arMLeNayafFeLocWu7bJtDFHCYjwDA@mail.gmail.com> <20240323015543.GB448621@cmpxchg.org>
In-Reply-To: <20240323015543.GB448621@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 22 Mar 2024 19:02:35 -0700
Message-ID: <CAJD7tkYDh39_Pp-_TFFvduGbirx0MTRpC3p+Z6NuY14xtXiOYA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: add folio in swapcache if swapin from zswap
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <21cnbao@gmail.com>, chengming.zhou@linux.dev, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 6:55=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Mar 22, 2024 at 05:14:37PM -0700, Yosry Ahmed wrote:
> > [..]
> > > > > I don't think we want to stop doing exclusive loads in zswap due =
to this
> > > > > interaction with zram, which shouldn't be common.
> > > > >
> > > > > I think we can solve this by just writing the folio back to zswap=
 upon
> > > > > failure as I mentioned.
> > > >
> > > > Instead of storing again, can we avoid invalidating the entry in th=
e
> > > > first place if the load is not "exclusive"?
> > > >
> > > > The reason for exclusive loads is that the ownership is transferred=
 to
> > > > the swapcache, so there is no point in keeping our copy. With an
> > > > optimistic read that doesn't transfer ownership, this doesn't
> > > > apply. And we can easily tell inside zswap_load() if we're dealing
> > > > with a swapcache read or not by testing the folio.
> > > >
> > > > The synchronous read already has to pin the swp_entry_t to be safe,
> > > > using swapcache_prepare(). That blocks __read_swap_cache_async() wh=
ich
> > > > means no other (exclusive) loads and no invalidates can occur.
> > > >
> > > > The zswap entry is freed during the regular swap_free() path, which
> > > > the sync fault calls on success. Otherwise we keep it.
> > >
> > > I thought about this, but I was particularly worried about the need t=
o
> > > bring back the refcount that was removed when we switched to only
> > > supporting exclusive loads:
> > > https://lore.kernel.org/lkml/20240201-b4-zswap-invalidate-entry-v2-6-=
99d4084260a0@bytedance.com/
> > >
> > > It seems to be that we don't need it, because swap_free() will free
> > > the entry as you mentioned before anyone else has the chance to load
> > > it or invalidate it. Writeback used to grab a reference as well, but
> > > it removes the entry from the tree anyway and takes full ownership of
> > > it then frees it, so that should be okay.
> > >
> > > It makes me nervous though to be honest. For example, not long ago
> > > swap_free() didn't call zswap_invalidate() directly (used to happen t=
o
> > > swap slots cache draining). Without it, a subsequent load could race
> > > with writeback without refcount protection, right? We would need to
> > > make sure to backport 0827a1fb143f ("mm/zswap: invalidate zswap entry
> > > when swap entry free") with the fix to stable for instance.
> > >
> > > I can't find a problem with your diff, but it just makes me nervous t=
o
> > > have non-exclusive loads without a refcount.
> > >
> > > >
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index 535c907345e0..686364a6dd86 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
> > > >         swp_entry_t swp =3D folio->swap;
> > > >         pgoff_t offset =3D swp_offset(swp);
> > > >         struct page *page =3D &folio->page;
> > > > +       bool swapcache =3D folio_test_swapcache(folio);
> > > >         struct zswap_tree *tree =3D swap_zswap_tree(swp);
> > > >         struct zswap_entry *entry;
> > > >         u8 *dst;
> > > > @@ -1634,7 +1635,8 @@ bool zswap_load(struct folio *folio)
> > > >                 spin_unlock(&tree->lock);
> > > >                 return false;
> > > >         }
> > > > -       zswap_rb_erase(&tree->rbroot, entry);
> > > > +       if (swapcache)
> > > > +               zswap_rb_erase(&tree->rbroot, entry);
> >
> > On second thought, if we don't remove the entry from the tree here,
> > writeback could free the entry from under us after we drop the lock
> > here, right?
>
> The sync-swapin does swapcache_prepare() and holds SWAP_HAS_CACHE, so
> racing writeback would loop on the -EEXIST in __read_swap_cache_async().
> (Or, if writeback wins the race, sync-swapin fails on swapcache_prepare()
> instead and bails on the fault.)
>
> This isn't coincidental. The sync-swapin needs to, and does, serialize
> against the swap entry moving into swapcache or being invalidated for
> it to be safe. Which is the same requirement that zswap ops have.

You are right. Even if swap_free() isn't called under SWAP_HAS_CACHE's
protection, a subsequent load will also be protected by SWAP_HAS_CACHE
(whether it's swapped in with sync swapin or throught the swapcache)
-- so it would be protected against writeback as well. Now it seems
like we may have been able to drop the refcount even without exclusive
loads..?

Anyway, I think your fix is sound. Zhongkun, do you mind confirming
that the diff Johannes sent fixes the problem for you?

