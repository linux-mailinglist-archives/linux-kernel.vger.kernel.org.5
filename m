Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F85E79913A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjIHUsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbjIHUsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:48:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B528C9C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:48:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so26241645e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694206088; x=1694810888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwlpmlnoH2/XNLfnwkkZ/snO4wOJuimlWOr26ADJPt4=;
        b=lJ39K8qOTM3DrPfkRl9aK7A/vV7Kd/kNwVWz/iHoiydIJJGGurrGkelGjx9pTyAC5M
         e7Aj1cIAYbrl8Mo5Jjgxga4fu02Dy9x8EvfzJZVi3x3Ob0uOOPtPAV0DGKnOHDzC2KQg
         OknLOq4vuTE9/Wb6LTEWojkQl/3kVXoTllXOWUairEk+/R8cpipYFygAeax6745l4RZE
         lrdIx/M2/QK53AL3fLlX6xRWnBfxp67Nw86HoTjpvNsSLJLg1E0tQ7thJJvRJ2mAORKT
         pPuSaFvtZwp4DbVfXQlTfXLZajySTbAiDx3bBH2XYUJsqyxc/toAWP2lsdXC96sz2CGR
         sXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694206088; x=1694810888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwlpmlnoH2/XNLfnwkkZ/snO4wOJuimlWOr26ADJPt4=;
        b=Mf8lSbqIW6dB0BsfBiwhGwpumZCiwGtyfXqBmjheqgUzEFca/6wskFjiqZTPzQtmbe
         mgAu6bicaAVs5EoYEYKe2Jm1/qiBYuMLazf4Jr09th6tsRpN3wQ8YzzxiWUdo9qeOP1K
         tCH0y3hAxdEFYL+nI21cxx6JRqrCZhEkBt/dzgoAAkc8qrxDmOrRpC0t62vPiei3DxFx
         DDXU+81xz11CUASlZpavlgedSnrsIwu7ijvE6ZmXO+QillYWx0IyXe59VpR8sK1jU/Uf
         0YW1ZRykYmWBzBS8mUvAmCsPDuaC7Qx9YNkjSTnL+NaxzxJkyPe4gtt+pRjMB7FtlF0E
         5plQ==
X-Gm-Message-State: AOJu0YyDUqTw1fP29H692Mf8qoawf+WbmeZNbUn4zrqprFDxXyVNJuq0
        2lBSdENUQvo95q8VYCV5SsxqUQQ+ey4zSqbVMMY=
X-Google-Smtp-Source: AGHT+IEsJEJkxBZhGZ02mU7PSIc4qDnHnbm9qULLT/PItBheKbhbolKCJ2gwyX3mc2Md2WiaTqLJ6g==
X-Received: by 2002:a5d:4e41:0:b0:31a:ccc6:b8de with SMTP id r1-20020a5d4e41000000b0031accc6b8demr2692257wrt.50.1694206088060;
        Fri, 08 Sep 2023 13:48:08 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b5c7:0:2620:8c76:d54f:c8e0? ([2a02:6b6a:b5c7:0:2620:8c76:d54f:c8e0])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d6791000000b00318147fd2d3sm2949124wru.41.2023.09.08.13.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 13:48:07 -0700 (PDT)
Message-ID: <63b72487-6220-7c44-70fd-822681746737@bytedance.com>
Date:   Fri, 8 Sep 2023 21:48:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [v4 4/4] mm: hugetlb: Skip initialization of
 gigantic tail struct pages if freed by HVO
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-5-usama.arif@bytedance.com>
 <20230907183712.GB3640@monkey>
 <C51EF081-ABC9-4770-B329-2CAC2CE979FA@linux.dev>
 <20230908182950.GA6564@monkey>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20230908182950.GA6564@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2023 19:29, Mike Kravetz wrote:
