Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED203753334
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjGNHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjGNHby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828B41FEE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689319871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFS9yCsx5eOJxRc13hfDeSrkj2kufE3IZQlqjqcPfw8=;
        b=jJMEXNXQrVcf+P30pOGpk8AnyUjPO/NwXq5jG9h/impPNremEx+2GktUbw54qdzhsbqj9U
        nbh/gj9vSpqcdhPyAfjrh1NO9DBp4FR67JMmYrFSminE4Ngp1Tfa16LtZOsp2RHOSLSj18
        LvkR+y4YJF4I3b7LEijB52r8WqhMNLI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-8j1X1moOOYGeKStG3U46_A-1; Fri, 14 Jul 2023 03:31:09 -0400
X-MC-Unique: 8j1X1moOOYGeKStG3U46_A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbe4cecd66so8535495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689319867; x=1691911867;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFS9yCsx5eOJxRc13hfDeSrkj2kufE3IZQlqjqcPfw8=;
        b=DccyCa7OV735UEB5V3WVLysDZ1Uc9ov/3r6EDZ4gS3SIyEGwQkPodXkdnq3lW52s4G
         0l310Q7JkGkuSYpswrS6Rbb/HuVw8xLU7oSCUFxbhqE/iYeMmtts5McGAV1N3NLp/Inf
         /vs0SgdKaZMoVonGwhPBS0nz7Yo+JkRhOYWRn2NyOkC4Hx4BB3bOl/6zDx+B/kKliBB6
         r3DqNxn8hhSayyrh8xdM/I4EtXJ09VftsQwHAGfEc4h2cUi6uUveyFrkwHPb6s1zG/Cg
         xHNVIlsl3Pxa6dd0cCtDMX0DLUMXKpj4ZSqB3KWU2ezfabMWdLn8nzMGu933OdNEUALz
         MRcg==
X-Gm-Message-State: ABy/qLaQyX2tdLQkwhA4678C0tQix22q6GgV268ejexu+YKiQ3Gi+80I
        3GrQBF8eze2PsiJqh4VSvI+ld5NgmghbrZFVg3gHigww8gV5be+ZX2wzALKiJBnHRnU4OGWfG4i
        UGPPM+/p+/ts7XjB03+QI6OK0
X-Received: by 2002:a05:600c:205:b0:3f5:878:c0c2 with SMTP id 5-20020a05600c020500b003f50878c0c2mr3291420wmi.3.1689319867340;
        Fri, 14 Jul 2023 00:31:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3WkevYS04U7Q1h5Why0+FtHC0+qv1IsLhd/s9PO3XWXE+lvk/das3PR765u5hXm9MbqPjxA==
X-Received: by 2002:a05:600c:205:b0:3f5:878:c0c2 with SMTP id 5-20020a05600c020500b003f50878c0c2mr3291394wmi.3.1689319866865;
        Fri, 14 Jul 2023 00:31:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:4500:8a9e:a24a:133d:86bb? (p200300cbc70a45008a9ea24a133d86bb.dip0.t-ipconnect.de. [2003:cb:c70a:4500:8a9e:a24a:133d:86bb])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c470300b003f7f475c3bcsm1383010wmo.1.2023.07.14.00.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:31:06 -0700 (PDT)
Message-ID: <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
Date:   Fri, 14 Jul 2023 09:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, ryan.roberts@arm.com, shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
 <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
 <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
In-Reply-To: <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
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

On 14.07.23 05:23, Yu Zhao wrote:
> On Thu, Jul 13, 2023 at 9:10 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 7/14/2023 10:08 AM, Yu Zhao wrote:
>>> On Thu, Jul 13, 2023 at 9:06 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>> Current madvise_cold_or_pageout_pte_range() has two problems for
>>>> large folio support:
>>>>    - Using folio_mapcount() with large folio prevent large folio from
>>>>      picking up.
>>>>    - If large folio is in the range requested, shouldn't split it
>>>>      in madvise_cold_or_pageout_pte_range().
>>>>
>>>> Fix them by:
>>>>    - Use folio_estimated_sharers() with large folio
>>>>    - If large folio is in the range requested, don't split it. Leave
>>>>      to page reclaim phase.
>>>>
>>>> For large folio cross boundaries of requested range, skip it if it's
>>>> page cache. Try to split it if it's anonymous folio. If splitting
>>>> fails, skip it.
>>>
>>> For now, we may not want to change the existing semantic (heuristic).
>>> IOW, we may want to stick to the "only owner" condition:
>>>
>>>    - if (folio_mapcount(folio) != 1)
>>>    + if (folio_entire_mapcount(folio) ||
>>>    +     (any_page_within_range_has_mapcount > 1))
>>>
>>> +Minchan Kim
>> The folio_estimated_sharers() was discussed here:
>> https://lore.kernel.org/linux-mm/20230118232219.27038-6-vishal.moola@gmail.com/
>> https://lore.kernel.org/linux-mm/20230124012210.13963-2-vishal.moola@gmail.com/
>>
>> Yes. It's accurate to check each page of large folio. But it may be over killed in
>> some cases (And I think madvise is one of the cases not necessary to be accurate.
>> So folio_estimated_sharers() is enough. Correct me if I am wrong).
> 
> I see. Then it's possible this is also what the original commit wants
> to do -- Minchan, could you clarify?
> 
> Regardless, I think we can have the following fix, potentially cc'ing stable:
> 
> -  if (folio_mapcount(folio) != 1)
> +  if (folio_estimated_sharers(folio) != 1)
> 
> Sounds good?

