Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D547CD647
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjJRIVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjJRIVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:21:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9345D12D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:21:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C912F4;
        Wed, 18 Oct 2023 01:21:45 -0700 (PDT)
Received: from [10.57.66.147] (unknown [10.57.66.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2FBA3F64C;
        Wed, 18 Oct 2023 01:21:03 -0700 (PDT)
Message-ID: <1634d3e0-ac13-4f08-97e3-9b04a9202431@arm.com>
Date:   Wed, 18 Oct 2023 09:21:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64/mm: Hoist synchronization out of set_ptes() loop
Content-Language: en-GB
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel test robot <lkp@intel.com>, Will Deacon <will@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Peter Collingbourne <pcc@google.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231005140730.2191134-1-ryan.roberts@arm.com>
 <202310140531.BQQwt3NQ-lkp@intel.com> <ZS147N1JKyUvaHyJ@arm.com>
 <b463b420-c2be-49c5-bed6-0ff896851adb@arm.com> <ZS6EvMiJ0QF5INkv@arm.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZS6EvMiJ0QF5INkv@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2023 13:57, Catalin Marinas wrote:
> On Tue, Oct 17, 2023 at 08:36:43AM +0100, Ryan Roberts wrote:
>> On 16/10/2023 18:54, Catalin Marinas wrote:
>>> On Sat, Oct 14, 2023 at 05:15:51AM +0800, kernel test robot wrote:
>>>> kernel test robot noticed the following build warnings:
>>>>
>>>> [auto build test WARNING on arm64/for-next/core]
>>>> [also build test WARNING on arm-perf/for-next/perf arm/for-next kvmarm/next soc/for-next linus/master v6.6-rc5 next-20231013]
>>>> [cannot apply to arm/fixes]
>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>>
>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/arm64-mm-Hoist-synchronization-out-of-set_ptes-loop/20231005-231636
>>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
>>>> patch link:    https://lore.kernel.org/r/20231005140730.2191134-1-ryan.roberts%40arm.com
>>>> patch subject: [PATCH v2] arm64/mm: Hoist synchronization out of set_ptes() loop
>>>> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231014/202310140531.BQQwt3NQ-lkp@intel.com/config)
>>>> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231014/202310140531.BQQwt3NQ-lkp@intel.com/reproduce)
>>>>
>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>> the same patch/commit), kindly add following tags
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310140531.BQQwt3NQ-lkp@intel.com/
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>    In file included from net/ipv4/route.c:66:
>>>>    In file included from include/linux/mm.h:29:
>>>>    In file included from include/linux/pgtable.h:6:
>>>>>> arch/arm64/include/asm/pgtable.h:344:65: warning: parameter 'addr' set but not used [-Wunused-but-set-parameter]
>>>>      344 | static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>>>>          |                                                                 ^
>>>>    1 warning generated.
>>>
>>> Thanks for the report. I think something like below will do (I'll test
>>> and commit as a separate patch, it's not something that Ryan's patch
>>> introduces):
>>
>> I was actually just trying to repro this and was planning to send out a v3 of my
>> patch. But if you are happy to handle it as you suggest, then I guess you don't
>> need anything further from me?
> 
> If you feel like testing, please give this a go ;)

Compile tested and observed that warning is gone with your change. Also ran mm
selftests and all looks good. So:

Tested-by: Ryan Roberts <ryan.roberts@arm.com>


> 
> ------------8<---------------------------
> From e6255237acfc21e92252653c3ed42446ef67f625 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Tue, 17 Oct 2023 11:57:55 +0100
> Subject: [PATCH] arm64: Mark the 'addr' argument to set_ptes() and
>  __set_pte_at() as unused
> 
> This argument is not used by the arm64 implementation. Mark it as
> __always_unused and also remove the unnecessary 'addr' increment in
> set_ptes().
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310140531.BQQwt3NQ-lkp@intel.com/
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 68984ba9ce2a..b19a8aee684c 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -341,8 +341,9 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
>  		mte_sync_tags(pte, nr_pages);
>  }
>  
> -static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t pte, unsigned int nr)
> +static inline void set_ptes(struct mm_struct *mm,
> +			    unsigned long __always_unused addr,

Personally I'm not a huge fan of the __always_unused mark up, given that it's
used so patchily in the source. The warning also disappears without these
markups. (the real problem is just the `addr += PAGE_SIZE` below.

Thanks,
Ryan


> +			    pte_t *ptep, pte_t pte, unsigned int nr)
>  {
>  	page_table_check_ptes_set(mm, ptep, pte, nr);
>  	__sync_cache_and_tags(pte, nr);
> @@ -353,7 +354,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		if (--nr == 0)
>  			break;
>  		ptep++;
> -		addr += PAGE_SIZE;
>  		pte_val(pte) += PAGE_SIZE;
>  	}
>  }
> @@ -528,7 +528,8 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>  #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
>  #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>  
> -static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
> +static inline void __set_pte_at(struct mm_struct *mm,
> +				unsigned long __always_unused addr,
>  				pte_t *ptep, pte_t pte, unsigned int nr)
>  {
>  	__sync_cache_and_tags(pte, nr);

