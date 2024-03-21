Return-Path: <linux-kernel+bounces-110679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6E886251
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10012854C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB39513777E;
	Thu, 21 Mar 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dh/W4mm2"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2643C137772
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055386; cv=none; b=eKj0RZXaq1rn4inDTGU+YViGNl3c1rOsRdTpKz8ULh9eGuaS7Dptrm2FLbSl7FpP8jOosktFNpzRS4t4i7lpxWwFVqmXRVawjErXevA30dlwO2+4KVKfDzU0NkYOd3NB2ukG74zkptnkKRQktjma/PI3kDaSW/5/QmKqAgiyQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055386; c=relaxed/simple;
	bh=ewIQavhqAI5butVvkhhGuC6jNX3LfUEAe9s1uyovQog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaZaGb6syP5PEWjkdS0m6+PItUYxk4tWLojM/KAZTXgV1YTBM0Rn43h/11//jzUu7Z+U4B5TTbHm5KBFup08fDRDywfL6isgZIh+8T3His4+F8EtSm95sUT6ECerxXPeqtqvu96nUY6wMWJwFB2o31XIOzsjaVPR06MM99Sk60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dh/W4mm2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a468004667aso213479866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711055382; x=1711660182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCPlx1GT9Pr9lMmsvRvjvdJRUIc8im5FcPiVj+xNHXc=;
        b=dh/W4mm2FKIKpiWuD5aIIyiCqaEtcfFA0cuq3RyLyV6GNVsiFJk7oY4Ds+h0Gh/aFO
         LUUFyBcFixbjjRc+FublGYcN6wUg4r3ot8T/hPGuldJvQlWpESdl/jK1VrLFsMgySaJL
         f6NqDhCt/YjyLmW2+YoLsqFxgQdk9g5eHZKQpcSZHm7TnRkGSO7Ij/mW6VCVopMFV4Z7
         LZGVb1kIebLrHXRQIhDCOduZQC9QW7YcK/pbmKED0cxO1Ri9gsz8TQzWBpnp/It4JRf4
         iDnThB2HVDuX56k86GxteA6gjGmLrZObB1ylUSQcl8Xxwwf+rx27KeZyMzFvYULa7U+z
         3/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055382; x=1711660182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCPlx1GT9Pr9lMmsvRvjvdJRUIc8im5FcPiVj+xNHXc=;
        b=XkWBkJ0NQGuNUxfKRnY1nETPtVYJ7SfnPLlguq+TvNW1BlWAkogJX99Hz0nGZTwScn
         8TkGO40q7P851Hp3LxJHT5TEzPHA5HP15gOcfIKWjaZXsMcy8PnYwBmSXHKpnpkRUNrT
         P4ugMvw3aHabAMqK5rle5EEGZMCgCFLGqh3Ao1vYfin6WQLrfQF5tDg52Y4kHtcZKjKS
         bcRXeSXrmlBvDhiw8szedOZdUglzifmJQWgnliXbHTJeYHrStNRZiB8POhOSzlfsCl0t
         w6VV5pvigQ324+H6bk68xqgLtQSxlHl3V6mqlLUe+tHsTLKhJyzYdMtUwy+VS8EF/QJx
         607Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDayHI/SVfeVGz1HzOc9aIx7drFo8aTlgHCMnOq7PNxwwQdIn/CHAUbCnd/0r8Girtr8/EQ4+ZuHto1nh2rLMkRbcLYgYgbXAs4uUo
X-Gm-Message-State: AOJu0Ywp3YZ7Rw0tTMXCihwhV3tMrK3179S5rB2L6/yzFG4wIQlYNn98
	c00qeJiITU7aKvVZlrskbWzFW0+oF4Q8TtYMLc8H2I3k9lhTSy0REWd8EfbHo3s+tjBsQL9B88Y
	nLIkmyiEVuagIbGsVzeLv9p3LscjrdwYRWLQ/
