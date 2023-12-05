Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE38055FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442193AbjLENci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbjLENch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:32:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7115818C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701783162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ZlWEYQXKg81nONkiYpPbgG9RelSWsxKHpc2b5kqkVXg=;
        b=AEk5xIoJ6ZuCqhggxnbU54EdPr/t/QmJY5qPwY9VOF5cnwAcWSPdFPsU/WKy1tdz2KAmiL
        jxf6CuEJhfiEowIKRAurT3tpSIWqInoB79Osmiv3uFppyvIqMRbyLGs5UYUOMu4XPJBrdT
        OcwCLpm5eYPOUJTT3JCrcDAx1CofEZs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-tvieVVwAMjeQJa7G672qvw-1; Tue, 05 Dec 2023 08:32:09 -0500
X-MC-Unique: tvieVVwAMjeQJa7G672qvw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b40234bd5so39134485e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701783128; x=1702387928;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZlWEYQXKg81nONkiYpPbgG9RelSWsxKHpc2b5kqkVXg=;
        b=K65Y26K+x9aCRkXSphtaIhDR3GWpbPkFox1ebCeNqME1t+Jsyic+qDq4QOiJSXVmjF
         ytUct2Wz3tlSVjP0kZ37fILXAr9V6jC4L2q9XMaIu+oenkfE+CQZJ3BwcHnnb/d8VjSw
         KTgnsohhZlrCVBWgzhTY7Of0zosVOq/O9AVTnEfbxeb1HtRPFtFvxl7qNIV89MHQePfH
         aiXMu9jE4x0y4mmprcefCgd9pr6P2dhzpjVZSbyTueHe3EiPiLsr80pX8i4svsQsEsnX
         lABTtKMC8XJ3L5DFZ3By7rt7tW6F7KAU1kqpuoVHpYsgyD5kNka9i8h3q6BRinwxqJL+
         zRlA==
X-Gm-Message-State: AOJu0YxJUroy/MqKvKlo5hKbITMDHfgD9gG4O6VeMS73bGErBzcbGbzJ
        KuqP7T9PwinU+BwRiIBzVT15ggB1LaKhBnYplSdyLi7zzyI0WBc+fqg3NVxTNT4uUZKpPXR4rkM
        CqLtIqqCe2BZskTvF1NQ71rYc
X-Received: by 2002:a05:600c:a05:b0:40c:503:24de with SMTP id z5-20020a05600c0a0500b0040c050324demr443577wmp.88.1701783128071;
        Tue, 05 Dec 2023 05:32:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOqXRjOubfLuT0xgSNa9lK9U/VlBCU3Bv53uHau47CGelyNV2o2s8V8VL4AnY8mLCH1L/QMQ==
X-Received: by 2002:a05:600c:a05:b0:40c:503:24de with SMTP id z5-20020a05600c0a0500b0040c050324demr443563wmp.88.1701783127563;
        Tue, 05 Dec 2023 05:32:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003feae747ff2sm22534426wms.35.2023.12.05.05.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:32:06 -0800 (PST)
Message-ID: <e2db9119-0f8f-42d2-af13-529edb043bc6@redhat.com>
Date:   Tue, 5 Dec 2023 14:32:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 34/39] mm/rmap: introduce
 folio_try_dup_anon_rmap_[pte|ptes|pmd]()
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
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
 <88a341bf-0b6a-454a-aeb1-0699233eb37c@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <88a341bf-0b6a-454a-aeb1-0699233eb37c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.23 14:17, David Hildenbrand wrote:
> On 05.12.23 14:12, Ryan Roberts wrote:
>> On 04/12/2023 14:21, David Hildenbrand wrote:
>>> The last user of page_needs_cow_for_dma() and __page_dup_rmap() are gone,
>>> remove them.
>>>
>>> Add folio_try_dup_anon_rmap_ptes() right away, we want to perform rmap
>>> baching during fork() soon.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    include/linux/mm.h   |   6 --
>>>    include/linux/rmap.h | 145 +++++++++++++++++++++++++++++--------------
>>>    2 files changed, 100 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 24c1c7c5a99c0..f7565b35ae931 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -1964,12 +1964,6 @@ static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
>>>    	return folio_maybe_dma_pinned(folio);
>>>    }
>>>    
>>> -static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>>> -					  struct page *page)
>>> -{
>>> -	return folio_needs_cow_for_dma(vma, page_folio(page));
>>> -}
>>> -
>>>    /**
>>>     * is_zero_page - Query if a page is a zero page
>>>     * @page: The page to query
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index 21d72cc602adc..84439f7720c62 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -354,68 +354,123 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
>>>    #endif
>>>    }
>>>    
>>> -static inline void __page_dup_rmap(struct page *page, bool compound)
>>> +static inline int __folio_try_dup_anon_rmap(struct folio *folio,
>>
>> __always_inline?
> 
> Yes.
> 
>>
>>> +		struct page *page, unsigned int nr_pages,
>>> +		struct vm_area_struct *src_vma, enum rmap_mode mode)
>>>    {
>>> -	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
>>> +	int i;
>>>    
>>> -	if (compound) {
>>> -		struct folio *folio = (struct folio *)page;
>>> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>>>    
>>> -		VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>>> -		atomic_inc(&folio->_entire_mapcount);
>>> -	} else {
>>> -		atomic_inc(&page->_mapcount);
>>> +	/*
>>> +	 * No need to check+clear for already shared PTEs/PMDs of the folio.
>>> +	 * This includes PTE mappings of (order-0) KSM folios.
>>> +	 */
>>> +	if (likely(mode == RMAP_MODE_PTE)) {
>>
>> Presumbly if __always_inline then the compiler will remove this if/else and just
>> keep the part indicated by mode? In which case "likely" is pretty useless? Same
>> for all similar sites in the other patches.
> 
> Yes, also had this in mind. As long as we use __always_inline it
> shouldn't ever matter.

It seems to be cleanest to just do:

switch (mode) {
case RMAP_MODE_PTE:
	...
	break;
case RMAP_MODE_PMD:
	...
	break;
}

-- 
Cheers,

David / dhildenb

