Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69179EB2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbjIMOcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbjIMOcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:32:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93C198
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pmWwPYKXVDejW5jO+e3W8gOpJicEZfd10euL8JNWonk=; b=H/IxsfNrNlGdxjmFpV8gc+rhaw
        MDCkmQWyYUqWMLF6RnsP7bK67giWpZYTgMo3MevG417JHBSZRrjyCBziiz5+bCcVfHCbrr0uR9nJg
        Ng0TOKZBDCa43h5oykjySIzAJfujqqN7UqBU5uiJWdwQ0Hw7F/OwBHhRawbo9FsGm9jMC0YBFyNw2
        8XxAkvWJqrsn8UAZ7/50efL85e6wTmVvgIj25JGqq8VlN4q+88g1BcHICF8o+3DK1bVFNoxcv1ZGs
        nkj7Dm4OLwhQ6WuihbESO8rRW4CyKSmenXIj0SaJpYO6qpSTv2eKLubTt/31IkLU1HYMoNA8uMzeP
        iUqxfb2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgQuX-00EMjK-C1; Wed, 13 Sep 2023 14:32:09 +0000
Date:   Wed, 13 Sep 2023 15:32:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 2/6] mm/rmap: move SetPageAnonExclusive out of
 __page_set_anon_rmap()
Message-ID: <ZQHH6ZC9aHQaqlNJ@casper.infradead.org>
References: <20230913125113.313322-1-david@redhat.com>
 <20230913125113.313322-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913125113.313322-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 02:51:09PM +0200, David Hildenbrand wrote:
> @@ -1246,11 +1241,13 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>  
>  	if (likely(!folio_test_ksm(folio))) {
>  		if (first)
> -			__page_set_anon_rmap(folio, page, vma, address,
> -					     !!(flags & RMAP_EXCLUSIVE));
> +			__folio_set_anon(folio, vma, address,
> +					 !!(flags & RMAP_EXCLUSIVE));
>  		else
>  			__page_check_anon_rmap(folio, page, vma, address);
>  	}
> +	if (flags & RMAP_EXCLUSIVE)
> +		SetPageAnonExclusive(page);

Won't we end up setting AnonExclusive on ksm pages, or do we make sure
to never pass RMAP_EXCLUSIVE for ksm pages?

Maybe better to move these last two lines inside the previous test,
just to avoid the question.
