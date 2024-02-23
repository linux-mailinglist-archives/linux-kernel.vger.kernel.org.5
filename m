Return-Path: <linux-kernel+bounces-78947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B84861B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0788B1F25153
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07223142631;
	Fri, 23 Feb 2024 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zQXCBHZP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2821419BA;
	Fri, 23 Feb 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711902; cv=none; b=N3qeU3wIXbi1adRzv9hYTP5SiMKhmIPySxCaVykP4r4htcKGlYWO/qjB+FG+NOYVuiRNqBNrtTquJyhd3/KZ33HEL5NA5V0r2cPfH5HoPohh2m3azogbZisqNBp/D1J8ewg8I7xWxvFAhQGDhR71z8Pl0JjjgD9s9ieIF0cnA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711902; c=relaxed/simple;
	bh=L4tt6x3R1Bj+GEMVgCO8O7Sp0dNZ/KFpCcL3E8B8s2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJRuBkfmJ7EomorBVnQFdVYw9VlAKxFBAJBQfd+8GoqHvkThosMcUyYhkRwPGkN6gFHokfM+yrlSSFWTbdTc+UM4xdNkqOFMcDCv5Vmn9apz8cwVeWDTqg5x4pJOGiOKHSi05SKyPEs/Ip5+0XdTyrmGQ5yQMpUn74+NtDpy/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zQXCBHZP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708711898;
	bh=L4tt6x3R1Bj+GEMVgCO8O7Sp0dNZ/KFpCcL3E8B8s2Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=zQXCBHZPh7mu5cqATdQZMEpfu03nZ0cxfs/33QRKuYevVD3XePgEFuEnyDdPQuI3z
	 uXenWNl+xWNLfrIJUvYUEKuKCoHO4tP9WTokWFWTVTzULDxTgSxaqsltOCStxmK1HC
	 Qrg5jBgAo4Kti3VZieI2i4Nr/c1o1IleXvqaSgM3TvJL7ZTr/qoBZgKXMQvyEzPAdL
	 4O9X0asl6bpxnN/icu7M8oDjQLq1aaZqqXKoL1LDuOCqiRSvOAYnL/Aax3VDtTmrYS
	 qUl5Ezt0hlgPlqpaX8uLl8giNtIbsiXtTgLabIgOEaZrczDugsl1NTl09wbVq/gWO/
	 BpTPk6Q60CJiQ==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 604E237820E3;
	Fri, 23 Feb 2024 18:11:36 +0000 (UTC)
Message-ID: <176094a180c0535119d487e6cf7c886c376b7d60.camel@collabora.com>
Subject: Re: [PATCH v3,2/2] media: mediatek: vcodec: adding lock to protect
 encoder context list
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Yunfei Dong <yunfei.dong@mediatek.com>, =?ISO-8859-1?Q?N=EDcolas?= "F .
 R . A . Prado" <nfraprado@collabora.com>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>, 
 Irui Wang <irui.wang@mediatek.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig
 <frkoenig@chromium.org>,  Daniel Vetter <daniel@ffwll.ch>, Steve Cho
 <stevecho@chromium.org>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com
Date: Fri, 23 Feb 2024 13:11:32 -0500
In-Reply-To: <20240222092609.31382-3-yunfei.dong@mediatek.com>
References: <20240222092609.31382-1-yunfei.dong@mediatek.com>
	 <20240222092609.31382-3-yunfei.dong@mediatek.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 22 f=C3=A9vrier 2024 =C3=A0 17:26 +0800, Yunfei Dong a =C3=A9crit=
