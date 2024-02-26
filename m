Return-Path: <linux-kernel+bounces-82077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F14867EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A931F2B20D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A39112EBF4;
	Mon, 26 Feb 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LqvqVx37"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14912E1F3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968981; cv=none; b=AA65ccn95WIfFA2U2toEZfgiXjoU725saZV7OcbyureaKaBDTGfwfPInQAgKH5cqAtIro9q3pruutGWqLdb+n1HWgKY0c9/oRlQevYuyCWyiahEdE7lxnxnDeGjubwzSxKj6thCJwsQYJXyU2MZLHN3HhZ32TlS5JkBpsETETgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968981; c=relaxed/simple;
	bh=aHCWKYUowEiJlYHQoqwEiRkIXxFGOS+v0Qck42dejEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2qQI+nK3pchYuTfJtDJcdoz1Gpe3x5PpiqpvZRYHdNEc0YHM/o6U1oe8OOAygH/gzcs1WzEIt1dZMBqLeRps0pbiLD39yPSawiAH/Ws6BJq9XeRG8kDAVLOqv72fz10NPE/l6W2EruGtibZ1meuP+iEdQcEOZ7V7ZjGPT7WxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LqvqVx37; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68f571be9ddso33257226d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708968978; x=1709573778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TJDpiQS0mzwh7myIO+xWtjFUw057mz9Kw5WxBUdIdQ=;
        b=LqvqVx37UWyE5uc2uf1be2/KY9OhJUZxcS3+Z620c8KWefWafg9PwWiv8jr0elemVz
         Gd8UhbqdRE2BIWRntxoV8P8YvFVjSG7FnbpPxkdIKDsprxLqcv+8+8nnnkUyxARBMQJa
         gP55aUGkQT4pX9Aji5w2ccIaAVsFwmKlard0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968978; x=1709573778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TJDpiQS0mzwh7myIO+xWtjFUw057mz9Kw5WxBUdIdQ=;
        b=WxLGkznFLc8G1GY+0KXwtxSGRpXQPSfVBt0ssZC+iN2xicaB326mvBvopHrqcXsZUd
         5IoV7BoU+GUkwDepGjTCgIaggbWaocLMkf3A7dh5dhnlZ837e6AgAytSIQgZzOvMVT2O
         l0qqB8Bq8Z4bKTkiZf7ZtcJuX3S6mQVz7nkYCVeIDieppIrL9gV4w+lsn2oSqKGSuL7q
         lHksDKSGUAcBOQ7VIA1MEpSES2MD+IHPyS5MIJjNyXQXJXArkpoSFoAs9zuksBUS7IE2
         P8NEUEpQeT/p2qsoMAa5Rb9RPAPRt/o/bhMTDReo/XkYRBd6cCWYmM8h0rJ6jLeNnZHP
         1R7g==
X-Forwarded-Encrypted: i=1; AJvYcCUVoHl98kIBRdPUVA/Loan5p8Vl9KEfBttshW5qOGzGY5yf1++2gnmuNoL/i0/Dva/OElLvVHCrsN/h4UIkrKb37FrmZLOZ1Sa9YLx5
X-Gm-Message-State: AOJu0YxfPGeds8Sk/OTN2gYCtlbh5d+KDAI/Ps1rAO2XJe1PgHatcrQo
	xTOz81QtM6Ps+KOeS1hL6AgfpeXIGfjSHGZs6IKJxJCFXT/MGU/31vMrwD1hIYn/0xyRwt1GPoc
	=
