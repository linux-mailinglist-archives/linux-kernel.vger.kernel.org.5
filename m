Return-Path: <linux-kernel+bounces-43904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F85841A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75464B20E31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B92374D2;
	Tue, 30 Jan 2024 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VKX4E6h3"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78623FDF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585866; cv=none; b=Zlyy06lY62IacU21BUc2CO6io6DhMunPDgQvUianlMtHWQzdtXZY86Il5TTzJLAptV67tYX+zxM7HS7qC9YvaWIYKuTniAqYBAiz9IZJhNjhTia6DOn7HjzkTMtQZ1lv3vnQLXH8rhocvUhFU3zn9/1kjJF6eDMfokxKss7QXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585866; c=relaxed/simple;
	bh=PuFbQiWSXT6tGLZr8NJjjwWhB08RIkHxrhNYlXm/4Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWflSZh3Utd4IU3QMGkMsokhMhJa+w5Fcvz7UvwF3JNldNfJNeUwpWBljgyq97fDWSDYIQLZOHpLBLRZJ0aYUuVClYjZsIbuQCMQgi5pZtQPpVdxxxAbV5QE0WoK/IHzhotgJW/wzjnn6SV5ragIhW+KG+6zXtX7NkNcA6fKd1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VKX4E6h3; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-204f50f305cso2586556fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706585864; x=1707190664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzebWaKZk+94ZRx2c2YdGPDF8CZwvmTVymWHqzMMxBc=;
        b=VKX4E6h3+4SFtFZqTQSirX6I6cZehCuFQWy8xige5t71LrvlrXdZcez3MNUn8PGq8i
         4S7gc76l//KGXvScQIJXhYCbbzxk/+ifiYDVNuzwr5sH2xSic81SGCWPs8cJZHx1a+1E
         sAN+CZqPn68opzAGq/TE7rERojBcDwzOJV46D1CLI/9QNANNTe75eFRG0SLSW6N3MVPi
         nqfA6NlFd0eCfsrPM3shkKf+QEjh15WuVIA45L3FlhzMH6kWxZ34FwQndAttYcY3w0op
         5odmg21h+ocye8mC+919FO2QKNSJ9wM6eS31PX+RX8ePHMubBQQEmyxRwTg7bressHEC
         yXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585864; x=1707190664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzebWaKZk+94ZRx2c2YdGPDF8CZwvmTVymWHqzMMxBc=;
        b=nZJpK+E2hmFuFJJZOUQliUD1xNTRk+koVz5O1L6aq6Ruj9pVuNnivLyz6c8kpQMVdy
         Ojuun5Ty/4k7YhLdbyr3jQAguYnfeeqpmdMKqvxqRroudEgn5/0v3IE+qQfnsL5FQupT
         +g1TlW9Rr+5N5t9uOjzlJSlQvEeEO3M3KpAgtPxm75Ljus2VOnBOujxcYekC93L/7tBz
         tSgsRWArHfZK7QZs6keQ8oYWwNfX6iOInC6N8JhqUQei90hB2Abbmc6nNQ1Hv0Z8q79S
         KNm6R7RkZ52IkxRiM4HxgOevlxY30ne3sfLOcLx9Jk9OVuyg7ZvTAT/WVh2Ai6M2EUQJ
         7qAg==
X-Gm-Message-State: AOJu0Yx1/S2mwGXOvfdMBA1S/J4TdYCzGT53HeWJhP6z/spvpzb/MVNp
	syoKwRdztSliRKO37GLuak0i/9BxM/uX4H0LOpnVfgZ6ZSzMLaU4ILFcH2jzkR4=
X-Google-Smtp-Source: AGHT+IEVWupfuhowGp0+yx9osJSBEspj8CvQktKmSZlvjG1elawu5cahWZXPJ90uuRxiYk4IBk/5QQ==
X-Received: by 2002:a05:6870:1254:b0:214:2886:705b with SMTP id 20-20020a056870125400b002142886705bmr6895796oao.11.1706585864169;
        Mon, 29 Jan 2024 19:37:44 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y17-20020a63b511000000b005d8b481c4d3sm5561909pge.87.2024.01.29.19.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:37:43 -0800 (PST)
Message-ID: <fa7112d5-b20d-429a-b083-426d605c3354@bytedance.com>
Date: Tue, 30 Jan 2024 11:37:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] mm: zswap: inline and remove zswap_entry_find_get()
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-3-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014208.565554-3-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:36, Johannes Weiner wrote:
> There is only one caller and the function is trivial. Inline it.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 173f2e6657de..cf864aaa214d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -559,19 +559,6 @@ static void zswap_entry_put(struct zswap_entry *entry)
>  	}
>  }
>  
> -/* caller must hold the tree lock */
> -static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
> -				pgoff_t offset)
> -{
> -	struct zswap_entry *entry;
> -
> -	entry = zswap_rb_search(root, offset);
> -	if (entry)
> -		zswap_entry_get(entry);
> -
> -	return entry;
> -}
> -
>  /*********************************
>  * shrinker functions
>  **********************************/
> @@ -1708,13 +1695,13 @@ bool zswap_load(struct folio *folio)
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  
> -	/* find */
>  	spin_lock(&tree->lock);
> -	entry = zswap_entry_find_get(&tree->rbroot, offset);
> +	entry = zswap_rb_search(&tree->rbroot, offset);
>  	if (!entry) {
>  		spin_unlock(&tree->lock);
>  		return false;
>  	}
> +	zswap_entry_get(entry);
>  	spin_unlock(&tree->lock);
>  
>  	if (entry->length)

