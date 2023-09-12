Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6719E79D485
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjILPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjILPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:13:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1D0115;
        Tue, 12 Sep 2023 08:13:24 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1EB30660731E;
        Tue, 12 Sep 2023 16:13:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694531602;
        bh=MC7lk4l2OzqSdTlMPVDGxUjfcIzaxsBg/cw3NPmOq50=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UzHG1Pr5oHEQR3arplnRgNVEptjBpJFXBnSFuK6IZB9LgBB+JSjPtPwLlpUe5/AvP
         hX+NTXY+ZY2UEc8IhvvjpY8A4HH9H/RWUV8jFNCBakGoa2VH/3iMSzUIBbmudDPgLs
         NperssmTfXPdsHUmPpW7Cr2eRQ6lMdEvAftZmn9xtNT+slfIE62N9r4s10pArXnSuH
         SutjqjPWW+zuG2nxq52BEaQw6egolwmnCsQhlx8GaUNlAKuahhAXKiRGdYO6BAbKP6
         AyHatWpLkbQvVFhcWfwC5QpusucEsA15FUFQWpbnj9RYWSnNJYZY/7Ncvin8pNLlY1
         mknZKWrEtaa6g==
Message-ID: <e6235c2de5288c695920a9c1d402e494ca0928a1.camel@collabora.com>
Subject: Re: [PATCH 08/14] media: medkatek: vcodec: support one plane
 capture buffer
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Yunfei Dong =?UTF-8?Q?=28=E8=91=A3=E4=BA=91=E9=A3=9E=29?= 
        <Yunfei.Dong@mediatek.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 12 Sep 2023 11:13:12 -0400
In-Reply-To: <33daf18157fe1c0b5b2a023a9fb65128915091d1.camel@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-9-yunfei.dong@mediatek.com>
         <4ff89457cbcc0582d312c8af919dab7a16b1943b.camel@collabora.com>
         <33daf18157fe1c0b5b2a023a9fb65128915091d1.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 12 septembre 2023 =C3=A0 02:08 +0000, Yunfei Dong (=E8=91=A3=E4=BA=
=91=E9=A3=9E) a =C3=A9crit=C2=A0:
> Hi Nicolas,
>=20
> Thanks for your advice.
> On Mon, 2023-09-11 at 11:44 -0400, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le lundi 11 septembre 2023 =C3=A0 20:59 +0800, Yunfei Dong a =C3=A9crit=
 :
> > > The capture buffer has two planes for format MM21, but user space
> > > only
> > > allocate secure memory for plane[0], and the size is Y data + uv
> > > data.
> > > The driver need to support one plane decoder for svp mode.
> >=20
> > I'm sorry, but in current V4L2 status, you must introduce a new
> > format. Assuming
> > the second M means MPLANE, this format would be MT21 (though you
> > already used
> > that fourcc for MT21C) ?
> >=20
>=20
> Just using the first plane for format MM21 in order to support svp mode
> according google's suggestion. The plane[1] won't be used to allocate
> memory. Whether it's better to add one format to support one plane? Not
> using MM21.

Userspace will be confused and will need to have special casing for this
platform if you do that. MM21 has been defined as 2 planes, 2 allocations, =
you
cannot use it for 1 plane/allocation.

Nicolas

