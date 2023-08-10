Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1F77763C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjHJKtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjHJKsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:48:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 928A726BE;
        Thu, 10 Aug 2023 03:48:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A39D4D75;
        Thu, 10 Aug 2023 03:49:12 -0700 (PDT)
Received: from [10.1.27.169] (XHFQ2J9959.cambridge.arm.com [10.1.27.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86E073F64C;
        Thu, 10 Aug 2023 03:48:28 -0700 (PDT)
Message-ID: <155bd03e-b75c-4d2d-a89d-a12271ada71b@arm.com>
Date:   Thu, 10 Aug 2023 11:48:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com> <ZNQD4pxo8svpGmvX@x1n>
 <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
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

On 10/08/2023 09:59, David Hildenbrand wrote:
> On 09.08.23 23:23, Peter Xu wrote:
>> Hi, David,
>>
>> Some pure questions below..
> 
> Hi Peter,
> 
> thanks for having a look!
> 
> [...]
> 
>>> With sub-PMD THP becoming more important and things looking promising
>>> that we will soon get support for such anon THP, we want to avoid looping
>>> over all pages of a folio just to calculate the total mapcount. Further,
>>> we may soon want to use the total mapcount in other context more
>>> frequently, so prepare for reading it efficiently and atomically.
>>
>> Any (perhaps existing) discussion on reduced loops vs added atomic
>> field/ops?
> 
> So far it's not been raised as a concern, so no existing discussion.
> 
> For order-0 pages the behavior is unchanged.
> 
> For PMD-mapped THP and hugetlb it's most certainly noise compared to the other
> activities when (un)mapping these large pages.
> 
> For PTE-mapped THP, it might be a bit bigger noise, although I doubt it is
> really significant (judging from my experience on managing PageAnonExclusive
> using set_bit/test_bit/clear_bit when (un)mapping anon pages).
> 
> As folio_add_file_rmap_range() indicates, for PTE-mapped THPs we should be
> batching where possible (and Ryan is working on some more rmap batching). 

Yes, I've just posted [1] which batches the rmap removal. That would allow you
to convert the per-page atomic_dec() into a (usually) single per-large-folio
atomic_sub().

[1] https://lore.kernel.org/linux-mm/20230810103332.3062143-1-ryan.roberts@arm.com/

> There,
> managing the subpage mapcount dominates all other overhead significantly.
> 
>>
>> I had a feeling that there's some discussion behind the proposal of this
>> patch, if that's the case it'll be great to attach the link in the commit
>> log.
> 
> There were (mostly offline) discussions on how to sort out some other issues
> that PTE-mapped THP are facing, and how to eventually get rid of the subpage
> mapcounts (once consumer being _nr_pages_mapped as spelled out in the patch
> description). Having a proper total mapcount available was discussed as one
> building block.
> 
> I don't think I have anything of value to link that would make sense for the
> patch as is, as this patch is mostly independent from all that.
> 

