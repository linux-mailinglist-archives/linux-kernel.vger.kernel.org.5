Return-Path: <linux-kernel+bounces-15143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F68227AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9761C21979
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C948171C8;
	Wed,  3 Jan 2024 04:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtGrPA1O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E414F6E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704254577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNiVBcSgnS7YDhIhezexv4UQ/o2XjO1B9pVBfER0O5A=;
	b=TtGrPA1OCgMRM1KoDM/gKw2vMlyWN+S3Lwuo2zeUJOPihJ6Z2abqMiOAVd9RxjZeHL3B3L
	Ta/bZaEjYeHHILwBJwwIlzG07s5LD72QvWSLM6QSo+sw0MlBgMVZ9dxd9Ti4CGPFbUQrK+
	YpkpjTI8IvQ4eYO5HU13VxO2TJXUDhs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-s2T-O5voO0qFpYZX1FTeFA-1; Tue,
 02 Jan 2024 23:02:54 -0500
X-MC-Unique: s2T-O5voO0qFpYZX1FTeFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 801381C05134;
	Wed,  3 Jan 2024 04:02:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D4E8351E3;
	Wed,  3 Jan 2024 04:02:47 +0000 (UTC)
Date: Wed, 3 Jan 2024 12:02:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: bvanassche@acm.org, hch@lst.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	ming.lei@redhat.com
Subject: Re: [PATCH -next RFC] block: support to account io_ticks precisely
Message-ID: <ZZTcYyveSE6Sl0Dl@fedora>
References: <20231205093743.1823351-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205093743.1823351-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Tue, Dec 05, 2023 at 05:37:43PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, io_ticks is accounted based on sampling, specifically
> update_io_ticks() will always account io_ticks by 1 jiffies from
> bdev_start_io_acct()/blk_account_io_start(), and the result can be
> inaccurate, for example(HZ is 250):
> 
> Test script:
> fio -filename=/dev/sda -bs=4k -rw=write -direct=1 -name=test -thinktime=4ms
> 
> Test result: util is about 90%, while the disk is really idle.
> 
> In order to account io_ticks precisely, update_io_ticks() must know if
> there are IO inflight already, and this requires overhead slightly,
> hence precise io accounting is disabled by default, and user can enable
> it through sysfs entry.

Yeah, the trouble is from commit 5b18b5a73760 ("block: delete part_round_stats and
switch to less precise counting"), and real reason is that IO inflight
info is too expensive to maintain in fast path, and RH have got several customer
complaint in this area too.

> 
> Noted that for rq-based devcie, part_stat_local_inc/dec() and
> part_in_flight() is used to track inflight instead of iterating tags,
> which is not supposed to be used in fast path because 'tags->lock' is
> grabbed in blk_mq_find_and_get_req().

You can iterate over static requests via BT_TAG_ITER_STATIC_RQS, then
tags->lock can be bypassed, but new helper is needed.

But given it is only run once for each tick, I guess percpu counting
might be fine too even in case of big machine.

> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  Documentation/ABI/stable/sysfs-block |  8 ++++--
>  block/blk-core.c                     | 17 ++++++++----
>  block/blk-mq.c                       | 18 ++++++++++---
>  block/blk-sysfs.c                    | 40 ++++++++++++++++++++++++++--
>  block/blk.h                          |  4 ++-
>  block/genhd.c                        |  6 ++---
>  include/linux/blk-mq.h               |  1 +
>  include/linux/blkdev.h               |  3 +++
>  8 files changed, 80 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 1fe9a553c37b..e5fedecf7bdf 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -358,8 +358,12 @@ What:		/sys/block/<disk>/queue/iostats
>  Date:		January 2009
>  Contact:	linux-block@vger.kernel.org
>  Description:
> -		[RW] This file is used to control (on/off) the iostats
> -		accounting of the disk.
> +		[RW] This file is used to control the iostats accounting of the
> +		disk. If this value is 0, iostats accounting is disabled; If
> +		this value is 1, iostats accounting is enabled, but io_ticks is
> +		accounted by sampling and the result is not accurate; If this
> +		value is 2, iostats accounting is enabled and io_ticks is
> +		accounted precisely, but there will be slightly overhead.

IMO, this approach looks fine.

>  
>  
>  What:		/sys/block/<disk>/queue/logical_block_size
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fdf25b8d6e78..405883d606cd 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -935,14 +935,20 @@ int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
>  }
>  EXPORT_SYMBOL_GPL(iocb_bio_iopoll);
>  
> -void update_io_ticks(struct block_device *part, unsigned long now, bool end)
> +void update_io_ticks(struct block_device *part, unsigned long now, bool end,
> +		     bool precise)
>  {
>  	unsigned long stamp;
>  again:
>  	stamp = READ_ONCE(part->bd_stamp);
> -	if (unlikely(time_after(now, stamp))) {
> -		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
> +	if (unlikely(time_after(now, stamp)) &&
> +	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now))) {
> +		if (precise) {
> +			if (end || part_in_flight(part))
> +				__part_stat_add(part, io_ticks, now - stamp);

Strictly speaking, `end` isn't need any more, but it can be thought
as one optimization, given part_in_flight() is supposed to be non-zero
in case of account_done.

> +		} else {
>  			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
> +		}
>  	}
>  	if (part->bd_partno) {
>  		part = bdev_whole(part);
> @@ -954,7 +960,8 @@ unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
>  				 unsigned long start_time)
>  {
>  	part_stat_lock();
> -	update_io_ticks(bdev, start_time, false);
> +	update_io_ticks(bdev, start_time, false,
> +			blk_queue_precise_io_stat(bdev->bd_queue));

blk_queue_precise_io_stat() can be moved into update_io_ticks()
directly, and it should be fine given it is just done once in each
tick.

Thanks,
Ming


