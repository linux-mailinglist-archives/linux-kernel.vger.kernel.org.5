Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF537F655F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345553AbjKWRZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345173AbjKWRZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:25:48 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE95120
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:25:49 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cd6e1d4fbso5245491cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1700760349; x=1701365149; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0cvnM+LARilaUVxVrbILLWc6xlA8g5XUV73LJ3CypJc=;
        b=inFmmRMwMWuWTcPdJUAupIz6arF7uemF5FoSt20rIvkv5cmfhcYpL22CLav1n3a72K
         w1kl0SBlKXiascE1UUw6CpnxiAz9yhF8k6/8w8Zs1FsMs0Kru1xID8J8VWnsVX0XJG+o
         QQwiDslxfsqnAJR19j0zO5O7H22G7s4X7n95m7M68s/06tFzM7pMcpqsy3Z+4Ec9F2F/
         T+pI+DBit+14O6yh4kM+uuxIsDpzLrsJB+B4unK4E53x0AZxTjvTnBBIY7UUOAtKIVt3
         U5jmB2NoyJ/+COhUOgZiagK5q/gmCPTXHkmryNnf+7Pf/COePQvsGJxzQgAeiewvFspJ
         OMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700760349; x=1701365149;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cvnM+LARilaUVxVrbILLWc6xlA8g5XUV73LJ3CypJc=;
        b=kv0qcvMuNKdzZ+e5rDnJv/x68UAwgeimPabhVR+vPMF5nuJ8b/WEtNMw9O6k0pSwoA
         afLyhEab6WlCd6yKlD8Ac1MFyJpHSoK+1Pdelrt7aPHz9bvQcgUcWAVb2PorgZgFzyWO
         DMN80GbS/LVLrQfWgCX82+SMIx38mdA1bO4+SBhn2rn4UtAUTqump07khbyxdLvorev6
         ejkHw5GUk5cVn1veN9yt+tacCrtN+jbpFcRbBL5khwU5KLIs5k4QnHH24wGQoO04C2PP
         R80GVTee8kUFN8hIAs4J9jCS40lsZNDwGhnuLl0As15ChbkZjKhW7pfEzcjHmvBkB3bb
         ScGA==
X-Gm-Message-State: AOJu0YyLaa6U3376IwxVyxXZaHRfsO4tu8FxuMxIGlq98EOt7yfMnn2x
        tI8H2LzMWHqzsJRacDSBFwEtzw==
X-Google-Smtp-Source: AGHT+IHfy00ync0d4VGbRhfnrlTjRE9b5EA+Q0O4HJL2iJ3ee5bC3xKsc0PH9hGFOPeridx/8QFX6Q==
X-Received: by 2002:ac8:58d6:0:b0:421:c58e:f9a8 with SMTP id u22-20020ac858d6000000b00421c58ef9a8mr60936qta.32.1700760348709;
        Thu, 23 Nov 2023 09:25:48 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:3ac8::7a9])
        by smtp.gmail.com with ESMTPSA id h23-20020ac85157000000b0041cbf113c28sm619870qtn.40.2023.11.23.09.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:25:48 -0800 (PST)
Message-ID: <c49c871d2fecd82b73d255cea575d231827245ba.camel@ndufresne.ca>
Subject: Re: [Patch v4 04/11] media: s5p-mfc: Add YV12 and I420 multiplanar
 format support
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        linux-samsung-soc@vger.kernel.org, andi@etezian.org,
        gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, linux-fsd@tesla.com,
        Smitha T Murthy <smithatmurthy@gmail.com>
Date:   Thu, 23 Nov 2023 12:25:46 -0500
In-Reply-To: <20231025102216.50480-5-aakarsh.jain@samsung.com>
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
         <CGME20231025102243epcas5p1cdd0eb385d2381943d6d194eec3a569d@epcas5p1.samsung.com>
         <20231025102216.50480-5-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 25 octobre 2023 =C3=A0 15:52 +0530, Aakarsh Jain a =C3=A9crit=