X-Google-Smtp-Source: AGHT+IFRGVJ9fOOEAnGLOBRwBOnFUxAy0Dp9rHK0t5s1ARYGXRn4VOlqiJ2YSebtwgBECP50v5s8Ww==
X-Received: by 2002:a0c:e18a:0:b0:68f:7f3b:5ef7 with SMTP id p10-20020a0ce18a000000b0068f7f3b5ef7mr7103278qvl.17.1708968977826;
        Mon, 26 Feb 2024 09:36:17 -0800 (PST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id mv8-20020a056214338800b006901a6dc877sm237041qvb.145.2024.02.26.09.36.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:36:17 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6861538916cso24146766d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:36:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkAuiIn7I7nhz/833wLF7WcZNr2M3QmN5ZDOz888He0wpRRNABHrVZTJpRvrNZoImG21RPJGyEb3OfUzLXuuMOcwUb2IiCZx2n8hZ3
X-Received: by 2002:a05:6214:1c8a:b0:68f:5fce:66f1 with SMTP id
 ib10-20020a0562141c8a00b0068f5fce66f1mr8157094qvb.46.1708968976685; Mon, 26
 Feb 2024 09:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226-fix-clang-warnings-v2-0-fa1bc931d17e@chromium.org> <20240226-fix-clang-warnings-v2-3-fa1bc931d17e@chromium.org>
In-Reply-To: <20240226-fix-clang-warnings-v2-3-fa1bc931d17e@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 26 Feb 2024 18:35:59 +0100
X-Gmail-Original-Message-ID: <CANiDSCtvLkWJ=-DgnAGFmHSuXy_ZCcgxfccQQ3cK_6y+WkML6A@mail.gmail.com>
Message-ID: <CANiDSCtvLkWJ=-DgnAGFmHSuXy_ZCcgxfccQQ3cK_6y+WkML6A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] media: mediatek: vcodedc: Fix Wcast-function-type-strict
 warnings
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Mike Isely <isely@pobox.com>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	nfraprado@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, 26 Feb 2024 at 18:32, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Building with LLVM=3D1 throws the following warning:
> drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c:38:32: =
warning: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsigned=
 int, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned in=
t, void *)') converts to incompatible function type [-Wcast-function-type-s=
trict]
>
> Constify the types to avoid the warning.

Please note that this has only been compile tested.


