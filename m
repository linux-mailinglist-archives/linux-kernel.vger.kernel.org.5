Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92B76EB30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjHCNv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjHCNvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FCA10C7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691070630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFtvFxzvtN7yC4jJv7eqOYfjz3o6rsTtEUsEqB0F9gY=;
        b=N7X+xYC6Pq4Sgw06/ALReKUDPcGr8rSJ61wnHQSSh8TpQizc0jVd6u8XBGg+KF8MFLDLBV
        mK/Z6n8xjMaVPMt0iCsJ1SKBbGos0HYFI2pzJF0KADUakIRHGJX46nfdno4sWV8ddLJw/B
        zJE4zsQq57Dvr72twZYAFbga/iVel+c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-2JYGLJtaN7CDoY-vzrQ3aA-1; Thu, 03 Aug 2023 09:50:28 -0400
X-MC-Unique: 2JYGLJtaN7CDoY-vzrQ3aA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3175bf07953so708929f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070627; x=1691675427;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFtvFxzvtN7yC4jJv7eqOYfjz3o6rsTtEUsEqB0F9gY=;
        b=Z63C02plgaVYWvFkHZg3cRVbKQmo8txXeNYLTuOmyF4jZ7AEIFmQq5DniLZ5v59jqg
         EAkSCUAIBC9SBUjJvvnL8JgZryOY+THnMkQ8GjLbRohYId5dIS/WJVU6AS2dGy3stNdI
         EbYXMozTusZLXCwbchAP0YWS9dSr+iO3MJLhoxcDV7gUnXjl6wEuINTW7BCEBvt3o1NH
         E1lODFoLl2hra/xQ1v7Dz+6MSrDPMqsI70jZI8hpqYhnPbhDcR7IFDy8sglWEp1j6KgJ
         kRNhO4LtSKoaPzHSAgdKl+B8Kbzf2Ehwyn/Pm1O0R0Jb8KqYq6Tuk9CfKpM6f0mdEnh3
         o9yQ==
X-Gm-Message-State: ABy/qLYxvlxynC23JHi7/2HG4LkaE4me5mGjfuJyXOO0we1Ycau576UD
        EWxWLQciis/YfA3stllSf52+RquS9UDd9r9WMOfJ/IYUPb6ZjjkngAGOTmsoJSgQED7Q0UhxZB/
        5utqlUiaBHaFWUYM3yx8N/di3
X-Received: by 2002:a05:6000:52:b0:316:d887:624a with SMTP id k18-20020a056000005200b00316d887624amr6276955wrx.15.1691070627549;
        Thu, 03 Aug 2023 06:50:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHINXnvI/NbH2+Y8nVmQoso9t9S0OvMtkkSv5reS2g3Ibze6DPyePC/pFcASpcAO7A5FTtBog==
X-Received: by 2002:a05:6000:52:b0:316:d887:624a with SMTP id k18-20020a056000005200b00316d887624amr6276941wrx.15.1691070627128;
        Thu, 03 Aug 2023 06:50:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9a00:a5f5:5315:b9fa:64df? (p200300cbc7189a00a5f55315b9fa64df.dip0.t-ipconnect.de. [2003:cb:c718:9a00:a5f5:5315:b9fa:64df])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d4206000000b00317a04131c5sm12979287wrq.57.2023.08.03.06.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:50:26 -0700 (PDT)
Message-ID: <a3aba793-5770-cfcd-3dab-91bcbe49c241@redhat.com>
Date:   Thu, 3 Aug 2023 15:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <20230727141837.3386072-4-ryan.roberts@arm.com>
 <6cda91b3-bb7a-4c4c-a618-2572b9c8bbf9@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
