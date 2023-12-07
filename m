Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F89808660
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378767AbjLGLIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:08:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273D3FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701947294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=6og0oOQgUrvkdvJFDX1/HxY8FKlKo9DmlTrnuDxQJQQ=;
        b=RsHBVcHSwgMh+c6AsnQMY5AAq764hRFssa2p4RjvYh44lmMpDN6pNMn0PI2RlmuzDMvpLH
        z1aO0yS60hQeLToAduyBuwTCxEvVvr62s4Ihg7JbdGNb0cFBgOUEnvtgIzZm1DOWl3uQVU
        PkbmCVN5sL8WGyvXYhFZ4MgVQmyusfw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-pktbCIPhPNmq69FmojnmvA-1; Thu, 07 Dec 2023 06:08:13 -0500
X-MC-Unique: pktbCIPhPNmq69FmojnmvA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c299d1e36so4120465e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 03:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701947292; x=1702552092;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6og0oOQgUrvkdvJFDX1/HxY8FKlKo9DmlTrnuDxQJQQ=;
        b=umIfS8vmhqAfl3xWk1cCfq4VEcmXBTylUNuW4n1L01jiMJYHJP1CAOZKacocQH2x8u
         uVKgwi+jpweml/712LVgwjeUQ8V2K0lz8tvTzytAbXFnkfSaORaRlIhWVj0ktU3dO32f
         o6k5T6yY5iZU4cMCjuDncdYVgdfdsD/PstKNz9dk+/aF6iIZYb7IngQEsLUfjRI6NEcy
         87xQkrB8bbv2vB/o98ylrHHhi8oQTwdaTEhDxtAtBZtywaGVQjIJ9o0CjCpHaL3VX6fL
         XcQstaTalwOLugqju+yUHOSkg2fE953uMWWn16dPs73sTMRuJMncL+IPZIq1Puda/oBl
         dWOQ==
X-Gm-Message-State: AOJu0YyrJoDTMKqIYcXM35SL2TTU57OAK0zFB3flP/AWovRl0HJtrobI
        x2+41RHfUDC8kb3UhyaNB2mlPPU38bn8yUWOclsR5TA+X7BZ9WWe4dBzeoiov3o7G6E1WA3zvae
        ndjDR5TPcI8up2RN0OReKl9m+
X-Received: by 2002:a7b:c385:0:b0:40c:2325:516c with SMTP id s5-20020a7bc385000000b0040c2325516cmr835046wmj.184.1701947291848;
        Thu, 07 Dec 2023 03:08:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3R9E25IMzdvELZa+WPF59FyVjLbV8+cmaIy1ytD66FHoctOBEEdMVSiUdTM4cYP0t6P/6pA==
X-Received: by 2002:a7b:c385:0:b0:40c:2325:516c with SMTP id s5-20020a7bc385000000b0040c2325516cmr835027wmj.184.1701947291351;
        Thu, 07 Dec 2023 03:08:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:5d00:18d7:1475:24bc:2417? (p200300cbc71b5d0018d7147524bc2417.dip0.t-ipconnect.de. [2003:cb:c71b:5d00:18d7:1475:24bc:2417])
        by smtp.gmail.com with ESMTPSA id be9-20020a05600c1e8900b0040596352951sm1659510wmb.5.2023.12.07.03.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 03:08:10 -0800 (PST)
Message-ID: <ca649aad-7b76-4c6d-b513-26b3d58f8e68@redhat.com>
Date:   Thu, 7 Dec 2023 12:08:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-5-ryan.roberts@arm.com>
 <71040a8c-4ea1-4f21-8ac8-65f7c25c217e@redhat.com>
 <f2896d7f-183b-48fb-a3aa-d21bf2257043@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f2896d7f-183b-48fb-a3aa-d21bf2257043@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>
>> Nit: the orders = ... order = ... looks like this might deserve a helper
>> function that makes this easier to read.
> 
> To be honest, the existing function that I've modified is a bit of a mess.

It's all an ugly mess and I hate it.

It would be cleanest if we'd just have "thp_vma_configured_orders()" 
that gives us all configured orders for the given VMA+flags combination. 
No passing in of orders, try handling the masking in the caller.

Then, we move that nasty "transhuge_vma_suitable" handling for !in_pf 
out of there and handle that in the callers. The comment "Huge fault 
does the check in fault handlers. And this check is not suitable for 
huge PUD fault handlers." already makes me angry, what a mess.


Then, we'd have a thp_vma_fitting_orders() / thp_vma_is_fitting_order() 
function that does the filtering only based on the given address + vma 
size/alignment. That's roughly "thp_vma_suitable_orders()".


Finding a good name to combine both could be something like
"thp_vma_possible_orders()".


Would make more sense to me (but again, German guy, so it's probably all 
wrong).


