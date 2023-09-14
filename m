Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429247A08D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbjINPSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbjINPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAFB61FD2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694704635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBHXLcuV4EPqLOuVGuSZ2vgBmxBMgNfH5q8svpMWRW4=;
        b=UBWoeL3/NlEnHu9PXV10oocxlTtTJpsgDq/V48FOTUyMjSWZZipL6j+uBUdyusGvq105w8
        DYPu+MFPlqx/lO3P0MOWBlu3G1KmX+D9ryAaObjZFIS6boOOn0EbNO25yTb3uRPN79DdIn
        QxPcXWUFqIEFQqV7MSGjUfmlKc24WvI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-zImDVOYpMY-_pKleY1MVAw-1; Thu, 14 Sep 2023 11:17:14 -0400
X-MC-Unique: zImDVOYpMY-_pKleY1MVAw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-502d8606cebso243503e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704632; x=1695309432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBHXLcuV4EPqLOuVGuSZ2vgBmxBMgNfH5q8svpMWRW4=;
        b=nohTmqxVWqnOASoDXVIJZinzfidLG/oowpyt3Mox+Al3vvdZFVeSBuBQE++y6EgeCS
         tdC3m7domWLUnwZ2iDyZEnw0AAgtV4If10/wGSJY0KR7XD/547kNQv3EjUkwmdF3On2K
         hKek3oGw9zF0DSr6fJYf0JOh+wdKipANiNZ0XqTdqwYdrgg9bDX46S6VIkFO5kaVGJva
         FsvhXVsMd7IMEnlXE3u+yJABT2pOGDQkjwdbZUehArvFZNmXcw/uzzONxFZ58Uq4ei20
         7/p+nLRJW4NDn3o5ivUWM38K3ZM1ce1m+ocxMRsP1dqXAVKELkcSMF/KykGSqbGXFffz
         Fhbg==
X-Gm-Message-State: AOJu0YykckEsZDzJxUyr/oRbKhk6J1mv5X4E3wKklzc8nJROnYyhkdSX
        YSAZ4tr5NWdT0/KOP2QSdGh8ZtlwISl8Ia8DtUv/J4eBKZOYLCwYTfPKDrvHEKwuFSSRbLLbXv1
        GlgV2J2VIeAELXpSKxF6GFGTq
X-Received: by 2002:ac2:488d:0:b0:502:d7fe:46f0 with SMTP id x13-20020ac2488d000000b00502d7fe46f0mr4370580lfc.0.1694704632706;
        Thu, 14 Sep 2023 08:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsU0DDT6yb3BujGwrIOC4cHfjRDtzTfEejwVQRucm650X7K6Lu5bFm3ku0G5LtBzXT6cTgCA==
X-Received: by 2002:ac2:488d:0:b0:502:d7fe:46f0 with SMTP id x13-20020ac2488d000000b00502d7fe46f0mr4370560lfc.0.1694704632270;
        Thu, 14 Sep 2023 08:17:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-187.dyn.eolo.it. [146.241.242.187])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7cd4a000000b0052333d7e320sm1033353edw.27.2023.09.14.08.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:17:11 -0700 (PDT)
Message-ID: <9e53ca46be34f3c393861b7a645bb25f0b03f1d2.camel@redhat.com>
Subject: Re: [PATCH net-next v8 2/6] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Date:   Thu, 14 Sep 2023 17:17:10 +0200
In-Reply-To: <20230912083126.65484-3-linyunsheng@huawei.com>
References: <20230912083126.65484-1-linyunsheng@huawei.com>
         <20230912083126.65484-3-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-12 at 16:31 +0800, Yunsheng Lin wrote:
> Currently when page_pool_create() is called with
> PP_FLAG_PAGE_FRAG flag, page_pool_alloc_pages() is only
> allowed to be called under the below constraints:
> 1. page_pool_fragment_page() need to be called to setup
>    page->pp_frag_count immediately.
> 2. page_pool_defrag_page() often need to be called to drain
>    the page->pp_frag_count when there is no more user will
>    be holding on to that page.
>=20
> Those constraints exist in order to support a page to be
> split into multi frags.
>=20
> And those constraints have some overhead because of the
> cache line dirtying/bouncing and atomic update.
>=20
> Those constraints are unavoidable for case when we need a
> page to be split into more than one frag, but there is also
> case that we want to avoid the above constraints and their
> overhead when a page can't be split as it can only hold a big
> frag as requested by user, depending on different use cases:
> use case 1: allocate page without page splitting.
> use case 2: allocate page with page splitting.
> use case 3: allocate page with or without page splitting
>             depending on the frag size.
>=20
> Currently page pool only provide page_pool_alloc_pages() and
> page_pool_alloc_frag() API to enable the 1 & 2 separately,
> so we can not use a combination of 1 & 2 to enable 3, it is
> not possible yet because of the per page_pool flag
> PP_FLAG_PAGE_FRAG.
>=20
> So in order to allow allocating unsplit page without the
> overhead of split page while still allow allocating split
> page we need to remove the per page_pool flag in
> page_pool_is_last_frag(), as best as I can think of, it seems
> there are two methods as below:
> 1. Add per page flag/bit to indicate a page is split or
>    not, which means we might need to update that flag/bit
>    everytime the page is recycled, dirtying the cache line
>    of 'struct page' for use case 1.
> 2. Unify the page->pp_frag_count handling for both split and
>    unsplit page by assuming all pages in the page pool is split
>    into a big frag initially.
>=20
> As page pool already supports use case 1 without dirtying the
> cache line of 'struct page' whenever a page is recyclable, we
> need to support the above use case 3 with minimal overhead,
> especially not adding any noticeable overhead for use case 1,
> and we are already doing an optimization by not updating
> pp_frag_count in page_pool_defrag_page() for the last frag
> user, this patch chooses to unify the pp_frag_count handling
> to support the above use case 3.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool/helpers.h | 48 ++++++++++++++++++++++++---------
>  net/core/page_pool.c            | 10 ++++++-
>  2 files changed, 44 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index 8e1c85de4995..0ec81b91bed8 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -115,28 +115,50 @@ static inline long page_pool_defrag_page(struct pag=
e *page, long nr)
>  	long ret;
> =20
>  	/* If nr =3D=3D pp_frag_count then we have cleared all remaining
> -	 * references to the page. No need to actually overwrite it, instead
> -	 * we can leave this to be overwritten by the calling function.
> +	 * references to the page:
> +	 * 1. 'n =3D=3D 1': no need to actually overwrite it.
> +	 * 2. 'n !=3D 1': overwrite it with one, which is the rare case
> +	 *              for frag draining.
>  	 *
> -	 * The main advantage to doing this is that an atomic_read is
> -	 * generally a much cheaper operation than an atomic update,
> -	 * especially when dealing with a page that may be partitioned
> -	 * into only 2 or 3 pieces.
> +	 * The main advantage to doing this is that not only we avoid a
> +	 * atomic update, as an atomic_read is generally a much cheaper
> +	 * operation than an atomic update, especially when dealing with
> +	 * a page that may be partitioned into only 2 or 3 pieces; but
> +	 * also unify the frag and non-frag handling by ensuring all
> +	 * pages have been split into one big frag initially, and only
> +	 * overwrite it when the page is split into more than one frag.
>  	 */
> -	if (atomic_long_read(&page->pp_frag_count) =3D=3D nr)
> +	if (atomic_long_read(&page->pp_frag_count) =3D=3D nr) {
> +		/* As we have ensured nr is always one for constant case
> +		 * using the BUILD_BUG_ON(), only need to handle the
> +		 * non-constant case here for frag count draining, which
> +		 * is a rare case.
> +		 */
> +		BUILD_BUG_ON(__builtin_constant_p(nr) && nr !=3D 1);
> +		if (!__builtin_constant_p(nr))
> +			atomic_long_set(&page->pp_frag_count, 1);
> +
>  		return 0;
> +	}
> =20
>  	ret =3D atomic_long_sub_return(nr, &page->pp_frag_count);
>  	WARN_ON(ret < 0);
> +
> +	/* We are the last user here too, reset frag count back to 1 to
> +	 * ensure all pages have been split into one big frag initially,
> +	 * this should be the rare case when the last two frag users call
> +	 * page_pool_defrag_page() currently.
> +	 */
> +	if (unlikely(!ret))
> +		atomic_long_set(&page->pp_frag_count, 1);
> +
>  	return ret;
>  }
> =20
> -static inline bool page_pool_is_last_frag(struct page_pool *pool,
> -					  struct page *page)
> +static inline bool page_pool_is_last_frag(struct page *page)
>  {
> -	/* If fragments aren't enabled or count is 0 we were the last user */
> -	return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
> -	       (page_pool_defrag_page(page, 1) =3D=3D 0);
> +	/* If page_pool_defrag_page() returns 0, we were the last user */
> +	return page_pool_defrag_page(page, 1) =3D=3D 0;
>  }
> =20
>  /**
> @@ -161,7 +183,7 @@ static inline void page_pool_put_page(struct page_poo=
l *pool,
>  	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
>  	 */
>  #ifdef CONFIG_PAGE_POOL
> -	if (!page_pool_is_last_frag(pool, page))
> +	if (!page_pool_is_last_frag(page))
>  		return;
> =20
>  	page_pool_put_defragged_page(pool, page, dma_sync_size, allow_direct);
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 8a9868ea5067..403b6df2e144 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -376,6 +376,14 @@ static void page_pool_set_pp_info(struct page_pool *=
pool,
>  {
>  	page->pp =3D pool;
>  	page->pp_magic |=3D PP_SIGNATURE;
> +
> +	/* Ensuring all pages have been split into one big frag initially:
> +	 * page_pool_set_pp_info() is only called once for every page when it
> +	 * is allocated from the page allocator and page_pool_fragment_page()
> +	 * is dirtying the same cache line as the page->pp_magic above, so
> +	 * the overhead is negligible.
> +	 */
> +	page_pool_fragment_page(page, 1);
>  	if (pool->p.init_callback)
>  		pool->p.init_callback(page, pool->p.init_arg);
>  }

I think it would be nice backing the above claim with some benchmarks.
(possibly even just a micro-benchmark around the relevant APIs)
and include such info into the changelog message.

Cheers,

Paolo