=C2=A0:
> The ctx_list will be deleted when scp getting unexpected behavior, then t=
he
> ctx_list->next will be NULL, the kernel driver maybe access NULL pointer =
in
> function vpu_enc_ipi_handler when going through each context, then reboot=
.
>=20
> Need to add lock to protect the ctx_list to make sure the ctx_list->next =
isn't
> NULL pointer.
>=20
> Fixes: 1972e32431ed ("media: mediatek: vcodec: Fix possible invalid memor=
y access for encoder")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c      | 4 ++--
>  .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c    | 5 +++++
>  .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h    | 2 ++
>  drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c | 2 ++
>  4 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_=
vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> index 9a11a2c248045..8d578b6902148 100644
> --- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> @@ -73,12 +73,12 @@ static void mtk_vcodec_vpu_reset_enc_handler(void *pr=
iv)
> =20
>  	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
> =20
> -	mutex_lock(&dev->dev_mutex);
> +	mutex_lock(&dev->dev_ctx_lock);
>  	list_for_each_entry(ctx, &dev->ctx_list, list) {
>  		ctx->state =3D MTK_STATE_ABORT;
>  		mtk_v4l2_vdec_dbg(0, ctx, "[%d] Change to state MTK_STATE_ABORT", ctx-=
>id);
>  	}
> -	mutex_unlock(&dev->dev_mutex);
> +	mutex_unlock(&dev->dev_ctx_lock);
>  }
> =20
>  static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_msg =3D {
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_en=
c_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv=
c
> index 5db2bf3db4c54..29524cd59ce8b 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> @@ -177,7 +177,9 @@ static int fops_vcodec_open(struct file *file)
>  	mtk_v4l2_venc_dbg(2, ctx, "Create instance [%d]@%p m2m_ctx=3D%p ",
>  			  ctx->id, ctx, ctx->m2m_ctx);
> =20
> +	mutex_lock(&dev->dev_ctx_lock);
>  	list_add(&ctx->list, &dev->ctx_list);
> +	mutex_unlock(&dev->dev_ctx_lock);
> =20
>  	mutex_unlock(&dev->dev_mutex);
>  	mtk_v4l2_venc_dbg(0, ctx, "%s encoder [%d]", dev_name(&dev->plat_dev->d=
ev),
> @@ -212,7 +214,9 @@ static int fops_vcodec_release(struct file *file)
>  	v4l2_fh_exit(&ctx->fh);
>  	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
> =20
> +	mutex_lock(&dev->dev_ctx_lock);
>  	list_del_init(&ctx->list);
> +	mutex_unlock(&dev->dev_ctx_lock);
>  	kfree(ctx);
>  	mutex_unlock(&dev->dev_mutex);
>  	return 0;
> @@ -294,6 +298,7 @@ static int mtk_vcodec_probe(struct platform_device *p=
dev)
> =20
>  	mutex_init(&dev->enc_mutex);
>  	mutex_init(&dev->dev_mutex);
> +	mutex_init(&dev->dev_ctx_lock);
>  	spin_lock_init(&dev->irqlock);
> =20
>  	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_en=
c_drv.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv=
h
> index a042f607ed8d1..0bd85d0fb379a 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
> @@ -178,6 +178,7 @@ struct mtk_vcodec_enc_ctx {
>   *
>   * @enc_mutex: encoder hardware lock.
>   * @dev_mutex: video_device lock
> + * @dev_ctx_lock: the lock of context list
>   * @encode_workqueue: encode work queue
>   *
>   * @enc_irq: h264 encoder irq resource
> @@ -205,6 +206,7 @@ struct mtk_vcodec_enc_dev {
>  	/* encoder hardware mutex lock */
>  	struct mutex enc_mutex;
>  	struct mutex dev_mutex;
> +	struct mutex dev_ctx_lock;
>  	struct workqueue_struct *encode_workqueue;
> =20
>  	int enc_irq;
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c=
 b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> index 84ad1cc6ad171..51bb7ee141b9e 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> @@ -47,12 +47,14 @@ static bool vpu_enc_check_ap_inst(struct mtk_vcodec_e=
nc_dev *enc_dev, struct ven
>  	struct mtk_vcodec_enc_ctx *ctx;
>  	int ret =3D false;
> =20
> +	mutex_lock(&enc_dev->dev_ctx_lock);
>  	list_for_each_entry(ctx, &enc_dev->ctx_list, list) {
>  		if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst =3D=3D vpu) {
>  			ret =3D true;
>  			break;
>  		}
>  	}
> +	mutex_unlock(&enc_dev->dev_ctx_lock);
> =20
>  	return ret;
>  }


