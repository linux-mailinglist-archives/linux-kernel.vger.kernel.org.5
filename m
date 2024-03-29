Return-Path: <linux-kernel+bounces-125325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C11892424
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A215E1F22CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DECD13792C;
	Fri, 29 Mar 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yt4elsuM"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9A38DD3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740095; cv=none; b=JqzyJoBCKGMQESbZIHa7mXFyBGYBh/8KrbZKZaF1yP4Ia9f4sTSRInPmk/PmH1VbkMqgESQX0bkEQt2buUpzGXHDOcHCPJdWnwqa5eY0YVInaInDsHkLJc3tjtNVAyRf86rwtrtq8JG029cmLEVsSvufJeXqBuEWa0Gjzn1REFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740095; c=relaxed/simple;
	bh=z9muOLD4VTRTTtoA2n3Iii3jbaZl7oRfgDZtnT6IBMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlJ/UJMgYrcXL0gtbhgKqrcP7Vh2ZPyuTDtdHA8bGAxEEn9Mn2X3x2Sm0Wk8Rff+XCyNl/oaxe5Hno0Uhnwh750E1V/vEqK9FFGvAAoQQdKzjSJ90RzWyEfLt36seXurTHO8JNm314KDaRm3cmQFidxuNcOxPafIjdAYk/whbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yt4elsuM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c2b4850d2so2739504a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711740090; x=1712344890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukyfBf8M/PO6667GafeepUwISCf+nSxV6YEdiRrfH9E=;
        b=Yt4elsuM/z3qunJikbD/qmFGZLN7222ZQ8JB1RrLfBRkfNp4PIAg05ppgU4MsvawP/
         zYoAOiU/Tt7IraObOpyQsszDEmMiyWCUZAGn9Ni7f86rTW6Ka+ABIzKFqjL2sPGtGAVg
         8Yy0c7uQa76dZhQ4wGQXNceyd5Ll5RYW1l6kzbnqt3NXp8oh6WDC7DZ4SQg/EXSToxA9
         +hvkB94yEIpbvuA4tci0dqa9Af1SpTtUZapHt4bhpJH1mC9tbCXpqG9ACQuwKy3LopJU
         Bo6Hw2y9SX3lOi5VeHjkMeN2SAyZwyvjSYmKBWfjXLg5qrF2uw5uUd5zUGN7emWMY7FQ
         +2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740090; x=1712344890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukyfBf8M/PO6667GafeepUwISCf+nSxV6YEdiRrfH9E=;
        b=FPd1jNC5fVH1lbdvoi1oz1Y68SNlkOYQYcS0fyvOkmityBjv6cpqk2Qh17qlXXeFE6
         7Od8BehvYOlRVJaf30zJqqlqxuEpH01r/cA9OJUctA+XOZgi9PkeJHaggKY6/wK1ud+L
         CwOBFpnCmHxxWXiltCuTE+vxtwyRFWhKmanOiy7s8F64l2gB5n+2MsTjwqrCCiRappfP
         qPj/Sy8lyDf6TVSKZTazVil//z5qbH8jTjh4E2z/5nDPblBuA5P25St+4gWqwOoIWuPU
         BThc8LIEb4tR8m0pYpu0t/SPaIi9E+3g0fTSqiGnRuGcvMDLZH9LhrB3YrmMkUqS3rGW
         qVMg==
X-Forwarded-Encrypted: i=1; AJvYcCWcftDgb2KYLVASdD1m8L7/eIuRzzOrHP2f+k69K12+aWQtkC0VGFF2A1WLW0nzNWAIPb0YklaYocRyvhJVf2RgXb1+5GzLE53YM0MK
X-Gm-Message-State: AOJu0Yw5Y4k8orFnLAKqsTiuEDvIlUAfG3NS96MSrIEr6m9CB72jIiEc
	NzDOtd07xdrkmci8ZMSQ0k49BbSymq+ogdeYo0RRQ1I5d/uAcf3kX4eziDLXoVUhBQnsXiZRrI9
	6owkGm12q1pc3ycZ40z0N/iEonYpc53SqzVuc
