Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A560753659
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjGNJ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbjGNJZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2DD2D51
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689326709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZ9Td58ANzPUzB7LnanvAxN3EjUOTHEhOzZSnP5c4MQ=;
        b=QirzkQA7Uze5elQtQ0WqbAceR11ZveD3JC96DGu7gnvbZE4aC2eXq5msk2If18ALC+1cFt
        V96E7tuszUIHQHRBBPdUHroIhzCatUwUdC888vOx118V1aX2124lH/WuJt0OgIzqrrhu1X
        gTlA6hKrU+JD9XP4HonnU9t1A4ja1jE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-vnA1l71CPe6deKTXrp9v7A-1; Fri, 14 Jul 2023 05:25:08 -0400
X-MC-Unique: vnA1l71CPe6deKTXrp9v7A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbe4cecd66so9087265e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689326707; x=1691918707;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZ9Td58ANzPUzB7LnanvAxN3EjUOTHEhOzZSnP5c4MQ=;
        b=HZ20MwLrcRN0GNCEvy4tCKXvggzgWthc+WKYPkVgZisjHbGOED3gRUUDIuDnyNgCrs
         B1tc5MhGeZF/RhhXn+/WIg2Ho65GQOWzDIZ2A0DJu597iQJO7ySYhnOtKCVoiJvzPQa4
         KJCgXU+PjeaQvuF5/9nYbfHxMeVgqLJ99LJBd7JUkkseiPsvLqJRqPip7qVT5NRA6B7W
         imV6u1VuONSIO3oI3x6JoQtJs3FlxIxsc64nuoKoiwnv/EZ6zU5gj3gR/SCAPRypBflN
         2pRyFenk8/Vm9F38vev7q+q7eaoNlwz/Oq7ui36v0iCpcByJOm197t9x4Y3+29tMlSYg
         cIIQ==
X-Gm-Message-State: ABy/qLa5WijtKXrubBEJPjWY2EP4R8j+cvtGgfy1vxdL+a0MEt6FUr93
        ur1m+2t0+ClxtGnXlrTJDPPlpS900U5Y1rvNa/SFWVae5Y0J+ph0y4RZHbkU3cvCNFeRW35aEqj
        U30+9L1uaNZqbK/IBxpMrR3UC
X-Received: by 2002:a7b:c383:0:b0:3fc:9e:eead with SMTP id s3-20020a7bc383000000b003fc009eeeadmr3499807wmj.20.1689326707104;
        Fri, 14 Jul 2023 02:25:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGtlCl6szFVfmowSABK3dKXMxCz9U7XEFSxW0fZjzmrBhkLAOByIkiQK8b153lVXwCbVm3sdw==
X-Received: by 2002:a7b:c383:0:b0:3fc:9e:eead with SMTP id s3-20020a7bc383000000b003fc009eeeadmr3499789wmj.20.1689326706677;
        Fri, 14 Jul 2023 02:25:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:4500:8a9e:a24a:133d:86bb? (p200300cbc70a45008a9ea24a133d86bb.dip0.t-ipconnect.de. [2003:cb:c70a:4500:8a9e:a24a:133d:86bb])
        by smtp.gmail.com with ESMTPSA id o6-20020a1c7506000000b003fc00212c1esm969657wmc.28.2023.07.14.02.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 02:25:06 -0700 (PDT)
Message-ID: <36cfe140-5685-bea7-d267-4a61f21aeb79@redhat.com>
Date:   Fri, 14 Jul 2023 11:25:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Zi Yan <ziy@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, ryan.roberts@arm.com, shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
 <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
 <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
 <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
 <2cbf457e-389e-cd45-1262-879513a4cf41@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
In-Reply-To: <2cbf457e-389e-cd45-1262-879513a4cf41@intel.com>
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

On 14.07.23 10:34, Yin, Fengwei wrote:
[...]

>>> Sounds good?
>>
>> Adding to the discussion, currently the COW selftest always skips a PTE-mapped THP.
> You always have very good summary of the situation. Thanks a lot for
> adding the following information.
> 
> Add Zi Yan as this is still about mapcount of the folio.
> 

Thanks, I thought he would have already been CCed!

