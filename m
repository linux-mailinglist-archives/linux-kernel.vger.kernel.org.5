Return-Path: <linux-kernel+bounces-83134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F9868EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC3F2812AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6226113A24B;
	Tue, 27 Feb 2024 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcStZZuN"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE5137C38;
	Tue, 27 Feb 2024 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033927; cv=none; b=SGXfysuSGTJKA8X/nI93/O388anuIIXtqQUIeyg5yOqyZGbZRA+mEgZM4Se2sdfrneeXc2b5crn7UcxkpOzS2oXl/L3UvOwPut02t8u9OQaH6w4vaJpOmyrIodm9O393LYO+bDCvLgZCp8Q1KH/XwLC2jEPAw3/c7srs+NDn+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033927; c=relaxed/simple;
	bh=rlI6CJci4iW2GxOaWto3mdUB3kh4slGAyal47TgP7jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocHBlzfu3IFO7kzzVhackxf/RGy7jOyMjwAOVoJorwaLOIvB/NETAZWbAqDbOCG/1rHANarL2ofS5PT9I0a7yV6raCaW4Ayu1TCB8LVasQ5dg4EZRQNuKigVGgC+JjDxWDhV3WvvrfmGxBhkBN8fB7PBp6XtYNFafrmSqBxeqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcStZZuN; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d19972b455so351330e0c.3;
        Tue, 27 Feb 2024 03:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709033924; x=1709638724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1EveZVEiSMMMB6fnTuGZVP/gmbDHNaPcEtW3gx8n28=;
        b=DcStZZuNOOgn0mlWU8YYHeZNOBjW+/nvk3zGnV3Gq+VtF9GG2sI9dvwADrpVAuBHvZ
         0wK6OEtoRkfZhbGLFGieYATAXVcPVWiq4jnAsAeGuBC1fzwVlDnSGuoSfaGN9UK496yn
         6bfP7Kgv4B2DdMjGXZmFbxbYEUWF5I6DRTY77x2eU1pmPaTVa6yYHZh/ojFiM7pCZ67h
         C035RJrnLHSp3Px57t/87E1/Y3SmiIk2sTHBHV/zSiUC2tTmquEftUcUc+BtkFGeHyI1
         4EG5wQQz2HlJz8vyPP458pBIwHTNqhO5rgAuABfM0VSC/jISEiH/A40Fe1Jz4qhb7m9R
         3OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709033924; x=1709638724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1EveZVEiSMMMB6fnTuGZVP/gmbDHNaPcEtW3gx8n28=;
        b=ruwiMGyyYbOSkb4d7ojAD66Rrh3LEAYfyd81q5SXC1bTVMTIpWOtS5XgCuMRYvnpOt
         LRWOoh16ZVfEY9fRKiOT/5JiO9nJ9lbdxi/zzWssfOwT+/NDhgbUqHvxxH4WsL7Farhj
         r5FvWV7rcRAU3qoey+QlB+kt+UC/g6TAe0td8KPTMehm93h2GZNDsW8vPz1UC3dP/qZf
         5mKt/SI6bOox24u5GN51qm1J+psKdWPW/Cs/XcPpKWhmzyf4I7tQc6zqz+jcCwjg02F6
         dycn8mQ72Dup6Wi8eiI9prFUEOfEGgqrQRm5FVR8zI0Lhx3Y88zUi467T0Zhg0XUwF/c
         27Gg==
X-Forwarded-Encrypted: i=1; AJvYcCW34TZv5lpWfkuprvy5w7rl0g9tDURPfwSQ14hkyGxk8ugn3qBTgiaHhFgVybKVede33Cj8diM7iRneQTM6YVs8Ni2CZ8Xwa3z/lprg42tYgA5C7ywjrBvuIE161Tgeh9jvGitSNGSEVOA=
X-Gm-Message-State: AOJu0YzjQK366KoCQYh7s+5M3y5myvAVGEfy9Y1q0EkC64rt+3gkIVZd
	z2eljhGjs1B6j4MXvGX04iQdVtdZPdX8GW4BmeX1775R/q5+pshFnKzdocTibBhQ6eTdqWe01AO
	unB5LdRdlWBtzP63wqc2SAOg/vXY=
