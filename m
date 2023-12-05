Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C4480557E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376771AbjLENJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjLENJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C9A120
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701781768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=zM4JCq9WIGuEp9pa5m7IsGxWFvE7X7kLxgPvEZWQ2Bc=;
        b=EQjL2AT/3VMjd0Pp5TwDDdE3VoqkldzHSBOUl9kXaNZAuajmVIvNrFqkVWzgLnUj72SYZ9
        nQ3vTxpSOSdKbPsBQHfAOLp0eZD8MNtOnWdNn0lecNLJGFZax4IvehoN/jSDaUQO2yYOe6
        UJFrm0RnzhNmoK1nez50NOxIwUSGZS0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-o45JaW7XMpCU7kgdlXWBOQ-1; Tue, 05 Dec 2023 08:09:27 -0500
X-MC-Unique: o45JaW7XMpCU7kgdlXWBOQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b53e5fc6bso43583595e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701781766; x=1702386566;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM4JCq9WIGuEp9pa5m7IsGxWFvE7X7kLxgPvEZWQ2Bc=;
        b=R/ztFQr4/fDZKY3Ai3oO64n0QeRo6ehvQ1/mThmNwZlnYBKB9Fi+GD17UITNG6nVmE
         jE5dQyTzxLFMKgNJrIKeOG+cjJdRaTe15btfn49jmZDGpe0jt5uzmvlro7Z3uYvNl73A
         e1lmBkkr9EcS07cN/nZ199Y150S/ReSAstD22bIG3tXt39FHrwd49rEd7qq0mFhM1KrZ
         fq9IAIp+Ptwd2JjeosGVpNRCSAbvbjXNsdu62Ahpz7QHWc43U5QXaiNQIeCXDqWfwY1Q
         cfvEXnjdzg+gFXE9VyzHX6TlqvfNXuRE6k2UWw3+MrJ3K6F0Zum57ts7snIUiiTWhr6Q
         nxAw==
X-Gm-Message-State: AOJu0YwWTo5cRy9PUqNZGxHxbG6rpWn4HBxz/V7eJalS25Y2WC378z+I
        2t3vogmRdKQKNzu2jyhCOKkMJwCtJgpSDOKRRxe1HKKCoOUDc4PJ/ciuVaFScn6Ogev//1bC3KM
        FRohxC4jNTqlD07L7i5DYsUDY1xYmO240
X-Received: by 2002:a05:600c:982:b0:40b:5e21:cc52 with SMTP id w2-20020a05600c098200b0040b5e21cc52mr477087wmp.125.1701781766174;
        Tue, 05 Dec 2023 05:09:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJAlXNhpRwT3H02YNfNcrwAhHAWbah/g6XzeWGG1aS2xtLW1LzrUMR4GJVLpbecQdCrp8MQQ==
X-Received: by 2002:a05:600c:982:b0:40b:5e21:cc52 with SMTP id w2-20020a05600c098200b0040b5e21cc52mr477069wmp.125.1701781765783;
        Tue, 05 Dec 2023 05:09:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c34cd00b0040b540ff0a5sm18797444wmq.19.2023.12.05.05.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:09:25 -0800 (PST)
Message-ID: <58be47c1-c34e-46a2-a32b-a993f7dee664@redhat.com>
Date:   Tue, 5 Dec 2023 14:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 23/39] mm/rmap: introduce
 folio_remove_rmap_[pte|ptes|pmd]()
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
 <20231204142146.91437-24-david@redhat.com>
 <b113e197-d802-4972-b2df-a47d334629f6@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b113e197-d802-4972-b2df-a47d334629f6@arm.com>
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

>> +static __always_inline void __folio_remove_rmap(struct folio *folio,
>> +		struct page *page, unsigned int nr_pages,
>> +		struct vm_area_struct *vma, enum rmap_mode mode)
>> +{
>>   	atomic_t *mapped = &folio->_nr_pages_mapped;
>> -	int nr = 0, nr_pmdmapped = 0;
>> -	bool last;
>> +	int last, nr = 0, nr_pmdmapped = 0;
> 
> nit: you're being inconsistent across the functions with signed vs unsigned for
> page counts (e.g. nr, nr_pmdmapped) - see __folio_add_rmap(),
> __folio_add_file_rmap(), __folio_add_anon_rmap().
> 

Definitely.

> I suggest pick one and stick to it. Personally I'd go with signed int (since
> that's what all the counters in struct folio that we are manipulating are,
> underneath the atomic_t) then check that nr_pages > 0 in
> __folio_rmap_sanity_checks().

Can do, but note that the counters are signed to detect udnerflows. It 
doesn't make sense here to pass a negative number.

> 
>>   	enum node_stat_item idx;
>>   
>> -	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>> -	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>> +	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
>>   
>>   	/* Is page being unmapped by PTE? Is this its last map to be removed? */
>> -	if (likely(!compound)) {
>> -		last = atomic_add_negative(-1, &page->_mapcount);
>> -		nr = last;
>> -		if (last && folio_test_large(folio)) {
>> -			nr = atomic_dec_return_relaxed(mapped);
>> -			nr = (nr < COMPOUND_MAPPED);
>> -		}
>> -	} else if (folio_test_pmd_mappable(folio)) {
>> -		/* That test is redundant: it's for safety or to optimize out */
>> +	if (likely(mode == RMAP_MODE_PTE)) {
>> +		do {
>> +			last = atomic_add_negative(-1, &page->_mapcount);
>> +			if (last && folio_test_large(folio)) {
>> +				last = atomic_dec_return_relaxed(mapped);
>> +				last = (last < COMPOUND_MAPPED);
>> +			}
>>   
>> +			if (last)
>> +				nr++;
>> +		} while (page++, --nr_pages > 0);
>> +	} else if (mode == RMAP_MODE_PMD) {
>>   		last = atomic_add_negative(-1, &folio->_entire_mapcount);
>>   		if (last) {
>>   			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
>> @@ -1517,7 +1528,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>>   		 * is still mapped.
>>   		 */
>>   		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
> 
> folio_test_pmd_mappable() -> folio_test_large()
> 
> Since you're converting this to support batch PTE removal, it might as well also
> support smaller-than-pmd too?

I remember that you have a patch for that, right? :)

> 
> I currently have a patch to do this same change in the multi-size THP series.
> 

Ah, yes, and that should go in first.


-- 
Cheers,

David / dhildenb

