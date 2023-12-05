Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE28C804EAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344965AbjLEJuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjLEJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:50:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6936C9E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:50:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B209EC15;
        Tue,  5 Dec 2023 01:51:05 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D1FE3F5A1;
        Tue,  5 Dec 2023 01:50:15 -0800 (PST)
Message-ID: <8adbde1c-970b-4a26-81b0-91b913c4850b@arm.com>
Date:   Tue, 5 Dec 2023 09:50:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] mm: thp: Introduce multi-size THP sysfs
 interface
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-4-ryan.roberts@arm.com>
 <CAGsJ_4zU6pHOwEzCQxo9UWUFmHZp0pvfgF4pKbkFfDPCRyFwyw@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zU6pHOwEzCQxo9UWUFmHZp0pvfgF4pKbkFfDPCRyFwyw@mail.gmail.com>
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

On 05/12/2023 04:21, Barry Song wrote:
> On Mon, Dec 4, 2023 at 11:21 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> In preparation for adding support for anonymous multi-size THP,
>> introduce new sysfs structure that will be used to control the new
>> behaviours. A new directory is added under transparent_hugepage for each
>> supported THP size, and contains an `enabled` file, which can be set to
>> "inherit" (to inherit the global setting), "always", "madvise" or
>> "never". For now, the kernel still only supports PMD-sized anonymous
>> THP, so only 1 directory is populated.
>>
>> The first half of the change converts transhuge_vma_suitable() and
>> hugepage_vma_check() so that they take a bitfield of orders for which
>> the user wants to determine support, and the functions filter out all
>> the orders that can't be supported, given the current sysfs
>> configuration and the VMA dimensions. If there is only 1 order set in
>> the input then the output can continue to be treated like a boolean;
>> this is the case for most call sites. The resulting functions are
>> renamed to thp_vma_suitable_orders() and thp_vma_allowable_orders()
>> respectively.
>>
>> The second half of the change implements the new sysfs interface. It has
>> been done so that each supported THP size has a `struct thpsize`, which
>> describes the relevant metadata and is itself a kobject. This is pretty
>> minimal for now, but should make it easy to add new per-thpsize files to
>> the interface if needed in future (e.g. per-size defrag). Rather than
>> keep the `enabled` state directly in the struct thpsize, I've elected to
>> directly encode it into huge_anon_orders_[always|madvise|inherit]
>> bitfields since this reduces the amount of work required in
>> thp_vma_allowable_orders() which is called for every page fault.
>>
>> See Documentation/admin-guide/mm/transhuge.rst, as modified by this
>> commit, for details of how the new sysfs interface works.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Reviewed-by: Barry Song <v-songbaohua@oppo.com>

Thanks!

> 
>> -khugepaged will be automatically started when
>> -transparent_hugepage/enabled is set to "always" or "madvise, and it'll
>> -be automatically shutdown if it's set to "never".
>> +khugepaged will be automatically started when one or more hugepage
>> +sizes are enabled (either by directly setting "always" or "madvise",
>> +or by setting "inherit" while the top-level enabled is set to "always"
>> +or "madvise"), and it'll be automatically shutdown when the last
>> +hugepage size is disabled (either by directly setting "never", or by
>> +setting "inherit" while the top-level enabled is set to "never").
>>
>>  Khugepaged controls
>>  -------------------
>>
>> +.. note::
>> +   khugepaged currently only searches for opportunities to collapse to
>> +   PMD-sized THP and no attempt is made to collapse to other THP
>> +   sizes.
> 
> For small-size THP, collapse is probably a bad idea. we like a one-shot
> try in Android especially we are using a 64KB and less large folio size. if
> PF succeeds in getting large folios, we map large folios, otherwise we
> give up as those memories can be quite unstably swapped-out, swapped-in
> and madvised to be DONTNEED.
> 
> too many compactions will increase power consumption and decrease UI
> response.

Understood; that's very useful information for the Android context. Multiple
people have made comments about eventually needing khugepaged (or something
similar) support in the server context though to async collapse to contpte size.
Actually one suggestion was a user space daemon that scans and collapses with
MADV_COLLAPSE. I suspect the key will be to ensure whatever solution we go for
is flexible and can be enabled/disabled/configured for the different environments.

> 
> Thanks
> Barry