X-Google-Smtp-Source: AGHT+IHp7JkJ1zp0leoDozKWzrBJKEl5VRnRAgL+Vv6uNXQKBpFHxT3gWVhunq/zMBDvMTjx0oPFm8KkT/6Sg1d/LIw=
X-Received: by 2002:a17:906:2c47:b0:a46:7b29:6bd0 with SMTP id
 f7-20020a1709062c4700b00a467b296bd0mr355919ejh.19.1711055382115; Thu, 21 Mar
 2024 14:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320020823.337644-1-yosryahmed@google.com> <20240320020823.337644-2-yosryahmed@google.com>
In-Reply-To: <20240320020823.337644-2-yosryahmed@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 21 Mar 2024 14:09:04 -0700
Message-ID: <CAJD7tkYb-=Ho85e2AJbkfe-FmT6KXpJpUgPRaXQb5-+sY5j4Hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove nr_zswap_stored atomic
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 7:08=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> zswap_nr_stored is used to maintain the number of stored pages in zswap
> that are not same-filled pages. It is used in zswap_shrinker_count() to
> scale the number of freeable compressed pages by the compression ratio.
> That is, to reduce the amount of writeback from zswap with higher
> compression ratios as the ROI from IO diminishes.
>
> However, the need for this counter is questionable due to two reasons:
> - It is redundant. The value can be inferred from (zswap_stored_pages -
>   zswap_same_filled_pages).
> - When memcgs are enabled, we use memcg_page_state(memcg,
>   MEMCG_ZSWAPPED), which includes same-filled pages anyway (i.e.
>   equivalent to zswap_stored_pages).
>
> Use zswap_stored_pages instead in zswap_shrinker_count() to keep things
> consistent whether memcgs are enabled or not, and add a comment about
> the number of freeable pages possibly being scaled down more than it
> should if we have lots of same-filled pages (i.e. inflated compression
> ratio).
>
> Remove nr_zswap_stored and one atomic operation in the store and free
> paths.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Any thoughts on this patch? Should I resend it separately?

> ---
>  mm/zswap.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 323f1dea43d22..ffcfce05a4408 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -181,8 +181,6 @@ struct zswap_pool {
>
>  /* Global LRU lists shared by all zswap pools. */
>  static struct list_lru zswap_list_lru;
> -/* counter of pages stored in all zswap pools. */
> -static atomic_t zswap_nr_stored =3D ATOMIC_INIT(0);
>
>  /* The lock protects zswap_next_shrink updates. */
>  static DEFINE_SPINLOCK(zswap_shrink_lock);
> @@ -880,7 +878,6 @@ static void zswap_entry_free(struct zswap_entry *entr=
y)
>         else {
>                 zswap_lru_del(&zswap_list_lru, entry);
>                 zpool_free(zswap_find_zpool(entry), entry->handle);
> -               atomic_dec(&zswap_nr_stored);
>                 zswap_pool_put(entry->pool);
>         }
>         if (entry->objcg) {
> @@ -1305,7 +1302,7 @@ static unsigned long zswap_shrinker_count(struct sh=
rinker *shrinker,
>  #else
>         /* use pool stats instead of memcg stats */
>         nr_backing =3D zswap_total_pages();
> -       nr_stored =3D atomic_read(&zswap_nr_stored);
> +       nr_stored =3D atomic_read(&zswap_stored_pages);
>  #endif
>
>         if (!nr_stored)
> @@ -1325,6 +1322,11 @@ static unsigned long zswap_shrinker_count(struct s=
hrinker *shrinker,
>          * This ensures that the better zswap compresses memory, the fewe=
r
>          * pages we will evict to swap (as it will otherwise incur IO for
>          * relatively small memory saving).
> +        *
> +        * The memory saving factor calculated here takes same-filled pag=
es into
> +        * account, but those are not freeable since they almost occupy n=
o
> +        * space. Hence, we may scale nr_freeable down a little bit more =
than we
> +        * should if we have a lot of same-filled pages.
>          */
>         return mult_frac(nr_freeable, nr_backing, nr_stored);
>  }
> @@ -1570,7 +1572,6 @@ bool zswap_store(struct folio *folio)
>         if (entry->length) {
>                 INIT_LIST_HEAD(&entry->lru);
>                 zswap_lru_add(&zswap_list_lru, entry);
> -               atomic_inc(&zswap_nr_stored);
>         }
>         spin_unlock(&tree->lock);
>
> --
> 2.44.0.291.gc1ea87d7ee-goog
>

