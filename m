Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E718279BA34
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355587AbjIKWBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242511AbjIKPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:44:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61346FB;
        Mon, 11 Sep 2023 08:44:50 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 662AA660730D;
        Mon, 11 Sep 2023 16:44:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694447089;
        bh=Y54cO3Keiy0/M19Pg2PI3OmwZpoo7rXctVpgGOi2oTE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c2raOA8o0CsQSjmro9YZXyZsNqpRy95YSTcN91QCUPZnyprbFEAF8LJ6lfk8KFL+U
         3ISTu7F3OMY7IxYKmkbKCm6cBqOC5ClYwI6rn5HP2QnH6JddjGjsDgh4ktHWX/5J1A
         LmHYlrLEB95RdJ7j8KMjKHZFVpO8sjucF5HuQylPJM9fXcE7mvvZ/bdH//LXAA0vXX
         sbyiBVaDh84F4mWUFIoPgpCASZrElMc3d1enm8kfle6m38yzHUhojyvOOKMvya7/Se
         hf/gvQRBC5pyxXYoZDran6530ebt5M4ET3eYvjDpPXxSUnbeIfbyMmogJmIKptUJpw
         rDS0JwhU4uDeg==
Message-ID: <4ff89457cbcc0582d312c8af919dab7a16b1943b.camel@collabora.com>
Subject: Re: [PATCH 08/14] media: medkatek: vcodec: support one plane
 capture buffer
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?ISO-8859-1?Q?N=EDcolas?= "F . R . A . Prado" 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Mon, 11 Sep 2023 11:44:37 -0400
In-Reply-To: <20230911125936.10648-9-yunfei.dong@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-9-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lundi 11 septembre 2023 =C3=A0 20:59 +0800, Yunfei Dong a =C3=A9crit=C2=
=A0:
> The capture buffer has two planes for format MM21, but user space only
> allocate secure memory for plane[0], and the size is Y data + uv data.
> The driver need to support one plane decoder for svp mode.

I'm sorry, but in current V4L2 status, you must introduce a new format. Ass=
uming
the second M means MPLANE, this format would be MT21 (though you already us=
ed
that fourcc for MT21C) ?

Nicolas

