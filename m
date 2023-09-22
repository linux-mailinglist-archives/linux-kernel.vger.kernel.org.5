Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA277AAA87
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjIVHnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjIVHmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:42:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E905B1A2;
        Fri, 22 Sep 2023 00:42:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CC2DDA7;
        Fri, 22 Sep 2023 00:42:43 -0700 (PDT)
Received: from [10.57.65.11] (unknown [10.57.65.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3AA23F5A1;
        Fri, 22 Sep 2023 00:41:54 -0700 (PDT)
Message-ID: <af6a0bb0-4645-4667-aa0e-e78fac3aad28@arm.com>
Date:   Fri, 22 Sep 2023 08:41:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] Fix set_huge_pte_at() panic on arm64
Content-Language: en-GB
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230921162007.1630149-1-ryan.roberts@arm.com>
 <20230921093026.230b2991be551093e397f462@linux-foundation.org>
 <7c5c2c00-d657-44fd-b478-743b43c57e8a@arm.com> <ZQx/f35o0zT2lug4@arm.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZQx/f35o0zT2lug4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 18:38, Catalin Marinas wrote:
> On Thu, Sep 21, 2023 at 05:35:54PM +0100, Ryan Roberts wrote:
>> On 21/09/2023 17:30, Andrew Morton wrote:
>>> On Thu, 21 Sep 2023 17:19:59 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>> Ryan Roberts (8):
>>>>   parisc: hugetlb: Convert set_huge_pte_at() to take vma
>>>>   powerpc: hugetlb: Convert set_huge_pte_at() to take vma
>>>>   riscv: hugetlb: Convert set_huge_pte_at() to take vma
>>>>   s390: hugetlb: Convert set_huge_pte_at() to take vma
>>>>   sparc: hugetlb: Convert set_huge_pte_at() to take vma
>>>>   mm: hugetlb: Convert set_huge_pte_at() to take vma
>>>>   arm64: hugetlb: Convert set_huge_pte_at() to take vma
>>>>   arm64: hugetlb: Fix set_huge_pte_at() to work with all swap entries
>>>>
>>>>  arch/arm64/include/asm/hugetlb.h              |  2 +-
>>>>  arch/arm64/mm/hugetlbpage.c                   | 22 ++++----------
>>>>  arch/parisc/include/asm/hugetlb.h             |  2 +-
>>>>  arch/parisc/mm/hugetlbpage.c                  |  4 +--
>>>>  .../include/asm/nohash/32/hugetlb-8xx.h       |  3 +-
>>>>  arch/powerpc/mm/book3s64/hugetlbpage.c        |  2 +-
>>>>  arch/powerpc/mm/book3s64/radix_hugetlbpage.c  |  2 +-
>>>>  arch/powerpc/mm/nohash/8xx.c                  |  2 +-
>>>>  arch/powerpc/mm/pgtable.c                     |  7 ++++-
>>>>  arch/riscv/include/asm/hugetlb.h              |  2 +-
>>>>  arch/riscv/mm/hugetlbpage.c                   |  3 +-
>>>>  arch/s390/include/asm/hugetlb.h               |  8 +++--
>>>>  arch/s390/mm/hugetlbpage.c                    |  8 ++++-
>>>>  arch/sparc/include/asm/hugetlb.h              |  8 +++--
>>>>  arch/sparc/mm/hugetlbpage.c                   |  8 ++++-
>>>>  include/asm-generic/hugetlb.h                 |  6 ++--
>>>>  include/linux/hugetlb.h                       |  6 ++--
>>>>  mm/damon/vaddr.c                              |  2 +-
>>>>  mm/hugetlb.c                                  | 30 +++++++++----------
>>>>  mm/migrate.c                                  |  2 +-
>>>>  mm/rmap.c                                     | 10 +++----
>>>>  mm/vmalloc.c                                  |  5 +++-
>>>>  22 files changed, 80 insertions(+), 64 deletions(-)
>>>
>>> Looks scary but it's actually a fairly modest patchset.  It could
>>> easily be all rolled into a single patch for ease of backporting. 
>>> Maybe Greg has an opinion?
>>
>> Yes, I thought about doing that; or perhaps 2 patches - one for the interface
>> change across all arches and core code, and one for the actual bug fix?
> 
> I think this would make more sense, especially if we want to backport
> it. The first patch would have no functional change, only an interface
> change, followed by the arm64 fix.

OK I'll do it like this for v2.

> 