X-Google-Smtp-Source: AGHT+IFY5rIW4R7AnsOo+2KkC+7Q4PqHRUzXLysCU3Xts5MAHbKEy5X0OQfVK+hv44PSmKVkOQ8vOWnw8p15f/5mIVs=
X-Received: by 2002:a1f:ca47:0:b0:4c9:b8a8:78d4 with SMTP id
 a68-20020a1fca47000000b004c9b8a878d4mr7019527vkg.3.1709033924366; Tue, 27 Feb
 2024 03:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224121059.1806691-1-arnd@kernel.org>
In-Reply-To: <20240224121059.1806691-1-arnd@kernel.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 27 Feb 2024 12:38:26 +0100
Message-ID: <CAPybu_2JoNfr158FXqYGUV=JuTW8i85XM6cf7K40_xZe9m2qyg@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: avoid -Wcast-function-type-strict
 warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: Minghsiu Tsai <minghsiu.tsai@mediatek.com>, Houlong Wei <houlong.wei@mediatek.com>, 
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Alexandre Courbot <acourbot@chromium.org>, 
	Pi-Hsun Shih <pihsun@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd

Thanks for the patch

On Sat, Feb 24, 2024 at 1:11=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The ipi handler here tries hard to maintain const-ness of its argument,
> but by doing that causes a warning about function type casts:

I worked on the same issue, but in instead of removing the const, I
tried to constify everything:
https://patchwork.linuxtv.org/project/linux-media/patch/20240226-fix-clang-=
warnings-v2-3-fa1bc931d17e@chromium.org/

My main goal is to remove the warning, so any patch is OK for me ;)

>
> drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c:38:32: =
error: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsigned i=
nt, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned int,=
 void *)') converts to incompatible function type [-Werror,-Wcast-function-=
type-strict]
>    38 |         ipi_handler_t handler_const =3D (ipi_handler_t)handler;
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~
>
> Remove the hack and just use a non-const argument.
>
> Fixes: bf1d556ad4e0 ("media: mtk-vcodec: abstract firmware interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/platform/mediatek/mdp/mtk_mdp_vpu.c      |  2 +-
>  .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c         | 10 +---------
>  drivers/media/platform/mediatek/vpu/mtk_vpu.c          |  2 +-
>  drivers/media/platform/mediatek/vpu/mtk_vpu.h          |  2 +-
>  4 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_vpu.c b/drivers/=
media/platform/mediatek/mdp/mtk_mdp_vpu.c
> index b065ccd06914..378a1cba0144 100644
> --- a/drivers/media/platform/mediatek/mdp/mtk_mdp_vpu.c
> +++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_vpu.c
> @@ -26,7 +26,7 @@ static void mtk_mdp_vpu_handle_init_ack(const struct md=
p_ipi_comm_ack *msg)
>         vpu->inst_addr =3D msg->vpu_inst_addr;
>  }
>
> -static void mtk_mdp_vpu_ipi_handler(const void *data, unsigned int len,
> +static void mtk_mdp_vpu_ipi_handler(void *data, unsigned int len,
>                                     void *priv)
>  {
>         const struct mdp_ipi_comm_ack *msg =3D data;
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_=
vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> index 9f6e4b59455d..4c34344dc7dc 100644
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
> diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/medi=
a/platform/mediatek/vpu/mtk_vpu.c
> index 7243604a82a5..724ae7c2ab3b 100644
> --- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
> +++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
> @@ -635,7 +635,7 @@ int vpu_load_firmware(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL_GPL(vpu_load_firmware);
>
> -static void vpu_init_ipi_handler(const void *data, unsigned int len, voi=
d *priv)
> +static void vpu_init_ipi_handler(void *data, unsigned int len, void *pri=
v)
>  {
>         struct mtk_vpu *vpu =3D priv;
>         const struct vpu_run *run =3D data;
> diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.h b/drivers/medi=
a/platform/mediatek/vpu/mtk_vpu.h
> index a56053ff135a..da05f3e74081 100644
> --- a/drivers/media/platform/mediatek/vpu/mtk_vpu.h
> +++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.h
> @@ -17,7 +17,7 @@
>   * VPU interfaces with other blocks by share memory and interrupt.
>   */
>
> -typedef void (*ipi_handler_t) (const void *data,
> +typedef void (*ipi_handler_t) (void *data,
>                                unsigned int len,
>                                void *priv);
>
> --
> 2.39.2
>
>


--=20
Ricardo Ribalda

