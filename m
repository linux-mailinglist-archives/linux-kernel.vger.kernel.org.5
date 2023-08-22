Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8A784ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjHVTpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjHVTpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:45:35 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7640CD0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:45:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-410a2925972so9199101cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1692733532; x=1693338332;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+j7gUQKGV+hHJ4UF2S6YK4i8VVIsFV3XWKH/WDCxjc=;
        b=1CUWXwJK/jYi+znojaMO6HycbxnIkk3WXml9qykr03Qf0tB94unmPtW1LqH8vNluh4
         4n9k1ZjdCKhmdkUdfb85IrZ2kU/atofVKievDSaLIZv3vYd0I8EXZh/XYhX438Mv80Qk
         9XZq/HMD6nHRrRwh0EjmZUWpSKevioZD44AL0RjKZpEV7n8SqQaVkbRRi6YcsmelIXsz
         u+HtAb00cuazZrzHLrquoosunHGifcKOfufloqDG9Dq/n79iVIfykaYaFXBjl8bfuyqC
         o+kv7oePlLudVak3gh6hCRpPg58PA/Ek2IoHoFH9QS6RnaMdr7EV4h1XTfAFmrr3CC58
         rf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733532; x=1693338332;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+j7gUQKGV+hHJ4UF2S6YK4i8VVIsFV3XWKH/WDCxjc=;
        b=GukC7xhq3dmKq91t4LWUKlB4TViV3wdqy46VdGtmFDZQrI2wqsDlmiKaAehGuqDfI3
         nEdYrTne0C0/8H1Afjp7JJUdVts5yDodADZpZ9FdVrg97hFEeX+Ophj/j2AmorBosbeb
         QCQoJRwzicPMVXhr/nImOvOTTYvx8dRoxtuB6kp29Mxsi+5smd0+r2ZD+yvbVz6SRYg1
         N0ZQeDhPSiDna2E0jZgbk1buv5yTo5+tp2SqJsVYqWXVDKYW9PPv/zX4NABSLR6LlE33
         NFrsVADmbRFOKVEQZYyXgVOOvKPm4sTy0vncdA+SKh0wd7+5OIxHDpkdqBKr16o/Gecr
         NDfA==
X-Gm-Message-State: AOJu0YxVp5yXB3O7WQ4XEcW8fIK+ghHmGWlpj/pRSLrf2tcYj6xbg+HP
        GykzVzjW1VWmvSiu/98vAR5m3g==
X-Google-Smtp-Source: AGHT+IGStuy5LxC9MNAN11rPMlYtX5+YYIsDcyAzmNaIbzHDZlgPoUbtbqENXbZqukanYEgL4eQt+Q==
X-Received: by 2002:ac8:5c0c:0:b0:403:66f7:ae66 with SMTP id i12-20020ac85c0c000000b0040366f7ae66mr13185028qti.13.1692733531802;
        Tue, 22 Aug 2023 12:45:31 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id h20-20020a05622a171400b00410957eaf3csm1749719qtk.21.2023.08.22.12.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:45:31 -0700 (PDT)
Message-ID: <5a5fd7df85fd1d8bf0386c04552df63857a7c1ba.camel@ndufresne.ca>
Subject: Re: [PATCH] media: imx-jpeg: initiate a drain of the capture queue
 in dynamic resolution change
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, eagle.zhou@nxp.com,
        tao.jiang_2@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 22 Aug 2023 15:45:30 -0400
In-Reply-To: <20230822014506.6675-1-ming.qian@nxp.com>
References: <20230822014506.6675-1-ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 22 ao=C3=BBt 2023 =C3=A0 09:45 +0800, Ming Qian a =C3=A9crit=C2=A0=
:
> The last buffer from before the change must be marked,
> with the V4L2_BUF_FLAG_LAST flag,
> similarly to the Drain sequence above.
>=20
> Meanwhile if V4L2_DEC_CMD_STOP is sent before
> the source change triggered,
> we need to restore the is_draing flag after
> the draining in dynamic resolution change.
>=20
> Fixes: b4e1fb8643da ("media: imx-jpeg: Support dynamic resolution change"=
)
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/med=
ia/platform/nxp/imx-jpeg/mxc-jpeg.c
> index b7a720198ce5..e74b0ed8ec5b 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -1322,6 +1322,20 @@ static bool mxc_jpeg_compare_format(const struct m=
xc_jpeg_fmt *fmt1,
>  	return false;
>  }
> =20
> +static void mxc_jpeg_set_last_buffer(struct mxc_jpeg_ctx *ctx)
> +{
> +	struct vb2_v4l2_buffer *next_dst_buf;
> +
> +	next_dst_buf =3D v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +	if (!next_dst_buf) {
> +		ctx->fh.m2m_ctx->is_draining =3D true;
> +		ctx->fh.m2m_ctx->next_buf_last =3D true;
> +		return;
> +	}
> +
> +	v4l2_m2m_last_buffer_done(ctx->fh.m2m_ctx, next_dst_buf);
> +}
> +
>  static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>  				   struct mxc_jpeg_src_buf *jpeg_src_buf)
>  {
> @@ -1378,6 +1392,8 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_=
ctx *ctx,
>  		mxc_jpeg_sizeimage(q_data_cap);
>  		notify_src_chg(ctx);
>  		ctx->source_change =3D 1;
> +		if (vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
> +			mxc_jpeg_set_last_buffer(ctx);
>  	}
> =20
>  	return ctx->source_change ? true : false;
> @@ -1638,8 +1654,13 @@ static void mxc_jpeg_stop_streaming(struct vb2_que=
ue *q)
>  		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
>  	}
> =20
> -	if (V4L2_TYPE_IS_OUTPUT(q->type) || !ctx->source_change)
> -		v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
> +	v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
> +	/* if V4L2_DEC_CMD_STOP is sent before the source change triggered,
> +	 * restore the is_draining flag
> +	 */
> +	if (V4L2_TYPE_IS_CAPTURE(q->type) && ctx->source_change && ctx->fh.m2m_=
ctx->last_src_buf)
> +		ctx->fh.m2m_ctx->is_draining =3D true;
> +
>  	if (V4L2_TYPE_IS_OUTPUT(q->type) &&
>  	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx)) {
>  		notify_eos(ctx);
> @@ -1916,7 +1937,7 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *=
vb)
>  		return -EINVAL;
>  	for (i =3D 0; i < q_data->fmt->mem_planes; i++) {
>  		sizeimage =3D mxc_jpeg_get_plane_size(q_data, i);
> -		if (vb2_plane_size(vb, i) < sizeimage) {
> +		if (!ctx->source_change && vb2_plane_size(vb, i) < sizeimage) {
>  			dev_err(dev, "plane %d too small (%lu < %lu)",
>  				i, vb2_plane_size(vb, i), sizeimage);
>  			return -EINVAL;

