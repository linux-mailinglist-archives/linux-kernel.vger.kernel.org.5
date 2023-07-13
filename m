Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C0C752710
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjGMPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjGMP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:29:14 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4030F4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:28:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-635fa79d7c0so9837496d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1689262130; x=1691854130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/80Ekd6DqzKLFqX46dYHjJZXY+rAS6rJgfP1rtkgTw=;
        b=E9hBr1jtJz/iksiAdsR2un2ICY/Q8lHi4KTgSuA/7iR3fqTHt+lPbTuN9+IPLgjjvt
         4cSAR5bN+HKxFrii46F8+XH89z2AirUAr2Wppx5SO7OarfVVsnvTYTl83mER9V5P/4dW
         vYqcfDG+DpazKcJ2rEldIgdTinGJ/qMmK9HI7wosH6ppxzdKKmGz1jJzcHbSBmelm3uF
         /ZPjjUNVscZLfAF9ByHAoAmD+iyFcwzYSG5NNBzOnVzXuBdII0QG6ETfNteggNbDSXuS
         FNNRc3FWCjDzOkKEpwf+LhJDcJIEBl7qaL+01kClqrHS+0wmvv1GWm6/ir3IZFHRzG4o
         swBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262130; x=1691854130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/80Ekd6DqzKLFqX46dYHjJZXY+rAS6rJgfP1rtkgTw=;
        b=Eky1CZ90wBmSeiuQBYFYThQZebeXmO/kveL0TLIDjkVdLklEtx8p4U208yDHdxKF3N
         9H5lwd9b1icrN01nFpz/JTU6MTynZmb8MnAJlOlIc4QoCk+5IUji+tlWKnXGwbA5oBq4
         41yPhK7HFfI4+cGBNcLwUs6O57BQw2ssvUGAMHGubVTvz2sjeDiiD2T2v5RgSTwWn8bu
         obJ+64Krd7ZmqyrprgNdAe8iqPjr/IN1dlbIr9ggUO/ezsghRmsOJjiF3dGa9uViSSEQ
         wJTsTJPFLR2IWkmA1Q6M/RW5v9Z/s+xEBRelrqnU+akaKfbQixxB+zLL4m9haXOuzAiQ
         G4iA==
X-Gm-Message-State: ABy/qLZRRmMTEBhkdolyOOgw+h4wJS7VceIzY7KkqsbPhPbskwa2IXOw
        1LeLAV8djIYJuF65cgYkDbK9pQ==
X-Google-Smtp-Source: APBJJlEPmbtWoVegAbCrTRJayFAcpqN6oOQKID1ZEfTn5WBgGrZqLXQyComslaaPYjdCn2i0GnHvHw==
X-Received: by 2002:a05:6214:20e7:b0:62f:fe47:d478 with SMTP id 7-20020a05621420e700b0062ffe47d478mr32572qvk.8.1689262129830;
        Thu, 13 Jul 2023 08:28:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:f593])
        by smtp.gmail.com with ESMTPSA id d22-20020a0cb2d6000000b00631fea4d5bcsm3168522qvf.95.2023.07.13.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:28:49 -0700 (PDT)
Date:   Thu, 13 Jul 2023 11:28:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     James Gowans <jgowans@amazon.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Minghao Chi <chi.minghao@zte.com.cn>
Subject: Re: [RFC] mm: compaction: suitable_migration_target checks for
 higher order buddies
