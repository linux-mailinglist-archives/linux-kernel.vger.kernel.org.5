Return-Path: <linux-kernel+bounces-147201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8E78A70EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7342834C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C30131BC0;
	Tue, 16 Apr 2024 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2cX1f/8"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4612BE9F;
	Tue, 16 Apr 2024 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283735; cv=none; b=CQLGcVlIEtwiPTTD47RKb/EsJ0WJS2PbPnuqIt6r88uV9KqK9If+dLBtIpUEBYV8cF6GtcqNcPo6dfs9W9ZB6fZHyL8nmphTUbqKzmrRPw+jrMeBwkeQ3sqv5gHy+P1DVnFoRdV56tPSvGp/zQkoRbtOtsU4ZAPdvvEeVTEsvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283735; c=relaxed/simple;
	bh=xJTZUAnxgcV31l2lk2qqoJPE2M8jusD+gc6I2kuThFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEf1AjueclYDyTOSbfS8T+SLlalPWsGYkIRzbeNJiZm3tUqMN3CXpNL+/ynVjlgPNt5nyQLiPbNHnQMYO4RZeXM7I4yLnAecmCj+zbFMrJI8O2KcUv9n5tJM5GmDLoYgoDdZzQ2DV43NZJ/O87PAdIdR2OdFqg6yhLqiVlj+XmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2cX1f/8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3454fbdd88aso4004782f8f.3;
        Tue, 16 Apr 2024 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713283732; x=1713888532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfqeinlZEWtIXVEkZjds66VVZ8TL7yzBqLVW5+SS5fc=;
        b=i2cX1f/8kayXC5spMaZvlCaQwf0f79sHNgNeBLm9OBpr1fWbS/BVWXbRpGRHh2K/kh
         tSMfsoZjERMEphOcqCkmJZZcnEyoby9z2t84tgWRT4BvT1u1VKe3K0w652kckRH+svt1
         35AS/wPljoQ3II/t+64qHTL3oABoJ1DSgtHMCLXOorWqU2M0jTJNK0GMF23/1J6BAW/r
         6DS8TMV6Fc7tnTql2TZrKNsHmcAsV8xJoRD10H3ypHAuP7EzKg+kNpTLuX7BWEoBEQYr
         v0opZBN7poOeChnFqBUueN2XDr1hvfVxDI5F17C49SR0EAzGi96lrIMw54bEANdjNfMB
         5OVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283732; x=1713888532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfqeinlZEWtIXVEkZjds66VVZ8TL7yzBqLVW5+SS5fc=;
        b=d3t0yC+9t4P/HVTjOsj/yKncYuYZIgETCcANbEKZWO4LcLy+Z/GcNMa1CYh7hgNdJN
         nWnzSjfZohqEEGoE7qBVI6ZuqSb7DSYvcFMucJG3pfx0p9DrmAh+NMm7PDJW3ChlAJ7D
         LeOZSSecs1DgiBfBcgCSOnCNAlU/wXm1F2wWQt6Odm+MMuSqVrscTioizrIsDeanGlU4
         jz5ul+NqvdS0lD1Xcz1ByxbnpO8XImT5avk8xyr6d2MRqU09xJ3KEt58BMneTLIQqplN
         iqKiaLw6E29rDnHmk7i95zH/mSLWQdlRDYfAqwshUS5U4OnAoZQv5QjIpiedSYEczsQV
         Sd/g==
X-Forwarded-Encrypted: i=1; AJvYcCXgrqUJQmgIl+2yj3eS9+CWigwCDyfjbfQdHQNpTSL1kvkGr+ufRPhBDtS2uakn0+/3HYuoWHJpc1NSCNFJo0e5KQSEATvtCuW1GfKJXvoVo323fEDOFSljivZJKa2gHeK/D1A0
X-Gm-Message-State: AOJu0YwRtRn9FKrtybFpuH/1oig2ERU7/8on5dShbU59QfMtdYTVN07a
	au+JIcEqZOFfoh7q6vaDBt8Pi82yyQc0s5hz9MQq+ab2eMJ3SR94XCAsrFPN9UYJV1V5Bu3jJbn
	W4zu/Bt+PaNcQ02iTBd+2ALdw53k=
X-Google-Smtp-Source: AGHT+IGF5abEcTvau2mHvo9SZL7EcchFBWSdkvIwcQqqBgNJB7O3i8rimyfDFs0cfpgylrUUTfGBxVDks5HFfnr/FOY=
X-Received: by 2002:a5d:510f:0:b0:346:cd1c:dc73 with SMTP id
 s15-20020a5d510f000000b00346cd1cdc73mr11149953wrt.46.1713283731429; Tue, 16
 Apr 2024 09:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415131941.51153-1-linyunsheng@huawei.com> <20240415131941.51153-7-linyunsheng@huawei.com>
