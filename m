Return-Path: <linux-kernel+bounces-17439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83957824D42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E901F21D01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9E44403;
	Fri,  5 Jan 2024 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea8f5tm9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006920EE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704422988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kHYrItYGiAQsYKD5ffJYn6ZPwoCN+6n7GbgnD9P3fo=;
	b=ea8f5tm9Kb1VGDgKOP7vP1qMl3zaRyUmBBL01XE1wik9aIVfMJi9UbNpAj/GLYcTl7HWER
	BLSwmUlnOXMYM5DKLDBuYLC9bwaysDeAxJ0PyakmWL7IGHMjUDkuhCrWwRWqXAOCHAslXK
	uNJ93M4GXMySpRQt1dAoyUIhjQeV9tU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-_laBTFaEPmOb3xHH_6Ruxg-1; Thu, 04 Jan 2024 21:49:43 -0500
X-MC-Unique: _laBTFaEPmOb3xHH_6Ruxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38F7783BA82;
	Fri,  5 Jan 2024 02:49:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.136])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 992CD3C25;
	Fri,  5 Jan 2024 02:49:38 +0000 (UTC)
Date: Fri, 5 Jan 2024 10:49:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH for-6.8/block RFC v2] block: support to account io_ticks
 precisely
Message-ID: <ZZduPrwMrwOLQiU7@fedora>
References: <20240103071515.2477311-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103071515.2477311-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Wed, Jan 03, 2024 at 03:15:15PM +0800, Yu Kuai wrote:
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
> 
> Noted that for rq-based devcie, part_stat_local_inc/dec() and
> part_in_flight() is used to track inflight instead of iterating tags,
> which is not supposed to be used in fast path because 'tags->lock' is
> grabbed in blk_mq_find_and_get_req().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v2:
>  - remove the new parameter for update_io_ticks();
>  - simplify update_io_ticks();
>  - use swith in queue_iostats_store();
>  - add missing part_stat_local_dec() in blk_account_io_merge_request()

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming


