Return-Path: <linux-kernel+bounces-43873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6D6841A42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DE7B20F07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E93716E;
	Tue, 30 Jan 2024 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Picy0UNw"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5137141
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584406; cv=none; b=TOAhWOBYUnLwMNHHKU6HksnNzHmLi8g7oUfA4doKnKlqw1fNxpDgyUNaP9uaD+2p5qNxaU1maPND8AGOGgW7nG/k05kx0X8t5Qdwith3l08hCfrcBuzXASTn0DEzBF6HBYSOxWyhr3Hn0rs30nKn6t+dtRDwx9u5nmg03v3x1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584406; c=relaxed/simple;
	bh=Mn5tCUCP8cUsdqs4cx049xN3ln0lICyhXM7KDBrGjd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DD6NXHvaJvy3RTgpIrHoDIHlm0ccmpStWuBTURcJZuS/Bw1pTEfHKRQPUU5FNdJndLfSAjryVAHAkcAdFSad1pagQsUD1LvWdg/s6vKxziOE8vGahYO9sZ70b5aF5WN/4udG9kaXClXC0ImvHDpcxvRPHzfaMYVmECwHuB/t5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Picy0UNw; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e12b58a3beso909547a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706584402; x=1707189202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gz/0DrxSnC6UsvfwPyk9OxqtFLi7qctjiAyBJL30GqU=;
        b=Picy0UNw3xXfFF2EZ9vNTTZl19+T7C11eKBaG6bNzg7l7riIPXBXp+EO6N+WFtQJMw
         2Ugzz7/f4g49vJ/nPuMKaAq6fgFPRJHr9bcmebGYCwNchJ3pig6E5ocsTzosF9m9I7gt
         86ajS2BnsjF8g8fXqS4ZMS2Q2nFzGReuqBykyJf9vLAnlfJmr/bXlTjpPar5i6qLaE0O
         PJ1HBhiuWB7P/CZjDvkYpzDkB5vBs1Aj0Tz4CgcdXt0rocreJsjiAIH/Hxma76cF4N/t
         N7XG9GARFXjATUkEVPMdBx7AZwhGY8Z91htOISNn4f8zxj4YKURPmRyLlPfyLM4wTqlG
         51Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584402; x=1707189202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gz/0DrxSnC6UsvfwPyk9OxqtFLi7qctjiAyBJL30GqU=;
        b=pM65YzkVpwVGmM5bobDj1L+b6wGCjXwNDWjZK8tzvXBPfHBWmU8vj0K5qCB3srp1Jf
         SeqWhGemvt8XK49f8X7C+z1+YoKI/AZ6xbyZDkNmiij6iQIhcxOi2H5p1LiPRZIHHAQB
         iGJpjpptS2D8P5RV379e/92i7a9AsUwPdos4/C0ZyxRDvATBD8Zp2JYMySx6Ynetq5Tq
         s7pT9Sifst0Ldd9z6N9ZV07KXv6YfdzaOcPPKW2nQ67Vlx1yJn3F7aUaxf9WAP6ZP6th
         hodX6k3f047E4tLGfguQYQHL5oZOsNwtDjfgTVrU7/ZrLmpNvi7NDNmciV/JBRq+w24g
         N7zg==
X-Gm-Message-State: AOJu0YyWirYTJDE2BFHjQSM5cEZXRz/JJ+7UYoMigfVWLSTglNTjTZhj
	PaKAcfsrnjCSpnP1+0QIFhYMBXzQMZTTtGjfzPzSz5BCgD1YZV8TldVaUTiJlhM=
X-Google-Smtp-Source: AGHT+IHePOoINh/isj1RRshS5OzhsNd/kKBlxk9k2lL8yiMZokgQzFyLIJdUArbanQO+uNV1UInNpA==
X-Received: by 2002:a05:6358:ed05:b0:178:7a67:addd with SMTP id hy5-20020a056358ed0500b001787a67adddmr2111816rwb.58.1706584402359;
        Mon, 29 Jan 2024 19:13:22 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d10-20020a63fd0a000000b005cf450e91d2sm7036824pgh.52.2024.01.29.19.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:13:21 -0800 (PST)
Message-ID: <eceb2dc5-f13b-4c54-b2dd-0e4a199c1280@bytedance.com>
Date: Tue, 30 Jan 2024 11:13:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] mm: zswap: rename zswap_free_entry to
 zswap_entry_free
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-2-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014208.565554-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:36, Johannes Weiner wrote:
> There is a zswap_entry_ namespace with multiple functions already.

Another is zswap_invalidate_entry(), maybe zswap_entry_invalidate is better.

> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7f88b3a77e4a..173f2e6657de 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -520,7 +520,7 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
>   * Carries out the common pattern of freeing and entry's zpool allocation,
>   * freeing the entry itself, and decrementing the number of stored pages.
>   */
> -static void zswap_free_entry(struct zswap_entry *entry)
> +static void zswap_entry_free(struct zswap_entry *entry)
>  {
>  	if (!entry->length)
>  		atomic_dec(&zswap_same_filled_pages);
> @@ -555,7 +555,7 @@ static void zswap_entry_put(struct zswap_entry *entry)
>  	WARN_ON_ONCE(refcount < 0);
>  	if (refcount == 0) {
>  		WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
> -		zswap_free_entry(entry);
> +		zswap_entry_free(entry);
>  	}
>  }
>  

