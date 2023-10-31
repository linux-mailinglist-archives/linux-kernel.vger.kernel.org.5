Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE1A7DCC22
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbjJaLun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344048AbjJaLul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:50:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E614C91
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:50:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56E36C15;
        Tue, 31 Oct 2023 04:51:20 -0700 (PDT)
Received: from [10.1.34.180] (XHFQ2J9959.cambridge.arm.com [10.1.34.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CE4B3F64C;
        Tue, 31 Oct 2023 04:50:35 -0700 (PDT)
Message-ID: <7a3a2d49-528d-4297-ae19-56aa9e6c59c6@arm.com>
Date:   Tue, 31 Oct 2023 11:50:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
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
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 21:06, David Hildenbrand wrote:
[...]
> 
> Change 2: sysfs interface.
> 
> If we call it THP, it shall go under "/sys/kernel/mm/transparent_hugepage/", I
> agree.
> 
> What we expose there and how, is TBD. Again, not a friend of "orders" and
> bitmaps at all. We can do better if we want to go down that path.
> 
> Maybe we should take a look at hugetlb, and how they added support for multiple
> sizes. What *might* make sense could be (depending on which values we actually
> support!)
> 
> 
> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/
> /sys/kernel/mm/transparent_hugepage/hugepages-128kB/
> /sys/kernel/mm/transparent_hugepage/hugepages-256kB/
> /sys/kernel/mm/transparent_hugepage/hugepages-512kB/
> /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/
> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/
> 
> Each one would contain an "enabled" and "defrag" file. We want something minimal
> first? Start with the "enabled" option.
> 
> 
> enabled: always [global] madvise never
> 
> Initially, we would set it for PMD-sized THP to "global" and for everything else
> to "never".

Hi David,

I've just started coding this, and it occurs to me that I might need a small
clarification here; the existing global "enabled" control is used to drive
decisions for both anonymous memory and (non-shmem) file-backed memory. But the
proposed new per-size "enabled" is implicitly only controlling anon memory (for
now).

1) Is this potentially confusing for the user? Should we rename the per-size
controls to "anon_enabled"? Or is it preferable to jsut keep it vague for now so
we can reuse the same control for file-backed memory in future?

2) The global control will continue to drive the file-backed memory decision
(for now), even when hugepages-2048kB/enabled != "global"; agreed?

Thanks,
Ryan

