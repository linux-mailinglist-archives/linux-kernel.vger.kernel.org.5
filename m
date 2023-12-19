Return-Path: <linux-kernel+bounces-5208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B5A8187FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D0C28B5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7160318AE7;
	Tue, 19 Dec 2023 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYLBYsEY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5418653
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ACFC433D9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702990235;
	bh=hXRBcR/CkDoWo+5XZl+gjuC8oYpbFZcW3b/mr+KF9Kk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VYLBYsEYisamx0tk99NFnluRGKQ0O9dFN0dJzZtfXpr0aspbVCiXWEGuNo4tBeEaR
	 I9twNWCpgkkAK9Dkc28tHZwuesHccJXITEEkXJ1/ZkobxgViJOm4JBFkqQZlrMfPin
	 jKR4kdCjBKUa3YdKR0aFG5JxbfqbOqP3CXqIWyOK05mZp8djwcK4g/YqER5lNcDGZ4
	 3OKJ1G50jI6UEuU/SC1MZgHNhz+88bF4aKPEzpLEw4deBABtxBIocYL9LRWc725D6X
	 RPxudwbTH3wTyb4AibD91vfEuzPJGXLOOcuDN6lkF5t1H/n/4CCbdgNJjENiQJEoEn
	 hx7dO5HwOTn2Q==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ba46a19689so3550640b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:50:35 -0800 (PST)
X-Gm-Message-State: AOJu0YyYcyotd0vHHuGYGsB1bUmYljqGzBI/PxggoMsLsF+uT/3Hd1CD
	Vw5KRQwFIUjxKDePKyprOXvQITj7K9hqShLIrecyEg==
X-Google-Smtp-Source: AGHT+IHLV35Qe4VA4rNnO1zOGlO5djKV2ADWoSTGkTId3HZua8ms5me49CWsKgEfLel8f9Q01NmNFJ2SpFdef5w6+h0=
X-Received: by 2002:a05:6358:91d:b0:172:d2ab:fcd4 with SMTP id
 r29-20020a056358091d00b00172d2abfcd4mr3815066rwi.57.1702990234519; Tue, 19
 Dec 2023 04:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com> <20231213-zswap-dstmem-v3-5-4eac09b94ece@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v3-5-4eac09b94ece@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Dec 2023 04:50:23 -0800
X-Gmail-Original-Message-ID: <CAF8kJuM4sxd1at3yQKhb9R7hQjGx2G5WiEi3KPq=eKPb4C_KoQ@mail.gmail.com>
Message-ID: <CAF8kJuM4sxd1at3yQKhb9R7hQjGx2G5WiEi3KPq=eKPb4C_KoQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mm/zswap: cleanup zswap_writeback_entry()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Seth Jennings <sjenning@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Dan Streetman <ddstreet@ieee.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org> (Google)

I also thing this one can fold into patch 3. Too trivial to be a separate p=
atch.
Your call.

Chris

On Mon, Dec 18, 2023 at 3:50=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Also after the common decompress part goes to __zswap_load(), we can
> cleanup the zswap_writeback_entry() a little.
>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 86886276cb81..2c349fd88904 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1443,7 +1443,6 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         struct page *page;
>         struct mempolicy *mpol;
>         bool page_was_allocated;
> -       int ret;
>         struct writeback_control wbc =3D {
>                 .sync_mode =3D WB_SYNC_NONE,
>         };
> @@ -1453,15 +1452,18 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>                                 NO_INTERLEAVE_INDEX, &page_was_allocated,=
 true);
>         if (!page) {
> -               ret =3D -ENOMEM;
> -               goto fail;
> +               /*
> +                * If we get here because the page is already in swapcach=
e, a
> +                * load may be happening concurrently. It is safe and oka=
y to
> +                * not free the entry. It is also okay to return !0.
> +                */
> +               return -ENOMEM;
>         }
>
>         /* Found an existing page, we raced with load/swapin */
>         if (!page_was_allocated) {
>                 put_page(page);
> -               ret =3D -EEXIST;
> -               goto fail;
> +               return -EEXIST;
>         }
>
>         /*
> @@ -1475,8 +1477,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) !=
=3D entry) {
>                 spin_unlock(&tree->lock);
>                 delete_from_swap_cache(page_folio(page));
> -               ret =3D -ENOMEM;
> -               goto fail;
> +               return -ENOMEM;
>         }
>         spin_unlock(&tree->lock);
>
> @@ -1497,15 +1498,7 @@ static int zswap_writeback_entry(struct zswap_entr=
y *entry,
>         __swap_writepage(page, &wbc);
>         put_page(page);
>
> -       return ret;
> -
> -fail:
> -       /*
> -        * If we get here because the page is already in swapcache, a
> -        * load may be happening concurrently. It is safe and okay to
> -        * not free the entry. It is also okay to return !0.
> -        */
> -       return ret;
> +       return 0;
>  }
>
>  static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
>
> --
> b4 0.10.1

