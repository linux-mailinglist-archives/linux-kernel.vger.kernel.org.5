Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3D7F3C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbjKVDax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbjKVDan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:30:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72A2D60
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700623836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6BAfBcLSn0+FOBzgusAMfyuBJsUaQ4efqNt4w+gDBI=;
        b=FoLa+4QOcFnZWFdo3YISK8pq71m7Lp8fSLlLcUes89MWns6Vmn18xF4i/xELaBfLPfOrph
        RbhkQwaP2CbN3C4tatoJu51g4PkdHn4Y6OwRUG6XFhdhbwqTVmDn2jF4Gt2ckadjW6z89X
        wlXbX84TcXgM3eJ74yFZL2WyRAMwFtA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-W6RdiiygN5qI39Br0IFzRA-1; Tue, 21 Nov 2023 22:30:32 -0500
X-MC-Unique: W6RdiiygN5qI39Br0IFzRA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBA488007B3;
        Wed, 22 Nov 2023 03:30:31 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D42F492BE0;
        Wed, 22 Nov 2023 03:30:26 +0000 (UTC)
Date:   Wed, 22 Nov 2023 11:30:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Message-ID: <ZV11zTuF7AX9eIIE@fedora>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122103103.1104589-3-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

On Wed, Nov 22, 2023 at 06:31:02PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are multiple switches in struct block_device, use separate bool
> fields for them is not gracefully. Add a new field bd_flags and replace
> swithes to a bit, there are no functional changes, and prepare to add
> a new switch in the next patch. In order to keep bd_flags in the first
> cacheline and prevent layout to be affected, define it as u16.
> 
> Also add new helpers to set/clear/test each bit like 'bio->bi_flags'.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bdev.c              | 15 ++++++++-------
>  block/blk-core.c          |  7 ++++---
>  block/genhd.c             | 15 +++++++++++----
>  block/ioctl.c             |  6 +++++-
>  include/linux/blk_types.h | 27 +++++++++++++++++++++------
>  include/linux/blkdev.h    |  5 +++--
>  6 files changed, 52 insertions(+), 23 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index e4cfb7adb645..10f524a7416c 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -402,10 +402,10 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  	bdev->bd_partno = partno;
>  	bdev->bd_inode = inode;
>  	bdev->bd_queue = disk->queue;
> -	if (partno)
> -		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
> +	if (partno && bdev_flagged(disk->part0, BD_FLAG_HAS_SUBMIT_BIO))
> +		bdev_set_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>  	else
> -		bdev->bd_has_submit_bio = false;
> +		bdev_clear_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>  	bdev->bd_stats = alloc_percpu(struct disk_stats);
>  	if (!bdev->bd_stats) {
>  		iput(inode);
> @@ -606,7 +606,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>  		bdev->bd_holder = NULL;
>  		bdev->bd_holder_ops = NULL;
>  		mutex_unlock(&bdev->bd_holder_lock);
> -		if (bdev->bd_write_holder)
> +		if (bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER))
>  			unblock = true;
>  	}
>  	if (!whole->bd_holders)
> @@ -619,7 +619,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>  	 */
>  	if (unblock) {
>  		disk_unblock_events(bdev->bd_disk);
> -		bdev->bd_write_holder = false;
> +		bdev_clear_flag(bdev, BD_FLAG_WRITE_HOLDER);
>  	}
>  }
>  
> @@ -805,9 +805,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		 * writeable reference is too fragile given the way @mode is
>  		 * used in blkdev_get/put().
>  		 */
> -		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
> +		if ((mode & BLK_OPEN_WRITE) &&
> +		    !bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER) &&
>  		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
> -			bdev->bd_write_holder = true;
> +			bdev_set_flag(bdev, BD_FLAG_WRITE_HOLDER);
>  			unblock_events = false;
>  		}
>  	}
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fdf25b8d6e78..f9f8b12ba626 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -482,7 +482,8 @@ __setup("fail_make_request=", setup_fail_make_request);
>  
>  bool should_fail_request(struct block_device *part, unsigned int bytes)
>  {
> -	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
> +	return bdev_flagged(part, BD_FLAG_MAKE_IT_FAIL) &&
> +		should_fail(&fail_make_request, bytes);
>  }
>  
>  static int __init fail_make_request_debugfs(void)
> @@ -595,7 +596,7 @@ static void __submit_bio(struct bio *bio)
>  	if (unlikely(!blk_crypto_bio_prep(&bio)))
>  		return;
>  
> -	if (!bio->bi_bdev->bd_has_submit_bio) {
> +	if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO)) {
>  		blk_mq_submit_bio(bio);
>  	} else if (likely(bio_queue_enter(bio) == 0)) {
>  		struct gendisk *disk = bio->bi_bdev->bd_disk;
> @@ -703,7 +704,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>  	 */
>  	if (current->bio_list)
>  		bio_list_add(&current->bio_list[0], bio);
> -	else if (!bio->bi_bdev->bd_has_submit_bio)
> +	else if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO))
>  		__submit_bio_noacct_mq(bio);
>  	else
>  		__submit_bio_noacct(bio);
> diff --git a/block/genhd.c b/block/genhd.c
> index c9d06f72c587..57f96c0c8da0 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  	elevator_init_mq(disk->queue);
>  
>  	/* Mark bdev as having a submit_bio, if needed */
> -	disk->part0->bd_has_submit_bio = disk->fops->submit_bio != NULL;
> +	if (disk->fops->submit_bio)
> +		bdev_set_flag(disk->part0, BD_FLAG_HAS_SUBMIT_BIO);
>  
>  	/*
>  	 * If the driver provides an explicit major number it also must provide
> @@ -1062,7 +1063,8 @@ static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
>  ssize_t part_fail_show(struct device *dev,
>  		       struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_make_it_fail);
> +	return sprintf(buf, "%d\n",
> +		       bdev_flagged(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL));
>  }
>  
>  ssize_t part_fail_store(struct device *dev,
> @@ -1071,8 +1073,13 @@ ssize_t part_fail_store(struct device *dev,
>  {
>  	int i;
>  
> -	if (count > 0 && sscanf(buf, "%d", &i) > 0)
> -		dev_to_bdev(dev)->bd_make_it_fail = i;
> +	if (count > 0 && sscanf(buf, "%d", &i) > 0) {
> +		if (!i)
> +			bdev_clear_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
> +		else
> +			bdev_set_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
> +
> +	}
>  
>  	return count;
>  }
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 4160f4e6bd5b..a64440f4c96b 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -394,7 +394,11 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
>  		if (ret)
>  			return ret;
>  	}
> -	bdev->bd_read_only = n;
> +
> +	if (!n)
> +		bdev_clear_flag(bdev, BD_FLAG_READ_ONLY);
> +	else
> +		bdev_set_flag(bdev, BD_FLAG_READ_ONLY);
>  	return 0;
>  }
>  
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index f7d40692dd94..de652045111b 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -37,6 +37,11 @@ struct bio_crypt_ctx;
>  #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
>  #define SECTOR_MASK		(PAGE_SECTORS - 1)
>  
> +#define BD_FLAG_READ_ONLY	0 /* read-only-policy */
> +#define BD_FLAG_WRITE_HOLDER	1
> +#define BD_FLAG_HAS_SUBMIT_BIO	2
> +#define BD_FLAG_MAKE_IT_FAIL	3
> +
>  struct block_device {
>  	sector_t		bd_start_sect;
>  	sector_t		bd_nr_sectors;
> @@ -44,10 +49,8 @@ struct block_device {
>  	struct request_queue *	bd_queue;
>  	struct disk_stats __percpu *bd_stats;
>  	unsigned long		bd_stamp;
> -	bool			bd_read_only;	/* read-only policy */
> +	unsigned short		bd_flags;
>  	u8			bd_partno;
> -	bool			bd_write_holder;
> -	bool			bd_has_submit_bio;
>  	dev_t			bd_dev;
>  	struct inode		*bd_inode;	/* will die */
>  
> @@ -67,9 +70,6 @@ struct block_device {
>  	struct super_block	*bd_fsfreeze_sb;
>  
>  	struct partition_meta_info *bd_meta_info;
> -#ifdef CONFIG_FAIL_MAKE_REQUEST
> -	bool			bd_make_it_fail;
> -#endif
>  	/*
>  	 * keep this out-of-line as it's both big and not needed in the fast
>  	 * path
> @@ -86,6 +86,21 @@ struct block_device {
>  #define bdev_kobj(_bdev) \
>  	(&((_bdev)->bd_device.kobj))
>  
> +static inline bool bdev_flagged(struct block_device *bdev, unsigned int bit)
> +{
> +	return bdev->bd_flags & (1U << bit);
> +}
> +
> +static inline void bdev_set_flag(struct block_device *bdev, unsigned int bit)
> +{
> +	bdev->bd_flags |= (1U << bit);
> +}
> +
> +static inline void bdev_clear_flag(struct block_device *bdev, unsigned int bit)
> +{
> +	bdev->bd_flags &= ~(1U << bit);
> +}

'U' becomes incorrect after .bd_flags is changed to 'unsigned short'.


Thanks,
Ming

