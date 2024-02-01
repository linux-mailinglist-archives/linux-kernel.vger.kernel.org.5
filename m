Return-Path: <linux-kernel+bounces-48214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574A68458A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C528619C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE65B694;
	Thu,  1 Feb 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0q2xZ1J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9886656
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793410; cv=none; b=dQ3Wr4ZssEhxih2K2y0iCSEwyxpQNijm1pWaRxVpCQNKt0SYChLslQhHxhxAQvL9wKh1B5yNvHQr22kys+nOLM9TOPORv9jSFMXdtSv5GnzzofsiZ75BeGmiKkjEr0csrbp3+JjhYkC1YHbiPcScPHWIbODgysW9qq1XGj+lu2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793410; c=relaxed/simple;
	bh=Pqs4CmHcJTvjKUKMbF/8pbQGlcSxxLL85y3R5LIPnuk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4Jjpg2darfgNUsicNuZBT1Xc0HueOLstguCNsQUSpYPiT93uehl38Gbdh4OWqqf6Frt+Zx7MpUYxy/3cGyP9zNtAl7J6nGZnsq+/qkHiD95r7xcAwhR9BmWbJrwsU473lHoMtGTCoASZBLAbVwkUnkqmAWevEg6tJuiKjzP9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0q2xZ1J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706793405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jMyGzesJ/z8ohl7KVzA66xKH8S456nUXduHOJbN1y64=;
	b=I0q2xZ1JPeTijiWgzh9f/nuCWh6dhIVVt65kMldNn+1Rf58/2PHTfmUSgCIoGiBvc/cbkq
	VNTdUy8WqOWRnYE4UU5FlbB8358T9s1CUZMw2CGBG+9RjKNP40IHHOldc55zNnVhYgGbfd
	6DdNZuWC3FLM1bTkYmBz3TuzD928xXM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-cf-qmy20Pv2YfuHntHtwPw-1; Thu, 01 Feb 2024 08:16:44 -0500
X-MC-Unique: cf-qmy20Pv2YfuHntHtwPw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40f02c4aa13so985335e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 05:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706793403; x=1707398203;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMyGzesJ/z8ohl7KVzA66xKH8S456nUXduHOJbN1y64=;
        b=G000fbzkPoTbq/lIGzy5Hq7xxwNFBbRJcc9+HPJC2+jx7NFuENEVDxWVI9zTN0dhkV
         i0mA0EsxYovCjyfUH8tEkt1xs97A4I1ijyOZfm7OvZg5lkk1CXo0RWn4ETw2eovDNKfi
         0X5hJoG0OXzFzac2tvgzUXFD3ef2TEJjF0St6vj4eRgGqVdOMJOuVrY3nAWnPemWYT6a
         Trc5EZJEkv5W7ijLm75lSf8FHOAQ//JYF5R0ZeTdgPaGfs4PHWIheqnFPGXvKXQlfs2W
         QmAXJO5QntKRSwVn4DEOMD+m1Wfug081Xrcnbf5RhnUvbShF9sFGqfiONpbfPZjvKabd
         hO+Q==
X-Forwarded-Encrypted: i=0; AJvYcCVRPjQMVpvrCx398NInyfvFG2lGzNdOlSeXgGtPAQYruPtoe6vxMa7HMqGIoiUvOSrScKexbER3X0DmD+JxX4dRczsDzP7j46KEPRkf
X-Gm-Message-State: AOJu0YwCg4yeGSnKOHTFbEGxsWsniBJE+ClgfP9+CKTEbHSC1/3bnBp7
	E9hk0ade5LFa2kL3QVQ5jq+JAO5EBCN3cp2qtokWV60gwCOKL1QBn95OLP9gfdigJefRDl43HoK
	q25Knhb1mrbE0iqtiKVp6/APG9xBC3T8MR+59xaLwjo9qjmcf7GrfeuJC6Gz6Fg==
X-Received: by 2002:a05:600c:1da7:b0:40f:c34a:a3d with SMTP id p39-20020a05600c1da700b0040fc34a0a3dmr33682wms.0.1706793403505;
        Thu, 01 Feb 2024 05:16:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRAP06jOZUsEI+yRVHfvK8CImFGDMYPJywrkavL8JrVIwIzD/C3rG4c8k0WemoaSiruOb2tg==