In-Reply-To: <6cda91b3-bb7a-4c4c-a618-2572b9c8bbf9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.23 15:38, David Hildenbrand wrote:
> On 27.07.23 16:18, Ryan Roberts wrote:
>> This allows batching the rmap removal with folio_remove_rmap_range(),
>> which means we avoid spuriously adding a partially unmapped folio to the
>> deferred split queue in the common case, which reduces split queue lock
>> contention.
>>
>> Previously each page was removed from the rmap individually with
>> page_remove_rmap(). If the first page belonged to a large folio, this
>> would cause page_remove_rmap() to conclude that the folio was now
>> partially mapped and add the folio to the deferred split queue. But
>> subsequent calls would cause the folio to become fully unmapped, meaning
>> there is no value to adding it to the split queue.
>>
>> A complicating factor is that for platforms where MMU_GATHER_NO_GATHER
>> is enabled (e.g. s390), __tlb_remove_page() drops a reference to the
>> page. This means that the folio reference count could drop to zero while
>> still in use (i.e. before folio_remove_rmap_range() is called). This
>> does not happen on other platforms because the actual page freeing is
>> deferred.
>>
>> Solve this by appropriately getting/putting the folio to guarrantee it
>> does not get freed early. Given the need to get/put the folio in the
>> batch path, we stick to the non-batched path if the folio is not large.
>> While the batched path is functionally correct for a folio with 1 page,
>> it is unlikely to be as efficient as the existing non-batched path in
>> this case.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>    mm/memory.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>    1 file changed, 132 insertions(+)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 01f39e8144ef..d35bd8d2b855 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1391,6 +1391,99 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>>    	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>>    }
>>    
>> +static inline unsigned long page_cont_mapped_vaddr(struct page *page,
>> +				struct page *anchor, unsigned long anchor_vaddr)
>> +{
>> +	unsigned long offset;
>> +	unsigned long vaddr;
>> +
>> +	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
>> +	vaddr = anchor_vaddr + offset;
>> +
>> +	if (anchor > page) {
>> +		if (vaddr > anchor_vaddr)
>> +			return 0;
>> +	} else {
>> +		if (vaddr < anchor_vaddr)
>> +			return ULONG_MAX;
>> +	}
>> +
>> +	return vaddr;
>> +}
>> +
>> +static int folio_nr_pages_cont_mapped(struct folio *folio,
>> +				      struct page *page, pte_t *pte,
>> +				      unsigned long addr, unsigned long end)
>> +{
>> +	pte_t ptent;
>> +	int floops;
>> +	int i;
>> +	unsigned long pfn;
>> +	struct page *folio_end;
>> +
>> +	if (!folio_test_large(folio))
>> +		return 1;
>> +
>> +	folio_end = &folio->page + folio_nr_pages(folio);
>> +	end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
>> +	floops = (end - addr) >> PAGE_SHIFT;
>> +	pfn = page_to_pfn(page);
>> +	pfn++;
>> +	pte++;
>> +
>> +	for (i = 1; i < floops; i++) {
>> +		ptent = ptep_get(pte);
>> +
>> +		if (!pte_present(ptent) || pte_pfn(ptent) != pfn)
>> +			break;
>> +
>> +		pfn++;
>> +		pte++;
>> +	}
>> +
>> +	return i;
>> +}
>> +
>> +static unsigned long try_zap_anon_pte_range(struct mmu_gather *tlb,
>> +					    struct vm_area_struct *vma,
>> +					    struct folio *folio,
>> +					    struct page *page, pte_t *pte,
>> +					    unsigned long addr, int nr_pages,
>> +					    struct zap_details *details)
>> +{
>> +	struct mm_struct *mm = tlb->mm;
>> +	pte_t ptent;
>> +	bool full;
>> +	int i;
>> +
>> +	/* __tlb_remove_page may drop a ref; prevent going to 0 while in use. */
>> +	folio_get(folio);
> 
> Is there no way around that? It feels wrong and IMHO a bit ugly.
> 
> With this patch, you'll might suddenly have mapcount > refcount for a
> folio, or am I wrong?

Thinking about it, Maybe we should really find a way to keep the current 
logic flow unmodified:

1) ptep_get_and_clear_full()
2) tlb_remove_tlb_entry()
3) page_remove_rmap()
4) __tlb_remove_page()

For example, one loop to handle 1) and 2); and another one to handle 4).

This will need a way to query for the first loop how often we can call 
__tlb_remove_page() before we need a flush.

The simple answer would be "batch->max - batch->nr". tlb_next_batch() 
makes exceeding that a bit harder, maybe it's not really required.

-- 
Cheers,

David / dhildenb