>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c          | 12 ++++++=
------
>  .../media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h    |  2 +-
>  .../platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c      | 10 +-----=
----
>  drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c |  2 +-
>  drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c |  2 +-
>  drivers/remoteproc/mtk_scp.c                                 |  4 ++--
>  include/linux/remoteproc/mtk_scp.h                           |  2 +-
>  include/linux/rpmsg/mtk_rpmsg.h                              |  2 +-
>  8 files changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c b/driver=
s/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
> index 49fc2e9d45dd5..c4f1c49b9d52a 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
> @@ -77,10 +77,10 @@ void mdp_vpu_shared_mem_free(struct mdp_vpu_dev *vpu)
>                 dma_free_wc(dev, vpu->config_size, vpu->config, vpu->conf=
ig_addr);
>  }
>
> -static void mdp_vpu_ipi_handle_init_ack(void *data, unsigned int len,
> +static void mdp_vpu_ipi_handle_init_ack(const void *data, unsigned int l=
en,
>                                         void *priv)
>  {
> -       struct mdp_ipi_init_msg *msg =3D (struct mdp_ipi_init_msg *)data;
> +       const struct mdp_ipi_init_msg *msg =3D data;
>         struct mdp_vpu_dev *vpu =3D
>                 (struct mdp_vpu_dev *)(unsigned long)msg->drv_data;
>
> @@ -91,10 +91,10 @@ static void mdp_vpu_ipi_handle_init_ack(void *data, u=
nsigned int len,
>         complete(&vpu->ipi_acked);
>  }
>
> -static void mdp_vpu_ipi_handle_deinit_ack(void *data, unsigned int len,
> +static void mdp_vpu_ipi_handle_deinit_ack(const void *data, unsigned int=
 len,
>                                           void *priv)
>  {
> -       struct mdp_ipi_deinit_msg *msg =3D (struct mdp_ipi_deinit_msg *)d=
ata;
> +       const struct mdp_ipi_deinit_msg *msg =3D data;
>         struct mdp_vpu_dev *vpu =3D
>                 (struct mdp_vpu_dev *)(unsigned long)msg->drv_data;
>
> @@ -102,10 +102,10 @@ static void mdp_vpu_ipi_handle_deinit_ack(void *dat=
a, unsigned int len,
>         complete(&vpu->ipi_acked);
>  }
>
> -static void mdp_vpu_ipi_handle_frame_ack(void *data, unsigned int len,
> +static void mdp_vpu_ipi_handle_frame_ack(const void *data, unsigned int =
len,
>                                          void *priv)
>  {
> -       struct img_sw_addr *addr =3D (struct img_sw_addr *)data;
> +       const struct img_sw_addr *addr =3D data;
>         struct img_ipi_frameparam *param =3D
>                 (struct img_ipi_frameparam *)(unsigned long)addr->va;
>         struct mdp_vpu_dev *vpu =3D
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.=
h b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
> index 300363a40158c..2561b99c95871 100644
> --- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
> @@ -23,7 +23,7 @@ enum mtk_vcodec_fw_use {
>
>  struct mtk_vcodec_fw;
>
> -typedef void (*mtk_vcodec_ipi_handler) (void *data,
> +typedef void (*mtk_vcodec_ipi_handler) (const void *data,
>         unsigned int len, void *priv);
>
>  struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_f=
w_type type,
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_=
vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> index 9f6e4b59455da..4c34344dc7dcb 100644
> --- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> @@ -29,15 +29,7 @@ static int mtk_vcodec_vpu_set_ipi_register(struct mtk_=
vcodec_fw *fw, int id,
>                                            mtk_vcodec_ipi_handler handler=
,
>                                            const char *name, void *priv)
>  {
> -       /*
> -        * The handler we receive takes a void * as its first argument. W=
e
> -        * cannot change this because it needs to be passed down to the r=
proc
> -        * subsystem when SCP is used. VPU takes a const argument, which =
is
> -        * more constrained, so the conversion below is safe.
> -        */
> -       ipi_handler_t handler_const =3D (ipi_handler_t)handler;
> -
> -       return vpu_ipi_register(fw->pdev, id, handler_const, name, priv);
> +       return vpu_ipi_register(fw->pdev, id, handler, name, priv);
>  }
>
>  static int mtk_vcodec_vpu_ipi_send(struct mtk_vcodec_fw *fw, int id, voi=
d *buf,
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c=
 b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> index 82e57ae983d55..a840dd2a48d0e 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> @@ -97,7 +97,7 @@ static bool vpu_dec_check_ap_inst(struct mtk_vcodec_dec=
_dev *dec_dev, struct vde
>   * This function runs in interrupt context and it means there's an IPI M=
SG
>   * from VPU.
>   */
> -static void vpu_dec_ipi_handler(void *data, unsigned int len, void *priv=
)
> +static void vpu_dec_ipi_handler(const void *data, unsigned int len, void=
 *priv)
>  {
>         struct mtk_vcodec_dec_dev *dec_dev;
>         const struct vdec_vpu_ipi_ack *msg =3D data;
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c=
 b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> index 84ad1cc6ad171..ea0c4a281d1a1 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> @@ -57,7 +57,7 @@ static bool vpu_enc_check_ap_inst(struct mtk_vcodec_enc=
_dev *enc_dev, struct ven
>         return ret;
>  }
>
> -static void vpu_enc_ipi_handler(void *data, unsigned int len, void *priv=
)
> +static void vpu_enc_ipi_handler(const void *data, unsigned int len, void=
 *priv)
>  {
>         struct mtk_vcodec_enc_dev *enc_dev;
>         const struct venc_vpu_ipi_msg_common *msg =3D data;
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index a35409eda0cf2..b508136b416a8 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -78,10 +78,10 @@ static void scp_wdt_handler(struct mtk_scp *scp, u32 =
scp_to_host)
>                 rproc_report_crash(scp_node->rproc, RPROC_WATCHDOG);
>  }
>
> -static void scp_init_ipi_handler(void *data, unsigned int len, void *pri=
v)
> +static void scp_init_ipi_handler(const void *data, unsigned int len, voi=
d *priv)
>  {
>         struct mtk_scp *scp =3D priv;
> -       struct scp_run *run =3D data;
> +       const struct scp_run *run =3D data;
>
>         scp->run.signaled =3D run->signaled;
>         strscpy(scp->run.fw_ver, run->fw_ver, SCP_FW_VER_LEN);
> diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remotepro=
c/mtk_scp.h
> index 7c2b7cc9fe6c1..84e579940b8e5 100644
> --- a/include/linux/remoteproc/mtk_scp.h
> +++ b/include/linux/remoteproc/mtk_scp.h
> @@ -8,7 +8,7 @@
>
>  #include <linux/platform_device.h>
>
> -typedef void (*scp_ipi_handler_t) (void *data,
> +typedef void (*scp_ipi_handler_t) (const void *data,
>                                    unsigned int len,
>                                    void *priv);
>  struct mtk_scp;
> diff --git a/include/linux/rpmsg/mtk_rpmsg.h b/include/linux/rpmsg/mtk_rp=
msg.h
> index 363b60178040b..9d67507471fba 100644
> --- a/include/linux/rpmsg/mtk_rpmsg.h
> +++ b/include/linux/rpmsg/mtk_rpmsg.h
> @@ -9,7 +9,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>
> -typedef void (*ipi_handler_t)(void *data, unsigned int len, void *priv);
> +typedef void (*ipi_handler_t)(const void *data, unsigned int len, void *=
priv);
>
>  /*
>   * struct mtk_rpmsg_info - IPI functions tied to the rpmsg device.
>
> --
> 2.44.0.rc0.258.g7320e95886-goog
>


--=20
Ricardo Ribalda

