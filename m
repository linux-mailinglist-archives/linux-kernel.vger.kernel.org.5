Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0932B7E493F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjKGTfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:35:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C981184;
        Tue,  7 Nov 2023 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RMzfASwureNH8zSRhEEH/Mxu6HknK4f+eaK1G9SLRAc=; b=I3TeLlCaus6IkrVTGgwZHy8o2k
        bAB0PaSS3TAxVd81jvQdhVgm9k+Z/Ya5i5gNv713ULe03Vo+EK+tRXPJv2+KSthlk0ZjSlwf+YpJA
        FTiIj05R/wy8pkP0rYCupnMoxuCjEW937iD9tvlr1jeia7rxgV6PNhXtK8rcjQ4Df+RZ+fycAoWzW
        +Nq9/uEerZcBE2l0EgZjzNeuYonBHLvJssv2ssmBPoEWyehdl70glLATggwHk80hLYrdt5BltWpKe
        rNOBE7V1F9fm46+u6wGXBROSOP4TM2poPh+NT2Y3NewYCPR2asGjMDOe40yDUsWR7kOmS2CDzrXi0
        hG6mMhfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0RrN-00E9U4-T7; Tue, 07 Nov 2023 19:35:37 +0000
Date:   Tue, 7 Nov 2023 19:35:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: Fix for negative counter: nr_file_hugepages
Message-ID: <ZUqRia1Ww0+wNfKr@casper.infradead.org>
References: <20231107181805.4188397-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107181805.4188397-1-shr@devkernel.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:18:05AM -0800, Stefan Roesch wrote:
> +++ b/mm/huge_memory.c
> @@ -2740,7 +2740,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  			if (folio_test_swapbacked(folio)) {
>  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
>  							-nr);
> -			} else {
> +			} else if (folio_test_pmd_mappable(folio)) {
>  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
>  							-nr);
>  				filemap_nr_thps_dec(mapping);

As I said, we also need the folio_test_pmd_mappable() for swapbacked.
Not because there's currently a problem, but because we don't leave
landmines for other people to trip over in future!
