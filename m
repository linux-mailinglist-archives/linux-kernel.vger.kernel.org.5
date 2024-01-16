Return-Path: <linux-kernel+bounces-27424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D142082EFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D10285380
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B41BDCA;
	Tue, 16 Jan 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TC/OfzrQ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261CE1BC5C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50eac018059so12468465e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705412417; x=1706017217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVJU5jiTzPEUoyMMg2QyayUMBhCdBnwfYp2MyeRq/z0=;
        b=TC/OfzrQGpqyBds6YEW4Q2fwGt+K64YQTxnNf3nHVxbyBgFU9X6NAvUTE+hqs9cVH2
         1KiaEZssEWzWjrGXM3xI2C05N2Gi4A436LYmzHYUJBlbLzhzMINPKXnWrI/CGz0Zu5nG
         iEDd8Jc1q/YWBYr+CNsuMdY4U+ZqeUheZjVqlHA4OMI/UgVF5yN4nCPHBt2mQ9upkdgb
         KQwY1M7VBSSuKJ6YQ7V1byvGpAlLDOF5L/GGlWKxiU0lOZb3g7CI6MeE+ZxPRciTJwx5
         bRO1jXZkw+UX5EtOuZh3+DsK6NBPGaXbsF3ZBIY0KzhM0ltvn38Q34gf/ep0kHWGg7Ze
         kZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705412417; x=1706017217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVJU5jiTzPEUoyMMg2QyayUMBhCdBnwfYp2MyeRq/z0=;
        b=sh4mu+StqfJKFtkStNY7NhO6dRPJPi3RFYIMIU2X22gXPBQwDOdn0pWjisr8i1kdgY
         eut95QPLgK6V1v7XKclcVxmCj2bfpG5Q6QfYe/poZA7tzBmIQ3eAGrtSGbdq8AoP3kBJ
         aVIriwSE2TnI1n31Sd/54mrpui4a+NYBWN5Zg0jhNRWEIrZw/YyMODa6bNyhuui4/I9f
         QAtPHj6oBRMPZlXtIp9+mihbYwfDz4WrndtPO9N/5VCa1cAhhu6kL3CA1Ek1o/xGIWA4
         jvPe4OfqKfGdlEgr/ESKEKg7dcCjebU5cVUNe9/XptqxgzfqeSK7Bmvzg+0JR0BHl+qd
         RS9w==
X-Gm-Message-State: AOJu0YzSpapPeDlSFcQnE0ugqjBzAOxRDVCFpgEP+j/aMRGRBoDYBEZb
	YFxs0B/1dnXYiIpIUzS3LecH1FHgbEHU71pKML59fzHihNn02Q==
X-Google-Smtp-Source: AGHT+IFnnDAhbGcdZty5D9K7fUTZ8B2Sp+Dbtz7dhqILgr6F04ua8VzWoNqKAww00qzCchYrXjpXF5EnABZT6zCkVe8=
X-Received: by 2002:a19:5e18:0:b0:50e:6d4f:6915 with SMTP id
 s24-20020a195e18000000b0050e6d4f6915mr3325240lfb.47.1705412417104; Tue, 16
 Jan 2024 05:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
 <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
 <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
 <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
 <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
 <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
 <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
 <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
 <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
 <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com>
 <CAKEwX=OsTQCJd12S3NajRMRy_s3q3yGFpS7S=_3-yOYK6+ezzA@mail.gmail.com> <CACSyD1NgqoFKuHSgdw_bzgK_StsLrNQ+7wHVBqsnHcB-2rD2ow@mail.gmail.com>
In-Reply-To: <CACSyD1NgqoFKuHSgdw_bzgK_StsLrNQ+7wHVBqsnHcB-2rD2ow@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 16 Jan 2024 21:40:05 +0800
Message-ID: <CACSyD1Np1JbKB9punaigGbJ7y2ZWou1Sr7bczanHv4-1UQZ==A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > >
> > > > Unless some page flag/readahead expert can confirm that the first
> > > > option is safe, my vote is on this option. I mean, it's fairly mini=
mal
> > > > codewise, no? Just a bunch of plumbing. We can also keep the other
> > > > call sites intact if we just rename the old versions - something al=
ong
> > > > the line of:
> > > >
> > > > __read_swap_cache_async_head(..., bool add_to_lru_head)
> > > > {
> > > > ...
> > > > if (add_to_lru_head)
> > > >   folio_add_lru(folio)
> > > > else
> > > >   folio_add_lru_tail(folio);
> > > > }
> > > >
> > > > __read_swap_cache_async(...)
> > > > {
> > > >    return __read_swap_cache_async_tail(..., true);
> > > > }
> > > >
> > > > A bit boilerplate? Sure. But this seems safer, and I doubt it's *th=
at*
> > > > much more work.
> > > >
> > >
> > > Yes=EF=BC=8C agree. I will try it again.
> >
> > Look forward to seeing it! Thanks for your patience and for working on =
this.

Please forgive me for adding additional information about this patch.

I have finished the opt for introducing a folio_add_lru_tail(), but
there are many
questions:
1) A new page can be move to LRU only by lru_add_fn, so
    folio_add_lru_tail could not add pages to LRU for the following code
    in folio_batch_move_lru(),which is added by Alex Shi for
    serializing memcg changes in pagevec_lru_move_fn[1].

/* block memcg migration while the folio moves between lru */
        if (move_fn !=3D lru_add_fn && !folio_test_clear_lru(folio))
            continue;
To achieve the goal, we need to add a new function like  lru_add_fn
which does not have the lru flag and folio_add_lru_tail()
+               if (move_fn !=3D lru_add_fn && move_fn !=3D lru_move_tail_f=
n_new &&
+                       !folio_test_clear_lru(folio))

2)  __read_swap_cache_async has six parameters, so there is no space to
add a new one, add_to_lru_head.

So it seems a bit hacky just for a special case for the reasons above.

Back to the beginning,  lru_add_drain() is the simplest option=EF=BC=8Cwhic=
h is common
below the __read_swap_cache_async(). Please see the function
swap_cluster_readahead()
and swap_vma_readahead(), of course it has been batched.

Or we should  leave this problem alone=EF=BC=8Cbefore we can write back zsw=
ap
in batches.

Thanks again.

