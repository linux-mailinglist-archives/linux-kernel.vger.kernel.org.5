Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD20980D1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344876AbjLKQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344896AbjLKQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:35:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF0991
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702312547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=CJNLvfM2+sDAhtWtWSLZKEEHZZTVIXo/koGlz70aoJA=;
        b=WdyiiIjUC/6NiLW9uyhp9dRL4N+KcB8wBqwsX1bkgmqiAMYrr4Dc9cDb6mi1UjalCv+yXw
        EQ9Uv9hHDazVt88c4rxyxEeIPUG9NiUS/C36n/QLRbffvbEz3xuMSQ6zga8zdftPNUtJJz
        hW4VKTnoilfDY6XftI8w/7snaLT7oz8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-1rKjXzZ-OhO46RtB6_ZBBA-1; Mon, 11 Dec 2023 11:35:46 -0500
X-MC-Unique: 1rKjXzZ-OhO46RtB6_ZBBA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3333c009305so4102925f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312545; x=1702917345;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJNLvfM2+sDAhtWtWSLZKEEHZZTVIXo/koGlz70aoJA=;
        b=Hn65yJ5zqquiBY3vJwr2BP/hTwLp8EYiWLLBq6E2ilb2b+1PTg57uW+car5gzr7OfB
         wYsufKfOhKNgruN7wACEhEfS5YAtyo9WBVeliJDLwB4xa6YPRFWuA6Dno26fJAkYave4
         lTrN5o7rEMRH+nDE35LRDQz733O5Oi3FlWYXGXOOtxAyFA5uf4bGSMLWCR5NmeUxQyhb
         wD3VsNRZfkiGYXN/KLaxnzbJzLYoR3+PqldZ1V/91L/BTobwJMGRPDhd6eqPEnb0/k+6
         IU5W8+DVLFYJC+h15CHq+/KjxV23etr5A+UjWzXmZ3LILbIon9MU1ttUmG5wJtpP6asR
         Zlpw==
X-Gm-Message-State: AOJu0YyJV7/j+6KLqWmRmoyaEMRODaNVb3qXgaBsYXfFoSeV3A9gb5QC
        b3O/xThIM19XXFt9EgeDTc/g1dea5VfhDIplklizfQb+P7ZbnO3uwcM3Wy3RvN/Iz4zB4JW6Ezo
        hOVYTbuwlMi6DnK4g2uEDS+y5
X-Received: by 2002:a05:600c:1ca7:b0:40c:3548:1ee9 with SMTP id k39-20020a05600c1ca700b0040c35481ee9mr2210708wms.164.1702312544772;
        Mon, 11 Dec 2023 08:35:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSu8LMQMyz10AqPy+OD7tQjIn+2fu2jth+qRBYVSNjxt4c31O/ASrWWAwBdpX3Jke3U8VNPQ==
X-Received: by 2002:a05:600c:1ca7:b0:40c:3548:1ee9 with SMTP id k39-20020a05600c1ca700b0040c35481ee9mr2210695wms.164.1702312544417;
        Mon, 11 Dec 2023 08:35:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c742:ae00:6e5f:7195:98f6:3ed1? (p200300cbc742ae006e5f719598f63ed1.dip0.t-ipconnect.de. [2003:cb:c742:ae00:6e5f:7195:98f6:3ed1])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm15751231wms.30.2023.12.11.08.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 08:35:44 -0800 (PST)
Message-ID: <c6cbf488-89d6-48fc-bd0f-7d666a95e035@redhat.com>
Date:   Mon, 11 Dec 2023 17:35:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/39] mm/rmap: introduce and use hugetlb_remove_rmap()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-3-david@redhat.com>
 <ZXc54xgLxaBSTuaq@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZXc54xgLxaBSTuaq@casper.infradead.org>
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

On 11.12.23 17:33, Matthew Wilcox wrote:
> On Mon, Dec 11, 2023 at 04:56:15PM +0100, David Hildenbrand wrote:
>> hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
>> For example, hugetlb currently only supports entire mappings, and treats
>> any mapping as mapped using a single "logical PTE". Let's move it out
>> of the way so we can overhaul our "ordinary" rmap.
>> implementation/interface.
>>
>> Let's introduce and use hugetlb_remove_rmap() and remove the hugetlb
>> code from page_remove_rmap(). This effectively removes one check on the
>> small-folio path as well.
>>
>> Note: all possible candidates that need care are page_remove_rmap() that
>>        pass compound=true.
>>
>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
>> +++ b/mm/rmap.c
>> @@ -1482,13 +1482,6 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>>   
>>   	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>>   
>> -	/* Hugetlb pages are not counted in NR_*MAPPED */
>> -	if (unlikely(folio_test_hugetlb(folio))) {
>> -		/* hugetlb pages are always mapped with pmds */
>> -		atomic_dec(&folio->_entire_mapcount);
>> -		return;
>> -	}
> 
> Maybe add
> 	VM_BUG_ON_FOLIO(folio_test_hugetlb(folio), folio);
> 

A bulk-add that in patch #6.

Thanks!

-- 
Cheers,

David / dhildenb

