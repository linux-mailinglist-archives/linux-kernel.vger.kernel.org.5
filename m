Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747677FC57D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345472AbjK1Ucg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Uce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:32:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BFA1988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701203560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=RWAGPazvRyiFXU/G5AU4pPg9B+JKiecLYKQaSGKIGvk=;
        b=gjm255uLjw3CwFe8MXpf+gHM9xEg+P6wefWdAhOe7gTc88K5yRVMClI+Rpxyya7oHZ/J7j
        HqXvsLNOZpm8r4ZJnw0yYI1J4xRr2VgxemMepiy9fbIljTM10L+ExeYUo9EVfDeWwUJhMe
        v59/a7JyfAZUlgRFs/r83TOi/iP+IkA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-rE7RxmdOMYa-NE16PKWTIw-1; Tue, 28 Nov 2023 15:32:37 -0500
X-MC-Unique: rE7RxmdOMYa-NE16PKWTIw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b40234bd5so23255265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701203556; x=1701808356;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWAGPazvRyiFXU/G5AU4pPg9B+JKiecLYKQaSGKIGvk=;
        b=XIvboTbIs5LXgv7POxWApukOtFL4Z0lEmsaPmbsHPxOlcI1rwDAmvQEs4NM2nkyVs8
         iRG+6EbvCd9cts+OTFJ9OiB4Dn8Kly7QpMGUz99KYWVQ+Jhzhezu86OnDMkcreveWkaq
         ZzkmWbLMJj3c1MGaopSKHPCVsInV5oOJrArX8SIFd3V8n6D9Kb88ftBpDteGw8Cg1MjJ
         M5dd6EsGdBRS3M169alVTZ1VrhjIQ60cko+fSG36OrWerXk1YxWJ40F73xyIj8t6AHCI
         k+usIrVtAjKKQ/Jz6BD37KH1kvacf1dKYRKz++rjvxoPZ4JZRlsEPrPVqURvzRCjlApW
         F7Xg==
X-Gm-Message-State: AOJu0YwieftsM0oW6+MIY1vzFIkGD/42XA49IIo9Kr4MKXTJQkXdTlES
        vpAsGWGojYwhp54czddOj/XfhMa2G9UvQEcQqBxJjiucMoh/Mrq8e9eG6X0Xjaj7pUgxZxQbmS3
        fVOYWz9Bpafqe6p4GclVaZtNj
X-Received: by 2002:a05:600c:3104:b0:406:8496:bd8b with SMTP id g4-20020a05600c310400b004068496bd8bmr9366265wmo.9.1701203556504;
        Tue, 28 Nov 2023 12:32:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJm3krrAQ/udoXguJxuIFNtxneQPwodr3oHMCOGGSjJPZ4olMvTRebyfWLZTS7aV7zfjGBrQ==
X-Received: by 2002:a05:600c:3104:b0:406:8496:bd8b with SMTP id g4-20020a05600c310400b004068496bd8bmr9366253wmo.9.1701203556084;
        Tue, 28 Nov 2023 12:32:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1d00:99ec:9656:7475:678d? (p200300cbc7081d0099ec96567475678d.dip0.t-ipconnect.de. [2003:cb:c708:1d00:99ec:9656:7475:678d])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm19196450wmo.39.2023.11.28.12.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 12:32:35 -0800 (PST)
Message-ID: <e2fbcd1e-0b6c-4406-bdef-b0b340e6f4a9@redhat.com>
Date:   Tue, 28 Nov 2023 21:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] mm/rmap: introduce and use hugetlb_remove_rmap()
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
References: <20231128145205.215026-1-david@redhat.com>
 <20231128145205.215026-3-david@redhat.com> <ZWYQeW1dqK6xM1T9@x1n>
 <f1b52042-646d-4679-b375-7550973701f5@redhat.com> <ZWYf0ZNF9OJgt-mt@x1n>
 <faf9ca16-ab0b-4ce9-a6e2-ea31842b213a@redhat.com> <ZWZD--hbxH9Pyx-4@x1n>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWZD--hbxH9Pyx-4@x1n>
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

