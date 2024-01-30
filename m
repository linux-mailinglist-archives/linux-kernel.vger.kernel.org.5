Return-Path: <linux-kernel+bounces-43906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C52B841A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED659288957
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB6374EC;
	Tue, 30 Jan 2024 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MaRkAfHu"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AB637157
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585906; cv=none; b=E9dH7kt7++WpS8XgHqzERGibt1wRqk1eD8gb0cV0v7+4y698mIgW9TozYsrugTGfsJFCdYhYnK8pWeBycl39rp2uIc5UkRi6r90b6x/oGDl7C1hCq2s+3IFRWgo4goZ1UWLAjFcxiMI9yF+ZSTVA5yr7mwT3HCoBqFEKuHUt7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585906; c=relaxed/simple;
	bh=hrhjCjwcpKd5uPHlgQDEg1iyA95whv3Si59NO63537k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCKKNigRmUGGJau3ZIhqU9Trl3s2Wi9FDEQreTPP7r6zdGkas74qSpQun8af0moBTfUgHMSKz551pSsmCwMvOQHLFnIJB7I3tgpSEyDYzXuL2wH9IEK5ET9WbnFHdS0+xua87WHDqbBA0rY7uG+lldYQsUOAnxGAb+Hg9Dx/gsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MaRkAfHu; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a181a46b6so1566594eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706585904; x=1707190704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gw55zBaaI7yFdI/zISx3TPRgzCmi5RYxU+fJSD063z0=;
        b=MaRkAfHuY6mrmHllHQtmjfOInvxQ/oUaEU+lLXIbUdD5zfrP+AJkCuLQ/0rxQmbWp6
         hfZNsZhZtNVZv8mOOswo/j5XKYA54OpBPvsTYF+XGebas6pECbZtf1kquL5EempmusGp
         6Ct9/bFzkzdYQAdHMXp2nObNF9x6QREE+3WHyfry0NLkL5Dk2Xuy/dEpCTfgU3dpX2P8
         WYqyNJ7y/cAb+p92MnB9eGjQ2WxLGyevjFNsjRUzAoBKUqaF0tMZeBHcjuO8xMipsOrC
         0fa6QhJdvJ7Jr6mNlXYjdADcGbGVmfF/h1fO8zldQ0ZQiwiwVws7YlZtYAK9QWZjMLmt
         ntqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585904; x=1707190704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw55zBaaI7yFdI/zISx3TPRgzCmi5RYxU+fJSD063z0=;
        b=CibT+uvj65F9uRzno+8LlicTAdilJCnI1LCzD3c71/UokOPi9YTedGdb3tJS4Eh6xe
         VG0U09Pfr88QkFeESXGGlWyHXWR3HT9BXbJIFd9Zw+Eeb/ujja22Ezqgi7zcN05FThkp
         W0HN9E/9y369MMOd8aiGSdZrN9SZyXUu/0NsySy+fRoLFBQ72PfMoidrD2tSvN/sLYN0
         vuuAYACDwb/Lfd2i2ewbmiTrYvcs1GJyFKU91p8RWXpGem5VhxVFaDIZYXqtDqFPabXS
         +v9XQuoFD77idka7cHgHw6zI7U18MkJlEdtBydyq3goCsdYsW1IvrJgMniE8mmSqeHuh
         Mzng==
X-Gm-Message-State: AOJu0YyRlLz3jt9xbzaNc9HZuMyfjGmsqpVV18ug+QH9U1bheBqGdebC
	CoGBQ0YLY+bH600Puy3hb58UkDhX33d9rwz6kk3wsBMu1H84EAb8jQSUbQvveKg=
X-Google-Smtp-Source: AGHT+IExJ7IYHKLRsORhO1SYYUTLHOYuFLPC3i8QwfgqQDC3LTA5TrwgWa7Z9haBsGBeeQp1j2oDgw==
X-Received: by 2002:a05:6358:89e:b0:176:d522:76b4 with SMTP id m30-20020a056358089e00b00176d52276b4mr4520101rwj.14.1706585904309;
        Mon, 29 Jan 2024 19:38:24 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y17-20020a63b511000000b005d8b481c4d3sm5561909pge.87.2024.01.29.19.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:38:23 -0800 (PST)
Message-ID: <fa164ca6-e7e2-48e2-87e1-0a6434481eb6@bytedance.com>
Date: Tue, 30 Jan 2024 11:38:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] mm: zswap: move zswap_invalidate_entry() to related
 functions
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-4-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014208.565554-4-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:36, Johannes Weiner wrote:
> Move it up to the other tree and refcounting functions.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index cf864aaa214d..9f05282efe3c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -559,6 +559,18 @@ static void zswap_entry_put(struct zswap_entry *entry)
>  	}
>  }
>  
> +/*
> + * If the entry is still valid in the tree, drop the initial ref and remove it
> + * from the tree. This function must be called with an additional ref held,
> + * otherwise it may race with another invalidation freeing the entry.
> + */
> +static void zswap_invalidate_entry(struct zswap_tree *tree,
> +				   struct zswap_entry *entry)
> +{
> +	if (zswap_rb_erase(&tree->rbroot, entry))
> +		zswap_entry_put(entry);
> +}
> +
>  /*********************************
>  * shrinker functions
>  **********************************/
> @@ -809,18 +821,6 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
>  	return NULL;
>  }
>  
> -/*
> - * If the entry is still valid in the tree, drop the initial ref and remove it
> - * from the tree. This function must be called with an additional ref held,
> - * otherwise it may race with another invalidation freeing the entry.
> - */
> -static void zswap_invalidate_entry(struct zswap_tree *tree,
> -				   struct zswap_entry *entry)
> -{
> -	if (zswap_rb_erase(&tree->rbroot, entry))
> -		zswap_entry_put(entry);
> -}
> -
>  static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
>  				       spinlock_t *lock, void *arg)
>  {