=C2=A0:
> YV12 and I420 format (3-plane) support is added. Stride information is
> added to all formats and planes since it is necessary for YV12/I420
> which are different from width.
>=20
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
>=20
> diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/driv=
ers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> index 6c68a45082d0..70464f47c1f9 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> @@ -26,6 +26,8 @@
>  #define MFC_VERSION_V12			0xC0
>  #define MFC_NUM_PORTS_V12		1
>  #define S5P_FIMV_CODEC_VP9_ENC		27
> +#define MFC_CHROMA_PAD_BYTES_V12        256
> +#define S5P_FIMV_D_ALIGN_PLANE_SIZE_V12 256
> =20
>  /* Encoder buffer size for MFCv12 */
>  #define ENC_V120_BASE_SIZE(x, y) \
> diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h b/drive=
rs/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
> index 4a7adfdaa359..50f9bf0603c1 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
> @@ -24,6 +24,7 @@
> =20
>  #define S5P_FIMV_E_ENCODED_SOURCE_FIRST_ADDR_V7		0xfa70
>  #define S5P_FIMV_E_ENCODED_SOURCE_SECOND_ADDR_V7	0xfa74
> +#define S5P_FIMV_E_ENCODED_SOURCE_THIRD_ADDR_V7		0xfa78
> =20
>  #define S5P_FIMV_E_VP8_OPTIONS_V7			0xfdb0
>  #define S5P_FIMV_E_VP8_FILTER_OPTIONS_V7		0xfdb4
> diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h b/drive=
rs/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
> index 162e3c7e920f..0ef9eb2dff22 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
> @@ -17,13 +17,16 @@
>  #define S5P_FIMV_D_MIN_SCRATCH_BUFFER_SIZE_V8	0xf108
>  #define S5P_FIMV_D_FIRST_PLANE_DPB_SIZE_V8	0xf144
>  #define S5P_FIMV_D_SECOND_PLANE_DPB_SIZE_V8	0xf148
> +#define S5P_FIMV_D_THIRD_PLANE_DPB_SIZE_V8	0xf14C
>  #define S5P_FIMV_D_MV_BUFFER_SIZE_V8		0xf150
> =20
>  #define S5P_FIMV_D_FIRST_PLANE_DPB_STRIDE_SIZE_V8	0xf138
>  #define S5P_FIMV_D_SECOND_PLANE_DPB_STRIDE_SIZE_V8	0xf13c
> +#define S5P_FIMV_D_THIRD_PLANE_DPB_STRIDE_SIZE_V8	0xf140
> =20
>  #define S5P_FIMV_D_FIRST_PLANE_DPB_V8		0xf160
>  #define S5P_FIMV_D_SECOND_PLANE_DPB_V8		0xf260
> +#define S5P_FIMV_D_THIRD_PLANE_DPB_V8		0xf360
>  #define S5P_FIMV_D_MV_BUFFER_V8			0xf460
> =20
>  #define S5P_FIMV_D_NUM_MV_V8			0xf134
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/dr=
ivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
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
> =20
> @@ -181,6 +182,7 @@ struct s5p_mfc_buf {
>  		struct {
>  			size_t luma;
>  			size_t chroma;
> +			size_t chroma_1;
>  		} raw;
>  		size_t stream;
>  	} cookie;
> @@ -657,6 +659,7 @@ struct s5p_mfc_ctx {
> =20
>  	int luma_size;
>  	int chroma_size;
> +	int chroma_size_1;
>  	int mv_size;
> =20
>  	unsigned long consumed_stream;
> @@ -722,6 +725,7 @@ struct s5p_mfc_ctx {
>  	size_t scratch_buf_size;
>  	int is_10bit;
>  	int is_422;
> +	int stride[VB2_MAX_PLANE_COUNT];
>  };
> =20
>  /*
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drive=
rs/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> index e219cbcd86d5..317f796fffa1 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> @@ -56,6 +56,20 @@ static struct s5p_mfc_fmt formats[] =3D {
>  		.num_planes	=3D 2,
>  		.versions	=3D MFC_V6PLUS_BITS,
>  	},
> +	{
> +		.fourcc         =3D V4L2_PIX_FMT_YUV420M,
> +		.codec_mode     =3D S5P_MFC_CODEC_NONE,
> +		.type           =3D MFC_FMT_RAW,
> +		.num_planes     =3D 3,
> +		.versions       =3D MFC_V12_BIT,
> +	},
> +	{
> +		.fourcc         =3D V4L2_PIX_FMT_YVU420M,
> +		.codec_mode     =3D S5P_MFC_CODEC_NONE,
> +		.type           =3D MFC_FMT_RAW,
> +		.num_planes     =3D 3,
> +		.versions       =3D MFC_V12_BIT
> +	},
>  	{
>  		.fourcc		=3D V4L2_PIX_FMT_H264,
>  		.codec_mode	=3D S5P_MFC_CODEC_H264_DEC,
> @@ -359,10 +373,15 @@ static int vidioc_g_fmt(struct file *file, void *pr=
iv, struct v4l2_format *f)
>  		/* Set pixelformat to the format in which MFC
>  		   outputs the decoded frame */
>  		pix_mp->pixelformat =3D ctx->dst_fmt->fourcc;
> -		pix_mp->plane_fmt[0].bytesperline =3D ctx->buf_width;
> +		pix_mp->plane_fmt[0].bytesperline =3D ctx->stride[0];
>  		pix_mp->plane_fmt[0].sizeimage =3D ctx->luma_size;
> -		pix_mp->plane_fmt[1].bytesperline =3D ctx->buf_width;
> +		pix_mp->plane_fmt[1].bytesperline =3D ctx->stride[1];
>  		pix_mp->plane_fmt[1].sizeimage =3D ctx->chroma_size;
> +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M) {
> +			pix_mp->plane_fmt[2].bytesperline =3D ctx->stride[2];
> +			pix_mp->plane_fmt[2].sizeimage =3D ctx->chroma_size_1;
> +		}
>  	} else if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
>  		/* This is run on OUTPUT
>  		   The buffer contains compressed image
> @@ -937,6 +956,9 @@ static int s5p_mfc_queue_setup(struct vb2_queue *vq,
>  		   vq->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>  		/* Output plane count is 2 - one for Y and one for CbCr */
>  		*plane_count =3D 2;
> +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +			*plane_count =3D 3;

I don't usually interfere, this is your driver to maintain, but this become=
s
horribly messy. Have you consider de-hardcoding a little and encapsulate pe=
r HW
format details into a C structure ? Drivers these days try to make sure of =
v4l2-
common library, which as a matter of fact knows that YUV420M and YVU420M ha=
ve 3
places, so that you don't have to duplicate it in your driver.

regards,
Nicolas

