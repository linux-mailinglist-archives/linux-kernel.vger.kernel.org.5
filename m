Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE7F80723E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378899AbjLFOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378736AbjLFOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:22:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46437D44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:22:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBF6A1474;
        Wed,  6 Dec 2023 06:23:34 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7DE33F5A1;
        Wed,  6 Dec 2023 06:22:45 -0800 (PST)
Message-ID: <7a18b924-1012-4649-9289-ab5075eb7736@arm.com>
Date:   Wed, 6 Dec 2023 14:22:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Multi-size THP for anonymous memory
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <8d5fdb17-c670-4814-8f48-4b90062668fc@redhat.com>
 <f65baa0c-3f5a-45ad-80dd-c240fe166877@arm.com>
 <7d3457cd-5e3d-42a7-8113-545da646d7c8@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <7d3457cd-5e3d-42a7-8113-545da646d7c8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 10:22, David Hildenbrand wrote:
> On 06.12.23 11:13, Ryan Roberts wrote:
>> On 05/12/2023 17:21, David Hildenbrand wrote:
>>> On 04.12.23 11:20, Ryan Roberts wrote:
>>>> Hi All,
>>>>
>>>> A new week, a new version, a new name... This is v8 of a series to implement
>>>> multi-size THP (mTHP) for anonymous memory (previously called "small-sized THP"
>>>> and "large anonymous folios"). Matthew objected to "small huge" so hopefully
>>>> this fares better.
>>>>
>>>> The objective of this is to improve performance by allocating larger chunks of
>>>> memory during anonymous page faults:
>>>>
>>>> 1) Since SW (the kernel) is dealing with larger chunks of memory than base
>>>>      pages, there are efficiency savings to be had; fewer page faults,
>>>> batched PTE
>>>>      and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
>>>>      overhead. This should benefit all architectures.
>>>> 2) Since we are now mapping physically contiguous chunks of memory, we can take
>>>>      advantage of HW TLB compression techniques. A reduction in TLB pressure
>>>>      speeds up kernel and user space. arm64 systems have 2 mechanisms to
>>>> coalesce
>>>>      TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
>>>>
>>>> This version changes the name and tidies up some of the kernel code and test
>>>> code, based on feedback against v7 (see change log for details).
>>>>
>>>> By default, the existing behaviour (and performance) is maintained. The user
>>>> must explicitly enable multi-size THP to see the performance benefit. This is
>>>> done via a new sysfs interface (as recommended by David Hildenbrand - thanks to
>>>> David for the suggestion)! This interface is inspired by the existing
>>>> per-hugepage-size sysfs interface used by hugetlb, provides full backwards
>>>> compatibility with the existing PMD-size THP interface, and provides a base for
>>>> future extensibility. See [8] for detailed discussion of the interface.
>>>>
>>>> This series is based on mm-unstable (715b67adf4c8).
>>>
>>> I took a look at the core pieces. Some things might want some smaller tweaks,
>>> but nothing that should stop this from having fun in mm-unstable, and replacing
>>> the smaller things as we move forward.
>>>
>>
>> Thanks! I'll address your comments and see if I can post another (final??)
>> version next week.
> 
> It's always possible to do incremental changes on top that Andrew will squash in
> the end. I even recall that he prefers that way once a series has been in
> mm-unstable for a bit, so one can better observe the diff and which effects they
> have.
> 

I've responded to all your comments. There are a bunch of changes that I agree
would be good to make (and some which I disagree with - would be good if you get
a chance to respond).

I think I can get all the changes done and tested by Friday. So perhaps it's
simplest to keep this out of mm-unstable until then, and put the new version in
on Friday? Then if there are any more small changes to do, I can do those as diffs?

Thanks,
Ryan


