Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B1D7B5443
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbjJBNqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbjJBNql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:46:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F7B7;
        Mon,  2 Oct 2023 06:46:37 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:9537:67ca:c85e:d0ae] (unknown [IPv6:2a01:e0a:120:3210:9537:67ca:c85e:d0ae])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F338666072E6;
        Mon,  2 Oct 2023 14:46:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696254396;
        bh=O8vCK6vbi9I+g3gLwposBxmUwfZuUOIFgHZEhwLWTJk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J3C+UmCPkSghlJzrlCZtSc86BTp3xMsv2L5lMzt7TXVLP8PKavhKS7i+5165v1ocK
         fX8bq/RCfPN/UatRG3P37MPOs3MnwnzoRI29RyjaB2H/JFxBZPCNrUlhygaoxGNA1u
         KneR40HdAwVKxQbkSkBzApvDOmttUvrRIsbl8a1yEeDuRoc6ArQ9o3MLnnD8EZyTO+
         4HHm6ZGzCmjb05nRK0Geaj4X2mIQoxMEZUY5OPVgahVXmev0TbKmIn60e0bdUVScwL
         zeXDiwACehxY2oE8Z1uNJ6+UroVJmJDZ3o1/E15LsgrEYZYA+qWAGFBFt0/6Ks81e7
         3pAJRzmUjdaQg==
Message-ID: <2f1d1983-6038-c216-e362-d08a05c344fc@collabora.com>
Date:   Mon, 2 Oct 2023 15:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 13/53] media: Report the maximum possible number of
 buffers for the queue
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
 <20230927153558.159278-14-benjamin.gaignard@collabora.com>
 <cf73025e-0bb0-44c2-9ab3-e426c09bebd8@xs4all.nl>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <cf73025e-0bb0-44c2-9ab3-e426c09bebd8@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 02/10/2023 à 15:37, Hans Verkuil a écrit :
> On 27/09/2023 17:35, Benjamin Gaignard wrote:
>> Use one of the struct v4l2_create_buffers reserved bytes to report
>> the maximum possible number of buffers for the queue.
>> V4l2 framework set V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS flags in queue
>> capabilities so userland can know when the field is valid.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   .../userspace-api/media/v4l/vidioc-create-bufs.rst       | 8 ++++++--
>>   Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst | 1 +
>>   drivers/media/common/videobuf2/videobuf2-v4l2.c          | 9 +++++++--
>>   drivers/media/v4l2-core/v4l2-ioctl.c                     | 4 ++--
>>   include/uapi/linux/videodev2.h                           | 7 ++++++-
>>   5 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
>> index a048a9f6b7b6..1a46549e7462 100644
>> --- a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
>> +++ b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
>> @@ -116,9 +116,13 @@ than the number requested.
>>         - ``flags``
>>         - Specifies additional buffer management attributes.
>>   	See :ref:`memory-flags`.
>> -
>>       * - __u32
>> -      - ``reserved``\ [6]
>> +      - ``max_buffers``
>> +      - If V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS capability flag is set
>> +        this field indicate the maximum possible number of buffers
>> +        for this queue.
>> +    * - __u32
>> +      - ``reserved``\ [5]
>>         - A place holder for future extensions. Drivers and applications
>>   	must set the array to zero.
>>   
>> diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
>> index 099fa6695167..0395187e1a5a 100644
>> --- a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
>> +++ b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
>> @@ -120,6 +120,7 @@ aborting or finishing any DMA in progress, an implicit
>>   .. _V4L2-BUF-CAP-SUPPORTS-ORPHANED-BUFS:
>>   .. _V4L2-BUF-CAP-SUPPORTS-M2M-HOLD-CAPTURE-BUF:
>>   .. _V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS:
>> +.. _V4L2-BUF-CAP-SUPPORTS-SET-MAX-BUFS:
>>   
>>   .. raw:: latex
>>   
>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> index 278ea1107b01..655133f1ae2b 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> @@ -686,6 +686,7 @@ EXPORT_SYMBOL(vb2_querybuf);
>>   static void fill_buf_caps(struct vb2_queue *q, u32 *caps)
>>   {
>>   	*caps = V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS;
>> +	*caps |= V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS;
>>   	if (q->io_modes & VB2_MMAP)
>>   		*caps |= V4L2_BUF_CAP_SUPPORTS_MMAP;
>>   	if (q->io_modes & VB2_USERPTR)
>> @@ -767,9 +768,13 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
>>   
>>   	fill_buf_caps(q, &create->capabilities);
>>   	validate_memory_flags(q, create->memory, &create->flags);
>> -	create->index = q->num_buffers;
>> -	if (create->count == 0)
>> +
>> +	create->max_buffers = q->max_num_buffers;
>> +
>> +	if (create->count == 0) {
>> +		create->index = vb2_get_num_buffers(q);
> This breaks git bisect: this function isn't introduced until patch 21/53.
>
> Note: with the build scripts you can just run it with:
>
> ./build.sh -patches 53 ...
>
> and it will apply each patch in sequence and attempt to compile it.

It should  be create->index = q->num_buffers;
The error is also in v9...

>
> Regards,
>
> 	Hans
>
>>   		return ret != -EBUSY ? ret : 0;
>> +	}
>>   
>>   	switch (f->type) {
>>   	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index f4d9d6279094..700db197e371 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -483,9 +483,9 @@ static void v4l_print_create_buffers(const void *arg, bool write_only)
>>   {
>>   	const struct v4l2_create_buffers *p = arg;
>>   
>> -	pr_cont("index=%d, count=%d, memory=%s, capabilities=0x%08x, ",
>> +	pr_cont("index=%d, count=%d, memory=%s, capabilities=0x%08x, max buffers=%u",
>>   		p->index, p->count, prt_names(p->memory, v4l2_memory_names),
>> -		p->capabilities);
>> +		p->capabilities, p->max_buffers);
>>   	v4l_print_format(&p->format, write_only);
>>   }
>>   
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 78260e5d9985..b0dbb1be728c 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -1034,6 +1034,7 @@ struct v4l2_requestbuffers {
>>   #define V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS		(1 << 4)
>>   #define V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF	(1 << 5)
>>   #define V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS		(1 << 6)
>> +#define V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS		(1 << 7)
>>   
>>   /**
>>    * struct v4l2_plane - plane info for multi-planar buffers
>> @@ -2604,6 +2605,9 @@ struct v4l2_dbg_chip_info {
>>    * @flags:	additional buffer management attributes (ignored unless the
>>    *		queue has V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS capability
>>    *		and configured for MMAP streaming I/O).
>> + * @max_buffers: if V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS capability flag is set
>> + *		 this field indicate the maximum possible number of buffers
>> + *		 for this queue.
>>    * @reserved:	future extensions
>>    */
>>   struct v4l2_create_buffers {
>> @@ -2613,7 +2617,8 @@ struct v4l2_create_buffers {
>>   	struct v4l2_format	format;
>>   	__u32			capabilities;
>>   	__u32			flags;
>> -	__u32			reserved[6];
>> +	__u32			max_buffers;
>> +	__u32			reserved[5];
>>   };
>>   
>>   /*
>
