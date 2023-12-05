Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A858051BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376828AbjLELNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjLELNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:13:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0010F9E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:13:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49DC2139F;
        Tue,  5 Dec 2023 03:14:10 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43D593F5A1;
        Tue,  5 Dec 2023 03:13:20 -0800 (PST)
Message-ID: <888e20e4-6073-426c-9159-e359c758d78a@arm.com>
Date:   Tue, 5 Dec 2023 11:13:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Multi-size THP for anonymous memory
Content-Language: en-GB
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <2be046e1-ef95-4244-ae23-e56071ae1218@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2be046e1-ef95-4244-ae23-e56071ae1218@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 03:37, John Hubbard wrote:
> On 12/4/23 02:20, Ryan Roberts wrote:
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
> 
> Using a couple of Armv8 systems, I've tested this patchset. I applied it
> to top of tree (Linux 6.7-rc4), on top of your latest contig pte series
> [1].
> 
> With those two patchsets applied, the mm selftests look OK--or at least
> as OK as they normally do. I compared test runs between THP/mTHP set to
> "always", vs "never", to verify that there were no new test failures.
> Details: specifically, I set one particular page size (2 MB) to
> "inherit", and then toggled /sys/kernel/mm/transparent_hugepage/enabled
> between "always" and "never".

Excellent - I'm guessing this was for 64K base pages?

> 
> I also re-ran my usual compute/AI benchmark, and I'm still seeing the
> same 10x performance improvement that I reported for the v6 patchset.
> 
> So for this patchset and for [1] as well, please feel free to add:
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>

Thanks!

> 
> 
> [1] https://lore.kernel.org/all/20231204105440.61448-1-ryan.roberts@arm.com/
> 
> 
> thanks,

