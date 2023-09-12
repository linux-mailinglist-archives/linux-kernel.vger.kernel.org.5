Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4DF79D82B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbjILR4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237211AbjILR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:56:15 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD410EF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:56:11 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6556d05a55fso31923626d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694541371; x=1695146171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4IhYeB0YxtIaCDBZz0UEzpIO0PR5QWLYjcVC9SEpKA=;
        b=fcjJVBgtfcwtW+l/+OzkNY5dib47Ag2EeSTdFYlkRo30FXFea+ZOdFURkqxSb3fntc
         5T3bun/bjae1C75r//TBsuIIhz2Q2Rg3cJoQGnfNc61t3L4Qwwx94vlMH7gXEoPkyVbv
         tUhYIvPg360f19Fs7hcNhQzHZft5GY3vpcYrwpppZ0D0E/nrGIEpj98e5QeTPGfxxfNs
         hnEtk11OK+tnrUHTf00eFSaj5Rrw86LEfPOEYiKolqVk02iWMvUHP7U4sATnruMWMrZq
         sWjfdr36ycOi5U+K1/2E+NIkwg+hxZ79SiXxb4MrvNoxuQlL5SIL8Q+vhqv1KjpJUCvw
         ec2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541371; x=1695146171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4IhYeB0YxtIaCDBZz0UEzpIO0PR5QWLYjcVC9SEpKA=;
        b=DwcoIjNwHBgb0yJ3DCcxLiTasGizBmBsaUchbQYteAKPqHsQwWRgY3/JttUj91k/2X
         1J9ok3GjpznYKx1X+aXsTwU3wZZCc6140vKXeuKCvPSB9stmrRlJV8yyRrGHIETXss/p
         TmGO6LydH4bp3USgA9GLJxeFcYrzY2buGmkf6P25QqaU+gua1QEGc+G5H74/oJlRJuMU
         ijg3NEpx2IhHC5sYOryaBO49O5C18ZYH/DlIow4ZJiyuB8Q1ZNDlsntV3G7xZ8C3ExM6
         /ZV/gib20pe5z34jKVKE/aChkJYj2C8GcN9BNT5rR6/IQPxW4abrD+TzR6zT3OYcxJKh
         LdBA==
X-Gm-Message-State: AOJu0Yxtr+yMkIMDgEH0UmHm2IA/9MFWJsxhMlxw26AWyTFgan/o6L6O
        sQbNdtUAAk6gbbN+Fc8jNHjSlA==
X-Google-Smtp-Source: AGHT+IHMl4rjeTD1z5d9sbmC4XZdGewFfSDjPv1SOboURcLudwLKitRMq75HOOrGTQ9kiILB0EdT5Q==
X-Received: by 2002:a05:6214:4a04:b0:64f:5729:7994 with SMTP id pg4-20020a0562144a0400b0064f57297994mr193814qvb.30.1694541370968;
        Tue, 12 Sep 2023 10:56:10 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id a17-20020a0ce391000000b006418c076f59sm3760138qvl.100.2023.09.12.10.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:56:10 -0700 (PDT)
Date:   Tue, 12 Sep 2023 13:56:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zi Yan <zi.yan@sent.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 3/4] mm/compaction: optimize >0 order folio
 compaction by sorting source pages.
Message-ID: <20230912175610.GC34089@cmpxchg.org>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <20230912162815.440749-4-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912162815.440749-4-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:28:14PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It should maximize high order free page use and minimize free page splits.
> It might be useful before free page merging is implemented.

The premise sounds reasonable to me: start with the largest chunks in
the hope of producing the desired block size before having to piece
things together from the order-0s dribbles.

> @@ -145,6 +145,38 @@ static void sort_free_pages(struct list_head *src, struct free_list *dst)
>  	}
>  }
>  
> +static void sort_folios_by_order(struct list_head *pages)
> +{
> +	struct free_list page_list[MAX_ORDER + 1];
> +	int order;
> +	struct folio *folio, *next;
> +
> +	for (order = 0; order <= MAX_ORDER; order++) {
> +		INIT_LIST_HEAD(&page_list[order].pages);
> +		page_list[order].nr_free = 0;
> +	}
> +
> +	list_for_each_entry_safe(folio, next, pages, lru) {
> +		order = folio_order(folio);
> +
> +		if (order > MAX_ORDER)
> +			continue;
> +
> +		list_move(&folio->lru, &page_list[order].pages);
> +		page_list[order].nr_free++;
> +	}
> +
> +	for (order = MAX_ORDER; order >= 0; order--) {
> +		if (page_list[order].nr_free) {
> +
> +			list_for_each_entry_safe(folio, next,
> +						 &page_list[order].pages, lru) {
> +				list_move_tail(&folio->lru, pages);
> +			}
> +		}
> +	}
> +}
> +
>  #ifdef CONFIG_COMPACTION
>  bool PageMovable(struct page *page)
>  {
> @@ -2636,6 +2668,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  				pageblock_start_pfn(cc->migrate_pfn - 1));
>  		}
>  
> +		sort_folios_by_order(&cc->migratepages);

Would it make sense to have isolate_migratepages_block() produce a
sorted list already? By collecting into a struct free_list in there
and finishing with that `for (order = MAX...) list_add_tail()' loop.

That would save quite a bit of shuffling around. Compaction can be
hot, and is expected to get hotter with growing larger order pressure.

The contig allocator doesn't care about ordering, but it should be
possible to gate the sorting reasonably on !cc->alloc_contig.

An optimization down the line could be to skip the sorted list
assembly for the compaction case entirely, have compact_zone() work
directly on struct free_list, starting with the highest order and
checking compact_finished() in between orders.
