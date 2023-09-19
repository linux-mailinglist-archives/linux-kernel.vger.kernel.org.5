Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DCA7A6F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjISXD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjISXDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7E1C5;
        Tue, 19 Sep 2023 16:03:44 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B490660309E;
        Wed, 20 Sep 2023 00:03:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695164622;
        bh=Xxy97lFlX/7Dd1li7uFsrn53XyhyXn4n+AjBMkTwkQI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ijBUCpt75neuOwpoHLDBudInKS3zi9vHPLbIrdWZVzcnXK/OoPwOfuJvGbCu+99tI
         JUkAz3e+IHYEpU2fF22p57+wwUtE6jEwQ5zSGel2S/7P483sK/JcAsXI6UsxVMWg7u
         7LVnCLCve3NYRJm4wbnCLByJP52+C/jwDeHxOuxdFY1O6L/WZmlrBwn2EJ9pp85iy9
         ESMzOC7IAE6b6o2d/8xqinuDNcwqhEpLK9lSwN8n1N2mOAgx6gLtQA4TiN+A333wBl
         SIt90E5URXXw0zF3101nZo8bYq0GzhWr1gs2FsPDIJ+HlRo6ffN4INv0yVSZYq6mxr
         0tjQjvbZmpP6w==
Message-ID: <1d19be1f21d579b529231882d761554d758db5b4.camel@collabora.com>
Subject: Re: [PATCH 11/14] media: medkatek: vcodec: covert secure fd to
 secure handle
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jeffrey Kardatzke <jkardatzke@google.com>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?ISO-8859-1?Q?N=EDcolas?= "F . R . A . Prado" 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Tue, 19 Sep 2023 19:03:31 -0400
In-Reply-To: <CA+ddPcOFksu6JzXZf0QOFeRDAyX=m0k+t8zwg2DbVmAkweobyg@mail.gmail.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-12-yunfei.dong@mediatek.com>
         <d02953725e7ae17e75bff235acfd30327d0fe9ac.camel@collabora.com>
         <CA+ddPcOFksu6JzXZf0QOFeRDAyX=m0k+t8zwg2DbVmAkweobyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 19 septembre 2023 =C3=A0 15:38 -0700, Jeffrey Kardatzke a =C3=A9cr=
it=C2=A0:
> On Tue, Sep 19, 2023 at 12:43=E2=80=AFPM Nicolas Dufresne
> <nicolas.dufresne@collabora.com> wrote:
> >=20
> > Le lundi 11 septembre 2023 =C3=A0 20:59 +0800, Yunfei Dong a =C3=A9crit=
 :
