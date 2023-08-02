Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C34776CAE5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjHBKdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjHBKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:32:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 043AF59F1;
        Wed,  2 Aug 2023 03:28:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B39113E;
        Wed,  2 Aug 2023 03:28:12 -0700 (PDT)
Received: from [10.57.77.90] (unknown [10.57.77.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64DCE3F6C4;
        Wed,  2 Aug 2023 03:27:26 -0700 (PDT)
Message-ID: <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
Date:   Wed, 2 Aug 2023 11:27:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
To:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, yuzhao@google.com, david@redhat.com,
        shy828301@gmail.com
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230728161356.1784568-1-fengwei.yin@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 17:13, Yin Fengwei wrote:
> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
> folio_mapcount() is used to check whether the folio is shared. But it's
> not correct as folio_mapcount() returns total mapcount of large folio.
> 
> Use folio_estimated_sharers() here as the estimated number is enough.
> 
> Yin Fengwei (2):
>   madvise: don't use mapcount() against large folio for sharing check
>   madvise: don't use mapcount() against large folio for sharing check
> 
>  mm/huge_memory.c | 2 +-
>  mm/madvise.c     | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

As a set of fixes, I agree this is definitely an improvement, so:

Reviewed-By: Ryan Roberts


But I have a couple of comments around further improvements;

Once we have the scheme that David is working on to be able to provide precise
exclusive vs shared info, we will probably want to move to that. Although that
scheme will need access to the mm_struct of a process known to be mapping the
folio. We have that info, but its not passed to folio_estimated_sharers() so we
can't just reimplement folio_estimated_sharers() - we will need to rework these
call sites again.

Given the aspiration for most of the memory to be large folios going forwards,
wouldn't it be better to avoid splitting the large folio where the large folio
is mapped entirely within the range of the madvise operation? Sorry if this has
already been discussed and decided against - I didn't follow the RFC too
closely. Or perhaps you plan to do this as a follow up?

Thanks,
Ryan

