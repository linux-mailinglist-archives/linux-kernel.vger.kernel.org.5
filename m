Return-Path: <linux-kernel+bounces-92460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4C687207D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E837D286543
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5F8612E;
	Tue,  5 Mar 2024 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfSz9unA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA184A48
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646058; cv=none; b=Fnc4jMSHv0oiywCZ4X/mVfn0BbreODhTpXCinWKjf7qs7S/PBJ2JDiZDbuLgGXCP/cTjHPRd3ZsWWm0H//Hp33V/IrmzwKy5CI2eHQ3LU6r9n/1om5wDiB8TcM1qub31OrMCtCZub7ODnMmAKPjTh/AepE9+Zu4A/XsLCMUTjX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646058; c=relaxed/simple;
	bh=gCvvh0vURqAlK8Beg+gkWcB1oIpv4RhGjzUK9b2R6Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWtxUYMr0sqYD2ZWYuoiLBv8MBJPFAIvW0HDECJassE7IyP8cZIC5mjuxkS8+qNdR3pl+tYeD/gNUx3S/1tFUeEOTy21dVRu3btLLx9WvMWSoinBQ5rq8qqFHLNobdDmfW+PsGSkt5uy+ZPKU24vboskM4Cxly6U8+jZvI81HFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfSz9unA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709646056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZnEToW5t7As1au0rwMSuY1nkYFxsgpWnFlldMYKeW4=;
	b=NfSz9unA4rAFpOn6BKEJDJZr1FD++oHTDWHVF+QM2X9NAXp6STMUHGNA5mvTkmh4sEUE4l
	E+JigwEdch4OCjxzOu3+BweJFFTMfxXyratlioisbn8XSwsFAe+EHryXgINmNf4bZDgwPY
	gmJlRKyWcfNZHjv3ouitvya/UJ09YyY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-ZNEMY3gsNWmSK7pySo_ePg-1; Tue, 05 Mar 2024 08:40:55 -0500
X-MC-Unique: ZNEMY3gsNWmSK7pySo_ePg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8dbe37d56so5044452a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709646054; x=1710250854;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZnEToW5t7As1au0rwMSuY1nkYFxsgpWnFlldMYKeW4=;
        b=Sxf8nQjn/Ir4H3JkR+OKOF7Y3j6C9R2obfz8llM3xsPjwTXf8aVbGv5jpW5KJQtGOr
         xJxNflHnUpz5vn2TSq2TfdtMJx3sLR+SRikKfWRA1OTolhx8CzC2VKtvA/IZU4QmXuCF
         71+sob/oGryGJ1aXVCTvy2f0ngCpHrTC1LTLq71NhE4cN/qFVRQzdFAEo5K18w9hQQZH
         LwWW4MzqsznAfMZF7TdorezAsctYRn3EA+LUQDB4dJx4IhRTgQu6fSuOFt4i15gqb6Pg
         xy3JYGTD29+1oEY1+mNyaSebT5dYhP32e6mHPAb8mZX4BZ1ClmUxHrFsPkwp7obIt2OI
         ofTg==
X-Forwarded-Encrypted: i=1; AJvYcCWqiKpkhktOjcbxS7hS0tZ6B+jWBLK2XtPa3e6pF3cmzsjE1g30wdKKPiweTLrlHpJghrdkSBCtth7nuvcnOg+5yv/5IKpcydeSkThj
X-Gm-Message-State: AOJu0YypGgXzjAAmDKjLL/KeG+h7uEg3ujsL2aLvKoQ9oEyDC0NqunOM
	hVWzCysBnwZUGsLG3Sl1NR3XkoLw1ptalPLspgaP1JvmstKWhIOVecgtjiRxEmDhhDr+F/60NV+
	ed61O6zSOTthjIhSiqYEhFpHsmkkca21vf9PiKN/qdeIMJm/nxuQsMkRmbk7pDw==
X-Received: by 2002:a05:6a20:cea4:b0:1a1:45b8:bba4 with SMTP id if36-20020a056a20cea400b001a145b8bba4mr1537447pzb.37.1709646054016;
        Tue, 05 Mar 2024 05:40:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZZ9bEhXrO6qofCmunP2PwITI7ouZsIJbjodQXvB3Cecr0rJmvJ+jNDD8uikp00KYqrjuu6g==
X-Received: by 2002:a05:6a20:cea4:b0:1a1:45b8:bba4 with SMTP id if36-20020a056a20cea400b001a145b8bba4mr1537431pzb.37.1709646053643;
        Tue, 05 Mar 2024 05:40:53 -0800 (PST)
Received: from [10.200.68.248] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id a13-20020aa78e8d000000b006e558416202sm9236593pfr.148.2024.03.05.05.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 05:40:53 -0800 (PST)
Message-ID: <fbe9453d-53c5-44d1-a478-2496c5928603@redhat.com>
Date: Tue, 5 Mar 2024 14:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nouveau/dmem: handle kcalloc() allocation failure
Content-Language: en-US
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com, lyude@redhat.com, kherbst@redhat.com,
 linux-kernel@vger.kernel.org
References: <20240303075312.56349-1-duoming@zju.edu.cn>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240303075312.56349-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Duoming,

On 3/3/24 08:53, Duoming Zhou wrote:
> The kcalloc() in nouveau_dmem_evict_chunk() will return null if
> the physical memory has run out. As a result, if we dereference
> src_pfns, dst_pfns or dma_addrs, the null pointer dereference bugs
> will happen.
> 
> This patch uses stack variables to replace the kcalloc().
> 
> Fixes: 249881232e14 ("nouveau/dmem: evict device private memory during release")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>   drivers/gpu/drm/nouveau/nouveau_dmem.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 12feecf71e7..9a578262c6d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -374,13 +374,13 @@ static void
>   nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
>   {
>   	unsigned long i, npages = range_len(&chunk->pagemap.range) >> PAGE_SHIFT;
> -	unsigned long *src_pfns, *dst_pfns;
> -	dma_addr_t *dma_addrs;
> +	unsigned long src_pfns[npages], dst_pfns[npages];
> +	dma_addr_t dma_addrs[npages];

Please don't use variable length arrays, this can potentially blow up
the stack.

As a fix I think we should allocate with __GFP_NOFAIL instead.

- Danilo

>   	struct nouveau_fence *fence;
>   
> -	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
> -	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
> -	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL);
> +	memset(src_pfns, 0, npages);
> +	memset(dst_pfns, 0, npages);
> +	memset(dma_addrs, 0, npages);
>   
>   	migrate_device_range(src_pfns, chunk->pagemap.range.start >> PAGE_SHIFT,
>   			npages);
> @@ -406,11 +406,8 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
>   	migrate_device_pages(src_pfns, dst_pfns, npages);
>   	nouveau_dmem_fence_done(&fence);
>   	migrate_device_finalize(src_pfns, dst_pfns, npages);
> -	kfree(src_pfns);
> -	kfree(dst_pfns);
>   	for (i = 0; i < npages; i++)
>   		dma_unmap_page(chunk->drm->dev->dev, dma_addrs[i], PAGE_SIZE, DMA_BIDIRECTIONAL);
> -	kfree(dma_addrs);
>   }
>   
>   void