>=20
> Best Regards,
> Yunfei Dong
> > Nicolas
> >=20
> > >=20
> > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > > ---
> > >  .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 24 ++++++++++++---
> > > ----
> > >  .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 13 ++++++----
> > >  .../decoder/vdec/vdec_h264_req_common.c       | 16 +++++++------
> > >  .../mediatek/vcodec/decoder/vdec_drv_if.c     |  4 ++--
> > >  4 files changed, 34 insertions(+), 23 deletions(-)
> > >=20
> > > diff --git
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> > > index 91ed576d6821..457c3e2979c9 100644
> > > ---
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> > > +++
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> > > @@ -541,14 +541,15 @@ static int vidioc_vdec_s_fmt(struct file
> > > *file, void *priv,
> > >  			ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] =3D
> > >  				ctx->picinfo.buf_w;
> > >  		} else {
> > > -			ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] =3D
> > > -				ctx->picinfo.fb_sz[0];
> > > -			ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] =3D
> > > -				ctx->picinfo.buf_w;
> > > -			ctx->q_data[MTK_Q_DATA_DST].sizeimage[1] =3D
> > > -				ctx->picinfo.fb_sz[1];
> > > -			ctx->q_data[MTK_Q_DATA_DST].bytesperline[1] =3D
> > > -				ctx->picinfo.buf_w;
> > > +			if (ctx->is_svp_mode)
> > > +				ctx-
> > > > q_data[MTK_Q_DATA_DST].sizeimage[0] =3D
> > > +					ctx->picinfo.fb_sz[0] + ctx-
> > > > picinfo.fb_sz[1];
> > > +			else
> > > +				ctx-
> > > > q_data[MTK_Q_DATA_DST].sizeimage[0] =3D ctx->picinfo.fb_sz[0];
> > > +
> > > +			ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] =3D
> > > ctx->picinfo.buf_w;
> > > +			ctx->q_data[MTK_Q_DATA_DST].sizeimage[1] =3D ctx-
> > > > picinfo.fb_sz[1];
> > > +			ctx->q_data[MTK_Q_DATA_DST].bytesperline[1] =3D
> > > ctx->picinfo.buf_w;
> > >  		}
> > > =20
> > >  		ctx->q_data[MTK_Q_DATA_DST].coded_width =3D ctx-
> > > > picinfo.buf_w;
> > > @@ -673,7 +674,12 @@ static int vidioc_vdec_g_fmt(struct file
> > > *file, void *priv,
> > >  		 * So we just return picinfo yet, and update picinfo in
> > >  		 * stop_streaming hook function
> > >  		 */
> > > -		q_data->sizeimage[0] =3D ctx->picinfo.fb_sz[0];
> > > +
> > > +		if (ctx->is_svp_mode)
> > > +			q_data->sizeimage[0] =3D ctx->picinfo.fb_sz[0] +
> > > ctx->picinfo.fb_sz[1];
> > > +		else
> > > +			q_data->sizeimage[0] =3D ctx->picinfo.fb_sz[0];
> > > +
> > >  		q_data->sizeimage[1] =3D ctx->picinfo.fb_sz[1];
> > >  		q_data->bytesperline[0] =3D ctx-
> > > > last_decoded_picinfo.buf_w;
> > >  		q_data->bytesperline[1] =3D ctx-
> > > > last_decoded_picinfo.buf_w;
> > > diff --git
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > index e29c9c58f3da..2ea517883a86 100644
> > > ---
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > +++
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > @@ -256,11 +256,12 @@ static struct vdec_fb
> > > *vdec_get_cap_buffer(struct mtk_vcodec_dec_ctx *ctx)
> > >  	framebuf =3D container_of(vb2_v4l2, struct mtk_video_dec_buf,
> > > m2m_buf.vb);
> > > =20
> > >  	pfb =3D &framebuf->frame_buffer;
> > > -	pfb->base_y.va =3D vb2_plane_vaddr(dst_buf, 0);
> > > +	if (!ctx->is_svp_mode)
> > > +		pfb->base_y.va =3D vb2_plane_vaddr(dst_buf, 0);
> > >  	pfb->base_y.dma_addr =3D vb2_dma_contig_plane_dma_addr(dst_buf,
> > > 0);
> > >  	pfb->base_y.size =3D ctx->q_data[MTK_Q_DATA_DST].sizeimage[0];
> > > =20
> > > -	if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes =3D=3D 2) {
> > > +	if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes =3D=3D 2 && !ctx-
> > > > is_svp_mode) {
> > >  		pfb->base_c.va =3D vb2_plane_vaddr(dst_buf, 1);
> > >  		pfb->base_c.dma_addr =3D
> > >  			vb2_dma_contig_plane_dma_addr(dst_buf, 1);
> > > @@ -310,16 +311,18 @@ static void mtk_vdec_worker(struct
> > > work_struct *work)
> > >  	mtk_v4l2_vdec_dbg(3, ctx, "[%d] (%d) id=3D%d, vb=3D%p", ctx->id,
> > >  			  vb2_src->vb2_queue->type, vb2_src->index,
> > > vb2_src);
> > > =20
> > > -	bs_src->va =3D vb2_plane_vaddr(vb2_src, 0);
> > > -	bs_src->dma_addr =3D vb2_dma_contig_plane_dma_addr(vb2_src, 0);
> > > -	bs_src->size =3D (size_t)vb2_src->planes[0].bytesused;
> > > +	if (!ctx->is_svp_mode) {
> > > +		bs_src->va =3D vb2_plane_vaddr(vb2_src, 0);
> > >  	if (!bs_src->va) {
> > >  		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
> > >  		mtk_v4l2_vdec_err(ctx, "[%d] id=3D%d source buffer is
> > > NULL", ctx->id,
> > >  				  vb2_src->index);
> > >  		return;
> > > +		}
> > >  	}
> > > =20
> > > +	bs_src->dma_addr =3D vb2_dma_contig_plane_dma_addr(vb2_src, 0);
> > > +	bs_src->size =3D (size_t)vb2_src->planes[0].bytesused;
> > >  	mtk_v4l2_vdec_dbg(3, ctx, "[%d] Bitstream VA=3D%p DMA=3D%pad
> > > Size=3D%zx vb=3D%p",
> > >  			  ctx->id, bs_src->va, &bs_src->dma_addr,
> > > bs_src->size, vb2_src);
> > >  	/* Apply request controls. */
> > > diff --git
> > > a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req
> > > _common.c
> > > b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req
> > > _common.c
> > > index 5ca20d75dc8e..838f0eeea6e2 100644
> > > ---
> > > a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req
> > > _common.c
> > > +++
> > > b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req
> > > _common.c
> > > @@ -81,13 +81,15 @@ void mtk_vdec_h264_fill_dpb_info(struct
> > > mtk_vcodec_dec_ctx *ctx,
> > > =20
> > >  		h264_dpb_info[index].y_dma_addr =3D
> > >  			vb2_dma_contig_plane_dma_addr(vb, 0);
> > > -		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes =3D=3D 2)
> > > -			h264_dpb_info[index].c_dma_addr =3D
> > > -				vb2_dma_contig_plane_dma_addr(vb, 1);
> > > -		else
> > > -			h264_dpb_info[index].c_dma_addr =3D
> > > -				h264_dpb_info[index].y_dma_addr +
> > > -				ctx->picinfo.fb_sz[0];
> > > +		if (!ctx->is_svp_mode) {
> > > +			if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes=20
> > > =3D=3D 2)
> > > +				h264_dpb_info[index].c_dma_addr =3D
> > > +					vb2_dma_contig_plane_dma_addr(v
> > > b, 1);
> > > +			else
> > > +				h264_dpb_info[index].c_dma_addr =3D
> > > +					h264_dpb_info[index].y_dma_addr
> > > +
> > > +					ctx->picinfo.fb_sz[0];
> > > +		}
> > >  	}
> > >  }
> > > =20
> > > diff --git
> > > a/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> > > b/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> > > index d0b459b1603f..c7d33e540a13 100644
> > > --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> > > +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
> > > @@ -73,14 +73,14 @@ int vdec_if_decode(struct mtk_vcodec_dec_ctx
> > > *ctx, struct mtk_vcodec_mem *bs,
> > >  {
> > >  	int ret =3D 0;
> > > =20
> > > -	if (bs) {
> > > +	if (bs && !ctx->is_svp_mode) {
> > >  		if ((bs->dma_addr & 63) !=3D 0) {
> > >  			mtk_v4l2_vdec_err(ctx, "bs dma_addr should 64
> > > byte align");
> > >  			return -EINVAL;
> > >  		}
> > >  	}
> > > =20
> > > -	if (fb) {
> > > +	if (fb && !ctx->is_svp_mode) {
> > >  		if (((fb->base_y.dma_addr & 511) !=3D 0) ||
> > >  		    ((fb->base_c.dma_addr & 511) !=3D 0)) {
> > >  			mtk_v4l2_vdec_err(ctx, "frame buffer dma_addr
> > > should 512 byte align");
> >=20
> >=20

