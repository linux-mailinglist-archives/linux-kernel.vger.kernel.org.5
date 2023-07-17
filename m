Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1C675653D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGQNkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjGQNke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:40:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8313BC7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OjcJNfI+ZFsjHCpKJy4DcI+Lam5MgEbyR3vKrF75hvk=; b=sNqY+OXhxUClUB7xAXZjrPH1lI
        K8RGdXd/0ZJ0S/l/tgC75d5SD4NAXz2xUVxkjo9mxF4syd2zpTJliExEkS8h2RvcA2/VM3NjJVq6+
        OrRwUsB5HenSqG+hYhnc7m8xxupgc5Hk+Ii156mpISEZ12TzRtc12zzivIMrPQDE6Ukx52UzIgYih
        6TbOYeKc8jlO/ZwlcWaPSnFIO82K5RRjLOMxq1DWLq3/lmnm889qsXf6iBofzWh55d42tR32w8o49
        PS2wTnPuONSl5T+c+oyCKteKMMjBvyOa+IRZZGeBTx5Va+k7KeH4KmG+GIcbDlnIHjsIJoT3JX7m7
        u9cuIfbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLOSe-003xHn-Al; Mon, 17 Jul 2023 13:40:24 +0000
Date:   Mon, 17 Jul 2023 14:40:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 2/6] mm/page_io: use a folio in sio_read_complete()
Message-ID: <ZLVEyG7SZMzgY7ov@casper.infradead.org>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-3-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717132602.2202147-3-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:25:58PM +0800, Peng Zhang wrote:
> +++ b/mm/page_io.c
> @@ -406,19 +406,19 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>  
>  	if (ret == sio->len) {
>  		for (p = 0; p < sio->pages; p++) {
> -			struct page *page = sio->bvec[p].bv_page;
> +			struct folio *folio = page_folio(sio->bvec[p].bv_page);
>  
> -			SetPageUptodate(page);
> -			unlock_page(page);
> +			folio_mark_uptodate(folio);
> +			folio_unlock(folio);
>  		}

I'm kind of shocked this works today.  Usually bvecs coalesce adjacent
pages into a single entry, so you need to use a real iterator like
bio_for_each_folio_all() to extract individual pages from a bvec.
Maybe the sio bvec is constructed inefficiently.

I think Kent had some bvec folio iterators in progress?

>  		count_vm_events(PSWPIN, sio->pages);
>  	} else {
>  		for (p = 0; p < sio->pages; p++) {
> -			struct page *page = sio->bvec[p].bv_page;
> +			struct folio *folio = page_folio(sio->bvec[p].bv_page);
>  
> -			SetPageError(page);
> -			ClearPageUptodate(page);
> -			unlock_page(page);
> +			folio_set_error(folio);
> +			folio_clear_uptodate(folio);
> +			folio_unlock(folio);

Similar questions to the last patch -- who checks the error flag on this
page/folio, and isn't the folio already !uptodate?

>  		}
>  		pr_alert_ratelimited("Read-error on swap-device\n");
>  	}
> -- 
> 2.25.1
> 
