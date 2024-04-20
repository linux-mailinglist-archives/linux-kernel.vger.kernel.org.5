Return-Path: <linux-kernel+bounces-152055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E98328AB816
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241761C20A0E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2A646;
	Sat, 20 Apr 2024 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtcfYdr0"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569A623
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713572303; cv=none; b=eCC9OGySDaNN6fcO9Wo5jW84OVrCroUEtbvlhVelr09/nkHo/VhvPs6QvMNAevwba600JSVOR8VUPrZry65mtI/Lw34iS6unYhIDjZEmYjLe9aPA+vCSaJGk/Y8ifkdSzfYpCZdKPyFCmTZEtQEdRrv8S0VZ4HqHWz5cH+fVGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713572303; c=relaxed/simple;
	bh=sXWs67bSvaRZ6Hfw+pm1zd557QDkr4ZDh5zqu12hRIs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ic5zAFvTnOp69DghdYKlGh/Lziu5I33/1ZJI8+QLuIRCMJrzoZLVrWJF+Z3FdaEfHnAicfGPh7FgAywW/DgSI3syDfVt12D1BYgEMZ+1MUhOpHzsh7ZfR9dnMPWN0TMD20yQcBQwAv03V2UJX958Dr8CDZ75cxU4BhcDIcXsKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZtcfYdr0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e84a894335so67685ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713572302; x=1714177102; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ikbl2Ly3fo9Zj3RwahsewHtxBq8zhBJhmAQdizY/PY=;
        b=ZtcfYdr0rwm9opkrtxLsbX5UXz5LJI9my8g06bD6mqlEfYq7Orb8BL/4vaYJeL+Hdp
         eA7JwTwGDFqTfYI4x5wauHME2hQjHyt2Ka8rBZvjphslCMsQ5DCT0iNAbFCFgeogSOPX
         GKHb9joZCO3d4LVx6eWupBsjgG0ZkE0w5eHwNmc9b3le5eU1vwsdJ/L9sKX36a/7PQMd
         mgRx5wQWfaFQK1nEvuG5Wma7cMtp7hJWRSLkhBFy6gnPRIgK0+ryFEWf+RcT8kfZYB6I
         lcgc7liqqaI5+AQuTCPWoSAugl+12YIG1AoC4SEeLhojr/79z1Qcxro4Gs97Hru+ieT8
         lHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713572302; x=1714177102;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ikbl2Ly3fo9Zj3RwahsewHtxBq8zhBJhmAQdizY/PY=;
        b=fsjZGE4/WmQVoKS8bMU4nXH6aQdhYKdubl6xajYyVfAoKInTcyHxiiYWtHGG9Zm/Oj
         hJQqr+nVDbR6xnqdwuzHe9KCdXLJDuBc7I6oorDKVYmFmHjKg3Ve7VEzxUwsXTyuOVRH
         disF7KS6zFaa8eUGKXH9yVz+MAgpzaZCocRqtaejaStcFwItwn/ZJ/TVd+uzq8W5QCUm
         StcnRzDnJVrBGFsP0FVRoLRA75D/C5pj6SkHzMHPK2RwC1pMKLi0KJMGR+jZ6jJFs9L5
         rMqN9lB46LPIFshkI7N8SpU9MKZnECIE5EE7kaT0eNY9ibNmiHeKqbt6//e1cAwhbjad
         EIyA==
X-Forwarded-Encrypted: i=1; AJvYcCUESDIuJXKE7S7FRFjRzuY3QrV61lPSLHAvbmkUVWjApzmiHQHT+bU9R67kq2ydyml2uQ4wBYJuAT6riKkJJJNMVwcfLGE6UUg9m9PZ
X-Gm-Message-State: AOJu0YxrJ2rJMg35hTxmTfX08++BxeSa5wYe6jukJo8ju7krJneuC65+
	aNquhvYgQC+0/5fMPUpR/Y4AYpZ06AjWewWT9wbqXvDW9bpgLuvJ2TXJ3jiefg==
