Return-Path: <linux-kernel+bounces-157917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219868B1891
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2452862B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF1B10795;
	Thu, 25 Apr 2024 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFTj9izh"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A055F5CA1;
	Thu, 25 Apr 2024 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714009718; cv=none; b=F4YiX+p0HqGTUF+J4eELA9jOFTdTADeUkpbdw4/dDyA/jOVWfov/gjJ8EZJ2eVuz0Gdt/OcmItTBkzrUCtZLuteCm3T+4YESaF1RsMrG2sr3lHydhDjGM8WKWb1J5mrgVtZA3IQy3Z60i6gP9YTjiieQVPihNI/a/YvY0AACSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714009718; c=relaxed/simple;
	bh=wuuQOVz9l7HKfoz0AAhWERs9gACjmEB2/IPy4Bz8WH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUtjJgFP/FWxKNB4s/+GywWqVdUcJa95JsIBpdPC6LeS1H87cWhMFGGYh7YV8vWiGBGhC2V9riUvj/14sZfygtY7eVriN+TXbuuh1Hccvm8CR+ijODvl24SQ7r3wE0ek55SqftNtd8S+wW5uUNKUw8eRfzghTVM1njrkKZI/AfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFTj9izh; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-479f50bcd7bso186941137.3;
        Wed, 24 Apr 2024 18:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714009715; x=1714614515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG102H74pdxU5NBp7aAW3ezITZvy/2GYPGEaW3NCxpg=;
        b=dFTj9izhw4OxcvkYA599cp5JwDKFOb9sNel4PSVjk/HO8GI+0G4G6X/GveIwJEStDQ
         pgPdQM6dwoJfNU4nQgEZ4rhhGTYJtWI3Cs79aqkGZot6jZWCiJcNQvG7O+TwMnxpXdpe
         /VJxtrMZ/R2J3rR7XXeLVHheDc5k09AMl5dZiDRduN7cq4DG2i1Ajf8GDOlXAe/xaHsd
         BxVCa5hz3wM/Oy54v1dSt+BHlQimH7jV0vX3kWL1emsf7fxfXP0Dy8IWNlzhK7e5FVDE
         BDGINnpX5Zu7mtKNpe1/1CKk8EyOBXhdw3I0Cy0OoqsVgGYWRdck+NcdEFUgYEA4H9+Q
         H/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714009715; x=1714614515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG102H74pdxU5NBp7aAW3ezITZvy/2GYPGEaW3NCxpg=;
        b=ABVEE6DE+TuW3drhKT3eY/31AhC8PpMC29n5nuQ0OymbRWc7NR6SaXO1FunpdFJXzh
         dAGOHnPitA+9SNZgu/PQPiS0ZzJqGUFWsDqF6s2eNTAauOyoOTMtjpkVWV1txAxrIo+X
         VPAIUkJcLmeR3P25p3+xmFNZF4SGxqJ9RCexRuFqt2KazcN5Fvmgugzp55QmAPRs/7U2
         JwY0XV4ktrbd/v82X/t6Z4XzyZxAKOU2ZR4P9LZ4opOemdD576DoPJwBatV7NJve+MdK
         1zUeJE3SgytQnt3AFyzU47EV5+KXboMS7xLP+lffRuHtdAEB4iuTqFM3sHRX3x0gOvWw
         pDIA==
X-Forwarded-Encrypted: i=1; AJvYcCVi+8sMOMzg5l6XXIjEvrVMoUzUfDiKh7ioSe1cffnqggfmnSMRvocsKGRTOqNRkiRStDDF52GzB7OEkKRop6ikVeuR9y138JlbHo1QlLNHIaI3Dbk4Ur/6ZjVjq8R2B/25CyxCkity7jj4ixjjPAo=
X-Gm-Message-State: AOJu0Yy9jgE+j3GUJiXan9tsS0oeNY4jf2NO1nVcbERnYXl26c2TCojO
	kxCFLP2zFkCWAidAAcY+ZVZ+VNFwhtnoi4MdEHq+JDsL976Zl+BiYESk+UC7NnXu/pjuc2NBexr
	Hir0CW9Krbpvm5+LQEvo7zFizJ6WYTO0c/xA=
X-Google-Smtp-Source: AGHT+IEpi9vH+ceBAPGcE12M1F3pcELXnj+ShzjzIPt31fULK4uD1Y79SwhGryUErqd7wTbS/ZRIOqF3N7DMl1qnPuE=
X-Received: by 2002:a67:f10d:0:b0:47b:b820:e735 with SMTP id
 n13-20020a67f10d000000b0047bb820e735mr4726089vsk.32.1714009715581; Wed, 24
 Apr 2024 18:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415003958.721061-1-shivani07g@gmail.com>
In-Reply-To: <20240415003958.721061-1-shivani07g@gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Thu, 25 Apr 2024 10:47:59 +0900
Message-ID: <CAAQKjZO0VhkpsM4L+C97QcCAjF_b99zp2W25n+swLP6K1OUpww@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: exynos: hdmi: eliminate uses of of_node_put()
To: Shivani Gupta <shivani07g@gmail.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Julia Lawall <julia.lawall@inria.fr>, Shuah Khan <skhan@linuxfoundation.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good cleanup. Applied. :)

Thanks,
Inki Dae

2024=EB=85=84 4=EC=9B=94 15=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 9:40, S=
hivani Gupta <shivani07g@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Utilize the __free() cleanup handler within the hdmi_get_phy_io function
> to automatically release the device node when it is out of scope.
> This eliminates the manual invocation of of_node_put(), reducing the
> potential for memory leaks.
>
> The modification requires initializing the device node at the beginning
> of the function, ensuring that the automatic cleanup is safely executed.
>
> Consequently, this removes the need for error cleanup paths that utilize
> goto statements and the jump to out is no longer necessary.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exyno=
s/exynos_hdmi.c
> index b1d02dec3774..a741fd949482 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -1919,10 +1919,9 @@ static int hdmi_get_ddc_adapter(struct hdmi_contex=
t *hdata)
>  static int hdmi_get_phy_io(struct hdmi_context *hdata)
>  {
>         const char *compatible_str =3D "samsung,exynos4212-hdmiphy";
> -       struct device_node *np;
> -       int ret =3D 0;
> +       struct device_node *np __free(device_node) =3D
> +               of_find_compatible_node(NULL, NULL, compatible_str);
>
> -       np =3D of_find_compatible_node(NULL, NULL, compatible_str);
>         if (!np) {
>                 np =3D of_parse_phandle(hdata->dev->of_node, "phy", 0);
>                 if (!np) {
> @@ -1937,21 +1936,17 @@ static int hdmi_get_phy_io(struct hdmi_context *h=
data)
>                 if (!hdata->regs_hdmiphy) {
>                         DRM_DEV_ERROR(hdata->dev,
>                                       "failed to ioremap hdmi phy\n");
> -                       ret =3D -ENOMEM;
> -                       goto out;
> +                       return -ENOMEM;
>                 }
>         } else {
>                 hdata->hdmiphy_port =3D of_find_i2c_device_by_node(np);
>                 if (!hdata->hdmiphy_port) {
>                         DRM_INFO("Failed to get hdmi phy i2c client\n");
> -                       ret =3D -EPROBE_DEFER;
> -                       goto out;
> +                       return -EPROBE_DEFER;
>                 }
>         }
>
> -out:
> -       of_node_put(np);
> -       return ret;
> +       return 0;
>  }
>
>  static int hdmi_probe(struct platform_device *pdev)
> --
> 2.34.1
>
>

