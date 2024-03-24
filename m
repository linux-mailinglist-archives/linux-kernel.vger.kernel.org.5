Return-Path: <linux-kernel+bounces-112862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E35887F23
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E4CB20FA8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7B1CD10;
	Sun, 24 Mar 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLBlLyNo"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370E1C68C
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711315408; cv=none; b=rCTtBJUR1cZqD14AlnlOthuIfftT7MWN926Xd2zCPloHYM2BEAy538f2pZ65OgHgwS8KIlfesWPeIs74/yVE0cdiDVoqj/7sv5dtKVPXsjClQ+nI3lHTkxNIrToMG+t0F/UG0rSzxuRnTaCzKPB68SzFY8yD4ZusGGxjdlL114w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711315408; c=relaxed/simple;
	bh=mSJwgnsoJJc86hqP5ghSmCR2NxFxgtq7+uHyKYZFYIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+MKTz5jE0GFc+OlEoZtdto0wAaIUrJDfKcCGVODz7tcoWlphIvYDL36JZMIA7oGAuHTex5lNzdDWiYSAORX/cWk5HWNHJbZ45gflxe3tthAOjVgS5OC6sQArmLVh9Fs1HML96gSI7qRqltveriFKPePoAPNss59eeWsim7SWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLBlLyNo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso4287807a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711315404; x=1711920204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpDW9MNFOfxjG6sVJlDI3bV93UG5A+19Bb8AJvL6hmg=;
        b=kLBlLyNodJbNJCPfC5JdpmplcgdLTVHLeXSkfhwzySvpVHT7TkwCD+Vo27uNh7LYs4
         sdbv8UDLtB/mZlej9qKhisWb4Nn1E75BYvB6QDPn8AbuH3aUwrfaR2742GvNapDsoXIw
         fzvYDWxCpkQkuP3T5bgo5xjN10VH46OCxUhSEsPeES3Oqk2R12IkyJvm90fmAegmQVPN
         1mSDo10XF7NU9RpyYojc3Haye+sN22fPhhRMCy34rvmP6+wozDU04WowWIJ0aaje1ZLf
         51o+Y5/jb4DevY7LgWbUgBJolIyOWQkj7MgBFbRO/O1/l5AJ85tEY6swaK8uhvD8BDWn
         W9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711315404; x=1711920204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpDW9MNFOfxjG6sVJlDI3bV93UG5A+19Bb8AJvL6hmg=;
        b=tbHaMsuG/BlrIP/Pd4vrmbM1REga7CixWtEtyoqKktHibyYWPaRpZjoyZC6ws7o9Rc
         Yd0hU5wzq9W7juQb1wuD+GaRMe6nbYGzTnMTR+tf5+9c39SfYevZOacYJ7dAsTg0WG4X
         UMCzsKAnxA/n5UtGwJGw4PylFNmempS2/FfPi/oH2Sdhx869U9kI2gAgARftWJ+BUmlD
         2CRQXYveZ1UwruYWtF1nyZNY24qGxldgO3YIRlKcclo2AByd94NU5Ormy9pUeSlfrHVK
         gefRL+nK8Q8FZsB9eMcbBfRpd6VVq/XS0kekwsjqjQJtumxtU6rYJ7QKyZ2WThr99UBa
         Pa/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmJ452IlaUeNBQPFVwgvEEWCQv/KiRkbyAc7dmN71f4xBL3gtqfRErMQG9fiGZwPnPTIUx1Od2adnOd1j2Kskl5DcxrxwacMEb2taB
X-Gm-Message-State: AOJu0YyE2otOtkmE+YbKUs/86hbFFhr8w0cDWpo/SX6CCvgLCdbTPYSR
	2jHFlOBG0gwcAPzgUjj1CVKWP10/SWHdYXTr59UdF6urdSUtRT4LgNAv/wR+cgYh1DPvCIX4+Ux
	u84Jma4rMd4sOD4wV334tucBpcBfdv/VZEf0w
X-Google-Smtp-Source: AGHT+IE2PLpZpD/SdVJ+zLXfepUJR3PSNmH6dMnK9nObvIVnE2sC0l7+uK+5o7TdJyrWuvLbMDmhzclSRq9qCgEwHDc=
X-Received: by 2002:a17:906:2688:b0:a46:8c40:7a3a with SMTP id
 t8-20020a170906268800b00a468c407a3amr3560145ejc.26.1711315404261; Sun, 24 Mar
 2024 14:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324210447.956973-1-hannes@cmpxchg.org>
In-Reply-To: <20240324210447.956973-1-hannes@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Sun, 24 Mar 2024 14:22:46 -0700
Message-ID: <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zhongkun He <hezhongkun.hzk@bytedance.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, 
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

Do we also want to mention somewhere (commit log or comment) that
keeping the entry in the tree is fine because we are still protected
from concurrent loads/invalidations/writeback by swapcache_prepare()
setting SWAP_HAS_CACHE or so?

Anyway, this LGTM.

Acked-by: Yosry Ahmed <yosryahmed@google.com>

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
>
>         return true;
>  }
> --
> 2.44.0
>

