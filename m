Return-Path: <linux-kernel+bounces-38155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803683BBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6D31C22193
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2517731;
	Thu, 25 Jan 2024 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gBIZkJy0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C4D175B4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170682; cv=none; b=RNiTPrr0f369cf01S482yxoWZtguj+cGEo5XEnX1oohcIc41lh0WhFnxwO+KsSDSV7hsjQpr1RRRh0xZJoyGqxnTNLDzpTTJJPbNhzUjrYPDoKliPWm3qCuYrm5axCLoKnuwQT9JbD+GCWhLEVxl2aoD8HMyhqxrtB5d+A7HPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170682; c=relaxed/simple;
	bh=sFctqVWbDUqDw0RrvO2CgB1OovkrJu9rF6i1QyD1CwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cphisZ52uHnTas5Qe880/lZRVvpqFm/Vv1SPcnLbfUo08l71ku/lTUZwov9u1Gd6qZPePXj2ykwr1+IlSdEcvg8P2NSdtpzx3h2mHE6tYTXPxjupo5oweJ8ym5qwr7iYOcpHpxkeJCaYBccCyN7ZcBSTVXiC25Gfgeh1yiab9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gBIZkJy0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d76671e5a4so26992695ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706170678; x=1706775478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBTHq4bMG1gDrvHUu2w4lSj2h0O+hUHl7UPziFU1CFQ=;
        b=gBIZkJy0jDNlYNBMdOAQMSk9q5cRBmHQVeKJZ1E4OxomevM83JCyEjxpbjYK94wBTh
         ZvA6iHDDeGdVleDWzzN+u1nzl4hHX3R6M0A+MPOlZs5IVcNfarimn4LUExFNv3CvOpGx
         fh2ODu56b7FVuwPSI9YMxyuMWWz/+lZhpFfadUAh1QIUsOirp28BkbMuXo0ogcEV9iSE
         O8iHSf7opNtgIsVidPZziBPtF5t96HtM5n1XQPy/+Vc30hynJ4Tja/7/eDk8O9Mu0GkL
         9KpNzZjfxghQsYcxHOjL3d4i+7LbTRig2visrAJhWbH83SF/M3tET9NrY2M2d7wqqM6e
         hkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706170678; x=1706775478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBTHq4bMG1gDrvHUu2w4lSj2h0O+hUHl7UPziFU1CFQ=;
        b=qUcdIBh/3xRHE+9DBfEaf1VgHvE9YmkvvQIKMrZnJUqnp95rEurIqJdyosL+wrM5i0
         ealCQp1wNPrzMDDq8m1nxHmbPz3tDNzYiIe6HZiljKyJBZL1wWI87BRdSoAJqvKBEkzG
         h1moHsWhJGLYVPrsR9It0XdstWat11w6jwh1abEVp8OQTqjWbVYoVdrTW366nEUpQuy3
         C/dGh+kxDw6P70eIIa+jEYZDEwJI6yqrniM8Yux75l+e9CC8bZSgWeRALBU2B2+RfP3A
         enFZuRgladOvY/M6HVdHQPeDEFywqhdTTAd9fBP03P6ney1+UG+5m14FY6klK/miW0RB
         DoNg==
X-Gm-Message-State: AOJu0YwWsbus6Rm1dLU8hZczSh2xNK+5gdURn/u3B9IgzW4E7NOK4JBA
	4hLYQKZ035ooP+nf3kul3gSXs+yw7J4LE8Y5FE8WZXqYNl72VTQj+bDBZdnIf97qgyBgXxHu5WP
	r
X-Google-Smtp-Source: AGHT+IF8qZjF1mquaMxoS+es9e/DvB2FXCF+lh/TuX5XX+zGSS53OXXu7j7PUU022c/Chid+JIqtvA==
X-Received: by 2002:a17:902:bc4c:b0:1d7:41b9:9a65 with SMTP id t12-20020a170902bc4c00b001d741b99a65mr681181plz.89.1706170678729;
        Thu, 25 Jan 2024 00:17:58 -0800 (PST)
Received: from [10.4.195.141] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f2c900b001d72b14e98bsm8344576plc.124.2024.01.25.00.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 00:17:58 -0800 (PST)
Message-ID: <c99a16fc-f459-4283-a65b-2ff84dd0bf15@bytedance.com>
Date: Thu, 25 Jan 2024 16:17:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zswap: remove unused tree argument in
 zswap_entry_put()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240125081423.1200336-1-yosryahmed@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240125081423.1200336-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/25 16:14, Yosry Ahmed wrote:
> Commit 7310895779624 ("mm: zswap: tighten up entry invalidation")
> removed the usage of tree argument, delete it.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM, thanks!

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 78df16d307aa8..8f4a7efc2bdae 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -569,8 +569,7 @@ static void zswap_entry_get(struct zswap_entry *entry)
>  /* caller must hold the tree lock
>  * remove from the tree and free it, if nobody reference the entry
>  */
> -static void zswap_entry_put(struct zswap_tree *tree,
> -			struct zswap_entry *entry)
> +static void zswap_entry_put(struct zswap_entry *entry)
>  {
>  	int refcount = --entry->refcount;
>  
> @@ -853,7 +852,7 @@ static void zswap_invalidate_entry(struct zswap_tree *tree,
>  				   struct zswap_entry *entry)
>  {
>  	if (zswap_rb_erase(&tree->rbroot, entry))
> -		zswap_entry_put(tree, entry);
> +		zswap_entry_put(entry);
>  }
>  
>  static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
> @@ -924,7 +923,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>  
>  put_unlock:
>  	/* Drop local reference */
> -	zswap_entry_put(tree, entry);
> +	zswap_entry_put(entry);
>  unlock:
>  	spin_unlock(&tree->lock);
>  	spin_lock(lock);
> @@ -1754,7 +1753,7 @@ bool zswap_load(struct folio *folio)
>  		zswap_lru_del(&entry->pool->list_lru, entry);
>  		zswap_lru_add(&entry->pool->list_lru, entry);
>  	}
> -	zswap_entry_put(tree, entry);
> +	zswap_entry_put(entry);
>  	spin_unlock(&tree->lock);
>  
>  	return true;

