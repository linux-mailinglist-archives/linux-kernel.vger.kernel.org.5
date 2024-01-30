Return-Path: <linux-kernel+bounces-43894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75F841A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33571C222E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280B374C6;
	Tue, 30 Jan 2024 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Bwj6HASa"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0723376F4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585021; cv=none; b=Dvzfx5Wzn7dlxy4RNYfV/OXDjrPK1Rynf6q/iMgn8/VPzYEWhXAsR0HUHjZHwwoUknwRY7PUaw7Yir3WwPltizrdm4VlzxyWwwtS9SLuDUo+2TOB9Jnz7Sz6hUuuUKu1BsWUXvEL5IPQZSytAm3h3jaqM/QN7Wh31vq9vgruAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585021; c=relaxed/simple;
	bh=TKueyDbu0dNmd8p9ZImYWs+ZqKPqYbXpn8u6zVPUfjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A124FHeSU+PWvoCmw4hBq+JJwivhMHYJ4AVlQq1XjO1zr49BzJ7hONlJ0+2H1RQz2ZpBMPlujwsIuWteF+GlDH3xeCYLtDbNLdPLv180pq1xiJKKLZISGJsO4/0sqdbbyPhqrVa/WY9q+VH9ISJ+Vh1ku7n6iMx5w7QLtQhqzXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Bwj6HASa; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2111612a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706585019; x=1707189819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8o03jrNzbU+C4x/9AR7e489filXEU2KmXfLu3Qo3xNs=;
        b=Bwj6HASaV6pB88NoEtyWrxJWI3siHBp/BELp3KDHwI070JuNocA6KVOep0jF6N2YWn
         E7ylBAlPE1gZEq4rXtXZqhHQYkk/rQEK3jR5oIbJlN1AqEgvV2Ve6+QH/FuG32wkeYRd
         AY6IK/4KGCjyYmOE4R7YIDb4GOXflG7rOhZP8sT8mnf0rIKlTPhKDSKuh16TC18TVdSF
         kS1D57U7gDVN4/LLDYs1UYDEkE71HOJetKl0ta3a0nf4I136/X4Kh8QZlr2HYM9DJoco
         rRww3syIF4B1ERC7CgxL3JTsO0FW97svA8gBGYBgM5EnZMprSJWsLQsvMM6MldH/blNl
         fnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585019; x=1707189819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8o03jrNzbU+C4x/9AR7e489filXEU2KmXfLu3Qo3xNs=;
        b=LKY8N1XMmgGkDv8snJ8e2xmaQ7/LYnXhMWOFRfqT2+W+5tmtCI4rySz4rPOT1J8tuZ
         WZvMcZy3RAqJ2ZSj5zfliAqije3Y6l7XJbVTAX5whXeF/mH/p2FyxNS5GGH1OUmtHKA8
         IFZK6jj8UxqOPYCsQLN9xrj18/n25Ak5lTja3YX++/fwQO9dQeQIp2J/ssDwX9y8RVUb
         xW6CcJ8mszEFooCTKOnqohcr9YK0gDNKAaPFp/jycFM+/gKTEQdghAvVIf6QOTr2isCE
         lSmWWs1OUKQMO2ZMTXdh/NzUxEbEKnOIHYQIZJIwY6onIL2A8H5kAFta7B2VoeiKIkcj
         yy6A==
X-Gm-Message-State: AOJu0YxlB0+z2hWbg2Fl9Cul5NprJO9Ks4lF5n5029Z9ppx0flrYdHz9
	b6WHprFSvSkExAaVsiIlVUMz68MF4qzkv6YUcJ7SPJBx0O5smK9aNdjzf599Mog=
X-Google-Smtp-Source: AGHT+IEZPHn9b0J452ClQ28tIEzvfdbzPN22cAJ3grLOGVVgcS6aMI1fyNw3wPYf8LsUEMpcVung0g==
X-Received: by 2002:a05:6a21:144f:b0:19c:5b32:9504 with SMTP id oc15-20020a056a21144f00b0019c5b329504mr5875020pzb.49.1706585019014;
        Mon, 29 Jan 2024 19:23:39 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902ed5300b001d8b0750940sm4871845plb.175.2024.01.29.19.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:23:38 -0800 (PST)
