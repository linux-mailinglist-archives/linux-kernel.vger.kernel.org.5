Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2975680A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGQPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjGQPbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:31:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAB91996
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Q37pZ8IBxOhr5Sa+/a5uMV+7jb/8DQNXvCzdrgVpWA=; b=VLQRzgjzCmvWkMyIW1Upa23Zfq
        h6SWe9w7NlxUIwdx3jEJZc8Bw5inu+veI8+uHp1p1SXFSO/Rr4NdsiCc9AkXxtuUmvrSDxDCuzavA
        WH6B06Etl2cMkr4FzMAeAbm7IdZRgoacU5O+T6RduXh3luJD6ZclTPkqBuoIaCu1jgJtQWkMpvUl4
        eZ8nd+t04KuSmBBZ7hEz6IutF9RObXicIno4Y3W7iJt0frXVavCgvHov/KXBhbYBiquvpPgGrNiXg
        why7uNlCWm0wylKnqXpIjwtdoamvMb67lFeaEymx8HLdAIicoBvfpvfT9HxWowAoVuXLE6iOeBQ13
        jNFBwleg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLQAi-0042X2-Gl; Mon, 17 Jul 2023 15:30:00 +0000
Date:   Mon, 17 Jul 2023 16:30:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/3] mm: Allow deferred splitting of arbitrary large
 anon folios
Message-ID: <ZLVeeDmPDWupYzSH@casper.infradead.org>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-2-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717143110.260162-2-ryan.roberts@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 03:31:08PM +0100, Ryan Roberts wrote:
> In preparation for the introduction of large folios for anonymous
> memory, we would like to be able to split them when they have unmapped
> subpages, in order to free those unused pages under memory pressure. So
> remove the artificial requirement that the large folio needed to be at
> least PMD-sized.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>  		 */
> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
> +		if (folio_test_large(folio) && folio_test_anon(folio))
>  			if (!compound || nr < nr_pmdmapped)
>  				deferred_split_folio(folio);

I wonder if it's worth introducing a folio_test_deferred_split() (better
naming appreciated ...) to allow us to allocate order-1 folios and not
do horrible things.  Maybe it's not worth supporting order-1 folios;
we're always better off going to order-2 immediately.  Just thinking.
