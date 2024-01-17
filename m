Return-Path: <linux-kernel+bounces-28404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F082FE27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7381A1C24110
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0511E138C;
	Wed, 17 Jan 2024 01:02:28 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379610E9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453347; cv=none; b=nLnqNdcyOR/XoQWMDUgKdgaZcvtPemwbD8NMf3hM8Yq0ratLnfEnYBia1xNBquFG3gdej2cw5kGFpri6SNDEz+NyKCpKOTaVi3s7wV4ksTjyv08rdC8c7GIgLPTD3XnLpis0HvZMNNfA2hYtpetS1ZZhJjlupVismbn0GUXlIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453347; c=relaxed/simple;
	bh=mIVlDBEqzyTiH3zn66mWsFtkIbDIh+J6mb4Dut3+6so=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy; b=pmgWKQbSExzCyVx2i7Y157ceDavjQ53AyV3WbC7yNS9NNyiLTp374ExopmAXikkhTiqzI+TGqkU4nKBEEuIJulPvbbCT6KytfovmI0bh/6S8WuHeU8rHGviBvxuBF00jiioBBSNWCCgvn5Mkp7/BmpNTDfPek/2l93FJX51f6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TF6xv0JTHzvV2y;
	Wed, 17 Jan 2024 09:00:51 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B64E18006C;
	Wed, 17 Jan 2024 09:02:15 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 09:02:14 +0800
Message-ID: <3089af79-c5fd-4c13-a1e1-cb9f67d4ea4f@huawei.com>
Date: Wed, 17 Jan 2024 09:02:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
To: kernel test robot <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Linux Memory Management List
	<linux-mm@kvack.org>, <ryan.roberts@arm.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>
References: <20240116071302.2282230-1-wangkefeng.wang@huawei.com>
 <202401170535.2TfJ7u74-lkp@intel.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202401170535.2TfJ7u74-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/17 5:26, kernel test robot wrote:
> Hi Kefeng,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm-memory-move-mem_cgroup_charge-into-alloc_anon_folio/20240116-151640
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240116071302.2282230-1-wangkefeng.wang%40huawei.com
> patch subject: [PATCH] mm: memory: move mem_cgroup_charge() into alloc_anon_folio()
> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240117/202401170535.2TfJ7u74-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240117/202401170535.2TfJ7u74-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401170535.2TfJ7u74-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 


thanks, will fix built on !CONFIG_TRANSPARENT_HUGEPAGE

>     mm/memory.c: In function 'alloc_anon_folio':
>>> mm/memory.c:4223:31: error: 'vma' undeclared (first use in this function); did you mean 'vmf'?
>      4223 |         return folio_prealloc(vma->vm_mm, vma, vmf->address, true);
>           |                               ^~~
>           |                               vmf
>     mm/memory.c:4223:31: note: each undeclared identifier is reported only once for each function it appears in
>>> mm/memory.c:4224:1: warning: control reaches end of non-void function [-Wreturn-type]
>      4224 | }
>           | ^
> 
> 
> vim +4223 mm/memory.c
> 
>    4153	
>    4154	static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>    4155	{
>    4156	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>    4157		struct vm_area_struct *vma = vmf->vma;
>    4158		unsigned long orders;
>    4159		struct folio *folio;
>    4160		unsigned long addr;
>    4161		pte_t *pte;
>    4162		gfp_t gfp;
>    4163		int order;
>    4164	
>    4165		/*
>    4166		 * If uffd is active for the vma we need per-page fault fidelity to
>    4167		 * maintain the uffd semantics.
>    4168		 */
>    4169		if (unlikely(userfaultfd_armed(vma)))
>    4170			goto fallback;
>    4171	
>    4172		/*
>    4173		 * Get a list of all the (large) orders below PMD_ORDER that are enabled
>    4174		 * for this vma. Then filter out the orders that can't be allocated over
>    4175		 * the faulting address and still be fully contained in the vma.
>    4176		 */
>    4177		orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
>    4178						  BIT(PMD_ORDER) - 1);
>    4179		orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>    4180	
>    4181		if (!orders)
>    4182			goto fallback;
>    4183	
>    4184		pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>    4185		if (!pte)
>    4186			return ERR_PTR(-EAGAIN);
>    4187	
>    4188		/*
>    4189		 * Find the highest order where the aligned range is completely
>    4190		 * pte_none(). Note that all remaining orders will be completely
>    4191		 * pte_none().
>    4192		 */
>    4193		order = highest_order(orders);
>    4194		while (orders) {
>    4195			addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>    4196			if (pte_range_none(pte + pte_index(addr), 1 << order))
>    4197				break;
>    4198			order = next_order(&orders, order);
>    4199		}
>    4200	
>    4201		pte_unmap(pte);
>    4202	
>    4203		/* Try allocating the highest of the remaining orders. */
>    4204		gfp = vma_thp_gfp_mask(vma);
>    4205		while (orders) {
>    4206			addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>    4207			folio = vma_alloc_folio(gfp, order, vma, addr, true);
>    4208			if (folio) {
>    4209				if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>    4210					folio_put(folio);
>    4211					goto next;
>    4212				}
>    4213				folio_throttle_swaprate(folio, gfp);
>    4214				clear_huge_page(&folio->page, vmf->address, 1 << order);
>    4215				return folio;
>    4216			}
>    4217	next:
>    4218			order = next_order(&orders, order);
>    4219		}
>    4220	
>    4221	fallback:
>    4222	#endif
>> 4223		return folio_prealloc(vma->vm_mm, vma, vmf->address, true);
>> 4224	}
>    4225	
> 

