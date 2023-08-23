Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEADB785C14
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbjHWP1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbjHWP1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946ECCC7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692804405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4UI7Ho540jlH4rUXPCi14mhF5Zm1AtUOA4NGPCV7qRs=;
        b=Th9bea/BfclaKj5qL6IMuQvWFBNlNmGd+bANUTZ373YglRjU3Sym4+kUrgCmK17Q/QkHfN
        rnt0yDWOONxpzFGbQcedjsFSeoHzUNcfpxru+cgAeKNzHDHlgl7aw1xl28zQFPsId7rhgV
        9imLb+FnOMDtI6lwjJV7yrf4LbuFwvw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-8ook5nenOQ-1MUJoTU3JNg-1; Wed, 23 Aug 2023 11:26:44 -0400
X-MC-Unique: 8ook5nenOQ-1MUJoTU3JNg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fee34b0eb8so30084565e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804403; x=1693409203;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UI7Ho540jlH4rUXPCi14mhF5Zm1AtUOA4NGPCV7qRs=;
        b=CzdSaKKuw6k7jf6e+6TzCSzuRekpnUz+ZGC/6qUQwzig/Ilm5sW3vlt+AJ30qBNyOp
         JiN+cLxt4dajHuBykxA03OlUUiUVjid7WYXSW7flcdMc8KXy/fQ8QKUy9Lzu1DvHsHY+
         5XcESSE7oLG0kJ/SVBhLDpGecmp30JWdK8WgA2x3NWdtUKqeIpV482Nb/qJzr5A+SJ0x
         XcCe+5m2LVJp39HRwYHRZhOry1pG6rLxFPGsMpkzJhLhWhI0hiM2QJ81zuozpXZZU1ri
         k0SnkwKiZa7uEasKZ77YYOdjeT8nH8Y7qTa+COt8EBYPWVd3+bhOLcFvbO9vIrIRPehK
         0SdA==
X-Gm-Message-State: AOJu0Yy7NMxSAfaZVjQZ46mYp2Pe9R95EgjSrMV5YOzK9+1NBMTVW+Yp
        qUWcJHbvvlsc2lHb9RMJr61+5BclIozyMcm+kPhaMehtIqR78ejvdvhAW2B0fa5E9EuOrD6lvxm
        xw7cW+oo8u1tw/sKBwdDtwNuX
X-Received: by 2002:a05:6000:9:b0:319:8d94:c245 with SMTP id h9-20020a056000000900b003198d94c245mr10178800wrx.69.1692804403202;
        Wed, 23 Aug 2023 08:26:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCOvETovhlYYrILujcJE2Q9Ex1e0QwKZySp+1RFtrq2eD3vfEzX6s4PxKdnt5D2cAAlx+gpQ==
X-Received: by 2002:a05:6000:9:b0:319:8d94:c245 with SMTP id h9-20020a056000000900b003198d94c245mr10178776wrx.69.1692804402720;
        Wed, 23 Aug 2023 08:26:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:e700:4d5c:81e2:253e:e397? (p200300cbc70ce7004d5c81e2253ee397.dip0.t-ipconnect.de. [2003:cb:c70c:e700:4d5c:81e2:253e:e397])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d6247000000b00317f29ad113sm19470345wrv.32.2023.08.23.08.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 08:26:42 -0700 (PDT)
Message-ID: <ab9f4179-fb40-c920-ccb5-42c111012b15@redhat.com>
Date:   Wed, 23 Aug 2023 17:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mm-unstable v1 1/4] mm/swap: stop using page->private on
 tail pages for THP_SWAP
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
References: <20230821160849.531668-1-david@redhat.com>
 <20230821160849.531668-2-david@redhat.com>
 <CAJD7tkYbHUVbg8LexkBsC9rLFBRrBSQYgOZ1tPKTDGEcWrAghQ@mail.gmail.com>
 <b00e2d3a-8601-924c-241c-4373b9dea0cb@redhat.com>
 <CAJD7tkbjPdk8xSGJG_BGaiNyPdh0-A58vwt7TwjsB4Mjh6RscA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJD7tkbjPdk8xSGJG_BGaiNyPdh0-A58vwt7TwjsB4Mjh6RscA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.23 17:21, Yosry Ahmed wrote:
