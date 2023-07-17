Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A23C756512
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGQNek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGQNei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:34:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CEB8F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wKKN1YUOoGsvhPfY2Rq6Z6lVgG5y1GpB+sjDgdgd22g=; b=ecUGWeYlGsQSQf8xRjneISGn2t
        um0nVCPO+s6BHHUrXZeCihb57E4O/+NZM2xNNJcN0u4qJvQDSGjUZI0o4M2fWxKEstVh9+att8Cew
        dLcdpnhgG+F5YJFqIWEoaBOPpyCYAQFJcihb68na5EGvTh/NCtifOziWXrjGfktFKH8ifNKzyBesF
        2z5ExPnpIkOiIG7alWfDNj0yQarKZ2D2ZJbdB4QpoaE2QTDlW1tUC/MajWuq4a02id/+XpvVuHta1
        HmSRQIrDJ5B9O177wv3iww6nfseREhZS3/dagQoOUVGh/sKpbvGYERfDh7CydB6cWuh7MLVTKuPr4
        +i/5fLDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLOMs-003wzt-It; Mon, 17 Jul 2023 13:34:26 +0000
Date:   Mon, 17 Jul 2023 14:34:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH 1/6] mm/page_io: use a folio in __end_swap_bio_read()
Message-ID: <ZLVDYjdflF+3oJCG@casper.infradead.org>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-2-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717132602.2202147-2-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:25:57PM +0800, Peng Zhang wrote:
> +++ b/mm/page_io.c
> @@ -58,18 +58,18 @@ static void end_swap_bio_write(struct bio *bio)
>  
>  static void __end_swap_bio_read(struct bio *bio)
>  {
> -	struct page *page = bio_first_page_all(bio);
> +	struct folio *folio = page_folio(bio_first_page_all(bio));

Should we have a bio_first_folio_all()?  It wouldn't save any calls to
compound_head(), but it's slightly easier to use.

>  	if (bio->bi_status) {
> -		SetPageError(page);
> -		ClearPageUptodate(page);
> +		folio_set_error(folio);

I appreciate this is a 1:1 conversion, but maybe we could think about
this a bit.  Is there anybody who checks the
PageError()/folio_test_error() for this page/folio?

> +		folio_clear_uptodate(folio);

Similarly ... surely the folio is already !uptodate, so we don't need to
clear the flag?

