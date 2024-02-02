Return-Path: <linux-kernel+bounces-49903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8771D847136
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C57D1F2A045
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803E446551;
	Fri,  2 Feb 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="keirWl+F"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DFB4778C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880800; cv=none; b=fkH1CvBXUGefiMVszrCmwC1WO5HplgGQMmu/eD27yO7+DsorTtt45pGlAE6/7Lkl9cMIH6YYum2JT94HenxzW+64gXCckRZJRuNUcm2dxD4efMeo5kZ7KveY90KsEVHo9SsoJFgKoFC1+UxXP7J+8kyLqb8xIiRQ6gHTEzTQ8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880800; c=relaxed/simple;
	bh=h5FvZM4vvQNNPHEA7xoOPdnJcfL/NdwEA3OTpamvKW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K31QdM2hiQ7qXkin+JYNFjewGjbBckLYhX/Xez+aoc9gKeiu4dOOTkiBFrGN+SGuBtDsuBFgAVm7j3I7shycUNFmleo6oVqF2IC5DgUR9vrILjptT22MGZSJ1nNZ3CkjI5HHRk6SqFhOhbqbxrcKWbUgJupC+arForBRCS8+4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=keirWl+F; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d625a3ace6so962412241.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 05:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706880798; x=1707485598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABHcyEAdLWO2TnDu9cSX+H4Lljr3MzHerdVctwbmSHg=;
        b=keirWl+FQrSsKZDAyhskKT2mrlhXk/mth2+t6U2ARDaL0MmKW8sILwaFIHYt8YuwhK
         a3ioAlHGYHHbcZ3zgIlCpEI7IeNfxrLj80eLMd5FKLvGALxz1F9wqXCbD5aGP6Lh3pgg
         1Hyy7+1UZA+WGQbwJntRctqusMjVsh1DeQJrLtlHLAy3KZC8koXNeD0zcRB1PuCJnbB6
         7+ZR5BTklPMulGnLy9DzArbSOtZ0QNCf4rG0kmyRGYrRuNRLGO0XM88vkiuLXDR9n7kq
         cVBWtwAfLBWY8NmZe9euIhWEimrvBkV1TSCFMrSUh/HJc9NzA1gqRlEIjiEfkHCYR1Zv
         Y2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706880798; x=1707485598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABHcyEAdLWO2TnDu9cSX+H4Lljr3MzHerdVctwbmSHg=;
        b=ibSKKZ2IEggo2BWnqnVUygq5IA8kcF0Y90qfXH4agPeiqElU15LcoKjt6yAcXBSixt
         gZwUTLTn/sSViYbE2doOLo7eT9+udwZv7ElULrAt8z4InLxeHyaFPX3UjMYGShFTn4OF
         XIzscJK2lVUVfiGuotTaJmvFFk+9P0Aeu2sOZjg2DwdK4IXYQAedrUJvuyO64Zi7d0c6
         hwKbZD6DRKqI9vIVRdiOO+Uo5pyNDBQ/Ry5PddNSFx3KEKq9QL9r8ByqwRVBj6s+3mPP
         0rIpauvpQ2elpM78mkVivcKVvloNiF8/VJDiwOjIkZXyfefqjMp2fUh1Pq8OF1TuluOh
         Ty1Q==
X-Gm-Message-State: AOJu0YxR+HrJd3+KgcbX9WOUGktuVEo6Iz3010uMcmzbQW6/h4srWfUB
	fs+Izn2Y4eLX+IshXL4RaeO2NpK4rgxKlbQVK8p/OEwpLgrnPCHG137eZYBaNt/ompPFIrdMBPE
	/rf+meMBxoUt2bZrd42Uo+Drrv3wItk1GaV7Hw4rvWyE+u24y7Pg=
X-Google-Smtp-Source: AGHT+IE2t4sCo6S1CYz+g6JONlHPeGsLsX8UkTO1nPLRyZWTmqGx0L//XrviSyo8YUB/6Z1H702/5yuZWNn3whWLSNI=
X-Received: by 2002:a1f:7208:0:b0:4b6:be22:cfc3 with SMTP id
 n8-20020a1f7208000000b004b6be22cfc3mr1417232vkc.8.1706880798417; Fri, 02 Feb
 2024 05:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124205900.14791-1-martin@kaiser.cx> <20240124205900.14791-3-martin@kaiser.cx>
In-Reply-To: <20240124205900.14791-3-martin@kaiser.cx>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 2 Feb 2024 14:33:07 +0100
Message-ID: <CAMRc=MeRjV_Nec1CCb-S5q2HW7d_TFFbbRkhFSXFweaaCQ5uZg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] gpio: vf610: enable COMPILE_TEST
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Peng Fan <peng.fan@nxp.com>, Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 9:59=E2=80=AFPM Martin Kaiser <martin@kaiser.cx> wr=
ote:
>
> Enable COMPILE_TEST for the vf610 gpio driver to support test builds on
> systems without this hardware.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v4:
>  - add a new patch to enable COMPILE_TEST
>
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 353af1a4d0ac..3081406ff57a 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -713,7 +713,7 @@ config GPIO_UNIPHIER
>  config GPIO_VF610
>         bool "VF610 GPIO support"
>         default y if SOC_VF610
> -       depends on ARCH_MXC
> +       depends on ARCH_MXC || COMPILE_TEST
>         select GPIOLIB_IRQCHIP
>         help
>           Say yes here to support i.MX or Vybrid vf610 GPIOs.
> --
> 2.39.2
>

Applied, thanks!

Bart

