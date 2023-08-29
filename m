Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D90078C6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbjH2ODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbjH2OD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:03:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1555CED
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:03:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70DFE2F4;
        Tue, 29 Aug 2023 07:03:08 -0700 (PDT)
Received: from [10.1.27.141] (XHFQ2J9959.cambridge.arm.com [10.1.27.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 877453F64C;
        Tue, 29 Aug 2023 07:02:26 -0700 (PDT)
Message-ID: <29099099-7ef2-45cb-bab7-455f58de47d1@arm.com>
Date:   Tue, 29 Aug 2023 15:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
To:     Matthew Wilcox <willy@infradead.org>
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
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
 <ZOgpb1Qo5B0r+mhJ@casper.infradead.org>
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZOgpb1Qo5B0r+mhJ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 05:09, Matthew Wilcox wrote:
> On Thu, Aug 10, 2023 at 11:33:32AM +0100, Ryan Roberts wrote:
>> +void folios_put_refs(struct folio_range *folios, int nr)
>> +{
>> +	int i;
>> +	LIST_HEAD(pages_to_free);
>> +	struct lruvec *lruvec = NULL;
>> +	unsigned long flags = 0;
>> +	unsigned int lock_batch;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		struct folio *folio = page_folio(folios[i].start);
>> +		int refs = folios[i].end - folios[i].start;
>> +
>> +		/*
>> +		 * Make sure the IRQ-safe lock-holding time does not get
>> +		 * excessive with a continuous string of pages from the
>> +		 * same lruvec. The lock is held only if lruvec != NULL.
>> +		 */
>> +		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
>> +			unlock_page_lruvec_irqrestore(lruvec, flags);
>> +			lruvec = NULL;
>> +		}
>> +
>> +		if (is_huge_zero_page(&folio->page))
>> +			continue;
>> +
>> +		if (folio_is_zone_device(folio)) {
>> +			if (lruvec) {
>> +				unlock_page_lruvec_irqrestore(lruvec, flags);
>> +				lruvec = NULL;
>> +			}
>> +			if (put_devmap_managed_page(&folio->page))
>> +				continue;
>> +			if (folio_put_testzero(folio))
> 
> We're only putting one ref for the zone_device folios?  Surely
> this should be ref_sub_and_test like below?

Good point. This function is originally a copy/paste of release_pages(), and I
obviously missed this. In fact, looking at it again today, I think I'll factor
out the vast majority into a common helper, since I'm currently duplicating a
whole bunch here.

In practice I think all devmap folios will be small today though? So while I
agree I need to fix this, I think in practice it will currently do the right thing?

> 
>> +				free_zone_device_page(&folio->page);
>> +			continue;
>> +		}
>> +
>> +		if (!folio_ref_sub_and_test(folio, refs))
>> +			continue;
>> +
>> +		if (folio_test_large(folio)) {
>> +			if (lruvec) {
>> +				unlock_page_lruvec_irqrestore(lruvec, flags);
>> +				lruvec = NULL;
>> +			}
>> +			__folio_put_large(folio);
>> +			continue;
>> +		}
>> +
>> +		if (folio_test_lru(folio)) {
>> +			struct lruvec *prev_lruvec = lruvec;
>> +
>> +			lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
>> +									&flags);
>> +			if (prev_lruvec != lruvec)
>> +				lock_batch = 0;
>> +
>> +			lruvec_del_folio(lruvec, folio);
>> +			__folio_clear_lru_flags(folio);
>> +		}
>> +
>> +		/*
>> +		 * In rare cases, when truncation or holepunching raced with
>> +		 * munlock after VM_LOCKED was cleared, Mlocked may still be
>> +		 * found set here.  This does not indicate a problem, unless
>> +		 * "unevictable_pgs_cleared" appears worryingly large.
>> +		 */
>> +		if (unlikely(folio_test_mlocked(folio))) {
>> +			__folio_clear_mlocked(folio);
>> +			zone_stat_sub_folio(folio, NR_MLOCK);
>> +			count_vm_event(UNEVICTABLE_PGCLEARED);
>> +		}
> 
> You'll be glad to know I've factored out a nice little helper for that.

OK, what's it called? This is just copied from release_pages() at the moment.
Happy to use your helper in the refactored common helper.

> 

