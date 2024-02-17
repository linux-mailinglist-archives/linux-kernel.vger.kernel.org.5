Return-Path: <linux-kernel+bounces-69872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1D5858FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D55B1F219C6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F56A011;
	Sat, 17 Feb 2024 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QGAxC+cP"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8165BCA
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708176468; cv=none; b=cXpqzu8tfhBr/2w1nxADAVy0rmGO0Anq8LvOg1uL6tA0z3rrUChHzB5pMnwJtMRpwSMSO3JGti7yXHhH8T0Yumry3ipxtjv5yW5FxqK3ARYnLFuWwK428Nn6IbQbOpMNByxbZZrmZqEbfcgoRFSsbxQPWoz15/QoIT7QCTI672A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708176468; c=relaxed/simple;
	bh=E7emPU9rypiCiybAXTjsY0x82QlSI3PXVL3AcjcZBes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zdb3j2F6fCUXAEAvxyMJEdGik+AyrIr+Wv5QNCkSo9zcBUIf8Yiy3D9+Gr49tZ2hSRubbD5lkRN88eJZ9ccRSYPUIIYkSpTr9i7xbvd9eaim6SSygWbFG+1/xC46RuysuSc4pAkf30S9ZomRdeTi3SVMm4vV3dCG4Cb1celd9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QGAxC+cP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dba94f9201so13649805ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708176466; x=1708781266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YIjUl7w74kX0iqRU9st/bixCfekkV2GsxSz3VGD0t8=;
        b=QGAxC+cPKx8/IqokCFyTW4Vnc9vIqPeJUrHfr0f2+LkZt61bcxMvtqeLRfrEVHLMzN
         hTCFkPPvm1iMycw5xxTMYFYKIR3O2h0bQgpU6/SryOOPvxtR3m83qOKjM2KrZZ2Dusnw
         ZxPnhV76PZ2FhM0+jWgfC+R+UlLb9IBLDXTpDiLNz+TPyA8ESq/cf0WGEMLT9Gy+d1IM
         J4fYGv8LFYVwK2Z/thmlaaZwbaWDr+MxK3JIPQ4slEoDu/MwjZ6hMj0EBvx6Gs5L49JH
         N1WBr7LdJdjKxLw35mBo32yFLc3blObreQyWwZnyC7fy5GXpeaEr9NL1eMXasVMxStSV
         n9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708176466; x=1708781266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YIjUl7w74kX0iqRU9st/bixCfekkV2GsxSz3VGD0t8=;
        b=PYgjtxIJXOAemlajCJBIUHcJzVp3zcDJ4VYPL/RXbxx6tDIDHANTAHNXySA5te/z51
         m1orPiBOBwAd5GeRX8dhqkLBYmA+r19kqAPxmnQBQSH1JMk4wG/VMPfpf1Z3TiVuLZhe
         uYZJcAfoZgtoX3sGSdYLNrdJfDGnmZXcbxUDG98x6uH6xmqBe/41fApqoNWu8CuZQVdI
         a4BLnaP2IDQTno1rmZ2SOyRj0v5QAFtwQbONZ/f4zdDz5+kKMJreYpAIYS+DCqzwAKWM
         yUUBrMSOUzj35+QiD6iGH4hP+hID2tfBKYVFaApUzS/PWUh85QL1GYczexclRqwCn7oP
         0JHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4svwRETeHVs398CBepnVzdOhnQ/fsA3Qhiaw8s+Z3tTgv/aJlM7DRf+/Zh0f4HLAf3mLQvE2LUvUplg5zkctsYvB9QW8sbSmIINFw
X-Gm-Message-State: AOJu0YyFQbVJDBqd/mwOoT8db4vu/h82IkaUHtnpC8sxleL7yTOZBIse
	eYQrN77xXo425DpiSCpMc7kVEF4T/jTRmyN2ZktA4lubuYJ2hVV8yLG6QNdTsN8=
