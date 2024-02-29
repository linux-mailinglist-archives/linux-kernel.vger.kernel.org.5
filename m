Return-Path: <linux-kernel+bounces-85938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA386BD02
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682F11C2254F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D21EB22;
	Thu, 29 Feb 2024 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzFXUayO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E242599
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167946; cv=none; b=KEw+gQQSBmzvTS/fp3zE33pc/onnKwWzTvhzUo1qsaNvReMAXg4PYrrsUFll7oqMhIEF4TRvKGvk5a0a3LpvkbJBRKKD7UPqCj3K8/3VZ+984Oi5JUE99n3P/qTMIA1f5OGr5LbLvUcyofe0auUoG2lWnLkWe9jmAVO4DObt9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167946; c=relaxed/simple;
	bh=TuCMlpZG79u3CzHRmniQwJCFUVTO1G4BzKK5naL1Dwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud11Ix8A4bmvlruIPHtVE6YRgz6FxL4QWNdtthk7DzOpckvewsm3wbWvHiaNMTkoObyReaWpCMovEjJyqkruU8rb5R4AOp/dIUduW+spAdvM5hPnvptHtYD4CASLdjF24XqQM2nJMGubSfqpRVMtJhjcLxPhWqNHa9YLv0N9QrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzFXUayO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3566c0309fso54453166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709167943; x=1709772743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOoFnCufx7taaiCSkKihrCSXYV9CGIUvZlyJqjbocTk=;
        b=CzFXUayO1+3GaivLtXeTCKY9C5POufDlX31zNpIt5RUhq9e5un0/X4rp+Iicy4HQBr
         trCRHKs/N+tQfQP/AItQ1SH3pysR2j1aDp4PeWotsKkYHAqpvqCLKkFY5My/e/3DBIDF
         V/idj0zHy0ocsTxO3MAfZUpoLSbSP8Y47AHO0i+yLJpzEynYmGUYeNlxUw32tQH21ag1
         IT5WZL9tj31qqnSD4ErbCv3T/jYkwELbrcPTh1nA68ij7aITPoP0J/ZQpWKwR9b1nJMa
         A8wPDOvZVt4RjbNkQAEcnJCTY17ryTYRkyhTscTUGqGTIOjhBxBN5HCzAAHvr6EvssoA
         lj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167943; x=1709772743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOoFnCufx7taaiCSkKihrCSXYV9CGIUvZlyJqjbocTk=;
        b=TZiuu1WdqdoOvLGGnbAtUNAxCh7+nHAlkM5TJULs6EajAzOJG6O+yS7UJq3Q8Z2w4D
         gZjcXF61DFmvNN5j4ECuu0gygU+DlIOun9DRL5AZztupmDhRtsaWwsHLA+lde1rH9Nmd
         +nzfd7PmoH454KOuLixIUszhEsYbXAveu06JwmLBjyJjOHh47JT5iMmophGxXuO+lznM
         8+bcjH9QgXdeLZnwBWshNBFW4kz84YYY3PIupUumRpLd2lTsBqHMNDR7u4QDD77mRM95
         NDBux4MlBepdF1HGEbI1u5yf2bMhjBttp7f+GRQxSm7u1RTarXhaUmgeWm78PUqVWNRR
         PEgg==
X-Forwarded-Encrypted: i=1; AJvYcCWEkus+n4kva+2rsnmm3oSBLYz/tTqgAbF9Fbrqik2c0W8T20Lt9ZJBeyfALVvcNvfRRBfPRqMQePXkE0726KNdmgZXGQidmMBVNKLz
X-Gm-Message-State: AOJu0Yzrk1vvylGUFQEGpWTfL5Kx7NMgGU88zH0J0dFoNhNwhaCW3+tP
	KClXvHNW+XRkRKGDoOXb0eTzeMMbbyLXYVy+JMEHIGwzLyV0w+pOIp0lpU+2oAq1tqFJ4MujNp4
	20M4OZW5KZ4gMq6S7e2+ywJhrcvMGE7iyMzb8
X-Google-Smtp-Source: AGHT+IEPA4ZTo8LTkRBSWlvTNJeoKH3nUD5wkqOYyabq6B7/WHJkyx0NFuHjRttWmpSWiJ+8mr+rCudvqOHhtPP1YwI=
X-Received: by 2002:a17:906:508:b0:a3e:b442:cfdd with SMTP id
 j8-20020a170906050800b00a3eb442cfddmr324683eja.17.1709167943213; Wed, 28 Feb
 2024 16:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229003753.134193-1-21cnbao@gmail.com> <20240229003753.134193-5-21cnbao@gmail.com>