> On 09/08/23 10:39, Muchun Song wrote:
>>
>>
>>> On Sep 8, 2023, at 02:37, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> On 09/06/23 12:26, Usama Arif wrote:
>>>> The new boot flow when it comes to initialization of gigantic pages
>>>> is as follows:
>>>> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
>>>> the region after the first struct page is marked as noinit.
>>>> - This results in only the first struct page to be
>>>> initialized in reserve_bootmem_region. As the tail struct pages are
>>>> not initialized at this point, there can be a significant saving
>>>> in boot time if HVO succeeds later on.
>>>> - Later on in the boot, the head page is prepped and the first
>>>> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
>>>> are initialized.
>>>> - HVO is attempted. If it is not successful, then the rest of the
>>>> tail struct pages are initialized. If it is successful, no more
>>>> tail struct pages need to be initialized saving significant boot time.
>>>>
>>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>>> ---
>>>> mm/hugetlb.c         | 61 +++++++++++++++++++++++++++++++++++++-------
>>>> mm/hugetlb_vmemmap.c |  2 +-
>>>> mm/hugetlb_vmemmap.h |  9 ++++---
>>>> mm/internal.h        |  3 +++
>>>> mm/mm_init.c         |  2 +-
>>>> 5 files changed, 62 insertions(+), 15 deletions(-)
>>>
>>> As mentioned, in general this looks good.  One small point below.
>>>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index c32ca241df4b..540e0386514e 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -3169,6 +3169,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>>>> }
>>>>
>>>> found:
>>>> +
>>>> + 	/*
>>>> + 	 * Only initialize the head struct page in memmap_init_reserved_pages,
>>>> + 	 * rest of the struct pages will be initialized by the HugeTLB subsystem itself.
>>>> + 	 * The head struct page is used to get folio information by the HugeTLB
>>>> + 	 * subsystem like zone id and node id.
>>>> + 	 */
>>>> + 	memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
>>>> + 	huge_page_size(h) - PAGE_SIZE);
>>>> 	/* Put them into a private list first because mem_map is not up yet */
>>>> 	INIT_LIST_HEAD(&m->list);
>>>> 	list_add(&m->list, &huge_boot_pages);
>>>> @@ -3176,6 +3185,40 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>>>> 	return 1;
>>>> }
>>>>
>>>> +/* Initialize [start_page:end_page_number] tail struct pages of a hugepage */
>>>> +static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
>>>> +     		unsigned long start_page_number,
>>>> +     		unsigned long end_page_number)
>>>> +{
>>>> + 	enum zone_type zone = zone_idx(folio_zone(folio));
>>>> + 	int nid = folio_nid(folio);
>>>> + 	unsigned long head_pfn = folio_pfn(folio);
>>>> + 	unsigned long pfn, end_pfn = head_pfn + end_page_number;
>>>> +
>>>> + 	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
>>>> + 	struct page *page = pfn_to_page(pfn);
>>>> +
>>>> + 		__init_single_page(page, pfn, zone, nid);
>>>> + 		prep_compound_tail((struct page *)folio, pfn - head_pfn);
>>>> + 		set_page_count(page, 0);
>>>> + 	}
>>>> +}
>>>> +
>>>> +static void __init hugetlb_folio_init_vmemmap(struct folio *folio, struct hstate *h,
>>>> +        unsigned long nr_pages)
>>>> +{
>>>> + 	int ret;
>>>> +
>>>> + 	/* Prepare folio head */
>>>> +	 __folio_clear_reserved(folio);
>>>> + 	__folio_set_head(folio);
>>>> + 	ret = page_ref_freeze(&folio->page, 1);
>>>> + 	VM_BUG_ON(!ret);
>>>
>>> In the current code, we print a warning and free the associated pages to
>>> buddy if we ever experience an increased ref count.  The routine
>>> hugetlb_folio_init_tail_vmemmap does not check for this.
>>>
>>> I do not believe speculative/temporary ref counts this early in the boot
>>> process are possible.  It would be great to get input from someone else.
>>
>> Yes, it is a very early stage and other tail struct pages haven't been
>> initialized yet, anyone should not reference them. It it the same case
>> as CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled.
>>
>>>
>>> When I wrote the existing code, it was fairly easy to WARN and continue
>>> if we encountered an increased ref count.  Things would be bit more
>>
>> In your case, I think it is not in the boot process, right?
> 
> They were calls in the same routine: gather_bootmem_prealloc().
> 
>>> complicated here.  So, it may not be worth the effort.
>>
>> Agree. Note that tail struct pages are not initialized here, if we want to
>> handle head page, how to handle tail pages? It really cannot resolved.
>> We should make the same assumption as CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> that anyone should not reference those pages.
> 
> Agree that speculative refs should not happen this early.  How about making
> the following changes?
> - Instead of set_page_count() in hugetlb_folio_init_tail_vmemmap, do a
>    page_ref_freeze and VM_BUG_ON if not ref_count != 1.
> - In the commit message, mention 'The WARN_ON for increased ref count in
>    gather_bootmem_prealloc was changed to a VM_BUG_ON.  This is OK as
>    there should be no speculative references this early in boot process.
>    The VM_BUG_ON's are there just in case such code is introduced.'

Sounds good, although its not possible for the refcnt to not be 1 as 
there isnt anything that happens between __init_single_page and 
setting/freezing refcnt to 0. I will include the below diff in the next 
revision with the explanation in commit message as suggested.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 540e0386514e..ed37c6e4e952 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3194,13 +3194,15 @@ static void __init 
hugetlb_folio_init_tail_vmemmap(struct folio *folio,
         int nid = folio_nid(folio);
         unsigned long head_pfn = folio_pfn(folio);
         unsigned long pfn, end_pfn = head_pfn + end_page_number;
+       int ret;

         for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
                 struct page *page = pfn_to_page(pfn);

                 __init_single_page(page, pfn, zone, nid);
                 prep_compound_tail((struct page *)folio, pfn - head_pfn);
-               set_page_count(page, 0);
+               ret = page_ref_freeze(page, 1);
+               VM_BUG_ON(!ret);
         }
  }
