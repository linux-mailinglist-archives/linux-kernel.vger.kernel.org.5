Return-Path: <linux-kernel+bounces-123429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D9C89087C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF9A1F2561D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664D7136E35;
	Thu, 28 Mar 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsjNXZCK"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A67E115
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651567; cv=none; b=DmLvcTQfweOSPMSrrbAYpzU+7fzncrUZSHInetyWm5sdzrgSGga/JD9ya5XpIJxovsXpSKPmJNZnrdWzrIK2ETwVjC/7ZlJJKDF4PI6AYrLGdXNVdJVJE3bNDHvYsY3xCw00+ghSxMDt+kV5Sf+jxuB9lZegMZ74NwmggJjcNAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651567; c=relaxed/simple;
	bh=2QS9nWy46ErSbwzeO0koPNbRcWgxc75H7v7teYVPTc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBbkm9P3SITrs69TGGuMmbaEk2XV7wvI6jaVNMHud8CYkANC7bvYmuLGUI/8nX0dH/1vuJI2Nrbw766jrmjf9r2Y64qimLG1cGME4Y/l92xXD0hSzO8UMTvqVPrm6fSXNVRm9CZNmgobIdIAZyEOjv8Fd2l62M/KwPykBVwb8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fsjNXZCK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4e0e3ef357so178706666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711651564; x=1712256364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id1/BhFDfw+YMKndBIzO44ul9b3NoasO2NXD5GD17qU=;
        b=fsjNXZCKAVAI0SJmhWDUX10XT/gaBra4NeoClHZtRNgsZhr66OllZx8FVHCMpl/ypN
         WVnx/JKyeQ/U0wC2IeIS+m6fFoHPAKv1VO5uHmmzGql7GhlRfykWWDNl03QCV7ulQxQI
         B0QHFPPeDGEAjpn6WrcYzTytIwR8bEvISN9LfNZIa9Cdh+cPSqv8/8/4dw1TY5HNGnuc
         4wNyoYVyDgXGHyGI0vZ6iJHfjOMTvm7aX0UyijBNiid64022AGlZSmxZ9BmeyO0EOW2B
         SK3VYL8+6BnI5YoZKCirgA1X23860CtzAZ9dIIeKYRyzl3eXWZoLNo8HNVeAFi5OFbiz
         lBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651564; x=1712256364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id1/BhFDfw+YMKndBIzO44ul9b3NoasO2NXD5GD17qU=;
        b=Mt6Kh7w9n5UMJ9toZ6NNEGLMbpvXhf5jHT9xQzl3uYG9rt4OhNJPaZ7FiT+0RdwzLC
         QJ2994MjWcXANxZrL9MWx1qzqLM2S5zl7WMIHUMUjTfcgxan9oFkRzAVp0AJ0PMWOxvE
         rJ0QRHqe5D7jS4s3d2gXe2YeEWQYGSzZAk4COUuAkckS6aBeS8m9NL5viaZ3WYjv8vZU
         jKlAUyQWz+UxvvwMXcWYTYhKgD7gkTLDMnaMNTUKFi8pgHGuqk9C6I75K6cpA4KKKeX1
         tTOfHOaUlv11ZqHR70hwtXuGF4E7XcRNvoFHLoh6SNJFPvS+pHsO2ugLU0q6pNd0qINu
         n1ig==
X-Forwarded-Encrypted: i=1; AJvYcCVAtxkdHkg2OXVNkz2MhGaurSyoRXASbMa7OI99tT8rHkCfxtdlc82OlKStQ733zLrhvL+HaS0Zc/fD9AibJ0WxRKFUMFl3ui0WoYF3
X-Gm-Message-State: AOJu0Yya59x6cz4vvEFQfhHHLU8al7WXh0t78QeNlpdPgsVb7IT32Sox
	EUJxIvSsWtYeEYUYa6rz+dLiPkZUD2urFVqBtmccDx2CVVodyAmegAcMwXGI09LNQwFEwGa+T/y
	kumEVXxMRFLKnW19kqjnoGAONL6LhRwr0QnBy
