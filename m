Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A586B7BBFFD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjJFUHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjJFUHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD195DE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696622786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pNqmbK30SfljLBAy/RLPHu30QLqa3v+lOBaHfBrwSc=;
        b=EUXd7fDZsGhHjRAaS9XH+d8PMqC5A1Mom6G/wFhDXvvaDj6nEprcEb/Hjp2+7KC7RK7PZf
        ZJ5s8dNsJImxT/lTyUnKDkqxzjOpKn08ywDSKTW99GXT2TEKSaXFPBg1SysVnQMOAxNFio
        i6CRQ8HyJob8tp0GX+QHJUKfGUgzB1I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-1waCJYJuNA-4k1wn0GRkiw-1; Fri, 06 Oct 2023 16:06:24 -0400
X-MC-Unique: 1waCJYJuNA-4k1wn0GRkiw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-324810f3bfcso1572957f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696622783; x=1697227583;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pNqmbK30SfljLBAy/RLPHu30QLqa3v+lOBaHfBrwSc=;
        b=O/tEakWzf0fHMtLjD5WbRID715gL6Jhtp8g9jdRxTTilMw9hn6mWnc88Pw2U+xNHfq
         BGN6hRg+74wbgpJf879wH15ruTDkAyoj9rkxa9F2fu1ygKLlt131bomCDt5IB650l1Ja
         Ix0lcLezyMS+o6aSiTDvbyCoYwJBOm7JrtBAyZOr5RRo4OMh5qvxah/pOmkbel5O+TOv
         a/jcJyv1v0ltXs51ykWu4QHIGtLAfrMu6Stq/Htil9AztCYFiEvp71ZCnc0/yjZ/WReK
         rnTmILTUTagrWp69JD2WDTZbCndO6FMyL5TPCO0QZ0ZX1s00KPG6Ayb3uvDWtsnuVLS4
         g9Zg==
X-Gm-Message-State: AOJu0YxEasJpOv+ZMQBYCTVxZQB5j1mEgZ8VvsExNwbYa59q5Jqk75xf
        TtOXk5nh/+44ga8zFejQ5+1zTqlofuT4rndJ8aWaPfxlhfnAh6xana7XbgJomK22cvU9RUjfDqX
        Pobr8jz8K4yVqbhVPdDiBpL/P
X-Received: by 2002:a05:600c:224d:b0:406:80b4:efd5 with SMTP id a13-20020a05600c224d00b0040680b4efd5mr5910086wmm.14.1696622783355;
        Fri, 06 Oct 2023 13:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVtdtIXkB99HLEvT5OLCfRrKm1R27RRmahSWx3yYs3WD5IkfkHtlye486IeL3QRpVuJOugng==
X-Received: by 2002:a05:600c:224d:b0:406:80b4:efd5 with SMTP id a13-20020a05600c224d00b0040680b4efd5mr5910057wmm.14.1696622782865;
        Fri, 06 Oct 2023 13:06:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bce0a000000b00405953973c3sm6639233wmc.6.2023.10.06.13.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 13:06:22 -0700 (PDT)
Message-ID: <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
Date:   Fri, 6 Oct 2023 22:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
In-Reply-To: <20230929114421.3761121-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.23 13:44, Ryan Roberts wrote:
> Hi All,

Let me highlight some core decisions on the things discussed in the 
previous alignment meetings, and comment on them.

> 
> This is v6 of a series to implement variable order, large folios for anonymous
> memory. (previously called "ANON_LARGE_FOLIO", "LARGE_ANON_FOLIO",
> "FLEXIBLE_THP", but now exposed as an extension to THP; "small-order THP"). The
> objective of this is to improve performance by allocating larger chunks of
> memory during anonymous page faults:

Change number 1: Let's call these things THP.

Fine with me; I previously rooted for that but was told that end users 
could be confused. I think the important bit is that we don't mess up 
the stats, and when we talk about THP we default to "PMD-sized THP", 
unless we explicitly include the other ones.


I dislike exposing "orders" to the users, I'm happy to be convinced why 
I am wrong and it is a good idea.

So maybe "Small THP"/"Small-sized THP" is better. Or "Medium-sized THP" 
-- as said, I think FreeBSD tends to call it "Medium-sized superpages". 
But what's small/medium/large is debatable. "Small" implies at least 
that it's smaller than what we used to know, which is a fact.

Can we also now use the terminology consistently? (e.g., 
"variable-order, large folios for anonymous memory" -> "Small-sized 
anonymous THP", you can just point at the previous patch set name in the 
cover letter)

