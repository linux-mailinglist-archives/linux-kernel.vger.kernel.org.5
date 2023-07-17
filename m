Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502197564BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjGQNXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGQNV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18DBE9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689599986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzmRvgGj5UdJOZDAPQTMOnuzZpufzLU+V21Io7HbvPk=;
        b=O0CHzYNPUxK73JH+Lj0rPegQaQgefYDQsoiPUyYz2MRt/MHApEgDhhA+V44TFbz+2PfUdf
        iXXQhl5V3oDLQL063W+ap3z4380O5naFqZ6Hq3RP0TFRj0ielE86qlpU4dLlg0kSGrOFcr
        VAHddLnRi/fHYlHPhPJVlzV2uHaYIvI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-q-CwYqI_NcW7L6Z9Aqz76Q-1; Mon, 17 Jul 2023 09:19:45 -0400
X-MC-Unique: q-CwYqI_NcW7L6Z9Aqz76Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31444df0fafso2779255f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689599984; x=1692191984;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzmRvgGj5UdJOZDAPQTMOnuzZpufzLU+V21Io7HbvPk=;
        b=azaOLmeupaxy0uZV76HLTtQkzWnKpQk0U6mX0HZoRcyyX5n6wRCpjvpULnfvW1n1vJ
         tvHK2rSYe3b9n2rr4YDcjw3R4xD4VYD4JhNuGDZlGNpnY7sGk8e09bMrE5jpUgwqUDhm
         FyflGnT7nFVmOrCQFnlOJouse/X8OBUu1r8uuG2bWJYmI3MIXtHQ3Z7r+g1DaH5EKUN9
         vjOwDfTP2kbB4LRwu98GM5zzL5tWe95vlQUu/5nCtVB2HEL3GbqGX5xc5BsnN0DxPjn1
         wnNun3AE1wveebrRC1c4ayI1YkTVHNf+rgpaEYs+EPLDrwEImpth3osHQHnOyihbTYcI
         odeA==
X-Gm-Message-State: ABy/qLZ+DzkSTFpxMbAAdHvlMyE300cGLmM1ag36juTv8eWMk1oOdiS+
        7c3gkoApPve52+qmrRcz8kSgnr4Iio00+QzOW2E3NHUHTlAdmos72BDWH5WugLLMO39Eo8g/MUL
        x+P5D/IP3IvCJVaF5GsZ3NQeP
X-Received: by 2002:adf:fe4c:0:b0:313:e8bf:a6e with SMTP id m12-20020adffe4c000000b00313e8bf0a6emr10449480wrs.21.1689599983870;
        Mon, 17 Jul 2023 06:19:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3KtgkR9RcfsSCfHtEUje6im5uz8dXVMLKlC0jTshe+fSle3yKdym4sWdYH9qzjU1SFSBGpw==
X-Received: by 2002:adf:fe4c:0:b0:313:e8bf:a6e with SMTP id m12-20020adffe4c000000b00313e8bf0a6emr10449464wrs.21.1689599983473;
        Mon, 17 Jul 2023 06:19:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d4dc4000000b0031424f4ef1dsm19243672wru.19.2023.07.17.06.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:19:43 -0700 (PDT)
Message-ID: <bf84d967-545f-92f8-bb82-2cbc0a54ddbc@redhat.com>
Date:   Mon, 17 Jul 2023 15:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-1-ryan.roberts@arm.com>
 <d85c0f04-1792-2a0f-d0be-7fffc7604797@redhat.com>
 <fccc8f3e-126f-baab-a14d-387018e5b8b7@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/4] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
In-Reply-To: <fccc8f3e-126f-baab-a14d-387018e5b8b7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.23 15:13, Ryan Roberts wrote:
> On 17/07/2023 14:00, David Hildenbrand wrote:
>> On 14.07.23 18:17, Ryan Roberts wrote:
>>> In preparation for FLEXIBLE_THP support, improve
>>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>>> passed to it. In this case, all contained pages are accounted using the
>>> order-0 folio (or base page) scheme.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>> ---
>>>    mm/rmap.c | 28 +++++++++++++++++++++-------
>>>    1 file changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 0c0d8857dfce..f293d072368a 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1278,31 +1278,45 @@ void page_add_anon_rmap(struct page *page, struct
>>> vm_area_struct *vma,
>>>     * This means the inc-and-test can be bypassed.
>>>     * The folio does not have to be locked.
>>>     *
>>> - * If the folio is large, it is accounted as a THP.  As the folio
>>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>>>     * is new, it's assumed to be mapped exclusively by a single process.
>>>     */
>>>    void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>            unsigned long address)
>>>    {
>>> -    int nr;
>>> +    int nr = folio_nr_pages(folio);
>>>
>>> -    VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>>> +    VM_BUG_ON_VMA(address < vma->vm_start ||
>>> +            address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>>        __folio_set_swapbacked(folio);
>>>
>>> -    if (likely(!folio_test_pmd_mappable(folio))) {
>>> +    if (!folio_test_large(folio)) {
>>
>> Why remove the "likely" here? The patch itself does not change anything about
>> that condition.
> 
> Good question; I'm not sure why. Will have to put it down to bad copy/paste
> fixup. Will put it back in the next version.
> 
>>
>>>            /* increment count (starts at -1) */
>>>            atomic_set(&folio->_mapcount, 0);
>>> -        nr = 1;
>>> +        __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>> +    } else if (!folio_test_pmd_mappable(folio)) {
>>> +        int i;
>>> +
>>> +        for (i = 0; i < nr; i++) {
>>> +            struct page *page = folio_page(folio, i);
>>> +
>>> +            /* increment count (starts at -1) */
>>> +            atomic_set(&page->_mapcount, 0);
>>> +            __page_set_anon_rmap(folio, page, vma,
>>> +                    address + (i << PAGE_SHIFT), 1);
>>> +        }
>>> +
>>> +        /* increment count (starts at 0) */
>>
>> That comment is a bit misleading. We're not talking about a mapcount as in the
>> other cases here.
> 
> Correct, I'm talking about _nr_pages_mapped, which starts 0, not -1 like
> _mapcount. The comment was intended to be in the style used in other similar
> places in rmap.c. I could change it to: "_nr_pages_mapped is 0-based, so set it
> to the number of pages in the folio" or remove it entirely? What do you prefer?
> 

We only have to comment what's weird, not what's normal.

IOW, we also didn't have such a comment in the existing code when doing 
atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);


What might make sense here is a simple

"All pages of the folio are PTE-mapped."

-- 
Cheers,

David / dhildenb

