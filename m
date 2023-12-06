Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C9806B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377677AbjLFKN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377668AbjLFKNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:13:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 843D71BDF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:13:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 361AC1474;
        Wed,  6 Dec 2023 02:14:12 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51533F762;
        Wed,  6 Dec 2023 02:13:22 -0800 (PST)
Message-ID: <f65baa0c-3f5a-45ad-80dd-c240fe166877@arm.com>
Date:   Wed, 6 Dec 2023 10:13:21 +0000
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
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8d5fdb17-c670-4814-8f48-4b90062668fc@redhat.com>
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

On 05/12/2023 17:21, David Hildenbrand wrote:
> On 04.12.23 11:20, Ryan Roberts wrote:
>> Hi All,
>>
>> A new week, a new version, a new name... This is v8 of a series to implement
>> multi-size THP (mTHP) for anonymous memory (previously called "small-sized THP"
>> and "large anonymous folios"). Matthew objected to "small huge" so hopefully
>> this fares better.
>>
>> The objective of this is to improve performance by allocating larger chunks of
>> memory during anonymous page faults:
>>
>> 1) Since SW (the kernel) is dealing with larger chunks of memory than base
>>     pages, there are efficiency savings to be had; fewer page faults, batched PTE
>>     and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
>>     overhead. This should benefit all architectures.
>> 2) Since we are now mapping physically contiguous chunks of memory, we can take
>>     advantage of HW TLB compression techniques. A reduction in TLB pressure
>>     speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
>>     TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
>>
>> This version changes the name and tidies up some of the kernel code and test
>> code, based on feedback against v7 (see change log for details).
>>
>> By default, the existing behaviour (and performance) is maintained. The user
>> must explicitly enable multi-size THP to see the performance benefit. This is
>> done via a new sysfs interface (as recommended by David Hildenbrand - thanks to
>> David for the suggestion)! This interface is inspired by the existing
>> per-hugepage-size sysfs interface used by hugetlb, provides full backwards
>> compatibility with the existing PMD-size THP interface, and provides a base for
>> future extensibility. See [8] for detailed discussion of the interface.
>>
>> This series is based on mm-unstable (715b67adf4c8).
> 
> I took a look at the core pieces. Some things might want some smaller tweaks,
> but nothing that should stop this from having fun in mm-unstable, and replacing
> the smaller things as we move forward.
> 

Thanks! I'll address your comments and see if I can post another (final??)
version next week.
