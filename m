Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E865759DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjGSSq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjGSSqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:46:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12D321FDC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:46:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 177632F4;
        Wed, 19 Jul 2023 11:47:33 -0700 (PDT)
Received: from [10.57.76.81] (unknown [10.57.76.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF49D3F67D;
        Wed, 19 Jul 2023 11:46:47 -0700 (PDT)
Message-ID: <10cdc414-c2d6-90c0-2810-9cdda0323423@arm.com>
Date:   Wed, 19 Jul 2023 19:46:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] mm: Implement folio_remove_rmap_range()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230719135450.545227-1-ryan.roberts@arm.com>
 <20230719135450.545227-3-ryan.roberts@arm.com>
 <CAOUHufZrrPBkdEYWnGnbTTHxp8bveSOocPB3J=+nu-VfYFdKZA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufZrrPBkdEYWnGnbTTHxp8bveSOocPB3J=+nu-VfYFdKZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 19:23, Yu Zhao wrote:
> On Wed, Jul 19, 2023 at 7:55 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Like page_remove_rmap() but batch-removes the rmap for a range of pages
>> belonging to a folio. This can provide a small speedup due to less
>> manipuation of the various counters. But more crucially, if removing the
>> rmap for all pages of a folio in a batch, there is no need to
>> (spuriously) add it to the deferred split list, which saves significant
>> cost when there is contention for the split queue lock.
>>
>> All contained pages are accounted using the order-0 folio (or base page)
>> scheme.
>>
>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> I have asked for this before but let me be very clear this time: we
> need to generalize the existing functions rather than add more
> specialized functions. Otherwise it'd get even harder to maintain down
> the road.

Yeah fair enough, my fault; I wrote this before I had your feedback on the other
rmap function and overlooked it when refactoring this. I'll fix it and repost.

> 
> folio_remove_rmap_range() needs to replace page_remove_rmap(). IOW,
> page_remove_rmap() is just a wrapper around folio_remove_rmap_range().

