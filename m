Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C117F6AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 04:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKXDby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 22:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXDbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 22:31:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55221D43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:31:57 -0800 (PST)
Received: from kwepemm000020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sc0rc59f6zvR8X;
        Fri, 24 Nov 2023 11:31:28 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm000020.china.huawei.com (7.193.23.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 11:31:53 +0800
Message-ID: <fedd15a2-1c22-598d-beb7-ab514886ef35@huawei.com>
Date:   Fri, 24 Nov 2023 11:31:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <fengwei.yin@intel.com>, <ying.huang@intel.com>,
        <aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>,
        <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20231124023107.571059-1-zhangpeng362@huawei.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20231124023107.571059-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000020.china.huawei.com (7.193.23.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please ignore this...

On 2023/11/24 10:31, Peng Zhang wrote:

> From: ZhangPeng <zhangpeng362@huawei.com>
>
> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
> in application, which leading to an unexpected performance issue[1].
>
> This caused by temporarily cleared pte during a read/modify/write update
> of the pte, eg, do_numa_page()/change_pte_range().
>
> For the data segment of the user-mode program, the global variable area
> is a private mapping. After the pagecache is loaded, the private anonymous
> page is generated after the COW is triggered. Mlockall can lock COW pages
> (anonymous pages), but the original file pages cannot be locked and may
> be reclaimed. If the global variable (private anon page) is accessed when
> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>
> At this time, the original private file page may have been reclaimed.
> If the page cache is not available at this time, a major fault will be
> triggered and the file will be read, causing additional overhead.
>
> Fix this by rechecking the pte by holding ptl in filemap_fault() before
> triggering a major fault.
>
> We tested the performance of file private mapping page fault
> (page_fault2.c of will-it-scale [2]) and file shared mapping page fault
> (page_fault3.c of will-it-scale). The difference in performance (in
> operations per second) before and after patch applied is about 0.7% on a
> x86 physical machine.
>
> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
> [2] https://github.com/antonblanchard/will-it-scale/tree/master
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
> RFC->v1: - Update commit message and add RB from Yin Fengwei
>           - Add error handling when ptep == NULL per Huang, Ying and
>             Matthew Wilcox
>
>   mm/filemap.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 71f00539ac00..f3dcabdbc810 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>   			mapping_locked = true;
>   		}
>   	} else {
> +		pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> +						  vmf->address, &vmf->ptl);
> +		if (unlikely(!ptep))
> +			return VM_FAULT_NOPAGE;
> +		/*
> +		 * Recheck pte with ptl locked as the pte can be cleared
> +		 * temporarily during a read/modify/write update.
> +		 */
> +		if (unlikely(!pte_none(ptep_get(ptep))))
> +			ret = VM_FAULT_NOPAGE;
> +		pte_unmap_unlock(ptep, vmf->ptl);
> +		if (unlikely(ret))
> +			return ret;
> +
>   		/* No page in the page cache at all */
>   		count_vm_event(PGMAJFAULT);
>   		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);

-- 
Best Regards,
Peng

