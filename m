Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D82E8055B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376886AbjLENRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjLENRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:17:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBCD98
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701782262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=AEabezFAeRUlJqiDqA536XXl+PtFBSDNun6/yQSCqkc=;
        b=e85AsP7jr2Dqlgl+NFt2CB9wzwy60wZOY+cdtjV+6g27ILHtHeD/ZiJhdGcyL8IqBoJeMl
        CawN9Hcm45JHL8kfwRcyVQE7LMPjMF6XQvz8OUxEtBwkEQB5eG84PZ3P+cOcJvEA0Z4Skw
        onjh13qtAahxg9URW+Dgg1hOtoElIeU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-CoZ-rKzmPSue5hdHUP6Edw-1; Tue, 05 Dec 2023 08:17:41 -0500
X-MC-Unique: CoZ-rKzmPSue5hdHUP6Edw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b3519a03aso48724095e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701782260; x=1702387060;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEabezFAeRUlJqiDqA536XXl+PtFBSDNun6/yQSCqkc=;
        b=QYPrU+fBRlnSLr5KOj7ojRp5kCAO7FpchyfHNWFA+eakiOGPS12f+pPHGGnZRIVlpd
         38weJk4mAYFlR0I5wPsHR/QOVAZgJYfC7YMXwjAIllgT7Eer4qQwcuScXT22IVygiJuO
         LSvTQU1+kybTaje1M1AEVz3BmUNc1BRgL39htRTN+SDgbANXrEWB09SNYCN4/P3RwDzh
         BabXUa5+r+efWjGVXYT9FlIVrsngWOqTLJw3CIFlXIXgDEveFbPfHwVugRo72xJ3IBU4
         cOXMLpnhbC+b+UI9mUPSbMVHQzntVH6xxH2xvsqJVh+uZCaFnJdA6O4jDoWDrEe26NxV
         MObg==
X-Gm-Message-State: AOJu0YxKRsmnh+E4VRyN+jABdqePr11qyCjxPjhOsdAewtesUkgtBlNM
        aa4q1D4mGEBFGDgndjRbiMAFe+6ylo8u6+JBmaXtzuuYA/NQ9Qb14n0AVxLk63dAGYTb7IwGxjh
        w460z2rn/TFVONOCFVBbMKKRF
X-Received: by 2002:a05:600c:5025:b0:40b:5e59:ccc9 with SMTP id n37-20020a05600c502500b0040b5e59ccc9mr459696wmr.170.1701782260373;
        Tue, 05 Dec 2023 05:17:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqXTiSZwJGf+chnZRKrXywMEqMr38XDDTAN30gqgzBR0iitcqxUQ4vh8wcegxLQljEFvhAIg==
X-Received: by 2002:a05:600c:5025:b0:40b:5e59:ccc9 with SMTP id n37-20020a05600c502500b0040b5e59ccc9mr459686wmr.170.1701782259946;
        Tue, 05 Dec 2023 05:17:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id jg23-20020a05600ca01700b0040b30be6244sm18663406wmb.24.2023.12.05.05.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:17:39 -0800 (PST)
Message-ID: <88a341bf-0b6a-454a-aeb1-0699233eb37c@redhat.com>
Date:   Tue, 5 Dec 2023 14:17:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 34/39] mm/rmap: introduce
 folio_try_dup_anon_rmap_[pte|ptes|pmd]()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-35-david@redhat.com>
 <b7ef017b-f651-40f3-a2bd-70ebe9411dc1@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b7ef017b-f651-40f3-a2bd-70ebe9411dc1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.23 14:12, Ryan Roberts wrote:
> On 04/12/2023 14:21, David Hildenbrand wrote:
>> The last user of page_needs_cow_for_dma() and __page_dup_rmap() are gone,
>> remove them.
>>
>> Add folio_try_dup_anon_rmap_ptes() right away, we want to perform rmap
>> baching during fork() soon.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/mm.h   |   6 --
>>   include/linux/rmap.h | 145 +++++++++++++++++++++++++++++--------------
>>   2 files changed, 100 insertions(+), 51 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 24c1c7c5a99c0..f7565b35ae931 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1964,12 +1964,6 @@ static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
>>   	return folio_maybe_dma_pinned(folio);
>>   }
>>   
>> -static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>> -					  struct page *page)
>> -{
>> -	return folio_needs_cow_for_dma(vma, page_folio(page));
>> -}
>> -
>>   /**
>>    * is_zero_page - Query if a page is a zero page
>>    * @page: The page to query
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 21d72cc602adc..84439f7720c62 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -354,68 +354,123 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
>>   #endif
>>   }
>>   
>> -static inline void __page_dup_rmap(struct page *page, bool compound)
>> +static inline int __folio_try_dup_anon_rmap(struct folio *folio,
> 
> __always_inline?

Yes.

> 
>> +		struct page *page, unsigned int nr_pages,
>> +		struct vm_area_struct *src_vma, enum rmap_mode mode)
>>   {
>> -	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
>> +	int i;
>>   
>> -	if (compound) {
>> -		struct folio *folio = (struct folio *)page;
>> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>>   
>> -		VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>> -		atomic_inc(&folio->_entire_mapcount);
>> -	} else {
>> -		atomic_inc(&page->_mapcount);
>> +	/*
>> +	 * No need to check+clear for already shared PTEs/PMDs of the folio.
>> +	 * This includes PTE mappings of (order-0) KSM folios.
>> +	 */
>> +	if (likely(mode == RMAP_MODE_PTE)) {
> 
> Presumbly if __always_inline then the compiler will remove this if/else and just
> keep the part indicated by mode? In which case "likely" is pretty useless? Same
> for all similar sites in the other patches.

Yes, also had this in mind. As long as we use __always_inline it 
shouldn't ever matter.

> 
>> +		for (i = 0; i < nr_pages; i++) {
>> +			if (PageAnonExclusive(page + i))
>> +				goto clear;
>> +		}
>> +	} else if (mode == RMAP_MODE_PMD) {
>> +		if (PageAnonExclusive(page))
>> +			goto clear;
>>   	}
>> +	goto dup;
>> +
>> +clear:
>> +	/*
>> +	 * If this folio may have been pinned by the parent process,
>> +	 * don't allow to duplicate the mappings but instead require to e.g.,
>> +	 * copy the subpage immediately for the child so that we'll always
>> +	 * guarantee the pinned folio won't be randomly replaced in the
>> +	 * future on write faults.
>> +	 */
>> +	if (likely(!folio_is_device_private(folio) &&
>> +	    unlikely(folio_needs_cow_for_dma(src_vma, folio))))
>> +		return -EBUSY;
>> +
>> +	if (likely(mode == RMAP_MODE_PTE)) {
>> +		for (i = 0; i < nr_pages; i++)
> 
> Do you really need to reset i=0 here? You have already checked that lower pages
> are shared in the above loop, so can't you just start from the first exclusive
> page here?

It's best to check the updated patch I sent.

-- 
Cheers,

David / dhildenb

