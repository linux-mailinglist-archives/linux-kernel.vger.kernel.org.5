Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED517FC2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345286AbjK1Rmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbjK1Rms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:42:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E44E10EC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701193373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=SAr5QDfBjoYNxgnqiGi0DG773ECEaxrZ0Actkz0JUII=;
        b=EmIGZCMmoIDUULxsrtb+ec6Y5UguipD1JO2Fg/VbF4OSu9TrFdWvUcYqFQifwtgSCegywv
        lawIgaUVxy13gkaAP713x91UHWWfQ4Tydyn9U/EZEwwLwo4mTYioI0AE8nwNUXbvUTwALJ
        9gpy2EphRtjf4GszjLq9sVq0rC9v2Vw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-NJNdVy1cPRS-5cLhZIGj4Q-1; Tue, 28 Nov 2023 12:42:51 -0500
X-MC-Unique: NJNdVy1cPRS-5cLhZIGj4Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332f5ff511aso2655188f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701193366; x=1701798166;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAr5QDfBjoYNxgnqiGi0DG773ECEaxrZ0Actkz0JUII=;
        b=pSe40GzW2wb7F+KEZZdWpCrKEDTz7VQytba2uTYcbQErNOCdL3DKyUquh3CtK2cs5W
         FDYHMixGf/vPBreZJUBUQTfHmdTOYGC8cFus29hDHNDRNsL5H30/eZ4hJXOiqOIwTRSQ
         rAkctdKjyv4cJRuJfx78OKQme9i2uIxme4v9/cXc2X41bx95L/Z17MhqFgEWleXSsz8N
         tFNb1hxmK9B4nHA2kPy61GTXsQ7YiW1w5XIjiuSnrgrGoTy/SMyuRx29ppvR3r1k42wG
         UDcR4y3yXEnW1P5H9Vi2FQovdiVqX1bjJPxZlxa7g9tpyJTW96Zr6YwYWwoZLnh0oFL0
         3TEQ==
X-Gm-Message-State: AOJu0Yw+E8Or6IRnLPRi79X0rlY151hyyy7ZJ/XmX6woGomcJr44DmE2
        irHGiAPvGFBSxa+YGf0I5c9NbC0ATKWhdBngevhKB3Env8AT7jpvfxYmODxsyYrKf8Rn1zDklJk
        4U5J9m/xaxqY90LpgKKAzUmck
X-Received: by 2002:a05:6000:1966:b0:333:135f:a7f0 with SMTP id da6-20020a056000196600b00333135fa7f0mr792376wrb.54.1701193366571;
        Tue, 28 Nov 2023 09:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGspIGuI/kYFdgQzkVNuyzoM3eXA3AHvA/zr4XiUIQx9yzHK6ckCbknitRxD4yCoHkCf7gp2w==
X-Received: by 2002:a05:6000:1966:b0:333:135f:a7f0 with SMTP id da6-20020a056000196600b00333135fa7f0mr792362wrb.54.1701193366143;
        Tue, 28 Nov 2023 09:42:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1d00:99ec:9656:7475:678d? (p200300cbc7081d0099ec96567475678d.dip0.t-ipconnect.de. [2003:cb:c708:1d00:99ec:9656:7475:678d])
        by smtp.gmail.com with ESMTPSA id do4-20020a0560000c4400b00332f2288e2esm10265166wrb.102.2023.11.28.09.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 09:42:45 -0800 (PST)
Message-ID: <faf9ca16-ab0b-4ce9-a6e2-ea31842b213a@redhat.com>
Date:   Tue, 28 Nov 2023 18:42:44 +0100
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
 <f1b52042-646d-4679-b375-7550973701f5@redhat.com> <ZWYf0ZNF9OJgt-mt@x1n>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWYf0ZNF9OJgt-mt@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.23 18:13, Peter Xu wrote:
> On Tue, Nov 28, 2023 at 05:39:35PM +0100, David Hildenbrand wrote:
>> Quoting from the cover letter:
>>
>> "We have hugetlb special-casing/checks in the callers in all cases either
>> way already in place: it doesn't make too much sense to call generic-looking
>> functions that end up doing hugetlb specific things from hugetlb
>> special-cases."
> 
> I'll take this one as an example: I think one goal (of my understanding of
> the mm community) is to make the generic looking functions keep being
> generic, dropping any function named as "*hugetlb*" if possible one day
> within that generic implementation.  I said that in my previous reply.

Yes, and I am one of the people asking for that. However, only where it 
makes sense (e.g., like page table walking, GUP as you said), and only 
when it is actually unified.

I don't think that rmap handling or fault handling will ever be 
completely unified to that extreme, and it might also not be desirable. 
Just like we have separate paths for anon and file in areas where they 
are reasonable different.

What doesn't make sense is using patterns like:

	page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));

and then, inside page_remove_rmap() have an initial folio_test_hugetlb() 
check that does something completely different.

So each and everyone calling page_remove_rmap (and knowing that it's 
certainly not a hugetlb folio) has to run through that check.

Then, we have functions like page_add_file_rmap() that look like they 
can be used for hugetlb, but hugetlb is smart enough and only calls 
page_dup_file_rmap(), because it doesn't want to touch any file/anon 
counters. And to handle that we would have to add folio_test_hugetlb() 
inside there, which adds the same as above, trying to unify without 
unifying.

Once we're in the area of folio_add_file_rmap_range(), it all stops 
making sense, because there is no way we could possibly partially map a 
folio today. (and if we can in the future, we might still want separate 
handling, because most caller know with which pages they are dealing, below)

Last but not least, it's all inconsistent right now with 
hugetlb_add_anon_rmap()/hugetlb_add_new_anon_rmap() being there because 
they differ reasonably well from the "ordinary" counterparts.

> 
> Having that "*hugetlb*" code already in the code base may or may not be a
> good reason to further move it upward the stack.

If you see a path forward in the foreseeable future where we would have 
code that doesn't special-case hugetlb in rmap calling code already, I'd 
be interested in that.

hugetlb.c knows that it's dealing with hugetlb pages.

huge_memory.c knows that it's dealing with PMD-mapped thp.

memory.c knows that it it's dealing with PTE-mapped thp or small folios.

Only migrate.c (and e.g., try_to_unmap()) in rmap.c handle different 
types. But there is plenty of hugetlb special-casing in there that I 
don't really see going away.

> 
> Strong feelings?  No, I don't have.  I'm not knowledged enough to do so.

I'm sure you are, so I'm trusting your judgment :)

I don't think going in the other direction and e.g., removing 
hugetlb_add_anon_rmap / hugetlb_add_new_anon_rmap is making a 
unification that is not really reasonable. It will only make things 
slower and the individual functions more complicated.

-- 
Cheers,

David / dhildenb