Message-ID: <20230713152848.GA495602@cmpxchg.org>
References: <20230712155421.875491-1-jgowans@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712155421.875491-1-jgowans@amazon.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 05:54:21PM +0200, James Gowans wrote:
> Huge page compaction finds free target pages to which source pages can
> be migrated when compacting.  A huge page sized and aligned block is
> considered a valid source of target pages if it passes the
> suitable_migration_target() test. One of the things which
> suitable_migration_target() does is to ensure that the entire block
> isn't currently free. It would counter productive to use an already
> fully free huge page sized block as a migration target because using
> pages from that free huge page block would decrease the number of
> available huge pages in the system.
> 
> suitable_migration_source() attempts to ensure that the supplied block
> is not currently a fully free block by checking PageBuddy flag on the
> starting page of the huge page sized and aligned block. This approach is
> flawed: the buddy list can and does maintain buddies at a larger order
> than huge page size. For example on a typical x86 system, huge page
> pageblock_order is 2 MiB, but the buddy list MAX_ORDER is 4 MiB. Because
> of this, a pageblock_order sized block may be free because it is part of
> a larger order buddy list buddy, but the pageblock_order sized block
> won't itself be part of the buddy list, only the larger order block will
> be. The current suitable_migration_target() implementation of just
> checking the PageBuddy flag on the pageblock_order block is hence
> insufficient as it will appear that the block is not free and hence try
> to use it as a source of migration target pages.
> 
> Enhance suitable_migration_target() to cater for this case by scanning
> up the buddy orders from the current pageblock_order page to MAX_ORDER
> to see if any of the larger page blocks have the PageBuddy flag set.
> 
> In practice incorrectly considering a page block as a suitable migration
> target doesn't actually cause the block to be broken down. That block is
> passed to isolate_freepages_block() which will scan it for any pages
> currently in the buddy list. The assumption is that buddy list nodes
> will be found because the entire block is not free. In the case
> described above actually no buddy list nodes will be found because the
> higher order block is free. It's just unnecessary scanning.
> 
> As such, the user visible effect of this change is only (in theory [1])
> very slightly faster huge compaction by avoiding scanning entirely free
> blocks for free pages. Even if the effect is negligible, this change
> better conveys what the function is attempting to do: check whether this
> page block is entirely free or not.
> 
> [1] I have not actually measured whether the difference is noticeable.

This is an interesting find. But because it's working correctly right
now, this patch is a performance optimization, so numbers would help.

> @@ -1342,15 +1342,40 @@ static bool suitable_migration_source(struct compact_control *cc,
>  static bool suitable_migration_target(struct compact_control *cc,
>  							struct page *page)
>  {
> -	/* If the page is a large free page, then disallow migration */
> -	if (PageBuddy(page)) {
> +	unsigned int higher_order;
> +	/*
> +	 * If the supplied page is part of a pageblock_order or larger free
> +	 * block it is not a suitable migration target block. Detect this case
> +	 * by starting at the pageorder_block aligned page and scan upwards to
> +	 * MAX_ORDER aligned page. Scan to see if any of the struct pages are
> +	 * in the buddy list for the order of the larger block. Disallow
> +	 * migration if so.
> +	 */
> +	for (higher_order = pageblock_order; higher_order <= MAX_ORDER; ++higher_order) {
> +		struct page *higher_order_page;
> +		unsigned long higher_order_pfn;
>  		/*
> -		 * We are checking page_order without zone->lock taken. But
> -		 * the only small danger is that we skip a potentially suitable
> -		 * pageblock, so it's not worth to check order for valid range.
> +		 * This is legal provided that struct pages are always initialised
> +		 * to at least start at MAX_ORDER alignment.
>  		 */
> -		if (buddy_order_unsafe(page) >= pageblock_order)
> -			return false;
> +		higher_order_pfn &= ~((1 << higher_order) - 1);
> +		higher_order_page = pfn_to_page(higher_order_pfn);
> +		if (PageBuddy(higher_order_page)) {
> +			/*
> +			 * We are checking page_order without zone->lock taken. But
> +			 * the only small danger is that we skip a potentially suitable
> +			 * pageblock, so it's not worth to check order for valid range.
> +			 */
> +			if (buddy_order_unsafe(higher_order_page) >= higher_order)
> +				return false;
> +			/*
> +			 * This is a buddy but not a sufficiently large buddy.
> +			 * There will never be a larger one above this.
> +			 */
> +			else
> +				break;
> +		}

One thing that's unfortunate is that isolate_freepages() will still
just skip one pageblock, even if you find the buddy further away than
that. This would check the same range at least twice (or more,
depending on the distance between pageblock_order and MAX_ORDER).

Instead of returning bool, it could make sense to return the pfn of
where you find the buddy, and then have isolate_freepages() skip and
continue the search at the pageblock below that.

Btw, this is also fixed by my patches that add the MIGRATE_FREE
type[1]. It has isolate_freepages() check this block type instead of
PageBuddy(), and that's set for all subblocks in a larger buddy.

[1] https://lore.kernel.org/lkml/20230418191313.268131-1-hannes@cmpxchg.org/ ]