> > > User driver will fill or parse data in optee-os with secure handle,
> > > need to covert secure fd to secure handle in kernel.
> > >=20
> > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > > ---
> > >  .../vcodec/decoder/mtk_vcodec_dec_drv.c       |  1 +
> > >  .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 54 +++++++++++++++++=
+-
> > >  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  5 ++
> > >  include/uapi/linux/v4l2-controls.h            |  4 ++
> > >  4 files changed, 62 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcode=
c_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec=
_drv.c
> > > index 0a89ce452ac3..64e006820f43 100644
> > > --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_d=
rv.c
> > > +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_d=
rv.c
> > > @@ -571,3 +571,4 @@ module_platform_driver(mtk_vcodec_dec_driver);
> > >=20
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_DESCRIPTION("Mediatek video codec V4L2 decoder driver");
> > > +MODULE_IMPORT_NS(DMA_BUF);
> > > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcode=
c_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcod=
ec_dec_stateless.c
> > > index 2ea517883a86..d2b09ce9f1cf 100644
> > > --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tateless.c
> > > +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tateless.c
> > > @@ -426,6 +426,46 @@ static int mtk_vcodec_get_pic_info(struct mtk_vc=
odec_dec_ctx *ctx)
> > >       return ret;
> > >  }
> > >=20
> > > +static int mtk_dma_contig_get_secure_handle(struct mtk_vcodec_dec_ct=
x *ctx, int fd)
> > > +{
> > > +     int secure_handle =3D 0;
> > > +     struct dma_buf *buf;
> > > +     struct dma_buf_attachment *dba;
> > > +     struct sg_table *sgt;
> > > +     struct device *dev =3D &ctx->dev->plat_dev->dev;
> > > +
> > > +     buf =3D dma_buf_get(fd);
> > > +     if (IS_ERR(buf)) {
> > > +             mtk_v4l2_vdec_err(ctx, "dma_buf_get fail fd:%d", fd);
> > > +             return 0;
> > > +     }
> > > +
> > > +     dba =3D dma_buf_attach(buf, dev);
> > > +     if (IS_ERR(dba)) {
> > > +             mtk_v4l2_vdec_err(ctx, "dma_buf_attach fail fd:%d", fd)=
;
> > > +             goto err_attach;
> > > +     }
> > > +
> > > +     sgt =3D dma_buf_map_attachment(dba, DMA_BIDIRECTIONAL);
> > > +     if (IS_ERR(sgt)) {
> > > +             mtk_v4l2_vdec_err(ctx, "dma_buf_map_attachment fail fd:=
%d", fd);
> > > +             goto err_map;
> > > +     }
> > > +     secure_handle =3D sg_dma_address(sgt->sgl);
> >=20
> > Does it mean if your secure dmabuf is passed to a driver that didn't kn=
ow it was
> > secure it will pick the handle as a memory address and program the HW w=
ith it ?
> > That seems unsafe, the handle should be stored in a dedicated place and=
 mapping
> > should either fail, or provide a dummy buffer.
>=20
> Since the secure dmabufs don't support any mmap/cpu access to them and
> return -EPERM in those cases; wouldn't that prevent misuse of them in
> other places? (so the mmap operation and CPU access will fail, but
> getting the SG list from the dmabuf succeeds)

My impression is that if userspace can pass this FD to a driver without tel=
ling
the driver it is secure memory, the driver may potentially crash trying to =
use
the handle as an memory address.

In my opinion, sg_dma_address() should return addresses, like its name stat=
e. If
you want to get something else, you should find another way to obtain it.

Nicolas

>=20
> >=20
> > > +
> > > +     dma_buf_unmap_attachment(dba, sgt, DMA_BIDIRECTIONAL);
> > > +     dma_buf_detach(buf, dba);
> > > +     dma_buf_put(buf);
> > > +
> > > +     return secure_handle;
> > > +err_map:
> > > +     dma_buf_detach(buf, dba);
> > > +err_attach:
> > > +     dma_buf_put(buf);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl)
> > >  {
> > >       struct mtk_vcodec_dec_ctx *ctx =3D ctrl_to_dec_ctx(ctrl);
> > > @@ -436,7 +476,7 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl=
)
> > >       struct v4l2_ctrl *hdr_ctrl;
> > >       const struct mtk_vcodec_dec_pdata *dec_pdata =3D ctx->dev->vdec=
_pdata;
> > >       const struct mtk_video_fmt *fmt;
> > > -     int i =3D 0, ret =3D 0;
> > > +     int i =3D 0, ret =3D 0, sec_fd;
> > >=20
> > >       hdr_ctrl =3D ctrl;
> > >       if (!hdr_ctrl || !hdr_ctrl->p_new.p)
> > > @@ -489,6 +529,12 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctr=
l)
> > >                       return -EINVAL;
> > >               }
> > >               break;
> > > +     case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:
> > > +             sec_fd =3D ctrl->val;
> > > +
> > > +             ctrl->val =3D mtk_dma_contig_get_secure_handle(ctx, ctr=
l->val);
> > > +             mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d =3D> 0=
x%x", sec_fd, ctrl->val);
> > > +             break;
> > >       default:
> > >               mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id=
: 0x%x\n", hdr_ctrl->id);
> > >               return ret;
> > > @@ -525,8 +571,9 @@ static const struct v4l2_ctrl_ops mtk_vcodec_dec_=
ctrl_ops =3D {
> > >  static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx=
)
> > >  {
> > >       unsigned int i;
> > > +     struct v4l2_ctrl *ctrl;
> > >=20
> > > -     v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS);
> > > +     v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
> > >       if (ctx->ctrl_hdl.error) {
> > >               mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init failed\n=
");
> > >               return ctx->ctrl_hdl.error;
> > > @@ -543,6 +590,9 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_=
vcodec_dec_ctx *ctx)
> > >               }
> > >       }
> > >=20
> > > +     ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl, &mtk_vcodec_dec_ctrl=
_ops,
> > > +                              V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, 0=
, 65535, 1, 0);
> > > +
> > >       v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
> > >=20
> > >       return 0;
> > > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/medi=
a/v4l2-core/v4l2-ctrls-defs.c
> > > index 8696eb1cdd61..d8cf01f76aab 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > @@ -1041,6 +1041,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> > >       case V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD:     return =
"HEVC Size of Length Field";
> > >       case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:        return =
"Reference Frames for a P-Frame";
> > >       case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:         return =
"Prepend SPS and PPS to IDR";
> > > +     case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:               return =
"MediaTek Decoder get secure handle";
> > >=20
> > >       /* AV1 controls */
> > >       case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:                   return =
"AV1 Profile";
> > > @@ -1437,6 +1438,10 @@ void v4l2_ctrl_fill(u32 id, const char **name,=
 enum v4l2_ctrl_type *type,
> > >       case V4L2_CID_MPEG_VIDEO_VPX_NUM_REF_FRAMES:
> > >               *type =3D V4L2_CTRL_TYPE_INTEGER_MENU;
> > >               break;
> > > +     case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:
> > > +             *type =3D V4L2_CTRL_TYPE_INTEGER;
> > > +             *flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> > > +             break;
> > >       case V4L2_CID_USER_CLASS:
> > >       case V4L2_CID_CAMERA_CLASS:
> > >       case V4L2_CID_CODEC_CLASS:
> > > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/=
v4l2-controls.h
> > > index c3604a0a3e30..7b3694985366 100644
> > > --- a/include/uapi/linux/v4l2-controls.h
> > > +++ b/include/uapi/linux/v4l2-controls.h
> > > @@ -954,6 +954,10 @@ enum v4l2_mpeg_mfc51_video_force_frame_type {
> > >  #define V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_STATIC           =
 (V4L2_CID_CODEC_MFC51_BASE+53)
> > >  #define V4L2_CID_MPEG_MFC51_VIDEO_H264_NUM_REF_PIC_FOR_P            =
 (V4L2_CID_CODEC_MFC51_BASE+54)
> > >=20
> > > +/*  MPEG-class control IDs specific to the MediaTek Decoder driver a=
s defined by V4L2 */
> > > +#define V4L2_CID_MPEG_MTK_BASE                       (V4L2_CTRL_CLAS=
S_CODEC | 0x2000)
> > > +#define V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE  (V4L2_CID_MPEG_MTK_BASE=
+8)
> > > +
> > >  /*  Camera class control IDs */
> > >=20
> > >  #define V4L2_CID_CAMERA_CLASS_BASE   (V4L2_CTRL_CLASS_CAMERA | 0x900=
)
> >=20