>  		/* Setup buffer count */
>  		if (*buf_count < ctx->pb_count)
>  			*buf_count =3D ctx->pb_count;
> @@ -955,12 +977,17 @@ static int s5p_mfc_queue_setup(struct vb2_queue *vq=
,
>  	    vq->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>  		psize[0] =3D ctx->luma_size;
>  		psize[1] =3D ctx->chroma_size;
> -
> +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +			psize[2] =3D ctx->chroma_size_1;
>  		if (IS_MFCV6_PLUS(dev))
>  			alloc_devs[0] =3D ctx->dev->mem_dev[BANK_L_CTX];
>  		else
>  			alloc_devs[0] =3D ctx->dev->mem_dev[BANK_R_CTX];
>  		alloc_devs[1] =3D ctx->dev->mem_dev[BANK_L_CTX];
> +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +			alloc_devs[2] =3D ctx->dev->mem_dev[BANK_L_CTX];
>  	} else if (vq->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
>  		   ctx->state =3D=3D MFCINST_INIT) {
>  		psize[0] =3D ctx->dec_src_buf_size;
> @@ -994,12 +1021,24 @@ static int s5p_mfc_buf_init(struct vb2_buffer *vb)
>  			mfc_err("Plane buffer (CAPTURE) is too small\n");
>  			return -EINVAL;
>  		}
> +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M) {
> +			if (vb2_plane_size(vb, 2) < ctx->chroma_size_1) {
> +				mfc_err("Plane buffer (CAPTURE) is too small\n");
> +				return -EINVAL;
> +			}
> +		}
>  		i =3D vb->index;
>  		ctx->dst_bufs[i].b =3D vbuf;
>  		ctx->dst_bufs[i].cookie.raw.luma =3D
>  					vb2_dma_contig_plane_dma_addr(vb, 0);
>  		ctx->dst_bufs[i].cookie.raw.chroma =3D
>  					vb2_dma_contig_plane_dma_addr(vb, 1);
> +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M) {
> +			ctx->dst_bufs[i].cookie.raw.chroma_1 =3D
> +					vb2_dma_contig_plane_dma_addr(vb, 2);
> +		}
>  		ctx->dst_bufs_cnt++;
>  	} else if (vq->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
>  		if (IS_ERR_OR_NULL(ERR_PTR(
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drive=
rs/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> index e4d6e7c117b5..0eec04eb3ef3 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> @@ -59,6 +59,20 @@ static struct s5p_mfc_fmt formats[] =3D {
>  		.num_planes	=3D 2,
>  		.versions	=3D MFC_V6PLUS_BITS,
>  	},
> +	{
> +		.fourcc         =3D V4L2_PIX_FMT_YUV420M,
> +		.codec_mode     =3D S5P_MFC_CODEC_NONE,
> +		.type           =3D MFC_FMT_RAW,
> +		.num_planes     =3D 3,
> +		.versions       =3D MFC_V12_BIT,
> +	},
> +	{
> +		.fourcc         =3D V4L2_PIX_FMT_YVU420M,
> +		.codec_mode     =3D S5P_MFC_CODEC_NONE,
> +		.type           =3D MFC_FMT_RAW,
> +		.num_planes     =3D 3,
> +		.versions       =3D MFC_V12_BIT,
> +	},
>  	{
>  		.fourcc		=3D V4L2_PIX_FMT_H264,
>  		.codec_mode	=3D S5P_MFC_CODEC_H264_ENC,
> @@ -1193,14 +1207,20 @@ static int enc_pre_frame_start(struct s5p_mfc_ctx=
 *ctx)
>  	struct s5p_mfc_dev *dev =3D ctx->dev;
>  	struct s5p_mfc_buf *dst_mb;
>  	struct s5p_mfc_buf *src_mb;
> -	unsigned long src_y_addr, src_c_addr, dst_addr;
> +	unsigned long src_y_addr, src_c_addr, src_c_1_addr, dst_addr;
>  	unsigned int dst_size;
> =20
>  	src_mb =3D list_entry(ctx->src_queue.next, struct s5p_mfc_buf, list);
>  	src_y_addr =3D vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 0);
>  	src_c_addr =3D vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 1);
> +	if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +			ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +		src_c_1_addr =3D
> +			vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 2);
> +	else
> +		src_c_1_addr =3D 0;
>  	s5p_mfc_hw_call(dev->mfc_ops, set_enc_frame_buffer, ctx,
> -							src_y_addr, src_c_addr);
> +					src_y_addr, src_c_addr, src_c_1_addr);
> =20
>  	dst_mb =3D list_entry(ctx->dst_queue.next, struct s5p_mfc_buf, list);
>  	dst_addr =3D vb2_dma_contig_plane_dma_addr(&dst_mb->b->vb2_buf, 0);
> @@ -1215,8 +1235,8 @@ static int enc_post_frame_start(struct s5p_mfc_ctx =
*ctx)
>  {
>  	struct s5p_mfc_dev *dev =3D ctx->dev;
>  	struct s5p_mfc_buf *mb_entry;
> -	unsigned long enc_y_addr =3D 0, enc_c_addr =3D 0;
> -	unsigned long mb_y_addr, mb_c_addr;
> +	unsigned long enc_y_addr =3D 0, enc_c_addr =3D 0, enc_c_1_addr =3D 0;
> +	unsigned long mb_y_addr, mb_c_addr, mb_c_1_addr;
>  	int slice_type;
>  	unsigned int strm_size;
>  	bool src_ready;
> @@ -1229,14 +1249,21 @@ static int enc_post_frame_start(struct s5p_mfc_ct=
x *ctx)
>  		  mfc_read(dev, S5P_FIMV_ENC_SI_PIC_CNT));
>  	if (slice_type >=3D 0) {
>  		s5p_mfc_hw_call(dev->mfc_ops, get_enc_frame_buffer, ctx,
> -				&enc_y_addr, &enc_c_addr);
> +				&enc_y_addr, &enc_c_addr, &enc_c_1_addr);
>  		list_for_each_entry(mb_entry, &ctx->src_queue, list) {
>  			mb_y_addr =3D vb2_dma_contig_plane_dma_addr(
>  					&mb_entry->b->vb2_buf, 0);
>  			mb_c_addr =3D vb2_dma_contig_plane_dma_addr(
>  					&mb_entry->b->vb2_buf, 1);
> -			if ((enc_y_addr =3D=3D mb_y_addr) &&
> -						(enc_c_addr =3D=3D mb_c_addr)) {
> +			if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +				mb_c_1_addr =3D vb2_dma_contig_plane_dma_addr
> +						(&mb_entry->b->vb2_buf, 2);
> +			else
> +				mb_c_1_addr =3D 0;
> +			if ((enc_y_addr =3D=3D mb_y_addr)
> +					&& (enc_c_addr =3D=3D mb_c_addr)
> +					&& (enc_c_1_addr =3D=3D mb_c_1_addr)) {
>  				list_del(&mb_entry->list);
>  				ctx->src_queue_cnt--;
>  				vb2_buffer_done(&mb_entry->b->vb2_buf,
> @@ -1249,8 +1276,15 @@ static int enc_post_frame_start(struct s5p_mfc_ctx=
 *ctx)
>  					&mb_entry->b->vb2_buf, 0);
>  			mb_c_addr =3D vb2_dma_contig_plane_dma_addr(
>  					&mb_entry->b->vb2_buf, 1);
> -			if ((enc_y_addr =3D=3D mb_y_addr) &&
> -						(enc_c_addr =3D=3D mb_c_addr)) {
> +			if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +				mb_c_1_addr =3D vb2_dma_contig_plane_dma_addr(
> +						&mb_entry->b->vb2_buf, 2);
> +			else
> +				mb_c_1_addr =3D 0;
> +			if ((enc_y_addr =3D=3D mb_y_addr)
> +					&& (enc_c_addr =3D=3D mb_c_addr)
> +					&& (enc_c_1_addr =3D=3D mb_c_1_addr)) {
>  				list_del(&mb_entry->list);
>  				ctx->ref_queue_cnt--;
>  				vb2_buffer_done(&mb_entry->b->vb2_buf,
> @@ -1381,10 +1415,15 @@ static int vidioc_g_fmt(struct file *file, void *=
priv, struct v4l2_format *f)
>  		pix_fmt_mp->pixelformat =3D ctx->src_fmt->fourcc;
>  		pix_fmt_mp->num_planes =3D ctx->src_fmt->num_planes;
> =20
> -		pix_fmt_mp->plane_fmt[0].bytesperline =3D ctx->buf_width;
> +		pix_fmt_mp->plane_fmt[0].bytesperline =3D ctx->stride[0];
>  		pix_fmt_mp->plane_fmt[0].sizeimage =3D ctx->luma_size;
> -		pix_fmt_mp->plane_fmt[1].bytesperline =3D ctx->buf_width;
> +		pix_fmt_mp->plane_fmt[1].bytesperline =3D ctx->stride[1];
>  		pix_fmt_mp->plane_fmt[1].sizeimage =3D ctx->chroma_size;
> +		if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M) {
> +			pix_fmt_mp->plane_fmt[2].bytesperline =3D ctx->stride[2];
> +			pix_fmt_mp->plane_fmt[2].sizeimage =3D ctx->chroma_size_1;
> +		}
>  	} else {
>  		mfc_err("invalid buf type\n");
>  		return -EINVAL;
> @@ -1468,9 +1507,14 @@ static int vidioc_s_fmt(struct file *file, void *p=
riv, struct v4l2_format *f)
> =20
>  		s5p_mfc_hw_call(dev->mfc_ops, enc_calc_src_size, ctx);
>  		pix_fmt_mp->plane_fmt[0].sizeimage =3D ctx->luma_size;
> -		pix_fmt_mp->plane_fmt[0].bytesperline =3D ctx->buf_width;
> +		pix_fmt_mp->plane_fmt[0].bytesperline =3D ctx->stride[0];
>  		pix_fmt_mp->plane_fmt[1].sizeimage =3D ctx->chroma_size;
> -		pix_fmt_mp->plane_fmt[1].bytesperline =3D ctx->buf_width;
> +		pix_fmt_mp->plane_fmt[1].bytesperline =3D ctx->stride[1];
> +		if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M) {
> +			pix_fmt_mp->plane_fmt[2].bytesperline =3D ctx->stride[2];
> +			pix_fmt_mp->plane_fmt[2].sizeimage =3D ctx->chroma_size_1;
> +		}
> =20
>  		ctx->src_bufs_cnt =3D 0;
>  		ctx->output_state =3D QUEUE_FREE;
> @@ -2414,10 +2458,16 @@ static int s5p_mfc_queue_setup(struct vb2_queue *=
vq,
> =20
>  		psize[0] =3D ctx->luma_size;
>  		psize[1] =3D ctx->chroma_size;
> +		if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +			psize[2] =3D ctx->chroma_size_1;
> =20
>  		if (IS_MFCV6_PLUS(dev)) {
>  			alloc_devs[0] =3D ctx->dev->mem_dev[BANK_L_CTX];
>  			alloc_devs[1] =3D ctx->dev->mem_dev[BANK_L_CTX];
> +			if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +				alloc_devs[2] =3D ctx->dev->mem_dev[BANK_L_CTX];
>  		} else {
>  			alloc_devs[0] =3D ctx->dev->mem_dev[BANK_R_CTX];
>  			alloc_devs[1] =3D ctx->dev->mem_dev[BANK_R_CTX];
> @@ -2456,6 +2506,10 @@ static int s5p_mfc_buf_init(struct vb2_buffer *vb)
>  					vb2_dma_contig_plane_dma_addr(vb, 0);
>  		ctx->src_bufs[i].cookie.raw.chroma =3D
>  					vb2_dma_contig_plane_dma_addr(vb, 1);
> +		if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +			ctx->src_bufs[i].cookie.raw.chroma_1 =3D
> +					vb2_dma_contig_plane_dma_addr(vb, 2);
>  		ctx->src_bufs_cnt++;
>  	} else {
>  		mfc_err("invalid queue type: %d\n", vq->type);
> @@ -2493,6 +2547,12 @@ static int s5p_mfc_buf_prepare(struct vb2_buffer *=
vb)
>  			mfc_err("plane size is too small for output\n");
>  			return -EINVAL;
>  		}
> +		if ((ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +		     ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M) &&
> +		    (vb2_plane_size(vb, 2) < ctx->chroma_size_1)) {
> +			mfc_err("plane size is too small for output\n");
> +			return -EINVAL;
> +		}
>  	} else {
>  		mfc_err("invalid queue type: %d\n", vq->type);
>  		return -EINVAL;
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h b/drive=
rs/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
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
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c b/dr=
ivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> index 28a06dc343fd..fcfaf125a5a1 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> @@ -516,7 +516,8 @@ static int s5p_mfc_set_enc_stream_buffer_v5(struct s5=
p_mfc_ctx *ctx,
>  }
> =20
>  static void s5p_mfc_set_enc_frame_buffer_v5(struct s5p_mfc_ctx *ctx,
> -		unsigned long y_addr, unsigned long c_addr)
> +		unsigned long y_addr, unsigned long c_addr,
> +		unsigned long c_1_addr)
>  {
>  	struct s5p_mfc_dev *dev =3D ctx->dev;
> =20
> @@ -525,7 +526,8 @@ static void s5p_mfc_set_enc_frame_buffer_v5(struct s5=
p_mfc_ctx *ctx,
>  }
> =20
>  static void s5p_mfc_get_enc_frame_buffer_v5(struct s5p_mfc_ctx *ctx,
> -		unsigned long *y_addr, unsigned long *c_addr)
> +		unsigned long *y_addr, unsigned long *c_addr,
> +		unsigned long *c_1_addr)
>  {
>  	struct s5p_mfc_dev *dev =3D ctx->dev;
> =20
> @@ -1210,7 +1212,7 @@ static int s5p_mfc_run_enc_frame(struct s5p_mfc_ctx=
 *ctx)
>  	if (list_empty(&ctx->src_queue)) {
>  		/* send null frame */
>  		s5p_mfc_set_enc_frame_buffer_v5(ctx, dev->dma_base[BANK_R_CTX],
> -						dev->dma_base[BANK_R_CTX]);
> +						dev->dma_base[BANK_R_CTX], 0);
>  		src_mb =3D NULL;
>  	} else {
>  		src_mb =3D list_entry(ctx->src_queue.next, struct s5p_mfc_buf,
> @@ -1220,7 +1222,7 @@ static int s5p_mfc_run_enc_frame(struct s5p_mfc_ctx=
 *ctx)
>  			/* send null frame */
>  			s5p_mfc_set_enc_frame_buffer_v5(ctx,
>  						dev->dma_base[BANK_R_CTX],
> -						dev->dma_base[BANK_R_CTX]);
> +						dev->dma_base[BANK_R_CTX], 0);
>  			ctx->state =3D MFCINST_FINISHING;
>  		} else {
>  			src_y_addr =3D vb2_dma_contig_plane_dma_addr(
> @@ -1228,7 +1230,7 @@ static int s5p_mfc_run_enc_frame(struct s5p_mfc_ctx=
 *ctx)
>  			src_c_addr =3D vb2_dma_contig_plane_dma_addr(
>  					&src_mb->b->vb2_buf, 1);
>  			s5p_mfc_set_enc_frame_buffer_v5(ctx, src_y_addr,
> -								src_c_addr);
> +								src_c_addr, 0);
>  			if (src_mb->flags & MFC_BUF_FLAG_EOS)
>  				ctx->state =3D MFCINST_FINISHING;
>  		}
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/dr=
ivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> index fb3f0718821d..e579c765e902 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -494,16 +494,43 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p=
_mfc_ctx *ctx)
>  	struct s5p_mfc_dev *dev =3D ctx->dev;
>  	ctx->buf_width =3D ALIGN(ctx->img_width, S5P_FIMV_NV12MT_HALIGN_V6);
>  	ctx->buf_height =3D ALIGN(ctx->img_height, S5P_FIMV_NV12MT_VALIGN_V6);
> +	ctx->chroma_size_1 =3D 0;
>  	mfc_debug(2, "SEQ Done: Movie dimensions %dx%d,\n"
>  			"buffer dimensions: %dx%d\n", ctx->img_width,
>  			ctx->img_height, ctx->buf_width, ctx->buf_height);
> =20
> -	ctx->luma_size =3D calc_plane(ctx->img_width, ctx->img_height);
> -	ctx->chroma_size =3D calc_plane(ctx->img_width, (ctx->img_height >> 1))=
;
> +	switch (ctx->dst_fmt->fourcc) {
> +	case V4L2_PIX_FMT_NV12M:
> +	case V4L2_PIX_FMT_NV21M:
> +		ctx->stride[0] =3D ALIGN(ctx->img_width,
> +					S5P_FIMV_NV12MT_HALIGN_V6);
> +		ctx->stride[1] =3D ALIGN(ctx->img_width,
> +					S5P_FIMV_NV12MT_HALIGN_V6);
> +		ctx->luma_size =3D calc_plane(ctx->stride[0], ctx->img_height);
> +		ctx->chroma_size =3D calc_plane(ctx->stride[1],
> +					(ctx->img_height / 2));
> +		break;
> +	case V4L2_PIX_FMT_YUV420M:
> +	case V4L2_PIX_FMT_YVU420M:
> +		ctx->stride[0] =3D ALIGN(ctx->img_width,
> +					S5P_FIMV_NV12MT_HALIGN_V6);
> +		ctx->stride[1] =3D ALIGN(ctx->img_width / 2,
> +					S5P_FIMV_NV12MT_HALIGN_V6);
> +		ctx->stride[2] =3D ALIGN(ctx->img_width / 2,
> +					S5P_FIMV_NV12MT_HALIGN_V6);
> +		ctx->luma_size =3D calc_plane(ctx->stride[0], ctx->img_height);
> +		ctx->chroma_size =3D calc_plane(ctx->stride[1],
> +					(ctx->img_height / 2));
> +		ctx->chroma_size_1 =3D calc_plane(ctx->stride[2],
> +					(ctx->img_height / 2));
> +		break;
> +	}
> +
>  	if (IS_MFCV8_PLUS(ctx->dev)) {
>  		/* MFCv8 needs additional 64 bytes for luma,chroma dpb*/
>  		ctx->luma_size +=3D S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
>  		ctx->chroma_size +=3D S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
> +		ctx->chroma_size_1 +=3D S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
>  	}
> =20
>  	if (ctx->codec_mode =3D=3D S5P_MFC_CODEC_H264_DEC ||
> @@ -534,15 +561,53 @@ static void s5p_mfc_enc_calc_src_size_v6(struct s5p=
_mfc_ctx *ctx)
>  	mb_width =3D MB_WIDTH(ctx->img_width);
>  	mb_height =3D MB_HEIGHT(ctx->img_height);
> =20
> -	ctx->buf_width =3D ALIGN(ctx->img_width, S5P_FIMV_NV12M_HALIGN_V6);
> -	ctx->luma_size =3D ALIGN((mb_width * mb_height) * 256, 256);
> -	ctx->chroma_size =3D ALIGN((mb_width * mb_height) * 128, 256);
> -
> -	/* MFCv7 needs pad bytes for Luma and Chroma */
> -	if (IS_MFCV7_PLUS(ctx->dev)) {
> +	if (IS_MFCV12(ctx->dev)) {
> +		switch (ctx->src_fmt->fourcc) {
> +		case V4L2_PIX_FMT_NV12M:
> +		case V4L2_PIX_FMT_NV21M:
> +			ctx->stride[0] =3D ALIGN(ctx->img_width,
> +						S5P_FIMV_NV12M_HALIGN_V6);
> +			ctx->stride[1] =3D ALIGN(ctx->img_width,
> +						S5P_FIMV_NV12M_HALIGN_V6);
> +			ctx->luma_size =3D ctx->stride[0] *
> +						ALIGN(ctx->img_height, 16);
> +			ctx->chroma_size =3D  ctx->stride[0] *
> +						ALIGN(ctx->img_height / 2, 16);
> +			break;
> +		case V4L2_PIX_FMT_YUV420M:
> +		case V4L2_PIX_FMT_YVU420M:
> +			ctx->stride[0] =3D ALIGN(ctx->img_width,
> +						S5P_FIMV_NV12M_HALIGN_V6);
> +			ctx->stride[1] =3D ALIGN(ctx->img_width / 2,
> +						S5P_FIMV_NV12M_HALIGN_V6);
> +			ctx->stride[2] =3D ALIGN(ctx->img_width / 2,
> +						S5P_FIMV_NV12M_HALIGN_V6);
> +			ctx->luma_size =3D ctx->stride[0] *
> +						ALIGN(ctx->img_height, 16);
> +			ctx->chroma_size =3D  ctx->stride[1] *
> +						ALIGN(ctx->img_height / 2, 16);
> +			ctx->chroma_size_1 =3D  ctx->stride[2] *
> +						ALIGN(ctx->img_height / 2, 16);
> +			break;
> +		}
>  		ctx->luma_size +=3D MFC_LUMA_PAD_BYTES_V7;
> -		ctx->chroma_size +=3D MFC_CHROMA_PAD_BYTES_V7;
> +		ctx->chroma_size +=3D MFC_CHROMA_PAD_BYTES_V12;
> +		ctx->chroma_size_1 +=3D MFC_CHROMA_PAD_BYTES_V12;
> +	} else {
> +		ctx->buf_width =3D ALIGN(ctx->img_width,
> +					S5P_FIMV_NV12M_HALIGN_V6);
> +		ctx->stride[0] =3D ctx->buf_width;
> +		ctx->stride[1] =3D ctx->buf_width;
> +		ctx->luma_size =3D ALIGN((mb_width * mb_height) * 256, 256);
> +		ctx->chroma_size =3D ALIGN((mb_width * mb_height) * 128, 256);
> +		ctx->chroma_size_1 =3D 0;
> +		/* MFCv7 needs pad bytes for Luma and Chroma */
> +		if (IS_MFCV7_PLUS(ctx->dev)) {
> +			ctx->luma_size +=3D MFC_LUMA_PAD_BYTES_V7;
> +			ctx->chroma_size +=3D MFC_LUMA_PAD_BYTES_V7;
> +		}
>  	}
> +
>  }
> =20
>  /* Set registers for decoding stream buffer */
> @@ -588,15 +653,21 @@ static int s5p_mfc_set_dec_frame_buffer_v6(struct s=
5p_mfc_ctx *ctx)
>  	writel(ctx->total_dpb_count, mfc_regs->d_num_dpb);
>  	writel(ctx->luma_size, mfc_regs->d_first_plane_dpb_size);
>  	writel(ctx->chroma_size, mfc_regs->d_second_plane_dpb_size);
> -
> +	if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +			ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +		writel(ctx->chroma_size_1, mfc_regs->d_third_plane_dpb_size);
>  	writel(buf_addr1, mfc_regs->d_scratch_buffer_addr);
>  	writel(ctx->scratch_buf_size, mfc_regs->d_scratch_buffer_size);
> =20
>  	if (IS_MFCV8_PLUS(dev)) {
> -		writel(ctx->img_width,
> +		writel(ctx->stride[0],
>  			mfc_regs->d_first_plane_dpb_stride_size);
> -		writel(ctx->img_width,
> +		writel(ctx->stride[1],
>  			mfc_regs->d_second_plane_dpb_stride_size);
> +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +			writel(ctx->stride[2],
> +				mfc_regs->d_third_plane_dpb_stride_size);
>  	}
> =20
>  	buf_addr1 +=3D ctx->scratch_buf_size;
> @@ -625,6 +696,13 @@ static int s5p_mfc_set_dec_frame_buffer_v6(struct s5=
p_mfc_ctx *ctx)
>  					ctx->dst_bufs[i].cookie.raw.chroma);
>  		writel(ctx->dst_bufs[i].cookie.raw.chroma,
>  				mfc_regs->d_second_plane_dpb + i * 4);
> +		if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M) {
> +			mfc_debug(2, "\tChroma_1 %d: %zx\n", i,
> +					ctx->dst_bufs[i].cookie.raw.chroma_1);
> +			writel(ctx->dst_bufs[i].cookie.raw.chroma_1,
> +					mfc_regs->d_third_plane_dpb + i * 4);
> +		}
>  	}
>  	if (ctx->codec_mode =3D=3D S5P_MFC_CODEC_H264_DEC ||
>  			ctx->codec_mode =3D=3D S5P_MFC_CODEC_H264_MVC_DEC ||
> @@ -683,20 +761,24 @@ static int s5p_mfc_set_enc_stream_buffer_v6(struct =
s5p_mfc_ctx *ctx,
>  }
> =20
>  static void s5p_mfc_set_enc_frame_buffer_v6(struct s5p_mfc_ctx *ctx,
> -		unsigned long y_addr, unsigned long c_addr)
> +		unsigned long y_addr, unsigned long c_addr,
> +		unsigned long c_1_addr)
>  {
>  	struct s5p_mfc_dev *dev =3D ctx->dev;
>  	const struct s5p_mfc_regs *mfc_regs =3D dev->mfc_regs;
> =20
>  	writel(y_addr, mfc_regs->e_source_first_plane_addr);
>  	writel(c_addr, mfc_regs->e_source_second_plane_addr);
> +	writel(c_1_addr, mfc_regs->e_source_third_plane_addr);
> =20
>  	mfc_debug(2, "enc src y buf addr: 0x%08lx\n", y_addr);
>  	mfc_debug(2, "enc src c buf addr: 0x%08lx\n", c_addr);
> +	mfc_debug(2, "enc src cr buf addr: 0x%08lx\n", c_1_addr);
>  }
> =20
>  static void s5p_mfc_get_enc_frame_buffer_v6(struct s5p_mfc_ctx *ctx,
> -		unsigned long *y_addr, unsigned long *c_addr)
> +		unsigned long *y_addr, unsigned long *c_addr,
> +		unsigned long *c_1_addr)
>  {
>  	struct s5p_mfc_dev *dev =3D ctx->dev;
>  	const struct s5p_mfc_regs *mfc_regs =3D dev->mfc_regs;
> @@ -704,12 +786,17 @@ static void s5p_mfc_get_enc_frame_buffer_v6(struct =
s5p_mfc_ctx *ctx,
> =20
>  	*y_addr =3D readl(mfc_regs->e_encoded_source_first_plane_addr);
>  	*c_addr =3D readl(mfc_regs->e_encoded_source_second_plane_addr);
> +	if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +			ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +		*c_1_addr =3D readl(mfc_regs->e_encoded_source_third_plane_addr);
> +	else
> +		*c_1_addr =3D 0;
> =20
>  	enc_recon_y_addr =3D readl(mfc_regs->e_recon_luma_dpb_addr);
>  	enc_recon_c_addr =3D readl(mfc_regs->e_recon_chroma_dpb_addr);
> =20
>  	mfc_debug(2, "recon y addr: 0x%08lx y_addr: 0x%08lx\n", enc_recon_y_add=
r, *y_addr);
> -	mfc_debug(2, "recon c addr: 0x%08lx\n", enc_recon_c_addr);
> +	mfc_debug(2, "recon c addr: 0x%08lx c_addr: 0x%08lx\n", enc_recon_c_add=
r, *c_addr);
>  }
> =20
>  /* Set encoding ref & codec buffer */
> @@ -886,6 +973,20 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx=
 *ctx)
>  		writel(reg, mfc_regs->e_enc_options);
>  		/* 0: NV12(CbCr), 1: NV21(CrCb) */
>  		writel(0x0, mfc_regs->pixel_format);
> +	} else if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M) {
> +		/* 0: Linear, 1: 2D tiled*/
> +		reg =3D readl(mfc_regs->e_enc_options);
> +		reg &=3D ~(0x1 << 7);
> +		writel(reg, mfc_regs->e_enc_options);
> +		/* 2: YV12(CrCb), 3: I420(CrCb) */
> +		writel(0x2, mfc_regs->pixel_format);
> +	} else if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M) {
> +		/* 0: Linear, 1: 2D tiled*/
> +		reg =3D readl(mfc_regs->e_enc_options);
> +		reg &=3D ~(0x1 << 7);
> +		writel(reg, mfc_regs->e_enc_options);
> +		/* 2: YV12(CrCb), 3: I420(CrCb) */
> +		writel(0x3, mfc_regs->pixel_format);
>  	}
> =20
>  	/* memory structure recon. frame */
> @@ -1696,8 +1797,12 @@ static int s5p_mfc_init_decode_v6(struct s5p_mfc_c=
tx *ctx)
>  	else
>  		writel(reg, mfc_regs->d_dec_options);
> =20
> -	/* 0: NV12(CbCr), 1: NV21(CrCb) */
> -	if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_NV21M)
> +	/* 0: NV12(CbCr), 1: NV21(CrCb), 2: YV12(CrCb), 3: I420(CbCr) */
> +	if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M)
> +		writel(0x3, mfc_regs->pixel_format);
> +	else if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +		writel(0x2, mfc_regs->pixel_format);
> +	else if (ctx->dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_NV21M)
>  		writel(0x1, mfc_regs->pixel_format);
>  	else
>  		writel(0x0, mfc_regs->pixel_format);
> @@ -1781,8 +1886,12 @@ static int s5p_mfc_init_encode_v6(struct s5p_mfc_c=
tx *ctx)
> =20
>  	/* Set stride lengths for v7 & above */
>  	if (IS_MFCV7_PLUS(dev)) {
> -		writel(ctx->img_width, mfc_regs->e_source_first_plane_stride);
> -		writel(ctx->img_width, mfc_regs->e_source_second_plane_stride);
> +		writel(ctx->stride[0], mfc_regs->e_source_first_plane_stride);
> +		writel(ctx->stride[1], mfc_regs->e_source_second_plane_stride);
> +		if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +			writel(ctx->stride[2],
> +					mfc_regs->e_source_third_plane_stride);
>  	}
> =20
>  	writel(ctx->inst_no, mfc_regs->instance_id);
> @@ -1891,7 +2000,7 @@ static inline int s5p_mfc_run_enc_frame(struct s5p_=
mfc_ctx *ctx)
>  	struct s5p_mfc_dev *dev =3D ctx->dev;
>  	struct s5p_mfc_buf *dst_mb;
>  	struct s5p_mfc_buf *src_mb;
> -	unsigned long src_y_addr, src_c_addr, dst_addr;
> +	unsigned long src_y_addr, src_c_addr, src_c_1_addr, dst_addr;
>  	/*
>  	unsigned int src_y_size, src_c_size;
>  	*/
> @@ -1909,22 +2018,29 @@ static inline int s5p_mfc_run_enc_frame(struct s5=
p_mfc_ctx *ctx)
> =20
>  	if (list_empty(&ctx->src_queue)) {
>  		/* send null frame */
> -		s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0);
> +		s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0, 0);
>  		src_mb =3D NULL;
>  	} else {
>  		src_mb =3D list_entry(ctx->src_queue.next, struct s5p_mfc_buf, list);
>  		src_mb->flags |=3D MFC_BUF_FLAG_USED;
>  		if (src_mb->b->vb2_buf.planes[0].bytesused =3D=3D 0) {
> -			s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0);
> +			s5p_mfc_set_enc_frame_buffer_v6(ctx, 0, 0, 0);
>  			ctx->state =3D MFCINST_FINISHING;
>  		} else {
>  			src_y_addr =3D vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 0);
>  			src_c_addr =3D vb2_dma_contig_plane_dma_addr(&src_mb->b->vb2_buf, 1);
> +			if (ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YUV420M ||
> +				ctx->src_fmt->fourcc =3D=3D V4L2_PIX_FMT_YVU420M)
> +				src_c_1_addr =3D vb2_dma_contig_plane_dma_addr
> +						(&src_mb->b->vb2_buf, 2);
> +			else
> +				src_c_1_addr =3D 0;
> =20
>  			mfc_debug(2, "enc src y addr: 0x%08lx\n", src_y_addr);
>  			mfc_debug(2, "enc src c addr: 0x%08lx\n", src_c_addr);
> =20
> -			s5p_mfc_set_enc_frame_buffer_v6(ctx, src_y_addr, src_c_addr);
> +			s5p_mfc_set_enc_frame_buffer_v6(ctx, src_y_addr,
> +						src_c_addr, src_c_1_addr);
>  			if (src_mb->flags & MFC_BUF_FLAG_EOS)
>  				ctx->state =3D MFCINST_FINISHING;
>  		}
> @@ -2450,6 +2566,8 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plu=
s(struct s5p_mfc_dev *dev)
>  			S5P_FIMV_E_ENCODED_SOURCE_FIRST_ADDR_V7);
>  	R(e_encoded_source_second_plane_addr,
>  			S5P_FIMV_E_ENCODED_SOURCE_SECOND_ADDR_V7);
> +	R(e_encoded_source_third_plane_addr,
> +			S5P_FIMV_E_ENCODED_SOURCE_THIRD_ADDR_V7);
>  	R(e_vp8_options, S5P_FIMV_E_VP8_OPTIONS_V7);
> =20
>  	if (!IS_MFCV8_PLUS(dev))
> @@ -2464,16 +2582,20 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_p=
lus(struct s5p_mfc_dev *dev)
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