> On Wed, Aug 23, 2023 at 8:17 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 23.08.23 17:12, Yosry Ahmed wrote:
>>> On Mon, Aug 21, 2023 at 9:09 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> Let's stop using page->private on tail pages, making it possible to
>>>> just unconditionally reuse that field in the tail pages of large folios.
>>>>
>>>> The remaining usage of the private field for THP_SWAP is in the THP
>>>> splitting code (mm/huge_memory.c), that we'll handle separately later.
>>>>
>>>> Update the THP_SWAP documentation and sanity checks in mm_types.h and
>>>> __split_huge_page_tail().
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>> The mm part looks good to me (with the added fixup):
>>>
>>> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>>
>> Thanks!
>>
>>>>    /**
>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>> index bb5adc604144..84fe0e94f5cd 100644
>>>> --- a/include/linux/swap.h
>>>> +++ b/include/linux/swap.h
>>>> @@ -339,6 +339,15 @@ static inline swp_entry_t folio_swap_entry(struct folio *folio)
>>>>           return entry;
>>>>    }
>>>>
>>>> +static inline swp_entry_t page_swap_entry(struct page *page)
>>>> +{
>>>> +       struct folio *folio = page_folio(page);
>>>> +       swp_entry_t entry = folio_swap_entry(folio);
>>>> +
>>>> +       entry.val += page - &folio->page;
>>>> +       return entry;
>>>> +}
>>>> +
>>>>    static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
>>>>    {
>>>>           folio->private = (void *)entry.val;
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index cc2f65f8cc62..c04702ae71d2 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2446,18 +2446,15 @@ static void __split_huge_page_tail(struct page *head, int tail,
>>>>           page_tail->index = head->index + tail;
>>>>
>>>>           /*
>>>> -        * page->private should not be set in tail pages with the exception
>>>> -        * of swap cache pages that store the swp_entry_t in tail pages.
>>>> -        * Fix up and warn once if private is unexpectedly set.
>>>> -        *
>>>> -        * What of 32-bit systems, on which folio->_pincount overlays
>>>> -        * head[1].private?  No problem: THP_SWAP is not enabled on 32-bit, and
>>>> -        * pincount must be 0 for folio_ref_freeze() to have succeeded.
>>>> +        * page->private should not be set in tail pages. Fix up and warn once
>>>> +        * if private is unexpectedly set.
>>>>            */
>>>> -       if (!folio_test_swapcache(page_folio(head))) {
>>>> -               VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, page_tail);
>>>> +       if (unlikely(page_tail->private)) {
>>>> +               VM_WARN_ON_ONCE_PAGE(true, page_tail);
>>>>                   page_tail->private = 0;
>>>>           }
>>>
>>> Could probably save a couple of lines here:
>>>
>>> if (VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, page_tail))
>>>
>>>          page_tail->private = 0;
>>>
>>
>> That would mean that we eventually compile out the runtime check
>>
>> #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
> 
> I thought the warning would be compiled out but not the check, my bad.

I even remembered that VM_WARN_ON_ONCE and friends could/should not be
used in conditionals.

But we do seem to have two users now:

  $ git grep "if (VM_WARN_ON"
mm/mmap.c:              if (VM_WARN_ON_ONCE_MM(vma->vm_end != vmi_end, mm))
mm/mmap.c:              if (VM_WARN_ON_ONCE_MM(vma->vm_start != vmi_start, mm))

But they only do warning-related action, to dump the stack, the vma, ...

So if the warnings get compiled out, also all the other stuff gets compiled out as well,
which makes sense here.

-- 
Cheers,

David / dhildenb

