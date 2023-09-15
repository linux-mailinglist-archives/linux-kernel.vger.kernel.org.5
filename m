Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB17A2029
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjIONt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjIONt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:49:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB7926B8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UIIhXNicKHnnfcqIBqQZ6OYm4L0/hzD6ZeRNbDy+XHc=; b=cul73f0l14bcuYtUcvN9r7dVKs
        DcurGPe+nrC5goDeEd1PUy62+J/VZP2dW6a0uPG+1Aa4aKTNkmJhILPvN758RreVgCSZDhDBKaD18
        s9+JwvAJPyijhJ7oKOdna1B1JZvMY6SQ9Wi8RjGpMOkK1vL7aP25/eRG9WCKIirOWbK6wItUxv6BI
        0utrrklNHiI4Ioepl+L5YmGWka1WGlrEED+nDJJapteTCXDb1w9F46OJ1AhGCh9L/cUt0+IKde0ct
        7LNqA4V36vXtu3p8qxqavZcaejnyfLNd7W39dzAGQ3ZDyIFYSlabAPCyHgZ2WxHPDkn6ahaThLBN/
        H158gsSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qh9CV-00A1sQ-QO; Fri, 15 Sep 2023 13:49:39 +0000
Date:   Fri, 15 Sep 2023 14:49:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: convert __page_check_anon_rmap() to folio
Message-ID: <ZQRg89X67vKL8Q4d@casper.infradead.org>
References: <20230915101731.1725986-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915101731.1725986-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 06:17:31PM +0800, Yajun Deng wrote:
> @@ -1176,8 +1175,8 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
>  	 */
>  	VM_BUG_ON_FOLIO(folio_anon_vma(folio)->root != vma->anon_vma->root,
>  			folio);
> -	VM_BUG_ON_PAGE(page_to_pgoff(page) != linear_page_index(vma, address),
> -		       page);
> +	VM_BUG_ON_FOLIO(folio_pgoff(folio) != linear_page_index(vma, address),
> +		       folio);

No, this is not equivalent.  You haven't hit any problems testing it
because you don't have large anonymous folios.

