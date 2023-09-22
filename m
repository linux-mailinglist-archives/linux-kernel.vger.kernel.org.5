Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60327AACC3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjIVIgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVIgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:36:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 279009E;
        Fri, 22 Sep 2023 01:36:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B69FDA7;
        Fri, 22 Sep 2023 01:36:52 -0700 (PDT)
Received: from [10.57.65.11] (unknown [10.57.65.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F7F03F67D;
        Fri, 22 Sep 2023 01:36:09 -0700 (PDT)
Message-ID: <fc85f58e-e8ed-4b24-a3e5-d6288156595e@arm.com>
Date:   Fri, 22 Sep 2023 09:36:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] riscv: hugetlb: Convert set_huge_pte_at() to take
 vma
Content-Language: en-GB
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
References: <20230921162007.1630149-1-ryan.roberts@arm.com>
 <20230921162007.1630149-4-ryan.roberts@arm.com>
 <7bbceed4-c5f6-42d4-5d94-060032b73385@ghiti.fr>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <7bbceed4-c5f6-42d4-5d94-060032b73385@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 08:54, Alexandre Ghiti wrote:
> Hi Ryan,
> 
> On 21/09/2023 18:20, Ryan Roberts wrote:
>> In order to fix a bug, arm64 needs access to the vma inside it's
>> implementation of set_huge_pte_at(). Provide for this by converting the
>> mm parameter to be a vma. Any implementations that require the mm can
>> access it via vma->vm_mm.
>>
>> This commit makes the required riscv modifications. Separate commits
>> update the other arches and core code, before the actual bug is fixed in
>> arm64.
>>
>> No behavioral changes intended.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   arch/riscv/include/asm/hugetlb.h | 2 +-
>>   arch/riscv/mm/hugetlbpage.c      | 3 ++-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
>> index 34e24f078cc1..be1ac8582bc2 100644
>> --- a/arch/riscv/include/asm/hugetlb.h
>> +++ b/arch/riscv/include/asm/hugetlb.h
>> @@ -17,7 +17,7 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>>               pte_t *ptep, unsigned long sz);
>>     #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
>> -void set_huge_pte_at(struct mm_struct *mm,
>> +void set_huge_pte_at(struct vm_area_struct *vma,
>>                unsigned long addr, pte_t *ptep, pte_t pte);
>>     #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
>> index 96225a8533ad..7cdbf0960772 100644
>> --- a/arch/riscv/mm/hugetlbpage.c
>> +++ b/arch/riscv/mm/hugetlbpage.c
>> @@ -177,11 +177,12 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int
>> shift, vm_flags_t flags)
>>       return entry;
>>   }
>>   -void set_huge_pte_at(struct mm_struct *mm,
>> +void set_huge_pte_at(struct vm_area_struct *vma,
>>                unsigned long addr,
>>                pte_t *ptep,
>>                pte_t pte)
>>   {
>> +    struct mm_struct *mm = vma->vm_mm;
>>       int i, pte_num;
>>         if (!pte_napot(pte)) {
> 
> 
> You can add:
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

> 
> I realize that we may have the same issue with our contig pte implementation
> (called napot in riscv) as we don't handle swap/migration entries at all. So I
> guess we need something similar, and I'll implement it (unless you want to do it
> of course, but I guess it's easier for me to test). 

Yes -I'll leave you to do the riscv part.

> One (maybe stupid) question
> though: wouldn't it be possible to extract the contig pte size from the value of
> ptep instead of using a vma?

Not for arm64: We support contpmd, pmd and contpte entries as backing for the
logical huge pte, depending on size. So without the size, we can't distinguish
between a coincidentally-aligned pmd entry vs a contpmd entry (which is just a
fixed size block of pmd entries).

Discussion with Christophe on the powerpc patch triggered some thinking; There
is theoretical problem with my current approach because there is one call site
in the core code that calls set_huge_pte_at(&init_mm). I've changed that to:

  struct vm_area_struct vma = TLB_FLUSH_VMA(&init_mm, 0);
  set_huge_pte_at(&vma);

knowing that this will never actually get called for arm64 because we return
PAGE_SIZE for arch_vmap_pte_range_map_size() and all other arches just take the
mm and ignore the rest of the vma. So it's safe, but fragile.

But it looks like riscv overrides arch_vmap_pte_range_map_size() and therefore
the call will be made there. And if riscv also needs to determine the size from
the vma, then bang.

So I'm going to rework it to continue to pass the mm in, but also add a size
parameter. Then it's totally safe. Will post a v2 later today.

Thanks,
Ryan

> 
> Thanks,
> 
> Alex
> 

