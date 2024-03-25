Return-Path: <linux-kernel+bounces-117550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBE688AC83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7151FA2F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1F1327E4;
	Mon, 25 Mar 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUILsgNC"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E86131197
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386591; cv=none; b=gn405DGIBQOTjEWUpKD7n1B9eMfdx+YlLpBKzWSaZNxoEJiXpYjGvTmIoQwYo8YPWxn+6EZVd37WVrDkoKnorPtQNxRM4W2bt1Fn6K1n1YLP+PtxGESrm3GYPAeesRHF3g1eJJ5KpAzfIfsy78cW/2ccT3i7mjJRUqzd9gfxrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386591; c=relaxed/simple;
	bh=MI4oK6lulMzBqe0OFiDFxTAWlxqvLvxfa6VGDIuFswg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WopQwncJlbGg9zud4oOq7YfwG8SNDKfUucgLt1Rv7UJwbjDBpTPt+Q/zeYzkGE3aJ1WVsPqlB4NEPZydZb4UhxomfvcNu24RabV1MspHJJw741sPG2QCIaaWognN1iVB49G4IXzCnXarP8OY8OS6LbbjosXDxRoH8xhUPXKQP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUILsgNC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78a01a3012aso326807785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386589; x=1711991389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYjqm/1NdDhDA4E1plMxFxGv/E29PMV9umo4qLhPFZY=;
        b=AUILsgNCGEEMKQIXS2e3eMISKDt2ctipcqyCkea7kfWcHYEJj1okq0pNWnIMfP/jeF
         IgtrPeVe49/54YmkXDyBzUyxgvk/sRJNetlO4Drfvn78bg9m1XM0TGVde6gFFafu8+r0
         Qr1/izXRCPBdiMh2CBk4e3Iwzns4sLhp7o2cNbUFhzgYXeBSZo8g0pKRH3lvTeIKnO8b
         CBIUFmeK9mtLvlekyo+BWY3IhjMRP4hqnARKlLVk3ZHmg3D2NXK6J7c3jITZEwpPFshY
         zIL3J7/PO8BG2KOsecW34UdV9Lf9bWYf7aosRjtGIe5TbDwt2xIhexgS6Gidh+SaQ3FQ
         9D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386589; x=1711991389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYjqm/1NdDhDA4E1plMxFxGv/E29PMV9umo4qLhPFZY=;
        b=AYzqlhVj2KecRCV2TwiKVLBK5cFsg9EghCZ4N4jH+cmn5Qog3fx4mztuh5I6518Oel
         w6xUqqR2itY9xWqDmxXJBDAsDXxF2oGJwoHLpYrKAucB2cRomgvRDs0hbCoLWVmxmi35
         x2NdnamPpL76XWmslQ0Oyr1Po54DA+vHlZSvjvsw13n8CyTnjlp6ImbpH6xnayBPbhH3
         OE55P38GX2ZioPSavDaTr2fkkIgHJ02Q/B0RdfcpJQA+dVdTYbG0Fl39WDuxpYRgm63P
         GySzDgMrzgfGyeqJTC+v64xlFyEthp04Z7WDB5zmdVwiBskYFqYtsQISdWj6FZtdO7tj
         6r7g==
X-Forwarded-Encrypted: i=1; AJvYcCXMd6BYXOGzraFp1vq3m8ILQSyFU5KpTLrZtWf1WWQvf1AvB22ydYONQZB9F2QJKpeJkQHIw7Wir+m7VWh2zbQSUawdHcRNSoWWNltx
X-Gm-Message-State: AOJu0YySCjMRKYiRRegQxDS6biDDFvBIpEdaDWpkSJ0zY98AKEsof9NH
	6dRAKmG0HOJpmMT+V0VA7QvzVf6mIDNBmWyTUu0VJ6gXFwdGfP522n3zbfOpGBn6faV3daRIfIY
	vijTq/pJJ4BNklWcuc2nm+hnfd4w=
X-Google-Smtp-Source: AGHT+IGfq12zKT1PPjPcEbfjPvQzo3NpeJjnbT1HJh4i4YahabfVLlS4mvDswjzBry9WP/zm4+Ht56Pq9U7sfG8SNw4=
X-Received: by 2002:a05:6214:f23:b0:696:45c1:4c7c with SMTP id
 iw3-20020a0562140f2300b0069645c14c7cmr442408qvb.35.1711386588678; Mon, 25 Mar
 2024 10:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324210447.956973-1-hannes@cmpxchg.org>
In-Reply-To: <20240324210447.956973-1-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 25 Mar 2024 10:09:37 -0700
Message-ID: <CAKEwX=MBXXB3QvX2Qa=1n=y3CD8bfhyeCzt98gEjLxfHEQAr=g@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zhongkun He <hezhongkun.hzk@bytedance.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 2:04=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Zhongkun He reports data corruption when combining zswap with zram.
>
> The issue is the exclusive loads we're doing in zswap. They assume
> that all reads are going into the swapcache, which can assume
> authoritative ownership of the data and so the zswap copy can go.
>
> However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will try
> to bypass the swapcache. This results in an optimistic read of the
> swap data into a page that will be dismissed if the fault fails due to
> races. In this case, zswap mustn't drop its authoritative copy.
>
> Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=3DzV9P691B9bVq33erwOXNT=
mEaUbi9DrDeJzw@mail.gmail.com/
> Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> Cc: stable@vger.kernel.org      [6.5+]
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> ---
>  mm/zswap.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 535c907345e0..41a1170f7cfe 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
>         swp_entry_t swp =3D folio->swap;
>         pgoff_t offset =3D swp_offset(swp);
>         struct page *page =3D &folio->page;
> +       bool swapcache =3D folio_test_swapcache(folio);
>         struct zswap_tree *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
>         u8 *dst;
> @@ -1634,7 +1635,20 @@ bool zswap_load(struct folio *folio)
>                 spin_unlock(&tree->lock);
>                 return false;
>         }
> -       zswap_rb_erase(&tree->rbroot, entry);
> +       /*
> +        * When reading into the swapcache, invalidate our entry. The
> +        * swapcache can be the authoritative owner of the page and
> +        * its mappings, and the pressure that results from having two
> +        * in-memory copies outweighs any benefits of caching the
> +        * compression work.
> +        *
> +        * (Most swapins go through the swapcache. The notable
> +        * exception is the singleton fault on SWP_SYNCHRONOUS_IO
> +        * files, which reads into a private page and may free it if
> +        * the fault fails. We remain the primary owner of the entry.)
> +        */
> +       if (swapcache)
> +               zswap_rb_erase(&tree->rbroot, entry);
>         spin_unlock(&tree->lock);
>
>         if (entry->length)
> @@ -1649,9 +1663,10 @@ bool zswap_load(struct folio *folio)
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPIN);
>
> -       zswap_entry_free(entry);
> -
> -       folio_mark_dirty(folio);
> +       if (swapcache) {
> +               zswap_entry_free(entry);
> +               folio_mark_dirty(folio);
> +       }

This LGTM!

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

