Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E1B7F7798
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbjKXPXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbjKXPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:22:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4255819B1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:23:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63AEF1063;
        Fri, 24 Nov 2023 07:23:51 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B04D3F73F;
        Fri, 24 Nov 2023 07:23:02 -0800 (PST)
Message-ID: <9379cf06-8f91-41ca-98dc-0f57b486952f@arm.com>
Date:   Fri, 24 Nov 2023 15:23:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-GB
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZWC9lwDAjMZsNzoG@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 15:13, Matthew Wilcox wrote:
> On Fri, Nov 24, 2023 at 09:56:37AM +0000, Ryan Roberts wrote:
>> On 23/11/2023 15:59, Matthew Wilcox wrote:
>>> On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
>>>> This is v7 of a series to implement small-sized THP for anonymous memory
>>>> (previously called "large anonymous folios"). The objective of this is to
>>>
>>> I'm still against small-sized THP.  We've now got people asking whether
>>> the THP counters should be updated when dealing with large folios that
>>> are smaller than PMD sized.  It's sowing confusion, and we should go
>>> back to large anon folios as a name.
>>
>> I suspect I'm labouring the point here, but I'd like to drill into exactly what
>> you are objecting to. Is it:
>>
>> A) Using the name "small-sized THP" (which is currently only used in the commit
>> logs and a couple of times in the documentation).
> 
> Yes, this is what I'm objecting to.
> 
>> B) Exposing the controls for this feature as an extension to the existing
>> /sys/kernel/mm/transparent_hugepage/* sysfs interface (note the interface never
>> uses the term "small-sized").
> 
> I don't object to the controls being here.  I still wish we didn't need
> an interface to control them at all, but I don't have the time to become
> an expert in anonymous memory and figure out how to make that happen.
> 
>> If A) then this is easily solved by choosing another descriptive name and
>> updating those places. Personally I think it would be best to continue to use
>> "THP" since we are exposing the feature through that interface. Perhaps "large
>> folio THP".
> 
> I think that continues the confusion about the existing interfaces we
> have which count THP (and mean "PMD sized THP").  I'd really prefer the
> term "THP" to unambiguously mean PMD sized THP.  I don't understand why
> you felt the need to move away from Large Anon Folios as a name.
> 

Because the controls are exposed in the sysfs THP directory (and therefore
documented in the transhuge.rst document). It seems odd to refer to them as
large anon folios within the kernel but expose them as as part of the THP interface.

But I'm certainly open to the idea of changing the name in the commit logs and
being careful to distance it from THP transhuge.rst if that's the concensus. I
am opposed to moving/changing the interface though - that's actually what I
thought you were suggesting.

