Return-Path: <linux-kernel+bounces-68307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E4E857882
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C045286768
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107961BC2A;
	Fri, 16 Feb 2024 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kENq1VTN"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C21B968
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074444; cv=none; b=lXtvV8NpGmVjqSRC/HhXJuXdaOOcCgr5OD2zcsLl1BYwncu215aIp0b59YcY+00+MdoCseakz4oQsvEdKLmZIxUECTWdj5xosiem/8WLm2YvJj4hcexw7zFPJxK+eao6nyY3OcEhXtOr5DTA+oktqVByTaHfFxNPHl1+sgI6SGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074444; c=relaxed/simple;
	bh=1rEyoLiaQjiwatUH1hykCnwQgvpB/ofDAzA46MapLnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5GeBHMJ9lPi9tuNKWNMCXa7HNX9yvKvue412gguxWGuGCUiCCg610Bp4xS2zty1JaUwlYUOYUaM1tytMn484YgQcZTMaX3nAoqh2PhXHFyqU7RZpebLOVZDGgXuLiZVkar4lMeW+eYu5K6y9+ZF6DvYA+A55R4uo4QPG6wkJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kENq1VTN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e10746c6f4so1347366b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708074441; x=1708679241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=te7LBuSkGpNERcPih/GmGHlalGkBFMiZ+Ca0upEKLOg=;
        b=kENq1VTNhRu4KwMR/Wlw/iMHzj6Atc1iSx/lLdjvuQW8T4DpSaO4OHeQrmRjoeTUMw
         RUnG9L3H5Ws7Q3zKHprAFkBWC/Jd3wJJJwGd2zpQXGqkCqYMhogfy9Ckk23sh1WbRbBA
         QZTDMNIwvrjfY2/Nl2/wtHvfAoa1VebemItmM0zTL052VZkbijD0yjXxctMLF+TtnqoV
         po1eIdKnFqywykath66euM5Syu/894R8fDSfgl3fUTcbZlIBGmQw6JBRFkGHh6vgZOuh
         wLAeYNUCrrk2j5D/AEkBL1lPWWTEHl5dsyxAe3TjfO3Jo7jeCYgvXSp4h3wsCbJ/Mzf9
         t4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708074441; x=1708679241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=te7LBuSkGpNERcPih/GmGHlalGkBFMiZ+Ca0upEKLOg=;
        b=b6bFlc/I31eb2kZecbr7Kf7rbj84jeU9aNI12BRNxBIgb4ba0DiSNxuN855tsI7h8B
         ZGpWQFLiSJZp1IuV98Q5/U/oPDjEstZZF8RhwR4uo37/45/Dq99qjofSBADhzNvtmyXA
         5vUiKnSBL90tfGo0QHiU3kbosM8R7u39Z75HRqrU8FOLY57SFgVcaWLpKw7dmZXeEVPR
         AlAa+aG2t+0kPccTqbLRAPdsjgwLpDaMcM7Pqi+GXoZ1KMdEPkEpS+d7k6SnSm3natk3
         NJAeuObGzx6z82nCHu7MfCGPaxyVM84DVz3qXHQtxA2j+PwL3ruM14bahqH+YhLbU3hc
         nzKA==
X-Forwarded-Encrypted: i=1; AJvYcCXpf6n5aMfbIRH5ztofW6gvUCwqY8Wshi7KQMH7qxwdwtBvVKh0g31chFqrf9ui0nqwgAcohLPk75ftKrOgOrTqIjTuH6QotrV+DKxj
X-Gm-Message-State: AOJu0YxXT2I/YR18liglFqpPBSzE8ImmQftLzEfPmH+bkhEDRS98WNs4
	5HI2OnmFq6w/9pV5/ZhPN43YcGlFrIVzKrcCFRdd2AZk1HIbxCwu75ZhdbgoTKw=
X-Google-Smtp-Source: AGHT+IEF8CmYpemNqYgmMWaNlK1GOcey+10tFseNDFQ4cxYUp7hRe0oHLGS1E4wBIAu0sncoXGA6Yw==
X-Received: by 2002:aa7:85c3:0:b0:6e0:4ed0:7b38 with SMTP id z3-20020aa785c3000000b006e04ed07b38mr3957056pfn.4.1708074441275;
        Fri, 16 Feb 2024 01:07:21 -0800 (PST)
