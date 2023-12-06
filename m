Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC91806BDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbjLFKYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377278AbjLFKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:24:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FA85109
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:24:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 701761474;
        Wed,  6 Dec 2023 02:25:26 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEFEF3F762;
        Wed,  6 Dec 2023 02:24:38 -0800 (PST)
Message-ID: <54be0bd1-9397-4b7c-9b3c-6680c5d4c248@arm.com>
Date:   Wed, 6 Dec 2023 10:24:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: hugetlb: Fix page fault loop for
 sw-dirty/hw-clean contiguous PTEs
Content-Language: en-GB
To:     James Houghton <jthoughton@google.com>
Cc:     Steve Capper <steve.capper@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231204172646.2541916-1-jthoughton@google.com>
 <70dcdad7-5952-48ce-a9b9-042cfea59a5d@arm.com>
 <CADrL8HVNBD=5akoTi3e0d6w=162Wak2cB2bc7jwQ8-DCAC4N1Q@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CADrL8HVNBD=5akoTi3e0d6w=162Wak2cB2bc7jwQ8-DCAC4N1Q@mail.gmail.com>
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

On 05/12/2023 17:54, James Houghton wrote:
> On Tue, Dec 5, 2023 at 6:43 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 04/12/2023 17:26, James Houghton wrote:
>>> It is currently possible for a userspace application to enter a page
>>> fault loop when using HugeTLB pages implemented with contiguous PTEs
>>> when HAFDBS is not available. This happens because:
>>> 1. The kernel may sometimes write PTEs that are sw-dirty but hw-clean
>>>    (PTE_DIRTY | PTE_RDONLY | PTE_WRITE).
>>
>> Hi James,
>>
>> Do you know how this happens?
> 
> Hi Ryan,
> 
> Thanks for taking a look! I do understand why this is happening. There
> is an explanation in the reproducer[1] and also in this cover letter
> (though I realize I could have been a little clearer). See below.

Sigh... sorry! I totally missed your (excellent) explanation.


> 
>> AFAIK, this is the set of valid bit combinations, and
>> PTE_RDONLY|PTE_WRITE|PTE_DIRTY is not one of them. Perhaps the real solution is
>> to understand how this is happening and prevent it?
>>
>> /*
>>  * PTE bits configuration in the presence of hardware Dirty Bit Management
>>  * (PTE_WRITE == PTE_DBM):
>>  *
>>  * Dirty  Writable | PTE_RDONLY  PTE_WRITE  PTE_DIRTY (sw)
>>  *   0      0      |   1           0          0
>>  *   0      1      |   1           1          0
>>  *   1      0      |   1           0          1
>>  *   1      1      |   0           1          x
>>  *
>>  * When hardware DBM is not present, the sofware PTE_DIRTY bit is updated via
>>  * the page fault mechanism. Checking the dirty status of a pte becomes:
>>  *
>>  *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
>>  */
> 
> Thanks for pointing this out. So (1) is definitely a bug. The second
> patch in this series makes it impossible to create such a PTE via
> pte_modify (by forcing sw-dirty PTEs to be hw-dirty as well).

Yes; I think the second patch should be sufficient; I took a quick look at the
other helpers and I don't see anything else that could get the PTE to the
invalid state.

I have a series that starts using the contpte bit for (multi-size) THP
opportunistically. This bug will affect that too I think. Your patch #2 will fix
for both hugetlb and my series. I'd rather not apply an equivalent to your patch
#1 because its not quite as straightforward in my code path. But I'm pretty
confident that patch # is all that's needed here.

Thanks,
Ryan

> 
>>> The second patch in this series makes step (1) less likely to occur.
> 
> It makes it impossible to create this invalid set of bits via
> pte_modify(). Assuming all PTE pgprot updates are done via the proper
> interfaces, patch #2 might actually make this invalid bit combination
> impossible to produce (that's certainly the goal). So perhaps language
> stronger than "less likely" is appropriate.
> 
> Here's the sequence of events to trigger this bug, via mprotect():
> 
>>> Without this patch, we can get the kernel to write a sw-dirty, hw-clean
>>> PTE with the following steps (showing the relevant VMA flags and pgprot
>>> bits):
>>> i.   Create a valid, writable contiguous PTE.
>>>        VMA vmflags:     VM_SHARED | VM_READ | VM_WRITE
>>>        VMA pgprot bits: PTE_RDONLY | PTE_WRITE
>>>        PTE pgprot bits: PTE_DIRTY | PTE_WRITE
>>> ii.  mprotect the VMA to PROT_NONE.
>>>        VMA vmflags:     VM_SHARED
>>>        VMA pgprot bits: PTE_RDONLY
>>>        PTE pgprot bits: PTE_DIRTY | PTE_RDONLY
>>> iii. mprotect the VMA back to PROT_READ | PROT_WRITE.
>>>        VMA vmflags:     VM_SHARED | VM_READ | VM_WRITE
>>>        VMA pgprot bits: PTE_RDONLY | PTE_WRITE
>>>        PTE pgprot bits: PTE_DIRTY | PTE_WRITE | PTE_RDONLY
> 
> With patch #2, the PTE pgprot bits in step iii become PTE_DIRTY |
> PTE_WRITE (hw-dirtiness is set, as the PTE is sw-dirty).
> 
> Thanks!
> 
>>> [1]: https://gist.github.com/48ca/11d1e466deee032cb35aa8c2280f93b0

