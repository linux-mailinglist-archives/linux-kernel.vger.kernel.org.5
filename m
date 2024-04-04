Return-Path: <linux-kernel+bounces-132037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18774898F02
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C393290E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCAC134725;
	Thu,  4 Apr 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOt8+waX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250B13AA59
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258817; cv=none; b=QDwl1fae67/cdyhwXoI1aDzYCyyGT8rLJiNaDO6uFk3TJzoJT5tQnSOx84JqPgYX4yRxuXF16MawRjGXyGRKJRMDUZSef4JKnB6Pbb6MO/k6+w+0pujk287WJuliHuDxddA/swlawUdUh8mDwNMBJT9IatqeDxHe83pGT8jliXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258817; c=relaxed/simple;
	bh=k7DvO3yX+4yZydpB+KOug1kvnEHjVjTsQu7BhKin90Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtY4fUMy1Dn57I4wPtAzgSxRjIy1xKj4xugT7bT/tqX4cLr2739+G/id4/FDCebaCUaMwO2Lt+23ONW3FW7bmx1YX8PlNmJMdjij5mGhIJuIoK/HogSqh1OePNP73SaMMl15JMW+6EyVic1vkkd0nT4U1oqsI7G3h4wVIP1KJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOt8+waX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712258814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sb5lQwQrBzQB3suXYcpgoYlyn9AOg84ixLAWhX1x3kU=;
	b=KOt8+waXMWyO9j3lgGOPBvnFfOsejkbezIq2LK5dNaIOrhRN8PRytqv4RJ6CksSzYCail+
	WEXbSe33im44f9eVJAD9WqBuhm0Kwcud5mnGWWb4871WnkgFZil/venMb7LIo6ssUGX1WS
	pYZRrhyMl5cWdlDLFM2+pSpen7fOrjM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-aW0F_bJZMtS6Tcw6eRZlAQ-1; Thu, 04 Apr 2024 15:26:53 -0400
X-MC-Unique: aW0F_bJZMtS6Tcw6eRZlAQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343bb240f70so506690f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258812; x=1712863612;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb5lQwQrBzQB3suXYcpgoYlyn9AOg84ixLAWhX1x3kU=;
        b=cLcd8HEDcBK6CG60bVjmNgEqxIK/M6W5ylVBRFc8PJ1oGGTE69qT9NNOCPZBLSbDi7
         PugTbo0Wiz1tzQwfRuqy7i5hEuUJUX9LXmOvO4I9lQRdcxPrn9TN0N1nHWsmPQDxxg1Y
         2VeslrAn78N3UCNCO61JeeM02QTOpv+zR4K/AggD1ze/t0MTcSwfJ5ApCa5mrLqCnrOe
         e8gC5z71WgshajY9sVRQtPeqTeLipHT3tl/8fFakNWgaL5S28mZLsR/AnExkHyJ4bjPu
         oXTI1OX29BLSYloY1e8Wo//VNcGwNMRi5Gh9UyU49wmrLo9o2xcjibP3tsX7WP6b7CBP
         58tg==
X-Forwarded-Encrypted: i=1; AJvYcCW1vnaYoIl1vzfZaLfxZZ7B4U/+hRNRWgw/DMax3dMNq12It8/sj3oDmEEwC88xlaAA0ypl6T6uBjYQhrjw2KloKnvDoetCWK9phoU0
X-Gm-Message-State: AOJu0Yy145V8Mj4G6JQtlnCb1jhmfwkbBikizXBw2QO8iCtNVCkeUzEc
	wK820aXac2hMp2P/AbeMoaEbUa2g12AdZjmgpMLnptAAmtkPcLgy1nQ3K8zXaSK0IBjPjzT8Tl7
	u9SCe8rl2+SRm33SpPz02Z3yawQ+ppF9MEJ+ZTNSrEOA5R8JgUu3kLdha3JaW7g==
X-Received: by 2002:adf:e742:0:b0:341:b5ca:9e9c with SMTP id c2-20020adfe742000000b00341b5ca9e9cmr283233wrn.25.1712258812007;
        Thu, 04 Apr 2024 12:26:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn7UVbFvz2b3ppRJhM31xuwbjmCcoVg0zOdEA34ppMUP1TMyfIolZNomA4TZw93AFSLnS5yw==
X-Received: by 2002:adf:e742:0:b0:341:b5ca:9e9c with SMTP id c2-20020adfe742000000b00341b5ca9e9cmr283222wrn.25.1712258811662;
        Thu, 04 Apr 2024 12:26:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id s26-20020adfa29a000000b00341b9737fc5sm113331wra.96.2024.04.04.12.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:26:51 -0700 (PDT)
Message-ID: <0fc5f2ea-af19-4ac6-a32a-efd607800b0a@redhat.com>
Date: Thu, 4 Apr 2024 21:26:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/page-flags: make __PageMovable return bool
To: Hao Ge <gehao@kylinos.cn>, akpm@linux-foundation.org, willy@infradead.org
Cc: gehao618@163.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240307132859.171048-1-gehao@kylinos.cn>
 <20240321032256.82063-1-gehao@kylinos.cn>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240321032256.82063-1-gehao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.24 04:22, Hao Ge wrote:
> make __PageMovable return bool like __folio_test_movable
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
> index 5ee2d0ab62c6..2647c7a35c5a 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -689,7 +689,7 @@ static __always_inline bool __folio_test_movable(const struct folio *folio)
>   			PAGE_MAPPING_MOVABLE;
>   }
>   
> -static __always_inline int __PageMovable(const struct page *page)
> +static __always_inline bool __PageMovable(const struct page *page)
>   {
>   	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
>   				PAGE_MAPPING_MOVABLE;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