Message-ID: <22d6a7be-be44-419f-9b01-24cd4f584b09@bytedance.com>
Date: Tue, 30 Jan 2024 11:23:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] mm: zswap: break out zwap_compress()
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-8-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014208.565554-8-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:36, Johannes Weiner wrote:
> zswap_store() is long and mixes work at the zswap layer with work at
> the backend and compression layer. Move compression & backend work to
> zswap_compress(), mirroring zswap_decompress().
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 145 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 77 insertions(+), 68 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index bdc9f82fe4b9..f9b9494156ba 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1316,6 +1316,79 @@ static int zswap_enabled_param_set(const char *val,
>  	return ret;
>  }
>  
> +static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
> +{
> +	struct crypto_acomp_ctx *acomp_ctx;
> +	struct scatterlist input, output;
> +	unsigned int dlen = PAGE_SIZE;
> +	unsigned long handle;
> +	struct zpool *zpool;
> +	char *buf;
> +	gfp_t gfp;
> +	int ret;
> +	u8 *dst;
> +
> +	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
> +
> +	mutex_lock(&acomp_ctx->mutex);
> +
> +	dst = acomp_ctx->buffer;
> +	sg_init_table(&input, 1);
> +	sg_set_page(&input, &folio->page, PAGE_SIZE, 0);
> +
> +	/*
> +	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
> +	 * and hardware-accelerators may won't check the dst buffer size, so
> +	 * giving the dst buffer with enough length to avoid buffer overflow.
> +	 */
> +	sg_init_one(&output, dst, PAGE_SIZE * 2);
> +	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
> +
> +	/*
> +	 * it maybe looks a little bit silly that we send an asynchronous request,
> +	 * then wait for its completion synchronously. This makes the process look
> +	 * synchronous in fact.
> +	 * Theoretically, acomp supports users send multiple acomp requests in one
> +	 * acomp instance, then get those requests done simultaneously. but in this
> +	 * case, zswap actually does store and load page by page, there is no
> +	 * existing method to send the second page before the first page is done
> +	 * in one thread doing zwap.
> +	 * but in different threads running on different cpu, we have different
> +	 * acomp instance, so multiple threads can do (de)compression in parallel.
> +	 */
> +	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
> +	dlen = acomp_ctx->req->dlen;
> +	if (ret) {
> +		zswap_reject_compress_fail++;
> +		goto unlock;
> +	}
> +
> +	zpool = zswap_find_zpool(entry);
> +	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> +	if (zpool_malloc_support_movable(zpool))
> +		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
> +	ret = zpool_malloc(zpool, dlen, gfp, &handle);
> +	if (ret == -ENOSPC) {
> +		zswap_reject_compress_poor++;
> +		goto unlock;
> +	}
> +	if (ret) {
> +		zswap_reject_alloc_fail++;
> +		goto unlock;
> +	}
> +
> +	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> +	memcpy(buf, dst, dlen);
> +	zpool_unmap_handle(zpool, handle);
> +
> +	entry->handle = handle;
> +	entry->length = dlen;
> +
> +unlock:
> +	mutex_unlock(&acomp_ctx->mutex);
> +	return ret == 0;
> +}
> +
>  static void zswap_decompress(struct zswap_entry *entry, struct page *page)
>  {
>  	struct zpool *zpool = zswap_find_zpool(entry);
> @@ -1472,18 +1545,11 @@ bool zswap_store(struct folio *folio)
>  	struct page *page = &folio->page;
>  	struct zswap_tree *tree = swap_zswap_tree(swp);
>  	struct zswap_entry *entry, *dupentry;
> -	struct scatterlist input, output;
> -	struct crypto_acomp_ctx *acomp_ctx;
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
>  	struct zswap_pool *pool;
> -	struct zpool *zpool;
> -	unsigned int dlen = PAGE_SIZE;
> -	unsigned long handle, value;
> -	char *buf;
> -	u8 *src, *dst;
> -	gfp_t gfp;
> -	int ret;
> +	unsigned long value;
> +	u8 *src;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1568,65 +1634,10 @@ bool zswap_store(struct folio *folio)
>  		mem_cgroup_put(memcg);
>  	}
>  
> -	/* compress */
> -	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
> -
> -	mutex_lock(&acomp_ctx->mutex);
> -
> -	dst = acomp_ctx->buffer;
> -	sg_init_table(&input, 1);
> -	sg_set_page(&input, &folio->page, PAGE_SIZE, 0);
> +	if (!zswap_compress(folio, entry))
> +		goto put_pool;
>  
> -	/*
> -	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
> -	 * and hardware-accelerators may won't check the dst buffer size, so
> -	 * giving the dst buffer with enough length to avoid buffer overflow.
> -	 */
> -	sg_init_one(&output, dst, PAGE_SIZE * 2);
> -	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
> -	/*
> -	 * it maybe looks a little bit silly that we send an asynchronous request,
> -	 * then wait for its completion synchronously. This makes the process look
> -	 * synchronous in fact.
> -	 * Theoretically, acomp supports users send multiple acomp requests in one
> -	 * acomp instance, then get those requests done simultaneously. but in this
> -	 * case, zswap actually does store and load page by page, there is no
> -	 * existing method to send the second page before the first page is done
> -	 * in one thread doing zwap.
> -	 * but in different threads running on different cpu, we have different
> -	 * acomp instance, so multiple threads can do (de)compression in parallel.
> -	 */
> -	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
> -	dlen = acomp_ctx->req->dlen;
> -
> -	if (ret) {
> -		zswap_reject_compress_fail++;
> -		goto put_dstmem;
> -	}
> -
> -	/* store */
> -	zpool = zswap_find_zpool(entry);
> -	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> -	if (zpool_malloc_support_movable(zpool))
> -		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
> -	ret = zpool_malloc(zpool, dlen, gfp, &handle);
> -	if (ret == -ENOSPC) {
> -		zswap_reject_compress_poor++;
> -		goto put_dstmem;
> -	}
> -	if (ret) {
> -		zswap_reject_alloc_fail++;
> -		goto put_dstmem;
> -	}
> -	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> -	memcpy(buf, dst, dlen);
> -	zpool_unmap_handle(zpool, handle);
> -	mutex_unlock(&acomp_ctx->mutex);
> -
> -	/* populate entry */
>  	entry->swpentry = swp;
> -	entry->handle = handle;
> -	entry->length = dlen;
>  
>  insert_entry:
>  	entry->objcg = objcg;
> @@ -1663,8 +1674,6 @@ bool zswap_store(struct folio *folio)
>  
>  	return true;
>  
> -put_dstmem:
> -	mutex_unlock(&acomp_ctx->mutex);
>  put_pool:
>  	zswap_pool_put(entry->pool);
>  freepage:

