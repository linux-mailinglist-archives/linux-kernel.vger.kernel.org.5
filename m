Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC52E77686F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjHITSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHITSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE926B1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vP7trY6UjzQ/nSDjPzqV0b/9egqHQIgzSwV3d83W41k=;
        b=eEv4iBFJsfSJ5r+iqZRT1ocfq2hX/vcgMq89kkEdffNo3k6of3YrOiPyueDxvWpjLEVWTk
        bHFDc16Y7n32ki/p3wbM27OqMXYi0QkjRITjI7Gp+K/4waAKbN7z4S06/yifoYvHSnJIlm
        Fun/Y8blnGCMBnA0Y1X3REWBelJ2Q7E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-MjvsiHmbMrCxuq6Nk8n22Q-1; Wed, 09 Aug 2023 15:17:35 -0400
X-MC-Unique: MjvsiHmbMrCxuq6Nk8n22Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbdf341934so654315e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608654; x=1692213454;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vP7trY6UjzQ/nSDjPzqV0b/9egqHQIgzSwV3d83W41k=;
        b=R04IdN0KKZ2x3tfRyfAjSBIBAAmeSIxsI1UuQrGMo4eGAbP98jL0Ie05UU3jW3UJU3
         II5Uq+1ccBUA0Kgrbh1AHnzI1dkdwAAYwM/t+c0sSBq1s8XoAAEZLoXtfgbGj+/7VziS
         zpcuhTXJ88+vmVDIFTq0/G1qI/15Oa19nH/nzu0U8dtvmNUKywXR/xbdCJGtzrau/Y/y
         /KBPug56ZRcZQlmBc/pIU4SvQH2o5qsWZZ57Zx60RTGd4sRCVvIrmRBA4maNIOeoo13l
         XLIgzidAVKngeE4MAJHoE/OCoGc4gQQp+Ya3OrXmmGFqi87PUyewoOyZEWAYbgByQA1X
         p7wA==
X-Gm-Message-State: AOJu0YzYBC8mWITRk+HTMoHwfmhpvIn0vcZBYJdeSnQHnabUXcT0OdQH
        o16vgaOY3A7d1OxDnvDENKBu+P1+40BTYYoWXx3qI3H+zD22JDNOywHBnrxHtLh7KcVmaBUZ0S/
        HuOImCUjS2XaCFb8bIVzhtav1
X-Received: by 2002:a7b:ce88:0:b0:3fe:1deb:86 with SMTP id q8-20020a7bce88000000b003fe1deb0086mr50996wmj.28.1691608653947;
        Wed, 09 Aug 2023 12:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCxDqts0CmhqrwLmrMtleFWF2PhsEkZ7JxUEb8gf0izo63cH/p0Wr8KfJ4AI/Ke9wrCOW2uQ==
X-Received: by 2002:a7b:ce88:0:b0:3fe:1deb:86 with SMTP id q8-20020a7bce88000000b003fe1deb0086mr50976wmj.28.1691608653526;
        Wed, 09 Aug 2023 12:17:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:6800:9933:28db:f83a:ef5? (p200300cbc70e6800993328dbf83a0ef5.dip0.t-ipconnect.de. [2003:cb:c70e:6800:9933:28db:f83a:ef5])
        by smtp.gmail.com with ESMTPSA id a14-20020adfed0e000000b003177f57e79esm17588407wro.88.2023.08.09.12.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 12:17:32 -0700 (PDT)
Message-ID: <60b5b2a2-1d1d-661c-d61e-855178fff44d@redhat.com>
Date:   Wed, 9 Aug 2023 21:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com>
 <181fcc79-b1c6-412f-9ca1-d1f21ef33e32@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
