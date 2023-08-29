Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AC378C747
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbjH2OUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbjH2OTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:19:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F5199
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e4hMctN6emCgrqiKuxK7UKWS85HR+fi7fjHSuR7TJAk=; b=wGtTAk8uXg4+MUSjXCkamKt4+O
        ytIr3Go3FRCrQRV2Bcs7qEZBhVZFDleCQWG+1fal6IxDqrNIt0ba+7uTclPUN+JjINfL4tcjQ6Zsa
        DZ3r+hv7v0cmIFAdtbdSEMI2R0mYXbvScPCX9noQQwt9b0xKmrcbC9cASH2QzzZeuOR/B/6qH/rm1
        RH01II3NoRdmwioVWAszh+NazastL1w4SczDpXbMTAbiyrMLkP5ggtXn+T5W/Fm86zbgj2hFIie+E
        v1AiH79QxLeZUjd1IC1bxvRCcWmOYRaQDTmxexp7xFANkZW+mgYjkclwR73BELHEQwiqiPSyg+5ik
        Sj/lurOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qazZ3-0071DB-D2; Tue, 29 Aug 2023 14:19:29 +0000
Date:   Tue, 29 Aug 2023 15:19:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
Message-ID: <ZO3+cQouje862QNu@casper.infradead.org>
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
 <ZOgpb1Qo5B0r+mhJ@casper.infradead.org>
 <29099099-7ef2-45cb-bab7-455f58de47d1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29099099-7ef2-45cb-bab7-455f58de47d1@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:02:22PM +0100, Ryan Roberts wrote:
> >> +			if (put_devmap_managed_page(&folio->page))
> >> +				continue;
> >> +			if (folio_put_testzero(folio))
> > 
> > We're only putting one ref for the zone_device folios?  Surely
> > this should be ref_sub_and_test like below?
> 
> Good point. This function is originally a copy/paste of release_pages(), and I
> obviously missed this. In fact, looking at it again today, I think I'll factor
> out the vast majority into a common helper, since I'm currently duplicating a
> whole bunch here.
> 
> In practice I think all devmap folios will be small today though? So while I
> agree I need to fix this, I think in practice it will currently do the right thing?

I think the devdax code uses 2MB folios.

> > You'll be glad to know I've factored out a nice little helper for that.
> 
> OK, what's it called? This is just copied from release_pages() at the moment.
> Happy to use your helper in the refactored common helper.

I'll send out those patches today.