>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 24 ++++++++++++-------
>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 13 ++++++----
>  .../decoder/vdec/vdec_h264_req_common.c       | 16 +++++++------
>  .../mediatek/vcodec/decoder/vdec_drv_if.c     |  4 ++--
>  4 files changed, 34 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> index 91ed576d6821..457c3e2979c9 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> @@ -541,14 +541,15 @@ static int vidioc_vdec_s_fmt(struct file *file, voi=
d *priv,
>  			ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] =3D
>  				ctx->picinfo.buf_w;
>  		} else {
> -			ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] =3D
> -				ctx->picinfo.fb_sz[0];
> -			ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] =3D
> -				ctx->picinfo.buf_w;
> -			ctx->q_data[MTK_Q_DATA_DST].sizeimage[1] =3D
> -				ctx->picinfo.fb_sz[1];
> -			ctx->q_data[MTK_Q_DATA_DST].bytesperline[1] =3D
> -				ctx->picinfo.buf_w;
> +			if (ctx->is_svp_mode)
> +				ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] =3D
> +					ctx->picinfo.fb_sz[0] + ctx->picinfo.fb_sz[1];
> +			else
> +				ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] =3D ctx->picinfo.fb_sz[0];
> +
> +			ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] =3D ctx->picinfo.buf_w;
> +			ctx->q_data[MTK_Q_DATA_DST].sizeimage[1] =3D ctx->picinfo.fb_sz[1];
> +			ctx->q_data[MTK_Q_DATA_DST].bytesperline[1] =3D ctx->picinfo.buf_w;
>  		}
> =20
>  		ctx->q_data[MTK_Q_DATA_DST].coded_width =3D ctx->picinfo.buf_w;
> @@ -673,7 +674,12 @@ static int vidioc_vdec_g_fmt(struct file *file, void=
 *priv,
>  		 * So we just return picinfo yet, and update picinfo in
>  		 * stop_streaming hook function
>  		 */
> -		q_data->sizeimage[0] =3D ctx->picinfo.fb_sz[0];
> +
> +		if (ctx->is_svp_mode)
> +			q_data->sizeimage[0] =3D ctx->picinfo.fb_sz[0] + ctx->picinfo.fb_sz[1=
];
> +		else
> +			q_data->sizeimage[0] =3D ctx->picinfo.fb_sz[0];
> +
>  		q_data->sizeimage[1] =3D ctx->picinfo.fb_sz[1];
>  		q_data->bytesperline[0] =3D ctx->last_decoded_picinfo.buf_w;
>  		q_data->bytesperline[1] =3D ctx->last_decoded_picinfo.buf_w;
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_d=
ec_stateless.c
> index e29c9c58f3da..2ea517883a86 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> @@ -256,11 +256,12 @@ static struct vdec_fb *vdec_get_cap_buffer(struct m=
tk_vcodec_dec_ctx *ctx)
>  	framebuf =3D container_of(vb2_v4l2, struct mtk_video_dec_buf, m2m_buf.v=
b);
> =20
>  	pfb =3D &framebuf->frame_buffer;
> -	pfb->base_y.va =3D vb2_plane_vaddr(dst_buf, 0);
> +	if (!ctx->is_svp_mode)
> +		pfb->base_y.va =3D vb2_plane_vaddr(dst_buf, 0);
>  	pfb->base_y.dma_addr =3D vb2_dma_contig_plane_dma_addr(dst_buf, 0);
>  	pfb->base_y.size =3D ctx->q_data[MTK_Q_DATA_DST].sizeimage[0];
> =20
> -	if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes =3D=3D 2) {
> +	if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes =3D=3D 2 && !ctx->is_sv=
p_mode) {
>  		pfb->base_c.va =3D vb2_plane_vaddr(dst_buf, 1);
>  		pfb->base_c.dma_addr =3D
>  			vb2_dma_contig_plane_dma_addr(dst_buf, 1);
> @@ -310,16 +311,18 @@ static void mtk_vdec_worker(struct work_struct *wor=
k)
>  	mtk_v4l2_vdec_dbg(3, ctx, "[%d] (%d) id=3D%d, vb=3D%p", ctx->id,
>  			  vb2_src->vb2_queue->type, vb2_src->index, vb2_src);
> =20
> -	bs_src->va =3D vb2_plane_vaddr(vb2_src, 0);
> -	bs_src->dma_addr =3D vb2_dma_contig_plane_dma_addr(vb2_src, 0);
> -	bs_src->size =3D (size_t)vb2_src->planes[0].bytesused;
> +	if (!ctx->is_svp_mode) {
> +		bs_src->va =3D vb2_plane_vaddr(vb2_src, 0);
>  	if (!bs_src->va) {
>  		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
>  		mtk_v4l2_vdec_err(ctx, "[%d] id=3D%d source buffer is NULL", ctx->id,
>  				  vb2_src->index);
>  		return;
> +		}
>  	}
> =20
> +	bs_src->dma_addr =3D vb2_dma_contig_plane_dma_addr(vb2_src, 0);
> +	bs_src->size =3D (size_t)vb2_src->planes[0].bytesused;
>  	mtk_v4l2_vdec_dbg(3, ctx, "[%d] Bitstream VA=3D%p DMA=3D%pad Size=3D%zx=
 vb=3D%p",
>  			  ctx->id, bs_src->va, &bs_src->dma_addr, bs_src->size, vb2_src);
>  	/* Apply request controls. */
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h26=
4_req_common.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h=
264_req_common.c
> index 5ca20d75dc8e..838f0eeea6e2 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_c=
ommon.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_c=
ommon.c
> @@ -81,13 +81,15 @@ void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_de=
c_ctx *ctx,
> =20
>  		h264_dpb_info[index].y_dma_addr =3D
>  			vb2_dma_contig_plane_dma_addr(vb, 0);
> -		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes =3D=3D 2)
> -			h264_dpb_info[index].c_dma_addr =3D
> -				vb2_dma_contig_plane_dma_addr(vb, 1);
> -		else
> -			h264_dpb_info[index].c_dma_addr =3D
> -				h264_dpb_info[index].y_dma_addr +
> -				ctx->picinfo.fb_sz[0];
> +		if (!ctx->is_svp_mode) {
> +			if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes =3D=3D 2)
> +				h264_dpb_info[index].c_dma_addr =3D
> +					vb2_dma_contig_plane_dma_addr(vb, 1);
> +			else
> +				h264_dpb_info[index].c_dma_addr =3D
> +					h264_dpb_info[index].y_dma_addr +
> +					ctx->picinfo.fb_sz[0];
> +		}
>  	}
>  }
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c=
 b/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> index d0b459b1603f..c7d33e540a13 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> @@ -73,14 +73,14 @@ int vdec_if_decode(struct mtk_vcodec_dec_ctx *ctx, st=
ruct mtk_vcodec_mem *bs,
>  {
>  	int ret =3D 0;
> =20
> -	if (bs) {
> +	if (bs && !ctx->is_svp_mode) {
>  		if ((bs->dma_addr & 63) !=3D 0) {
>  			mtk_v4l2_vdec_err(ctx, "bs dma_addr should 64 byte align");
>  			return -EINVAL;
>  		}
>  	}
> =20
> -	if (fb) {
> +	if (fb && !ctx->is_svp_mode) {
>  		if (((fb->base_y.dma_addr & 511) !=3D 0) ||
>  		    ((fb->base_c.dma_addr & 511) !=3D 0)) {
>  			mtk_v4l2_vdec_err(ctx, "frame buffer dma_addr should 512 byte align")=
;

