Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492477E6A91
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjKIM26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKIM25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:28:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3B2590;
        Thu,  9 Nov 2023 04:28:54 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 191B9660747A;
        Thu,  9 Nov 2023 12:28:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699532932;
        bh=wvBhmLqQREGAx7oI3reWe2l9af2k7nuNnRJBg9FCTr4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ExFkeytFlei55dbrJW6zpwbv5BYV0MbggCVBUcXQBNiM1/sHKVg/JpGHHnF2s7dCo
         Li7kwuM3z+7qXVFORQmvymicrppZRH85wCQZMsLN7f2rgCEglpxhTv+fZXy1dydcfZ
         GDPGLHh38V93b/yBaJnXaWSZu8x0I2yvc5VO/fwGRtCEslW39AR1gB+B3PTFdL5qGz
         AMVyazugfVnHbygYcv7/22BzSpfukJJssucjtrgWIK7MpRgrNQQGriMw40W5F1QCE7
         kDLVkR3xW9NLYiRr0GvcgEm+RhVsP7ysyGmCBgF3XENKjRaE7uMREYvh+oM8G0SNNZ
         aZ86u3NgLFyKg==
Message-ID: <25614b04-4bb5-4b32-b41f-92477d1117a0@collabora.com>
Date:   Thu, 9 Nov 2023 13:28:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 44/56] media: core: Report the maximum possible number
 of buffers for the queue
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-45-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-45-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,


W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Use one of the struct v4l2_create_buffers reserved bytes to report

I initially thought you were using literally a single byte, which made
no sense to me given that values much larger than 255 are sometimes going to be
stored there.

Maybe rephrase this to:

Use one element of the struct v4l2_create_buffers "reserved" array to report...

With that you can add my

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>