Received: from [10.4.195.175] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id x10-20020a056a000bca00b006ddc03c425bsm2628098pfu.180.2024.02.16.01.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 01:07:20 -0800 (PST)
Message-ID: <b717ae0c-ed4f-4ebc-90cf-51a8da0a6583@bytedance.com>
Date: Fri, 16 Feb 2024 17:07:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Nhat Pham <nphamcs@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240216030539.110404-1-21cnbao@gmail.com>
 <Zc8bjZFZAZneObQG@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Zc8bjZFZAZneObQG@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/16 16:23, Yosry Ahmed wrote:
> On Fri, Feb 16, 2024 at 04:05:39PM +1300, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> My commit fc8580edbaa6 ("mm: zsmalloc: return -ENOSPC rather than -EINVAL
>> in zs_malloc while size is too large") wanted to depend on zs_malloc's
>> returned ENOSPC to distinguish the case that compressed data is larger
>> than the original data from normal compression cases. The commit, for
>> sure, was correct and worked as expected but the code wouldn't run to
>> there after commit 744e1885922a ("crypto: scomp - fix req->dst buffer
>> overflow") as Chengming's this patch makes zswap_store() goto out
>> immediately after the special compression case happens. So there is
>> no chance to execute zs_malloc() now. We need to fix the count right
>> after compressions return ENOSPC.
>>
>> Fixes: fc8580edbaa6 ("mm: zsmalloc: return -ENOSPC rather than -EINVAL in zs_malloc while size is too large")
> 
> I don't see how this is a fix for that commit. Commit fc8580edbaa6 made
> sure zsmalloc returns a correct errno when the compressed size is too
> large. The fact that zswap stores were failing before calling into
> zsmalloc and not reporting the error correctly in debug counters is not
> that commits fault.
> 
> I think the proper fixes should be 744e1885922a if it introduced the
> first scenario where -ENOSPC can be returned from scomp without handling
> it properly in zswap. If -ENOSPC was a possible return value before
> that, then it should be cb61dad80fdc ("zswap: export compression failure
> stats"), where the counter was introduced.

Right, 744e1885922a maybe a better fixes target.

> 
>> Cc: Chengming Zhou <zhouchengming@bytedance.com>
>> Cc: Nhat Pham <nphamcs@gmail.com>
>> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>  mm/zswap.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 6319d2281020..9a21dbe8c056 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1627,7 +1627,10 @@ bool zswap_store(struct folio *folio)
>>  	dlen = acomp_ctx->req->dlen;
>>  
>>  	if (ret) {
>> -		zswap_reject_compress_fail++;
>> +		if (ret == -ENOSPC)
>> +			zswap_reject_compress_poor++;
>> +		else
>> +			zswap_reject_compress_fail++;
> 
> With this diff, we have four locations in zswap_store() where we
> increment zswap_reject_compress_{poor/fail}.
> 
> How about the following instead?A
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 62fe307521c93..3a7e8ba7f6116 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1059,24 +1059,16 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
>  	 */
>  	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
>  	dlen = acomp_ctx->req->dlen;
> -	if (ret) {
> -		zswap_reject_compress_fail++;
> +	if (ret)
>  		goto unlock;
> -	}
> 
>  	zpool = zswap_find_zpool(entry);
>  	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>  	if (zpool_malloc_support_movable(zpool))
>  		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
>  	ret = zpool_malloc(zpool, dlen, gfp, &handle);
> -	if (ret == -ENOSPC) {
> -		zswap_reject_compress_poor++;
> -		goto unlock;
> -	}
> -	if (ret) {
> -		zswap_reject_alloc_fail++;
> +	if (ret)
>  		goto unlock;
> -	}
> 
>  	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
>  	memcpy(buf, dst, dlen);
> @@ -1086,6 +1078,10 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
>  	entry->length = dlen;
> 
>  unlock:
> +	if (ret == -ENOSPC)
> +		zswap_reject_compress_poor++;
> +	else if (ret)
> +		zswap_reject_alloc_fail++;

Here have two cases: zswap_reject_compress_fail, zswap_reject_alloc_fail.

>  	mutex_unlock(&acomp_ctx->mutex);
>  	return ret == 0;
>  }
> 
>>  		goto put_dstmem;
>>  	}
>>  
>> -- 
>> 2.34.1
>>

