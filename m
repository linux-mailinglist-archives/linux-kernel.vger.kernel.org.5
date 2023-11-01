Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41547DE22F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjKAOC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjKAOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:02:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCE5683
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:02:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3852F4;
        Wed,  1 Nov 2023 07:03:34 -0700 (PDT)
Received: from [10.1.34.131] (XHFQ2J9959.cambridge.arm.com [10.1.34.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 143943F64C;
        Wed,  1 Nov 2023 07:02:49 -0700 (PDT)
Message-ID: <148676a4-8267-42de-a3ad-a3734e3f4bd9@arm.com>
Date:   Wed, 1 Nov 2023 14:02:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-GB
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
 <7a3a2d49-528d-4297-ae19-56aa9e6c59c6@arm.com>
 <cf97cf90-ceae-4fc8-8fd8-3f8068e53611@arm.com>
 <CAHbLzkrJAsWzAJCrh+Dh5gNTE1UrH9ndbWQqH9fStoptpMkEew@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAHbLzkrJAsWzAJCrh+Dh5gNTE1UrH9ndbWQqH9fStoptpMkEew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 18:29, Yang Shi wrote:
> On Tue, Oct 31, 2023 at 4:55 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 31/10/2023 11:50, Ryan Roberts wrote:
>>> On 06/10/2023 21:06, David Hildenbrand wrote:
>>> [...]
>>>>
>>>> Change 2: sysfs interface.
>>>>
>>>> If we call it THP, it shall go under "/sys/kernel/mm/transparent_hugepage/", I
>>>> agree.
>>>>
>>>> What we expose there and how, is TBD. Again, not a friend of "orders" and
>>>> bitmaps at all. We can do better if we want to go down that path.
>>>>
>>>> Maybe we should take a look at hugetlb, and how they added support for multiple
>>>> sizes. What *might* make sense could be (depending on which values we actually
>>>> support!)
>>>>
>>>>
>>>> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/
>>>> /sys/kernel/mm/transparent_hugepage/hugepages-128kB/
>>>> /sys/kernel/mm/transparent_hugepage/hugepages-256kB/
>>>> /sys/kernel/mm/transparent_hugepage/hugepages-512kB/
>>>> /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/
>>>> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/
>>>>
>>>> Each one would contain an "enabled" and "defrag" file. We want something minimal
>>>> first? Start with the "enabled" option.
>>>>
>>>>
>>>> enabled: always [global] madvise never
>>>>
>>>> Initially, we would set it for PMD-sized THP to "global" and for everything else
>>>> to "never".
>>>
>>> Hi David,
>>>
>>> I've just started coding this, and it occurs to me that I might need a small
>>> clarification here; the existing global "enabled" control is used to drive
>>> decisions for both anonymous memory and (non-shmem) file-backed memory. But the
>>> proposed new per-size "enabled" is implicitly only controlling anon memory (for
>>> now).
>>>
>>> 1) Is this potentially confusing for the user? Should we rename the per-size
>>> controls to "anon_enabled"? Or is it preferable to jsut keep it vague for now so
>>> we can reuse the same control for file-backed memory in future?
>>>
>>> 2) The global control will continue to drive the file-backed memory decision
>>> (for now), even when hugepages-2048kB/enabled != "global"; agreed?
>>>
>>> Thanks,
>>> Ryan
>>>
>>
>> Also, an implementation question:
>>
>> hugepage_vma_check() doesn't currently care whether enabled="never" for DAX VMAs
>> (although it does honour MADV_NOHUGEPAGE and the prctl); It will return true
>> regardless. Is that by design? It couldn't fathom any reasoning from the commit log:
> 
> The enabled="never" is for anonymous VMAs, DAX VMAs are typically file VMAs.

That's not quite true; enabled="never" is honoured for non-DAX/non-shmem file
VMAs (for collapse via CONFIG_READ_ONLY_THP_FOR_FS and more recently for
anything that implements huge_fault() - see
7a81751fcdeb833acc858e59082688e3020bfe12).

