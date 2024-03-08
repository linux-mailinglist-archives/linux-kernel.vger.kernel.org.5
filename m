Return-Path: <linux-kernel+bounces-97321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C28768C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85655287DAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E414265;
	Fri,  8 Mar 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6V4gDSU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E61F953
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916340; cv=none; b=UMP2QH6eYjGhr8nLBuguNro5D9vqXpge+jbL6EqQVXWECT/JidBkK/Z8y45+orB2HzHdvgGXxqGmobCxpFTO4Sp9ViAMyK5DakBanttozrChD+H0fLzAjO6iQ322hVnsUrW5I7cabYpIJgAOSVcFCXuytVD7E/dmsMgaVDmxpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916340; c=relaxed/simple;
	bh=RjaNT49ljT8g4/bWagEUh7Y92fvPnAxD9ciM0m/L/Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgxTi02bgV1Zva0PrLme7mGeuKc1rQkPkA6uIfwsLjJmjg2stNZuxp5nbjSo24h7a/z9NOg3UhxDLOE8sb8rFGYjThexeVJI0hhP8643BB2CEFX9ip6Y5FAfTxkNoCQMiadhOGxTW7+XLUeNC4ej0F1N5zan3dzcnSa+Ubvf7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6V4gDSU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709916337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=534u/67YBq7t7mIqXOVTlZcmBGl/1NW7WJ5BcOAUIpI=;
	b=E6V4gDSUEDRcPdFI4nvpzfIYRTFGdmXL0gZJvfs7R8AjP4z3ORuC/z6jupS399imSkEnE0
	Y855IEQ7VSH9djN9IX9QVOdr4iv+tBhQhrxpGAs5jtRUfucWDDzWapRkCcd2gdVRZRVAhn
	1pLrCNCCSmOMS4gu9UjsmRDuX4Gw7Lk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-NCq3qJnSOtqVgoL_dO40-Q-1; Fri, 08 Mar 2024 11:45:35 -0500
X-MC-Unique: NCq3qJnSOtqVgoL_dO40-Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a45851b0030so107415366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 08:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916334; x=1710521134;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=534u/67YBq7t7mIqXOVTlZcmBGl/1NW7WJ5BcOAUIpI=;
        b=BQQ6QHh0d3oSQvL2P0PW6BZJO3L32RFuxYbqZPkAT1pIwMWE0pCmwmgZCNbaE3qo6j
         FRl5LKXH/Ep9hSlxjWAlNmA2tbN3TwhBru1MJlV55HyMoqU3sP/jlspD2NsU/Mz80Z6W
         B2ss6ld2idzcwRcwSpwR0KN5uZZ2EO8dMQ4l1Z0fRaQt9a7MoYK+KibZ3HrlLMQ0DgcA
         WpKeXKtRkjn7timJb3j9PGmgkQdLQgkq+5LdR3NJWeeGSi78sv0n4tT7EzASq5zKQ8L1
         sbUtwbvPR0PVqxqjqMfPeo+CRI6TFE4iZOIEh9PgTCSiuSMwdxRUTQi5+k7YoPF/k6Aj
         YXfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNHnvdaeUTc7U8HrqnR6dUa2jvSmC5Hll1hwx8L5rUqP/Jh9XwNTy6GTxFYUCJEYpERBNIbiOdFrScDes/CQ4nUmLzxEsIlyz5obRW
X-Gm-Message-State: AOJu0Yyd5Ttykh60i+rv24XEjgTq8XutTI3MjqR2AuvwL1PmFlVMMTX4
	A5qORR4HUwuB8VgW3d1Ow1eVrFVa515AcnUbi8UzThxn2t1TvCiCINAn7E6pZY7wGvLwN1d6/6u
	rK4vSEzQmU926A0mzZfW5htk356+456cxs+JRviHLJR62iWGJwuPAjNhUJNKfWg==
X-Received: by 2002:a17:907:d301:b0:a45:f4d9:d911 with SMTP id vg1-20020a170907d30100b00a45f4d9d911mr1172172ejc.34.1709916334734;
        Fri, 08 Mar 2024 08:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn7ZndBGszHKq0H8y6c/T3rs7VSPm+fqpniPAcpA1gNnmrOtVIRBYfNM3Sudcp2tOC29DwLw==
X-Received: by 2002:a17:907:d301:b0:a45:f4d9:d911 with SMTP id vg1-20020a170907d30100b00a45f4d9d911mr1172156ejc.34.1709916334330;
        Fri, 08 Mar 2024 08:45:34 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906119200b00a45e04e3ebdsm1409444eja.83.2024.03.08.08.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 08:45:33 -0800 (PST)
Message-ID: <fc80adaa-3bbc-4331-abd3-3cfbff9b3dcd@redhat.com>
Date: Fri, 8 Mar 2024 17:45:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nouveau/dmem: handle kcalloc() allocation failure
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, airlied@gmail.com, lyude@redhat.com, kherbst@redhat.com,
 timur@kernel.org, jani.nikula@linux.intel.com, nouveau@lists.freedesktop.org
References: <20240306050104.11259-1-duoming@zju.edu.cn>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240306050104.11259-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/24 06:01, Duoming Zhou wrote:
> The kcalloc() in nouveau_dmem_evict_chunk() will return null if
> the physical memory has run out. As a result, if we dereference
> src_pfns, dst_pfns or dma_addrs, the null pointer dereference bugs
> will happen.
> 
> Moreover, the GPU is going away. If the kcalloc() fails, we could not
> evict all pages mapping a chunk. So this patch adds a __GFP_NOFAIL
> flag in kcalloc().
> 
> Finally, as there is no need to have physically contiguous memory,
> this patch switches kcalloc() to kvcalloc() in order to avoid
> failing allocations.
> 
> Fixes: 249881232e14 ("nouveau/dmem: evict device private memory during release")
> Suggested-by: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Applied to drm-misc-fixes, thanks!

> ---
> Changes in v3:
>    - Switch kcalloc() to kvcalloc().
> 
>   drivers/gpu/drm/nouveau/nouveau_dmem.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 12feecf71e7..6fb65b01d77 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -378,9 +378,9 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
>   	dma_addr_t *dma_addrs;
>   	struct nouveau_fence *fence;
>   
> -	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
> -	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
> -	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL);
> +	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
> +	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
> +	dma_addrs = kvcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL | __GFP_NOFAIL);
>   
>   	migrate_device_range(src_pfns, chunk->pagemap.range.start >> PAGE_SHIFT,
>   			npages);
> @@ -406,11 +406,11 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
>   	migrate_device_pages(src_pfns, dst_pfns, npages);
>   	nouveau_dmem_fence_done(&fence);
>   	migrate_device_finalize(src_pfns, dst_pfns, npages);
> -	kfree(src_pfns);
> -	kfree(dst_pfns);
> +	kvfree(src_pfns);
> +	kvfree(dst_pfns);
>   	for (i = 0; i < npages; i++)
>   		dma_unmap_page(chunk->drm->dev->dev, dma_addrs[i], PAGE_SIZE, DMA_BIDIRECTIONAL);
> -	kfree(dma_addrs);
> +	kvfree(dma_addrs);
>   }
>   
>   void