X-Received: by 2002:a05:600c:1da7:b0:40f:c34a:a3d with SMTP id p39-20020a05600c1da700b0040fc34a0a3dmr33661wms.0.1706793403155;
        Thu, 01 Feb 2024 05:16:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW/Q05nEw2lfWAkFO9uaW6nkg2bEEKXGAGM3SkT1AB0V3ltWfKX+AQvuT92xi2K4H3IlB6XREOOyleaRRrBpWkMvXCZ2LCBcOusk9kkhqxMcW/dZ8A082SMtU317vKxKxKlKs7sya+Codh5edzTsSNxZGpdRy6AC4Pzd691XyLICnyHCnCVs8q6KQraV6zI7b/r19+ZJcBxvdU9GymrJcJ9k3ZyMspsSPczxlkHemKHdoMrUmVz2FqbMh8d4vxqKSqcxgju6pBq7stFbNqSqpY/qciPFj7cbL5JACROuZhl9qk30kFF65F6GYBUychSyhlK4qEcHTPo5w1ALC4NVIFp93k3hhEUABZrC484zD51ubqJKadjEu8GgAgrysmc9G2DLTtSeJKxmj/a4v2lwIL4e9m4tagTmVRM2L444rjF8GJa
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c310f00b0040fb0193565sm4437876wmo.29.2024.02.01.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 05:16:42 -0800 (PST)
Message-ID: <81c37127dda0f2f69a019d67d4420f62c995ee7f.camel@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] page_frag: unify gfp bits for order 3
 page allocation
From: Paolo Abeni <pabeni@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Duyck
	 <alexanderduyck@fb.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	"Michael S. Tsirkin"
	 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrew Morton
	 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org
Date: Thu, 01 Feb 2024 14:16:41 +0100
In-Reply-To: <20240130113710.34511-3-linyunsheng@huawei.com>
References: <20240130113710.34511-1-linyunsheng@huawei.com>
	 <20240130113710.34511-3-linyunsheng@huawei.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-30 at 19:37 +0800, Yunsheng Lin wrote:
> Currently there seems to be three page frag implementions
> which all try to allocate order 3 page, if that fails, it
> then fail back to allocate order 0 page, and each of them
> all allow order 3 page allocation to fail under certain
> condition by using specific gfp bits.
>=20
> The gfp bits for order 3 page allocation are different
> between different implementation, __GFP_NOMEMALLOC is
> or'd to forbid access to emergency reserves memory for
> __page_frag_cache_refill(), but it is not or'd in other
> implementions, __GFP_DIRECT_RECLAIM is masked off to avoid
> direct reclaim in skb_page_frag_refill(), but it is not
> masked off in __page_frag_cache_refill().
>=20
> This patch unifies the gfp bits used between different
> implementions by or'ing __GFP_NOMEMALLOC and masking off
> __GFP_DIRECT_RECLAIM for order 3 page allocation to avoid
> possible pressure for mm.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> ---
>  drivers/vhost/net.c | 2 +-
>  mm/page_alloc.c     | 4 ++--
>  net/core/sock.c     | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..e574e21cc0ca 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -670,7 +670,7 @@ static bool vhost_net_page_frag_refill(struct vhost_n=
et *net, unsigned int sz,
>  		/* Avoid direct reclaim but allow kswapd to wake */
>  		pfrag->page =3D alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
>  					  __GFP_COMP | __GFP_NOWARN |
> -					  __GFP_NORETRY,
> +					  __GFP_NORETRY | __GFP_NOMEMALLOC,
>  					  SKB_FRAG_PAGE_ORDER);

>  		if (likely(pfrag->page)) {
>  			pfrag->size =3D PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c0f7e67c4250..636145c29f70 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4685,8 +4685,8 @@ static struct page *__page_frag_cache_refill(struct=
 page_frag_cache *nc,
>  	gfp_t gfp =3D gfp_mask;
> =20
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	gfp_mask |=3D __GFP_COMP | __GFP_NOWARN | __GFP_NORETRY |
> -		    __GFP_NOMEMALLOC;
> +	gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> +		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>  	page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>  				PAGE_FRAG_CACHE_MAX_ORDER);
>  	nc->size =3D page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 88bf810394a5..8289a3d8c375 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2919,7 +2919,7 @@ bool skb_page_frag_refill(unsigned int sz, struct p=
age_frag *pfrag, gfp_t gfp)
>  		/* Avoid direct reclaim but allow kswapd to wake */
>  		pfrag->page =3D alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
>  					  __GFP_COMP | __GFP_NOWARN |
> -					  __GFP_NORETRY,
> +					  __GFP_NORETRY | __GFP_NOMEMALLOC,
>  					  SKB_FRAG_PAGE_ORDER);

This will prevent memory reserve usage when allocating order 3 pages,
but not when allocating a single page as a fallback. Still different
from the __page_frag_cache_refill() allocator - which never accesses
the memory reserves.

I'm unsure we want to propagate the __page_frag_cache_refill behavior
here, the current behavior could be required by some systems.

It looks like this series still leave the skb_page_frag_refill()
allocator alone, what about dropping this chunk, too?=20

Thanks!

Paolo