>> What doesn't make sense is using patterns like:
>>
>> 	page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
>>
>> and then, inside page_remove_rmap() have an initial folio_test_hugetlb()
>> check that does something completely different.
> 
> IIUC above "folio_test_hugetlb(folio)" pattern can become "false" for
> hugetlb, if we decided to do mapcount for small hugetlb mappings.  If that
> happens, I think something like this patch _may_ need to be reverted again
> more or less. Or we start to copy some of page_remove_rmap() into the new
> hugetlb rmap api.

Probably just extend it to a hugetlb rmap api if you want to do some 
batching. But who knows how that will actually look like. The 
migrate.c/rmap.c special casing for hugetlb when migrating/unmapping is 
quite severe already and this is just the tip of the iceberg.

Further, the question is if you really want to deal with subpage 
mapcounts like the !hugetlb variant does. Quite likely you don't want to 
do that if you can avoid it and just have a total mapcount.

> 
>>
>> So each and everyone calling page_remove_rmap (and knowing that it's
>> certainly not a hugetlb folio) has to run through that check.
> 
> Note that right after this change applied, hugetlb already start to lose
> something in common with generic compound folios, where page_remove_rmap()
> had:
> 
> 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
> 
> That sanity check goes away immediately for hugetlb, which is still
> logically applicable.

Why? We're passing folios that the caller already properly prepared.

A folio by definition points to the head page.

> 
>>
>> Then, we have functions like page_add_file_rmap() that look like they can be
>> used for hugetlb, but hugetlb is smart enough and only calls
>> page_dup_file_rmap(), because it doesn't want to touch any file/anon
>> counters. And to handle that we would have to add folio_test_hugetlb()
>> inside there, which adds the same as above, trying to unify without
>> unifying.
>>
>> Once we're in the area of folio_add_file_rmap_range(), it all stops making
>> sense, because there is no way we could possibly partially map a folio
>> today. (and if we can in the future, we might still want separate handling,
>> because most caller know with which pages they are dealing, below)
>>
>> Last but not least, it's all inconsistent right now with
>> hugetlb_add_anon_rmap()/hugetlb_add_new_anon_rmap() being there because they
>> differ reasonably well from the "ordinary" counterparts.
> 
> Taking hugepage_add_new_anon_rmap() as example, IMHO they still share a lot
> of things with !hugetlb codes, and maybe they can already be cleaned up
> into something common for a large mapping:
> 
> void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
> 		unsigned long address)
> {
> 	int nr;
> 
> 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> 
>          if (folio_is_hugetlb(folio)) {
>                  folio_clear_hugetlb_restore_reserve(folio);
>          } else {
>                  __folio_set_swapbacked(folio);
> 		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
> 		nr = folio_nr_pages(folio);
> 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>                  __lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
>          }
> 
>          /* increment count (starts at -1) */
>          atomic_set(&folio->_entire_mapcount, 0);
> 	__folio_set_anon(folio, vma, address, true);
> 	SetPageAnonExclusive(&folio->page);
> }

Note that function is about to be extended to be more !hugetlb like in 
Ryans work (smaller THP).

> 
> For folio_add_file_rmap_range(): would it work if it just pass the hugetlb
> folio range into it?  Would that make it much more difficult with the
> recent work on large folios from you or anyone?

Sure we can, that doesn't mean that it's a good interface for hugetlb 
that doesn't support ranges right now and maybe never will. :)

> 
>> I don't think going in the other direction and e.g., removing
>> hugetlb_add_anon_rmap / hugetlb_add_new_anon_rmap is making a unification
>> that is not really reasonable. It will only make things slower and the
>> individual functions more complicated.
> 
> IIUC so far the performance difference should be minimum on which helper to
> use.

I've learned that even the likely in "if (likely(compound))" matters in 
some rmap function.

So I'm still against effectively adding more folio_is_hugetlb() checks 
on hot code paths for the sake of "unification" that I don't really see 
as "unification".

> 
> As I mentioned, I sincerely don't know whether this patch is good or not as
> I don't know enough on everything around that is happening.  It's just that
> I'll still think twice if to create hugetlb its own rmap API, because from
> the high level it's going the other way round to me.  So I still want to
> raise this as a pure question.

I consider the end result here easier to read and easier to extend. If 
there are good reasons to go the different way, I'm all ears.

-- 
Cheers,

David / dhildenb

