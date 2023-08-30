Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F263678DFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbjH3TR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243888AbjH3MHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:07:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F9AB1B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:07:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41E8A2F4;
        Wed, 30 Aug 2023 05:08:00 -0700 (PDT)
Received: from [10.57.64.173] (unknown [10.57.64.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7A53F738;
        Wed, 30 Aug 2023 05:07:03 -0700 (PDT)
Message-ID: <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com>
Date:   Wed, 30 Aug 2023 13:07:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-GB
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 22:32, Huang, Ying wrote:
> Hi, Ryan,
> 
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>> allocated in large folios of a determined order. All pages of the large
>> folio are pte-mapped during the same page fault, significantly reducing
>> the number of page faults. The number of per-page operations (e.g. ref
>> counting, rmap management lru list management) are also significantly
>> reduced since those ops now become per-folio.
>>
>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>> which defaults to disabled for now; The long term aim is for this to
>> defaut to enabled, but there are some risks around internal
>> fragmentation that need to be better understood first.
>>
>> Large anonymous folio (LAF) allocation is integrated with the existing
>> (PMD-order) THP and single (S) page allocation according to this policy,
>> where fallback (>) is performed for various reasons, such as the
>> proposed folio order not fitting within the bounds of the VMA, etc:
>>
>>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>> ----------------|-----------|-------------|---------------|-------------
>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>> MADV_NOHUGEPAGE | S         | S           | S             | S
> 
> IMHO, we should use the following semantics as you have suggested
> before.
> 
>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
> ----------------|-----------|-------------|---------------|-------------
> no hint         | S         | S           | LAF>S         | THP>LAF>S
> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
> MADV_NOHUGEPAGE | S         | S           | S             | S
> 
> Or even,
> 
>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
> ----------------|-----------|-------------|---------------|-------------
> no hint         | S         | S           | S             | THP>LAF>S
> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
> MADV_NOHUGEPAGE | S         | S           | S             | S
> 
> From the implementation point of view, PTE mapped PMD-sized THP has
> almost no difference with LAF (just some small sized THP).  It will be
> confusing to distinguish them from the interface point of view.
> 
> So, IMHO, the real difference is the policy.  For example, prefer
> PMD-sized THP, prefer small sized THP, or fully auto.  The sysfs
> interface is used to specify system global policy.  In the long term, it
> can be something like below,
> 
> never:      S               # disable all THP
> madvise:                    # never by default, control via madvise()
> always:     THP>LAF>S       # prefer PMD-sized THP in fact
> small:      LAF>S           # prefer small sized THP
> auto:                       # use in-kernel heuristics for THP size
> 
> But it may be not ready to add new policies now.  So, before the new
> policies are ready, we can add a debugfs interface to override the
> original policy in /sys/kernel/mm/transparent_hugepage/enabled.  After
> we have tuned enough workloads, collected enough data, we can add new
> policies to the sysfs interface.

I think we can all imagine many policy options. But we don't really have much
evidence yet for what it best. The policy I'm currently using is intended to
give some flexibility for testing (use LAF without THP by setting sysfs=never,
use THP without LAF by compiling without LAF) without adding any new knobs at
all. Given that, surely we can defer these decisions until we have more data?

In the absence of data, your proposed solution sounds very sensible to me. But
for the purposes of scaling up perf testing, I don't think its essential given
the current policy will also produce the same options.

If we were going to add a debugfs knob, I think the higher priority would be a
knob to specify the folio order. (but again, I would rather avoid if possible).

Thanks,
Ryan


