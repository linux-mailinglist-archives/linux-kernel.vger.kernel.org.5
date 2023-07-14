Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A40752FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjGNDGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjGNDGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:06:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75B8A2D63
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:05:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 694F11570;
        Thu, 13 Jul 2023 20:06:36 -0700 (PDT)
Received: from [10.163.47.78] (unknown [10.163.47.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D95D23F67D;
        Thu, 13 Jul 2023 20:05:51 -0700 (PDT)
Message-ID: <7c05a142-09a4-cfc1-b6ef-db89abcffd35@arm.com>
Date:   Fri, 14 Jul 2023 08:35:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] mm/hwpoison: rename hwp_walk* to hwpoison_walk*
Content-Language: en-US
To:     Jiaqi Yan <jiaqiyan@google.com>, naoya.horiguchi@nec.com
Cc:     linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
References: <20230713235553.4121855-1-jiaqiyan@google.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230713235553.4121855-1-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/23 05:25, Jiaqi Yan wrote:
> In the discussion of "Improve hugetlbfs read on HWPOISON hugepages",

A very small nit, [1] should appear here instead		   ^^^^

> Matthew Wilcox suggests hwp is a bad abbreviation of hwpoison, as hwp
> is already used as "an acronym by acpi, intel_pstate, some clock
> drivers, an ethernet driver, and a scsi driver"[1].

Some examples here might have been useful, but never mind.

> 
> So rename hwp_walk and hwp_walk_ops to hwpoison_walk and
> hwpoison_walk_ops respectively.
> 
> raw_hwp_(page|list), *_raw_hwp, and raw_hwp_unreliable flag are other
> major appearances of "hwp". However, given the "raw" hint in the name,
> it is easy to differentiate them from other "hwp" acronyms. Since
> renaming them is not as straightforward as renaming hwp_walk*, they
> are not covered by this commit.

Makes sense.

> 
> [1] https://lore.kernel.org/lkml/20230707201904.953262-5-jiaqiyan@google.com/T/#me6fecb8ce1ad4d5769199c9e162a44bc88f7bdec
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  mm/memory-failure.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e245191e6b04..cb232e41f6c0 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -721,7 +721,7 @@ static void collect_procs(struct page *page, struct list_head *tokill,
>  		collect_procs_file(page, tokill, force_early);
>  }
>  
> -struct hwp_walk {
> +struct hwpoison_walk {
>  	struct to_kill tk;
>  	unsigned long pfn;
>  	int flags;
> @@ -756,7 +756,7 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
> -				      struct hwp_walk *hwp)
> +				      struct hwpoison_walk *hwp)
>  {
>  	pmd_t pmd = *pmdp;
>  	unsigned long pfn;
> @@ -774,7 +774,7 @@ static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
>  }
>  #else
>  static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
> -				      struct hwp_walk *hwp)
> +				      struct hwpoison_walk *hwp)
>  {
>  	return 0;
>  }
> @@ -783,7 +783,7 @@ static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
>  static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
>  			      unsigned long end, struct mm_walk *walk)
>  {
> -	struct hwp_walk *hwp = walk->private;
> +	struct hwpoison_walk *hwp = walk->private;
>  	int ret = 0;
>  	pte_t *ptep, *mapped_pte;
>  	spinlock_t *ptl;
> @@ -817,7 +817,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
>  			    unsigned long addr, unsigned long end,
>  			    struct mm_walk *walk)
>  {
> -	struct hwp_walk *hwp = walk->private;
> +	struct hwpoison_walk *hwp = walk->private;
>  	pte_t pte = huge_ptep_get(ptep);
>  	struct hstate *h = hstate_vma(walk->vma);
>  
> @@ -828,7 +828,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
>  #define hwpoison_hugetlb_range	NULL
>  #endif
>  
> -static const struct mm_walk_ops hwp_walk_ops = {
> +static const struct mm_walk_ops hwpoison_walk_ops = {
>  	.pmd_entry = hwpoison_pte_range,
>  	.hugetlb_entry = hwpoison_hugetlb_range,
>  };
> @@ -850,7 +850,7 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>  				  int flags)
>  {
>  	int ret;
> -	struct hwp_walk priv = {
> +	struct hwpoison_walk priv = {
>  		.pfn = pfn,
>  	};
>  	priv.tk.tsk = p;
> @@ -859,7 +859,7 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>  		return -EFAULT;
>  
>  	mmap_read_lock(p->mm);
> -	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwp_walk_ops,
> +	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwpoison_walk_ops,
>  			      (void *)&priv);
>  	if (ret == 1 && priv.tk.addr)
>  		kill_proc(&priv.tk, pfn, flags);

This makes better sense, and the patch LGTM in itself. There are no residues
for "hwp_walk_ops" and "hwp_walk" symbols in the tree afterwards.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
