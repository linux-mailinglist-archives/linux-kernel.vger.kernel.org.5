Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F002E7C4DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjJKIyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjJKIyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:54:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7556FD7;
        Wed, 11 Oct 2023 01:54:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F39C433C8;
        Wed, 11 Oct 2023 08:54:35 +0000 (UTC)
Message-ID: <ab98f6df-206b-48a0-a8ec-4d105bae0e22@xs4all.nl>
Date:   Wed, 11 Oct 2023 10:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/54] media: Remove duplicated index vs
 q->num_buffers check
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
References: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
 <20231003080704.43911-21-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231003080704.43911-21-benjamin.gaignard@collabora.com>
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

Subject should start with "media: videobuf2:".

Regards,

	Hans

On 03/10/2023 10:06, Benjamin Gaignard wrote:
> vb2_get_buffer() already checks if the requested index is valid.
> Stop duplicating this kind of check everywhere.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-v4l2.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 42da0adc052a..cf881c8d8d4d 100644
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
>  		dprintk(q, 1, "%s: buffer %u is NULL\n", opname,  b->index);
> @@ -833,10 +828,6 @@ int vb2_qbuf(struct vb2_queue *q, struct media_device *mdev,
>  		return -EBUSY;
>  	}
>  
> -	if (b->index >= q->num_buffers) {
> -		dprintk(q, 1, "buffer index out of range\n");
> -		return -EINVAL;
> -	}
>  	vb = vb2_get_buffer(q, b->index);
>  	if (!vb) {
>  		dprintk(q, 1, "can't find the requested buffer %u\n", b->index);
> @@ -908,10 +899,6 @@ int vb2_expbuf(struct vb2_queue *q, struct v4l2_exportbuffer *eb)
>  {
>  	struct vb2_buffer *vb;
>  
> -	if (eb->index >= q->num_buffers) {
> -		dprintk(q, 1, "buffer index out of range\n");
> -		return -EINVAL;
> -	}
>  	vb = vb2_get_buffer(q, eb->index);
>  	if (!vb) {
>  		dprintk(q, 1, "can't find the requested buffer %u\n", eb->index);

