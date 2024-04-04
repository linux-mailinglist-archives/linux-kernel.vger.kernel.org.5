Return-Path: <linux-kernel+bounces-131979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEF0898E33
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F75C1C21C89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31153130A48;
	Thu,  4 Apr 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5OG3hRF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE12208A7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256276; cv=none; b=oONV0SCU6D6oLi6EZBBuywpugY7hPq+AXmTEqoESsz8NdwBXl8UgcXglcARzTSTYNYAi891KlxOUzs8ycnuYNYLMnkCMGxRo3ptOgcAOPbKDpUEu+cn7SmUSd8ZUXgNYyq515xWcAwDtB7LiH21LLvj/eNB8viW0H9w1Srad2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256276; c=relaxed/simple;
	bh=E0c8Fnxoyb8PyLO47mFjRzlj6k8w9AkITx81mqoCs08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unk98SRY/FtPZRYSNExNrQKx0rVNJ9FX/9PHSuMLRZeFmdETGYNyLQew7e5OJkAbb5QwpMI9lTHguTrkxtiZ3yMxAO+8eANdmWRP/xXm1DLEbLh5TaSVxdgW6h1ZgUrgsuKCKbokLeaWsDBsd19hdWB0AV8ucNsuuBbDFnk9WbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5OG3hRF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712256273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AVidyUENoKyCBCeWo6z9hwaMExylhCoJZ3s1Ah0DuWA=;
	b=X5OG3hRFnWaDhqzwJlizFvjVyoHKPHVIK5Xw6DK5GMxV8i+gqxPMatHgXpUDhPeG8BRaN3
	x4R2D7DumJ3pwsJoh+VZF0yA/0I/pq9zMMdZk8+/QtH4Rx94xpTS+Zc3b/zJlSvQ5rTk8+
	W+ViEC/4uHeT1llnARpma54Pcwl2RQc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-INxW43u3NK6_GvX_M5F1aQ-1; Thu, 04 Apr 2024 14:44:31 -0400
X-MC-Unique: INxW43u3NK6_GvX_M5F1aQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-416259a5fe5so6548535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 11:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712256270; x=1712861070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVidyUENoKyCBCeWo6z9hwaMExylhCoJZ3s1Ah0DuWA=;
        b=tR+BR0UjKP3q65TSovD0bHgTA9FCzuD22MJ+tH00TyA/CuwhMn6vlN5cnmirN6Euc1
         JcLMNgfOgssuJywWkmrwdEiGLESuj82wk4BU+Gq4O5KZaLhR5q/4xiq/UkBh98kK27An
         yvpyuwe2KVc0iEuc++EDQn2SWe9DWGV0GKQi48Eu7jkiV37ozt0a1h1B39JPIcwIQnm1
         amOgH+PRQQ2xmNGGuzXaIskE6GGeaSRgItYZMnwSLCu59I2yiuYV1DaVTMaMNo4Bh5+N
         Cm7TR9VrUSW2hn8WRWIJBkeWcUYKTnqHeW0+VaybK2G46gGEzBn0xXYUzNb+NA7iJZGe
         SIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEYLMGAvlu2u5OiajPPnYJTBM63ZVNhXVmG33BHSctL2QOnQPvnt06qkO2GrPJeeFFe0LY880rhczal4/Ua5+HeBz4904y/hrFsg2x
X-Gm-Message-State: AOJu0YzE+UwyJBq56hZn3j5PNhF8Jmt9IWk2Y7jkQdIQy+LZ4lToHdFg
	9pQEdCwSo2Kl6lk9D6BWqAQrF6gCZHuKmV9XO9Q4SP/Dhv3wtbanh/klMEqSlVWMKwBx0L6Mk05
	EHpwVNp1/bjhB1vGmOHejItkUpzEmsr/LEjwuKVXUvvSn0xIJWFvlos070Sm1ZA==
X-Received: by 2002:a05:600c:4f8d:b0:415:45e5:bfff with SMTP id n13-20020a05600c4f8d00b0041545e5bfffmr433386wmq.33.1712256270695;
        Thu, 04 Apr 2024 11:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeSLNVGzrfJLs9PkKSQlbcO5jXD+drxcMjZDnOyx+OGRaX5jEPqFP2oOF27q6yKZ007bZxbA==
X-Received: by 2002:a05:600c:4f8d:b0:415:45e5:bfff with SMTP id n13-20020a05600c4f8d00b0041545e5bfffmr433374wmq.33.1712256270292;
        Thu, 04 Apr 2024 11:44:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b0041624540918sm91050wms.9.2024.04.04.11.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:44:29 -0700 (PDT)
Message-ID: <21a03f92-f2ac-40fd-93b5-2b064b1d896b@redhat.com>
Date: Thu, 4 Apr 2024 20:44:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: add the missing
 folio_test_pmd_mappable() for THP split statistics
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <a5341defeef27c9ac7b85c97f030f93e4368bbc1.1711694852.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a5341defeef27c9ac7b85c97f030f93e4368bbc1.1711694852.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.03.24 07:59, Baolin Wang wrote:
> Now the mTHP can also be split or added into the deferred list, so add
> folio_test_pmd_mappable() validation for PMD mapped THP, to avoid confusion
> with PMD mapped THP related statistics.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/huge_memory.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1683de78c313..3ca9282a0dc9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3109,7 +3109,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   		i_mmap_unlock_read(mapping);
>   out:
>   	xas_destroy(&xas);
> -	count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
> +	if (folio_test_pmd_mappable(folio))
> +		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
>   	return ret;
>   }
>   
> @@ -3171,7 +3172,8 @@ void deferred_split_folio(struct folio *folio)
>   
>   	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>   	if (list_empty(&folio->_deferred_list)) {
> -		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +		if (folio_test_pmd_mappable(folio))
> +			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>   		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>   		ds_queue->split_queue_len++;
>   #ifdef CONFIG_MEMCG

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


