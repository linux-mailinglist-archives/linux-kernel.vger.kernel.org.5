Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F49580A4F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573887AbjLHOAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573864AbjLHOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:00:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4710D10EB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:00:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AC4A106F;
        Fri,  8 Dec 2023 06:01:23 -0800 (PST)
Received: from [10.57.73.30] (unknown [10.57.73.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6E103F6C4;
        Fri,  8 Dec 2023 06:00:35 -0800 (PST)
Message-ID: <992ba52a-fcbc-4a6a-9bd1-416b4ae60cc8@arm.com>
Date:   Fri, 8 Dec 2023 14:00:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: support THP_SWAP on hardware with MTE
To:     Matthew Wilcox <willy@infradead.org>,
        Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        david@redhat.com, linux-mm@kvack.org, steven.price@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        mhocko@suse.com, shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com, linux-kernel@vger.kernel.org
References: <20231208073401.70153-1-v-songbaohua@oppo.com>
 <ZXMYe2IDVll6pBn9@casper.infradead.org>
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZXMYe2IDVll6pBn9@casper.infradead.org>
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

On 08/12/2023 13:22, Matthew Wilcox wrote:
> On Fri, Dec 08, 2023 at 08:34:01PM +1300, Barry Song wrote:
>> arch_prepare_to_swap() should take folio rather than page as parameter
>> because we support THP swap-out as a whole. It saves tags for all
>> pages in a large folio.
>>
>> Meanwhile, arch_swap_restore() now moves to use page parameter rather
>> than folio because swap-in, refault and MTE tags are working at the
>> granularity of base pages rather than folio:
>> 1. a large folio in swapcache can be partially unmapped, thus, MTE
>> tags for the unmapped pages will be invalidated;
>> 2. users might use mprotect() to set MTEs on a part of a large folio.
> 
> I would argue that using mprotect() to set MTEs on part of a large folio
> should cause that folio to be split.  Could the user give us any
> stronger signal that this memory is being used for different purposes,
> and therefore should not be managed as a single entity?

I agree this probably makes sense here. But splitting is best effort as I
understand it? It can fail due to long-term GUP, right? In which case we still
have to handle the MTE on partial large folio case safely, even if not performantly.

As an aside, I don't think it's clear cut that we would always prefer to split
based on user space mprotect/madvise/etc calls. IIUC, there are garbage
collectors that temporarily mark pages RO then switch back to RW. I wouldn't
want to split here and lose the benefits of contpte forever. I'm handwaving
because I haven't looked into the exact mechanisms yet. But I think we need to
understand these users better before deciding on an "always split based on user
hints" policy.

> 
>> Thus, it won't be easy to manage MTE tags at the granularity of folios
>> since we do have some cases in which a part of pages in a large folios
>> have valid tags, while the other part of pages haven't. Furthermore,
>> trying to restore MTE tags for a whole folio can lead to many loops and
>> early exiting even if the large folio in swapcache are still entirely
>> mapped since do_swap_page() only sets PTE and frees swap for the base
>> page where PF is happening.
>>
>> But we still have a chance to restore tags for a whole large folio
>> once we support swap-in large folio. So this job is deferred till we
>> can do refault and swap-in as a large folio.
> 
> I strongly disagree with changing the interface to arch_swap_restore()
> from folio to page.

