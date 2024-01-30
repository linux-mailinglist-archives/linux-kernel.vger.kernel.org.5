Return-Path: <linux-kernel+bounces-45499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E3843190
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61FA5B224B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E725479953;
	Tue, 30 Jan 2024 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHC2Wbzc"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A843D7EEE7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658507; cv=none; b=M8FLHXljBiabQEP6qiTgthNQYc34USKXApuc8EHo+zzD1AhYiAAJoftLN9ZhWj5+g4YIieDmluB9hApVeuGX6quhxRKrYOCkfbouJ5BlUfHX+ZVU6R+VQnwcfEiBfn3DPsBfoC1ulXkz0kseu79x0axd8KLBHkpea62WVPBi3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658507; c=relaxed/simple;
	bh=+o5dw4i+V3UfJILxlj5izylxx+Odphf1YLK8GFy/FpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9Xrq1dff5w6jb2i6v6VHrtAFTR+muLrDF6fPki3z30VjQrWnUdXunm4iHqsOXnfny1tcGT/CD6Io0Pn/KDrWNpCpWnA56JDxvakgFP/hVxz3n53bzmaml2+sGgnunvFbrASrNgBrByO5ppUH5fZEH1XcOLIc7zPTzF5QFb670I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHC2Wbzc; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-363890b20dfso6864225ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706658505; x=1707263305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fZr4lKvL81KL9mKJdNG4wqQnIzOxS/AaC4B6cMo1vY=;
        b=IHC2WbzcvTInNzOPNKOyT5l0uE1K5wrxnE8Y2C65yrS5hur3UDq1LOY6ueykbXVOKp
         lzSPBo99eRd+iMigY8WBmyWNKHpsHUYLxqEiTcBKUcKKc8KVH9RNO1S5IB745UU4uans
         dqM2XhZ4MqK0nZ8Q5mEWlJm3vYxgXQEQtj1KcvjCP11kmqq67Ou6yBfdNwNZKyjl1MrD
         2pXEITBagcwERBodEKC+M+JLWOHdiyZ3aNcEOQdP5xJzBWsViUNzTbKyKmwZ/Iyl3z6v
         NpBd7786SnNS/RzF0mjCkFXo/1XCWKrtTWhZGCd3Y1DvFWj+Yzi6y5mSbBfbqHGsBWFj
         7nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706658505; x=1707263305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fZr4lKvL81KL9mKJdNG4wqQnIzOxS/AaC4B6cMo1vY=;
        b=EVj5SkwVhkghd9k/dErqYJmBXqeyBfnlc5YY1OktIkvsYsOIFh5lnlVYbgM7e+a63R
         /GdXPd4piE8EYceyUxRZ+EBuIARudibOyNWYeCmTzb4doaAQUDhcy7mQxxFKSrKDHLH3
         kLXfNd+Sjq8EgfAghgAd3/mVPx4aPPy6RFs/8TKt6jMT1AuAz20wcEbN3k//QHljR1HB
         M5qoMQAMpOzVozPDX7/cW4L4ZVKXJsY7LhbI2Elv/zdMm9vkB8Tm9lR2KHbNtOZrRPqz
         28Vbv/DraDGslecmejr1Kvxc//jUeD/cP0z2aMGszXHdL5RP0ms5I4DTtbk0gO4W1s1o
         1LPA==
X-Gm-Message-State: AOJu0YyH3ggMz8psyJpytfJzh95LELDi5zuSAW5wRjDVp3IEdKJic8hg
	FLTSoGijwCRSPRb7sIaKgVKjEMga1g8adtcTs+m1e65mOPGrdyGFDFmfeMzqohx+Ss96ReCTubJ
	uuyqCM+r5gPYsIyQ4cqvKU8TMhcY=
X-Google-Smtp-Source: AGHT+IETgzCoGY9ZZBkoLuxT28Pwh9txeSQC++SWOUPFMBKt9gvh3WSbKsPT6p9nBxMHkLfyMoUq+sCi/TqPBe/ZFFw=
X-Received: by 2002:a05:6e02:ee7:b0:363:7fb9:929a with SMTP id
 j7-20020a056e020ee700b003637fb9929amr91167ilk.31.1706658504678; Tue, 30 Jan
 2024 15:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-16-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-16-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 15:48:13 -0800
