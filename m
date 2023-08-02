Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D1C76CCAD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjHBMbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjHBMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:31:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95C99B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w9tr1AR4GmU5vaVxpOCOeNBoe0QTS0eYPR8meuRf/nA=; b=Sty7cJ5I21M8pIW4vcPtXwcLTD
        wQ/lq/rUczznk1i6mZJJW+DHIjI6Nyhnqe68OyZW+pH5fn0qrkduW0/m0uhcG9/cdRBqXTuKHVLKy
        1aD2p+pBmBIy1NAPTwVRde13kciPSuh/DsMZfA8QbLf8YjYISmJQSUIYCvDCKEy52IpVfcHIZijfq
        yJSIJpJT4Q3ZskApOYQl1lEpvgkIzLXAVII58nPMrPyPWM1UN2P05Qibg3X+6DCr/Ajb0rnnBW8C4
        LdaQE+uI5nTuVIgXZmZQjVUbYNX1LKxIfkz6oy3BvR56JmkP+kD5ol4M1uEDYVaEtRfiTN7kI8+/m
        I+1zVq3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRB09-00EvsP-Rf; Wed, 02 Aug 2023 12:30:53 +0000
Date:   Wed, 2 Aug 2023 13:30:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/4] mm: migrate: convert numamigrate_isolate_page() to
 numamigrate_isolate_folio()
Message-ID: <ZMpMfQUktateeN1D@casper.infradead.org>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802095346.87449-3-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:53:44PM +0800, Kefeng Wang wrote:
> -static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
> +static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
>  {
> -	int nr_pages = thp_nr_pages(page);
> -	int order = compound_order(page);
> +	int nr_pages = folio_nr_pages(folio);
> +	int order = folio_order(folio);
>  
> -	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
> +	VM_BUG_ON_FOLIO(order && !folio_test_pmd_mappable(folio), folio);

I don't know why we have this assertion.  I would be inclined to delete
it as part of generalising the migration code to handle arbitrary sizes
of folio, rather than assert that we only support PMD size folios.

>  	/* Do not migrate THP mapped by multiple processes */
> -	if (PageTransHuge(page) && total_mapcount(page) > 1)
> +	if (folio_test_pmd_mappable(folio) && folio_estimated_sharers(folio) > 1)
>  		return 0;

I don't know if this is the right logic.  We've willing to move folios
mapped by multiple processes, as long as they're smaller than PMD size,
but once they get to PMD size they're magical and can't be moved?

