Return-Path: <linux-kernel+bounces-104262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12BF87CB63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B6F1C217A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62F319474;
	Fri, 15 Mar 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NafJHbAd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C0E17C60;
	Fri, 15 Mar 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498628; cv=none; b=HTSRLu1Bu608sGzZ60MVsvdilCWLgJifAnKc8lINssdWARF+o8buug6Mz4hXcZnxy62GcRhdczFSvGoiuPG2yJbngGso9xDep5PO3RGaUdyKD6N9BS94/jr7JjJDqe9zItnqhkzsJ0FBs3mvcircqWaGgRq+MA7cQakyWn3YK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498628; c=relaxed/simple;
	bh=Wi/QbN+8ipUEYeOAbUm86xpNE3oPJ0g7EhQMoF7njRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXKTIOUk00g4+5zjNfG2GDawnIz7TH+cFMzYHHKnREqj7fwftVmLgx+zhwWFQg5DA48Ob9bYQJ6yebW4GWJ2DabbjWmdCPReBTj8JBBuAoaEYoZF4XWX1VOv4kUbk6qxvf02O/gK44jwoVGTfXODSo0AZ1GiMiMMWVeKE46jOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NafJHbAd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710498618;
	bh=Wi/QbN+8ipUEYeOAbUm86xpNE3oPJ0g7EhQMoF7njRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NafJHbAd9/omf5ShUyuD5GKzQhS3XJhF4WMagWXntKDm3n8ti0taj0esJziU84Mdp
	 WxYGljPwkXxB/PIz9ZLteJsSqXoYKViMdBJzKwxa4hy1ptRIMx8uVa3dNz6zuawAiD
	 BT6Otsgt/kFOBfErLJb6+zoetXvFppHZ86JA1bLOb2cBtH40Cs1Lr/UdGQjmk1R6D1
	 sc2FoITqwOwvMCEk7Qf8hjr9Tku2FW4ps+x36BQYhVeob6INGvf88oXDqrVGj72evN
	 ojyf3oZ8szTOXxre1VJoYt0ebtUIYWZdugBIh++MpGJXZ2oS3Wmx5TepO4gGVBoWhb
	 d/+ulbrcypKuw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9D6383782083;
	Fri, 15 Mar 2024 10:30:18 +0000 (UTC)
Date: Fri, 15 Mar 2024 11:30:17 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: =?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado <nfraprado@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Nathan Hebert <nhebert@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] media: mediatek: vcodec: add decoder command to support
 stateless decoder
Message-ID: <20240315094706.xcpjy5s4fjtjvn7j@basti-XPS-13-9310>
References: <20240315072629.27738-1-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240315072629.27738-1-yunfei.dong@mediatek.com>

Hey Yunfei,

On 15.03.2024 15:26, Yunfei Dong wrote:
>The supported decoder commands are different for stateless and
>stateful architecture. Adding stateless decoder commands to fix

s/Adding/Add/

>below v4l2-compliance test error.

s/below v4l2-compliance test error./the v4l2-compliance test error below./

>
>Codec ioctls:
>    VIDIOC_ENCODER_CMD returned -1 (Inappropriate ioctl for device)
>    VIDIOC_TRY_ENCODER_CMD returned -1 (Inappropriate ioctl for device)
> test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>    VIDIOC_G_ENC_INDEX returned -1 (Inappropriate ioctl for device)
> test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>    VIDIOC_DECODER_CMD returned -1 (Invalid argument)
>    VIDIOC_TRY_DECODER_CMD returned -1 (Invalid argument)
>    VIDIOC_TRY_DECODER_CMD returned -1 (Invalid argument)
>    fail: v4l2-test-codecs.cpp(126): ret
> test VIDIOC_(TRY_)DECODER_CMD: FAIL
>
>Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>---
> .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 65 +++++++++++++++++--
> 1 file changed, 59 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
>index ba742f0e391d..90579dd92cae 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
>@@ -80,21 +80,20 @@ static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_dec_ctx *ctx,
> 	return &ctx->q_data[MTK_Q_DATA_DST];
> }
>
>-static int vidioc_try_decoder_cmd(struct file *file, void *priv,
>-				struct v4l2_decoder_cmd *cmd)
>+static int mtk_vcodec_stateful_try_decoder_cmd(struct file *file, void *priv,
>+					       struct v4l2_decoder_cmd *cmd)

