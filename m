Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B0F7B6875
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjJCMFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjJCMFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:05:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD5A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:05:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9032C433C8;
        Tue,  3 Oct 2023 12:05:27 +0000 (UTC)
Date:   Tue, 3 Oct 2023 13:05:25 +0100
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
Message-ID: <ZRwDhfejnvQ7jfwW@arm.com>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-8-ryan.roberts@arm.com>
 <ZRrgEPwuFnCry3+/@arm.com>
 <0fb0840f-02f0-4103-a6be-eeb4fcc16f8f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb0840f-02f0-4103-a6be-eeb4fcc16f8f@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 08:32:29AM +0100, Ryan Roberts wrote:
> On 02/10/2023 16:21, Catalin Marinas wrote:
> > On Fri, Sep 29, 2023 at 12:44:18PM +0100, Ryan Roberts wrote:
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index 7f7d9b1df4e5..e3d2449dec5c 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -1110,6 +1110,16 @@ extern pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
> >>  extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
> >>  				    unsigned long addr, pte_t *ptep,
> >>  				    pte_t old_pte, pte_t new_pte);
> >> +
> >> +#define arch_wants_pte_order arch_wants_pte_order
> >> +static inline int arch_wants_pte_order(void)
> >> +{
> >> +	/*
> >> +	 * Many arm64 CPUs support hardware page aggregation (HPA), which can
> >> +	 * coalesce 4 contiguous pages into a single TLB entry.
> >> +	 */
> >> +	return 2;
> >> +}
> > 
> > I haven't followed the discussions on previous revisions of this series
> > but I wonder why not return a bitmap from arch_wants_pte_order(). For
> > arm64 we may want an order 6 at some point (contiguous ptes) with a
> > fallback to order 2 as the next best.
> 
> This sounds like good idea to me - I'll implement it, assuming there is a next
> rev. (Or in the unlikely event that this is the only pending change, I'd rather
> defer it to when we actually need it with the contpte series).

Fine by me, at the moment there wouldn't be any user, so a patch on top
later would do.

> Side note: I don't think order-6 is ever a contpte size? Its order-4 for 4K,
> order-7 for 16k and order-5 for 64k.

Yes, it's order-4 for 4K pages (I was thinking too much of the "64" in 64KB).

-- 
Catalin
