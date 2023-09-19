Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A37A6633
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjISOKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjISOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:10:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F6183;
        Tue, 19 Sep 2023 07:10:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18227C433C7;
        Tue, 19 Sep 2023 14:10:09 +0000 (UTC)
Message-ID: <b459dc32-7eba-481e-8c52-99bba5a5db4d@xs4all.nl>
Date:   Tue, 19 Sep 2023 16:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 34/49] media: ti: Stop direct calls to queue
 num_buffers field
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
 <20230914133323.198857-35-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230914133323.198857-35-benjamin.gaignard@collabora.com>
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

On 14/09/2023 15:33, Benjamin Gaignard wrote:
> Use vb2_get_num_buffers() to avoid using queue num_buffer field directly.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/ti/am437x/am437x-vpfe.c   | 5 +++--
>  drivers/media/platform/ti/cal/cal-video.c        | 5 +++--
>  drivers/media/platform/ti/davinci/vpif_capture.c | 5 +++--
>  drivers/media/platform/ti/davinci/vpif_display.c | 5 +++--
>  drivers/media/platform/ti/omap/omap_vout.c       | 5 +++--
>  5 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/ti/am437x/am437x-vpfe.c b/drivers/media/platform/ti/am437x/am437x-vpfe.c
> index 63092013d476..3b1e5dfecdbc 100644
> --- a/drivers/media/platform/ti/am437x/am437x-vpfe.c
> +++ b/drivers/media/platform/ti/am437x/am437x-vpfe.c
> @@ -1774,10 +1774,11 @@ static int vpfe_queue_setup(struct vb2_queue *vq,
>  			    unsigned int sizes[], struct device *alloc_devs[])
>  {
>  	struct vpfe_device *vpfe = vb2_get_drv_priv(vq);
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>  	unsigned size = vpfe->fmt.fmt.pix.sizeimage;
>  
> -	if (vq->num_buffers + *nbuffers < 3)
> -		*nbuffers = 3 - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < 3)
> +		*nbuffers = 3 - q_num_bufs;

Drop this, instead update min_buffers_needed from 1 to 3.

>  
>  	if (*nplanes) {
>  		if (sizes[0] < size)
> diff --git a/drivers/media/platform/ti/cal/cal-video.c b/drivers/media/platform/ti/cal/cal-video.c
> index a8abcd0fee17..5dfe40ca47fc 100644
> --- a/drivers/media/platform/ti/cal/cal-video.c
> +++ b/drivers/media/platform/ti/cal/cal-video.c
> @@ -602,10 +602,11 @@ static int cal_queue_setup(struct vb2_queue *vq,
>  			   unsigned int sizes[], struct device *alloc_devs[])
>  {
>  	struct cal_ctx *ctx = vb2_get_drv_priv(vq);
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>  	unsigned int size = ctx->v_fmt.fmt.pix.sizeimage;
>  
> -	if (vq->num_buffers + *nbuffers < 3)
> -		*nbuffers = 3 - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < 3)
> +		*nbuffers = 3 - q_num_bufs;

Drop this check, min_buffers_needed is already 3.

>  
>  	if (*nplanes) {
>  		if (sizes[0] < size)
> diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
> index 99fae8830c41..fc42b4bc37e6 100644
> --- a/drivers/media/platform/ti/davinci/vpif_capture.c
> +++ b/drivers/media/platform/ti/davinci/vpif_capture.c
> @@ -113,6 +113,7 @@ static int vpif_buffer_queue_setup(struct vb2_queue *vq,
>  	struct channel_obj *ch = vb2_get_drv_priv(vq);
>  	struct common_obj *common = &ch->common[VPIF_VIDEO_INDEX];
>  	unsigned size = common->fmt.fmt.pix.sizeimage;
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>  
>  	vpif_dbg(2, debug, "vpif_buffer_setup\n");
>  
> @@ -122,8 +123,8 @@ static int vpif_buffer_queue_setup(struct vb2_queue *vq,
>  		size = sizes[0];
>  	}
>  
> -	if (vq->num_buffers + *nbuffers < 3)
> -		*nbuffers = 3 - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < 3)
> +		*nbuffers = 3 - q_num_bufs;

Drop, and update min_buffers_needed to 3.

>  
>  	*nplanes = 1;
>  	sizes[0] = size;
> diff --git a/drivers/media/platform/ti/davinci/vpif_display.c b/drivers/media/platform/ti/davinci/vpif_display.c
> index f8ec2991c667..9dbab1003c1d 100644
> --- a/drivers/media/platform/ti/davinci/vpif_display.c
> +++ b/drivers/media/platform/ti/davinci/vpif_display.c
> @@ -115,6 +115,7 @@ static int vpif_buffer_queue_setup(struct vb2_queue *vq,
>  	struct channel_obj *ch = vb2_get_drv_priv(vq);
>  	struct common_obj *common = &ch->common[VPIF_VIDEO_INDEX];
>  	unsigned size = common->fmt.fmt.pix.sizeimage;
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>  
>  	if (*nplanes) {
>  		if (sizes[0] < size)
> @@ -122,8 +123,8 @@ static int vpif_buffer_queue_setup(struct vb2_queue *vq,
>  		size = sizes[0];
>  	}
>  
> -	if (vq->num_buffers + *nbuffers < 3)
> -		*nbuffers = 3 - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < 3)
> +		*nbuffers = 3 - q_num_bufs;

Ditto.

>  
>  	*nplanes = 1;
>  	sizes[0] = size;
> diff --git a/drivers/media/platform/ti/omap/omap_vout.c b/drivers/media/platform/ti/omap/omap_vout.c
> index 4143274089c3..72ce903717d3 100644
> --- a/drivers/media/platform/ti/omap/omap_vout.c
> +++ b/drivers/media/platform/ti/omap/omap_vout.c
> @@ -944,10 +944,11 @@ static int omap_vout_vb2_queue_setup(struct vb2_queue *vq,
>  				     struct device *alloc_devs[])
>  {
>  	struct omap_vout_device *vout = vb2_get_drv_priv(vq);
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>  	int size = vout->pix.sizeimage;
>  
> -	if (is_rotation_enabled(vout) && vq->num_buffers + *nbufs > VRFB_NUM_BUFS) {
> -		*nbufs = VRFB_NUM_BUFS - vq->num_buffers;
> +	if (is_rotation_enabled(vout) && q_num_bufs + *nbufs > VRFB_NUM_BUFS) {
> +		*nbufs = VRFB_NUM_BUFS - q_num_bufs;
>  		if (*nbufs == 0)
>  			return -EINVAL;
>  	}

Regards,

	Hans
