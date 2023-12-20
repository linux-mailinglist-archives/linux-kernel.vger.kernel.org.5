Return-Path: <linux-kernel+bounces-6970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F5B819FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C324F1F219BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD391374E4;
	Wed, 20 Dec 2023 13:38:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165FA374C1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4SwF022SzBz1FFG9;
	Wed, 20 Dec 2023 21:34:10 +0800 (CST)
Received: from kwepemm000003.china.huawei.com (unknown [7.193.23.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 342EB1A0172;
	Wed, 20 Dec 2023 21:37:54 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 21:37:53 +0800
Subject: Re: [PATCH v2 2/3] arm64: mm: HVO: support BBM of vmemmap pgtable
 safely
To: Muchun Song <muchun.song@linux.dev>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton
	<akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, <linux-arm-kernel@lists.infradead.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20231220051855.47547-1-sunnanyong@huawei.com>
 <20231220051855.47547-3-sunnanyong@huawei.com>
 <08DCC8BB-631C-4F7A-BB0A-494AD2AD3465@linux.dev>
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <8e3b03bc-af43-adaf-5980-82548893a7c5@huawei.com>
Date: Wed, 20 Dec 2023 21:37:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <08DCC8BB-631C-4F7A-BB0A-494AD2AD3465@linux.dev>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000003.china.huawei.com (7.193.23.66)

On 2023/12/20 14:32, Muchun Song wrote:

>
>> On Dec 20, 2023, at 13:18, Nanyong Sun <sunnanyong@huawei.com> wrote:
>>
>> Implement vmemmap_update_pmd and vmemmap_update_pte on arm64 to do
>> BBM(break-before-make) logic when change the page table of vmemmap
>> address, they will under the init_mm.page_table_lock.
>> If a translation fault of vmemmap address concurrently happened after
>> pte/pmd cleared, vmemmap page fault handler will acquire the
>> init_mm.page_table_lock to wait for vmemmap update to complete,
>> by then the virtual address is valid again, so PF can return and
>> access can continue.
>> In other case, do the traditional kernel fault.
>>
>> Implement vmemmap_flush_tlb_all/range on arm64 with nothing
>> to do because tlb already flushed in every single BBM.
>>
>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>> ---
>> arch/arm64/include/asm/esr.h |  4 ++
>> arch/arm64/include/asm/mmu.h | 20 +++++++++
>> arch/arm64/mm/fault.c        | 78 ++++++++++++++++++++++++++++++++++--
>> arch/arm64/mm/mmu.c          | 28 +++++++++++++
>> 4 files changed, 127 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
>> index ae35939f395b..1c63256efd25 100644
>> --- a/arch/arm64/include/asm/esr.h
>> +++ b/arch/arm64/include/asm/esr.h
>> @@ -116,6 +116,10 @@
>> #define ESR_ELx_FSC_SERROR (0x11)
>> #define ESR_ELx_FSC_ACCESS (0x08)
>> #define ESR_ELx_FSC_FAULT (0x04)
>> +#define ESR_ELx_FSC_FAULT_L0    (0x04)
>> +#define ESR_ELx_FSC_FAULT_L1    (0x05)
>> +#define ESR_ELx_FSC_FAULT_L2    (0x06)
>> +#define ESR_ELx_FSC_FAULT_L3    (0x07)
>> #define ESR_ELx_FSC_PERM (0x0C)
>> #define ESR_ELx_FSC_SEA_TTW0 (0x14)
>> #define ESR_ELx_FSC_SEA_TTW1 (0x15)
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 2fcf51231d6e..b553bc37c925 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -76,5 +76,25 @@ extern bool kaslr_requires_kpti(void);
>> #define INIT_MM_CONTEXT(name) \
>> .pgd = init_pg_dir,
>>
>> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>> +void vmemmap_update_pmd(unsigned long addr, pmd_t *pmdp, pte_t *ptep);
>> +#define vmemmap_update_pmd vmemmap_update_pmd
>> +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte);
>> +#define vmemmap_update_pte vmemmap_update_pte
>> +
>> +static inline void vmemmap_flush_tlb_all(void)
>> +{
>> + 	/* do nothing, already flushed tlb in every single BBM */
>> +}
>> +#define vmemmap_flush_tlb_all vmemmap_flush_tlb_all
>> +
>> +static inline void vmemmap_flush_tlb_range(unsigned long start,
>> +   unsigned long end)
>> +{
>> + 	/* do nothing, already flushed tlb in every single BBM */
>> +}
>> +#define vmemmap_flush_tlb_range vmemmap_flush_tlb_range
>> +#endif
> I think those declaration related to TLB flushing should be moved
> to arch/arm64/include/asm/tlbflush.h since we do not include
> <asm/mmu.h> explicitly in hugetlb_vmemmap.c and its functionality
> is to flush TLB. Luckily, <asm/tlbflush.h> is included by hugetlb_vmemmap.c.
>
> Additionally, vmemmap_update_pmd/pte helpers should be moved to
> arch/arm64/include/asm/pgtable.h since it is really pgtable related
> operations.
>
> Thanks.

Yes£¬I will move them in next version.

Thanks for your time.

>
>
>
>
> .

