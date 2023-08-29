Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2661178C90F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjH2P7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbjH2P7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:59:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D75BA12F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:59:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0A8D2F4;
        Tue, 29 Aug 2023 09:00:06 -0700 (PDT)
Received: from [10.1.27.141] (XHFQ2J9959.cambridge.arm.com [10.1.27.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6F893F738;
        Tue, 29 Aug 2023 08:59:24 -0700 (PDT)
Message-ID: <f2c2f084-697a-47f0-9a04-faec495eb362@arm.com>
Date:   Tue, 29 Aug 2023 16:59:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
Content-Language: en-GB
To:     Matthew Wilcox <willy@infradead.org>
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
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
 <ZOgpb1Qo5B0r+mhJ@casper.infradead.org>
 <29099099-7ef2-45cb-bab7-455f58de47d1@arm.com>
 <ZO3+cQouje862QNu@casper.infradead.org>
 <ZO3/tYWCahFJAHhu@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZO3/tYWCahFJAHhu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 15:24, Matthew Wilcox wrote:
> On Tue, Aug 29, 2023 at 03:19:29PM +0100, Matthew Wilcox wrote:
>>>> You'll be glad to know I've factored out a nice little helper for that.
>>>
>>> OK, what's it called? This is just copied from release_pages() at the moment.
>>> Happy to use your helper in the refactored common helper.
>>
>> I'll send out those patches today.
> 
> No, wait, I sent them on Friday.
> 
> https://lore.kernel.org/linux-mm/20230825135918.4164671-9-willy@infradead.org/
> 
> is the important one from your point of view.  It's
> __page_cache_release() which is a little different from the current
> __page_cache_release()

Thanks! Given your series is marked RFC, I won't take the dependency for now;
I'd rather keep my series independent for review. We can race to mm-unstable and
I guess the loser gets to do the merge. ;-)
