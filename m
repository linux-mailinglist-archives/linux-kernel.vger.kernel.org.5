Return-Path: <linux-kernel+bounces-53186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D401E84A1D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900CE285736
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4EA47F52;
	Mon,  5 Feb 2024 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a/kYseUs"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6045978
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156691; cv=none; b=HYl15XZO/YrkHx9skU1Ey+B0bgsSS2gtV5BX9pARDFRbOOVTZnA43hAFNxMv1o8HQhQbygR7DlLQUHWxpYAOHs17wvChaeoww7kQDME2BCOzE2MP58t/gUJ8FEzepveI0WOgOTy5DIkS8IzwfJKV6nrgc97KexuT26auus4hzYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156691; c=relaxed/simple;
	bh=VwcaSmtvjRjxf/Iv6lMWF4GZNaFQ25DKb9caAPo+0mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9ZaFeb/aIFG+il01JN9hMMVtQQNfplgpp25Gdad02np9FhI54uKsr7bkv7cHLUoGqHlDw0BeTdvwJNNJtxBQUC1Geg32nAuBkMjyGqdaUqiCnPBscCVK9IgPCID/h5RtyyNYiIDNMMRDMpK5Qp6IfmuaP8q94g3YrDXJVhmdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a/kYseUs; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5114cd44fdbso2704780e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707156685; x=1707761485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ood9JeXOKG87bTqfPH5vVrFrWxV318p/Ke+LplXjoho=;
        b=a/kYseUsVOApbcDqo7nlBcgdbsjxfi7dLKawib4sxJ18gY80U+pKm1I67fruEGvlDc
         32cJbkxAl9Pbslrn/tAKYAt99shzTJFycFBy6Ez6Dw2tavi3jY6SGTMIJ1r/nYnVYrDs
         +WWNxAeO1IrVBjJbXMw3FxjWnLsKPAMSB70Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156685; x=1707761485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ood9JeXOKG87bTqfPH5vVrFrWxV318p/Ke+LplXjoho=;
        b=Tc7QSwmNN6oOBWZHN5AlfsJs9GRfYB0XvMHMHmafLP/3g6EkJnVP7EnQ7s1CVM2Z33
         /epP3Gl3p10Rw7hMS481LfzZQxUxqYwCiifnQlL237I/bpc68xJujA5bguRxCxL75EKt
         l9GUI/Ii5NkuxSS3jBJV/K9+wpe2gaSwkaMCXqV5vjT1Yg40R1Of58sl9bAAERlrQqv7
         wQQ/BMtaHGvDJG31TuT2jiG0GI1fh4r93+8lyL/9wkxSWrHaQKdZRgVDnRgNqY/TNPGU
         nly7DvVbOV4C9k9FwbSrQxexBeVJgwT/8VnqbRUNwwaR9loUP3L1EVrGOy74cAME69E8
         rTRw==
X-Gm-Message-State: AOJu0YzVlQPzTLCJcr/Cj/wsOWkW8s5bglZObDWgm+/NewDI75MhcRMD
	s3w7JmwsqSIMwAHcKpqH8hTYf0QB2d1J3CIcY9Y5/Kc6JeME2mToPP37jeWLJ6OsZY/lDt2VuWP
	IvUZd
X-Google-Smtp-Source: AGHT+IHPeCEiNn9O5l+AgaXum4wDbYvGo+R4ygSsq/lD+wnNxDLwGsgEKz2amAF8TPSbbZ/rJWwuiA==
X-Received: by 2002:a05:6512:2028:b0:511:4967:9f0a with SMTP id s8-20020a056512202800b0051149679f0amr213881lfs.57.1707156684799;
        Mon, 05 Feb 2024 10:11:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZQ3Bz/5J695l1G/jrVKKdPjXNMBJojzXKpqdzeLMoNiya9WEJcy02L1lqG85vm4M5KpYiD0gTtb7VYH1H/FJvD4XS9MXY11GkEHLo
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id b5-20020a196705000000b005114a9c483csm24181lfc.100.2024.02.05.10.11.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:11:24 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5114a797f17so523e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:11:24 -0800 (PST)
X-Received: by 2002:a19:5f50:0:b0:511:4a7c:51aa with SMTP id
 a16-20020a195f50000000b005114a7c51aamr19188lfj.6.1707156683549; Mon, 05 Feb
 2024 10:11:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b236236a-9953-4246-a697-19ed1b22d86a@web.de>
In-Reply-To: <b236236a-9953-4246-a697-19ed1b22d86a@web.de>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Feb 2024 10:11:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xsg3Fs8XQ0piBYKGSYOhuGXyKpoJ5dbtGPdP5HU+2RyQ@mail.gmail.com>
Message-ID: <CAD=FV=Xsg3Fs8XQ0piBYKGSYOhuGXyKpoJ5dbtGPdP5HU+2RyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/hisilicon: Use devm_platform_get_and_ioremap_resource()
 in dsi_parse_dt()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, John Stultz <jstultz@google.com>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Tian Tao <tiantao6@hisilicon.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Xinliang Liu <xinliang.liu@linaro.org>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
	Yongqin Liu <yongqin.liu@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 5, 2024 at 12:13=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Feb 2024 08:58:21 +0100
>
> A wrapper function is available since the commit 890cc39a879906b63912482d=
fc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Thus reuse existing functionality instead of keeping duplicate source cod=
e.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/d=
rm/hisilicon/kirin/dw_drm_dsi.c
> index 566de4658719..1edf429c49d7 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> @@ -834,8 +834,7 @@ static int dsi_parse_dt(struct platform_device *pdev,=
 struct dw_dsi *dsi)
>                 return PTR_ERR(ctx->pclk);
>         }
>
> -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       ctx->base =3D devm_ioremap_resource(&pdev->dev, res);
> +       ctx->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &re=
s);
>         if (IS_ERR(ctx->base)) {
>                 DRM_ERROR("failed to remap dsi io region\n");
>                 return PTR_ERR(ctx->base);

This function no longer needs the local variable "res". Remove it and
then change the function call to devm_platform_ioremap_resource().
With that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