In-Reply-To: <20240415131941.51153-7-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 16 Apr 2024 09:08:14 -0700
Message-ID: <CAKgT0UdAW9EBh_eauHMArxjUeV-mwC9arZuCYPk=scn5yvW9gQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/15] mm: page_frag: change page_frag_alloc_*
 API to accept align param
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:22=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> When page_frag_alloc_* API doesn't need data alignment, the
> ALIGN() operation is unnecessary, so change page_frag_alloc_*
> API to accept align param instead of align_mask param, and do
> the ALIGN()'ing in the inline helper when needed.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

The vast majority of callers are using this aligned one way or
another. If anything with your recent changes we should probably be
making sure to align the fragsz as well as the offset since most
callers were only using the alignment of the fragsz in order to get
their alignment.

My main concern is that this change implies that most are using an
unaligned setup when it is in fact quite the opposite.

> ---
>  include/linux/page_frag_cache.h | 20 ++++++++++++--------
>  include/linux/skbuff.h          | 12 ++++++------
>  mm/page_frag_cache.c            |  9 ++++-----
>  net/core/skbuff.c               | 12 +++++-------
>  net/rxrpc/txbuf.c               |  5 +++--
>  5 files changed, 30 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 04810d8d6a7d..cc0ede0912f3 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -25,21 +25,25 @@ struct page_frag_cache {
>
>  void page_frag_cache_drain(struct page_frag_cache *nc);
>  void __page_frag_cache_drain(struct page *page, unsigned int count);
> -void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int f=
ragsz,
> -                             gfp_t gfp_mask, unsigned int align_mask);
> +void *page_frag_alloc(struct page_frag_cache *nc, unsigned int fragsz,
> +                     gfp_t gfp_mask);
> +
> +static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
> +                                           unsigned int fragsz, gfp_t gf=
p_mask,
> +                                           unsigned int align)
> +{
> +       nc->offset =3D ALIGN(nc->offset, align);
> +
> +       return page_frag_alloc(nc, fragsz, gfp_mask);
> +}
>

I would rather not have us breaking up the alignment into another
function. It makes this much more difficult to work with. In addition
you are adding offsets without actually adding to the pages which
makes this seem exploitable. Basically just pass an alignment value of
32K and you are forcing a page eviction regardless.