X-Google-Smtp-Source: AGHT+IHryiPRPxQDrTg55XLq+V7QJeRsJ+yEGzh1/0zvgIomnS33RrLd0QVMtT+9vBzw9M4q56R1LAYW9+pLKYElaVM=
X-Received: by 2002:a17:907:7216:b0:a4e:14e6:2084 with SMTP id
 dr22-20020a170907721600b00a4e14e62084mr93370ejc.51.1711651564051; Thu, 28 Mar
 2024 11:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-8-yosryahmed@google.com> <098bfa48-75d5-45b5-b81d-a2a84b394352@linux.dev>
In-Reply-To: <098bfa48-75d5-45b5-b81d-a2a84b394352@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Mar 2024 11:45:26 -0700
Message-ID: <CAJD7tkbhK_BS03MfeM5br+5K2JwXayp9Tay71MqhJ4qdfocDMw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] mm: zswap: store zero-filled pages without a zswap_entry
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 1:12=E2=80=AFAM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/3/26 07:50, Yosry Ahmed wrote:
> > After the rbtree to xarray conversion, and dropping zswap_entry.refcoun=
t
> > and zswap_entry.value, the only members of zswap_entry utilized by
> > zero-filled pages are zswap_entry.length (always 0) and
> > zswap_entry.objcg. Store the objcg pointer directly in the xarray as a
> > tagged pointer and avoid allocating a zswap_entry completely for
> > zero-filled pages.
> >
> > This simplifies the code as we no longer need to special case
> > zero-length cases. We are also able to further separate the zero-filled
> > pages handling logic and completely isolate them within store/load
> > helpers.  Handling tagged xarray pointers is handled in these two
> > helpers, as well as the newly introduced helper for freeing tree
> > elements, zswap_tree_free_element().
> >
> > There is also a small performance improvement observed over 50 runs of
> > kernel build test (kernbench) comparing the mean build time on a skylak=
e
> > machine when building the kernel in a cgroup v1 container with a 3G
> > limit. This is on top of the improvement from dropping support for
> > non-zero same-filled pages:
> >
> >               base            patched         % diff
> > real            69.915          69.757                -0.229%
> > user            2956.147        2955.244      -0.031%
> > sys             2594.718        2575.747      -0.731%
> >
> > This probably comes from avoiding the zswap_entry allocation and
> > cleanup/freeing for zero-filled pages. Note that the percentage of
> > zero-filled pages during this test was only around 1.5% on average.
> > Practical workloads could have a larger proportion of such pages (e.g.
> > Johannes observed around 10% [1]), so the performance improvement shoul=
d
> > be larger.
> >
> > This change also saves a small amount of memory due to less allocated
> > zswap_entry's. In the kernel build test above, we save around 2M of
> > slab usage when we swap out 3G to zswap.
> >
> > [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org=
/
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> The code looks good, just one comment below.
>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

>
> > ---
> >  mm/zswap.c | 137 ++++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 78 insertions(+), 59 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 413d9242cf500..efc323bab2f22 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -183,12 +183,11 @@ static struct shrinker *zswap_shrinker;
> >   * struct zswap_entry
> >   *
> [..]
> >
> > @@ -1531,26 +1552,27 @@ bool zswap_load(struct folio *folio)
> >       struct page *page =3D &folio->page;
> >       struct xarray *tree =3D swap_zswap_tree(swp);
> >       struct zswap_entry *entry;
> > +     struct obj_cgroup *objcg;
> > +     void *elem;
> >
> >       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >
> > -     entry =3D xa_erase(tree, offset);
> > -     if (!entry)
> > +     elem =3D xa_erase(tree, offset);
> > +     if (!elem)
> >               return false;
> >
> > -     if (entry->length)
> > +     if (!zswap_load_zero_filled(elem, page, &objcg)) {
> > +             entry =3D elem;
>
> nit: entry seems no use anymore.

I left it here on purpose to avoid casting elem in the next two lines,
it is just more aesthetic.

>
> > +             objcg =3D entry->objcg;
> >               zswap_decompress(entry, page);
> > -     else
> > -             clear_highpage(page);
> > +     }
> >
> >       count_vm_event(ZSWPIN);
> > -     if (entry->objcg)
> > -             count_objcg_event(entry->objcg, ZSWPIN);
> > -
> > -     zswap_entry_free(entry);
> > +     if (objcg)
> > +             count_objcg_event(objcg, ZSWPIN);
> >
> > +     zswap_tree_free_element(elem);
> >       folio_mark_dirty(folio);
> > -
> >       return true;
> >  }
> [..]

