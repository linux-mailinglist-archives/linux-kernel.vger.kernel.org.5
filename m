Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFC87F5A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjKWIib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjKWIi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:38:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5146CD53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700728716; x=1732264716;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PfB+bD4Xld4bAhck5/xWDTE34JBnBQaCLqQ04SDVW+c=;
  b=iEOW1ezPXUW/T79DfxJG1uM0FzcwZX0eqUtOyTdpZAAzqg5bAUkl9UhZ
   kuIgctf5km5ygB7mfXQkDOh+ajByRQQSMuxMykf9PDo5sI94+GuyjzUFW
   9BQmAPBNE8383FvzIhK0WRxIT9d8SJwVDndNV2qtvX6T00FsNskldYnzU
   pCV6rE5MrPHa4ARL40b6yGeLM770iUe4H1DeuKgzn5kmaDRYwWc/Lq3kT
   0ilgEaNl5j0wSV9jvGq4TJkWkurShi/gCsVziVZBoJnhtAu24DoYC1PJV
   9my2T3uCMvlMHKzUY1Vk8kF9R5X6lvUgCdchh7HXAOCPNUx77lO4ZpDKn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389374997"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="389374997"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 00:38:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833352047"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="833352047"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 00:38:20 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <fengwei.yin@intel.com>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
In-Reply-To: <20231122140052.4092083-1-zhangpeng362@huawei.com> (Peng Zhang's
        message of "Wed, 22 Nov 2023 22:00:52 +0800")
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
Date:   Thu, 23 Nov 2023 16:36:20 +0800
Message-ID: <87a5r4988r.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peng Zhang <zhangpeng362@huawei.com> writes:

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
> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Suggested-by: "Huang, Ying" <ying.huang@intel.com>

:-)

> ---
>  mm/filemap.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 71f00539ac00..bb5e6a2790dc 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  			mapping_locked = true;
>  		}
>  	} else {
> +		pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> +						  vmf->address, &vmf->ptl);
> +		if (ptep) {
> +			/*
> +			 * Recheck pte with ptl locked as the pte can be cleared
> +			 * temporarily during a read/modify/write update.
> +			 */
> +			if (unlikely(!pte_none(ptep_get(ptep))))
> +				ret = VM_FAULT_NOPAGE;
> +			pte_unmap_unlock(ptep, vmf->ptl);
> +			if (unlikely(ret))
> +				return ret;
> +		}
> +

Need to deal with ptep == NULL.  Although that is high impossible.

--
Best Regards,
Huang, Ying

>  		/* No page in the page cache at all */
>  		count_vm_event(PGMAJFAULT);
>  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
