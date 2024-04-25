Return-Path: <linux-kernel+bounces-158779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A07A8B24D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E49328CEB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677914AD02;
	Thu, 25 Apr 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sl7NnEa9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4FC3BBE5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058116; cv=none; b=MzPzy/JLGhrzdmjwtYt+8f7PU4x8sBA6+32kQgXhSg+eK/iwkQZU83cBYT1eiUlL9TJhD/8BGD1stajap4RxUvuNhiYJpzCn4oFr7UtnkVmt9OXiKHI8AQ0EHqdQIDUFFFBNP4IG0m4o8DRwF7pG8/8QQGlHiGniPyuwc96OX2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058116; c=relaxed/simple;
	bh=8hkYuQ3Ev1OGu52o1t7BbFC08GB26tsHjUpWZy4dn4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkqWS9QsxBAUjAliHxyCcLXSufnT658LDdCo6L7hXymvIBYjovk65c0FzW6sHAYJ6yr1L7Wm+S6ldB6I1ND1gB4E7+Xi+hfcO7tKBlSaRj55pVdNoCdXzUkjDPo7Ml5NUJMqffhHi3m3N9KX9Xh2MhoUpYICuKYNDEm3CCIPMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sl7NnEa9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714058113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WKYp4wzzNixm3T/VbKRymtX4GblCaiqZAAtfiT4bJSQ=;
	b=Sl7NnEa96LGtoa8YoSN8d5r9U68L6atYkMDTCI2kv+XLMM9erEp5cci9Z8Ynizao9xJBTL
	rkQdFXeDbmCIOIjfRreFRt8cuAGykp02CUIdRiSVlTxwSD1FHKe1r6xFoMXLar0IiDRlPU
	5wsr6e87IjqTmmPk+Bly2pXYBEOCA+A=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-zbyDD3neMe2FzFSwPOpK8g-1; Thu, 25 Apr 2024 11:15:12 -0400
X-MC-Unique: zbyDD3neMe2FzFSwPOpK8g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51c7abe8da8so308294e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714058111; x=1714662911;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WKYp4wzzNixm3T/VbKRymtX4GblCaiqZAAtfiT4bJSQ=;
        b=clkPEDLsKFGcNqyTfTlazLZakex3byTRhJhGtxKPFguTEK3VfDfDDplo5tvDpBpi2O
         jHAlpUoyhrMQkabrdo1nXEU8R7NbcwnZmhnyJaY/G1N0Brs40ngP6YNIJbdQEOZW4OaP
         PUPg1t1X6uGvq46acf4YQrw9J/x5akoKHK1JueynE4ZlQs9ynIP79lFfWeFDTJ8uJHl3
         9R5truX+RUW9VEloZ867KvfkbxIG/YfyCcYzK23M6+w0H55s4kdTpDvaVWKPtBxzuWgh
         qYyB3vkMwuhlkshvCQ95ZVCEKfcQqifxKL6dD5fltuoUXamvOfvHfHb+56zpD6cmoCgY
         iNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUo5aFdaR9LBJDRaTCxVFxKpJC9Fd5x7lTpwnlcmwgKCZG//UpK8wPsJYtf/t6uFmK0PIi4UBzROIzHA7bCIqgOBnIhKwR570XLPs+
X-Gm-Message-State: AOJu0Yz7WDCGhP0/BG+t8e0E224BwIgG842yT5fNOZXmbFapm005bYIZ
	j2z7uLsHYrXUllJXcCXWE8C4/1hHZuJ2gGfs9yIIJPZ1wFdALXR0FOBSrZ2SV6vj547iaUShY6C
	CK8NrNdfBo4HVLlKn++sqI2k2ZMELCEyZjSnRr9jASsnNZls7AxY8FyupXwJ64A==
X-Received: by 2002:a05:6512:34d8:b0:51b:e46c:19fd with SMTP id w24-20020a05651234d800b0051be46c19fdmr3679510lfr.18.1714058110943;
        Thu, 25 Apr 2024 08:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAjWcKZVSE52xsLzyJs0BC22b+AHCTBkoiVrCRR0JY8iqWa3ktVq29t8RuI2BqSxZgEK0f4g==
X-Received: by 2002:a05:6512:34d8:b0:51b:e46c:19fd with SMTP id w24-20020a05651234d800b0051be46c19fdmr3679490lfr.18.1714058110500;
        Thu, 25 Apr 2024 08:15:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id f12-20020a0565123b0c00b0051b65645256sm1221549lfv.265.2024.04.25.08.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 08:15:09 -0700 (PDT)
Message-ID: <e1e3d368-4861-470f-b7ca-b222712adef5@redhat.com>
Date: Thu, 25 Apr 2024 17:15:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240424224614.477221-1-zi.yan@sent.com>
 <a5426fa6-442a-453f-a234-63d89675ea79@redhat.com>
 <8BBD1B75-135D-42AA-8937-53B259803AA7@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8BBD1B75-135D-42AA-8937-53B259803AA7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 16:53, Zi Yan wrote:
> On 25 Apr 2024, at 3:19, David Hildenbrand wrote:
> 
>> On 25.04.24 00:46, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> In __folio_remove_rmap(), a large folio is added to deferred split list
>>> if any page in a folio loses its final mapping. It is possible that
>>> the folio is unmapped fully, but it is unnecessary to add the folio
>>> to deferred split list at all. Fix it by checking folio->_nr_pages_mapped
>>> before adding a folio to deferred split list. If the folio is already
>>> on the deferred split list, it will be skipped. This issue applies to
>>> both PTE-mapped THP and mTHP.
>>>
>>> Commit 98046944a159 ("mm: huge_memory: add the missing
>>> folio_test_pmd_mappable() for THP split statistics") tried to exclude
>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
>>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
>>
>> Once again: your patch won't fix it either.
>>
>>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
>>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
>>> However, this miscount was present even earlier due to implementation,
>>> since PTEs are unmapped individually and first PTE unmapping adds the THP
>>> into the deferred split list.
>>
>> It will still be present. Just less frequently.
> 
> OK. Let me reread the email exchanges between you and Yang and clarify
> the details in the commit log.

Likely something like:

--
In __folio_remove_rmap(), a large folio is added to deferred split list
if any page in a folio loses its final mapping. But, it is possible that
the folio is now fully unmapped and adding it to the deferred split list 
is unnecessary.

For PMD-mapped THPs, that was not really an issue, because removing the 
last PMD mapping in the absence of PTE mappings would not have added the 
folio to the deferred split queue.

However, for PTE-mapped THPs, which are now more prominent due to mTHP, 
we will always end up adding them to the deferred split queue.

One side effect of this is that we will frequently increase the 
THP_DEFERRED_SPLIT_PAGE stat for PTE-mapped THP, making it look like we 
frequently get many partially mapped folios -- although we are simply
unmapping the whole thing stepwise.

Core-mm will now try batch-unmapping consecutive PTEs of PTE-mapped THPs 
where possible. If we're lucky, we unmap the whole thing in one go and 
can avoid adding the folio to the deferred split queue, reducing the 
THP_DEFERRED_SPLIT_PAGE noise.

But there will still be noise when we cannot batch-unmap a complete 
PTE-mapped folio in one go -- or where this type of batching is not 
implemented yet.
--

Feel free to reuse what you consider reasonable.

-- 
Cheers,

David / dhildenb