> thp_vma_allowable_orders() calls thp_vma_suitable_orders() if we are not in a
> page fault, because the page fault handlers already do that check themselves. It
> would be nice to refactor the whole thing so that thp_vma_allowable_orders() is
> a strict superset of thp_vma_suitable_orders(). Then this can just call
> thp_vma_allowable_orders(). But that's going to start touching the PMD and PUD
> handlers, so prefer if we leave that for a separate patch set.
> 
>>
>> Nit: Why call thp_vma_suitable_orders if the orders are already 0? Again, some
>> helper might be reasonable where that is handled internally.
> 
> Because thp_vma_suitable_orders() will handle it safely and is inline, so it
> should just as efficient? This would go away with the refactoring described above.

Right. Won't win in a beauty contest. Some simple helper might make this 
much easier to digest.

> 
>>
>> Comment: For order-0 we'll always perform a function call to both
>> thp_vma_allowable_orders() / thp_vma_suitable_orders(). We should perform some
>> fast and efficient check if any <PMD THP are even enabled in the system / for
>> this VMA, and in that case just fallback before doing more expensive checks.
> 
> thp_vma_allowable_orders() is inline as you mentioned.
> 
> I was deliberately trying to keep all the decision logic in one place
> (thp_vma_suitable_orders) because it's already pretty complicated. But if you
> insist, how about this in the header:
> 
> static inline
> unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
> 				       unsigned long vm_flags, bool smaps,
> 				       bool in_pf, bool enforce_sysfs,
> 				       unsigned long orders)
> {
> 	/* Optimization to check if required orders are enabled early. */
> 	if (enforce_sysfs && vma_is_anonymous(vma)) {
> 		unsigned long mask = READ_ONCE(huge_anon_orders_always);
> 
> 		if (vm_flags & VM_HUGEPAGE)
> 			mask |= READ_ONCE(huge_anon_orders_madvise);
> 		if (hugepage_global_always() ||
> 			((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
> 			mask |= READ_ONCE(huge_anon_orders_inherit);
> 
> 		orders &= mask;
> 		if (!orders)
> 			return 0;
> 		
> 		enforce_sysfs = false;
> 	}
> 
> 	return __thp_vma_allowable_orders(vma, vm_flags, smaps, in_pf,
> 					  enforce_sysfs, orders);
> }
> 
> Then the above check can be removed from __thp_vma_allowable_orders() - it will
> still retain the `if (enforce_sysfs && !vma_is_anonymous(vma))` part.
> 

Better. I still kind-of hate having to pass in orders here. Such masking 
is better done in the caller (see above how it might be done when moving 
the transhuge_vma_suitable() check out).

> 
>>
>>> +
>>> +    if (!orders)
>>> +        goto fallback;
>>> +
>>> +    pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>> +    if (!pte)
>>> +        return ERR_PTR(-EAGAIN);
>>> +
>>> +    order = first_order(orders);
>>> +    while (orders) {
>>> +        addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>> +        vmf->pte = pte + pte_index(addr);
>>> +        if (pte_range_none(vmf->pte, 1 << order))
>>> +            break;
>>
>> Comment: Likely it would make sense to scan only once and determine the "largest
>> none range" around that address, having the largest suitable order in mind.
> 
> Yes, that's how I used to do it, but Yu Zhou requested simplifying to this,
> IIRC. Perhaps this an optimization opportunity for later?

Yes, definetly.

> 
>>
>>> +        order = next_order(&orders, order);
>>> +    }
>>> +
>>> +    vmf->pte = NULL;
>>
>> Nit: Can you elaborate why you are messing with vmf->pte here? A simple helper
>> variable will make this code look less magical. Unless I am missing something
>> important :)
> 
> Gahh, I used to pass the vmf to what pte_range_none() was refactored into (an
> approach that was suggested by Yu Zhou IIRC). But since I did some refactoring
> based on some comments from JohnH, I see I don't need that anymore. Agreed; it
> will be much clearer just to use a local variable. Will fix.
> 
>>
>>> +    pte_unmap(pte);
>>> +
>>> +    gfp = vma_thp_gfp_mask(vma);
>>> +
>>> +    while (orders) {
>>> +        addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>> +        folio = vma_alloc_folio(gfp, order, vma, addr, true);
>>> +        if (folio) {
>>> +            clear_huge_page(&folio->page, addr, 1 << order);
>>> +            return folio;
>>> +        }
>>> +        order = next_order(&orders, order);
>>> +    }
>>> +
>>
>> Queestion: would it make sense to combine both loops? I suspect memory
>> allocations with pte_offset_map()/kmao are problematic.
> 
> They are both operating on separate orders; next_order() is "consuming" an order
> by removing the current one from the orders bitfield and returning the next one.
> 
> So the first loop starts at the highest order and keeps checking lower orders
> until one fully fits in the VMA. And the second loop starts at the first order
> that was found to fully fits and loops to lower orders until an allocation is
> successful.

Right, but you know from the first loop which order is applicable (and 
will be fed to the second loop) and could just pte_unmap(pte) + 
tryalloc. If that fails, remap and try with the next orders.

That would make the code certainly easier to understand. That "orders" 
magic of constructing, filtering, walking is confusing :)


I might find some time today to see if there is an easy way to cleanup 
all what I spelled out above. It really is a mess. But likely that 
cleanup could be deferred (but you're touching it, so ... :) ).

-- 
Cheers,

David / dhildenb