> the maximum possible number of buffers for the queue.
> V4l2 framework set V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS flags in queue
> capabilities so userland can know when the field is valid.
> Does the same change in v4l2_create_buffers32 structure.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>   .../userspace-api/media/v4l/vidioc-create-bufs.rst       | 8 ++++++--
>   Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst | 1 +
>   drivers/media/common/videobuf2/videobuf2-v4l2.c          | 2 ++
>   drivers/media/v4l2-core/v4l2-compat-ioctl32.c            | 9 ++++++++-
>   drivers/media/v4l2-core/v4l2-ioctl.c                     | 4 ++--
>   include/uapi/linux/videodev2.h                           | 7 ++++++-
>   6 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
> index a048a9f6b7b6..49232c9006c2 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
> @@ -116,9 +116,13 @@ than the number requested.
>         - ``flags``
>         - Specifies additional buffer management attributes.
>   	See :ref:`memory-flags`.
> -
>       * - __u32
> -      - ``reserved``\ [6]
> +      - ``max_num_buffers``
> +      - If the V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS capability flag is set
> +        this field indicates the maximum possible number of buffers
> +        for this queue.
> +    * - __u32
> +      - ``reserved``\ [5]
>         - A place holder for future extensions. Drivers and applications
>   	must set the array to zero.
>   
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
> index 099fa6695167..0b3a41a45d05 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
> @@ -120,6 +120,7 @@ aborting or finishing any DMA in progress, an implicit
>   .. _V4L2-BUF-CAP-SUPPORTS-ORPHANED-BUFS:
>   .. _V4L2-BUF-CAP-SUPPORTS-M2M-HOLD-CAPTURE-BUF:
>   .. _V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS:
> +.. _V4L2-BUF-CAP-SUPPORTS-MAX-NUM-BUFFERS:
>   
>   .. raw:: latex
>   
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index f3cf4b235c1f..bdfc3a253c65 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -762,6 +762,8 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
>   	fill_buf_caps(q, &create->capabilities);
>   	validate_memory_flags(q, create->memory, &create->flags);
>   	create->index = vb2_get_num_buffers(q);
> +	create->max_num_buffers = q->max_num_buffers;
> +	create->capabilities |= V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS;
>   	if (create->count == 0)
>   		return ret != -EBUSY ? ret : 0;
>   
> diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
> index f3bed37859a2..5aac5cf780b3 100644
> --- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
> +++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
> @@ -116,6 +116,9 @@ struct v4l2_format32 {
>    * @flags:	additional buffer management attributes (ignored unless the
>    *		queue has V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS capability and
>    *		configured for MMAP streaming I/O).
> + * @max_num_buffers: if V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS capability flag is set
> + *		this field indicate the maximum possible number of buffers
> + *		for this queue.
>    * @reserved:	future extensions
>    */
>   struct v4l2_create_buffers32 {
> @@ -125,7 +128,8 @@ struct v4l2_create_buffers32 {
>   	struct v4l2_format32	format;
>   	__u32			capabilities;
>   	__u32			flags;
> -	__u32			reserved[6];
> +	__u32			max_num_buffers;
> +	__u32			reserved[5];
>   };
>   
>   static int get_v4l2_format32(struct v4l2_format *p64,
> @@ -175,6 +179,8 @@ static int get_v4l2_create32(struct v4l2_create_buffers *p64,
>   		return -EFAULT;
>   	if (copy_from_user(&p64->flags, &p32->flags, sizeof(p32->flags)))
>   		return -EFAULT;
> +	if (copy_from_user(&p64->max_num_buffers, &p32->max_num_buffers, sizeof(p32->max_num_buffers)))
> +		return -EFAULT;
>   	return get_v4l2_format32(&p64->format, &p32->format);
>   }
>   
> @@ -221,6 +227,7 @@ static int put_v4l2_create32(struct v4l2_create_buffers *p64,
>   			 offsetof(struct v4l2_create_buffers32, format)) ||
>   	    put_user(p64->capabilities, &p32->capabilities) ||
>   	    put_user(p64->flags, &p32->flags) ||
> +	    put_user(p64->max_num_buffers, &p32->max_num_buffers) ||
>   	    copy_to_user(p32->reserved, p64->reserved, sizeof(p64->reserved)))
>   		return -EFAULT;
>   	return put_v4l2_format32(&p64->format, &p32->format);
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 9b1de54ce379..4d90424cbfc4 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -483,9 +483,9 @@ static void v4l_print_create_buffers(const void *arg, bool write_only)
>   {
>   	const struct v4l2_create_buffers *p = arg;
>   
> -	pr_cont("index=%d, count=%d, memory=%s, capabilities=0x%08x, ",
> +	pr_cont("index=%d, count=%d, memory=%s, capabilities=0x%08x, max num buffers=%u",
>   		p->index, p->count, prt_names(p->memory, v4l2_memory_names),
> -		p->capabilities);
> +		p->capabilities, p->max_num_buffers);
>   	v4l_print_format(&p->format, write_only);
>   }
>   
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index c3d4e490ce7c..13ddb5abf584 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -1035,6 +1035,7 @@ struct v4l2_requestbuffers {
>   #define V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS		(1 << 4)
>   #define V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF	(1 << 5)
>   #define V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS		(1 << 6)
> +#define V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS		(1 << 7)
>   
>   /**
>    * struct v4l2_plane - plane info for multi-planar buffers
> @@ -2605,6 +2606,9 @@ struct v4l2_dbg_chip_info {
>    * @flags:	additional buffer management attributes (ignored unless the
>    *		queue has V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS capability
>    *		and configured for MMAP streaming I/O).
> + * @max_num_buffers: if V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS capability flag is set
> + *		this field indicate the maximum possible number of buffers
> + *		for this queue.
>    * @reserved:	future extensions
>    */
>   struct v4l2_create_buffers {
> @@ -2614,7 +2618,8 @@ struct v4l2_create_buffers {
>   	struct v4l2_format	format;
>   	__u32			capabilities;
>   	__u32			flags;
> -	__u32			reserved[6];
> +	__u32			max_num_buffers;
> +	__u32			reserved[5];
>   };
>   
>   /*

