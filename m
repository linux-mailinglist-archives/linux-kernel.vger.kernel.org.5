Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D3776E8C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjHCMsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHCMsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:48:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DE033586
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:48:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78F26113E;
        Thu,  3 Aug 2023 05:49:35 -0700 (PDT)
Received: from [10.1.35.53] (C02Z41KALVDN.cambridge.arm.com [10.1.35.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 964493F6C4;
        Thu,  3 Aug 2023 05:48:50 -0700 (PDT)
Message-ID: <2f3a4ab5-dea3-deaf-6f6d-01ac4a5716b2@arm.com>
Date:   Thu, 3 Aug 2023 13:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/3] Optimize large folio interaction with deferred
 split
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <b308fbb3-73a1-f8b4-3b08-ed5da044b2a9@arm.com>
 <20230803120100.2glxdc4yf7sjn7h5@box.shutemov.name>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230803120100.2glxdc4yf7sjn7h5@box.shutemov.name>
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

On 03/08/2023 13:01, Kirill A. Shutemov wrote:
> On Wed, Aug 02, 2023 at 05:42:23PM +0100, Ryan Roberts wrote:
>>  - avoid the split lock contention by using mmu gather (suggested by Kirill)
> 
> [Offlist]
> 
> So, my idea is to embed struct deferred_split into struct mmu_gather and
> make zap path to use it instead of per-node/per-memcg deferred_split. This
> would avoid lock contention. If the list is not empty after zap, move the
> to the per-node/per-memcg deferred_split.
> 
> But it is only relevant if we see lock contention.
> 

Thanks Kiryl, I understand the proposal now. Having thought about this over
night, I'm thinking I'll just implement the full batch approach that Yu
proposed. In this case, we will get the benefits of batching rmap removal (for
all folio types) and as a side benefit we will get the lock contention reduction
(if there is lock contention) without the need for the new per-mmu_gather struct
deferred_split. Shout if you have issue with this.
