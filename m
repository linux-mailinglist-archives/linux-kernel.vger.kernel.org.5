Return-Path: <linux-kernel+bounces-160505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DE28B3E59
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2452823B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85515B99D;
	Fri, 26 Apr 2024 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuXCg+uO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1A14AD38
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152998; cv=none; b=ChjhEVoZVtpO2QPy/IPvDQO8Wxst5GBgPin9mliTiCqL20oSCsPc1IufTOPs2Y2s76jlPKel1ZosTVnU+16bWLgQxYLKlIgkaEjoMdQ0dFOdeiXgbIvFWChaiDJOhCqzu/QnoMYSTJCB+LLnBj+ATcwGjoGkuJKipz+MGut+l6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152998; c=relaxed/simple;
	bh=4l3yRXyHg3mK5vO/TO7jqMojFHUSF9wgI3tI7EB5TiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ns+XdNEtY9ZYA1zcvaHNN5jN5Qz+Sc7JDqAB46Cq4h3vZgBk7uQ0eGrvDurLRprX7VOKyjFaCygp64UMV/6fCx0auZQpef+uCAZ5Ov/2eIHC7eGiuie7eZHzFjs00rlT1obMgwoneMBd5KqGMxRZaXuJNTvlWuTErCtU8apdbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuXCg+uO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714152995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4VuHb1gFmXIB/FeEfholHCYEuftXxlfe2solR5B5lW8=;
	b=HuXCg+uO6R3x6GWvKgmcaiDBbAXZxRw1s6ONpjdmKRZ3zijMV6whe6B3Ku5EDZIF03vEi1
	Eg/6PCPvBlA46kRtM2BWSHuHnzXf0YaCD/siPwagfz5+ADxz0J/8amBuQ3DT10wLV1ihyw
	cD9GMyIgx4Tvq/N2DkNrpHLAWcZmdPI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-yrKO4a6jMYqm_epecQAbgg-1; Fri, 26 Apr 2024 13:36:34 -0400
X-MC-Unique: yrKO4a6jMYqm_epecQAbgg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41aa1bbddadso9899385e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152993; x=1714757793;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VuHb1gFmXIB/FeEfholHCYEuftXxlfe2solR5B5lW8=;
        b=AQWv2fb8qdunwLzsbWgvIgyNLn1QxQg53oBX3EAXEDb8d87ZN7LtYdzP5a5ACkFtrA
         lKg8DQuTc/ZuTUrCYCgQqGosTGTP9eNRC2RBxJpfdT3ChaSORerEyU5AHW4hyc9c4UsO
         0YJV/piPxIfd7U4tcquUhvZoQJCyPjNvj018+IHL8fVmwEye7BWe7XeJUXL7OpDYvK/D
         UYiBLH+sMsQGGKGWrXawuKp2pcOvkU8Q5HLw9s4BUG1U3LvrhUJy2WMBNGzRdaslkKwo
         ycQnT7Qy7pIDd9GuZDl+fOlG7kR3kCcTqsshzgjQnw4jm7ZlIgRkLOCaizd+yrJIk83o
         YKhA==
X-Forwarded-Encrypted: i=1; AJvYcCUwBryzPlhKZvS0JGD2Xr4pZnyj5llmm+237nwiLZs19rsjsGqAmBtyC5fDgeKgsCRKpIE4VBqK3DfHmc4/oTfdd7ZiQi/HYF3URekI
X-Gm-Message-State: AOJu0YyhXDr0hH9Oakmn0VzgbxZOJAdDINv4tzpjFKqvXhIrQumUXhlr
	qaAl5MjamEhW2Znic9R1mgQskeSigUQWa9lLYEqcqRCwdPcvfSSIBZUJMgCb3an8CFNzpDQfnmr
	zs8Spp8KkDj3dePJCSrphlbdc54s2m2PziqfrXbdsn64DzjfwZWlf/h6rgynRiw==
X-Received: by 2002:a05:600c:1394:b0:41a:8b39:8040 with SMTP id u20-20020a05600c139400b0041a8b398040mr2943868wmf.20.1714152993274;
        Fri, 26 Apr 2024 10:36:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNNgIDudDwqyvI6rxOrWgWJ8NW7tjiTOvzKJvhKOitiIk2dcvrJOLcFtFRjPACrfIlTFt9hA==
X-Received: by 2002:a05:600c:1394:b0:41a:8b39:8040 with SMTP id u20-20020a05600c139400b0041a8b398040mr2943851wmf.20.1714152992848;
        Fri, 26 Apr 2024 10:36:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82? (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de. [2003:cb:c726:6100:20f2:6848:5b74:ca82])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c1d8e00b0041bab13cd74sm1505014wms.17.2024.04.26.10.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 10:36:32 -0700 (PDT)
Message-ID: <31813228-4d2e-45f5-98d3-10cae826130a@redhat.com>
Date: Fri, 26 Apr 2024 19:36:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm: Optimise vmf_anon_prepare() for VMAs without an
 anon_vma
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>, Peter Xu <peterx@redhat.com>,
 Jann Horn <jannh@google.com>
References: <20240426144506.1290619-1-willy@infradead.org>
 <20240426144506.1290619-5-willy@infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240426144506.1290619-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 16:45, Matthew Wilcox (Oracle) wrote:
> If the mmap_lock can be taken for read, we can call __anon_vma_prepare()
> while holding it, saving ourselves a trip back through the fault handler.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   mm/memory.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7dc112d3a7e4..b5453b86ec4b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3232,16 +3232,21 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
>   vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
> +	vm_fault_t ret = 0;
>   
>   	if (likely(vma->anon_vma))
>   		return 0;
>   	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> -		vma_end_read(vma);
> -		return VM_FAULT_RETRY;
> +		if (!mmap_read_trylock(vma->vm_mm)) {
> +			vma_end_read(vma);
> +			return VM_FAULT_RETRY;
> +		}
>   	}
>   	if (__anon_vma_prepare(vma))
> -		return VM_FAULT_OOM;
> -	return 0;
> +		ret = VM_FAULT_OOM;
> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> +		mmap_read_unlock(vma->vm_mm);
> +	return ret;
>   }
>   
>   /*

Fancy

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


