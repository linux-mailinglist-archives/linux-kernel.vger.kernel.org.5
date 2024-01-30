Return-Path: <linux-kernel+bounces-44954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28084295F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC0C1C2583C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ADB4C629;
	Tue, 30 Jan 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at8e3xjv"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A382128379
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632412; cv=none; b=X4Az4BN0HReaz/lq4pjyhsAL9W3m7sFPw+QHYbkAunoAjsYlat5N84wPKMqB67wY9Z0qdNU8tXpNaL7h5jx2SxyoQ2JTaTHnFZpQ5VmgHVxXag9eyTTqoT+vMez5uJLEIxRNdW9jeqwB1j5ioePWhiYI1lz0zJoBd5YdPvXJNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632412; c=relaxed/simple;
	bh=h6H8yFGnyU3/CpPeqSB22cNKJDaDYbEVSkDp/gjcVYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOxQ2bbhUjxnw/NAxU+lVKp2N4OqAD2c2Ne8Oia3mEbRuQpI0fvaB0dRT3L0LfeeQNuWQrcabHRgXxJl8KAxy6cZi5B00jRdmdKlCHAsTeogkPraduYs+EIP2z3Akv9mON82GnqYbyXYg3/N4ln++g9JGdcDfqV2NO6ccT0R0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at8e3xjv; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36376bf7f6dso8708385ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706632409; x=1707237209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5df6v4Y1CvGshA4Xd8afgPQAEeOHdkVXvY3a18V0GUw=;
        b=at8e3xjviiOmAE4S/0aWqQ8e8eq8trD25ZGhhgFaR+z1OtdqZiFm5tDu2Xlu2Ve0yF
         Rw+jDDraqiSEZSi3OxcJ9niGnyjlEWj24oCeNTrnF/thm/3RzZfk27RccKw8G886I3Wk
         o08Ps7XD7VPD22+w5pRfKmPLCCICODLe3VDFmM/xu1zid0RbPwmdTOtVvBChbDZghaFC
         PdR5itUIqeegaSMpXe++BDM+cd7ZF4RRx7e5qOEFb3qSwt1dLKqAka7vYMGvnx0EuT6z
         9jVoPKByEoNGItayG3Wdh/Uv3EU15lWB/T6uXXC1GM7ztccN2QR+k4JO8djOf2PrSR7F
         /PVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632409; x=1707237209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5df6v4Y1CvGshA4Xd8afgPQAEeOHdkVXvY3a18V0GUw=;
        b=KwLiC7/hKrv9HvQ5Jq+9POWxnQootOYGHZRpjHkbqHqT7Q95TDZKOORGlqp0hU/S4v
         b1yjmTDTBT8IRAjT6Fi8N0LXzB90CDNb3ZoQbTDp4r5WLiyLyG8cqtVcwyebNEZBuUB2
         NMScrOUHT0vqG3joKwQLU628p9pVyD8RaBE8fzltEDgAuZcfGhWjdwL8lLGREicjvh7e
         a/ty9f2HXegecIgMsxoRQpP9SXpBl6K+R0uZlpUZX2plbrS8nFXcvShFaQe1e3Gx386a
         9FIErNn72c196gLOSYzzTknpogJGcgwXGrCyxlSSB3x9WYD3I+QtS/w65651EQb895AC
         T1eg==
X-Gm-Message-State: AOJu0YxDO5u7GneAyhDvlrvd6EGhOFgl8ZrWyNaWe/cnE5RK7+KZ4OAb
	czggFD9z4eJtTf8s5eoB9/GhF7ooRKLeMO0iECvAwI9Tmpzc97qndxhM7BglC4PzQ7nX2GuSipD
	hfQESG7E7wbZ5HMAy0UCvaDWnKjI=
X-Google-Smtp-Source: AGHT+IFYBCqr3IbpgXE0K/7lY9bLI60Nr5zvvxtevwznlcLY7z4FEn/C5oupH38AA9X1XbwYzu+MF24uE+zZ1+RzGBQ=
X-Received: by 2002:a92:c0c3:0:b0:363:75fc:6c4f with SMTP id
 t3-20020a92c0c3000000b0036375fc6c4fmr7620916ilf.3.1706632409693; Tue, 30 Jan
 2024 08:33:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-7-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-7-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 08:33:18 -0800
Message-ID: <CAKEwX=N-n8Eps4ohERxRYAPSRYzpxpOW_1fzUfrpUq7P=1DZFg@mail.gmail.com>
Subject: Re: [PATCH 06/20] mm: zswap: rename __zswap_load() to zswap_decompress()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7a7e8da2b4f8..bdc9f82fe4b9 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1316,7 +1316,7 @@ static int zswap_enabled_param_set(const char *val,
>         return ret;
>  }
>
> -static void __zswap_load(struct zswap_entry *entry, struct page *page)
> +static void zswap_decompress(struct zswap_entry *entry, struct page *pag=
e)

This is a much better name. Was gonna point this out in the original
series - it's clearly just decompression :)
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

>  {
>         struct zpool *zpool =3D zswap_find_zpool(entry);
>         struct scatterlist input, output;
> @@ -1411,7 +1411,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         zswap_entry_get(entry);
>         spin_unlock(&tree->lock);
>
> -       __zswap_load(entry, &folio->page);
> +       zswap_decompress(entry, &folio->page);
>
>         count_vm_event(ZSWPWB);
>         if (entry->objcg)
> @@ -1702,7 +1702,7 @@ bool zswap_load(struct folio *folio)
>         spin_unlock(&tree->lock);
>
>         if (entry->length)
> -               __zswap_load(entry, page);
> +               zswap_decompress(entry, page);
>         else {
>                 dst =3D kmap_local_page(page);
>                 zswap_fill_page(dst, entry->value);
> --
> 2.43.0
>

