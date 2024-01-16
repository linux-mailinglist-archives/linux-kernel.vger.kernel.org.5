Return-Path: <linux-kernel+bounces-27260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC4D82ECDD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E998B22AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A188E13AEB;
	Tue, 16 Jan 2024 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R0koWecI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DADB134DA;
	Tue, 16 Jan 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705401777;
	bh=QheYevpPKWLtwlqs9yJuw0+el/TYi4lzg9WtACT2oa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R0koWecIS+76AQMz2BNKVgqJsSFj7UiiAkg4hGSMbxc3bxLcahgGOP/b61Fwim6/H
	 8+UHCB1pGbqQ6gBO2hNn4LrDiMKyo09Tea1LjI3A8By+SmZgfEs076BEUXGAUVJy4m
	 vOpEebvFnrkzqVQ0VDjPq1SLR6M5gm0HIp696729ajm7ZdztZOEPSsWj+vJm1uhNHl
	 ZhxhiglvdpDJJ4ehGfwX+mEyRt1jH4qobhBClIWNKjGV1IOga8NpTIdRReNXqAOJGi
	 uLi5LNf2tBBD76jvnE9MI7HVbEK9VfE1Y0AxAj3lK2LDR3ChxSVJBSuePHiuAtDOBx
	 4oAW2naBxPK6A==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4CF9437811F1;
	Tue, 16 Jan 2024 10:42:57 +0000 (UTC)
Message-ID: <60c942d8-e0bd-4609-8fc4-1e80102ac051@collabora.com>
Date: Tue, 16 Jan 2024 11:42:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 7/8] media: v4l2: Add mem2mem helpers for DELETE_BUFS
 ioctl
Content-Language: en-US
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20231215090813.15610-1-benjamin.gaignard@collabora.com>
 <20231215090813.15610-8-benjamin.gaignard@collabora.com>
 <6b0e4c6b-493c-4916-ab3c-deeeb725fdec@xs4all.nl>
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <6b0e4c6b-493c-4916-ab3c-deeeb725fdec@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 15/01/2024 à 17:50, Hans Verkuil a écrit :
> On 15/12/2023 10:08, Benjamin Gaignard wrote:
>> Create v4l2-mem2mem helpers for VIDIOC_DELETE_BUFS ioctl.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   .../media/platform/verisilicon/hantro_drv.c   |  1 +
>>   .../media/platform/verisilicon/hantro_v4l2.c  |  1 +
>>   drivers/media/test-drivers/vim2m.c            |  2 ++
> The driver changes should be done in a separate patch.
>
>>   drivers/media/v4l2-core/v4l2-mem2mem.c        | 20 +++++++++++++++++++
>>   include/media/v4l2-mem2mem.h                  | 12 +++++++++++
>>   5 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>> index db3df6cc4513..f6b0a676a740 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -248,6 +248,7 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>>   	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>>   	dst_vq->lock = &ctx->dev->vpu_mutex;
>>   	dst_vq->dev = ctx->dev->v4l2_dev.dev;
>> +	src_vq->supports_delete_bufs = true;
> Isn't this something that can be supported for both queues?

For me it isn't useful to support it on the both queues because
only capture queue will store unused buffers after a dynamic
resolution change. Output queue buffers are smaller and always
recycled even after a dynamic resolution change.

>
>>   
>>   	return vb2_queue_init(dst_vq);
>>   }
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index 941fa23c211a..34eab90e8a42 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>>   	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>>   	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>>   	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
>> +	.vidioc_delete_bufs = v4l2_m2m_ioctl_delete_bufs,
>>   	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>>   
>>   	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
>> diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
>> index 3e3b424b4860..17213ce42059 100644
>> --- a/drivers/media/test-drivers/vim2m.c
>> +++ b/drivers/media/test-drivers/vim2m.c
>> @@ -960,6 +960,7 @@ static const struct v4l2_ioctl_ops vim2m_ioctl_ops = {
>>   	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
>>   	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
>>   	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
>> +	.vidioc_delete_bufs	= v4l2_m2m_ioctl_delete_bufs,
>>   	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
>>   
>>   	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
>> @@ -1133,6 +1134,7 @@ static int queue_init(void *priv, struct vb2_queue *src_vq,
>>   	dst_vq->mem_ops = &vb2_vmalloc_memops;
>>   	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>>   	dst_vq->lock = &ctx->vb_mutex;
>> +	dst_vq->supports_delete_bufs = true;
> Same question.

I want to test something similar to what the real use case does.

>
>>   
>>   	return vb2_queue_init(dst_vq);
>>   }
>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> index 9e983176542b..dbc4711fc556 100644
>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> @@ -834,6 +834,17 @@ int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>>   }
>>   EXPORT_SYMBOL_GPL(v4l2_m2m_prepare_buf);
>>   
>> +int v4l2_m2m_delete_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>> +			 struct v4l2_delete_buffers *d)
>> +{
>> +	struct vb2_queue *vq;
>> +
>> +	vq = v4l2_m2m_get_vq(m2m_ctx, d->type);
> These 3 lines can be combined into one.
>
>> +
>> +	return vb2_delete_bufs(vq, d);
>> +}
>> +EXPORT_SYMBOL_GPL(v4l2_m2m_delete_bufs);
> I'm not sure we need to export this. Drivers should really just use the
> v4l2_m2m_ioctl_ variant below.

ok

regards,
Benjamin

>
>> +
>>   int v4l2_m2m_create_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>>   			 struct v4l2_create_buffers *create)
>>   {
>> @@ -1380,6 +1391,15 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
>>   }
>>   EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
>>   
>> +int v4l2_m2m_ioctl_delete_bufs(struct file *file, void *priv,
>> +			       struct v4l2_delete_buffers *d)
>> +{
>> +	struct v4l2_fh *fh = file->private_data;
>> +
>> +	return v4l2_m2m_delete_bufs(file, fh->m2m_ctx, d);
>> +}
>> +EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_delete_bufs);
>> +
>>   int v4l2_m2m_ioctl_querybuf(struct file *file, void *priv,
>>   				struct v4l2_buffer *buf)
>>   {
>> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
>> index 7f1af1f7f912..5314952ad3d5 100644
>> --- a/include/media/v4l2-mem2mem.h
>> +++ b/include/media/v4l2-mem2mem.h
>> @@ -388,6 +388,16 @@ int v4l2_m2m_dqbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>>   int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>>   			 struct v4l2_buffer *buf);
>>   
>> +/**
>> + * v4l2_m2m_delete_bufs() - delete buffers from the queue
>> + *
>> + * @file: pointer to struct &file
>> + * @m2m_ctx: m2m context assigned to the instance given by struct &v4l2_m2m_ctx
>> + * @d: pointer to struct &v4l2_delete_buffers
>> + */
>> +int v4l2_m2m_delete_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>> +			 struct v4l2_delete_buffers *d);
>> +
>>   /**
>>    * v4l2_m2m_create_bufs() - create a source or destination buffer, depending
>>    * on the type
>> @@ -867,6 +877,8 @@ int v4l2_m2m_ioctl_reqbufs(struct file *file, void *priv,
>>   				struct v4l2_requestbuffers *rb);
>>   int v4l2_m2m_ioctl_create_bufs(struct file *file, void *fh,
>>   				struct v4l2_create_buffers *create);
>> +int v4l2_m2m_ioctl_delete_bufs(struct file *file, void *priv,
>> +			       struct v4l2_delete_buffers *d);
>>   int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
>>   				struct v4l2_buffer *buf);
>>   int v4l2_m2m_ioctl_expbuf(struct file *file, void *fh,
> Regards,
>
> 	Hans
>

