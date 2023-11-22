Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E87F4B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjKVPts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjKVPth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:49:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA5549D6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:40:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63563C433C7;
        Wed, 22 Nov 2023 15:40:39 +0000 (UTC)
Message-ID: <9e6793e3-d824-4117-990d-924f8ad69d4e@xs4all.nl>
Date:   Wed, 22 Nov 2023 16:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 04/11] media: s5p-mfc: Add YV12 and I420 multiplanar
 format support
Content-Language: en-US, nl
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-samsung-soc@vger.kernel.org, andi@etezian.org,
        gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, linux-fsd@tesla.com,
        Smitha T Murthy <smithatmurthy@gmail.com>
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
 <CGME20231025102243epcas5p1cdd0eb385d2381943d6d194eec3a569d@epcas5p1.samsung.com>
 <20231025102216.50480-5-aakarsh.jain@samsung.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231025102216.50480-5-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 12:22, Aakarsh Jain wrote:
> YV12 and I420 format (3-plane) support is added. Stride information is
> added to all formats and planes since it is necessary for YV12/I420
> which are different from width.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |   2 +
>  .../platform/samsung/s5p-mfc/regs-mfc-v7.h    |   1 +
>  .../platform/samsung/s5p-mfc/regs-mfc-v8.h    |   3 +
>  .../platform/samsung/s5p-mfc/s5p_mfc_common.h |   4 +
>  .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  45 ++++-
>  .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    |  86 +++++++--
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |   6 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c |  12 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 168 +++++++++++++++---
>  9 files changed, 281 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> index 6c68a45082d0..70464f47c1f9 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> @@ -26,6 +26,8 @@
>  #define MFC_VERSION_V12			0xC0
>  #define MFC_NUM_PORTS_V12		1
>  #define S5P_FIMV_CODEC_VP9_ENC		27
> +#define MFC_CHROMA_PAD_BYTES_V12        256
> +#define S5P_FIMV_D_ALIGN_PLANE_SIZE_V12 256
>  
>  /* Encoder buffer size for MFCv12 */
>  #define ENC_V120_BASE_SIZE(x, y) \
> diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
> index 4a7adfdaa359..50f9bf0603c1 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
> @@ -24,6 +24,7 @@
>  
>  #define S5P_FIMV_E_ENCODED_SOURCE_FIRST_ADDR_V7		0xfa70
>  #define S5P_FIMV_E_ENCODED_SOURCE_SECOND_ADDR_V7	0xfa74
> +#define S5P_FIMV_E_ENCODED_SOURCE_THIRD_ADDR_V7		0xfa78
>  
>  #define S5P_FIMV_E_VP8_OPTIONS_V7			0xfdb0
>  #define S5P_FIMV_E_VP8_FILTER_OPTIONS_V7		0xfdb4
> diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
> index 162e3c7e920f..0ef9eb2dff22 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
> @@ -17,13 +17,16 @@
>  #define S5P_FIMV_D_MIN_SCRATCH_BUFFER_SIZE_V8	0xf108
>  #define S5P_FIMV_D_FIRST_PLANE_DPB_SIZE_V8	0xf144
>  #define S5P_FIMV_D_SECOND_PLANE_DPB_SIZE_V8	0xf148
> +#define S5P_FIMV_D_THIRD_PLANE_DPB_SIZE_V8	0xf14C
>  #define S5P_FIMV_D_MV_BUFFER_SIZE_V8		0xf150
>  
>  #define S5P_FIMV_D_FIRST_PLANE_DPB_STRIDE_SIZE_V8	0xf138
>  #define S5P_FIMV_D_SECOND_PLANE_DPB_STRIDE_SIZE_V8	0xf13c
> +#define S5P_FIMV_D_THIRD_PLANE_DPB_STRIDE_SIZE_V8	0xf140
>  
>  #define S5P_FIMV_D_FIRST_PLANE_DPB_V8		0xf160
>  #define S5P_FIMV_D_SECOND_PLANE_DPB_V8		0xf260
> +#define S5P_FIMV_D_THIRD_PLANE_DPB_V8		0xf360
>  #define S5P_FIMV_D_MV_BUFFER_V8			0xf460
>  
>  #define S5P_FIMV_D_NUM_MV_V8			0xf134
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> index dd2e9f7704ab..9a39cccfe002 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> @@ -56,6 +56,7 @@
>  #define MFC_NO_INSTANCE_SET	-1
>  #define MFC_ENC_CAP_PLANE_COUNT	1
>  #define MFC_ENC_OUT_PLANE_COUNT	2
> +#define VB2_MAX_PLANE_COUNT	3
>  #define STUFF_BYTE		4
>  #define MFC_MAX_CTRLS		128
>  
> @@ -181,6 +182,7 @@ struct s5p_mfc_buf {
>  		struct {
>  			size_t luma;
>  			size_t chroma;
> +			size_t chroma_1;
>  		} raw;
>  		size_t stream;
>  	} cookie;
> @@ -657,6 +659,7 @@ struct s5p_mfc_ctx {
>  
>  	int luma_size;
>  	int chroma_size;
> +	int chroma_size_1;
>  	int mv_size;
>  
>  	unsigned long consumed_stream;
> @@ -722,6 +725,7 @@ struct s5p_mfc_ctx {
>  	size_t scratch_buf_size;
>  	int is_10bit;
>  	int is_422;
> +	int stride[VB2_MAX_PLANE_COUNT];
>  };
>  
>  /*
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> index e219cbcd86d5..317f796fffa1 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> @@ -56,6 +56,20 @@ static struct s5p_mfc_fmt formats[] = {
>  		.num_planes	= 2,
>  		.versions	= MFC_V6PLUS_BITS,
>  	},
> +	{
> +		.fourcc         = V4L2_PIX_FMT_YUV420M,
> +		.codec_mode     = S5P_MFC_CODEC_NONE,
> +		.type           = MFC_FMT_RAW,
> +		.num_planes     = 3,
> +		.versions       = MFC_V12_BIT,
> +	},
> +	{
> +		.fourcc         = V4L2_PIX_FMT_YVU420M,
> +		.codec_mode     = S5P_MFC_CODEC_NONE,
> +		.type           = MFC_FMT_RAW,
> +		.num_planes     = 3,
> +		.versions       = MFC_V12_BIT
> +	},
>  	{
>  		.fourcc		= V4L2_PIX_FMT_H264,
>  		.codec_mode	= S5P_MFC_CODEC_H264_DEC,
> @@ -359,10 +373,15 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  		/* Set pixelformat to the format in which MFC
>  		   outputs the decoded frame */
>  		pix_mp->pixelformat = ctx->dst_fmt->fourcc;
> -		pix_mp->plane_fmt[0].bytesperline = ctx->buf_width;
> +		pix_mp->plane_fmt[0].bytesperline = ctx->stride[0];
>  		pix_mp->plane_fmt[0].sizeimage = ctx->luma_size;
> -		pix_mp->plane_fmt[1].bytesperline = ctx->buf_width;
> +		pix_mp->plane_fmt[1].bytesperline = ctx->stride[1];
>  		pix_mp->plane_fmt[1].sizeimage = ctx->chroma_size;
> +		if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YVU420M) {
> +			pix_mp->plane_fmt[2].bytesperline = ctx->stride[2];
> +			pix_mp->plane_fmt[2].sizeimage = ctx->chroma_size_1;
> +		}
>  	} else if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
>  		/* This is run on OUTPUT
>  		   The buffer contains compressed image
> @@ -937,6 +956,9 @@ static int s5p_mfc_queue_setup(struct vb2_queue *vq,
>  		   vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>  		/* Output plane count is 2 - one for Y and one for CbCr */
>  		*plane_count = 2;
> +		if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YVU420M)