>  static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
>                                           unsigned int fragsz, gfp_t gfp_=
mask,
>                                           unsigned int align)
>  {
>         WARN_ON_ONCE(!is_power_of_2(align));
> -       return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
> -}
>
> -static inline void *page_frag_alloc(struct page_frag_cache *nc,
> -                                   unsigned int fragsz, gfp_t gfp_mask)
> -{
> -       return page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
> +       return __page_frag_alloc_align(nc, fragsz, gfp_mask, align);
>  }
>
>  void page_frag_free(void *addr);
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index f2dc1f735c79..43c704589deb 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3268,7 +3268,7 @@ static inline void skb_queue_purge(struct sk_buff_h=
ead *list)
>  unsigned int skb_rbtree_purge(struct rb_root *root);
>  void skb_errqueue_purge(struct sk_buff_head *list);
>
> -void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_=
mask);
> +void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align)=
;
>
>  /**
>   * netdev_alloc_frag - allocate a page fragment
> @@ -3279,14 +3279,14 @@ void *__netdev_alloc_frag_align(unsigned int frag=
sz, unsigned int align_mask);
>   */
>  static inline void *netdev_alloc_frag(unsigned int fragsz)
>  {
> -       return __netdev_alloc_frag_align(fragsz, ~0u);
> +       return __netdev_alloc_frag_align(fragsz, 1u);
>  }
>
>  static inline void *netdev_alloc_frag_align(unsigned int fragsz,
>                                             unsigned int align)
>  {
>         WARN_ON_ONCE(!is_power_of_2(align));
> -       return __netdev_alloc_frag_align(fragsz, -align);
> +       return __netdev_alloc_frag_align(fragsz, align);
>  }
>
>  struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int =
length,
> @@ -3346,18 +3346,18 @@ static inline void skb_free_frag(void *addr)
>         page_frag_free(addr);
>  }
>
> -void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_ma=
sk);
> +void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align);
>
>  static inline void *napi_alloc_frag(unsigned int fragsz)
>  {
> -       return __napi_alloc_frag_align(fragsz, ~0u);
> +       return __napi_alloc_frag_align(fragsz, 1u);
>  }
>
>  static inline void *napi_alloc_frag_align(unsigned int fragsz,
>                                           unsigned int align)
>  {
>         WARN_ON_ONCE(!is_power_of_2(align));
> -       return __napi_alloc_frag_align(fragsz, -align);
> +       return __napi_alloc_frag_align(fragsz, align);
>  }
>
>  struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int le=
ngth);
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index dc864ee09536..b4408187e1ab 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -61,9 +61,8 @@ void __page_frag_cache_drain(struct page *page, unsigne=
d int count)
>  }
>  EXPORT_SYMBOL(__page_frag_cache_drain);
>
> -void *__page_frag_alloc_align(struct page_frag_cache *nc,
> -                             unsigned int fragsz, gfp_t gfp_mask,
> -                             unsigned int align_mask)
> +void *page_frag_alloc(struct page_frag_cache *nc, unsigned int fragsz,
> +                     gfp_t gfp_mask)
>  {
>         unsigned int size, offset;
>         struct page *page;
> @@ -92,7 +91,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *n=
c,
>         size =3D PAGE_SIZE;
>  #endif
>
> -       offset =3D ALIGN(nc->offset, -align_mask);
> +       offset =3D nc->offset;
>         if (unlikely(offset + fragsz > size)) {
>                 page =3D virt_to_page(nc->va);
>
> @@ -129,7 +128,7 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>
>         return nc->va + offset;
>  }
> -EXPORT_SYMBOL(__page_frag_alloc_align);
> +EXPORT_SYMBOL(page_frag_alloc);
>
>  /*
>   * Frees a page fragment allocated out of either a compound or order 0 p=
age.
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ea052fa710d8..676e2d857f02 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -306,18 +306,17 @@ void napi_get_frags_check(struct napi_struct *napi)
>         local_bh_enable();
>  }
>
> -void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_ma=
sk)
> +void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align)
>  {
>         struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
>
>         fragsz =3D SKB_DATA_ALIGN(fragsz);
>

So this is a perfect example. This caller is aligning the size by
SMP_CACHE_BYTES. This is the most typical case. Either this or
L1_CACHE_BYTES. As such all requests should be aligned to at least
that. I would prefer it if we didn't strip the alignment code out of
our main allocating function. If anything, maybe we should make it
more specific that the expectation is that fragsz is a multiple of the
alignment.

> -       return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
> -                                      align_mask);
> +       return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, ali=
gn);
>  }
>  EXPORT_SYMBOL(__napi_alloc_frag_align);
>
> -void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_=
mask)
> +void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align)
>  {
>         void *data;
>
> @@ -325,15 +324,14 @@ void *__netdev_alloc_frag_align(unsigned int fragsz=
, unsigned int align_mask)
>         if (in_hardirq() || irqs_disabled()) {
>                 struct page_frag_cache *nc =3D this_cpu_ptr(&netdev_alloc=
_cache);
>
> -               data =3D __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC,
> -                                              align_mask);
> +               data =3D __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, =
align);
>         } else {
>                 struct napi_alloc_cache *nc;
>
>                 local_bh_disable();
>                 nc =3D this_cpu_ptr(&napi_alloc_cache);
>                 data =3D __page_frag_alloc_align(&nc->page, fragsz, GFP_A=
TOMIC,
> -                                              align_mask);
> +                                              align);
>                 local_bh_enable();
>         }
>         return data;
> diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
> index e0679658d9de..eb640875bf07 100644
> --- a/net/rxrpc/txbuf.c
> +++ b/net/rxrpc/txbuf.c
> @@ -32,9 +32,10 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrp=
c_call *call, size_t data_
>                 hoff =3D round_up(sizeof(*whdr), data_align) - sizeof(*wh=
dr);
>         total =3D hoff + sizeof(*whdr) + data_size;
>
> +       data_align =3D max_t(size_t, data_align, L1_CACHE_BYTES);
>         mutex_lock(&call->conn->tx_data_alloc_lock);
> -       buf =3D __page_frag_alloc_align(&call->conn->tx_data_alloc, total=
, gfp,
> -                                     ~(data_align - 1) & ~(L1_CACHE_BYTE=
S - 1));
> +       buf =3D page_frag_alloc_align(&call->conn->tx_data_alloc, total, =
gfp,
> +                                   data_align);
>         mutex_unlock(&call->conn->tx_data_alloc_lock);
>         if (!buf) {
>                 kfree(txb);
> --
> 2.33.0
>

