Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935847F7A73
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjKXReQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:34:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76070A4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700847259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Ic/JwA3DthdDpe7smn+uf/VWJeAGFkAVcH5nMn2kqTE=;
        b=fZjp+g/0BeJJeKcfFsTXYQiDWvtyuT6PrgkjXcbx2OtsoZa7YPcR+VvTpmIy0QbWWezB+G
        SW2+LZEreauPLPVqgVMA8RZSnfTpWqO+29Xqdd5iFTaNTKOmH4K8OQQWL44hYG+c9n7fe/
        nRg4awv+FBmMwp6FvEk02cGR4qMl9ow=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-JEjuSgGlP2eOrWtD7gPv2A-1; Fri, 24 Nov 2023 12:34:18 -0500
X-MC-Unique: JEjuSgGlP2eOrWtD7gPv2A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332e61e383aso913496f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847257; x=1701452057;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic/JwA3DthdDpe7smn+uf/VWJeAGFkAVcH5nMn2kqTE=;
        b=XtpO2OohZLYWOW9ENz04GVc+asm/nhQSnk+HgOdPIxIztO5ctsRvTeirtgVF8KzBLm
         H3x54YmbkL1QOgWBbRy66kyLRnDgBoPvu4YsNGGRQX6TWFvP7ZotM9yM1Th6EgqQUJAK
         3V1PsekDXaTSPupu+mfPQNQ+XNfrs5+DqBoraZfC8c8bs0qAJZNnWBIXU3bUXlUH6npk
         JvIOXkuPt+9YU6evPxJusP2K9s1L/Piq0UWMM9JAFqPX68aFaexz+sy6AScIhVvQsW10
         j62y4ixr0kvHeM5qbEhW9G5QijjlXfqE8YGV/hXUbwyDe5ldGShOjRdFQzFVG6dCJXcj
         EE1g==
X-Gm-Message-State: AOJu0Ywc+3I0GoF+yWuJyGi5Ukr1DcW74OgI9yI/XF4kvL9WkYeqKYD6
        E+b7sFhLVLxuWSopmkIhoVFWcgFd4ROscZeyV40GSC4t8AojEYuKZXGertKq+ksbumha4ENpDVX
        puKugsE84C4wMDBRaNbI7I6mm
X-Received: by 2002:a5d:5959:0:b0:332:eb88:7272 with SMTP id e25-20020a5d5959000000b00332eb887272mr2363445wri.21.1700847257388;
        Fri, 24 Nov 2023 09:34:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFARncDZ00cuXG+m+8lCbsMMrRdRm3IVlllW9nfCYdqZEQA+TMB3G/q0swIZPn31qI6qNMXqA==
X-Received: by 2002:a5d:5959:0:b0:332:eb88:7272 with SMTP id e25-20020a5d5959000000b00332eb887272mr2363192wri.21.1700847252236;
        Fri, 24 Nov 2023 09:34:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:a000:7426:f6b4:82a3:c6ab? (p200300cbc721a0007426f6b482a3c6ab.dip0.t-ipconnect.de. [2003:cb:c721:a000:7426:f6b4:82a3:c6ab])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b003143867d2ebsm4813981wrz.63.2023.11.24.09.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 09:34:11 -0800 (PST)
Message-ID: <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
Date:   Fri, 24 Nov 2023 18:34:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
 <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
 <ZWDG6BYqmZVpyTLL@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWDG6BYqmZVpyTLL@casper.infradead.org>
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

On 24.11.23 16:53, Matthew Wilcox wrote:
> On Fri, Nov 24, 2023 at 04:25:38PM +0100, David Hildenbrand wrote:
>> On 24.11.23 16:13, Matthew Wilcox wrote:
>>> On Fri, Nov 24, 2023 at 09:56:37AM +0000, Ryan Roberts wrote:
>>>> On 23/11/2023 15:59, Matthew Wilcox wrote:
>>>>> On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
>>>>>> This is v7 of a series to implement small-sized THP for anonymous memory
>>>>>> (previously called "large anonymous folios"). The objective of this is to
>>>>>
>>>>> I'm still against small-sized THP.  We've now got people asking whether
>>>>> the THP counters should be updated when dealing with large folios that
>>>>> are smaller than PMD sized.  It's sowing confusion, and we should go
>>>>> back to large anon folios as a name.
>>>>
>>>> I suspect I'm labouring the point here, but I'd like to drill into exactly what
>>>> you are objecting to. Is it:
>>>>
>>>> A) Using the name "small-sized THP" (which is currently only used in the commit
>>>> logs and a couple of times in the documentation).
>>>
>>> Yes, this is what I'm objecting to.
>>
>> I'll just repeat that "large anon folio" is misleading, because
>> * we already have "large anon folios" in hugetlb
> 
> We do?  Where?

MAP_PRIVATE of hugetlb. hugepage_add_anon_rmap() instantiates them.

Hugetlb is likely one of the oldest user of compund pages aka large folios.

> 
>> * we already have PMD-sized "large anon folios" in THP
> 
> Right, those are already accounted as THP, and that's what users expect.
> If we're allocating 1024 x 64kB chunks of memory, the user won't be able
> to distinguish that from 32 x 2MB chunks of memory, and yet the
> performance profile for some applications will be very different.

Very right, and because there will be a difference between 1024 x 64kB, 
2048 x 32 kB and so forth, we need new memory stats either way.

Ryan had some ideas on that, but currently, that's considered future 
work, just like it likely is for the pagecache as well and needs much 
more thoughts.

Initially, the admin will have to enable all that for anon either way. 
It all boils down to one memory statistic for anon memory 
(AnonHugePages) that's messed-up already.

> 
>> But inn the end, I don't care how we will call this in a commit message.
>>
>> Just sticking to what we have right now makes most sense to me.
>>
>> I know, as the creator of the term "folio" you have to object :P Sorry ;)
> 
> I don't care if it's called something to do with folios or not.  I

Good!

> am objecting to the use of the term "small THP" on the grounds of
> confusion and linguistic nonsense.

Maybe that's the reason why FreeBSD calls them "medium-sized 
superpages", because "Medium-sized" seems to be more appropriate to 
express something "in between".

So far I thought the reason was because they focused on 64k only.

Never trust a German guy on naming suggestions. John has so far been my 
naming expert, so I'm hoping he can help.

"Sub-pmd-sized THP" is just mouthful. But then, again, this is would 
just be a temporary name, and in the future THP will just naturally come 
in multiple sizes (and others here seem to agree on that).


But just to repeat: I don't think there is need to come up with new 
terminology and that there will be mass-confusion. So far I've not heard 
a compelling argument besides "one memory counter could confuse an admin 
that explicitly enables that new behavior.".

Side note: I'm, happy that we've reached a stage where we're nitpicking 
on names :)

-- 
Cheers,

David / dhildenb