In some cases you seem to name these functions with the prefix
`mtk_vdec` and sometimes with the prefix `mtk_vcodec` but all of these
are for decoders, so could you settle for one naming scheme? Also as
these functions are static I don't think it is strictly necessary to add
a prefix for each function.

> {
> 	return v4l2_m2m_ioctl_try_decoder_cmd(file, priv, cmd);
> }
>
>-
>-static int vidioc_decoder_cmd(struct file *file, void *priv,
>-				struct v4l2_decoder_cmd *cmd)
>+static int mtk_vcodec_stateful_decoder_cmd(struct file *file, void *priv,
>+					   struct v4l2_decoder_cmd *cmd)
> {
> 	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
> 	struct vb2_queue *src_vq, *dst_vq;
> 	int ret;
>
>-	ret = vidioc_try_decoder_cmd(file, priv, cmd);
>+	ret = mtk_vcodec_stateful_try_decoder_cmd(file, priv, cmd);
> 	if (ret)
> 		return ret;
>
>@@ -128,6 +127,60 @@ static int vidioc_decoder_cmd(struct file *file, void *priv,
> 	return 0;
> }
>
>+static int mtk_vcodec_stateless_try_decoder_cmd(struct file *file, void *priv,
>+						struct v4l2_decoder_cmd *cmd)
>+{
>+	return v4l2_m2m_ioctl_stateless_try_decoder_cmd(file, priv, cmd);
>+}
>+
>+static int mtk_vcodec_stateless_decoder_cmd(struct file *file, void *priv,
>+					    struct v4l2_decoder_cmd *cmd)
>+{
>+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
>+	int ret;
>+
>+	ret = v4l2_m2m_ioctl_stateless_try_decoder_cmd(file, priv, cmd);
>+	if (ret)
>+		return ret;
>+
>+	mtk_v4l2_vdec_dbg(3, ctx, "decoder cmd=%u", cmd->cmd);
>+	switch (cmd->cmd) {
>+	case V4L2_DEC_CMD_FLUSH:
>+		/*
>+		 * If the flag of output buffer is set with V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF,

s/output/the output/
s/is set with/equals/

>+		 * this command will prevent dequeueing the capture buffer containing the last
>+		 * decoded frame. Or do nothing
>+		 */
>+		break;
>+

Please remove this newline.

>+	default:
>+		mtk_v4l2_vdec_err(ctx, "invalid stateless decoder cmd=%u", cmd->cmd);
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+static int vidioc_try_decoder_cmd(struct file *file, void *priv, struct v4l2_decoder_cmd *cmd)
>+{
>+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
>+
>+	if (ctx->dev->vdec_pdata->uses_stateless_api)
>+		return mtk_vcodec_stateless_try_decoder_cmd(file, priv, cmd);
>+	else

As these conditional branches contain return statements you can skip the
else.
E.g.
	if (ctx->dev->vdec_pdata->uses_stateless_api)
		return mtk_vcodec_stateless_try_decoder_cmd(file, priv, cmd);
   return mtk_vcodec_stateful_try_decoder_cmd(file, priv, cmd);

>+		return mtk_vcodec_stateful_try_decoder_cmd(file, priv, cmd);
>+}
>+
>+static int vidioc_decoder_cmd(struct file *file, void *priv, struct v4l2_decoder_cmd *cmd)
>+{
>+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
>+
>+	if (ctx->dev->vdec_pdata->uses_stateless_api)
>+		return mtk_vcodec_stateless_decoder_cmd(file, priv, cmd);
>+	else

Same as mentioned above.

>+		return mtk_vcodec_stateful_decoder_cmd(file, priv, cmd);
>+}
>+
> void mtk_vdec_unlock(struct mtk_vcodec_dec_ctx *ctx)
> {
> 	mutex_unlock(&ctx->dev->dec_mutex[ctx->hw_id]);
>-- 
>2.18.0
>

