Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B097A7597FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGSOSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjGSOSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:18:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3181FF9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9EXZcJ4PYuH8+4ZYXhCfHFTWxB9XGfut+FegrCXyocU=; b=He/lF2pNq0xVn+UVeq4FX+s3sr
        iEXY8o0RzxrOqMqxsC8cMawG6ruO8lEL1do+Rk1s7dTwfbWYLGuQ8wFgHKqSWvDYojh3vJUVdrLLN
        qVYbgxe0QZmFQt9qGvpG6wqj/55wVZ+dWM89Xwm1wVn9XI8JLn8KJvWnx8QJMpXrLlJ5OwWtcDXPK
        yO/3SCgRHM/PMKXtJglM5QRVPcufQ5QOLPtZEEFjrDxganPcocELNg624tZhzXJvjxTdqFKfAs45v
        /uPySp01prEg+gN/JST9u1oFW8juQHxDVTet3vbic/VjxKX5WwH/jdFUeJ5DPyQVHKO3ZmU+lzuRf
        Rg2BJiiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qM7zi-0068E6-Va; Wed, 19 Jul 2023 14:17:35 +0000
Date:   Wed, 19 Jul 2023 15:17:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v2 3/9] mm/page_io: convert bio_first_page_all() to
 bio_first_folio_all()
Message-ID: <ZLfwfhMkegLUav/B@casper.infradead.org>
References: <20230719095848.3422629-1-zhangpeng362@huawei.com>
 <20230719095848.3422629-4-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719095848.3422629-4-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 05:58:42PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Convert bio_first_page_all() to bio_first_folio_all() to return a
> folio, which makes it easier to use.

This wasn't what I was suggesting.  Indeed, this may introduce bugs.
I was suggesting adding bio_first_folio_all() so that it can be used
by code that knows this is what it wants.

> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>  Documentation/block/biovecs.rst  | 2 +-
>  drivers/block/drbd/drbd_bitmap.c | 2 +-
>  fs/f2fs/data.c                   | 2 +-
>  include/linux/bio.h              | 4 ++--
>  kernel/power/swap.c              | 2 +-
>  mm/page_io.c                     | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/block/biovecs.rst b/Documentation/block/biovecs.rst
> index ddb867e0185b..258f6faed333 100644
> --- a/Documentation/block/biovecs.rst
> +++ b/Documentation/block/biovecs.rst
> @@ -133,7 +133,7 @@ Usage of helpers:
>  	bio_for_each_segment_all()
>  	bio_for_each_bvec_all()
>  	bio_first_bvec_all()
> -	bio_first_page_all()
> +	bio_first_folio_all()
>  	bio_last_bvec_all()
>  
>  * The following helpers iterate over single-page segment. The passed 'struct
> diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
> index 85ca000a0564..ce1a07ba85ff 100644
> --- a/drivers/block/drbd/drbd_bitmap.c
> +++ b/drivers/block/drbd/drbd_bitmap.c
> @@ -939,7 +939,7 @@ static void drbd_bm_endio(struct bio *bio)
>  	struct drbd_bm_aio_ctx *ctx = bio->bi_private;
>  	struct drbd_device *device = ctx->device;
>  	struct drbd_bitmap *b = device->bitmap;
> -	unsigned int idx = bm_page_to_idx(bio_first_page_all(bio));
> +	unsigned int idx = bm_page_to_idx(&bio_first_folio_all(bio)->page);
>  
>  	if ((ctx->flags & BM_AIO_COPY_PAGES) == 0 &&
>  	    !bm_test_page_unchanged(b->bm_pages[idx]))
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 5882afe71d82..6706858de984 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -288,7 +288,7 @@ static void f2fs_post_read_work(struct work_struct *work)
>  
>  static void f2fs_read_end_io(struct bio *bio)
>  {
> -	struct f2fs_sb_info *sbi = F2FS_P_SB(bio_first_page_all(bio));
> +	struct f2fs_sb_info *sbi = F2FS_P_SB(&bio_first_folio_all(bio)->page);
>  	struct bio_post_read_ctx *ctx;
>  	bool intask = in_task();
>  
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index c4f5b5228105..7d2979d24530 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -248,9 +248,9 @@ static inline struct bio_vec *bio_first_bvec_all(struct bio *bio)
>  	return bio->bi_io_vec;
>  }
>  
> -static inline struct page *bio_first_page_all(struct bio *bio)
> +static inline struct folio *bio_first_folio_all(struct bio *bio)
>  {
> -	return bio_first_bvec_all(bio)->bv_page;
> +	return page_folio(bio_first_bvec_all(bio)->bv_page);
>  }
>  
>  static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index f6ebcd00c410..2796ce48ca4b 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -247,7 +247,7 @@ static void hib_finish_batch(struct hib_bio_batch *hb)
>  static void hib_end_io(struct bio *bio)
>  {
>  	struct hib_bio_batch *hb = bio->bi_private;
> -	struct page *page = bio_first_page_all(bio);
> +	struct page *page = &bio_first_folio_all(bio)->page;
>  
>  	if (bio->bi_status) {
>  		pr_alert("Read-error on swap-device (%u:%u:%Lu)\n",
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 5ddb5d9c5013..e21d570c873d 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -29,7 +29,7 @@
>  
>  static void __end_swap_bio_write(struct bio *bio)
>  {
> -	struct page *page = bio_first_page_all(bio);
> +	struct page *page = &bio_first_folio_all(bio)->page;
>  
>  	if (bio->bi_status) {
>  		/*
> @@ -57,7 +57,7 @@ static void end_swap_bio_write(struct bio *bio)
>  
>  static void __end_swap_bio_read(struct bio *bio)
>  {
> -	struct page *page = bio_first_page_all(bio);
> +	struct page *page = &bio_first_folio_all(bio)->page;
>  
>  	if (bio->bi_status) {
>  		pr_alert_ratelimited("Read-error on swap-device (%u:%u:%llu)\n",
> -- 
> 2.25.1
> 
