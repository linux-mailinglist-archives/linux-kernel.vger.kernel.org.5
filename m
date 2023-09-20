Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA117A70DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjITDOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITDOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:14:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C4DB0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695179685; x=1726715685;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=1SxDjFkG+rS8siB7pgMqaoqzXOfpU9xxTwYAc924F0U=;
  b=FD+IncCt9Z8gF3//M8cOc/bx3IB2VAXtIlUcwHwrWjEP6DiNmU9ADDqp
   fdm/FRG+9/3xwinyNgrfIBkwZxOeByUkALBTnueRcMhXg5a+mMk19SEsI
   Z8WNEtVijuQ2GnEIRbrm21KRMbjGMg1CkCOyjH/GWHTfw2qKyc/RM7dnj
   FduW6ZOSC5G5BVFUXUrYMR0rWr8YP+zuAmFqauahJtXlYpk1fIgcG1wZT
   SAJyVLQhc2kdQ3g4fXPeiEnkGZDkOsc93O1lVWmNG4SQHxZPGiIj086Yn
   kSsxiObrZEONuRECKwDp8yYMTzJHZ8fLOnc//BntFa7uSRYldu+6f8gT/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370425533"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="370425533"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 20:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="861800218"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="861800218"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 20:14:42 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>
Subject: Re: [PATCH 5/6] mm: memory: add vm_normal_pmd_folio()
References: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
        <20230918103213.4166210-6-wangkefeng.wang@huawei.com>
Date:   Wed, 20 Sep 2023 11:12:39 +0800
In-Reply-To: <20230918103213.4166210-6-wangkefeng.wang@huawei.com> (Kefeng
        Wang's message of "Mon, 18 Sep 2023 18:32:12 +0800")
Message-ID: <87pm2dwna0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

> The new vm_normal_pmd_folio() wrapper is similar to vm_normal_folio(),
> which allow them to completely replace the struct page variables with
> struct folio variables.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/mm.h |  2 ++
>  mm/memory.c        | 10 ++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 12335de50140..7d05ec047186 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2327,6 +2327,8 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
>  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
> +struct folio *vm_normal_pmd_folio(struct vm_area_struct *vma, unsigned long addr,
> +				  pmd_t pmd);
>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  				pmd_t pmd);

Why do not follow the counterpart of page (vm_normal_page_pmd()) to be
vm_normal_folio_pmd()?

--
Best Regards,
Huang, Ying

> diff --git a/mm/memory.c b/mm/memory.c
> index ce3efe7255d2..d4296ee72730 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -689,6 +689,16 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  out:
>  	return pfn_to_page(pfn);
>  }
> +
> +struct folio *vm_normal_pmd_folio(struct vm_area_struct *vma, unsigned long addr,
> +				  pmd_t pmd)
> +{
> +	struct page *page = vm_normal_page_pmd(vma, addr, pmd);
> +
> +	if (page)
> +		return page_folio(page);
> +	return NULL;
> +}
>  #endif
>  
>  static void restore_exclusive_pte(struct vm_area_struct *vma,