Message-ID: <CAKEwX=ONxSveDNJRgw7mciKp=PFCme_niAod_01bigfDAW=-BA@mail.gmail.com>
Subject: Re: [PATCH 15/20] mm: zswap: function ordering: move entry sections
 out of LRU section
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> This completes consolidation of the LRU section.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  mm/zswap.c | 101 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 49 insertions(+), 52 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 511bfafc1456..756d4d575efe 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -768,58 +768,6 @@ static inline int entry_to_nid(struct zswap_entry *e=
ntry)
>         return page_to_nid(virt_to_page(entry));
>  }
>
> -void zswap_lruvec_state_init(struct lruvec *lruvec)
> -{
> -       atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0=
);
> -}
> -
> -void zswap_folio_swapin(struct folio *folio)
> -{
> -       struct lruvec *lruvec;
> -
> -       if (folio) {
> -               lruvec =3D folio_lruvec(folio);
> -               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_prot=
ected);
> -       }
> -}
> -
> -void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
> -{
> -       struct zswap_pool *pool;
> -
> -       /* lock out zswap pools list modification */
> -       spin_lock(&zswap_pools_lock);
> -       list_for_each_entry(pool, &zswap_pools, list) {
> -               if (pool->next_shrink =3D=3D memcg)
> -                       pool->next_shrink =3D mem_cgroup_iter(NULL, pool-=
>next_shrink, NULL);
> -       }
> -       spin_unlock(&zswap_pools_lock);
> -}
> -
> -/*********************************
> -* zswap entry functions
> -**********************************/
> -static struct kmem_cache *zswap_entry_cache;
> -
> -static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
> -{
> -       struct zswap_entry *entry;
> -       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> -       if (!entry)
> -               return NULL;
> -       entry->refcount =3D 1;
> -       RB_CLEAR_NODE(&entry->rbnode);
> -       return entry;
> -}
> -
> -static void zswap_entry_cache_free(struct zswap_entry *entry)
> -{
> -       kmem_cache_free(zswap_entry_cache, entry);
> -}
> -
> -/*********************************
> -* lru functions
> -**********************************/
>  static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry =
*entry)
>  {
>         atomic_long_t *nr_zswap_protected;
> @@ -872,6 +820,55 @@ static void zswap_lru_del(struct list_lru *list_lru,=
 struct zswap_entry *entry)
>         rcu_read_unlock();
>  }
>
> +void zswap_lruvec_state_init(struct lruvec *lruvec)
> +{
> +       atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0=
);
> +}
> +
> +void zswap_folio_swapin(struct folio *folio)
> +{
> +       struct lruvec *lruvec;
> +
> +       if (folio) {
> +               lruvec =3D folio_lruvec(folio);
> +               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_prot=
ected);
> +       }
> +}
> +
> +void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
> +{
> +       struct zswap_pool *pool;
> +
> +       /* lock out zswap pools list modification */
> +       spin_lock(&zswap_pools_lock);
> +       list_for_each_entry(pool, &zswap_pools, list) {
> +               if (pool->next_shrink =3D=3D memcg)
> +                       pool->next_shrink =3D mem_cgroup_iter(NULL, pool-=
>next_shrink, NULL);
> +       }
> +       spin_unlock(&zswap_pools_lock);
> +}
> +
> +/*********************************
> +* zswap entry functions
> +**********************************/
> +static struct kmem_cache *zswap_entry_cache;
> +
> +static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
> +{
> +       struct zswap_entry *entry;
> +       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> +       if (!entry)
> +               return NULL;
> +       entry->refcount =3D 1;
> +       RB_CLEAR_NODE(&entry->rbnode);
> +       return entry;
> +}
> +
> +static void zswap_entry_cache_free(struct zswap_entry *entry)
> +{
> +       kmem_cache_free(zswap_entry_cache, entry);
> +}
> +
>  /*********************************
>  * rbtree functions
>  **********************************/
> --
> 2.43.0
>

