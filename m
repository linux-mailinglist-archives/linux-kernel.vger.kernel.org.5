Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7617FC240
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbjK1Qjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjK1Qjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:39:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE88D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701189581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=q1jB4RVXxVVTLsFdPQcHPWyCB55F72GQ+BZr9q/xXCc=;
        b=HQb0xAD6WZiqyT1FYoctpfUEp5xhD/0tzeDfAtvM8Pt0v6fGxXBe2COXTAJWTOnSGqKR+r
        /WqCqVu8VZffY6491nJwdIBsHXOjvq8M46gdTjSIaqOxXz1XfIdqOsHEoalJT9s1ivzqr3
        yi4DGgOn06KgoOJX5RDcU8b+z9k6y8U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ye-4Cs-yMwm5eiVOej0Osw-1; Tue, 28 Nov 2023 11:39:38 -0500
X-MC-Unique: ye-4Cs-yMwm5eiVOej0Osw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b296a4450so32895415e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189578; x=1701794378;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1jB4RVXxVVTLsFdPQcHPWyCB55F72GQ+BZr9q/xXCc=;
        b=A03B4TqQyEuvKrpKFT/Umd5IdT4VcoMbXJknSlmImSjxWn4upUr9mntOujHTjPxzx+
         5lN/rCKpSCMFADgfzzozZmMpb2DL3RhZSPMdkjxS756Bnb+VjguIoBYYEV1q5iZ6qpqv
         2KPQq6fyJGA2AE9YrMh6yAw9EjAfFKa9AqCCzU8ML2PrlKNQ9QMO+BdPXRZeSXCulQfv
         MncOlyGlENODeVZuUIxXvELyu2f64GAiKl0FZddYOjKx1gbLYv0NKEH1eivDN2kjIlDM
         vJZ7ospgzqDt/8YW/1LkkuzxxCu9rhDUnzxGNWYNIE6cCr9YaHhNEijyfT/Q7heNutor
         4ekg==
X-Gm-Message-State: AOJu0YzYDLP9I+PDeli5v4hppxv1HzacELz7rXOjBYkcPhuXpd3PZ0C4
        0NkrS0EpNXyhUn7GRBQiqrVPlzPRCM4a9xgZ1vYqcxoFgV9PGjdzHCHckv0HheegQyFBhZv+d+q
        eMjiSHZbx1rG/RO+n3RtX2931
X-Received: by 2002:a05:600c:45c6:b0:40b:37f2:95b6 with SMTP id s6-20020a05600c45c600b0040b37f295b6mr12138061wmo.0.1701189577758;
        Tue, 28 Nov 2023 08:39:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnDb//LFkh4avxdiYNErHdqNEds8FYFfN+DB77BgOaSJMAUp17ceUNnFt08FeNplEv+t63cw==
X-Received: by 2002:a05:600c:45c6:b0:40b:37f2:95b6 with SMTP id s6-20020a05600c45c600b0040b37f295b6mr12138040wmo.0.1701189577179;
        Tue, 28 Nov 2023 08:39:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1d00:99ec:9656:7475:678d? (p200300cbc7081d0099ec96567475678d.dip0.t-ipconnect.de. [2003:cb:c708:1d00:99ec:9656:7475:678d])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c475500b0040b2976eb02sm17948819wmo.10.2023.11.28.08.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 08:39:36 -0800 (PST)
Message-ID: <f1b52042-646d-4679-b375-7550973701f5@redhat.com>
Date:   Tue, 28 Nov 2023 17:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] mm/rmap: introduce and use hugetlb_remove_rmap()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
References: <20231128145205.215026-1-david@redhat.com>
 <20231128145205.215026-3-david@redhat.com> <ZWYQeW1dqK6xM1T9@x1n>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWYQeW1dqK6xM1T9@x1n>
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

On 28.11.23 17:08, Peter Xu wrote:
> On Tue, Nov 28, 2023 at 03:52:02PM +0100, David Hildenbrand wrote:
>> hugetlb rmap handling differs quite a lot from "ordinary" rmap code. We
>> don't want this hugetlb special-casing in the rmap functions, as
>> we're special casing the callers already. Let's simply use a separate
>> function for hugetlb.
> 
> We were special casing some, not all..
> 
> And IIUC the suggestion from the community is we reduce that "special
> casing", instead of adding more?  To be explicit below..

Quoting from the cover letter:

"We have hugetlb special-casing/checks in the callers in all cases 
either way already in place: it doesn't make too much sense to call 
generic-looking functions that end up doing hugetlb specific things from 
hugetlb special-cases."

[...]

>> +++ b/mm/rmap.c
>> @@ -1440,13 +1440,6 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
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
> Fundamentally in the ideal world when hugetlb can be merged into generic
> mm, I'd imagine that as dropping here, meanwhile...
> 

Quoting from the cover letter:

"If ever something about hugetlb changes that makes them actually
partially-mappable folios, we can look into cleanly merging all code
paths, not just some."

>> -
>>   	/* Is page being unmapped by PTE? Is this its last map to be removed? */
>>   	if (likely(!compound)) {
>>   		last = atomic_add_negative(-1, &page->_mapcount);
>> @@ -1804,7 +1797,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   			dec_mm_counter(mm, mm_counter_file(&folio->page));
>>   		}
>>   discard:
>> -		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
>> +		if (unlikely(folio_test_hugetlb(folio)))
>> +			hugetlb_remove_rmap(folio);
>> +		else
>> +			page_remove_rmap(subpage, vma, false);
> 
> ... rather than moving hugetlb_* handlings even upper the stack, we should
> hopefully be able to keep this one as a generic api.
> 
> I worry this patch is adding more hugetlb-specific paths even onto higher
> call stacks so it's harder to generalize, going the other way round to what
> we wanted per previous discussions.
> 
> Said that, indeed I read mostly nothing yet with the recent rmap patches,
> so I may miss some important goal here.

Quoting from the cover letter:

"This is a stanalone cleanup, but it gets more relevant when adding more
rmap batching (we cannot map parts of a hugetlb folio) or changing the 
way we handle partially-mappable folios as in [1], whereby we'd have to 
add more hugetlb special casing to keep hugetlb working as is."


Thanks for the review. If you have strong feelings, please add an 
explicit nack. Otherwise, I'll move forward with this.

-- 
Cheers,

David / dhildenb

