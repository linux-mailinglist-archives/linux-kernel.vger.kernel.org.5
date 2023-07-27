Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56F37648D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjG0Hho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjG0Hh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:37:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8DC3D5E6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:27:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C597FD75;
        Thu, 27 Jul 2023 00:27:30 -0700 (PDT)
Received: from [10.57.77.6] (unknown [10.57.77.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 617EF3F67D;
        Thu, 27 Jul 2023 00:26:46 -0700 (PDT)
Message-ID: <faf8d723-afb8-ac4e-7861-4004bb78c5a9@arm.com>
Date:   Thu, 27 Jul 2023 08:26:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] mm: Implement folio_remove_rmap_range()
To:     Matthew Wilcox <willy@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230720112955.643283-1-ryan.roberts@arm.com>
 <20230720112955.643283-3-ryan.roberts@arm.com>
 <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
 <ZMFNgmlT1JpI0z5+@casper.infradead.org>
 <87r0ouw39n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZMHX+O0wmjuPXdTi@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZMHX+O0wmjuPXdTi@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 03:35, Matthew Wilcox wrote:
> On Thu, Jul 27, 2023 at 09:29:24AM +0800, Huang, Ying wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>>> I think that can make sense.  Because we limit to a single page table,
>>> specifying 'nr = 1 << PMD_ORDER' is the same as 'compound = true'.
>>> Just make it folio, page, nr, vma.  I'd actually prefer it as (vma,
>>> folio, page, nr), but that isn't the convention we've had in rmap up
>>> until now.
>>
>> IIUC, even if 'nr = 1 << PMD_ORDER', we may remove one PMD 'compound'
>> mapping, or 'nr' PTE mapping.  So, we will still need 'compound' (or
>> some better name) as parameter.
> 
> Oh, this is removing ... so you're concerned with the case where we've
> split the PMD into PTEs, but all the PTEs are still present in a single
> page table?  OK, I don't have a good answer to that.  Maybe that torpedoes
> the whole idea; I'll think about it.

This is exactly why I think the approach I've already taken is the correct one;
a 'range' makes no sense when you are dealing with 'compound' pages because you
are accounting the entire folio. So surely its better to reflect that by only
accounting small pages in the range version of the API.
