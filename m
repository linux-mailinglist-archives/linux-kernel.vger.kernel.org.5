Return-Path: <linux-kernel+bounces-132700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FA8998FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033D41F25A63
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC5515F3E0;
	Fri,  5 Apr 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHruDDk8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDAF145B31
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308020; cv=none; b=EX6jfbFbNGrwk4JEucgy94QKhgpJd/HDsBSHYljeOyU58TdGguscbWT/0vBUgzpOw84Ai4vWhiXUC0p0U5tw6CXZZeVh6Jk/v+hMymJ6vu3wabpNv/Em7k1riz+rV0xDYBVc6hc/jh0JrByCEjSevykvyltPWTnkEJmss0bZvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308020; c=relaxed/simple;
	bh=kAlys/9p/RCa+a21S5tq0RVGRqIPEuQQSepEFro2xNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ng1+oeU5AixBWddyvViBhED6LGp50BEJZi9GpsXwJaCrNNeivolevrIdO+CwEtjlUHhMfzjfnjvqsqDLdFPgtmPZIalQ6Eycex5LgR8iN1XnTciUOLzE1PwDy9d842+mwUft0P2CfvXEVc776/D4+HAmtzDS44JKJbZM7M/Nmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHruDDk8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712308017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0zRRYELJxrPHEgjDy1ctAUfjOu8XzSDkxN2W0uvQ3RM=;
	b=iHruDDk8vxyQ5n4x7DoOYufJK5abl3hjHLILyz1b4KtnN6UDzbBXdRO6a5jIsYHIrwbgne
	Ks3/mLSFzyUHI1s7KaQPEiOvBsFmt3ZJX/+nJ5lpZbZCgGkmi3KKe42W9G3TIgucyv3IOY
	xu6TFxEUhuj8cjOtAvOZ275qWHYWlMU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-zoEczeoQMCOFIKIAcwpz5w-1; Fri, 05 Apr 2024 05:06:56 -0400
X-MC-Unique: zoEczeoQMCOFIKIAcwpz5w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516c8697daaso1507654e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308014; x=1712912814;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zRRYELJxrPHEgjDy1ctAUfjOu8XzSDkxN2W0uvQ3RM=;
        b=mfznwBGZZX4M1FKq8QQJOqqxiTGYgDb+q58+/c5oll4xfp7swzII4nbE6UVOHhK7/R
         KXtIeLJ6LMWAg1pzOvEU67whYDQLbQckKE89ciHRPO9yHxyEVmf+QaQhkhvuOrAv+M3Q
         yk3gEZwJdUK/jnzKjMPrdvrrQe7c6yGtZHsblDzJnVY08d48bldBGa6hMxht9zwXodVB
         xM1r2Ca4seGs3NZhdOxqtUa0F/8KBxFr0fV7EKK4ryb6FgsGbidzLJ9DbzjPNXlJKrqF
         /UB7GNoct8G+aaWSyDJZ0u8ttnQ7VAFFgtML2GNQfax12bFdkR/+viaVLp+LFqo7I7KU
         wthw==
X-Forwarded-Encrypted: i=1; AJvYcCUai59Ryhe0eBhi/KdbTYsMsI38oaHgMRNbUdD1EOhlpE0rnSsUKpTzZCqMQrUroXgi5/juF/eKNgKwiN0aaBa/w+R3HQ56mLAWK5az
X-Gm-Message-State: AOJu0YxUV2DNUwTFTElehkXTt0j/KovrTAINyHYhceCE17LhEnWuSVW9
	RtvEeyLyK7OGqIQYEChGdluZw2j4fVjWu+MVhsgFNfz4bgUMHQzTp/FOgF+F5c+Nt1mxiPDVB4/
	MuslxHD8aObOHjuSWvjP49639Lh3q9ABOXAr5KIkXpUeA0/yfbYE4hO0tENDhVQ==
X-Received: by 2002:a05:6512:475:b0:516:c1b9:22e9 with SMTP id x21-20020a056512047500b00516c1b922e9mr644980lfd.17.1712308014673;
        Fri, 05 Apr 2024 02:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCQQbRCXessb7cmeerSHS4NLFh+aADVdDXL1rcQvtLSb51fucsBMtlYCwXl0HJTyrCJic3HQ==
X-Received: by 2002:a05:6512:475:b0:516:c1b9:22e9 with SMTP id x21-20020a056512047500b00516c1b922e9mr644959lfd.17.1712308014201;
        Fri, 05 Apr 2024 02:06:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1? (p200300cbc74b5500e1f8a3108fa34ec1.dip0.t-ipconnect.de. [2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d5502000000b0033e786abf84sm1519965wrv.54.2024.04.05.02.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:06:53 -0700 (PDT)
Message-ID: <a8d30fa4-2381-40a8-9a22-63dfcf5054d5@redhat.com>
Date: Fri, 5 Apr 2024 11:06:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] mm/ksm: use folio_set_stable_node in
 try_to_merge_one_page
To: alexs@kernel.org, Matthew Wilcox <willy@infradead.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryncsn@gmail.com
Cc: Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>
References: <20240325124904.398913-1-alexs@kernel.org>
 <20240325124904.398913-14-alexs@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240325124904.398913-14-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.24 13:49, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> Only single page could be reached where we set stable node after write
> protect, so use folio converted func to replace page's.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> ---
>   mm/ksm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 15a78a9bab59..d7c4cc4a0cc1 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1518,7 +1518,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
>   			 * PageAnon+anon_vma to PageKsm+NULL stable_node:
>   			 * stable_tree_insert() will update stable_node.
>   			 */
> -			set_page_stable_node(page, NULL);
> +			folio_set_stable_node(page_folio(page), NULL);
>   			mark_page_accessed(page);
>   			/*
>   			 * Page reclaim just frees a clean page with no dirty

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