Adding to the discussion, currently the COW selftest always skips a 
PTE-mapped THP.


For example:

# [INFO] Anonymous memory tests in private mappings
# [RUN] Basic COW after fork() ... with base page
ok 1 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped out base page
ok 2 No leak from parent into child
# [RUN] Basic COW after fork() ... with THP
ok 3 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped-out THP
ok 4 No leak from parent into child
# [RUN] Basic COW after fork() ... with PTE-mapped THP
ok 5 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
...


The commit that introduced that change is:

commit 07e8c82b5eff8ef34b74210eacb8d9c4a2886b82
Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Date:   Wed Dec 21 10:08:46 2022 -0800

     madvise: convert madvise_cold_or_pageout_pte_range() to use folios

     This change removes a number of calls to compound_head(), and saves
     1729 bytes of kernel text.



folio_mapcount(folio) is wrong, because that never works on a PTE-mapped 
THP (well, unless only a single subpage is still mapped ...).

page_mapcount(folio) was wrong, because it ignored all other subpages, 
but at least it worked in some cases.

folio_estimated_sharers(folio) is similarly wrong like page_mapcount(), 
as it's essentially a page_mapcount() of the first subpage.

(ignoring that a lockless mapcount-based check is always kind-of 
unreliable, but that's msotly acceptable for these kind of things)


So, unfortunately, page_mapcount() / folio_estimated_sharers() is best 
we can do for now, but they miss to detect some cases of sharing of the 
folio -- false negatives to detect sharing.


Ideally we want something like folio_maybe_mapped_shared(), and get rid 
of folio_estimated_sharers(), we better to guess the exact number, 
simply works towards an answer that tells us "yep, this may be mapped by 
multiple sharers" vs. "no, this is definitely not mapped by multiple 
sharers".

The "mapped" part of it indicates that this does not catch all cases of 
sharing. But it should handle most of the cases we care about.


There, we can then implement something better than what 
folio_estimated_sharers() currently does:

static inline bool folio_maybe_mapped_shared(folio)
{
	if (likely(!folio_test_large(folio)))
		return atomic_read(&folio->_mapcount) > 0;

	/* Mapped multiple times via PMD? */
	if (folio_test_pmd_mappable(folio)
		return folio_entire_mapcount() > 1;

	/*
	 * First subpage is mapped multiple times (especially also via
	 * PMDs)?
          */
	if (page_mapcount(folio_page(folio, 0) > 1)
		return true;

	/* TODO: also test last subpage? */
	
	/* Definitely shared if we're mapping a page multiple times. */
	return folio_total_mapcount(folio) > folio_nr_pages(folio);
}

There are some more things we could optimize for.



While it's better than what we have right now:

(a) It's racy. Well, it's always been racy with concurrent (un)mapping
     and splitting. But maybe we can do better.

(b) folio_total_mapcount() is currently expensive.

(c) there are still false negatives even without races.


For anon pages, we could scan all subpages and test if they are 
PageAnonExclusive, but it's also not really what we want to do here.


I have some idea to handle anon pages better to avoid any page table 
walk or subpage scan, improving (a), (b) and (c). It might work for 
pagecache pages with some more work, but it's a bit more complicated 
with the scheme I have in mind).


First step would be replacing folio->_nr_pages_mapped by 
folio->_total_mapcount. While we could eventually have 
folio->_total_mapcount in addition to folio->_nr_pages_mapped, I'm, not 
sure if we want to go down that path


That would make folio_total_mapcount() extremely fast (I'm working on a 
prototype). The downsides are that

(a) We have to make NR_ANON_MAPPED/NR_FILE_MAPPED accounting less 
precise. Easiest way to handle it: as soon as a single subpage is 
mapped, account the whole folio as mapped. After all, it's consuming 
memory, so who cares?

(b) We have to find a different way to decide when to put an anonymous 
folio on the deferred split queue in page_remove_rmap(). Some cases are 
nasty to handle: PTE-mapped THP that are shared between a parent and a 
child.

I have to do some more thinking about (b), I'd be happy about thoughts 
on that.

-- 
Cheers,

David / dhildenb

