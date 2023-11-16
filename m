Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03B7EDE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjKPKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:08:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C6DB189
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:07:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0F741595;
        Thu, 16 Nov 2023 02:08:44 -0800 (PST)
Received: from [10.1.35.163] (XHFQ2J9959.cambridge.arm.com [10.1.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42D543F6C4;
        Thu, 16 Nov 2023 02:07:55 -0800 (PST)
Message-ID: <e6060ff2-ced0-42fd-b92a-c2e710c4e15a@arm.com>
Date:   Thu, 16 Nov 2023 10:07:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Content-Language: en-GB
To:     kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231115163018.1303287-2-ryan.roberts@arm.com>
 <202311160516.kHhfmjvl-lkp@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <202311160516.kHhfmjvl-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Hoping for some guidance below!


On 15/11/2023 21:26, kernel test robot wrote:
> Hi Ryan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master v6.7-rc1 next-20231115]
> [cannot apply to arm64/for-next/core efi/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/mm-Batch-copy-PTE-ranges-during-fork/20231116-010123
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20231115163018.1303287-2-ryan.roberts%40arm.com
> patch subject: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
> config: arm-randconfig-002-20231116 (https://download.01.org/0day-ci/archive/20231116/202311160516.kHhfmjvl-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160516.kHhfmjvl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311160516.kHhfmjvl-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    mm/memory.c: In function 'folio_nr_pages_cont_mapped':
>>> mm/memory.c:969:16: error: implicit declaration of function 'pte_pgprot'; did you mean 'ptep_get'? [-Werror=implicit-function-declaration]
>      969 |         prot = pte_pgprot(pte_mkold(pte_mkclean(ptent)));
>          |                ^~~~~~~~~~
>          |                ptep_get
>    cc1: some warnings being treated as errors

It turns out that pte_pgprot() is not universal; its only implemented by
architectures that select CONFIG_HAVE_IOREMAP_PROT (currently arc, arm64,
loongarch, mips, powerpc, s390, sh, x86).

I'm using it in core-mm to help calculate the number of "contiguously mapped"
pages within a folio (note that's not the same as arm64's notion of
contpte-mapped. I just want to know that there are N physically contiguous pages
mapped virtually contiguously with the same permissions). And I'm using
pte_pgprot() to extract the permissions for each pte to compare. It's important
that we compare the permissions because just because the pages belongs to the
same folio doesn't imply they are mapped with the same permissions; think
mprotect()ing a sub-range.

I don't have a great idea for how to fix this - does anyone have any thoughts?

Some ideas:

- Implement folio_nr_pages_cont_mapped() conditionally on
CONFIG_HAVE_IOREMAP_PROT being set, otherwise it just returns 1 and for those
arches we always get the old, non-batching behavior. There is some precident;
mm/memory.c is already using pte_pgprot() behind this ifdef.

- Implement a generic helper the same way arm64 does it. This will return all
the pte bits that are not part of the PFN. But I'm not sure this is definitely a
valid thing to do for all architectures:

static inline pgprot_t pte_pgprot(pte_t pte)
{
	unsigned long pfn = pte_pfn(pte);

	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
}

- Explicitly implement pte_pgprot() for all arches that don't currently have it
(sigh).

Thanks,
Ryan


> 
> 
> vim +969 mm/memory.c
> 
>    950	
>    951	static int folio_nr_pages_cont_mapped(struct folio *folio,
>    952					      struct page *page, pte_t *pte,
>    953					      unsigned long addr, unsigned long end,
>    954					      pte_t ptent, bool *any_dirty)
>    955	{
>    956		int floops;
>    957		int i;
>    958		unsigned long pfn;
>    959		pgprot_t prot;
>    960		struct page *folio_end;
>    961	
>    962		if (!folio_test_large(folio))
>    963			return 1;
>    964	
>    965		folio_end = &folio->page + folio_nr_pages(folio);
>    966		end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
>    967		floops = (end - addr) >> PAGE_SHIFT;
>    968		pfn = page_to_pfn(page);
>  > 969		prot = pte_pgprot(pte_mkold(pte_mkclean(ptent)));
>    970	
>    971		*any_dirty = pte_dirty(ptent);
>    972	
>    973		pfn++;
>    974		pte++;
>    975	
>    976		for (i = 1; i < floops; i++) {
>    977			ptent = ptep_get(pte);
>    978			ptent = pte_mkold(pte_mkclean(ptent));
>    979	
>    980			if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
>    981			    pgprot_val(pte_pgprot(ptent)) != pgprot_val(prot))
>    982				break;
>    983	
>    984			if (pte_dirty(ptent))
>    985				*any_dirty = true;
>    986	
>    987			pfn++;
>    988			pte++;
>    989		}
>    990	
>    991		return i;
>    992	}
>    993	
> 

