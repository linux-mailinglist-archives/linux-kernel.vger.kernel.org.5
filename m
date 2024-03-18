Return-Path: <linux-kernel+bounces-105940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19887E6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B707B283127
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A62D05A;
	Mon, 18 Mar 2024 10:06:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACC2D043;
	Mon, 18 Mar 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756372; cv=none; b=kDUyuyV/vSvZYqur+nJROUFalItbcyCs478B97NZpMmlk17H4lKfev4g7oiuR8IP18O6AzTB1rlqIktvt6H7X8YfD5kE8c91/Ct8zice1No61EnPB8hX0Cd/wMS0L5PA+7AuGca4M6QkTEdemK18rsyGaoUnaddaQxBUWWG9a60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756372; c=relaxed/simple;
	bh=RPnZJlihau7sJRd6TqoEUFRAI6uPe4HBOe2/3ut4XAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRm3aYsA03pvFD6zwXl9cfVpBx8Uj17bIL8fuqvbDUTt7E8WsEHLvP3pdCjA+USn0GknQRdNMh/vgkV8a9SCpFhw0CKa3QuVTPETax+2Wrki3OX2cgnMoG78mRpOa+VSgrh0ss4gEYNeeToN6bTxSA5ONXqU0JzuhCE3yKf7/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5867BC433F1;
	Mon, 18 Mar 2024 10:06:09 +0000 (UTC)
Message-ID: <43d27ed7-94ff-4916-b1f3-07204b2f54ab@xs4all.nl>
Date: Mon, 18 Mar 2024 11:06:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 3/9] media: test-drivers: Set REQBUFS minimum number
 of buffers
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org,
 tfiga@chromium.org, m.szyprowski@samsung.com, ezequiel@vanguardiasur.com.ar,
 p.zabel@pengutronix.de, nicolas@ndufresne.ca
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
 <20240314153226.197445-4-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240314153226.197445-4-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Benjamin,

On 14/03/2024 4:32 pm, Benjamin Gaignard wrote:
> Instead of using 'min_queued_buffers' field to specify the
> minimum number of buffers to be allocated when calling REQBUF
> use 'min_reqbufs_allocation' field which is dedicated to this
> purpose.
> 
> While at it rename vivid_create_queue() parameter.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/test-drivers/vimc/vimc-capture.c | 2 +-
>  drivers/media/test-drivers/vivid/vivid-core.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
> index 2a2d19d23bab..97693561f1e4 100644
> --- a/drivers/media/test-drivers/vimc/vimc-capture.c
> +++ b/drivers/media/test-drivers/vimc/vimc-capture.c
> @@ -432,7 +432,7 @@ static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
>  	q->mem_ops = vimc_allocator == VIMC_ALLOCATOR_DMA_CONTIG
>  		   ? &vb2_dma_contig_memops : &vb2_vmalloc_memops;
>  	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> -	q->min_queued_buffers = 2;
> +	q->min_reqbufs_allocation = 2;
>  	q->lock = &vcapture->lock;
>  	q->dev = v4l2_dev->dev;
>  
> diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
> index 159c72cbb5bf..11b8520d9f57 100644
> --- a/drivers/media/test-drivers/vivid/vivid-core.c
> +++ b/drivers/media/test-drivers/vivid/vivid-core.c
> @@ -861,7 +861,7 @@ static const struct media_device_ops vivid_media_ops = {
>  static int vivid_create_queue(struct vivid_dev *dev,
>  			      struct vb2_queue *q,
>  			      u32 buf_type,
> -			      unsigned int min_queued_buffers,
> +			      unsigned int min_reqbufs_allocation,
>  			      const struct vb2_ops *ops)
>  {
>  	if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE && dev->multiplanar)
> @@ -898,7 +898,7 @@ static int vivid_create_queue(struct vivid_dev *dev,
>  	q->mem_ops = allocators[dev->inst] == 1 ? &vb2_dma_contig_memops :
>  						  &vb2_vmalloc_memops;
>  	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> -	q->min_queued_buffers = supports_requests[dev->inst] ? 0 : min_queued_buffers;
> +	q->min_reqbufs_allocation = min_reqbufs_allocation;
>  	q->lock = &dev->mutex;
>  	q->dev = dev->v4l2_dev.dev;
>  	q->supports_requests = supports_requests[dev->inst];

How did you test this series? If I run the test-media script using the patch
v4l2-compliance (the v9 series) I get two failures. Both are traced to code
in vivid: meta_out_queue_setup() and touch_cap_queue_setup():

Both have this code:

        if (*nplanes) {
                if (sizes[0] < size)
                        return -EINVAL;
        } else {
                sizes[0] = size;
        }

        if (q_num_bufs + *nbuffers < 2)
                *nbuffers = 2 - q_num_bufs;

        *nplanes = 1;
        return 0;

It's the *nbuffers assignment that is wrong. Looking at vivid-core.c I see
that vivid_create_queue() is called with min_reqbufs_allocation set to 1 for
these two devices. I think that should be 2, and then the code above can
be dropped.

It is probably best to post a v21.1 3/9 patch only.

Regards,

	Hans



