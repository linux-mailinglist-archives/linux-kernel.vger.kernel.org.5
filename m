Return-Path: <linux-kernel+bounces-132030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97999898EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07096B27FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30B134407;
	Thu,  4 Apr 2024 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYLKII2/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C112883A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258798; cv=none; b=ZF4v3MbO/T2RYgfLEhQW3jbB2DAMRAC7dYwXBnbRe6MDenmlM3yqh513cOod0w5sXchqIQLTHnoyx9S6zjLB+0hro/TQ9xyIeMzzmVYVPoe5Xnghtdi345u54kKxPYDvuOFKrc9iDRnxtp2JV6w3Iq/LYbv+m0NcEiHYGpAHWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258798; c=relaxed/simple;
	bh=9flUdVUxSEnBDjHOOL1+QzoLfSCshZaqhr6KL5SXL6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npRBvU23DakfX6bWxCb+87Vec74xpnNi0u57Ekz9EDE6RoJ2q4KBL5djMucmNZCdoH4SxeNxY0zgG3n2x8pMPiEhGB2Uduo+xiN4QKDF02tOMX1vzn/U+RiiK7UvjTJzgYqN6cVrklgCTXU+kdgWz0SFt+1DNwg6v/72b80raoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYLKII2/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712258794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UHxvd784HXmQbjhASureduXPz+XMFq4R6fbqRO4lKCc=;
	b=KYLKII2/O4krHkK7ZwLnGpdthUWh79OicT1SByHE5ENfGCLczWFcehld2zVCuB6/A0pyhp
	GmREFxfNTbmps0QcxanXgx9UJEJuQXLLsMghYEuxHe2VXWNqruaS9ObEyIW0Mth1TMMdCo
	SL2lZ+RDKXHwfsDdFtWy+eFqf5soFV4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-gQZDb_MqPoC2KMhLXOZZow-1; Thu, 04 Apr 2024 15:26:31 -0400
X-MC-Unique: gQZDb_MqPoC2KMhLXOZZow-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343da0a889dso127600f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258790; x=1712863590;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHxvd784HXmQbjhASureduXPz+XMFq4R6fbqRO4lKCc=;
        b=Z9DtYdVEpT4xG0djtX3awMwOMk93s8/w9COCekFiK4l3bKv1t6jkdsdT6MUS/5rpvI
         kE4xePOCpOvCCSpWPXOAj4s/hD/H5pwhCJq8uRsXP4I+RWnGTFf5pLt5wXKWRXvK93w8
         XE3y6Va97Y6foIAqtzlOzU8WdCL1GnPnNs8eoy5g3caRLoZoMSo9NAszUaiw4+5zgXt1
         N74NetZPrbaliLdhTWb0G6VpMiTn4YlinrxB/E5OJ9LtIe/ubp+iC6X4RgwBkado058X
         iNy6fOHpxowd/k++I5Gatd69EIGuuO8vGpYygjulskwg6FbDu+e9Xxlj7owcdY7EvCUN
         C3SA==
X-Forwarded-Encrypted: i=1; AJvYcCWV2Vk19F6RGX9pN6DPZhC8ZhoOdXfGpqDRVHzXz/RW4Vj35KWDSCksj5dPH1q4w47t/1Z1AEc1LmoC+JLop2Th84y03U3JP51Lbbw0
X-Gm-Message-State: AOJu0Yxqk/Ryw3Ucq2YX5WEWs8w7nkzzVDWd4wtIV+zf66iTdyr6Jbsa
	KHbZCyhE/eIIFxpc1tJ+vPk6wZ1nQboqTQ790RXArVxWEe+wamkWQwOm+//6KfGzfuF06R8Pv2H
	pSLcomUwnJhjnxRtJHWz2Qug5SBP2GJEGrhTomC1Sq9HJVq9iri64rqgTX+PI1g==
X-Received: by 2002:adf:f104:0:b0:343:a183:4218 with SMTP id r4-20020adff104000000b00343a1834218mr396426wro.52.1712258790691;
        Thu, 04 Apr 2024 12:26:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcHupj7o3LGtozIFqvIETqqaFEhhYJDZRlENZAoibjYVyO1cCFUBJr0gS5/EwZRPOuy4uJCA==
X-Received: by 2002:adf:f104:0:b0:343:a183:4218 with SMTP id r4-20020adff104000000b00343a1834218mr396413wro.52.1712258790305;
        Thu, 04 Apr 2024 12:26:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d4084000000b003433bf6651dsm114241wrp.75.2024.04.04.12.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:26:29 -0700 (PDT)
Message-ID: <6442a40b-be04-49e8-9390-8742c82db3dd@redhat.com>
Date: Thu, 4 Apr 2024 21:26:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/page-flags: make PageMappingFlags return bool
To: Hao Ge <gehao@kylinos.cn>, akpm@linux-foundation.org
Cc: willy@infradead.org, gehao618@163.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240307131304.169859-1-gehao@kylinos.cn>
 <20240321030712.80618-1-gehao@kylinos.cn>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240321030712.80618-1-gehao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.24 04:07, Hao Ge wrote:
> make PageMappingFlags return bool like folio_mapping_flags
> 
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> 
> ---
> v2: Send this patch on the latest version
> ---
>   include/linux/page-flags.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 652d77805e99..5ee2d0ab62c6 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -668,7 +668,7 @@ static __always_inline bool folio_mapping_flags(const struct folio *folio)
>   	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
>   }
>   
> -static __always_inline int PageMappingFlags(const struct page *page)
> +static __always_inline bool PageMappingFlags(const struct page *page)
>   {
>   	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


