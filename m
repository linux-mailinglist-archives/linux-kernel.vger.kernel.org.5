Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130997E5C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjKHRaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:30:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829DD1FF9;
        Wed,  8 Nov 2023 09:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H2zkVEPvH7oBasEzfGl3kL2RvaYaBO1+1nf9sgaN5go=; b=ZdarU8HTLeI+3VXpHsmRAd6/EN
        58u/kaSEFMl7acA7qNp5+a83pAUeQZnu/gYqsi1dl1uJ+xdsf7ZE2yEw0RVqilETPB2Ft0uRVdzFg
        bisNk7HFRWNZyleyr6LRtD+73q/QhXiY4NNCtrI8nE48GHWF1uplqHpBA9omugSeWoN9Wmh8gcBYk
        tM+65iEaEcIH+4F/E07cqzNkoxfP96zPdeNYBJkY5t0moIRSrY1yeLCyfAIu4xuh6WZGYj5uSwGVp
        iMMlc7BR56Oqsxa+TVwTJ5ULCe2+DMd4nvvjCkemvjxNU+CJ8Ub9acUANoWmzqWqdn65EEV2B6ABd
        R4XoZQPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0mND-002Guz-VU; Wed, 08 Nov 2023 17:29:52 +0000
Date:   Wed, 8 Nov 2023 17:29:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: Fix for negative counter: nr_file_hugepages
Message-ID: <ZUvFjzqTXg3WU2Q6@casper.infradead.org>
References: <20231108171517.2436103-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108171517.2436103-1-shr@devkernel.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 09:15:17AM -0800, Stefan Roesch wrote:
> While qualifiying the 6.4 release, the following warning was detected in
> messages:
> 
> vmstat_refresh: nr_file_hugepages -15664
> 
> The warning is caused by the incorrect updating of the NR_FILE_THPS
> counter in the function split_huge_page_to_list. The if case is checking
> for folio_test_swapbacked, but the else case is missing the check for
> folio_test_pmd_mappable. The other functions that manipulate the counter
> like __filemap_add_folio and filemap_unaccount_folio have the
> corresponding check.
> 
> I have a test case, which reproduces the problem. It can be found here:
>   https://github.com/sroeschus/testcase/blob/main/vmstat_refresh/madv.c
> 
> The test case reproduces on an XFS filesystem. Running the same test
> case on a BTRFS filesystem does not reproduce the problem.
> 
> AFAIK version 6.1 until 6.6 are affected by this problem.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Co-debugged-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
