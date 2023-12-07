Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD9809515
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjLGWKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjLGWKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:10:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB698
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:10:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20215C433C8;
        Thu,  7 Dec 2023 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701987016;
        bh=sBNd3oxL6+a22NEO/VDNFOidep38poCkeBZb+XkzywM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=neI12TK/fHjGgZNDnLArNdLQEFClIYknp5Ch25AvJ3uzwa2mhmCuGfWn6SZmc4Xyh
         gQMahdRIXK77n5/TMkaJuK/OTaGAPpUr8VBnnr4q3wtd7Fji08gZbr7yFVPHi4KIgb
         kPw8zNI7nHJ/VS+tzDxLN1M0wA5VuigBoMI9/5Yj/pDRS49Sl+6w9ez2hmAT7NjNC7
         qQdXIGld6g178tGepH6B2006iUsLwQmpAinMxrh1bo76odHAfwiueeCK5A2UhUESZZ
         nVUMpRinVsxy8gbJ5s20Klo6zNQG6cK7+fyob9qhJiofGyOE3G4twLx4NuUzZqYJo8
         EHr/yFHXpV51A==
Date:   Thu, 7 Dec 2023 15:10:13 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-ID: <ZXJCxbAm1_V7lPnF@kbusch-mbp>
References: <20230814144100.596749-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814144100.596749-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 03:41:00PM +0100, Matthew Wilcox (Oracle) wrote:
>  void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
> -	struct bvec_iter_all iter_all;
> -	struct bio_vec *bvec;
> +	struct folio_iter fi;
> +
> +	bio_for_each_folio_all(fi, bio) {
> +		struct page *page;
> +		size_t done = 0;
>  
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		if (mark_dirty && !PageCompound(bvec->bv_page))
> -			set_page_dirty_lock(bvec->bv_page);
> -		bio_release_page(bio, bvec->bv_page);
> +		if (mark_dirty) {
> +			folio_lock(fi.folio);
> +			folio_mark_dirty(fi.folio);
> +			folio_unlock(fi.folio);
> +		}
> +		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> +		do {
> +			bio_release_page(bio, page++);
> +			done += PAGE_SIZE;
> +		} while (done < fi.length);
>  	}
>  }

Is it okay to release same-folio pages while creating the bio instead of
releasing all the pages at the completion? If so, the completion could
provide just the final bio_release_page() instead looping. I'm more
confirming if that's an appropriate way to use folios here.
