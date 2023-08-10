Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB501777F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjHJRs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjHJRs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B72705
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691689660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oU7y2MwySKI8Jyjp8rHjmRFDUK7yH9mFWODVue0LC6k=;
        b=ZN/rjBj/Hit43tVEO90+JM1QkGd+mcOqBOqoXm5wKQme+8ozvTYh+tL7CXzqWza1klpLRR
        CHdTVNpIvcpkCntwgi5c7vLvfZ6eDFv6tjpthFY/XBQEWtmbgfFfuNg82oZjYOQA4LMO1M
        Pa8op8rGGNuHSfbwgcEzCqWlDaDXXoc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-pVnTTF_-Mz2gfmrJVt5y-g-1; Thu, 10 Aug 2023 13:47:38 -0400
X-MC-Unique: pVnTTF_-Mz2gfmrJVt5y-g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3175b757bbfso720848f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689657; x=1692294457;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oU7y2MwySKI8Jyjp8rHjmRFDUK7yH9mFWODVue0LC6k=;
        b=F7faJsjZ21lLlQuAh9QQLESEPJak+XBuTqKYB4IsSPLu9am/wbWI2cMk5tWRWnxf14
         iSOPLkMCMt4AnLOl0wxGY4u1Yh9bqqEdk7xfeVH/gzKFOLAsYPYPND/HStAMhGmi7vbD
         JZ/Bojmle2kkKZ8QWN3zSH4WvE+FnpuzoLAeoJjAy7NbV4xVM5O/TaGtkTWg9Ius2TAB
         /fXrg6mTK9u0KBgqTrg9jBQWYim+P06yXavHvuBYjqqetPb2j3oGyJMkUodhny0EqRvl
         Ea94HpVpXgBhGrhYEMIa/YN0yQYmaDxjPlwSDgD/x3/uCR0qMFpxNXAMWF79mIOPZdfA
         IM0A==
X-Gm-Message-State: AOJu0YxgiG2+CG/diSfhnT2vu84yCXijup9OXKhO0vqP7/jLLvxe2pq/
        h9llVF5z/LJqfOzHPgypV4Bf6TsBoHvXdai8JtzipM205U5dB2zcXwrYH7rtD63j4bkR8j1Gtlc
        QgfnSq1+yEWNVuGJpIMsAlSfc
X-Received: by 2002:a05:6000:1010:b0:317:5ed6:887 with SMTP id a16-20020a056000101000b003175ed60887mr2589676wrx.66.1691689656983;
        Thu, 10 Aug 2023 10:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd5a43eooBSZBw90DEpfdZTNsoD/ddgvcTiFpWbNXO7eJpBo5l/9LyJ4ZEFkBQfsQWoHPcFg==
X-Received: by 2002:a05:6000:1010:b0:317:5ed6:887 with SMTP id a16-20020a056000101000b003175ed60887mr2589655wrx.66.1691689656528;
        Thu, 10 Aug 2023 10:47:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:8a00:8200:f041:4b87:a8be? (p200300cbc71a8a008200f0414b87a8be.dip0.t-ipconnect.de. [2003:cb:c71a:8a00:8200:f041:4b87:a8be])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003fe2120ad0bsm5663845wmc.41.2023.08.10.10.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 10:47:36 -0700 (PDT)
Message-ID: <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com>
Date:   Thu, 10 Aug 2023 19:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com> <ZNQD4pxo8svpGmvX@x1n>
 <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
 <155bd03e-b75c-4d2d-a89d-a12271ada71b@arm.com> <ZNUbNDiciFefJngZ@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
In-Reply-To: <ZNUbNDiciFefJngZ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.23 19:15, Peter Xu wrote:
> On Thu, Aug 10, 2023 at 11:48:27AM +0100, Ryan Roberts wrote:
>>> For PTE-mapped THP, it might be a bit bigger noise, although I doubt it is
>>> really significant (judging from my experience on managing PageAnonExclusive
>>> using set_bit/test_bit/clear_bit when (un)mapping anon pages).
>>>
>>> As folio_add_file_rmap_range() indicates, for PTE-mapped THPs we should be
>>> batching where possible (and Ryan is working on some more rmap batching).
>>
>> Yes, I've just posted [1] which batches the rmap removal. That would allow you
>> to convert the per-page atomic_dec() into a (usually) single per-large-folio
>> atomic_sub().
>>
>> [1] https://lore.kernel.org/linux-mm/20230810103332.3062143-1-ryan.roberts@arm.com/
> 
> Right, that'll definitely make more sense, thanks for the link; I'd be very
> happy to read more later (finally I got some free time recently..).  But
> then does it mean David's patch can be attached at the end instead of
> proposed separately and early?

Not in my opinion. Batching rmap makes sense even without this change, 
and this change makes sense even without batching.

> 
> I was asking mostly because I read it as a standalone patch first, and
> honestly I don't know the effect.  It's based on not only the added atomic
> ops itself, but also the field changes.
> 
> For example, this patch moves Hugh's _nr_pages_mapped into the 2nd tail
> page, I think it means for any rmap change of any small page of a huge one
> we'll need to start touching one more 64B cacheline on x86.  I really have
> no idea what does it mean for especially a large SMP: see 292648ac5cf1 on
> why I had an impression of that.  But I've no enough experience or clue to
> prove it a problem either, maybe would be interesting to measure the time
> needed for some pte-mapped loops?  E.g., something like faulting in a thp,

Okay, so your speculation right now is:

1) The change in cacheline might be problematic.

2) The additional atomic operation might be problematic.

> then measure the split (by e.g. mprotect() at offset 1M on a 4K?) time it
> takes before/after this patch.

I can certainly try getting some numbers on that. If you're aware of 
other micro-benchmarks that would likely notice slower pte-mapping of 
THPs, please let me know.

> 
> When looking at this, I actually found one thing that is slightly
> confusing, not directly relevant to your patch, but regarding the reuse of
> tail page 1 on offset 24 bytes.  Current it's Hugh's _nr_pages_mapped,
> and you're proposing to replace it with the total mapcount:
> 
>          atomic_t   _nr_pages_mapped;     /*    88     4 */
> 
> Now my question is.. isn't byte 24 of tail page 1 used for keeping a
> poisoned mapping?  See prep_compound_tail() where it has:
> 
> 	p->mapping = TAIL_MAPPING;
> 
> While here mapping is, afaict, also using offset 24 of the tail page 1:
> 
>          struct address_space * mapping;  /*    24     8 */
> 
> I hope I did a wrong math somewhere, though.
> 

I think your math is correct.

prep_compound_head() is called after prep_compound_tail(), so 
prep_compound_head() wins.

In __split_huge_page_tail() there is a VM_BUG_ON_PAGE() that explains 
the situation:

/* ->mapping in first and second tail page is replaced by other uses */
VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
	       page_tail);

Thanks for raising that, I had to look into that myself.

-- 
Cheers,

David / dhildenb