X-Google-Smtp-Source: AGHT+IHf5XjAvQoLHaG46v0y3LMf7DvcMz7JEFAGu+4N2BrQj4crccmIs4asCfg4ObgdDpQURWmzqw==
X-Received: by 2002:a17:902:c405:b0:1e8:58ec:c139 with SMTP id k5-20020a170902c40500b001e858ecc139mr47591plk.3.1713572301417;
        Fri, 19 Apr 2024 17:18:21 -0700 (PDT)
Received: from [2620:0:1008:15:1ed1:e8c8:9e4a:e624] ([2620:0:1008:15:1ed1:e8c8:9e4a:e624])
        by smtp.gmail.com with ESMTPSA id b186-20020a62cfc3000000b006ecf56cb55fsm4071548pfg.96.2024.04.19.17.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 17:18:20 -0700 (PDT)
Date: Fri, 19 Apr 2024 17:18:18 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz, 
    cl@linux.com, akpm@linux-foundation.org, penberg@kernel.org
Subject: Re: [PATCH v3 1/2] slub: introduce count_partial_free_approx()
In-Reply-To: <20240419175611.47413-2-jianfeng.w.wang@oracle.com>
Message-ID: <3e5d2937-76ab-546b-9ce8-7e7140424278@google.com>
References: <20240419175611.47413-1-jianfeng.w.wang@oracle.com> <20240419175611.47413-2-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Apr 2024, Jianfeng Wang wrote:

> diff --git a/mm/slub.c b/mm/slub.c
> index 1bb2a93cf7b6..993cbbdd2b6c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3213,6 +3213,43 @@ static inline bool free_debug_processing(struct kmem_cache *s,
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  #if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
> +#define MAX_PARTIAL_TO_SCAN 10000
> +
> +static unsigned long count_partial_free_approx(struct kmem_cache_node *n)
> +{
> +	unsigned long flags;
> +	unsigned long x = 0;
> +	struct slab *slab;
> +
> +	spin_lock_irqsave(&n->list_lock, flags);
> +	if (n->nr_partial <= MAX_PARTIAL_TO_SCAN) {
> +		list_for_each_entry(slab, &n->partial, slab_list)
> +			x += slab->objects - slab->inuse;
> +	} else {
> +		/*
> +		 * For a long list, approximate the total count of objects in
> +		 * it to meet the limit on the number of slabs to scan.
> +		 * Scan from both the list's head and tail for better accuracy.
> +		 */
> +		unsigned long scanned = 0;
> +
> +		list_for_each_entry(slab, &n->partial, slab_list) {
> +			x += slab->objects - slab->inuse;
> +			if (++scanned == MAX_PARTIAL_TO_SCAN / 2)
> +				break;
> +		}
> +		list_for_each_entry_reverse(slab, &n->partial, slab_list) {
> +			x += slab->objects - slab->inuse;
> +			if (++scanned == MAX_PARTIAL_TO_SCAN)
> +				break;
> +		}
> +		x = mult_frac(x, n->nr_partial, scanned);
> +		x = min(x, node_nr_objs(n));
> +	}
> +	spin_unlock_irqrestore(&n->list_lock, flags);
> +	return x;
> +}

Creative :)

The default value of MAX_PARTIAL_TO_SCAN seems to work well in practice 
while being large enough to bias for actual values?

I can't think of a better way to avoid the disruption that very long 
partial lists cause.  If the actual value is needed, it will need to be 
read from the sysfs file for that slab cache.

It does beg the question of whether we want to extend slabinfo to indicate 
that some fields are approximations, however.  Adding a suffix such as 
" : approx" to a slab cache line may be helpful if the disparity in the 
estimates would actually make a difference in practice.

I have a hard time believing that this approximation will not be "close 
enough" for all practical purposes, given that the value could very well 
substantially change the instant after the iteration is done anyway.

So for that reason, this sounds good to me!

Acked-by: David Rientjes <rientjes@google.com>

> +
>  static unsigned long count_partial(struct kmem_cache_node *n,
>  					int (*get_count)(struct slab *))
>  {
> @@ -7089,7 +7126,7 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
>  	for_each_kmem_cache_node(s, node, n) {
>  		nr_slabs += node_nr_slabs(n);
>  		nr_objs += node_nr_objs(n);
> -		nr_free += count_partial(n, count_free);
> +		nr_free += count_partial_free_approx(n);
>  	}
>  
>  	sinfo->active_objs = nr_objs - nr_free;