In-Reply-To: <20240229003753.134193-5-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 28 Feb 2024 16:51:45 -0800
Message-ID: <CAJD7tkYWvxeCLmDO83tGyde7e4wPDPMnNbQfnB+pyTJAoSHqbg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/5] mm: swap: introduce swapcache_prepare_nr and
 swapcache_clear_nr for large folios swap-in
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chrisl@kernel.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, shy828301@gmail.com, steven.price@arm.com, surenb@google.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, kasong@tencent.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-arm-kernel@lists.infradead.org, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:39=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache") support=
s
> one entry only, to support large folio swap-in, we need to handle multipl=
e
> swap entries.
>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: SeongJae Park <sj@kernel.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/swap.h |   1 +
>  mm/swap.h            |   1 +
>  mm/swapfile.c        | 117 ++++++++++++++++++++++++++-----------------
>  3 files changed, 72 insertions(+), 47 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index b3581c976e5f..2691c739d9a4 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -480,6 +480,7 @@ extern int add_swap_count_continuation(swp_entry_t, g=
fp_t);
>  extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
> +extern int swapcache_prepare_nr(swp_entry_t, int nr);
>  extern void swap_free(swp_entry_t);
>  extern void swap_nr_free(swp_entry_t entry, int nr_pages);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> diff --git a/mm/swap.h b/mm/swap.h
> index fc2f6ade7f80..1cec991efcda 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -42,6 +42,7 @@ void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>                                   unsigned long end);
>  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
> +void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, =
int nr);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
>                 struct vm_area_struct *vma, unsigned long addr);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c0c058ee7b69..c8c8b6dbaeda 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3308,7 +3308,7 @@ void si_swapinfo(struct sysinfo *val)
>  }
>
>  /*
> - * Verify that a swap entry is valid and increment its swap map count.
> + * Verify that nr swap entries are valid and increment their swap map co=
unt.
>   *
>   * Returns error code in following case.
>   * - success -> 0
> @@ -3318,66 +3318,73 @@ void si_swapinfo(struct sysinfo *val)
>   * - swap-cache reference is requested but the entry is not used. -> ENO=
ENT
>   * - swap-mapped reference requested but needs continued swap count. -> =
ENOMEM
>   */
> -static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> +static int __swap_duplicate_nr(swp_entry_t entry, int nr, unsigned char =
usage)
>  {
>         struct swap_info_struct *p;
>         struct swap_cluster_info *ci;
>         unsigned long offset;
> -       unsigned char count;
> -       unsigned char has_cache;
> -       int err;
> +       unsigned char count[SWAPFILE_CLUSTER];
> +       unsigned char has_cache[SWAPFILE_CLUSTER];

I am not closely following this series, but a couple of things caught my ey=
es.

Is this reasonable for stack usage?

> +       int err, i;
>
>         p =3D swp_swap_info(entry);
>
>         offset =3D swp_offset(entry);
>         ci =3D lock_cluster_or_swap_info(p, offset);
>
> -       count =3D p->swap_map[offset];
> -
> -       /*
> -        * swapin_readahead() doesn't check if a swap entry is valid, so =
the
> -        * swap entry could be SWAP_MAP_BAD. Check here with lock held.
> -        */
> -       if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
> -               err =3D -ENOENT;
> -               goto unlock_out;
> -       }
> +       for (i =3D 0; i < nr; i++) {
> +               count[i] =3D p->swap_map[offset + i];
>
> -       has_cache =3D count & SWAP_HAS_CACHE;
> -       count &=3D ~SWAP_HAS_CACHE;
> -       err =3D 0;
> -
> -       if (usage =3D=3D SWAP_HAS_CACHE) {
> -
> -               /* set SWAP_HAS_CACHE if there is no cache and entry is u=
sed */
> -               if (!has_cache && count)
> -                       has_cache =3D SWAP_HAS_CACHE;
> -               else if (has_cache)             /* someone else added cac=
he */
> -                       err =3D -EEXIST;
> -               else                            /* no users remaining */
> +               /*
> +                * swapin_readahead() doesn't check if a swap entry is va=
lid, so the
> +                * swap entry could be SWAP_MAP_BAD. Check here with lock=
 held.
> +                */
> +               if (unlikely(swap_count(count[i]) =3D=3D SWAP_MAP_BAD)) {
>                         err =3D -ENOENT;
> +                       goto unlock_out;
> +               }

Here we immediately exit if there is an error, but we don't below, we
just keep overwriting the error every iteration as far as I can tell.
Also, it doesn't seem like we do any cleanups if we hit an error
halfway through. Should we undo previously updated swap entries, or am
I missing something here?

>
> -       } else if (count || has_cache) {
> -
> -               if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> -                       count +=3D usage;
> -               else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> -                       err =3D -EINVAL;
> -               else if (swap_count_continued(p, offset, count))
> -                       count =3D COUNT_CONTINUED;
> -               else
> -                       err =3D -ENOMEM;
> -       } else
> -               err =3D -ENOENT;                  /* unused swap entry */
> -
> -       if (!err)
> -               WRITE_ONCE(p->swap_map[offset], count | has_cache);
> +               has_cache[i] =3D count[i] & SWAP_HAS_CACHE;
> +               count[i] &=3D ~SWAP_HAS_CACHE;
> +               err =3D 0;
> +
> +               if (usage =3D=3D SWAP_HAS_CACHE) {
> +
> +                       /* set SWAP_HAS_CACHE if there is no cache and en=
try is used */
> +                       if (!has_cache[i] && count[i])
> +                               has_cache[i] =3D SWAP_HAS_CACHE;
> +                       else if (has_cache[i])          /* someone else a=
dded cache */
> +                               err =3D -EEXIST;
> +                       else                            /* no users remai=
ning */
> +                               err =3D -ENOENT;
> +               } else if (count[i] || has_cache[i]) {
> +
> +                       if ((count[i] & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> +                               count[i] +=3D usage;
> +                       else if ((count[i] & ~COUNT_CONTINUED) > SWAP_MAP=
_MAX)
> +                               err =3D -EINVAL;
> +                       else if (swap_count_continued(p, offset + i, coun=
t[i]))
> +                               count[i] =3D COUNT_CONTINUED;
> +                       else
> +                               err =3D -ENOMEM;
> +               } else
> +                       err =3D -ENOENT;                  /* unused swap =
entry */
> +       }
>
> +       if (!err) {
> +               for (i =3D 0; i < nr; i++)
> +                       WRITE_ONCE(p->swap_map[offset + i], count[i] | ha=
s_cache[i]);
> +       }
>  unlock_out:
>         unlock_cluster_or_swap_info(p, ci);
>         return err;
>  }

