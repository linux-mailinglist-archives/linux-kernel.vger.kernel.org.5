Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9168756831
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjGQPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGQPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:41:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD011103
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:41:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D19C1C15;
        Mon, 17 Jul 2023 08:42:22 -0700 (PDT)
Received: from [10.57.76.30] (unknown [10.57.76.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8A033F738;
        Mon, 17 Jul 2023 08:41:36 -0700 (PDT)
Message-ID: <283e4122-c23f-35a1-4782-fddde32f4ad4@arm.com>
Date:   Mon, 17 Jul 2023 16:41:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/3] mm: Allow deferred splitting of arbitrary large
 anon folios
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-2-ryan.roberts@arm.com>
 <ZLVeeDmPDWupYzSH@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZLVeeDmPDWupYzSH@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 16:30, Matthew Wilcox wrote:
> On Mon, Jul 17, 2023 at 03:31:08PM +0100, Ryan Roberts wrote:
>> In preparation for the introduction of large folios for anonymous
>> memory, we would like to be able to split them when they have unmapped
>> subpages, in order to free those unused pages under memory pressure. So
>> remove the artificial requirement that the large folio needed to be at
>> least PMD-sized.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks!

> 
>>  		 */
>> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
>> +		if (folio_test_large(folio) && folio_test_anon(folio))
>>  			if (!compound || nr < nr_pmdmapped)
>>  				deferred_split_folio(folio);
> 
> I wonder if it's worth introducing a folio_test_deferred_split() (better
> naming appreciated ...) to allow us to allocate order-1 folios and not
> do horrible things.  Maybe it's not worth supporting order-1 folios;
> we're always better off going to order-2 immediately.  Just thinking.

There is more than just _deferred_list in the 3rd page; you also have _flags_2a
and _head_2a. I guess you know much better than me what they store. But I'm
guessing its harder than jsut not splitting an order-1 page?

With the direction of large anon folios (_not_ retrying with every order down to
0), I'm not sure what the use case would be for order-1 anyway?