These misalignments produce a lot of checkpatch warnings.

Make sure you run your patch series through 'checkpatch.pl --strict'!

Regards,

	Hans

> +			*plane_count = 3;
>  		/* Setup buffer count */
>  		if (*buf_count < ctx->pb_count)
>  			*buf_count = ctx->pb_count;
> @@ -955,12 +977,17 @@ static int s5p_mfc_queue_setup(struct vb2_queue *vq,
>  	    vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>  		psize[0] = ctx->luma_size;
>  		psize[1] = ctx->chroma_size;
> -
> +		if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +			psize[2] = ctx->chroma_size_1;
>  		if (IS_MFCV6_PLUS(dev))
>  			alloc_devs[0] = ctx->dev->mem_dev[BANK_L_CTX];
>  		else
>  			alloc_devs[0] = ctx->dev->mem_dev[BANK_R_CTX];
>  		alloc_devs[1] = ctx->dev->mem_dev[BANK_L_CTX];
> +		if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +			alloc_devs[2] = ctx->dev->mem_dev[BANK_L_CTX];
>  	} else if (vq->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
>  		   ctx->state == MFCINST_INIT) {
>  		psize[0] = ctx->dec_src_buf_size;
> @@ -994,12 +1021,24 @@ static int s5p_mfc_buf_init(struct vb2_buffer *vb)
>  			mfc_err("Plane buffer (CAPTURE) is too small\n");
>  			return -EINVAL;
>  		}
> +		if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YVU420M) {
> +			if (vb2_plane_size(vb, 2) < ctx->chroma_size_1) {
> +				mfc_err("Plane buffer (CAPTURE) is too small\n");
> +				return -EINVAL;
> +			}
> +		}
>  		i = vb->index;
>  		ctx->dst_bufs[i].b = vbuf;
>  		ctx->dst_bufs[i].cookie.raw.luma =
>  					vb2_dma_contig_plane_dma_addr(vb, 0);
>  		ctx->dst_bufs[i].cookie.raw.chroma =
>  					vb2_dma_contig_plane_dma_addr(vb, 1);
> +		if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YVU420M) {
> +			ctx->dst_bufs[i].cookie.raw.chroma_1 =
> +					vb2_dma_contig_plane_dma_addr(vb, 2);
> +		}
>  		ctx->dst_bufs_cnt++;
>  	} else if (vq->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
>  		if (IS_ERR_OR_NULL(ERR_PTR(
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> index e4d6e7c117b5..0eec04eb3ef3 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> @@ -59,6 +59,20 @@ static struct s5p_mfc_fmt formats[] = {
>  		.num_planes	= 2,
>  		.versions	= MFC_V6PLUS_BITS,
>  	},
> +	{
> +		.fourcc         = V4L2_PIX_FMT_YUV420M,
> +		.codec_mode     = S5P_MFC_CODEC_NONE,
> +		.type           = MFC_FMT_RAW,
> +		.num_planes     = 3,
> +		.versions       = MFC_V12_BIT,
> +	},
> +	{
> +		.fourcc         = V4L2_PIX_FMT_YVU420M,
> +		.codec_mode     = S5P_MFC_CODEC_NONE,
> +		.type           = MFC_FMT_RAW,
> +		.num_planes     = 3,
> +		.versions       = MFC_V12_BIT,
> +	},
>  	{
>  		.fourcc		= V4L2_PIX_FMT_H264,
>  		.codec_mode	= S5P_MFC_CODEC_H264_ENC,
> @@ -1193,14 +1207,20 @@ static int enc_pre_frame_start(struct s5p_mfc_ctx *ctx)
>  	struct s5p_mfc_dev *dev = ctx->dev;
>  	struct s5p_mfc_buf *dst_mb;
>  	struct s5p_mfc_buf *src_mb;
> -	unsigned long src_y_addr, src_c_addr, dst_addr;
> +	unsigned long src_y_addr, src_c_addr, src_c_1_addr, dst_addr;
>  	unsigned int dst_size;
>  
>  	src_mb = list_entry(ctx->src_queue.next, struct s5p_mfc_buf, list);
>  	src_y_addr = vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 0);
>  	src_c_addr = vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 1);
> +	if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +			ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +		src_c_1_addr =
> +			vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 2);
> +	else
> +		src_c_1_addr = 0;
>  	s5p_mfc_hw_call(dev->mfc_ops, set_enc_frame_buffer, ctx,
> -							src_y_addr, src_c_addr);
> +					src_y_addr, src_c_addr, src_c_1_addr);
>  
>  	dst_mb = list_entry(ctx->dst_queue.next, struct s5p_mfc_buf, list);
>  	dst_addr = vb2_dma_contig_plane_dma_addr(&dst_mb->b->vb2_buf, 0);
> @@ -1215,8 +1235,8 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
>  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
>  	struct s5p_mfc_buf *mb_entry;
> -	unsigned long enc_y_addr = 0, enc_c_addr = 0;
> -	unsigned long mb_y_addr, mb_c_addr;
> +	unsigned long enc_y_addr = 0, enc_c_addr = 0, enc_c_1_addr = 0;
> +	unsigned long mb_y_addr, mb_c_addr, mb_c_1_addr;
>  	int slice_type;
>  	unsigned int strm_size;
>  	bool src_ready;
> @@ -1229,14 +1249,21 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
>  		  mfc_read(dev, S5P_FIMV_ENC_SI_PIC_CNT));
>  	if (slice_type >= 0) {
>  		s5p_mfc_hw_call(dev->mfc_ops, get_enc_frame_buffer, ctx,
> -				&enc_y_addr, &enc_c_addr);
> +				&enc_y_addr, &enc_c_addr, &enc_c_1_addr);
>  		list_for_each_entry(mb_entry, &ctx->src_queue, list) {
>  			mb_y_addr = vb2_dma_contig_plane_dma_addr(
>  					&mb_entry->b->vb2_buf, 0);
>  			mb_c_addr = vb2_dma_contig_plane_dma_addr(
>  					&mb_entry->b->vb2_buf, 1);
> -			if ((enc_y_addr == mb_y_addr) &&
> -						(enc_c_addr == mb_c_addr)) {
> +			if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +				mb_c_1_addr = vb2_dma_contig_plane_dma_addr
> +						(&mb_entry->b->vb2_buf, 2);
> +			else
> +				mb_c_1_addr = 0;
> +			if ((enc_y_addr == mb_y_addr)
> +					&& (enc_c_addr == mb_c_addr)
> +					&& (enc_c_1_addr == mb_c_1_addr)) {
>  				list_del(&mb_entry->list);
>  				ctx->src_queue_cnt--;
>  				vb2_buffer_done(&mb_entry->b->vb2_buf,
> @@ -1249,8 +1276,15 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
>  					&mb_entry->b->vb2_buf, 0);
>  			mb_c_addr = vb2_dma_contig_plane_dma_addr(
>  					&mb_entry->b->vb2_buf, 1);
> -			if ((enc_y_addr == mb_y_addr) &&
> -						(enc_c_addr == mb_c_addr)) {
> +			if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +				mb_c_1_addr = vb2_dma_contig_plane_dma_addr(
> +						&mb_entry->b->vb2_buf, 2);
> +			else
> +				mb_c_1_addr = 0;
> +			if ((enc_y_addr == mb_y_addr)
> +					&& (enc_c_addr == mb_c_addr)
> +					&& (enc_c_1_addr == mb_c_1_addr)) {
>  				list_del(&mb_entry->list);
>  				ctx->ref_queue_cnt--;
>  				vb2_buffer_done(&mb_entry->b->vb2_buf,
> @@ -1381,10 +1415,15 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  		pix_fmt_mp->pixelformat = ctx->src_fmt->fourcc;
>  		pix_fmt_mp->num_planes = ctx->src_fmt->num_planes;
>  
> -		pix_fmt_mp->plane_fmt[0].bytesperline = ctx->buf_width;
> +		pix_fmt_mp->plane_fmt[0].bytesperline = ctx->stride[0];
>  		pix_fmt_mp->plane_fmt[0].sizeimage = ctx->luma_size;
> -		pix_fmt_mp->plane_fmt[1].bytesperline = ctx->buf_width;
> +		pix_fmt_mp->plane_fmt[1].bytesperline = ctx->stride[1];
>  		pix_fmt_mp->plane_fmt[1].sizeimage = ctx->chroma_size;
> +		if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M) {
> +			pix_fmt_mp->plane_fmt[2].bytesperline = ctx->stride[2];
> +			pix_fmt_mp->plane_fmt[2].sizeimage = ctx->chroma_size_1;
> +		}
>  	} else {
>  		mfc_err("invalid buf type\n");
>  		return -EINVAL;
> @@ -1468,9 +1507,14 @@ static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  
>  		s5p_mfc_hw_call(dev->mfc_ops, enc_calc_src_size, ctx);
>  		pix_fmt_mp->plane_fmt[0].sizeimage = ctx->luma_size;
> -		pix_fmt_mp->plane_fmt[0].bytesperline = ctx->buf_width;
> +		pix_fmt_mp->plane_fmt[0].bytesperline = ctx->stride[0];
>  		pix_fmt_mp->plane_fmt[1].sizeimage = ctx->chroma_size;
> -		pix_fmt_mp->plane_fmt[1].bytesperline = ctx->buf_width;
> +		pix_fmt_mp->plane_fmt[1].bytesperline = ctx->stride[1];
> +		if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M) {
> +			pix_fmt_mp->plane_fmt[2].bytesperline = ctx->stride[2];
> +			pix_fmt_mp->plane_fmt[2].sizeimage = ctx->chroma_size_1;
> +		}
>  
>  		ctx->src_bufs_cnt = 0;
>  		ctx->output_state = QUEUE_FREE;
> @@ -2414,10 +2458,16 @@ static int s5p_mfc_queue_setup(struct vb2_queue *vq,
>  
>  		psize[0] = ctx->luma_size;
>  		psize[1] = ctx->chroma_size;
> +		if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +			psize[2] = ctx->chroma_size_1;
>  
>  		if (IS_MFCV6_PLUS(dev)) {
>  			alloc_devs[0] = ctx->dev->mem_dev[BANK_L_CTX];
>  			alloc_devs[1] = ctx->dev->mem_dev[BANK_L_CTX];
> +			if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +				alloc_devs[2] = ctx->dev->mem_dev[BANK_L_CTX];
>  		} else {
>  			alloc_devs[0] = ctx->dev->mem_dev[BANK_R_CTX];
>  			alloc_devs[1] = ctx->dev->mem_dev[BANK_R_CTX];
> @@ -2456,6 +2506,10 @@ static int s5p_mfc_buf_init(struct vb2_buffer *vb)
>  					vb2_dma_contig_plane_dma_addr(vb, 0);
>  		ctx->src_bufs[i].cookie.raw.chroma =
>  					vb2_dma_contig_plane_dma_addr(vb, 1);
> +		if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +			ctx->src_bufs[i].cookie.raw.chroma_1 =
> +					vb2_dma_contig_plane_dma_addr(vb, 2);
>  		ctx->src_bufs_cnt++;
>  	} else {
>  		mfc_err("invalid queue type: %d\n", vq->type);
> @@ -2493,6 +2547,12 @@ static int s5p_mfc_buf_prepare(struct vb2_buffer *vb)
>  			mfc_err("plane size is too small for output\n");
>  			return -EINVAL;
>  		}
> +		if ((ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +		     ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M) &&
> +		    (vb2_plane_size(vb, 2) < ctx->chroma_size_1)) {
> +			mfc_err("plane size is too small for output\n");
> +			return -EINVAL;
> +		}
>  	} else {
>  		mfc_err("invalid queue type: %d\n", vq->type);
>  		return -EINVAL;
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> index 87ac56756a16..7c5e851c8191 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> @@ -293,9 +293,11 @@ struct s5p_mfc_hw_ops {
>  	int (*set_enc_stream_buffer)(struct s5p_mfc_ctx *ctx,
>  			unsigned long addr, unsigned int size);
>  	void (*set_enc_frame_buffer)(struct s5p_mfc_ctx *ctx,
> -			unsigned long y_addr, unsigned long c_addr);
> +			unsigned long y_addr, unsigned long c_addr,
> +			unsigned long c_1_addr);
>  	void (*get_enc_frame_buffer)(struct s5p_mfc_ctx *ctx,
> -			unsigned long *y_addr, unsigned long *c_addr);
> +			unsigned long *y_addr, unsigned long *c_addr,
> +			unsigned long *c_1_addr);
>  	void (*try_run)(struct s5p_mfc_dev *dev);
>  	void (*clear_int_flags)(struct s5p_mfc_dev *dev);
>  	int (*get_dspl_y_adr)(struct s5p_mfc_dev *dev);
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> index 28a06dc343fd..fcfaf125a5a1 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> @@ -516,7 +516,8 @@ static int s5p_mfc_set_enc_stream_buffer_v5(struct s5p_mfc_ctx *ctx,
>  }
>  
>  static void s5p_mfc_set_enc_frame_buffer_v5(struct s5p_mfc_ctx *ctx,
> -		unsigned long y_addr, unsigned long c_addr)
> +		unsigned long y_addr, unsigned long c_addr,
> +		unsigned long c_1_addr)
>  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
>  
> @@ -525,7 +526,8 @@ static void s5p_mfc_set_enc_frame_buffer_v5(struct s5p_mfc_ctx *ctx,
>  }
>  
>  static void s5p_mfc_get_enc_frame_buffer_v5(struct s5p_mfc_ctx *ctx,
> -		unsigned long *y_addr, unsigned long *c_addr)
> +		unsigned long *y_addr, unsigned long *c_addr,
> +		unsigned long *c_1_addr)
>  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
>  
> @@ -1210,7 +1212,7 @@ static int s5p_mfc_run_enc_frame(struct s5p_mfc_ctx *ctx)
>  	if (list_empty(&ctx->src_queue)) {
>  		/* send null frame */
>  		s5p_mfc_set_enc_frame_buffer_v5(ctx, dev->dma_base[BANK_R_CTX],
> -						dev->dma_base[BANK_R_CTX]);
> +						dev->dma_base[BANK_R_CTX], 0);
>  		src_mb = NULL;
>  	} else {
>  		src_mb = list_entry(ctx->src_queue.next, struct s5p_mfc_buf,
> @@ -1220,7 +1222,7 @@ static int s5p_mfc_run_enc_frame(struct s5p_mfc_ctx *ctx)
>  			/* send null frame */
>  			s5p_mfc_set_enc_frame_buffer_v5(ctx,
>  						dev->dma_base[BANK_R_CTX],
> -						dev->dma_base[BANK_R_CTX]);
> +						dev->dma_base[BANK_R_CTX], 0);
>  			ctx->state = MFCINST_FINISHING;
>  		} else {
>  			src_y_addr = vb2_dma_contig_plane_dma_addr(
> @@ -1228,7 +1230,7 @@ static int s5p_mfc_run_enc_frame(struct s5p_mfc_ctx *ctx)
>  			src_c_addr = vb2_dma_contig_plane_dma_addr(
>  					&src_mb->b->vb2_buf, 1);
>  			s5p_mfc_set_enc_frame_buffer_v5(ctx, src_y_addr,
> -								src_c_addr);
> +								src_c_addr, 0);
>  			if (src_mb->flags & MFC_BUF_FLAG_EOS)
>  				ctx->state = MFCINST_FINISHING;
>  		}
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> index fb3f0718821d..e579c765e902 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -494,16 +494,43 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
>  	struct s5p_mfc_dev *dev = ctx->dev;
>  	ctx->buf_width = ALIGN(ctx->img_width, S5P_FIMV_NV12MT_HALIGN_V6);
>  	ctx->buf_height = ALIGN(ctx->img_height, S5P_FIMV_NV12MT_VALIGN_V6);
> +	ctx->chroma_size_1 = 0;
>  	mfc_debug(2, "SEQ Done: Movie dimensions %dx%d,\n"
>  			"buffer dimensions: %dx%d\n", ctx->img_width,
>  			ctx->img_height, ctx->buf_width, ctx->buf_height);
>  
> -	ctx->luma_size = calc_plane(ctx->img_width, ctx->img_height);
> -	ctx->chroma_size = calc_plane(ctx->img_width, (ctx->img_height >> 1));
> +	switch (ctx->dst_fmt->fourcc) {
> +	case V4L2_PIX_FMT_NV12M:
> +	case V4L2_PIX_FMT_NV21M:
> +		ctx->stride[0] = ALIGN(ctx->img_width,
> +					S5P_FIMV_NV12MT_HALIGN_V6);
> +		ctx->stride[1] = ALIGN(ctx->img_width,
> +					S5P_FIMV_NV12MT_HALIGN_V6);
> +		ctx->luma_size = calc_plane(ctx->stride[0], ctx->img_height);
> +		ctx->chroma_size = calc_plane(ctx->stride[1],
> +					(ctx->img_height / 2));
> +		break;
> +	case V4L2_PIX_FMT_YUV420M:
> +	case V4L2_PIX_FMT_YVU420M:
> +		ctx->stride[0] = ALIGN(ctx->img_width,
> +					S5P_FIMV_NV12MT_HALIGN_V6);
> +		ctx->stride[1] = ALIGN(ctx->img_width / 2,
> +					S5P_FIMV_NV12MT_HALIGN_V6);
> +		ctx->stride[2] = ALIGN(ctx->img_width / 2,
> +					S5P_FIMV_NV12MT_HALIGN_V6);
> +		ctx->luma_size = calc_plane(ctx->stride[0], ctx->img_height);
> +		ctx->chroma_size = calc_plane(ctx->stride[1],
> +					(ctx->img_height / 2));
> +		ctx->chroma_size_1 = calc_plane(ctx->stride[2],
> +					(ctx->img_height / 2));
> +		break;
> +	}
> +
>  	if (IS_MFCV8_PLUS(ctx->dev)) {
>  		/* MFCv8 needs additional 64 bytes for luma,chroma dpb*/
>  		ctx->luma_size += S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
>  		ctx->chroma_size += S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
> +		ctx->chroma_size_1 += S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
>  	}
>  
>  	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
> @@ -534,15 +561,53 @@ static void s5p_mfc_enc_calc_src_size_v6(struct s5p_mfc_ctx *ctx)
>  	mb_width = MB_WIDTH(ctx->img_width);
>  	mb_height = MB_HEIGHT(ctx->img_height);
>  
> -	ctx->buf_width = ALIGN(ctx->img_width, S5P_FIMV_NV12M_HALIGN_V6);
> -	ctx->luma_size = ALIGN((mb_width * mb_height) * 256, 256);
> -	ctx->chroma_size = ALIGN((mb_width * mb_height) * 128, 256);
> -
> -	/* MFCv7 needs pad bytes for Luma and Chroma */
> -	if (IS_MFCV7_PLUS(ctx->dev)) {
> +	if (IS_MFCV12(ctx->dev)) {
> +		switch (ctx->src_fmt->fourcc) {
> +		case V4L2_PIX_FMT_NV12M:
> +		case V4L2_PIX_FMT_NV21M:
> +			ctx->stride[0] = ALIGN(ctx->img_width,
> +						S5P_FIMV_NV12M_HALIGN_V6);
> +			ctx->stride[1] = ALIGN(ctx->img_width,
> +						S5P_FIMV_NV12M_HALIGN_V6);
> +			ctx->luma_size = ctx->stride[0] *
> +						ALIGN(ctx->img_height, 16);
> +			ctx->chroma_size =  ctx->stride[0] *
> +						ALIGN(ctx->img_height / 2, 16);
> +			break;
> +		case V4L2_PIX_FMT_YUV420M:
> +		case V4L2_PIX_FMT_YVU420M:
> +			ctx->stride[0] = ALIGN(ctx->img_width,
> +						S5P_FIMV_NV12M_HALIGN_V6);
> +			ctx->stride[1] = ALIGN(ctx->img_width / 2,
> +						S5P_FIMV_NV12M_HALIGN_V6);
> +			ctx->stride[2] = ALIGN(ctx->img_width / 2,
> +						S5P_FIMV_NV12M_HALIGN_V6);
> +			ctx->luma_size = ctx->stride[0] *
> +						ALIGN(ctx->img_height, 16);
> +			ctx->chroma_size =  ctx->stride[1] *
> +						ALIGN(ctx->img_height / 2, 16);
> +			ctx->chroma_size_1 =  ctx->stride[2] *
> +						ALIGN(ctx->img_height / 2, 16);
> +			break;
> +		}
>  		ctx->luma_size += MFC_LUMA_PAD_BYTES_V7;
> -		ctx->chroma_size += MFC_CHROMA_PAD_BYTES_V7;
> +		ctx->chroma_size += MFC_CHROMA_PAD_BYTES_V12;
> +		ctx->chroma_size_1 += MFC_CHROMA_PAD_BYTES_V12;
> +	} else {
> +		ctx->buf_width = ALIGN(ctx->img_width,
> +					S5P_FIMV_NV12M_HALIGN_V6);
> +		ctx->stride[0] = ctx->buf_width;
> +		ctx->stride[1] = ctx->buf_width;
> +		ctx->luma_size = ALIGN((mb_width * mb_height) * 256, 256);
> +		ctx->chroma_size = ALIGN((mb_width * mb_height) * 128, 256);
> +		ctx->chroma_size_1 = 0;
> +		/* MFCv7 needs pad bytes for Luma and Chroma */
> +		if (IS_MFCV7_PLUS(ctx->dev)) {
> +			ctx->luma_size += MFC_LUMA_PAD_BYTES_V7;
> +			ctx->chroma_size += MFC_LUMA_PAD_BYTES_V7;
> +		}
>  	}
> +
>  }
>  
>  /* Set registers for decoding stream buffer */
> @@ -588,15 +653,21 @@ static int s5p_mfc_set_dec_frame_buffer_v6(struct s5p_mfc_ctx *ctx)
>  	writel(ctx->total_dpb_count, mfc_regs->d_num_dpb);
>  	writel(ctx->luma_size, mfc_regs->d_first_plane_dpb_size);
>  	writel(ctx->chroma_size, mfc_regs->d_second_plane_dpb_size);
> -
> +	if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +			ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +		writel(ctx->chroma_size_1, mfc_regs->d_third_plane_dpb_size);
>  	writel(buf_addr1, mfc_regs->d_scratch_buffer_addr);
>  	writel(ctx->scratch_buf_size, mfc_regs->d_scratch_buffer_size);
>  
>  	if (IS_MFCV8_PLUS(dev)) {
> -		writel(ctx->img_width,
> +		writel(ctx->stride[0],
>  			mfc_regs->d_first_plane_dpb_stride_size);
> -		writel(ctx->img_width,
> +		writel(ctx->stride[1],
>  			mfc_regs->d_second_plane_dpb_stride_size);
> +		if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +			writel(ctx->stride[2],
> +				mfc_regs->d_third_plane_dpb_stride_size);
>  	}
>  
>  	buf_addr1 += ctx->scratch_buf_size;
> @@ -625,6 +696,13 @@ static int s5p_mfc_set_dec_frame_buffer_v6(struct s5p_mfc_ctx *ctx)
>  					ctx->dst_bufs[i].cookie.raw.chroma);
>  		writel(ctx->dst_bufs[i].cookie.raw.chroma,
>  				mfc_regs->d_second_plane_dpb + i * 4);
> +		if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YVU420M) {
> +			mfc_debug(2, "\tChroma_1 %d: %zx\n", i,
> +					ctx->dst_bufs[i].cookie.raw.chroma_1);
> +			writel(ctx->dst_bufs[i].cookie.raw.chroma_1,
> +					mfc_regs->d_third_plane_dpb + i * 4);
> +		}
>  	}
>  	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
>  			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC ||
> @@ -683,20 +761,24 @@ static int s5p_mfc_set_enc_stream_buffer_v6(struct s5p_mfc_ctx *ctx,
>  }
>  
>  static void s5p_mfc_set_enc_frame_buffer_v6(struct s5p_mfc_ctx *ctx,
> -		unsigned long y_addr, unsigned long c_addr)
> +		unsigned long y_addr, unsigned long c_addr,
> +		unsigned long c_1_addr)
>  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
>  	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
>  
>  	writel(y_addr, mfc_regs->e_source_first_plane_addr);
>  	writel(c_addr, mfc_regs->e_source_second_plane_addr);
> +	writel(c_1_addr, mfc_regs->e_source_third_plane_addr);
>  
>  	mfc_debug(2, "enc src y buf addr: 0x%08lx\n", y_addr);
>  	mfc_debug(2, "enc src c buf addr: 0x%08lx\n", c_addr);
> +	mfc_debug(2, "enc src cr buf addr: 0x%08lx\n", c_1_addr);
>  }
>  
>  static void s5p_mfc_get_enc_frame_buffer_v6(struct s5p_mfc_ctx *ctx,
> -		unsigned long *y_addr, unsigned long *c_addr)
> +		unsigned long *y_addr, unsigned long *c_addr,
> +		unsigned long *c_1_addr)
>  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
>  	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
> @@ -704,12 +786,17 @@ static void s5p_mfc_get_enc_frame_buffer_v6(struct s5p_mfc_ctx *ctx,
>  
>  	*y_addr = readl(mfc_regs->e_encoded_source_first_plane_addr);
>  	*c_addr = readl(mfc_regs->e_encoded_source_second_plane_addr);
> +	if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +			ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +		*c_1_addr = readl(mfc_regs->e_encoded_source_third_plane_addr);
> +	else
> +		*c_1_addr = 0;
>  
>  	enc_recon_y_addr = readl(mfc_regs->e_recon_luma_dpb_addr);
>  	enc_recon_c_addr = readl(mfc_regs->e_recon_chroma_dpb_addr);
>  
>  	mfc_debug(2, "recon y addr: 0x%08lx y_addr: 0x%08lx\n", enc_recon_y_addr, *y_addr);
> -	mfc_debug(2, "recon c addr: 0x%08lx\n", enc_recon_c_addr);
> +	mfc_debug(2, "recon c addr: 0x%08lx c_addr: 0x%08lx\n", enc_recon_c_addr, *c_addr);
>  }
>  
>  /* Set encoding ref & codec buffer */
> @@ -886,6 +973,20 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
>  		writel(reg, mfc_regs->e_enc_options);
>  		/* 0: NV12(CbCr), 1: NV21(CrCb) */
>  		writel(0x0, mfc_regs->pixel_format);
> +	} else if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M) {
> +		/* 0: Linear, 1: 2D tiled*/
> +		reg = readl(mfc_regs->e_enc_options);
> +		reg &= ~(0x1 << 7);
> +		writel(reg, mfc_regs->e_enc_options);
> +		/* 2: YV12(CrCb), 3: I420(CrCb) */
> +		writel(0x2, mfc_regs->pixel_format);
> +	} else if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M) {
> +		/* 0: Linear, 1: 2D tiled*/
> +		reg = readl(mfc_regs->e_enc_options);
> +		reg &= ~(0x1 << 7);
> +		writel(reg, mfc_regs->e_enc_options);
> +		/* 2: YV12(CrCb), 3: I420(CrCb) */
> +		writel(0x3, mfc_regs->pixel_format);
>  	}
>  
>  	/* memory structure recon. frame */
> @@ -1696,8 +1797,12 @@ static int s5p_mfc_init_decode_v6(struct s5p_mfc_ctx *ctx)
>  	else
>  		writel(reg, mfc_regs->d_dec_options);
>  
> -	/* 0: NV12(CbCr), 1: NV21(CrCb) */
> -	if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_NV21M)
> +	/* 0: NV12(CbCr), 1: NV21(CrCb), 2: YV12(CrCb), 3: I420(CbCr) */
> +	if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YUV420M)
> +		writel(0x3, mfc_regs->pixel_format);
> +	else if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +		writel(0x2, mfc_regs->pixel_format);
> +	else if (ctx->dst_fmt->fourcc == V4L2_PIX_FMT_NV21M)
>  		writel(0x1, mfc_regs->pixel_format);
>  	else
>  		writel(0x0, mfc_regs->pixel_format);
> @@ -1781,8 +1886,12 @@ static int s5p_mfc_init_encode_v6(struct s5p_mfc_ctx *ctx)
>  
>  	/* Set stride lengths for v7 & above */
>  	if (IS_MFCV7_PLUS(dev)) {
> -		writel(ctx->img_width, mfc_regs->e_source_first_plane_stride);
> -		writel(ctx->img_width, mfc_regs->e_source_second_plane_stride);
> +		writel(ctx->stride[0], mfc_regs->e_source_first_plane_stride);
> +		writel(ctx->stride[1], mfc_regs->e_source_second_plane_stride);
> +		if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +			writel(ctx->stride[2],
> +					mfc_regs->e_source_third_plane_stride);
>  	}
>  
>  	writel(ctx->inst_no, mfc_regs->instance_id);
> @@ -1891,7 +2000,7 @@ static inline int s5p_mfc_run_enc_frame(struct s5p_mfc_ctx *ctx)
>  	struct s5p_mfc_dev *dev = ctx->dev;
>  	struct s5p_mfc_buf *dst_mb;
>  	struct s5p_mfc_buf *src_mb;
> -	unsigned long src_y_addr, src_c_addr, dst_addr;
> +	unsigned long src_y_addr, src_c_addr, src_c_1_addr, dst_addr;
>  	/*
>  	unsigned int src_y_size, src_c_size;
>  	*/
> @@ -1909,22 +2018,29 @@ static inline int s5p_mfc_run_enc_frame(struct s5p_mfc_ctx *ctx)
>  
>  	if (list_empty(&ctx->src_queue)) {
>  		/* send null frame */
> -		s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0);
> +		s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0, 0);
>  		src_mb = NULL;
>  	} else {
>  		src_mb = list_entry(ctx->src_queue.next, struct s5p_mfc_buf, list);
>  		src_mb->flags |= MFC_BUF_FLAG_USED;
>  		if (src_mb->b->vb2_buf.planes[0].bytesused == 0) {
> -			s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0);
> +			s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0, 0);
>  			ctx->state = MFCINST_FINISHING;
>  		} else {
>  			src_y_addr = vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 0);
>  			src_c_addr = vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 1);
> +			if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc == V4L2_PIX_FMT_YVU420M)
> +				src_c_1_addr = vb2_dma_contig_plane_dma_addr
> +						(&src_mb->b->vb2_buf, 2);
> +			else
> +				src_c_1_addr = 0;
>  
>  			mfc_debug(2, "enc src y addr: 0x%08lx\n", src_y_addr);
>  			mfc_debug(2, "enc src c addr: 0x%08lx\n", src_c_addr);
>  
> -			s5p_mfc_set_enc_frame_buffer_v6(ctx, src_y_addr, src_c_addr);
> +			s5p_mfc_set_enc_frame_buffer_v6(ctx, src_y_addr,
> +						src_c_addr, src_c_1_addr);
>  			if (src_mb->flags & MFC_BUF_FLAG_EOS)
>  				ctx->state = MFCINST_FINISHING;
>  		}
> @@ -2450,6 +2566,8 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
>  			S5P_FIMV_E_ENCODED_SOURCE_FIRST_ADDR_V7);
>  	R(e_encoded_source_second_plane_addr,
>  			S5P_FIMV_E_ENCODED_SOURCE_SECOND_ADDR_V7);
> +	R(e_encoded_source_third_plane_addr,
> +			S5P_FIMV_E_ENCODED_SOURCE_THIRD_ADDR_V7);
>  	R(e_vp8_options, S5P_FIMV_E_VP8_OPTIONS_V7);
>  
>  	if (!IS_MFCV8_PLUS(dev))
> @@ -2464,16 +2582,20 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
>  	R(d_cpb_buffer_offset, S5P_FIMV_D_CPB_BUFFER_OFFSET_V8);
>  	R(d_first_plane_dpb_size, S5P_FIMV_D_FIRST_PLANE_DPB_SIZE_V8);
>  	R(d_second_plane_dpb_size, S5P_FIMV_D_SECOND_PLANE_DPB_SIZE_V8);
> +	R(d_third_plane_dpb_size, S5P_FIMV_D_THIRD_PLANE_DPB_SIZE_V8);
>  	R(d_scratch_buffer_addr, S5P_FIMV_D_SCRATCH_BUFFER_ADDR_V8);
>  	R(d_scratch_buffer_size, S5P_FIMV_D_SCRATCH_BUFFER_SIZE_V8);
>  	R(d_first_plane_dpb_stride_size,
>  			S5P_FIMV_D_FIRST_PLANE_DPB_STRIDE_SIZE_V8);
>  	R(d_second_plane_dpb_stride_size,
>  			S5P_FIMV_D_SECOND_PLANE_DPB_STRIDE_SIZE_V8);
> +	R(d_third_plane_dpb_stride_size,
> +			S5P_FIMV_D_THIRD_PLANE_DPB_STRIDE_SIZE_V8);
>  	R(d_mv_buffer_size, S5P_FIMV_D_MV_BUFFER_SIZE_V8);
>  	R(d_num_mv, S5P_FIMV_D_NUM_MV_V8);
>  	R(d_first_plane_dpb, S5P_FIMV_D_FIRST_PLANE_DPB_V8);
>  	R(d_second_plane_dpb, S5P_FIMV_D_SECOND_PLANE_DPB_V8);
> +	R(d_third_plane_dpb, S5P_FIMV_D_THIRD_PLANE_DPB_V8);
>  	R(d_mv_buffer, S5P_FIMV_D_MV_BUFFER_V8);
>  	R(d_init_buffer_options, S5P_FIMV_D_INIT_BUFFER_OPTIONS_V8);
>  	R(d_available_dpb_flag_lower, S5P_FIMV_D_AVAILABLE_DPB_FLAG_LOWER_V8);

