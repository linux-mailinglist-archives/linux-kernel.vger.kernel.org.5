Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9F7AA698
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjIVBhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVBhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:37:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDF2F5;
        Thu, 21 Sep 2023 18:37:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2723CC433C8;
        Fri, 22 Sep 2023 01:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695346635;
        bh=zRyL223DT0AFJx1gaOEUn6WcLlX2Kysk+6Fs0mtLrOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNAAsjxZ/e5mSgGg/LPftlkbNKpcN/rnJGyJdb//w0VkNEAdvtPkglz83EUpi+iRP
         CUifgPcEfIXikkO8FSBVWAewa4zbTOyW/Yl5flrqUDllqJAE3SzG2kmjrjAZrmJDHo
         crbAM8SWYY+JnkBboXDn+/Qz7CHhlgXE7xG/2qP2x0dmB0tprvlPXeP9NzkYvk+r3s
         0uxngMBI0XN0BvxVhCId+ACbyTDCZOXDjS5wdL3TxpEGcwtg23dBoXZkT0xPOs4c86
         SSz1LUNN37N0YRjVtKgcGjRfXwPjXi9P2JOPVjrrrvT7bUtXub+Siisb+MvwlrdxSE
         a+KWdAyrmeGOA==
From:   SeongJae Park <sj@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Will Deacon <will@kernel.org>,
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 6/8] mm: hugetlb: Convert set_huge_pte_at() to take vma
Date:   Fri, 22 Sep 2023 01:37:11 +0000
Message-Id: <20230922013711.100278-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921162007.1630149-7-ryan.roberts@arm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On Thu, 21 Sep 2023 17:20:05 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> In order to fix a bug, arm64 needs access to the vma inside it's
> implementation of set_huge_pte_at(). Provide for this by converting the
> mm parameter to be a vma. Any implementations that require the mm can
> access it via vma->vm_mm.
> 
> This commit makes the required modifications to the core mm. Separate
> commits update the arches, before the actual bug is fixed in arm64.
> 
> No behavioral changes intended.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

For mm/damon/ part change,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ


> ---
>  include/asm-generic/hugetlb.h |  6 +++---
>  include/linux/hugetlb.h       |  6 +++---
>  mm/damon/vaddr.c              |  2 +-
>  mm/hugetlb.c                  | 30 +++++++++++++++---------------
>  mm/migrate.c                  |  2 +-
>  mm/rmap.c                     | 10 +++++-----
>  mm/vmalloc.c                  |  5 ++++-
>  7 files changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 4da02798a00b..515e4777fb65 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -75,10 +75,10 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>  #endif
>  
>  #ifndef __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
> -static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> -		pte_t *ptep, pte_t pte)
> +static inline void set_huge_pte_at(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep, pte_t pte)
>  {
> -	set_pte_at(mm, addr, ptep, pte);
> +	set_pte_at(vma->vm_mm, addr, ptep, pte);
>  }
>  #endif
>  
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 5b2626063f4f..08184f32430c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -984,7 +984,7 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
>  						unsigned long addr, pte_t *ptep,
>  						pte_t old_pte, pte_t pte)
>  {
> -	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> +	set_huge_pte_at(vma, addr, ptep, pte);
>  }
>  #endif
>  
> @@ -1172,8 +1172,8 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>  #endif
>  }
>  
> -static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> -				   pte_t *ptep, pte_t pte)
> +static inline void set_huge_pte_at(struct vm_area_struct *vma,
> +				   unsigned long addr, pte_t *ptep, pte_t pte)
>  {
>  }
>  
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 4c81a9dbd044..55da8cee8fbc 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -347,7 +347,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
>  	if (pte_young(entry)) {
>  		referenced = true;
>  		entry = pte_mkold(entry);
> -		set_huge_pte_at(mm, addr, pte, entry);
> +		set_huge_pte_at(vma, addr, pte, entry);
>  	}
>  
>  #ifdef CONFIG_MMU_NOTIFIER
[...]


Thanks,
SJ
