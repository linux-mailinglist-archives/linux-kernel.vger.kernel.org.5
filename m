Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB17546BD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 06:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGOEHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 00:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGOEHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 00:07:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935363594
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 21:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E6BKvalc76lCISIlkA/GnH7FAR2tEutl4Xg0nyimIoc=; b=q2aBEUe+ad0PVFePYgpW3j8qVg
        JLhgMydUFQrcarZZZCVOjLXoQQHGERh1YmHzeA8176T18gNQZrgPZsnYU3/YrLlS2fvjAywmBoxqH
        NuEWQrba1HvD2dUgLOqtKOJOtsXHeUipp3iSy5EKNkP3Or4GCj2BpilAExEHslhQ++NP8njkowJ/s
        1Dqwg1lLn9Kib+F/TVnLRPiRaSauh6GpHfAT5vLuvyrzSwElE+6nEC4gD1ATsqnDgBWSd42hyDht4
        tH5rxTuYo52MT6MtQqAalwfUckXk2w5ND2Eh1RBfwjGcgeCZJKprKPOXV9RTnEQmUukxDZKqQr+qg
        6/XTXKhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWYh-001oOJ-DQ; Sat, 15 Jul 2023 04:07:03 +0000
Date:   Sat, 15 Jul 2023 05:07:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com
Subject: Re: [PATCH mm-unstable 8/8] mm/memory-failure: convert
 unpoison_memory() to folios
Message-ID: <ZLIbZygG7LqSI9xe@casper.infradead.org>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
 <20230112204608.80136-9-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112204608.80136-9-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 02:46:08PM -0600, Sidhartha Kumar wrote:
> @@ -2348,7 +2347,6 @@ int unpoison_memory(unsigned long pfn)
>  		return -ENXIO;
>  
>  	p = pfn_to_page(pfn);
> -	page = compound_head(p);
>  	folio = page_folio(p);
>  
>  	mutex_lock(&mf_mutex);
> @@ -2360,31 +2358,31 @@ int unpoison_memory(unsigned long pfn)
>  		goto unlock_mutex;
>  	}
>  
> -	if (!PageHWPoison(p)) {
> +	if (!folio_test_hwpoison(folio)) {

This is wrong.  You need to test the individual page for PageHWPoison()
instead of testing the folio.  I understand that this will work for
hugetlbfs pages, but for THP, it's the individual pages that get poisoned,
and folio_test_hwpoison() on a THP actually only tests the head page.

Ideas for preventing this mistake in the future gratefully received.
