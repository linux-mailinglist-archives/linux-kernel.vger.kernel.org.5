Return-Path: <linux-kernel+bounces-25930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CC382D876
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCC81F218DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EB82C696;
	Mon, 15 Jan 2024 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFOkDXeF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925E2C683
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705318702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvr1H4HWot08qDvWwNjLa4kBqu8J0KtTgh8LnyVOj1c=;
	b=PFOkDXeFUzgWcJcUXd/4cfCYpBdc9QJb/sNFXK4i+eHBuYSRvOnBG23AF91XjRVjF79c1Z
	7V7dR3f3aib8ahHgKklJfx1dPAydugm1dJnbx0EGMXw3R1mluNldIjXWVEIWcEAWUUbm8h
	gfjE/AXXJxVGK4DUxwJBDypjn1Xj4Po=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-BdaA_Z60PCOcXjrNB-qauQ-1; Mon,
 15 Jan 2024 06:38:17 -0500
X-MC-Unique: BdaA_Z60PCOcXjrNB-qauQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2F2C3C29A61;
	Mon, 15 Jan 2024 11:38:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C8E0492BFA;
	Mon, 15 Jan 2024 11:38:11 +0000 (UTC)
Date: Mon, 15 Jan 2024 19:38:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH for-6.8/block] block: support to account io_ticks
 precisely
Message-ID: <ZaUZH8v2i7YBklyc@fedora>
References: <20240109071332.2216253-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109071332.2216253-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Tue, Jan 09, 2024 at 03:13:32PM +0800, Yu Kuai wrote:
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

Just be curious, what is result with this patch? 0%?

> 
> In order to account io_ticks precisely, update_io_ticks() must know if
> there are IO inflight already, and this requires overhead slightly,
> hence precise io accounting is disabled by default, and user can enable
> it through sysfs entry.
> 
> Noted that for rq-based devcie, part_stat_local_inc/dec() and
> part_in_flight() is used to track inflight instead of iterating tags,
> which is not supposed to be used in fast path because 'tags->lock' is
> grabbed in blk_mq_find_and_get_req().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes from RFC v1:
>  - remove the new parameter for update_io_ticks();
>  - simplify update_io_ticks();
>  - use swith in queue_iostats_store();
>  - add missing part_stat_local_dec() in blk_account_io_merge_request();
> Changes from RFC v2:
>  - fix that precise is ignored for the first io in update_io_ticks();
> 
>  Documentation/ABI/stable/sysfs-block |  8 ++++--
>  block/blk-core.c                     | 10 +++++--
>  block/blk-merge.c                    |  3 ++
>  block/blk-mq-debugfs.c               |  2 ++
>  block/blk-mq.c                       | 11 +++++++-
>  block/blk-sysfs.c                    | 42 ++++++++++++++++++++++++++--
>  block/blk.h                          |  1 +
>  block/genhd.c                        |  2 +-
>  include/linux/blk-mq.h               |  1 +
>  include/linux/blkdev.h               |  3 ++
>  10 files changed, 74 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 1fe9a553c37b..79027bf2661a 100644
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
> +		accounted precisely, but there will be slightly more overhead.
>  
>  
>  What:		/sys/block/<disk>/queue/logical_block_size
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9520ccab3050..c70dc311e3b7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -954,11 +954,15 @@ EXPORT_SYMBOL_GPL(iocb_bio_iopoll);
>  void update_io_ticks(struct block_device *part, unsigned long now, bool end)
>  {
>  	unsigned long stamp;
> +	bool precise = blk_queue_precise_io_stat(part->bd_queue);
>  again:
>  	stamp = READ_ONCE(part->bd_stamp);
> -	if (unlikely(time_after(now, stamp))) {
> -		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
> -			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
> +	if (unlikely(time_after(now, stamp)) &&
> +	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now))) {
> +		if (end || (precise && part_in_flight(part)))
> +			__part_stat_add(part, io_ticks, now - stamp);
> +		else if (!precise)
> +			__part_stat_add(part, io_ticks, 1);

It should be better or readable to move 'bool precise' into the above branch,
given we only need to read the flag once in each tick.

Otherwise, this patch looks fine.

Thanks,
Ming


