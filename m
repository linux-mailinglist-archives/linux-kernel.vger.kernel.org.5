Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696907668B4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjG1JXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjG1JWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:22:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1B6B8A7F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:17:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8B42D75;
        Fri, 28 Jul 2023 02:17:21 -0700 (PDT)
Received: from [10.57.77.173] (unknown [10.57.77.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8985D3F67D;
        Fri, 28 Jul 2023 02:16:36 -0700 (PDT)
Message-ID: <9b54e5af-af1a-6741-424b-6c667d0b405b@arm.com>
Date:   Fri, 28 Jul 2023 10:16:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
To:     Yu Zhao <yuzhao@google.com>, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <20230727141837.3386072-4-ryan.roberts@arm.com>
 <CAOUHufYiEwYw0sFGK0kP0FFRfV51=hVJ==e5R_hXZXQo-OEcwQ@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufYiEwYw0sFGK0kP0FFRfV51=hVJ==e5R_hXZXQo-OEcwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 18:22, Yu Zhao wrote:
> On Thu, Jul 27, 2023 at 8:18 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> This allows batching the rmap removal with folio_remove_rmap_range(),
>> which means we avoid spuriously adding a partially unmapped folio to the
>> deferred split queue in the common case, which reduces split queue lock
>> contention.
>>
>> Previously each page was removed from the rmap individually with
>> page_remove_rmap(). If the first page belonged to a large folio, this
>> would cause page_remove_rmap() to conclude that the folio was now
>> partially mapped and add the folio to the deferred split queue. But
>> subsequent calls would cause the folio to become fully unmapped, meaning
>> there is no value to adding it to the split queue.
>>
>> A complicating factor is that for platforms where MMU_GATHER_NO_GATHER
>> is enabled (e.g. s390), __tlb_remove_page() drops a reference to the
>> page. This means that the folio reference count could drop to zero while
>> still in use (i.e. before folio_remove_rmap_range() is called). This
>> does not happen on other platforms because the actual page freeing is
>> deferred.
>>
>> Solve this by appropriately getting/putting the folio to guarrantee it
>> does not get freed early. Given the need to get/put the folio in the
>> batch path, we stick to the non-batched path if the folio is not large.
>> While the batched path is functionally correct for a folio with 1 page,
>> it is unlikely to be as efficient as the existing non-batched path in
>> this case.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> This ad hoc patch looks unacceptable to me: we can't afford to keep
> adding special cases.
> 
> I vote for completely converting zap_pte_range() to use
> folio_remove_rmap_range(), and that includes tlb_flush_rmap_batch()
> and other types of large folios, not just anon. 

The intent of the change is to avoid the deferred split queue lock contention,
and this is only a problem for anon folios; page cache folios are never split in
this way. My intention was to do the smallest change to solve the problem. I
don't see the value in reworking a much bigger piece of the code, making it more
complex, when its not going to give any clear perf benefits.


Otherwise I'll leave
> it to Matthew and David.

If there is concensus that this is _required_ in order to merge this series,
then I guess I'll bite the bullet and do it. But my preference is to leave it
for if/when a reason is found that it is actually bringing benefit.

