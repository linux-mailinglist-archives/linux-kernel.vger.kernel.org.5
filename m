Return-Path: <linux-kernel+bounces-27443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8943D82F030
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F89BB233A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDCC1BDE6;
	Tue, 16 Jan 2024 14:03:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3A1BDD6;
	Tue, 16 Jan 2024 14:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3490DC433C7;
	Tue, 16 Jan 2024 14:03:18 +0000 (UTC)
Message-ID: <cbafd2ce-bbfd-4684-a876-79af20ad33cd@xs4all.nl>
Date: Tue, 16 Jan 2024 15:03:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: core: Refactor vb2_ioctl_create_bufs() to always
 set capabilities flags
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, tfiga@chromium.org,
 m.szyprowski@samsung.com, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240115170826.214519-1-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240115170826.214519-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 18:08, Benjamin Gaignard wrote:
> vb2_create_bufs() takes care of setting V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS
> flag and vb2_queue max_num_buffers field so call it instead duplicate the
> same code in vb2_ioctl_create_bufs(). Testing p->count after calling
> vb2_create_bufs() is safe since the function also check it.
> 
> Fixes: d055a76c0065 ("media: core: Report the maximum possible number of buffers for the queue")
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-v4l2.c   | 23 ++++++++++---------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 54d572c3b515..bf304a7234a0 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -1029,23 +1029,24 @@ int vb2_ioctl_create_bufs(struct file *file, void *priv,
>  	int res = vb2_verify_memory_type(vdev->queue, p->memory,
>  			p->format.type);
>  
> -	p->index = vdev->queue->num_buffers;
> -	fill_buf_caps(vdev->queue, &p->capabilities);
> -	validate_memory_flags(vdev->queue, p->memory, &p->flags);
> +	if (vb2_queue_is_busy(vdev->queue, file)) {
> +		res = -EBUSY;
> +		goto failed;
> +	}
> +
> +	res = vb2_create_bufs(vdev->queue, p);
> +	if (res == 0)
> +		vdev->queue->owner = file->private_data;

This would set owner when called with p->count == 0, but that's
not what you want.

I decided to make an attempt at this myself, I'll post a patch.

Regards,

	Hans

> +
> +failed:
>  	/*
>  	 * If count == 0, then just check if memory and type are valid.
> -	 * Any -EBUSY result from vb2_verify_memory_type can be mapped to 0.
> +	 * Any -EBUSY result from vb2_verify_memory_type() or
> +	 * vb2_queue_is_busy() can be mapped to 0.
>  	 */
>  	if (p->count == 0)
>  		return res != -EBUSY ? res : 0;
> -	if (res)
> -		return res;
> -	if (vb2_queue_is_busy(vdev->queue, file))
> -		return -EBUSY;
>  
> -	res = vb2_create_bufs(vdev->queue, p);
> -	if (res == 0)
> -		vdev->queue->owner = file->private_data;
>  	return res;
>  }
>  EXPORT_SYMBOL_GPL(vb2_ioctl_create_bufs);