> 
> 1) Since SW (the kernel) is dealing with larger chunks of memory than base
>     pages, there are efficiency savings to be had; fewer page faults, batched PTE
>     and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
>     overhead. This should benefit all architectures.
> 2) Since we are now mapping physically contiguous chunks of memory, we can take
>     advantage of HW TLB compression techniques. A reduction in TLB pressure
>     speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
>     TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
> 
> The major change in this revision is the addition of sysfs controls to allow
> this "small-order THP" to be enabled/disabled/configured independently of
> PMD-order THP. The approach I've taken differs a bit from previous discussions;
> instead of creating a whole new interface ("large_folio"), I'm extending THP. I
> personally think this makes things clearer and more extensible. See [6] for
> detailed rationale.

Change 2: sysfs interface.

If we call it THP, it shall go under 
"/sys/kernel/mm/transparent_hugepage/", I agree.

What we expose there and how, is TBD. Again, not a friend of "orders" 
and bitmaps at all. We can do better if we want to go down that path.

Maybe we should take a look at hugetlb, and how they added support for 
multiple sizes. What *might* make sense could be (depending on which 
values we actually support!)


/sys/kernel/mm/transparent_hugepage/hugepages-64kB/
/sys/kernel/mm/transparent_hugepage/hugepages-128kB/
/sys/kernel/mm/transparent_hugepage/hugepages-256kB/
/sys/kernel/mm/transparent_hugepage/hugepages-512kB/
/sys/kernel/mm/transparent_hugepage/hugepages-1024kB/
/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/

Each one would contain an "enabled" and "defrag" file. We want something 
minimal first? Start with the "enabled" option.


enabled: always [global] madvise never

Initially, we would set it for PMD-sized THP to "global" and for 
everything else to "never".



That sounds reasonable at least to me, and we would be using what we 
learned from THP (as John suggested).  That still gives reasonable 
flexibility without going too wild, and a better IMHO interface.

I understand Yu's point about ABI discussions and "0 knobs". I'm happy 
as long as we can have something that won't hurt us later and still be 
able to use this in distributions within a reasonable timeframe. 
Enabling/disabling individual sizes does not sound too restrictive to 
me. And we could always add an "auto" setting later and default to that 
with a new kconfig knob.

If someone wants to configure it, why not. Let's just prepare a way to 
to handle this "better" automatically in the future (if ever ...).


Change 3: Stats

 > /proc/meminfo:
 >   Introduce new "AnonHugePteMap" field, which reports the amount of
 >   memory (in KiB) mapped from large folios globally (similar to
 >   AnonHugePages field).

AnonHugePages is and remains "PMD-sized THP that is mapped using a PMD", 
I think we all agree on that. It should have been named "AnonPmdMapped" 
or "AnonHugePmdMapped", too bad, we can't change that.

"AnonHugePteMap" better be "AnonHugePteMapped".

But, I wonder if we want to expose this "PteMapped" to user space *at 
all*. Why should they care if it's PTE mapped? For PMD-sized THP it 
makes a bit of sense, because !PMD implied !performance, and one might 
have been able to troubleshoot that somehow. For PTE-mapped, it doesn't 
make much sense really, they are always PTE-mapped.

That also raises the question how you would account a PTE-mapped THP. 
The hole thing? Only the parts that are mapped? Let's better not go down 
that path.

That leaves the question why we would want to include them here at all 
in a special PTE-mapped way?


Again, let's look at hugetlb: I prepared 1 GiB and one 2 MiB page.

HugePages_Total:       1
HugePages_Free:        1
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:         1050624 kB

-> Only the last one gives the sum, the other stats don't even mention 
the other ones. [how do we get their stats, if at all?]

So maybe, we only want a summary of how many anon huge pages of any size 
are allocated (independent of the PTE vs. PMD mapping), and some other 
source to eventually inspect how the different sizes behave.

But note that for non-PMD-sized file THP we don't even have special 
counters! ... so maybe we should also defer any such stats and come up 
with something uniform for all types of non-PMD-sized THP.


Sane discussion applies to all other stats.


> 
> Because we now have runtime enable/disable control, I've removed the compile
> time Kconfig switch. It still defaults to runtime-disabled.
> 
> NOTE: These changes should not be merged until the prerequisites are complete.
> These are in progress and tracked at [7].

We should probably list them here, and classify which one we see as 
strict a requirement, which ones might be an optimization.


Now, these are just my thoughts, and I'm happy about other thoughts.

-- 
Cheers,

David / dhildenb

