Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6007D738C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjJYSsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33E8111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698259668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=/A0jwRSw1DaBntSa4tsSJ2pFvJQzP2vjsW0usGBKgM8=;
        b=Ez7hIpe0iGHjbV9E1WHhkmQSei5ElzLhc9HwjQOPXvEkAD/xSrGRTLZrrPTxwV7Z+2OxWc
        u0jDMP0CldkZOfgKphiL43wg2AHO4jGP9nVFXar9t+GX0NLmd2uFCgrFurfX73WqFAdzgY
        A8eg3qLwgDyAzPIh5YqRZEWixSBjiNQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-xEBNCvd2PyuIbk8s-g_vZA-1; Wed, 25 Oct 2023 14:47:46 -0400
X-MC-Unique: xEBNCvd2PyuIbk8s-g_vZA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4084d0b171eso7764995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259665; x=1698864465;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A0jwRSw1DaBntSa4tsSJ2pFvJQzP2vjsW0usGBKgM8=;
        b=fGU6fomYmQR1Bjl/qjxPPEwf12D6gbtbPbJ29FJDgRsKIPgnzrPAZP7s/2v5/MY8Y5
         AhBtVnHWESaZcc01sySEZP3W6s6Y9IoNBqL+2XUQjeR6FF0hJYH0KdbrsxbdIjAO9QhM
         iKpNij6bcrHNYLpXQdUX6bdyEsEr2v8iVVUP9Lzq7fZNmF78fbJYY0CUNZPLlq4sTekK
         RRbRP9XGoO7TwuTNDdYLVaMfdK4Wn7SqOBbjeKhfFiH3oV/EE+TmUYgPMk4edX6VgOyX
         rLFWx0Jeyo7mAYZaNA44W92kH76ASEwPkFG/fNy73dtP5vdZ4Vamb3Ua/0Ko51ufsWtt
         uMWg==
X-Gm-Message-State: AOJu0Yyp8y2HvKh1KWTr1bURb8UN3CuWxCpe3ivFIWyu5WSqiZkbFOWF
        W+eNQhE79hRvkHWXztdFOTcE5rjVUCDWMVQ/8LUmFUz6LvNBm/SKI1BVFOGeLbxYD1GUaLvZUkV
        ZiFDonE8I3YQtAfYpFz+hXiUR
X-Received: by 2002:a05:600c:1c14:b0:405:358c:ba74 with SMTP id j20-20020a05600c1c1400b00405358cba74mr655385wms.0.1698259665176;
        Wed, 25 Oct 2023 11:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW093/1UZRzoZJVCpzUIR5s8m6Ud8Ie3slQyv7dsexAL+mjcPvEwkEOH0RVKO2XYJu4OdVFA==
X-Received: by 2002:a05:600c:1c14:b0:405:358c:ba74 with SMTP id j20-20020a05600c1c1400b00405358cba74mr655342wms.0.1698259664269;
        Wed, 25 Oct 2023 11:47:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8100:1fcd:5169:391e:99af? (p200300cbc70881001fcd5169391e99af.dip0.t-ipconnect.de. [2003:cb:c708:8100:1fcd:5169:391e:99af])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c139100b003fefaf299b6sm450174wmf.38.2023.10.25.11.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:47:43 -0700 (PDT)
Message-ID: <a2e11353-fad8-475c-a4d1-dc1de22dde11@redhat.com>
Date:   Wed, 25 Oct 2023 20:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
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
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
 <a7781f13-21ca-48c7-99c4-22beef0400f9@arm.com>
 <fcbe9179-dcd9-4bf8-b1d1-82201880527e@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fcbe9179-dcd9-4bf8-b1d1-82201880527e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.10.23 18:24, Ryan Roberts wrote:
