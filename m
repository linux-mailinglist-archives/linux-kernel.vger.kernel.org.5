Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E31762BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjGZGmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjGZGmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:42:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07EA72132
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:42:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BDEF11FB;
        Tue, 25 Jul 2023 23:43:14 -0700 (PDT)
Received: from [10.57.77.6] (unknown [10.57.77.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FB0B3F5A1;
        Tue, 25 Jul 2023 23:42:28 -0700 (PDT)
Message-ID: <4ae1b75e-8e9b-c4f5-a50c-9fbeca245cee@arm.com>
Date:   Wed, 26 Jul 2023 07:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] mm: Implement folio_remove_rmap_range()
To:     Yu Zhao <yuzhao@google.com>, Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230720112955.643283-1-ryan.roberts@arm.com>
 <20230720112955.643283-3-ryan.roberts@arm.com>
 <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
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

On 26/07/2023 06:53, Yu Zhao wrote:
> On Thu, Jul 20, 2023 at 5:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
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
>> page_remove_rmap() is refactored so that it forwards to
>> folio_remove_rmap_range() for !compound cases, and both functions now
>> share a common epilogue function. The intention here is to avoid
>> duplication of code.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/rmap.h |   2 +
>>  mm/rmap.c            | 125 ++++++++++++++++++++++++++++++++-----------
>>  2 files changed, 97 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index b87d01660412..f578975c12c0 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -200,6 +200,8 @@ void page_add_file_rmap(struct page *, struct vm_area_struct *,
>>                 bool compound);
>>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>>                 bool compound);
>> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
>> +               int nr, struct vm_area_struct *vma);
> 
> I prefer folio_remove_rmap_range(page, nr, vma). Passing both the
> folio and the starting page seems redundant to me.

I prefer to pass folio explicitly because it makes it clear that all pages in
the range must belong to the same folio.

> 
> Matthew, is there a convention (function names, parameters, etc.) for
> operations on a range of pages within a folio?
> 
> And regarding the refactor, what I have in mind is that
> folio_remove_rmap_range() is the core API and page_remove_rmap() is
> just a wrapper around it, i.e., folio_remove_rmap_range(page, 1, vma).

I tried to do it that way, but the existing page_remove_rmap() also takes a
'compound' parameter; it can operate on compound, thp pages and uses the
alternative accounting scheme in this case.

I could add a compound parameter to folio_remove_rmap_range() but in that case
the range parameters don't make sense - when compound is true we are implicitly
operating on the whole folio due to the way the accounting is done. So I felt it
was clearer for folio_remove_rmap_range() to deal with small page accounting
only. page_remove_rmap() forwards to folio_remove_rmap_range() when
compound=false and page_remove_rmap() directly deals with the thp accounting
when compound=true.

> 
> Let me post a diff later and see if it makes sense to you.

