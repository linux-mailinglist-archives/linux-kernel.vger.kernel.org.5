Return-Path: <linux-kernel+bounces-158116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A448B1BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFFE1F25159
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928B6CDAC;
	Thu, 25 Apr 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXvCXJMU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D8134A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029675; cv=none; b=S9OJT4sz2m4k+M2YL+gqZ/kmYwT5RR1wBgkiONpfInUZP0V3OOpHxKsUA/LV2D94vnLyhYFYTOyMfbqKL+JDAPRVFviewr9uRHtcptVjTPBm8oXs1jd+imavffdugf6ShfBh+7aBK7umw5gZ9EBmcbOLhB28W224GJK8Xuc0kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029675; c=relaxed/simple;
	bh=mqq2S/dRtMAibaL7yltQ9mudkL6EfBBg5ubNFQu2MJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqTFXK6mHJ3ZLoc5a/dpQACXKoe8yCB2mro/ETDCD/4JnK2P9g6kay21k7cKA0iYxDwBDhnVJRZnSzuTz5cbsLpaU6j6mX2CKzuUHOde3JX4GQDlQhCbAW8LqlYVtc8iyaPDMzHc8ci8E1YYUXXFhbLjOAJI3sghIFSOCgCA4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXvCXJMU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714029672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KIsAK2JTSKo1imZEGDIjeMZs4Wbxa5IE7a74wR8FL1A=;
	b=cXvCXJMU+xSdpPf5g3pN1tgJU1kOmbckF7OxzmLbv8zK+V2QhccUmO1iFeUj4kp/4llQlm
	3hof7aBCFZj1PUefnHNlzNrbYmIW4yE6GRkYSeh6apSDLFscfCLncjcG2SL0TaY5tkbrWj
	hrQe/MSVwFPWctN4L7gyqCgkPIx6c1M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-XCIJpQuOP9OLKV59e8zJKA-1; Thu, 25 Apr 2024 03:21:10 -0400
X-MC-Unique: XCIJpQuOP9OLKV59e8zJKA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41b37ce2160so2910205e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714029670; x=1714634470;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIsAK2JTSKo1imZEGDIjeMZs4Wbxa5IE7a74wR8FL1A=;
        b=eqpWlg9bptjCYa+0QO7Pu3kUqyk4d2GXgA3t+Iz7sgKlmyU2j9DhFCYF30endP7j1s
         lzsa2VbAt/kZ563DD9Hib152hCTNsrmZIW6HrLAqSTuF1hGWV0P4hnZSHDilMEsD9iFo
         6xSAFoGtG+SrCG54uhhlELKZy2RQCaqpziGbhmSOrnzfaZlmrQx7NMY4NmFshA5gQQtE
         d7dNyXhtTcJaYPpBfpgq5/C3oOR9HTdDrfwqIRPSezGd41sBIQJ4YDOgjgffGxSvSPKo
         VdH+LdURLOLSdTyJ8XHAzggvmEUcQsIDpPLUFOcQ7V9acM7tnYACKq8gHsrxp5MKaJIl
         bhdw==
X-Forwarded-Encrypted: i=1; AJvYcCUa0PPfQlwK/b5F+5+c/bkUY0LL0uIEgyC40D9UnP06cRNSzMzfDRTTPzyugRPnmBfcyqsqUDB3eUOhgyAfNtYKV9v0Li1ft1Hzhl58
X-Gm-Message-State: AOJu0YzOLO+WCy6y3EZ3KXlg54LnwAeQdU62P1uuFxJCpqZA3jDtOALV
	lv8/DaKsxwVT6bE/mXcGXetsiUNkhJE3HtmmC7API7GT5ufA6DRiU3lV36+lvyL2bcMkCPftUBg
	GQKb3/Rl8X0U2SRVZs1YkzRLvcd/0uedJtJKXHUaU1HtwyAWSbv1m9NyG/bDD7Q==
X-Received: by 2002:a05:600c:1c15:b0:418:f760:abfb with SMTP id j21-20020a05600c1c1500b00418f760abfbmr3270844wms.5.1714029669717;
        Thu, 25 Apr 2024 00:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmn6Y7s8jVRTPNzCFh7lkRI/K/Tv8PM/kqBiBJp84ZmcgiZe//y4udRRHv5Ih7Fg6bGYDNcA==
X-Received: by 2002:a05:600c:1c15:b0:418:f760:abfb with SMTP id j21-20020a05600c1c1500b00418f760abfbmr3270826wms.5.1714029669316;
        Thu, 25 Apr 2024 00:21:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b00418f72d9027sm24262026wmq.18.2024.04.25.00.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 00:21:08 -0700 (PDT)
Message-ID: <5e6bf4c6-c4a5-4be3-b203-ecc77ba4e5d9@redhat.com>
Date: Thu, 25 Apr 2024 09:21:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Lance Yang <ioworker0@gmail.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20240424224614.477221-1-zi.yan@sent.com>
 <CAK1f24mHG+CZL38CAp++9urMkciWqd0wAgyFi+QjfCTAVk3Rew@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24mHG+CZL38CAp++9urMkciWqd0wAgyFi+QjfCTAVk3Rew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.04.24 05:45, Lance Yang wrote:
> Hey Zi,
> 
> On Thu, Apr 25, 2024 at 6:46 AM Zi Yan <zi.yan@sent.com> wrote:
>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In __folio_remove_rmap(), a large folio is added to deferred split list
>> if any page in a folio loses its final mapping. It is possible that
>> the folio is unmapped fully, but it is unnecessary to add the folio
> 
> Agreed. If a folio is fully unmapped, then that's unnecessary to add
> to the deferred split list.
> 
>> to deferred split list at all. Fix it by checking folio->_nr_pages_mapped
>> before adding a folio to deferred split list. If the folio is already
>> on the deferred split list, it will be skipped. This issue applies to
>> both PTE-mapped THP and mTHP.
>>
>> Commit 98046944a159 ("mm: huge_memory: add the missing
>> folio_test_pmd_mappable() for THP split statistics") tried to exclude
>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
>> However, this miscount was present even earlier due to implementation,
>> since PTEs are unmapped individually and first PTE unmapping adds the THP
>> into the deferred split list.
>>
>> With commit b06dc281aa99 ("mm/rmap: introduce
>> folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-mapped
>> folios in one shot without causing the miscount, hence this patch.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> ---
>>   mm/rmap.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index a7913a454028..2809348add7b 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1553,9 +1553,10 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>                   * page of the folio is unmapped and at least one page
>>                   * is still mapped.
>>                   */
>> -               if (folio_test_large(folio) && folio_test_anon(folio))
>> -                       if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
>> -                               deferred_split_folio(folio);
>> +               if (folio_test_large(folio) && folio_test_anon(folio) &&
>> +                   ((level == RMAP_LEVEL_PTE && atomic_read(mapped)) ||
>> +                    (level == RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
> 
> Perhaps we only need to check the mapcount?
> 
> IIUC, if a large folio that was PMD/PTE mapped is fully unmapped here,
> then folio_mapcount() will return 0.

See discussion on v1. folio_large_mapcount() would achieve the same 
without another folio_test_large() check, but in the context of this 
patch it doesn't really matter.

-- 
Cheers,

David / dhildenb


