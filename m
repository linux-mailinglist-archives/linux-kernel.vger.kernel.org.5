Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC597CA15D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjJPINf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjJPINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:13:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F31A1;
        Mon, 16 Oct 2023 01:13:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DC4C433C7;
        Mon, 16 Oct 2023 08:13:28 +0000 (UTC)
Message-ID: <dd279357-bccc-41c2-9566-a7670880db37@xs4all.nl>
Date:   Mon, 16 Oct 2023 10:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/56] media: amphion: Use vb2_get_buffer() instead of
 directly access to buffers array
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
        kernel@collabora.com, Zhou Peng <eagle.zhou@nxp.com>
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
 <20231012114642.19040-10-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231012114642.19040-10-benjamin.gaignard@collabora.com>
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

On 12/10/2023 13:45, Benjamin Gaignard wrote:
> Use vb2_get_buffer() instead of directly access to vb2_buffer buffer array.
> This could allow to change the type bufs[] field of vb2_buffer structure if
> needed.

Awkward phrasing, and bufs is part of vb2_queue, not vb2_buffer. How about:

Use vb2_get_buffer() instead of direct access to the vb2_queue bufs array.
This allows us to change the type of the bufs in the future.

The same text is used in other driver patches, so please update it there
as well.

Regards,

	Hans

> After each call to vb2_get_buffer() we need to be sure that we get
> a valid pointer so check the return value of all of them.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> CC: Ming Qian <ming.qian@nxp.com>
> CC: Zhou Peng <eagle.zhou@nxp.com>
> ---
>  drivers/media/platform/amphion/vpu_dbg.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
> index 982c2c777484..a462d6fe4ea9 100644
> --- a/drivers/media/platform/amphion/vpu_dbg.c
> +++ b/drivers/media/platform/amphion/vpu_dbg.c
> @@ -140,11 +140,18 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>  
>  	vq = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
>  	for (i = 0; i < vq->num_buffers; i++) {
> -		struct vb2_buffer *vb = vq->bufs[i];
> -		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +		struct vb2_buffer *vb;
> +		struct vb2_v4l2_buffer *vbuf;
> +
> +		vb = vb2_get_buffer(vq, i);
> +		if (!vb)
> +			continue;
>  
>  		if (vb->state == VB2_BUF_STATE_DEQUEUED)
>  			continue;
> +
> +		vbuf = to_vb2_v4l2_buffer(vb);
> +
>  		num = scnprintf(str, sizeof(str),
>  				"output [%2d] state = %10s, %8s\n",
>  				i, vb2_stat_name[vb->state],
> @@ -155,11 +162,18 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>  
>  	vq = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
>  	for (i = 0; i < vq->num_buffers; i++) {
> -		struct vb2_buffer *vb = vq->bufs[i];
> -		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +		struct vb2_buffer *vb;
> +		struct vb2_v4l2_buffer *vbuf;
> +
> +		vb = vb2_get_buffer(vq, i);
> +		if (!vb)
> +			continue;
>  
>  		if (vb->state == VB2_BUF_STATE_DEQUEUED)
>  			continue;
> +
> +		vbuf = to_vb2_v4l2_buffer(vb);
> +
>  		num = scnprintf(str, sizeof(str),
>  				"capture[%2d] state = %10s, %8s\n",
>  				i, vb2_stat_name[vb->state],

Regards,

	Hans
