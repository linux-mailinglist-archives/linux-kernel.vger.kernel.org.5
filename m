Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAAB76CC82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjHBMWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjHBMWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:22:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68846269D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QCOWbNxTPoEqKAFwIDBh0pTUiwLMUpnUoYaj0aoYiOs=; b=gEMB8KpMav/+K8RKzJMV2gvzzj
        S129f7+76wuz/c48ZqHCwhPtuX+BjWS1l56V9zoXKaGOLEB6PMrBUr64nNAJMkn+e2ta1PhFrr0tp
        63ZCuGMaYHfbRJ8zJ1EUv8KgPGuTy6x2C1rvviydJiPcYJbN2u3YRQ5nw1fRIqUty4t59q9egJAfJ
        sPB1TM4+VmNAjDBg+HjrnQciPJCX6AjVqhUFTxqAfcCPisxFKG3C+YevzI5aPUaTZ/MgpzFQ7shis
        F6weO/Df8hKtSQt4QllXdrHMipCo1deR/FjAn0DByGS0HnegiVb4DPZR1WcQ+IsWhvmciH85qMZJ3
        7TYiVakQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRArR-00EvaZ-VE; Wed, 02 Aug 2023 12:21:53 +0000
Date:   Wed, 2 Aug 2023 13:21:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Message-ID: <ZMpKYfNWA/jNgEuL@casper.infradead.org>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802095346.87449-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:53:43PM +0800, Kefeng Wang wrote:
>  	err = -EACCES;
> -	if (page_mapcount(page) > 1 && !migrate_all)
> -		goto out_putpage;
> +	if (folio_estimated_sharers(folio) > 1 && !migrate_all)
> +		goto out_putfolio;

I do not think this is the correct change.  Maybe leave this line
alone.

> -	if (PageHuge(page)) {
> -		if (PageHead(page)) {
> -			isolated = isolate_hugetlb(page_folio(page), pagelist);
> +	if (folio_test_hugetlb(folio)) {
> +		if (folio_test_large(folio)) {

This makes no sense when you read it.  All hugetlb folios are large,
by definition.  Think about what this code used to do, and what it
should be changed to.

> +			isolated = isolate_hugetlb(folio, pagelist);
>  			err = isolated ? 1 : -EBUSY;
>  		}
>  	} else {
> -		struct page *head;
> -
> -		head = compound_head(page);
> -		isolated = isolate_lru_page(head);
> +		isolated = folio_isolate_lru(folio);
>  		if (!isolated) {
>  			err = -EBUSY;
> -			goto out_putpage;
> +			goto out_putfolio;
>  		}
>  
>  		err = 1;
> -		list_add_tail(&head->lru, pagelist);
> -		mod_node_page_state(page_pgdat(head),
> -			NR_ISOLATED_ANON + page_is_file_lru(head),
> -			thp_nr_pages(head));
> +		list_add_tail(&folio->lru, pagelist);
> +		node_stat_mod_folio(folio,
> +			NR_ISOLATED_ANON + folio_is_file_lru(folio),
> +			folio_nr_pages(folio));
>  	}
