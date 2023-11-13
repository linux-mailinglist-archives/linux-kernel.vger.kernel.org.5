Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49EA7E9A11
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjKMKT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:19:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C08B5D4C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:19:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4C9414BF;
        Mon, 13 Nov 2023 02:20:37 -0800 (PST)
Received: from [10.57.73.13] (unknown [10.57.73.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE5403F6C4;
        Mon, 13 Nov 2023 02:19:49 -0800 (PST)
Message-ID: <f1fa098b-210e-41a9-80fc-aec212976610@arm.com>
Date:   Mon, 13 Nov 2023 10:19:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-GB
To:     Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com>
 <ZVGxkMeY50JSesaj@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZVGxkMeY50JSesaj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2023 05:18, Matthew Wilcox wrote:
> On Sun, Nov 12, 2023 at 10:57:47PM -0500, John Hubbard wrote:
>> I've done some initial performance testing of this patchset on an arm64
>> SBSA server. When these patches are combined with the arm64 arch contpte
>> patches in Ryan's git tree (he has conveniently combined everything
>> here: [1]), we are seeing a remarkable, consistent speedup of 10.5x on
>> some memory-intensive workloads. Many test runs, conducted independently
>> by different engineers and on different machines, have convinced me and
>> my colleagues that this is an accurate result.
>>
>> In order to achieve that result, we used the git tree in [1] with
>> following settings:
>>
>>     echo always >/sys/kernel/mm/transparent_hugepage/enabled
>>     echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders
>>
>> This was on a aarch64 machine configure to use a 64KB base page size.
>> That configuration means that the PMD size is 512MB, which is of course
>> too large for practical use as a pure PMD-THP. However, with with these
>> small-size (less than PMD-sized) THPs, we get the improvements in TLB
>> coverage, while still getting pages that are small enough to be
>> effectively usable.
> 
> That is quite remarkable!

Yes, agreed - thanks for sharing these results! A very nice Monday morning boost!

> 
> My hope is to abolish the 64kB page size configuration.  ie instead of
> using the mixture of page sizes that you currently are -- 64k and
> 1M (right?  Order-0, and order-4)

Not quite; the contpte-size for a 64K page size is 2M/order-5. (and yes, it is
64K/order-4 for a 4K page size, and 2M/order-7 for a 16K page size. I agree that
intuitively you would expect the order to remain constant, but it doesn't).

The "recommend" setting above will actually enable order-3 as well even though
there is no HW benefit to this. So the full set of available memory sizes here is:

64K/order-0, 512K/order-3, 2M/order-5, 512M/order-13

> , that 4k, 64k and 2MB (order-0,
> order-4 and order-9) will provide better performance.
> 
> Have you run any experiements with a 4kB page size?

Agree that would be interesting with 64K small-sized THP enabled. And I'd love
to get to a world were we universally deal in variable sized chunks of memory,
aligned on 4K boundaries.

In my experience though, there are still some performance benefits to 64K base
page vs 4K+contpte; the page tables are more cache efficient for the former case
- 64K of memory is described by 8 bytes in the former vs 8x16=128 bytes in the
latter. In practice the HW will still only read 8 bytes in the latter but that's
taking up a full cache line vs the former where a single cache line stores 8x
64K entries.

Thanks,
Ryan

