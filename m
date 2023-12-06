Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDADB806A08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376953AbjLFIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:46:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38BEFA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:46:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F84DC433C7;
        Wed,  6 Dec 2023 08:46:36 +0000 (UTC)
Message-ID: <574bb65f-872d-4bf4-9d3d-a330133de884@xs4all.nl>
Date:   Wed, 6 Dec 2023 09:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3,16/21] media: medkatek: vcodec: support one plane
 capture buffer
Content-Language: en-US, nl
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Yong Wu <yong.wu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231206081538.17056-1-yunfei.dong@mediatek.com>
 <20231206081538.17056-17-yunfei.dong@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231206081538.17056-17-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 09:15, Yunfei Dong wrote:
> The capture buffer has two planes for format MM21, but user space only
> allocate secure memory for plane[0], and the size is Y data + uv data.
> The driver need to support one plane decoder for svp mode.

For a future v4: note the typo in the Subject line: medkatek -> mediatek.
It's present in patches 16-20.

Regards,

	Hans

> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  |  7 ++++-
>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 26 ++++++++++---------
>  .../decoder/vdec/vdec_h264_req_common.c       | 11 +++-----
>  .../mediatek/vcodec/decoder/vdec_drv_if.c     |  4 +--
>  4 files changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> index 604fdc8ee3ce..ab922e8d2d37 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> @@ -653,7 +653,12 @@ static int vidioc_vdec_g_fmt(struct file *file, void *priv,
>  		 * So we just return picinfo yet, and update picinfo in
>  		 * stop_streaming hook function
>  		 */
> -		q_data->sizeimage[0] = ctx->picinfo.fb_sz[0];
> +
> +		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 1)
> +			q_data->sizeimage[0] = ctx->picinfo.fb_sz[0] + ctx->picinfo.fb_sz[1];
> +		else
> +			q_data->sizeimage[0] = ctx->picinfo.fb_sz[0];
> +
>  		q_data->sizeimage[1] = ctx->picinfo.fb_sz[1];
>  		q_data->bytesperline[0] = ctx->last_decoded_picinfo.buf_w;
>  		q_data->bytesperline[1] = ctx->last_decoded_picinfo.buf_w;
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
> index cc42c942eb8a..707ed57a412e 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
> @@ -285,14 +285,14 @@ static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_dec_ctx *ctx)
>  	framebuf = container_of(vb2_v4l2, struct mtk_video_dec_buf, m2m_buf.vb);
>  
>  	pfb = &framebuf->frame_buffer;
> -	pfb->base_y.va = vb2_plane_vaddr(dst_buf, 0);
> +	if (!ctx->is_secure_playback)
> +		pfb->base_y.va = vb2_plane_vaddr(dst_buf, 0);
>  	pfb->base_y.dma_addr = vb2_dma_contig_plane_dma_addr(dst_buf, 0);
>  	pfb->base_y.size = ctx->q_data[MTK_Q_DATA_DST].sizeimage[0];
>  
> -	if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2) {
> +	if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2 && !ctx->is_secure_playback) {
>  		pfb->base_c.va = vb2_plane_vaddr(dst_buf, 1);
> -		pfb->base_c.dma_addr =
> -			vb2_dma_contig_plane_dma_addr(dst_buf, 1);
> +		pfb->base_c.dma_addr = vb2_dma_contig_plane_dma_addr(dst_buf, 1);
>  		pfb->base_c.size = ctx->q_data[MTK_Q_DATA_DST].sizeimage[1];
>  	}
>  	mtk_v4l2_vdec_dbg(1, ctx,
> @@ -339,16 +339,18 @@ static void mtk_vdec_worker(struct work_struct *work)
>  	mtk_v4l2_vdec_dbg(3, ctx, "[%d] (%d) id=%d, vb=%p", ctx->id,
>  			  vb2_src->vb2_queue->type, vb2_src->index, vb2_src);
>  
> -	bs_src->va = vb2_plane_vaddr(vb2_src, 0);
> -	bs_src->dma_addr = vb2_dma_contig_plane_dma_addr(vb2_src, 0);
> -	bs_src->size = (size_t)vb2_src->planes[0].bytesused;
> -	if (!bs_src->va) {
> -		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
> -		mtk_v4l2_vdec_err(ctx, "[%d] id=%d source buffer is NULL", ctx->id,
> -				  vb2_src->index);
> -		return;
> +	if (!ctx->is_secure_playback) {
> +		bs_src->va = vb2_plane_vaddr(vb2_src, 0);
> +		if (!bs_src->va) {
> +			v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
> +			mtk_v4l2_vdec_err(ctx, "[%d] id=%d source buffer is NULL", ctx->id,
> +					  vb2_src->index);
> +			return;
> +		}
>  	}
>  
> +	bs_src->dma_addr = vb2_dma_contig_plane_dma_addr(vb2_src, 0);
> +	bs_src->size = (size_t)vb2_src->planes[0].bytesused;
>  	mtk_v4l2_vdec_dbg(3, ctx, "[%d] Bitstream VA=%p DMA=%pad Size=%zx vb=%p",
>  			  ctx->id, bs_src->va, &bs_src->dma_addr, bs_src->size, vb2_src);
>  	/* Apply request controls. */
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.c
> index 5ca20d75dc8e..2a57e689ec07 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.c
> @@ -79,15 +79,12 @@ void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_dec_ctx *ctx,
>  		vb2_v4l2 = container_of(vb, struct vb2_v4l2_buffer, vb2_buf);
>  		h264_dpb_info[index].field = vb2_v4l2->field;
>  
> -		h264_dpb_info[index].y_dma_addr =
> -			vb2_dma_contig_plane_dma_addr(vb, 0);
> +		h264_dpb_info[index].y_dma_addr = vb2_dma_contig_plane_dma_addr(vb, 0);
>  		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2)
> +			h264_dpb_info[index].c_dma_addr = vb2_dma_contig_plane_dma_addr(vb, 1);
> +		else if (!ctx->is_secure_playback)
>  			h264_dpb_info[index].c_dma_addr =
> -				vb2_dma_contig_plane_dma_addr(vb, 1);
> -		else
> -			h264_dpb_info[index].c_dma_addr =
> -				h264_dpb_info[index].y_dma_addr +
> -				ctx->picinfo.fb_sz[0];
> +				h264_dpb_info[index].y_dma_addr + ctx->picinfo.fb_sz[0];
>  	}
>  }
>  
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> index d0b459b1603f..fb3e4f75ed93 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> @@ -73,14 +73,14 @@ int vdec_if_decode(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_mem *bs,
>  {
>  	int ret = 0;
>  
> -	if (bs) {
> +	if (bs && !ctx->is_secure_playback) {
>  		if ((bs->dma_addr & 63) != 0) {
>  			mtk_v4l2_vdec_err(ctx, "bs dma_addr should 64 byte align");
>  			return -EINVAL;
>  		}
>  	}
>  
> -	if (fb) {
> +	if (fb && !ctx->is_secure_playback) {
>  		if (((fb->base_y.dma_addr & 511) != 0) ||
>  		    ((fb->base_c.dma_addr & 511) != 0)) {
>  			mtk_v4l2_vdec_err(ctx, "frame buffer dma_addr should 512 byte align");

