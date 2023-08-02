Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32676C8EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjHBJFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjHBJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:05:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F13742724
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:05:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4271113E;
        Wed,  2 Aug 2023 02:05:43 -0700 (PDT)
Received: from [10.57.77.90] (unknown [10.57.77.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B1483F5A1;
        Wed,  2 Aug 2023 02:04:58 -0700 (PDT)
Message-ID: <951a8d96-ecdf-7ca4-ec7a-e1c5eba8bce3@arm.com>
Date:   Wed, 2 Aug 2023 10:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
 <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
 <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
 <CAOUHufb8D-8qOhB55WhHgX5dOgrPcrpOZhiA7q9JMi=w6cqEoA@mail.gmail.com>
 <d628df5d-9ff6-f830-ba72-a2b7df7e5d51@arm.com>
In-Reply-To: <d628df5d-9ff6-f830-ba72-a2b7df7e5d51@arm.com>
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

On 02/08/2023 09:02, Ryan Roberts wrote:
...

>>>
>>> I've captured run time and peak memory usage, and taken the mean. The stdev for
>>> the peak memory usage is big-ish, but I'm confident this still captures the
>>> central tendancy well:
>>>
>>> | MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak memory |
>>> |:-------------------|------------:|------------:|------------:|:------------|
>>> | 4k                 |        0.0% |        0.0% |        0.0% |        0.0% |
>>> | 16k                |       -3.6% |      -26.5% |       -0.5% |       -0.1% |
>>> | 32k                |       -4.8% |      -37.4% |       -0.6% |       -0.1% |
>>> | 64k                |       -5.7% |      -42.0% |       -0.6% |       -1.1% |
>>> | 128k               |       -5.6% |      -42.1% |       -0.7% |        1.4% |
>>> | 256k               |       -4.9% |      -41.9% |       -0.4% |        1.9% |
>>>
>>> 64K looks like the clear sweet spot to me.

I'm sorry about this; I've concluded that these tests are flawed. While I'm
correctly setting the MAX_ORDER_UNHINTED value in each case, this is run against
a 4K base page kernel, which means that it's arch_wants_pte_order() return value
is order-4. So for MAX_ORDER_UNHINTED = {64k, 128k, 256k}, the actual order used
is order-4 (=64K):

	order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);

	if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
		order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);

So while I think we can conclude that the performance improves from 4k -> 64k,
and the peak memory is about the same, we can't conclude that 64k is definely
where performance gains peak or that peak memory increases after this.

The error bars on the memory consumption are fairly big.

I'll rework the tests so that I'm actually measuring what I was intending to
measure and repost in due course.
