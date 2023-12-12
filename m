Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB980F11C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376884AbjLLPc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376793AbjLLPc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:32:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B04995
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:32:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A394A143D;
        Tue, 12 Dec 2023 07:33:19 -0800 (PST)
Received: from [10.1.39.183] (XHFQ2J9959.cambridge.arm.com [10.1.39.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8385B3F738;
        Tue, 12 Dec 2023 07:32:30 -0800 (PST)
Message-ID: <e424982c-8a2f-4c98-83aa-fdb0ee765776@arm.com>
Date:   Tue, 12 Dec 2023 15:32:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/10] mm: thp: Introduce multi-size THP sysfs
 interface
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
        linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-4-ryan.roberts@arm.com>
 <ff7a3e9c-53cb-4283-9298-781d4fb7c7f8@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ff7a3e9c-53cb-4283-9298-781d4fb7c7f8@redhat.com>
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

On 12/12/2023 14:54, David Hildenbrand wrote:
> On 07.12.23 17:12, Ryan Roberts wrote:
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
>> configuration and the VMA dimensions. The resulting functions are
>> renamed to thp_vma_suitable_orders() and thp_vma_allowable_orders()
>> respectively. Convenience functions that take a single, unencoded order
>> and return a boolean are also defined as thp_vma_suitable_order() and
>> thp_vma_allowable_order().
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
>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
> 
> [...]
> 
>> +
>> +static ssize_t thpsize_enabled_store(struct kobject *kobj,
>> +                     struct kobj_attribute *attr,
>> +                     const char *buf, size_t count)
>> +{
>> +    int order = to_thpsize(kobj)->order;
>> +    ssize_t ret = count;
>> +
>> +    if (sysfs_streq(buf, "always")) {
>> +        spin_lock(&huge_anon_orders_lock);
>> +        clear_bit(order, &huge_anon_orders_inherit);
>> +        clear_bit(order, &huge_anon_orders_madvise);
>> +        set_bit(order, &huge_anon_orders_always);
>> +        spin_unlock(&huge_anon_orders_lock);
>> +    } else if (sysfs_streq(buf, "inherit")) {
>> +        spin_lock(&huge_anon_orders_lock);
>> +        clear_bit(order, &huge_anon_orders_always);
>> +        clear_bit(order, &huge_anon_orders_madvise);
>> +        set_bit(order, &huge_anon_orders_inherit);
>> +        spin_unlock(&huge_anon_orders_lock);
>> +    } else if (sysfs_streq(buf, "madvise")) {
>> +        spin_lock(&huge_anon_orders_lock);
>> +        clear_bit(order, &huge_anon_orders_always);
>> +        clear_bit(order, &huge_anon_orders_inherit);
>> +        set_bit(order, &huge_anon_orders_madvise);
>> +        spin_unlock(&huge_anon_orders_lock);
>> +    } else if (sysfs_streq(buf, "never")) {
>> +        spin_lock(&huge_anon_orders_lock);
>> +        clear_bit(order, &huge_anon_orders_always);
>> +        clear_bit(order, &huge_anon_orders_inherit);
>> +        clear_bit(order, &huge_anon_orders_madvise);
>> +        spin_unlock(&huge_anon_orders_lock);
> 
> Why not perform lock/unlock only once in surrounding code? :)

I was nervous that sysfs_streq() may be unhappy in atomic context... Unfounded?

> 
> 
> Much better
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

