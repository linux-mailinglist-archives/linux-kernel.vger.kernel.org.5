Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAA781079D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjLMBZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378177AbjLMBZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A04CA7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702430756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+Fi662eTBH61l7dziQI31ojIowi0xTylG+eKXF8CnY=;
        b=NEPzLyB676JyqYQ/Ueq9RkfXVT0oghLuZ0Aw7Xq2AWQHfO8TJdu9YLCXLFQloDyf0JF8IC
        o2BnnVkmai89sktHpYekcolerWUXkQIRgpzHAHpOSFR4qBm5Jnvb5DzurXPzgRpvSv+pXA
        gL0nUsXjw7vRLFkEeeLR0YuG6lwgD/E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-C7-uyY69MkKS7aFFTyZZzQ-1; Tue, 12 Dec 2023 20:25:52 -0500
X-MC-Unique: C7-uyY69MkKS7aFFTyZZzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1ED9833B41;
        Wed, 13 Dec 2023 01:25:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B04C3C25;
        Wed, 13 Dec 2023 01:25:42 +0000 (UTC)
Date:   Wed, 13 Dec 2023 09:25:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        jaswin@linux.ibm.com, bvanassche@acm.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v2 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <ZXkIEnQld577uHqu@fedora>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-2-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:08:29AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add the following limits:
> - atomic_write_boundary_bytes
> - atomic_write_max_bytes
> - atomic_write_unit_max_bytes
> - atomic_write_unit_min_bytes
> 
> All atomic writes limits are initialised to 0 to indicate no atomic write
> support. Stacked devices are just not supported either for now.
> 
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> #jpg: Heavy rewrite
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 47 ++++++++++++++++++++++
>  block/blk-settings.c                 | 60 ++++++++++++++++++++++++++++
>  block/blk-sysfs.c                    | 33 +++++++++++++++
>  include/linux/blkdev.h               | 37 +++++++++++++++++
>  4 files changed, 177 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 1fe9a553c37b..ba81a081522f 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -21,6 +21,53 @@ Description:
>  		device is offset from the internal allocation unit's
>  		natural alignment.
>  
> +What:		/sys/block/<disk>/atomic_write_max_bytes
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the maximum atomic write
> +		size reported by the device. This parameter is relevant
> +		for merging of writes, where a merged atomic write
> +		operation must not exceed this number of bytes.
> +		The atomic_write_max_bytes may exceed the value in
> +		atomic_write_unit_max_bytes if atomic_write_max_bytes
> +		is not a power-of-two or atomic_write_unit_max_bytes is
> +		limited by some queue limits, such as max_segments.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_unit_min_bytes
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the smallest block which can
> +		be written atomically with an atomic write operation. All
> +		atomic write operations must begin at a
> +		atomic_write_unit_min boundary and must be multiples of
> +		atomic_write_unit_min. This value must be a power-of-two.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_unit_max_bytes
> +Date:		January 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter defines the largest block which can be
> +		written atomically with an atomic write operation. This
> +		value must be a multiple of atomic_write_unit_min and must
> +		be a power-of-two.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_boundary_bytes
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] A device may need to internally split I/Os which
> +		straddle a given logical block address boundary. In that
> +		case a single atomic write operation will be processed as
> +		one of more sub-operations which each complete atomically.
> +		This parameter specifies the size in bytes of the atomic
> +		boundary if one is reported by the device. This value must
> +		be a power-of-two.
> +
>  
>  What:		/sys/block/<disk>/diskseq
>  Date:		February 2021
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 0046b447268f..d151be394c98 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -59,6 +59,10 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
>  	lim->dma_alignment = 511;
> +	lim->atomic_write_unit_min_sectors = 0;
> +	lim->atomic_write_unit_max_sectors = 0;
> +	lim->atomic_write_max_sectors = 0;
> +	lim->atomic_write_boundary_sectors = 0;

Can we move the four into single structure and setup them in single
API? Then cross-validation can be done in this API.

>  }
>  
>  /**
> @@ -183,6 +187,62 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  }
>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>  
> +/**
> + * blk_queue_atomic_write_max_bytes - set max bytes supported by
> + * the device for atomic write operations.
> + * @q:  the request queue for the device
> + * @size: maximum bytes supported
> + */
> +void blk_queue_atomic_write_max_bytes(struct request_queue *q,
> +				      unsigned int bytes)
> +{
> +	q->limits.atomic_write_max_sectors = bytes >> SECTOR_SHIFT;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);

What if driver doesn't call it but driver supports atomic write?

I guess the default max sectors should be atomic_write_unit_max_sectors
if the feature is enabled.

> +
> +/**
> + * blk_queue_atomic_write_boundary_bytes - Device's logical block address space
> + * which an atomic write should not cross.
> + * @q:  the request queue for the device
> + * @bytes: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
> +					   unsigned int bytes)
> +{
> +	q->limits.atomic_write_boundary_sectors = bytes >> SECTOR_SHIFT;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_boundary_bytes);

Default atomic_write_boundary_sectors should be
atomic_write_unit_max_sectors in case of atomic write?

> +
> +/**
> + * blk_queue_atomic_write_unit_min_sectors - smallest unit that can be written
> + * atomically to the device.
> + * @q:  the request queue for the device
> + * @sectors: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
> +					     unsigned int sectors)
> +{
> +	struct queue_limits *limits = &q->limits;
> +
> +	limits->atomic_write_unit_min_sectors = sectors;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_min_sectors);

atomic_write_unit_min_sectors should be >= (physical block size >> 9)
given the minimized atomic write unit is physical sector for all disk.

> +
> +/*
> + * blk_queue_atomic_write_unit_max_sectors - largest unit that can be written
> + * atomically to the device.
> + * @q: the request queue for the device
> + * @sectors: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
> +					     unsigned int sectors)
> +{
> +	struct queue_limits *limits = &q->limits;
> +
> +	limits->atomic_write_unit_max_sectors = sectors;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_max_sectors);

atomic_write_unit_max_sectors should be >= atomic_write_unit_min_sectors.


Thanks, 
Ming