X-Google-Smtp-Source: AGHT+IExaXZuDizLOA3l/cHfVXumWOO9aiqMNqLjd2VLeN5LRXv9r2GsRAyf4zcErY61bUzLMIfdB/8nsJDPVmf15HY=
X-Received: by 2002:a17:906:a3d3:b0:a4e:4518:dbc5 with SMTP id
 ca19-20020a170906a3d300b00a4e4518dbc5mr345862ejb.8.1711740089591; Fri, 29 Mar
 2024 12:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329165507.3240110-1-aleksander.lobakin@intel.com> <20240329165507.3240110-2-aleksander.lobakin@intel.com>
In-Reply-To: <20240329165507.3240110-2-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 29 Mar 2024 12:21:15 -0700
Message-ID: <CAHS8izOMudLgV2HstD4O1HUL1A35UT58os3n-boMzs=rW4wJAg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] page_pool: check for PP direct cache
 locality later
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 9:56=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Since we have pool->p.napi (Jakub) and pool->cpuid (Lorenzo) to check
> whether it's safe to use direct recycling, we can use both globally for
> each page instead of relying solely on @allow_direct argument.
> Let's assume that @allow_direct means "I'm sure it's local, don't waste
> time rechecking this" and when it's false, try the mentioned params to
> still recycle the page directly. If neither is true, we'll lose some
> CPU cycles, but then it surely won't be hotpath. On the other hand,
> paths where it's possible to use direct cache, but not possible to
> safely set @allow_direct, will benefit from this move.
> The whole propagation of @napi_safe through a dozen of skb freeing
> functions can now go away, which saves us some stack space.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/skbuff.h | 12 ++++----
>  net/core/page_pool.c   | 31 +++++++++++++++++--
>  net/core/skbuff.c      | 70 +++++++++++++-----------------------------
>  net/ipv4/esp4.c        |  2 +-
>  net/ipv6/esp6.c        |  2 +-
>  5 files changed, 58 insertions(+), 59 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index dadd3f55d549..f7f6e42c6814 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3515,25 +3515,25 @@ int skb_pp_cow_data(struct page_pool *pool, struc=
t sk_buff **pskb,
>                     unsigned int headroom);
>  int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
>                          struct bpf_prog *prog);
> -bool napi_pp_put_page(struct page *page, bool napi_safe);
> +bool napi_pp_put_page(struct page *page);
>
>  static inline void
> -skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_s=
afe)
> +skb_page_unref(const struct sk_buff *skb, struct page *page)
>  {
>  #ifdef CONFIG_PAGE_POOL
> -       if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
> +       if (skb->pp_recycle && napi_pp_put_page(page))
>                 return;
>  #endif
>         put_page(page);
>  }
>
>  static inline void
> -napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
> +napi_frag_unref(skb_frag_t *frag, bool recycle)
>  {
>         struct page *page =3D skb_frag_page(frag);
>
>  #ifdef CONFIG_PAGE_POOL
> -       if (recycle && napi_pp_put_page(page, napi_safe))
> +       if (recycle && napi_pp_put_page(page))
>                 return;
>  #endif
>         put_page(page);
> @@ -3549,7 +3549,7 @@ napi_frag_unref(skb_frag_t *frag, bool recycle, boo=
l napi_safe)
>   */
>  static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
>  {
> -       napi_frag_unref(frag, recycle, false);
> +       napi_frag_unref(frag, recycle);
>  }
>
>  /**
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index dd364d738c00..9d56257e444b 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -690,8 +690,7 @@ __page_pool_put_page(struct page_pool *pool, struct p=
age *page,
>                         page_pool_dma_sync_for_device(pool, page,
>                                                       dma_sync_size);
>
> -               if (allow_direct && in_softirq() &&
> -                   page_pool_recycle_in_cache(page, pool))
> +               if (allow_direct && page_pool_recycle_in_cache(page, pool=
))
>                         return NULL;
>
>                 /* Page found as candidate for recycling */
> @@ -716,9 +715,35 @@ __page_pool_put_page(struct page_pool *pool, struct =
page *page,
>         return NULL;
>  }
>
> +static bool page_pool_napi_local(const struct page_pool *pool)
> +{
> +       const struct napi_struct *napi;
> +       u32 cpuid;
> +
> +       if (unlikely(!in_softirq()))
> +               return false;
> +
> +       /* Allow direct recycle if we have reasons to believe that we are
> +        * in the same context as the consumer would run, so there's
> +        * no possible race.
> +        * __page_pool_put_page() makes sure we're not in hardirq context
> +        * and interrupts are enabled prior to accessing the cache.
> +        */
> +       cpuid =3D smp_processor_id();
> +       if (READ_ONCE(pool->cpuid) =3D=3D cpuid)
> +               return true;
> +
> +       napi =3D READ_ONCE(pool->p.napi);
> +
> +       return napi && READ_ONCE(napi->list_owner) =3D=3D cpuid;
> +}
> +
>  void page_pool_put_unrefed_page(struct page_pool *pool, struct page *pag=
e,
>                                 unsigned int dma_sync_size, bool allow_di=
rect)
>  {
> +       if (!allow_direct)
> +               allow_direct =3D page_pool_napi_local(pool);
> +
>         page =3D __page_pool_put_page(pool, page, dma_sync_size, allow_di=
rect);
>         if (page && !page_pool_recycle_in_ring(pool, page)) {
>                 /* Cache full, fallback to free pages */
> @@ -969,7 +994,7 @@ void page_pool_use_xdp_mem(struct page_pool *pool, vo=
id (*disconnect)(void *),
>  static void page_pool_disable_direct_recycling(struct page_pool *pool)
>  {
>         /* Disable direct recycling based on pool->cpuid.
> -        * Paired with READ_ONCE() in napi_pp_put_page().
> +        * Paired with READ_ONCE() in page_pool_napi_local().
>          */
>         WRITE_ONCE(pool->cpuid, -1);
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index e0e172638c0a..e01e2a618621 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1005,11 +1005,8 @@ int skb_cow_data_for_xdp(struct page_pool *pool, s=
truct sk_buff **pskb,
>  EXPORT_SYMBOL(skb_cow_data_for_xdp);
>
>  #if IS_ENABLED(CONFIG_PAGE_POOL)
> -bool napi_pp_put_page(struct page *page, bool napi_safe)
> +bool napi_pp_put_page(struct page *page)
>  {
> -       bool allow_direct =3D false;
> -       struct page_pool *pp;
> -
>         page =3D compound_head(page);
>
>         /* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
> @@ -1022,39 +1019,18 @@ bool napi_pp_put_page(struct page *page, bool nap=
i_safe)
>         if (unlikely(!is_pp_page(page)))
>                 return false;
>
> -       pp =3D page->pp;
> -
> -       /* Allow direct recycle if we have reasons to believe that we are
> -        * in the same context as the consumer would run, so there's
> -        * no possible race.
> -        * __page_pool_put_page() makes sure we're not in hardirq context
> -        * and interrupts are enabled prior to accessing the cache.
> -        */
> -       if (napi_safe || in_softirq()) {
> -               const struct napi_struct *napi =3D READ_ONCE(pp->p.napi);
> -               unsigned int cpuid =3D smp_processor_id();
> -
> -               allow_direct =3D napi && READ_ONCE(napi->list_owner) =3D=
=3D cpuid;
> -               allow_direct |=3D READ_ONCE(pp->cpuid) =3D=3D cpuid;
> -       }
> -
> -       /* Driver set this to memory recycling info. Reset it on recycle.
> -        * This will *not* work for NIC using a split-page memory model.
> -        * The page will be returned to the pool here regardless of the
> -        * 'flipped' fragment being in use or not.
> -        */
> -       page_pool_put_full_page(pp, page, allow_direct);
> +       page_pool_put_full_page(page->pp, page, false);
>
>         return true;
>  }
>  EXPORT_SYMBOL(napi_pp_put_page);
>  #endif
>
> -static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_sa=
fe)
> +static bool skb_pp_recycle(struct sk_buff *skb, void *data)
>  {
>         if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
>                 return false;
> -       return napi_pp_put_page(virt_to_page(data), napi_safe);
> +       return napi_pp_put_page(virt_to_page(data));
>  }
>
>  /**
> @@ -1096,12 +1072,12 @@ static void skb_kfree_head(void *head, unsigned i=
nt end_offset)
>                 kfree(head);
>  }
>
> -static void skb_free_head(struct sk_buff *skb, bool napi_safe)
> +static void skb_free_head(struct sk_buff *skb)
>  {
>         unsigned char *head =3D skb->head;
>
>         if (skb->head_frag) {
> -               if (skb_pp_recycle(skb, head, napi_safe))
> +               if (skb_pp_recycle(skb, head))
>                         return;
>                 skb_free_frag(head);
>         } else {
> @@ -1109,8 +1085,7 @@ static void skb_free_head(struct sk_buff *skb, bool=
 napi_safe)
>         }
>  }
>
> -static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason r=
eason,
> -                            bool napi_safe)
> +static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason r=
eason)
>  {
>         struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>         int i;
> @@ -1127,13 +1102,13 @@ static void skb_release_data(struct sk_buff *skb,=
 enum skb_drop_reason reason,

skb_release_data has a napi_safe argument. Do you want to remove that
as well? To my eye it looks like dead code now that the value is not
passed to napi_frag_unref and skb_free_head.

After this change, __napi_kfree_skb() which previously set napi_safe
to true, now isn't able to. Is my understanding correct that this
should still work fine because we now check pool->p.napi in the
page_pool code?

>         }
>
>         for (i =3D 0; i < shinfo->nr_frags; i++)
> -               napi_frag_unref(&shinfo->frags[i], skb->pp_recycle, napi_=
safe);
> +               napi_frag_unref(&shinfo->frags[i], skb->pp_recycle);
>
>  free_head:
>         if (shinfo->frag_list)
>                 kfree_skb_list_reason(shinfo->frag_list, reason);
>
> -       skb_free_head(skb, napi_safe);
> +       skb_free_head(skb);
>  exit:
>         /* When we clone an SKB we copy the reycling bit. The pp_recycle
>          * bit is only set on the head though, so in order to avoid races
> @@ -1194,12 +1169,11 @@ void skb_release_head_state(struct sk_buff *skb)
>  }
>
>  /* Free everything but the sk_buff shell. */
> -static void skb_release_all(struct sk_buff *skb, enum skb_drop_reason re=
ason,
> -                           bool napi_safe)
> +static void skb_release_all(struct sk_buff *skb, enum skb_drop_reason re=
ason)
>  {
>         skb_release_head_state(skb);
>         if (likely(skb->head))
> -               skb_release_data(skb, reason, napi_safe);
> +               skb_release_data(skb, reason);
>  }
>
>  /**
> @@ -1213,7 +1187,7 @@ static void skb_release_all(struct sk_buff *skb, en=
um skb_drop_reason reason,
>
>  void __kfree_skb(struct sk_buff *skb)
>  {
> -       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
> +       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED);
>         kfree_skbmem(skb);
>  }
>  EXPORT_SYMBOL(__kfree_skb);
> @@ -1270,7 +1244,7 @@ static void kfree_skb_add_bulk(struct sk_buff *skb,
>                 return;
>         }
>
> -       skb_release_all(skb, reason, false);
> +       skb_release_all(skb, reason);
>         sa->skb_array[sa->skb_count++] =3D skb;
>
>         if (unlikely(sa->skb_count =3D=3D KFREE_SKB_BULK_SIZE)) {
> @@ -1444,7 +1418,7 @@ EXPORT_SYMBOL(consume_skb);
>  void __consume_stateless_skb(struct sk_buff *skb)
>  {
>         trace_consume_skb(skb, __builtin_return_address(0));
> -       skb_release_data(skb, SKB_CONSUMED, false);
> +       skb_release_data(skb, SKB_CONSUMED);
>         kfree_skbmem(skb);
>  }
>
> @@ -1471,7 +1445,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
>
>  void __napi_kfree_skb(struct sk_buff *skb, enum skb_drop_reason reason)
>  {
> -       skb_release_all(skb, reason, true);
> +       skb_release_all(skb, reason);
>         napi_skb_cache_put(skb);
>  }
>
> @@ -1509,7 +1483,7 @@ void napi_consume_skb(struct sk_buff *skb, int budg=
et)
>                 return;
>         }
>
> -       skb_release_all(skb, SKB_CONSUMED, !!budget);
> +       skb_release_all(skb, SKB_CONSUMED);
>         napi_skb_cache_put(skb);
>  }
>  EXPORT_SYMBOL(napi_consume_skb);
> @@ -1640,7 +1614,7 @@ EXPORT_SYMBOL_GPL(alloc_skb_for_msg);
>   */
>  struct sk_buff *skb_morph(struct sk_buff *dst, struct sk_buff *src)
>  {
> -       skb_release_all(dst, SKB_CONSUMED, false);
> +       skb_release_all(dst, SKB_CONSUMED);
>         return __skb_clone(dst, src);
>  }
>  EXPORT_SYMBOL_GPL(skb_morph);
> @@ -2272,9 +2246,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead=
, int ntail,
>                 if (skb_has_frag_list(skb))
>                         skb_clone_fraglist(skb);
>
> -               skb_release_data(skb, SKB_CONSUMED, false);
> +               skb_release_data(skb, SKB_CONSUMED);
>         } else {
> -               skb_free_head(skb, false);
> +               skb_free_head(skb);
>         }
>         off =3D (data + nhead) - skb->head;
>
> @@ -6575,12 +6549,12 @@ static int pskb_carve_inside_header(struct sk_buf=
f *skb, const u32 off,
>                         skb_frag_ref(skb, i);
>                 if (skb_has_frag_list(skb))
>                         skb_clone_fraglist(skb);
> -               skb_release_data(skb, SKB_CONSUMED, false);
> +               skb_release_data(skb, SKB_CONSUMED);
>         } else {
>                 /* we can reuse existing recount- all we did was
>                  * relocate values
>                  */
> -               skb_free_head(skb, false);
> +               skb_free_head(skb);
>         }
>
>         skb->head =3D data;
> @@ -6715,7 +6689,7 @@ static int pskb_carve_inside_nonlinear(struct sk_bu=
ff *skb, const u32 off,
>                 skb_kfree_head(data, size);
>                 return -ENOMEM;
>         }
> -       skb_release_data(skb, SKB_CONSUMED, false);
> +       skb_release_data(skb, SKB_CONSUMED);
>
>         skb->head =3D data;
>         skb->head_frag =3D 0;
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index d33d12421814..3d647c9a7a21 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void =
*tmp, struct sk_buff *skb)
>          */
>         if (req->src !=3D req->dst)
>                 for (sg =3D sg_next(req->src); sg; sg =3D sg_next(sg))
> -                       skb_page_unref(skb, sg_page(sg), false);
> +                       skb_page_unref(skb, sg_page(sg));
>  }
>
>  #ifdef CONFIG_INET_ESPINTCP
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index 7371886d4f9f..fe8d53f5a5ee 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void =
*tmp, struct sk_buff *skb)
>          */
>         if (req->src !=3D req->dst)
>                 for (sg =3D sg_next(req->src); sg; sg =3D sg_next(sg))
> -                       skb_page_unref(skb, sg_page(sg), false);
> +                       skb_page_unref(skb, sg_page(sg));
>  }
>
>  #ifdef CONFIG_INET6_ESPINTCP
> --
> 2.44.0
>
>


--=20
Thanks,
Mina

