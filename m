Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE97CBE67
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjJQJF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjJQJFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:05:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0486B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:05:10 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S8nzX3y0DzrTWv;
        Tue, 17 Oct 2023 17:02:00 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 17:04:42 +0800
Message-ID: <b52105b5-3910-46b8-a869-4a82c8a2b845@huawei.com>
Date:   Tue, 17 Oct 2023 17:04:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 17/19] mm: convert wp_page_reuse() and
 finish_mkwrite_fault() to take a folio
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
        <ying.huang@intel.com>, <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20231013085603.1227349-18-wangkefeng.wang@huawei.com>
 <202310171537.XhmrkImn-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202310171537.XhmrkImn-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/17 15:33, kernel test robot wrote:
> Hi Kefeng,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm_types-add-virtual-and-_last_cpupid-into-struct-folio/20231017-121040
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20231013085603.1227349-18-wangkefeng.wang%40huawei.com
> patch subject: [PATCH -next v2 17/19] mm: convert wp_page_reuse() and finish_mkwrite_fault() to take a folio
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310171537.XhmrkImn-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171537.XhmrkImn-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310171537.XhmrkImn-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> mm/memory.c:3276: warning: Function parameter or member 'folio' not described in 'finish_mkwrite_fault'
> 

Hi Andrew, should I resend this patch? or could you help me to update
it, also a comment(page -> folio's) on patch18, thanks.

> 
> vim +3276 mm/memory.c
> 
> 2f38ab2c3c7fef Shachar Raindel 2015-04-14  3258
> 66a6197c118540 Jan Kara        2016-12-14  3259  /**
> 66a6197c118540 Jan Kara        2016-12-14  3260   * finish_mkwrite_fault - finish page fault for a shared mapping, making PTE
> 66a6197c118540 Jan Kara        2016-12-14  3261   *			  writeable once the page is prepared
> 66a6197c118540 Jan Kara        2016-12-14  3262   *
> 66a6197c118540 Jan Kara        2016-12-14  3263   * @vmf: structure describing the fault
> 66a6197c118540 Jan Kara        2016-12-14  3264   *
> 66a6197c118540 Jan Kara        2016-12-14  3265   * This function handles all that is needed to finish a write page fault in a
> 66a6197c118540 Jan Kara        2016-12-14  3266   * shared mapping due to PTE being read-only once the mapped page is prepared.
> a862f68a8b3600 Mike Rapoport   2019-03-05  3267   * It handles locking of PTE and modifying it.
> 66a6197c118540 Jan Kara        2016-12-14  3268   *
> 66a6197c118540 Jan Kara        2016-12-14  3269   * The function expects the page to be locked or other protection against
> 66a6197c118540 Jan Kara        2016-12-14  3270   * concurrent faults / writeback (such as DAX radix tree locks).
> a862f68a8b3600 Mike Rapoport   2019-03-05  3271   *
> 2797e79f1a491f Liu Xiang       2021-06-28  3272   * Return: %0 on success, %VM_FAULT_NOPAGE when PTE got changed before
> a862f68a8b3600 Mike Rapoport   2019-03-05  3273   * we acquired PTE lock.
> 66a6197c118540 Jan Kara        2016-12-14  3274   */
> 60fe935fc6b035 Kefeng Wang     2023-10-13  3275  static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf, struct folio *folio)
> 66a6197c118540 Jan Kara        2016-12-14 @3276  {
> 66a6197c118540 Jan Kara        2016-12-14  3277  	WARN_ON_ONCE(!(vmf->vma->vm_flags & VM_SHARED));
> 66a6197c118540 Jan Kara        2016-12-14  3278  	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
> 66a6197c118540 Jan Kara        2016-12-14  3279  				       &vmf->ptl);
> 3db82b9374ca92 Hugh Dickins    2023-06-08  3280  	if (!vmf->pte)
> 3db82b9374ca92 Hugh Dickins    2023-06-08  3281  		return VM_FAULT_NOPAGE;
> 66a6197c118540 Jan Kara        2016-12-14  3282  	/*
> 66a6197c118540 Jan Kara        2016-12-14  3283  	 * We might have raced with another page fault while we released the
> 66a6197c118540 Jan Kara        2016-12-14  3284  	 * pte_offset_map_lock.
> 66a6197c118540 Jan Kara        2016-12-14  3285  	 */
> c33c794828f212 Ryan Roberts    2023-06-12  3286  	if (!pte_same(ptep_get(vmf->pte), vmf->orig_pte)) {
> 7df676974359f9 Bibo Mao        2020-05-27  3287  		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
> 66a6197c118540 Jan Kara        2016-12-14  3288  		pte_unmap_unlock(vmf->pte, vmf->ptl);
> a19e25536ed3a2 Jan Kara        2016-12-14  3289  		return VM_FAULT_NOPAGE;
> 66a6197c118540 Jan Kara        2016-12-14  3290  	}
> 60fe935fc6b035 Kefeng Wang     2023-10-13  3291  	wp_page_reuse(vmf, folio);
> a19e25536ed3a2 Jan Kara        2016-12-14  3292  	return 0;
> 66a6197c118540 Jan Kara        2016-12-14  3293  }
> 66a6197c118540 Jan Kara        2016-12-14  3294
> 
