Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB84F7DB182
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjJ2Xhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2Xhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:37:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D836E9B;
        Sun, 29 Oct 2023 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=guqQZMi+S1KSEFshVxWJ2luwQG5HPiCtpJaksTTmti0=; b=Wo7WerlJhEgpQrY5ZBqa6AaM+u
        eR4dg/eHjvkTjQbqX3tLPPXvNPE/bgtdqm1WwiIVWjI11m6B+kDspU0GRBMULp/1I6L+mq3E66aQR
        G81NXlVt2ghXmGThaHLgGX+uWJWG68FiQYpLF5c/gYQ0+8U9ahKnxx8x7a2/gnce4PjMEvuxF6LcO
        e6b9sE5jh55LZ4Wic4UMfTL6J6IrCQnWpwdlV5NJfNbgu6FgVRFyhSvzl5p8UEUltyq4aPUR70u/B
        HeZ/L0OladO+JRwUOK4qruG0SWBCzPxw53IVJ+nOKiXvRld2K/OTG9HZdS2/pG3d/R2jC7WFHuN50
        vaepK3Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxFGJ-000jDh-MM; Sun, 29 Oct 2023 23:32:07 +0000
Date:   Sun, 29 Oct 2023 23:32:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC PATCH 10/11] shmem: add large folio support to the write
 path
Message-ID: <ZT7rd3CSr+VnKj7v@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
 <CGME20231028211551eucas1p1552b7695f12c27f4ea1b92ecb6259b31@eucas1p1.samsung.com>
 <20231028211518.3424020-11-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028211518.3424020-11-da.gomez@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 09:15:50PM +0000, Daniel Gomez wrote:
> +++ b/mm/shmem.c
> @@ -1621,6 +1621,9 @@ static struct folio *shmem_alloc_folio(gfp_t gfp, struct shmem_inode_info *info,
>  	pgoff_t ilx;
>  	struct page *page;
>  
> +	if ((order != 0) && !(gfp & VM_HUGEPAGE))
> +		gfp |= __GFP_COMP;

This is silly.  Just set it unconditionally.

> +static inline unsigned int
> +shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
> +			 size_t size, struct shmem_sb_info *sbinfo)
> +{
> +	unsigned int order = ilog2(size);
> +
> +	if ((order <= PAGE_SHIFT) ||
> +	    (!mapping_large_folio_support(mapping) || !sbinfo->noswap))
> +		return 0;
> +
> +	order -= PAGE_SHIFT;

You know we have get_order(), right?

