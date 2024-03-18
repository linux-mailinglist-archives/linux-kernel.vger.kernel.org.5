Return-Path: <linux-kernel+bounces-106788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453C687F3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B61283089
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3BD5C5FA;
	Mon, 18 Mar 2024 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EhTnOcyN"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A735C5E2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803185; cv=none; b=Zcir1hJV1OUN04WaEFCbdmsa3l1Zr5hBVdYIenBnvOWMZI2YzB4BMhq+vDtZjAmDmHlKJinzvt1S//67eBlE34vILZM3ksmNgqLJpq7K3/Y3BhMRBOK/gli65XHnTYu5BVFOjbSPnvXRHK5p+fMr0InmRncdKt+QYMOQ9E7y+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803185; c=relaxed/simple;
	bh=+Cqh1qzPeYEo74GQhTU/gUGfVSNhsJVuovVbrxNGMbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAwMlgHgZWVmZy18q56ETarijU0xsvtTKnluVhmIoCyCHGpBjqir+1boUO7Qe8xW7ZibfGo6vuW43gDrYlEbkUonKza4TMsdN4gZMWxk288Ajk5kDUWUoKLjxjDV975LI9Ln9xwFw0nBMMOAjvi+/vB4+TX1jdFdFkYThjhsPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhTnOcyN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513e134f73aso2455535e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710803178; x=1711407978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5DMnVdNWNAjZVL5C6FPpxt5T2+Y0CJYnHB8c35yWXI=;
        b=EhTnOcyNxnQ9KWqQJA+4y79tF0drZvH5lHt9Ej5sYMt8qdRjz5M6M1ASICXkMY2e6n
         TxMp8nZfyUreo4ouSiOhUKUjE4XOgFkM3kHqkLYncJX5yHIwTmQU2STc5SrypOTfAy5i
         DCxK3oZNDvOUX6qRkVnkd71aqoDcBQXAU8BcL7uOWdGzLquwhvgge5AT8U41qF/4cqgS
         auAR5ABXPEd3q30iTG/Thr9S1VEFp+WDLt1LUl1cm1PAw9p+YbKhsuCWoTyIn9TZy89R
         skzGMdNelTuHEXDuotFia7Q2t9RPRfHrtSibLFsbjjCAecHyqTLo9/h7D+LRDzl3xe2b
         SjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710803178; x=1711407978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5DMnVdNWNAjZVL5C6FPpxt5T2+Y0CJYnHB8c35yWXI=;
        b=Gixs7zp/ruZlvCFSx1Y/JaxgP0ePC6t5NxwU8XeAY0D3YGwZIKNm2HNcjvhtp4c/hP
         NWnWoMGCCXRGRZkw7wS136elqywDEvDJyqrapW3R87EYzBhlYMXwvzwxG9xdtIhPFRKM
         /dz5av8W64fkZIo++Pu7v7B9bF3USzSkocdYlOwn1PZ+pMUJeKgJBm83OGTJONg5rGVn
         o827sayTzqDNND1ug7f3VBaLfRYgYemkTQRMT5/tIouSbJJBBInqztfAL0b+AN/RONvJ
         MWuTyFgLUvT8t0cPuaNh+8v8fDUTQuajw3iBoQS+HcTPvxki7j336WV+Osst17JDj+hQ
         TALw==
X-Forwarded-Encrypted: i=1; AJvYcCWdkfDTkwBSysGD2gNMcA6vT5B1imeSIzUdfpMuLhBDFw+uKJD/b361UEWVbrUlcozQ+Vg5d/tmFjw+BERtn0b+LoKIAF8twsY8I3+w
X-Gm-Message-State: AOJu0YwSubNVQO/qY6Un8QSJ04nvPSw5wBID04JEmfNnpyiwrU9PE7OD
	2VQ/lhSkW+WDXR5i9+TtRT3Y/x0bFKuhMYDEwOu6NnhwJO1M2t0EY3dktKacCCfmWcHMrac+Ghd
	+cePWXGhplmUwg2fiqYAL2jlJiIVI4y0R7Yus
X-Google-Smtp-Source: AGHT+IFkQbfmpv0p+UcuSWZwdlOWXXOaryvIuFb0BgE3vuS9qef7LvmE3AHHqKPmdzhNvdVAyeKnuxjvFcHFxtklfNE=
X-Received: by 2002:ac2:5b03:0:b0:513:b159:e711 with SMTP id
 v3-20020ac25b03000000b00513b159e711mr725670lfn.4.1710803177916; Mon, 18 Mar
 2024 16:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318230013.87543-1-21cnbao@gmail.com>
In-Reply-To: <20240318230013.87543-1-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Mar 2024 16:05:40 -0700
Message-ID: <CAJD7tkYVJHsWoaEkTiTigJRzSNBrRSg3YVAL3Q5Q96cLSNJZrQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix kernel BUG in sg_init_one
To: Barry Song <21cnbao@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org, 
	chrisl@kernel.org, v-songbaohua@oppo.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ira.weiny@intel.com, 
	syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 4:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> sg_init_one() relies on linearly mapped low memory for the safe
> utilization of virt_to_page(). Consequently, we have two choices:
> either employ kmap_to_page() alongside sg_set_page(), or resort to
> copying high memory contents to a temporary buffer residing in low
> memory. However, considering the introduction of the WARN_ON_ONCE
> in commit ef6e06b2ef870 ("highmem: fix kmap_to_page() for
> kmap_local_page() addresses"), which specifically addresses high
> memory concerns, it appears that memcpy remains the sole viable
> option.
>
> Reported-and-tested-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail=
com
> Closes: https://lore.kernel.org/all/000000000000bbb3d80613f243a6@google.c=
om/
> Fixes: 270700dd06ca ("mm/zswap: remove the memcpy if acomp is not sleepab=
le")
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/zswap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9dec853647c8..17bf6d87b274 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1080,7 +1080,8 @@ static void zswap_decompress(struct zswap_entry *en=
try, struct page *page)
>         mutex_lock(&acomp_ctx->mutex);
>
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> -       if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
> +       if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) |=
|
> +           !virt_addr_valid(src)) {


Would it be better to explicitly check is_kmap_addr() here? I am
particularly worried about hiding a bug where the returned address
from zpool_map_handle() is not a kmap address, but also not a valid
linear mapping address.

If we use is_kmap_addr() here, then the virt_addr_valid() check in
sg_init_one() will catch any non-kmap non-linear mapping addresses.
WDYT? Am I being paranoid? :)

Also, I think a comment would be nice to explain the cases where we
need to use a temporary buffer since we have two different cases now.

>
>                 memcpy(acomp_ctx->buffer, src, entry->length);
>                 src =3D acomp_ctx->buffer;
>                 zpool_unmap_handle(zpool, entry->handle);
> @@ -1094,7 +1095,7 @@ static void zswap_decompress(struct zswap_entry *en=
try, struct page *page)
>         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
>         mutex_unlock(&acomp_ctx->mutex);
>
> -       if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
> +       if (src !=3D acomp_ctx->buffer)
>                 zpool_unmap_handle(zpool, entry->handle);
>  }
>
> --
> 2.34.1
>