>>
>>
>> For example:
>>
>> # [INFO] Anonymous memory tests in private mappings
>> # [RUN] Basic COW after fork() ... with base page
>> ok 1 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with swapped out base page
>> ok 2 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with THP
>> ok 3 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with swapped-out THP
>> ok 4 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with PTE-mapped THP
>> ok 5 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
>> ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
>> ...
>>
>>
>> The commit that introduced that change is:
>>
>> commit 07e8c82b5eff8ef34b74210eacb8d9c4a2886b82
>> Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>> Date:   Wed Dec 21 10:08:46 2022 -0800
>>
>>      madvise: convert madvise_cold_or_pageout_pte_range() to use folios
>>
>>      This change removes a number of calls to compound_head(), and saves
>>      1729 bytes of kernel text.
>>
>>
>>
>> folio_mapcount(folio) is wrong, because that never works on a PTE-mapped THP (well, unless only a single subpage is still mapped ...).
>>
>> page_mapcount(folio) was wrong, because it ignored all other subpages, but at least it worked in some cases.
>>
>> folio_estimated_sharers(folio) is similarly wrong like page_mapcount(), as it's essentially a page_mapcount() of the first subpage.
>>
>> (ignoring that a lockless mapcount-based check is always kind-of unreliable, but that's msotly acceptable for these kind of things)
>>
>>
>> So, unfortunately, page_mapcount() / folio_estimated_sharers() is best we can do for now, but they miss to detect some cases of sharing of the folio -- false negatives to detect sharing.
>>
>>
>> Ideally we want something like folio_maybe_mapped_shared(), and get rid of folio_estimated_sharers(), we better to guess the exact number, simply works towards an answer that tells us "yep, this may be mapped by multiple sharers" vs. "no, this is definitely not mapped by multiple sharers".
>>
> So you want to accurate number. My understanding is that it's required for COW case.

For COW we have to take a look at the mapcount vs. the refcount:

With an order-0 page that's straight forward:
   (a) Has that page never been shared (PageAnonExclusive?), then I am
       the exclusive owner and can reuse.
   (a) I am mapping the page and it cannot get unmapped concurrently due
       to the PT lock (which implies mapcount > 0, refcount > 0). Is this
       reference I am holding is in fact the only reference to
       the page (refcount == 1, implying mapcount == 1)? Then I am
       the exclusive owner and can reuse.

Note that we don't have to perform any mapcount checks, because it's 
implied by pur page table mapping and the refcount.

What I want to achieve is the same for PTE-mapped THP, without scanning 
page tables to detect if I am holding all references to the folio. That is:

(1) total_mapcount() == refcount AND
(2) I am responsible for all these mappings AND
(3) Subpages cannot get unmapped / shared concurrently

To make that work reliable, we might need some synchronization, 
especially when multiple page tables are involved.

I previously raised tracking the "creator" of the anon page. I think we 
can do better, but still have to prototype it.

[...]

>>
>> While it's better than what we have right now:
>>
>> (a) It's racy. Well, it's always been racy with concurrent (un)mapping
>>      and splitting. But maybe we can do better.
>>
>> (b) folio_total_mapcount() is currently expensive.
>>
>> (c) there are still false negatives even without races.
>>
>>
>> For anon pages, we could scan all subpages and test if they are PageAnonExclusive, but it's also not really what we want to do here.
> I was wondering whether we could identify the cases as:
>    - bold estimated mapcount is enough. In this case, we can use
>      current folio_estimated_sharers() for now. For long term, I
>      am with Zi Yan's proposal:  maintain total_mapcount and just use
>      total_mapcount > folio_nr_pages() as estimated number.
> 
>      The madvise/migration cases are identified as this type.
> 
>    - Need some level accurate. Use estimated mapcount to filter out obvious
>      shared case first as estimated mapcount is correct for shared case.
>      Then use some heavy operations (check anon folio if pages are
>      PageAnonExclusive or use pvmw) to get more accurate number.
> 
>      Cow is identified as this type.

I want to tackle both (at least for anon pages) using the same 
mechanism. Especially, to cover the case "total_mapcount <= 
folio_nr_pages()". For total_mapcount > folio_nr_pages(), it's easy.

In any case, we want an atomic total mapcount I think.

> 
>>
>>
>> I have some idea to handle anon pages better to avoid any page table walk or subpage scan, improving (a), (b) and (c). It might work for pagecache pages with some more work, but it's a bit more complicated with the scheme I have in mind).
>>
> Great.
> 
>>
>> First step would be replacing folio->_nr_pages_mapped by folio->_total_mapcount. While we could eventually have folio->_total_mapcount in addition to folio->_nr_pages_mapped, I'm, not sure if we want to go down that path
>>
> I saw Zi Yan shared same proposal.
> 
>>
>> That would make folio_total_mapcount() extremely fast (I'm working on a prototype). The downsides are that
>>
>> (a) We have to make NR_ANON_MAPPED/NR_FILE_MAPPED accounting less precise. Easiest way to handle it: as soon as a single subpage is mapped, account the whole folio as mapped. After all, it's consuming memory, so who cares?
>>
>> (b) We have to find a different way to decide when to put an anonymous folio on the deferred split queue in page_remove_rmap(). Some cases are nasty to handle: PTE-mapped THP that are shared between a parent and a child.
>>
> It's nasty because partial mapped to parent and partial mapped to child? Thanks.

I thought about this a lot already, but let me dedicate some time here 
to write it down. There are two scenarios to consider: do we still want 
to use the subpage mapcount or not.

When still considering the subpage mapcount, it gets easier.


(1) We're unmapping a single subpage, the compound_mapcount == 0
     and the total_mapcount > 0. If the subpage mapcount is now 0, add it
     to the deferred split queue.

(2) We're unmapping a complete folio (PMD mapping / compound), the
     compound_mapcount is 0 and the total_mapcount > 0.

  (a) If total mapcount < folio_nr_pages, add it
      to the deferred split queue.

  (b) If total mapcount >= folio_nr_pages , we have to scan all subpage
      mapcounts. If any subpage mapcount == 0, add it to the deferred
      split queue.


(b) is a bit nasty. It would happen when we fork() with a PMD-mapped 
THP, the parent splits the THP due to COW, and then our child unmaps or 
splits the PMD-mapped THP (unmap easily happening during exec()). 
Fortunately, we'd only scan once when unmapping the PMD.


Getting rid of the subpage mapcount usage in (1) would mean that we have 
to do exactly what we do in (2). But then we'd need to ha handle (2) (B) 
differently as well.

So, for 2 (b) we would either need some other heuristic, or we add it to 
the deferred split queue more frequently and let that one detect using 
an rmap walk "well, every subpage is still mapped, let's abort the split".

-- 
Cheers,

David / dhildenb

