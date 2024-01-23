Return-Path: <linux-kernel+bounces-35975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE883995D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1296C1F23328
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B182D6A;
	Tue, 23 Jan 2024 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsLzpfBz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5B50A64;
	Tue, 23 Jan 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037298; cv=none; b=isPE9iDWPoD3GNLi0RSLJ+34BseevENUJDkXYMkpz2JoOlSMHPixSWmx/2xH93gtRsemc3NsOpmrssEF6lcBnikBqzuwRT9jSN9KpqLQXp7aYWXh+DPPeHYGxwMCXZzhdhp1RzQRPj2m17lj0IgdrPNPFOx1NWrnLpyRnqc5w3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037298; c=relaxed/simple;
	bh=yUpKsP8bVl80uJpZfTJsdrlqZYLDIS9nN+AT5h0Y3hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK0tozJFjrGpIrJEZGSURu+ZNiIImo14UpuKZv8Gz5rzAgRJ1JqIG40xAf/8HMR5/zsC+WYQ3pNfESAqe3YInPEL9y/LSvoDTSNVLavY1BVaay5K+Yz8U6+e77MNgQTSQFQBlB9ATRIw68h7vfClcNiBA7PgsPvj8D3QrX3ua0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsLzpfBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F18C433F1;
	Tue, 23 Jan 2024 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706037297;
	bh=yUpKsP8bVl80uJpZfTJsdrlqZYLDIS9nN+AT5h0Y3hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MsLzpfBz//jNj6WTNX3v/HYwgipRg0uP3mI3V+orEgrXFs6JQUZpUshVL22Av9mqG
	 fQbMT4X/lC2E1T73SebaeykdGxZ5Yccn+xTVCMGMSS7ofCY1OYb5gGb5l97sBhOIby
	 rOgwjOGyLo4sEgiLdwDaDAHIflJoU16D5rG9vRygUVftJGD89pL/5Th/wmF9GwJg2l
	 QgGyyFNwG6KTcoKjMjlAmJ1utyi8MooF0TzmIZNRL52syH8+qkq6Fr66I8TKp1D2Bc
	 17RNuOI8OXnzqqnW7lVNsRqwKHNiz8PJaeVC3/lilfhP9MihYZmHHOn8HaxUddYF4c
	 iTSJN+9k9184g==
Date: Tue, 23 Jan 2024 12:14:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yi Sun <yi.sun@unisoc.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com,
	stefanha@redhat.com, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhiguo.niu@unisoc.com, hongyu.jin@unisoc.com, sunyibuaa@gmail.com
Subject: Re: [PATCH 1/2] blk-mq: introduce
 blk_mq_tagset_wait_request_completed()
Message-ID: <ZbAQLRLNSx-IRRwM@kbusch-mbp.dhcp.thefacebook.com>
References: <20240122110722.690223-1-yi.sun@unisoc.com>
 <20240122110722.690223-2-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122110722.690223-2-yi.sun@unisoc.com>

On Mon, Jan 22, 2024 at 07:07:21PM +0800, Yi Sun wrote:
> In some cases, it is necessary to wait for all requests to become complete
> status before performing other operations. Otherwise, these requests will never
> be processed successfully.
> 
> For example, when the virtio device is in hibernation, the virtqueues
> will be deleted. It must be ensured that virtqueue is not in use before being deleted.
> Otherwise the requests in the virtqueue will be lost. This function can ensure
> that all requests have been taken out of the virtqueues.
> 
> Prepare for fixing this kind of issue by introducing
> blk_mq_tagset_wait_request_completed().

Does blk_mq_freeze_queue() not work for your use case? I think that
should work unless you have some driver specific requests entered that
don't ever get released.
 
> +static bool blk_mq_tagset_count_inflight_rqs(struct request *rq, void *data)
> +{
> +	unsigned int *count = data;
> +
> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		(*count)++;
> +	return true;
> +}
> +
> +/**
> + * blk_mq_tagset_wait_request_completed - Wait for all inflight requests
> + * to become completed.
> + *
> + * Note: This function has to be run after all IO queues are shutdown.
> + */
> +void blk_mq_tagset_wait_request_completed(struct blk_mq_tag_set *tagset)
> +{
> +	while (true) {
> +		unsigned int count = 0;
> +
> +		blk_mq_tagset_busy_iter(tagset,
> +				blk_mq_tagset_count_inflight_rqs, &count);

If the tagset is shared, then one active user can prevent this from ever
completing. It sounds like your use case cares about just one specific
request_queue, not all of them.

> +		if (!count)
> +			break;
> +		msleep(20);
> +	}
> +}
> +EXPORT_SYMBOL(blk_mq_tagset_wait_request_completed);