In-Reply-To: <181fcc79-b1c6-412f-9ca1-d1f21ef33e32@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.23 21:07, Ryan Roberts wrote:
> On 09/08/2023 09:32, David Hildenbrand wrote:
>> Let's track the total mapcount for all large folios in the first subpage.
>>
>> The total mapcount is what we actually want to know in folio_mapcount()
>> and it is also sufficient for implementing folio_mapped(). This also
>> gets rid of any "raceiness" concerns as expressed in
>> folio_total_mapcount().
>>
>> With sub-PMD THP becoming more important and things looking promising
>> that we will soon get support for such anon THP, we want to avoid looping
>> over all pages of a folio just to calculate the total mapcount. Further,
>> we may soon want to use the total mapcount in other context more
>> frequently, so prepare for reading it efficiently and atomically.
>>
>> Make room for the total mapcount in page[1] of the folio by moving
>> _nr_pages_mapped to page[2] of the folio: it is not applicable to hugetlb
>> -- and with the total mapcount in place probably also not desirable even
>> if PMD-mappable hugetlb pages could get PTE-mapped at some point -- so we
>> can overlay the hugetlb fields.
>>
>> Note that we currently don't expect any order-1 compound pages / THP in
>> rmap code, and that such support is not planned. If ever desired, we could
>> move the compound mapcount to another page, because it only applies to
>> PMD-mappable folios that are definitely larger. Let's avoid consuming
>> more space elsewhere for now -- we might need more space for a different
>> purpose in some subpages soon.
>>
>> Maintain the total mapcount also for hugetlb pages. Use the total mapcount
>> to implement folio_mapcount(), total_mapcount(), folio_mapped() and
>> page_mapped().
>>
>> We can now get rid of folio_total_mapcount() and
>> folio_large_is_mapped(), by just inlining reading of the total mapcount.
>>
>> _nr_pages_mapped is now only used in rmap code, so not accidentially
>> externally where it might be used on arbitrary order-1 pages. The remaining
>> usage is:
>>
>> (1) Detect how to adjust stats: NR_ANON_MAPPED and NR_FILE_MAPPED
>>   -> If we would account the total folio as mapped when mapping a
>>      page (based on the total mapcount), we could remove that usage.
>>
>> (2) Detect when to add a folio to the deferred split queue
>>   -> If we would apply a different heuristic, or scan using the rmap on
>>      the memory reclaim path for partially mapped anon folios to
>>      split them, we could remove that usage as well.
>>
>> So maybe, we can simplify things in the future and remove
>> _nr_pages_mapped. For now, leave these things as they are, they need more
>> thought. Hugh really did a nice job implementing that precise tracking
>> after all.
>>
>> Note: Not adding order-1 sanity checks to the file_rmap functions for
>>        now. For anon pages, they are certainly not required right now.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Other than the nits and query on zeroing _total_mapcount below, LGTM. If zeroing
> is correct:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks for the review!

[...]

>>   
>>   static inline int total_mapcount(struct page *page)
> 
> nit: couldn't total_mapcount() just be implemented as a wrapper around
> folio_mapcount()? What's the benefit of PageCompound() check instead of just
> getting the folio and checking if it's large? i.e:

Good point, let me take a look tomorrow if the compiler can optimize in 
both cases equally well.

[...]

>>   
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 5f498e8025cc..6a614c559ccf 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1479,7 +1479,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>>   	struct page *p;
>>   
>>   	atomic_set(&folio->_entire_mapcount, 0);
>> -	atomic_set(&folio->_nr_pages_mapped, 0);
>> +	atomic_set(&folio->_total_mapcount, 0);
> 
> Just checking this is definitely what you intended? _total_mapcount is -1 when
> it means "no pages mapped", so 0 means 1 page mapped?

I was blindly doing what _entire_mapcount is doing: zeroing out the 
values. ;)

But let's look into the details: in __destroy_compound_gigantic_folio(), 
we're manually dissolving the whole compound page. So instead of 
actually returning a compound page to the buddy (where we would make 
sure the mapcounts are -1, to then zero them out !), we simply zero-out 
the fields we use and then dissolve the compound page: to be left with a 
bunch of order-0 pages where the memmap is in a clean state.

(the buddy doesn't handle that page order, so we have to do things 
manually to get to order-0 pages we can reuse or free)

-- 
Cheers,

David / dhildenb

