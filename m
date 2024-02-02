Return-Path: <linux-kernel+bounces-49448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A6846A6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0177E1F2231F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3419D1AADF;
	Fri,  2 Feb 2024 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fr6d10MH"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774C182AF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861581; cv=none; b=R8QmlwH9dJshnkpT7YeXQJgvaFsmq+wL7pMXOfdTaNdRBCgjn5FG4fEivoae23hm7cfsqzmkrHv05vuSzKjqUCgv93inIcv+zX+NpHRmOgxXyGTJBvgdRGaF+MCJlBRZ7z6WhnPPa9qZUMnOlVUgqpKAeyZjJJAuLijucUkPsd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861581; c=relaxed/simple;
	bh=XmRNWbk1Rw7iRYV0P/z6WjSur6k3KMnUilgGnnht7ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bo6BtmymXJH6fwi8PD3MKlXxoyj+5B9v4bixnVaie88XzWm3Bw0YEdZOEyHk4vqOOzZ6vXUfyzm9UYBFBbpZC0JWVQXvqcJBaHeg4I0vWUdKbXps94zsd2u1PwPaOymsGNa8cyz2q8WpnpgwmV2ASdfzQ5PG6KNwaNBRW08w3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fr6d10MH; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e11cda9f6fso1049302a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706861578; x=1707466378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJTlS+Zx0kwsewgmgXrZQpo393YaXW30zOMs0OgwhUg=;
        b=Fr6d10MHl4+GofgCOx3iigyz1J67diaZpH63alWUjeT6xNFWpI6iN65jt1904SCcpU
         yRWhNiQ8dPh4rJsAHUqWFzKGfNvEiEKiEbojgiXm7GZEECEPl3zMnQD3p3CILEQ8Z4oH
         xnpdDttL9cjFh9jtX7+7d9udO0KRUKEGwz99+LX1VWEoi6YPV518z7ZYO1/1nF+FiXPa
         y1XerETyuIKs7yD2GE2h2FW8a7ePK+EkkLvvQPQiOTKqj5QVBgmIGlIVIztrYW2jgr2j
         Jho0E1/izhgH+baor+lzCQq6UqW+eTGjTARJWBCAiptQRuVkmNxzwWeq12JzcPwCzm3n
         +vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706861578; x=1707466378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJTlS+Zx0kwsewgmgXrZQpo393YaXW30zOMs0OgwhUg=;
        b=XCbHPLxuViEgrU5/OSe1Iy5lYhbkpRtSR12KfFFgjmMhwjVhzAuKXACrjNm5HiNqfl
         WBtmtZLFoxpmxjf+fiuyrFA+0UM3osioXdMIUw4O1wywx6r8dwR3xndwbpH766kr6+jh
         JlV1H320kUUP4+gjpXSGPY/qzHRvoyogbvhBBfLZ7vAVuPISuw+vSJma7muIuCpkR1JK
         cW0sjg/cOxzLqPUqlAKJXxUP13qk8v9/ySudy3owyERnwoCdEGjwtN0o2FBtogy2Pikc
         qoVWCQc98s0S+uJql6qU8D/kk3bgjv+UrRFvzy9v0xc4ojM/sAncOx9uUtE7n/rsY9j4
         W78Q==
X-Gm-Message-State: AOJu0YwmXFYnESl9PkIrRW9RbK7WYOmFY4SZFaNeAehsM7EV99x/q6il
	4Hhnz1J1XLjWi9epFpxYD0KSY6gGex0vzmtXip60vzhintpcBJ4FbsVXP5x0GwU=
X-Google-Smtp-Source: AGHT+IH08/09Sp52XGUFjNivGPPEyv/hiWdujauxR1oqe84/ZQppsHPur7+KvUDNmZvNJzgFOt+V5w==
X-Received: by 2002:a05:6358:5bd0:b0:178:756b:6bcb with SMTP id i16-20020a0563585bd000b00178756b6bcbmr1546836rwf.27.1706861578474;
        Fri, 02 Feb 2024 00:12:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWTDogFDZ7mGbhV1qKTMQGCQyeUhQ/bD4WNRszgYLEfg8aXwVdDANZ1/oHSiIXIgcESI809ivm70xcOC5bWQA0ckgEiewI+n57jCLBNhFVwVAHnxNK7x6clqT9/UZdRVPDdclCfaSOzaIHMdcEl/TnaaOm/EIcnFbhDbwwuuZMKrq3HqoVqeSfgMkH4nRPFLA==
Received: from [10.84.152.222] ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id k15-20020a63d10f000000b0059b2316be86sm1049563pgg.46.2024.02.02.00.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 00:12:58 -0800 (PST)
Message-ID: <2e6547c6-1bdd-4e27-a573-b866eb8bb305@bytedance.com>
Date: Fri, 2 Feb 2024 16:12:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mm/zswap: stop lru list shrinking when encounter warm
 region
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-3-56ed496b6e55@bytedance.com>
 <Zbw0HjFkvMG4PT9l@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Zbw0HjFkvMG4PT9l@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/2 08:15, Yosry Ahmed wrote:
> On Thu, Feb 01, 2024 at 03:49:03PM +0000, Chengming Zhou wrote:
>> When the shrinker encounter an existing folio in swap cache, it means
>> we are shrinking into the warmer region. We should terminate shrinking
>> if we're in the dynamic shrinker context.
>>
>> This patch add LRU_STOP to support this, to avoid overshrinking.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> LGTM with one comment below.
> 
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> 
>> ---
>>  include/linux/list_lru.h | 1 +
>>  mm/list_lru.c            | 3 +++
>>  mm/zswap.c               | 4 +++-
>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
>> index f2882a820690..5633e970144b 100644
>> --- a/include/linux/list_lru.h
>> +++ b/include/linux/list_lru.h
>> @@ -24,6 +24,7 @@ enum lru_status {
>>  	LRU_SKIP,		/* item cannot be locked, skip */
>>  	LRU_RETRY,		/* item not freeable. May drop the lock
>>  				   internally, but has to return locked. */
>> +	LRU_STOP,		/* stop lru list walking */
> 
> nit: Should we add "May drop the lock internally, but has to return
> locked" like LRU_RETRY and LRU_REMOVED_RETRY?

Right, will add.

Thanks.

