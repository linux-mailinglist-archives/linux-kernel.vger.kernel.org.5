Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC2787EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbjHYEKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbjHYEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:09:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F091FCE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9AcvZSxbpImY+QilwnlW7s4QTbMInM9uihUNGJjwdrU=; b=cAMCZehh5ClWBMQce2ZuCMk8fG
        e71WxYyp3sgEjdkuiE0zMFtRxqyXix9iEicFES4G9a63BBP3426wWIiCd+Rfx8FpF95iYHdJscLpa
        /xeqOsiCiMCsTO85X+5h6+0jm2d9FR0XvBnkklyy8V9ph6n9sJ7drtoZjjXvFa/SDmFYKQh1Cirf/
        U/vmMElX6LfqEMhBcS/oLgXPBrNv0AOcEdTPq3cJNbiW6NTlhOHgxp6Uiv1becLHj2zdCTh+glVea
        OkYtiZEyTi3oETlxN8UuyMilBaFrH9Yf9kma97XkhBRWXPIB16RLcAIa8VRBLwmwJuYp6Gkypg7bQ
        lZFkKhMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZO8N-00Evmw-OC; Fri, 25 Aug 2023 04:09:19 +0000
Date:   Fri, 25 Aug 2023 05:09:19 +0100
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
Message-ID: <ZOgpb1Qo5B0r+mhJ@casper.infradead.org>
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810103332.3062143-5-ryan.roberts@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:33:32AM +0100, Ryan Roberts wrote:
> +void folios_put_refs(struct folio_range *folios, int nr)
> +{
> +	int i;
> +	LIST_HEAD(pages_to_free);
> +	struct lruvec *lruvec = NULL;
> +	unsigned long flags = 0;
> +	unsigned int lock_batch;
> +
> +	for (i = 0; i < nr; i++) {
> +		struct folio *folio = page_folio(folios[i].start);
> +		int refs = folios[i].end - folios[i].start;
> +
> +		/*
> +		 * Make sure the IRQ-safe lock-holding time does not get
> +		 * excessive with a continuous string of pages from the
> +		 * same lruvec. The lock is held only if lruvec != NULL.
> +		 */
> +		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
> +			unlock_page_lruvec_irqrestore(lruvec, flags);
> +			lruvec = NULL;
> +		}
> +
> +		if (is_huge_zero_page(&folio->page))
> +			continue;
> +
> +		if (folio_is_zone_device(folio)) {
> +			if (lruvec) {
> +				unlock_page_lruvec_irqrestore(lruvec, flags);
> +				lruvec = NULL;
> +			}
> +			if (put_devmap_managed_page(&folio->page))
> +				continue;
> +			if (folio_put_testzero(folio))

We're only putting one ref for the zone_device folios?  Surely
this should be ref_sub_and_test like below?

> +				free_zone_device_page(&folio->page);
> +			continue;
> +		}
> +
> +		if (!folio_ref_sub_and_test(folio, refs))
> +			continue;
> +
> +		if (folio_test_large(folio)) {
> +			if (lruvec) {
> +				unlock_page_lruvec_irqrestore(lruvec, flags);
> +				lruvec = NULL;
> +			}
> +			__folio_put_large(folio);
> +			continue;
> +		}
> +
> +		if (folio_test_lru(folio)) {
> +			struct lruvec *prev_lruvec = lruvec;
> +
> +			lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
> +									&flags);
> +			if (prev_lruvec != lruvec)
> +				lock_batch = 0;
> +
> +			lruvec_del_folio(lruvec, folio);
> +			__folio_clear_lru_flags(folio);
> +		}
> +
> +		/*
> +		 * In rare cases, when truncation or holepunching raced with
> +		 * munlock after VM_LOCKED was cleared, Mlocked may still be
> +		 * found set here.  This does not indicate a problem, unless
> +		 * "unevictable_pgs_cleared" appears worryingly large.
> +		 */
> +		if (unlikely(folio_test_mlocked(folio))) {
> +			__folio_clear_mlocked(folio);
> +			zone_stat_sub_folio(folio, NR_MLOCK);
> +			count_vm_event(UNEVICTABLE_PGCLEARED);
> +		}

You'll be glad to know I've factored out a nice little helper for that.

