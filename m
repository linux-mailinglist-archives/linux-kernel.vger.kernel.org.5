Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81497B5697
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbjJBPWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbjJBPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:22:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245BA9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:21:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F149C433C7;
        Mon,  2 Oct 2023 15:21:55 +0000 (UTC)
Date:   Mon, 2 Oct 2023 16:21:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 7/9] arm64/mm: Override arch_wants_pte_order()
Message-ID: <ZRrgEPwuFnCry3+/@arm.com>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-8-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929114421.3761121-8-ryan.roberts@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:44:18PM +0100, Ryan Roberts wrote:
> Define an arch-specific override of arch_wants_pte_order() so that when
> anon_orders=recommend is set, large folios will be allocated for
> anonymous memory with an order that is compatible with arm64's HPA uarch
> feature.
> 
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 7f7d9b1df4e5..e3d2449dec5c 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1110,6 +1110,16 @@ extern pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
>  extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  				    unsigned long addr, pte_t *ptep,
>  				    pte_t old_pte, pte_t new_pte);
> +
> +#define arch_wants_pte_order arch_wants_pte_order
> +static inline int arch_wants_pte_order(void)
> +{
> +	/*
> +	 * Many arm64 CPUs support hardware page aggregation (HPA), which can
> +	 * coalesce 4 contiguous pages into a single TLB entry.
> +	 */
> +	return 2;
> +}

I haven't followed the discussions on previous revisions of this series
but I wonder why not return a bitmap from arch_wants_pte_order(). For
arm64 we may want an order 6 at some point (contiguous ptes) with a
fallback to order 2 as the next best.

-- 
Catalin
