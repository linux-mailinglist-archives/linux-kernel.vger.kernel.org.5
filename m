Return-Path: <linux-kernel+bounces-92721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 476618724EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CB1B21629
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9090EDDAD;
	Tue,  5 Mar 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAT0mdQc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345813FE0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657704; cv=none; b=c3hVrR/NGnjVaP5dQh6p/WZda0U/LYqTjYrRV4FK0YYFISa+Ocprr3kNspGwdQXJT0EsOQLjiD+Jhn0+649vB9OKDbpW5cJhFRx8ATJc+Yo4sFH2Z1Lut9xrMKu9n1F0dfQHQ1LC/cFniM/wPpp4ss3oN1gU7+iFpNntgDylayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657704; c=relaxed/simple;
	bh=PRaonYPYUdbmRN+RYzUyp2iAubGYp/R4DwvNbWHE0/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gxa2+N/iJlOnm7rgCfys3tPHNT4H0fzO8Hr7yBO+YZVVicAUUXRP9vUWYWjm2gaUZiqn+ZHNWWBujMOLgurK12TRJ4HP+4+sU2nBb5kOblA5q71VpwhTCNyCUpXZuwGOiE0LvplqYjnURPwKa6FmhpXsishqCFLQybOq8o9uK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAT0mdQc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709657701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2z9lZCL9Z3rimHOG8O2ywzmChw7nkWjJ7ypccwQP5g=;
	b=KAT0mdQcwWzyfROxFekwASXIz4LS5E7te3iVnzr9ZVG6712BMGUYUm5shWakPbTPQyelDK
	u6KV/uqeaLslUB77kVfda+wcpI+C0wFOIa/RYIXYkNr//xVZXt7f7Gm9CYo9jx+QYiBTqs
	G3ouL4llISdhiWtpiCCYZdfTDYutufg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-EjWsLqR6OTi7Hk1MrcroIA-1; Tue, 05 Mar 2024 11:55:00 -0500
X-MC-Unique: EjWsLqR6OTi7Hk1MrcroIA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78825e5e374so468117585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 08:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709657699; x=1710262499;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2z9lZCL9Z3rimHOG8O2ywzmChw7nkWjJ7ypccwQP5g=;
        b=PkLgJ0Cqa200vfJ9smT6MypFXqz+5R0Vg3shPxyqRd/MxKR5SUR+73JhwgjKkH/Pai
         j0EzOq4/kU/iHtv7rxJbmWWdOAE6+BZk6T9kCCqMyD4cvhlqehyU361l8vdtotNUrnfU
         saSKJyZVfV8mGmhTqWnJ7WQuabALaNhYrfag7TuEB/19WU3+5xAXP2PJbcvJd5fJkOsc
         DITdCeUHDfYCjjpYIM4W1sjJzZ8RKKdhyy4iR4gWERo0mV1ICY04G7E5x1b3Vk1a5zux
         kn6G662jrCQsoXlSzwtzTggbpQK5sV4ZtS2E1MCURTcpPcCDSFp/h+h08EpXTSViwYxe
         Ee3w==
X-Forwarded-Encrypted: i=1; AJvYcCWOEJuAN2rj9C42BBFCa9B3Mtoe34t0aTuDjuRmTdKb7TZX1eiXGbTC7NWEltLjMHMun32BdGqp8p8CoXrycWpr1uTkgbYVXobZeGQZ
X-Gm-Message-State: AOJu0YyI65L+iInyspPuxLPdRKEH0PgEsKpQKnSFMuMRouu+Tbc9T4Ld
	JNJ9SjgnKQzTwjku/S9O7LUbnaHW4lr++mIvr1FcJQT46cEZHJFzSlQv+yOozqVyQ6s/ITMZRH8
	2aoq1i5kBIy3BC3u40Py6ACjmchYc7GYaRTEo7mKwSeQAVh9upJ0yuNl4YqJiwDs6AmMizw==
X-Received: by 2002:a05:620a:1482:b0:788:322f:e8ab with SMTP id w2-20020a05620a148200b00788322fe8abmr3727318qkj.2.1709657699561;
        Tue, 05 Mar 2024 08:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExv3MZheDgrjYzjAL3lBjTHXd+iKVpZeMtwriKBSS2qghKHcd7atNz/pH30IdbdmikOhTY+A==
X-Received: by 2002:a05:620a:1482:b0:788:322f:e8ab with SMTP id w2-20020a05620a148200b00788322fe8abmr3727284qkj.2.1709657699281;
        Tue, 05 Mar 2024 08:54:59 -0800 (PST)
Received: from [10.32.64.131] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id p14-20020ae9f30e000000b0078825e2c57dsm2507620qkg.76.2024.03.05.08.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 08:54:58 -0800 (PST)
Message-ID: <93c832af-55df-4149-b9d1-1171528809c2@redhat.com>
Date: Tue, 5 Mar 2024 17:54:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nouveau/dmem: handle kcalloc() allocation failure
Content-Language: en-US
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, airlied@gmail.com, lyude@redhat.com, kherbst@redhat.com,
 timur@kernel.org, jani.nikula@linux.intel.com, nouveau@lists.freedesktop.org
References: <20240305143936.25283-1-duoming@zju.edu.cn>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240305143936.25283-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Duoming,

thanks for sending a V2.

On 3/5/24 15:39, Duoming Zhou wrote:
> The kcalloc() in nouveau_dmem_evict_chunk() will return null if
> the physical memory has run out. As a result, if we dereference
> src_pfns, dst_pfns or dma_addrs, the null pointer dereference bugs
> will happen.
> 
> Moreover, the GPU is going away. If the kcalloc() fails, we could not
> evict all pages mapping a chunk. So this patch adds a __GFP_NOFAIL
> flag in kcalloc().
> 
> Fixes: 249881232e14 ("nouveau/dmem: evict device private memory during release")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>    - Allocate with __GFP_NOFAIL.
> 
>   drivers/gpu/drm/nouveau/nouveau_dmem.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 12feecf71e7..f5ae9724ee2 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -378,9 +378,9 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
>   	dma_addr_t *dma_addrs;
>   	struct nouveau_fence *fence;
>   
> -	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
> -	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
> -	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL);
> +	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
> +	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
> +	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL | __GFP_NOFAIL);

I think we should also switch to kvcalloc(), AFAICS we don't need 
physically contiguous memory.

Sorry I did not mention that in V1 already.

- Danilo

>   
>   	migrate_device_range(src_pfns, chunk->pagemap.range.start >> PAGE_SHIFT,
>   			npages);


