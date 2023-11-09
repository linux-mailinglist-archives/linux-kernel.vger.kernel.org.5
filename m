Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538A37E6C80
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjKIOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjKIOgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:36:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25F22D7C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i/3avsOpLd3aZaWrgDNXJxmHWSlkc1l2DLIoTImK/GQ=; b=D2rqESR35iVv9aNRPQT5DbbQQ1
        D4KlbLopXeIeEKJwD9qPXGddscAVpziQIQQ6rsk/xzyv2qmQ9kFw63qmPr7+QD/FBI+M5Oj6avYVO
        T9CYOu8kv75GD3JtZCQZw86DS/yxhbEMbY3UpjDowYqtUQkrFQgAp8ze+4HKjsQIYFr6gFgE+pg3e
        eYutrhgJBzRrmnh0eFn7nYy0rvzKj5OZkCrJ8ZBavW2bRs0k/VXoko2K3r3SYu23g4EPursgbjRPj
        eE80tn3FgJ1gibRs46ZOd3rd3xJ69MVwmr/8uvM2k00gv8uIzXutODSKYvmGOU/iyvNrNkePh3N4K
        KM52jbiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r168X-007mgh-Ri; Thu, 09 Nov 2023 14:36:01 +0000
Date:   Thu, 9 Nov 2023 14:36:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Byungchul Park <byungchul@sk.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, david@redhat.com,
        peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [v4 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <ZUzuUf7JfhybYBgg@casper.infradead.org>
References: <20231109045908.54996-1-byungchul@sk.com>
 <20231109045908.54996-3-byungchul@sk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109045908.54996-3-byungchul@sk.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 01:59:07PM +0900, Byungchul Park wrote:
> +++ b/include/linux/page-flags.h
> @@ -136,6 +136,7 @@ enum pageflags {
>  	PG_arch_2,
>  	PG_arch_3,
>  #endif
> +	PG_migrc,		/* Page is under migrc's control */
>  	__NR_PAGEFLAGS,

Yeah; no.  We're out of page flags.  And CXL is insufficiently
compelling to add more.  If you use CXL, you don't care about
performance, by definition.

> @@ -589,6 +590,9 @@ TESTCLEARFLAG(Young, young, PF_ANY)
>  PAGEFLAG(Idle, idle, PF_ANY)
>  #endif
>  
> +TESTCLEARFLAG(Migrc, migrc, PF_ANY)
> +__PAGEFLAG(Migrc, migrc, PF_ANY)

Why PF_ANY?

> +/*
> + * Initialize the page when allocated from buddy allocator.
> + */
> +static inline void migrc_init_page(struct page *p)
> +{
> +	__ClearPageMigrc(p);
> +}

This flag should already be clear ... ?

> +/*
> + * Check if the folio is pending for TLB flush and then clear the flag.
> + */
> +static inline bool migrc_unpend_if_pending(struct folio *f)
> +{
> +	return folio_test_clear_migrc(f);
> +}

If you named the flag better, you wouldn't need this wrapper.

> +static void migrc_mark_pending(struct folio *fsrc, struct folio *fdst)
> +{
> +	folio_get(fsrc);
> +	__folio_set_migrc(fsrc);
> +	__folio_set_migrc(fdst);
> +}

This is almost certainly unsafe.  By using the non-atomic bit ops, you
stand the risk of losing a simultaneous update to any other bit in this
word.  Like, say, someone trying to lock the folio?

> +++ b/mm/page_alloc.c
> @@ -1535,6 +1535,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  
>  	set_page_owner(page, order, gfp_flags);
>  	page_table_check_alloc(page, order);
> +
> +	for (i = 0; i != 1 << order; ++i)
> +		migrc_init_page(page + i);

No.

