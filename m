Return-Path: <linux-kernel+bounces-123930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03967890FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274651C24939
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B74125B2;
	Fri, 29 Mar 2024 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIkVkHvn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309312E48
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673678; cv=none; b=b9Pwmm5CjGyYO3Z02U8qjyo+n+Yiom+joKz91FahVdPsl+qlhKjwxFn47yiPWnnI2a+G7pg92pP1PODYEyedoobCl5aWD3pZwnNIoYxbP991orjaihCQTOJEuVK5k3dWdWZ42RIKKkRCmmQyzwwfkxMEJqLWM58qHvYBNMHOQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673678; c=relaxed/simple;
	bh=yqVTYnwDDcFXueqNFnLAymJnOE8hQMqwwCmtGw1XHBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNXe7hb9UWaQJPFJq+AQlNRjNIlgNN7TjvEPsYBLQxJgx0m44e5fi+Bq05PhJiJIHHgPMOKs4Nhlc55Pd2P5AWsGPRBphYt/PaYUpcd9kIFjI72ECYEtX79JMDhaJEAz91Dj6RkCzg/wlP3Ybh/AwNg3iUNWebCwAS1HYj7i2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIkVkHvn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711673675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FFbjCyFMWwfVTQ7/3Wxygk8+OAR68hADZgcsWJnmq0U=;
	b=EIkVkHvnYC1hEXJDsHXWexrwogFCg6pM17lA0bYL6+c0Kh5j0LwMLcuFFtlLN1eIi2ES/s
	PsE6cmWBEc8gHIvW4x6ltWPuCOfe+F0vp8L6uWf5UpwLdwCmK0fzQeofO6KQWUUloi/ThC
	8GSDBcwkaeu0FVQttHwRsGtJfzTWV68=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-N0BlVr9xPpmKD97oO2Z2uw-1; Thu, 28 Mar 2024 20:54:31 -0400
X-MC-Unique: N0BlVr9xPpmKD97oO2Z2uw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFE8D8164E3;
	Fri, 29 Mar 2024 00:54:30 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E0E8200AFFC;
	Fri, 29 Mar 2024 00:54:28 +0000 (UTC)
Date: Thu, 28 Mar 2024 19:54:21 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 6/9] dm-linear: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <zetfekdpoq6rmas26o7jl2uvricjcv6zygi6cngf6mkmiev5kn@e5d4ie3m77ku>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-7-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328203910.2370087-7-stefanha@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Thu, Mar 28, 2024 at 04:39:07PM -0400, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/md/dm-linear.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 2d3e186ca87e3..9b6cdfa4f951d 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -147,6 +147,30 @@ static int linear_report_zones(struct dm_target *ti,
>  #define linear_report_zones NULL
>  #endif
>  
> +static loff_t linear_seek_hole_data(struct dm_target *ti, loff_t offset,
> +		int whence)
> +{
> +	struct linear_c *lc = ti->private;
> +	loff_t ti_begin = ti->begin << SECTOR_SHIFT;
> +	loff_t ti_len = ti->len << SECTOR_SHIFT;
> +	loff_t bdev_start = lc->start << SECTOR_SHIFT;
> +	loff_t bdev_offset;

Okay, given my questions in 4/9, it looks like your intent is that
each callback for dm_seek_hole_data will obey its own ti-> limits.

> +
> +	/* TODO underflow/overflow? */
> +	bdev_offset = offset - ti_begin + bdev_start;
> +
> +	bdev_offset = blkdev_seek_hole_data(lc->dev->bdev, bdev_offset,
> +					    whence);
> +	if (bdev_offset < 0)
> +		return bdev_offset;
> +
> +	offset = bdev_offset - bdev_start;
> +	if (offset >= ti_len)
> +		return whence == SEEK_DATA ? -ENXIO : ti_begin + ti_len;

However, this is inconsistent with dm_blk_seek_hole_data_default in
4/9; I think you want to unconditionally return -ENXIO here, and let
the caller figure out when to turn -ENXIO back into end to proceed
with the next ti in the list.

OR, you may want to document the semantics that dm_seek_hole_data
callbacks must NOT return -ENXIO, but always return ti_begin + ti_len
when the answer (either SEEK_HOLE or SEEK_END) did not lie within the
current ti - it is DIFFERENT than the semantics for
blkdev_seek_hole_data, but gets normalized back into the expected
-ENXIO answer when dm_blk_do_seek_hole_data finally advances past the
last ti.

At any rate, I know this is an RFC series, but it goes to show that
comments will be essential, whichever interface you decide for
callbacks to honor (both a guarantee that callbacks will only ever see
SEEK_HOLE/SEEK_DATA in bounds, because earlier points in the call
stack have filtered out out-of-bounds and SEEK_SET; and constraints on
what the return value(s) must be for the various callbacks, especially
if it is different from the eventual return value of the overall
llseek syscall)

> +
> +	return offset + ti_begin;
> +}
> +
>  static int linear_iterate_devices(struct dm_target *ti,
>  				  iterate_devices_callout_fn fn, void *data)
>  {
> @@ -212,6 +236,7 @@ static struct target_type linear_target = {
>  	.direct_access = linear_dax_direct_access,
>  	.dax_zero_page_range = linear_dax_zero_page_range,
>  	.dax_recovery_write = linear_dax_recovery_write,
> +	.seek_hole_data = linear_seek_hole_data,
>  };
>  
>  int __init dm_linear_init(void)
> -- 
> 2.44.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


