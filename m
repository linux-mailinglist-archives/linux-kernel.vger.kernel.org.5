Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF68057C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345615AbjLEOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjLEOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:42:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7010CA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:43:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21EC2139F;
        Tue,  5 Dec 2023 06:43:51 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3962C3F6C4;
        Tue,  5 Dec 2023 06:43:03 -0800 (PST)
Message-ID: <70dcdad7-5952-48ce-a9b9-042cfea59a5d@arm.com>
Date:   Tue, 5 Dec 2023 14:43:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: hugetlb: Fix page fault loop for
 sw-dirty/hw-clean contiguous PTEs
Content-Language: en-GB
To:     James Houghton <jthoughton@google.com>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231204172646.2541916-1-jthoughton@google.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231204172646.2541916-1-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 17:26, James Houghton wrote:
> It is currently possible for a userspace application to enter a page
> fault loop when using HugeTLB pages implemented with contiguous PTEs
> when HAFDBS is not available. This happens because:
> 1. The kernel may sometimes write PTEs that are sw-dirty but hw-clean
>    (PTE_DIRTY | PTE_RDONLY | PTE_WRITE).

Hi James,

Do you know how this happens?

AFAIK, this is the set of valid bit combinations, and
PTE_RDONLY|PTE_WRITE|PTE_DIRTY is not one of them. Perhaps the real solution is
to understand how this is happening and prevent it?

/*
 * PTE bits configuration in the presence of hardware Dirty Bit Management
 * (PTE_WRITE == PTE_DBM):
 *
 * Dirty  Writable | PTE_RDONLY  PTE_WRITE  PTE_DIRTY (sw)
 *   0      0      |   1           0          0
 *   0      1      |   1           1          0
 *   1      0      |   1           0          1
 *   1      1      |   0           1          x
 *
 * When hardware DBM is not present, the sofware PTE_DIRTY bit is updated via
 * the page fault mechanism. Checking the dirty status of a pte becomes:
 *
 *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
 */


Thanks,
Ryan


> 2. If, during a write, the CPU uses a sw-dirty, hw-clean PTE in handling
>    the memory access on a system without HAFDBS, we will get a page
>    fault.
> 3. HugeTLB will check if it needs to update the dirty bits on the PTE.
>    For contiguous PTEs, it will check to see if the pgprot bits need
>    updating. In this case, HugeTLB wants to write a sequence of
>    sw-dirty, hw-dirty PTEs, but it finds that all the PTEs it is about
>    to overwrite are all pte_dirty() (pte_sw_dirty() => pte_dirty()),
>    so it thinks no update is necessary.
> 
> Please see this[1] reproducer.
> 
> I think (though I may be wrong) that both step (1) and step (3) are
> buggy.
> 
> The first patch in this series fixes step (3); instead of checking if
> pte_dirty is matching in __cont_access_flags_changed, check pte_hw_dirty
> and pte_sw_dirty separately.
> 
> The second patch in this series makes step (1) less likely to occur.
> Without this patch, we can get the kernel to write a sw-dirty, hw-clean
> PTE with the following steps (showing the relevant VMA flags and pgprot
> bits):
> i.   Create a valid, writable contiguous PTE.
>        VMA vmflags:     VM_SHARED | VM_READ | VM_WRITE
>        VMA pgprot bits: PTE_RDONLY | PTE_WRITE
>        PTE pgprot bits: PTE_DIRTY | PTE_WRITE
> ii.  mprotect the VMA to PROT_NONE.
>        VMA vmflags:     VM_SHARED
>        VMA pgprot bits: PTE_RDONLY
>        PTE pgprot bits: PTE_DIRTY | PTE_RDONLY
> iii. mprotect the VMA back to PROT_READ | PROT_WRITE.
>        VMA vmflags:     VM_SHARED | VM_READ | VM_WRITE
>        VMA pgprot bits: PTE_RDONLY | PTE_WRITE
>        PTE pgprot bits: PTE_DIRTY | PTE_WRITE | PTE_RDONLY
> 
> Applying either one of the two patches in this patchset will fix the
> particular issue with HugeTLB pages implemented with contiguous PTEs.
> It's possible that only one of these patches should be taken, or that
> the right fix is something else entirely.
> 
> [1]: https://gist.github.com/48ca/11d1e466deee032cb35aa8c2280f93b0
> 
> James Houghton (2):
>   arm64: hugetlb: Distinguish between hw and sw dirtiness in
>     __cont_access_flags_changed
>   arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify
> 
>  arch/arm64/include/asm/pgtable.h | 6 ++++++
>  arch/arm64/mm/hugetlbpage.c      | 5 ++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 645a9a454fdb7e698a63a275edca6a17ef97afc4