X-Google-Smtp-Source: AGHT+IEhs/wcrA0Gp63w4jHt1NcsIgXxn1UGTPz2QTHXlJn7DRWACzJRzx4cLjxQNjSo/+XEep3QyA==
X-Received: by 2002:a17:902:e882:b0:1db:465b:b5a3 with SMTP id w2-20020a170902e88200b001db465bb5a3mr9022718plg.11.1708176466112;
        Sat, 17 Feb 2024 05:27:46 -0800 (PST)
Received: from [10.254.113.79] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id kr7-20020a170903080700b001db8a5ea0a3sm1467529plb.94.2024.02.17.05.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 05:27:45 -0800 (PST)
Message-ID: <edf95287-4f1d-4aaa-8ff2-d2a4db748311@bytedance.com>
Date: Sat, 17 Feb 2024 21:27:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, linux-mm@kvack.org
Cc: nphamcs@gmail.com, senozhatsky@chromium.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20240217053642.79558-1-21cnbao@gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240217053642.79558-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/17 13:36, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> We used to rely on the returned -ENOSPC of zpool_malloc() to increase
> reject_compress_poor. But the code wouldn't get to there after commit
> 744e1885922a ("crypto: scomp - fix req->dst buffer overflow") as the
> new code will goto out immediately after the special compression case
> happens. So there might be no longer a chance to execute zpool_malloc
> now. We are incorrectly increasing zswap_reject_compress_fail instead.
> Thus, we need to fix the counters handling right after compressions
> return ENOSPC. This patch also centralizes the counters handling for
> all of compress_poor, compress_fail and alloc_fail.
> 
> Fixes: 744e1885922a ("crypto: scomp - fix req->dst buffer overflow")
> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM, thanks!

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  -v2: 
>  * correct the fixes target according to Yosry, Chengming, Nhat's
>    comments;
>  * centralize the counters handling according to Yosry's comment
> 
>  mm/zswap.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 350dd2fc8159..47cf07d56362 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1498,6 +1498,7 @@ bool zswap_store(struct folio *folio)
>  	struct zswap_tree *tree = zswap_trees[type];
>  	struct zswap_entry *entry, *dupentry;
>  	struct scatterlist input, output;
> +	int comp_ret = 0, alloc_ret = 0;
>  	struct crypto_acomp_ctx *acomp_ctx;
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
> @@ -1508,7 +1509,6 @@ bool zswap_store(struct folio *folio)
>  	char *buf;
>  	u8 *src, *dst;
>  	gfp_t gfp;
> -	int ret;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1621,28 +1621,20 @@ bool zswap_store(struct folio *folio)
>  	 * but in different threads running on different cpu, we have different
>  	 * acomp instance, so multiple threads can do (de)compression in parallel.
>  	 */
> -	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
> +	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
>  	dlen = acomp_ctx->req->dlen;
>  
> -	if (ret) {
> -		zswap_reject_compress_fail++;
> +	if (comp_ret)
>  		goto put_dstmem;
> -	}
>  
>  	/* store */
>  	zpool = zswap_find_zpool(entry);
>  	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>  	if (zpool_malloc_support_movable(zpool))
>  		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
> -	ret = zpool_malloc(zpool, dlen, gfp, &handle);
> -	if (ret == -ENOSPC) {
> -		zswap_reject_compress_poor++;
> -		goto put_dstmem;
> -	}
> -	if (ret) {
> -		zswap_reject_alloc_fail++;
> +	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle);
> +	if (alloc_ret)
>  		goto put_dstmem;
> -	}
>  	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
>  	memcpy(buf, dst, dlen);
>  	zpool_unmap_handle(zpool, handle);
> @@ -1689,6 +1681,13 @@ bool zswap_store(struct folio *folio)
>  	return true;
>  
>  put_dstmem:
> +	if (comp_ret == -ENOSPC || alloc_ret == -ENOSPC)
> +		zswap_reject_compress_poor++;
> +	else if (comp_ret)
> +		zswap_reject_compress_fail++;
> +	else if (alloc_ret)
> +		zswap_reject_alloc_fail++;
> +
>  	mutex_unlock(&acomp_ctx->mutex);
>  put_pool:
>  	zswap_pool_put(entry->pool);