> On 20/10/2023 13:33, Ryan Roberts wrote:
>> On 06/10/2023 21:06, David Hildenbrand wrote:
>>> On 29.09.23 13:44, Ryan Roberts wrote:
>>>> Hi All,
>>>
>>
>> [...]
>>
>>>> NOTE: These changes should not be merged until the prerequisites are complete.
>>>> These are in progress and tracked at [7].
>>>
>>> We should probably list them here, and classify which one we see as strict a
>>> requirement, which ones might be an optimization.
>>>
>>
>> Bringing back the discussion of prerequistes to this thread following the
>> discussion at the mm-alignment meeting on Wednesday.
>>
>> Slides, updated following discussion to reflect all the agreed items that are
>> prerequisites and enhancements, are at [1].
>>
>> I've taken a closer look at the situation with khugepaged, and can confirm that
>> it does correctly collapse anon small-sized THP into PMD-sized THP. I did notice
>> though, that one of the khugepaged selftests (collapse_max_ptes_none) fails when
>> small-sized THP is enabled+always. So I've fixed that test up and will add the
>> patch to the next version of my series.
>>
>> So I believe the khugepaged prerequisite can be marked as done.
>>
>> [1]
>> https://drive.google.com/file/d/1GnfYFpr7_c1kA41liRUW5YtCb8Cj18Ud/view?usp=sharing&resourcekey=0-U1Mj3-RhLD1JV6EThpyPyA
> 
> Hi All,

Hi,

I wanted to remind people in the THP cabal meeting, but that either 
didn't happen or zoomed decided to not let me join :)

> 
> It's been a week since the mm alignment meeting discussion we had around
> prerequisites and the ABI. I haven't heard any further feedback on the ABI
> proposal, so I'm going to be optimistic and assume that nobody has found any
> fatal flaws in it :).

After saying in the call probably 10 times that people should comment 
here if there are reasonable alternatives worth discussing, call me 
"optimistic" as well; but, it's only been a week and people might still 
be thinking about this/

There were two things discussed in the call:

* Yu brought up "lists" so we can have priorities. As briefly discussed
   in the  call, this (a) might not be needed right now in an initial
   version;  (b) the kernel might be able to handle that (or many cases)
   automatically, TBD. Adding lists now would kind-of set the semantics
   of that interface in stone. As you describe below, the approach
   discussed here could easily be extended to cover priorities, if need
   be.

* Hugh raised the point that "bitmap of orders" could be replaced by
   "added THP sizes", which really is "bitmap of orders" shifted to the
   left. To configure 2 MiB +  64Kib, one would get "2097152 + 65536" =
   "2162688" or in KiB "2112". Hm.

Both approaches would require single-option files like "enable_always", 
"enable_madvise" ... which I don't particularly like, but who am I to judge.


> 
> Certainly, I think it held up to the potential future policies that Yu Zhou
> cited on the call - the possibility of preferring a smaller size over a bigger
> one, if the smaller size can be allocated without splitting a contiguous block.
> I think the suggestion of adding a per-size priority file would solve it. And in
> general because we have a per-size directory, that gives us lots of flexibility
> for growth.

Jup, same opinion here. But again, I'm very happy to hear other 
alternatives and why they are better.

> 
> Anyway, given the lack of feedback, I'm proposing to spin a new version. I'm
> planning to do the following:
> 
>    - Drop the accounting patch (#3); we will continue to only account PMD-sized
>      THP for now. We can add more counters in future if needed. page cache large
>      folios haven't needed any new counters yet.
> 
>    - Pivot to the ABI proposed by DavidH; per-size directories in a similar shape
>      to that used by hugetlb
> 
>    - Drop the "recommend" keyword patch (#6); For now, users will need to
>      understand implicitly which sizes are beneficial to their HW perf
> 
>    - Drop patch (#7); arch_wants_pte_order() is no longer needed due to dropping
>      patch #6
> 
>    - Add patch for khugepaged selftest improvement (described in previous email
>      above).
> 
>    - Ensure that PMD_ORDER is not assumed to be compile-time constant (current
>      code is broken on powerpc)
> 
> Please shout if you think this is the wrong approach.

I'll shout that this sounds good to me; rather wait a bit more for more 
opinions. It probably makes sense to post something after the (upcoming) 
merge window, if there are no further discussions here.

-- 
Cheers,

David / dhildenb

