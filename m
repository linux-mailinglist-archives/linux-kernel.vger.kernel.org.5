Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA57A62B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjISMV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjISMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:21:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEB2F7;
        Tue, 19 Sep 2023 05:21:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA738C433C7;
        Tue, 19 Sep 2023 12:21:43 +0000 (UTC)
Message-ID: <90ee9c16-f023-483c-8cc8-f4a15a29ea48@xs4all.nl>
Date:   Tue, 19 Sep 2023 14:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/49] media: Remove duplicated index vs q->num_buffers
 check
Content-Language: en-US, nl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
 <20230914133323.198857-19-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230914133323.198857-19-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 15:32, Benjamin Gaignard wrote:
> vb2_get_buffer() already check if the requested index is valid.

typo: check -> checks

> Stop duplicating this kind of check everywhere.

Also mention you moved it from the header to videobuf2-core.c.

Although I am not sure if it belongs in this patch, it is not
needed for this. I think it is better to move it either into a
separate patch, or move it to the patch where it is really needed.

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c |  8 ++++++++
>  drivers/media/common/videobuf2/videobuf2-v4l2.c | 13 -------------
>  include/media/videobuf2-core.h                  |  8 +-------
>  3 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index ee4df7c68397..2add7a6795e7 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -660,6 +660,14 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  	}
>  }
>  
> +struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q, unsigned int index)
> +{
> +	if (index < q->num_buffers)
> +		return q->bufs[index];
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(vb2_get_buffer);
> +
>  bool vb2_buffer_in_use(struct vb2_queue *q, struct vb2_buffer *vb)
>  {
>  	unsigned int plane;
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 87c2d5916960..f10b70d8e66a 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -378,11 +378,6 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
>  		return -EINVAL;
>  	}
>  
> -	if (b->index >= q->num_buffers) {
> -		dprintk(q, 1, "%s: buffer index out of range\n", opname);
> -		return -EINVAL;
> -	}
> -
>  	vb = vb2_get_buffer(q, b->index);
>  	if (!vb) {
>  		dprintk(q, 1, "%s: buffer is NULL\n", opname);
> @@ -829,10 +824,6 @@ int vb2_qbuf(struct vb2_queue *q, struct media_device *mdev,
>  		return -EBUSY;
>  	}
>  
> -	if (b->index >= q->num_buffers) {
> -		dprintk(q, 1, "buffer index out of range\n");
> -		return -EINVAL;
> -	}
>  	vb = vb2_get_buffer(q, b->index);
>  	if (!vb) {
>  		dprintk(q, 1, "can't find the requested buffer\n");
> @@ -904,10 +895,6 @@ int vb2_expbuf(struct vb2_queue *q, struct v4l2_exportbuffer *eb)
>  {
>  	struct vb2_buffer *vb;
>  
> -	if (eb->index >= q->num_buffers) {
> -		dprintk(q, 1, "buffer index out of range\n");
> -		return -EINVAL;
> -	}
>  	vb = vb2_get_buffer(q, eb->index);
>  	if (!vb) {
>  		dprintk(q, 1, "can't find the requested buffer\n");

This patch should be folded into 11/49. It is 11/49 that introduced these
duplicate messages, and it should have removed those directly.

Regards,

	Hans

> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 97153c69583f..25ca395616a7 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -1238,13 +1238,7 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
>   * operation, so the buffer lifetime should be taken into
>   * consideration.
>   */
> -static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
> -						unsigned int index)
> -{
> -	if (index < q->num_buffers)
> -		return q->bufs[index];
> -	return NULL;
> -}
> +struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q, unsigned int index);
>  
>  /*
>   * The following functions are not part of the vb2 core API, but are useful

