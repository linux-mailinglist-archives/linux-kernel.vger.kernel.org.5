Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864AB803294
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343981AbjLDM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjLDM0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:26:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 381F9C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:26:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492471424;
        Mon,  4 Dec 2023 04:27:18 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B0583F5A1;
        Mon,  4 Dec 2023 04:26:28 -0800 (PST)
Message-ID: <6dd6164a-1dd5-46e7-bcf7-b62ff5c6e8ec@arm.com>
Date:   Mon, 4 Dec 2023 12:26:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
Content-Language: en-GB
To:     Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
 <800937DA-BAD0-4C60-B155-AECCA21E955E@nvidia.com>
 <1a0f5cb8-421c-4f28-a986-f3c381406e81@arm.com>
 <90EC4C0D-0254-4B93-AFD5-3C09580A77DE@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <90EC4C0D-0254-4B93-AFD5-3C09580A77DE@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>
>>> Also, struct page (memmap) might not be always contiguous, using struct page
>>> points to represent folio range might not give the result you want.
>>> See nth_page() and folio_page_idx() in include/linux/mm.h.
>>
>> Is that true for pages within the same folio too? Or are all pages in a folio
>> guarranteed contiguous? Perhaps I'm better off using pfn?
> 
> folio_page_idx() says not all pages in a folio is guaranteed to be contiguous.
> PFN might be a better choice.

Hi Zi, Matthew,

Zi made this comment a couple of months back that it is incorrect to assume that
`struct page`s within a folio are (virtually) contiguous. I'm not sure if that's
really the case though? I see other sites in the source that do page++ when
iterating over a folio. e.g. smaps_account(), splice_folio_into_pipe(),
__collapse_huge_page_copy(), etc.

Any chance someone could explain the rules?

Thanks,
Ryan


