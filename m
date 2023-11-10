Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDD7E81A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346446AbjKJSbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346119AbjKJS2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:28:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D53B923
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699632225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7LLLmKlkTqdbQdg/nQJ6XhAMm0kN7EMtZc4aqahAzZY=;
        b=EU/mlVW++FmUsQ3e0U4of8GphKP2XI5/iM5n0uFHX4Z3DehdF1SPftzsHXZSuSLWdEukW2
        aUu1CMBB3DK/tUX+pIklVgIe8rMofI6Vv2kMAtR5CWOcoziWJZNRD4L38YSMDZKk7iuVOl
        YQcDQ6PNxC3wN4oVX24ojL66nAAPhHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-UzdHz-rJN-C_1u5cphBx7g-1; Fri, 10 Nov 2023 11:03:41 -0500
X-MC-Unique: UzdHz-rJN-C_1u5cphBx7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF577185A786;
        Fri, 10 Nov 2023 16:03:40 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B54240C6EB9;
        Fri, 10 Nov 2023 16:03:32 +0000 (UTC)
Date:   Sat, 11 Nov 2023 00:03:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ed.tsai@mediatek.com
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, chun-hung.wu@mediatek.com,
        casper.li@mediatek.com, will.shiu@mediatek.com,
        light.hsieh@mediatek.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, ming.lei@redhat.com
Subject: Re: [PATCH v2] block: limit the extract size to align queue limit
Message-ID: <ZU5UTqnV4En0XBPB@fedora>
References: <20231110051950.21972-1-ed.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110051950.21972-1-ed.tsai@mediatek.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 01:19:49PM +0800, ed.tsai@mediatek.com wrote:
> From: Ed Tsai <ed.tsai@mediatek.com>
> 
> When an application performs a large IO, it fills and submits multiple
> full bios to the block layer. Referring to commit 07173c3ec276
> ("block: enable multipage bvecs"), the full bio size is no longer fixed
> at 1MB but can vary based on the physical memory layout.
> 
> The size of the full bio no longer aligns with the maximum IO size of
> the queue. Therefore, in a 64MB read, you may see many unaligned bios
> being submitted.
> 
> Executing the command to perform a 64MB read:
> 
> 	dd if=/data/test_file of=/dev/null bs=64m count=1 iflag=direct
> 
> It demonstrates the submission of numerous unaligned bios:
> 
> 	block_bio_queue: 254,52 R 2933336 + 2136
> 	block_bio_queue: 254,52 R 2935472 + 2152
> 	block_bio_queue: 254,52 R 2937624 + 2128
> 	block_bio_queue: 254,52 R 2939752 + 2160
> 
> This patch limits the number of extract pages to ensure that we submit
> the bio once we fill enough pages, preventing the block layer from
> spliting small I/Os in between.
> 
> I performed the Antutu V10 Storage Test on a UFS 4.0 device, which
> resulted in a significant improvement in the Sequential test:
> 
> Sequential Read (average of 5 rounds):
> Original: 3033.7 MB/sec
> Patched: 3520.9 MB/sec
> 
> Sequential Write (average of 5 rounds):
> Original: 2225.4 MB/sec
> Patched: 2800.3 MB/sec
> 
> Link: https://lore.kernel.org/linux-arm-kernel/20231025092255.27930-1-ed.tsai@mediatek.com/
> Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> 
> ---
>  block/bio.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 816d412c06e9..8d3a112e68da 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1227,8 +1227,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	iov_iter_extraction_t extraction_flags = 0;
>  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
>  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> +	struct block_device *bdev = bio->bi_bdev;
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>  	struct page **pages = (struct page **)bv;
> +	ssize_t max_extract = UINT_MAX - bio->bi_iter.bi_size;
>  	ssize_t size, left;
>  	unsigned len, i = 0;
>  	size_t offset;
> @@ -1242,7 +1244,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>  
> -	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
> +	if (bdev && blk_queue_pci_p2pdma(bdev->bd_disk->queue))
>  		extraction_flags |= ITER_ALLOW_P2PDMA;
>  
>  	/*
> @@ -1252,16 +1254,21 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	 * result to ensure the bio's total size is correct. The remainder of
>  	 * the iov data will be picked up in the next bio iteration.
>  	 */
> -	size = iov_iter_extract_pages(iter, &pages,
> -				      UINT_MAX - bio->bi_iter.bi_size,
> +	if (bdev && bio_op(bio) != REQ_OP_ZONE_APPEND) {
> +		unsigned int max = queue_max_bytes(bdev_get_queue(bdev));
> +
> +		max_extract = bio->bi_iter.bi_size ?
> +			max - bio->bi_iter.bi_size & (max - 1) : max;
> +	}
> +	size = iov_iter_extract_pages(iter, &pages, max_extract,
>  				      nr_pages, extraction_flags, &offset);

The above is just what I did in the 'slow path' of patch v2[1], and it can't work
well for every extracting pages which is usually slow, and batching
extracting pages should be done always, such as:

1) build one ublk disk(suppose it is /dev/ublkb0) with max sectors of 32k:

- rublk add null --io-buf-size=16384 -q 2	[2]

2) run 64KB IO

fio --direct=1 --size=230G --bsrange=64k-64k --runtime=20 --numjobs=2 --ioengine=libaio \
	--iodepth=64 --iodepth_batch_submit=64 --iodepth_batch_complete_min=64 --group_reporting=1 \
	--filename=/dev/ublkb0 --name=/dev/ublkb0-test-randread --rw=randread

In my local VM, read BW is dropped to 3709MB/s from 20GB/s in the above
fio test with this patch.

The point is that:

1) bio size alignment is only needed in case of multiple bios

2) bio size alignment is needed only when the current bio is approaching
to become FULL

3) with multiple bvec, it is hard to know how many pages can be held
in bvecs beforehand

In short, running every alignment is much less efficient.


[1] https://lore.kernel.org/linux-block/202311100354.HYfqOQ7o-lkp@intel.com/T/#u
[2] install rublk via `cargo install --version=^0.1 rublk` and
CONFIG_BLK_DEV_UBLK is required

Thanks, 
Ming

