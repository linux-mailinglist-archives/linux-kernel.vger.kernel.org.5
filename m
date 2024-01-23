Return-Path: <linux-kernel+bounces-35986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AEA83999B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADB1B2F514
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F9385C72;
	Tue, 23 Jan 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XH87orin"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4B823AE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038123; cv=none; b=eja0JayBOXb5Fexj/fS572CWMnQaH52vm3t2tFQjZ0fw9EKmKunpZ7Zj6B/IkxVk7AeKUCQby1F8tcl4+tjpdWvQS7bb3jc1xzM9G4OwhlBuN4RiF1By6S4MDIDibxoM9vW2u9Xw289Xnp6Mb2zs+tm6mzzTSoL+0bE9X3YqHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038123; c=relaxed/simple;
	bh=z635edAjEZRLK9uYsv6D75GltoeAuq2T8K98RgKsohU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUv33tD7RAIfqxK+6UDxRI/2rAGh4bQ95oNhPKTlp1tbM0XJ5f1RaSpMLr9n6/Yz/qPmJN3DQ5ulzxTpinMhN+kYF0iYPXMhYz8spFwCBF/NpC7q/zrrzrOC5PN4PGh4MJg9TYoWg6tCRFE4v0YoKru49Jj8puUwCo40vJVCzL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XH87orin; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dd84fe7aebso537873b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706038120; x=1706642920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4fx2jRa6XWdzoBOQRFudfhQ7Cys5tOUHx4aJsazh8w=;
        b=XH87orin++yohiMfBwAoFVV9WdBMKy+twg/U6p/3DyC9KKTOU2Ux3eLbdMfNgfkODT
         ppj7MvP0UEPdg6jEE5yAgZJvT/XXOtMm2ElKwrRwEkVaArOZLozQ8ORNwNgs8bDa8asU
         /rn+q+Ke3bT8gefXTQ+LrLW55JQhv4q1x7wguM/Vwu9Whh0g7jpL5Zt7xDaOWe8L6bz5
         cNisxXxI0IQgX4RWq2IQgPrBOrWWzqV4tOTLOOfjyQv/6vsOetesi3H3EwmHWBlNyngt
         vtoakd+H+8kUbkC5yVFqV+TzKZ+SL2E7oviXIw6OHpzBZKwcyBDRRyJBRaSo9Qp9hGap
         A3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706038120; x=1706642920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4fx2jRa6XWdzoBOQRFudfhQ7Cys5tOUHx4aJsazh8w=;
        b=nmwvpQ5LVjIyP0XXFf8fbsWNf//ajpXe3c4q9Slib5AfJH08cbVZ7AIfrjgqoNyG3h
         jJZ+YrBlZnPUymXXQ2ato+S67B7Pvt77X5oPyTuMP2N7790suNtK9jeylP7KW093s6ah
         95om5icCgWFGs84tVPVqYL1he66xKbplsRz6CcJUGzyRsOCxeDpQDiCcj5CB/0jBE0cd
         NFSCsW5Mm62D8TrJipElYFW04QY5qjc6fJmWCKhRL9ahZIp3qwJA9xanvCqZ7MeUz+7m
         1FPVTg78P8VaYIWXSli3vcTEs/I+ClezKpbyVzAYOnLGK6pDULnJBVu4M9G2zAYeWZAL
         E9Nw==
X-Gm-Message-State: AOJu0Yw4mVQhhIboNHO1tTdEUTA6ps7LKWDnqY3ZFXi/yZnVi4KWF9Ff
	5mFtVs4T+MQDAUbMIze8jEOU+7jgAb0rDaRHiP/FgFHkJwO75H7umMFoItmnD/xiGjWkzZAowwI
	/4V6DrKfEOdYTkVj0cSL14QkMMc7FgEzcIN8JSxyQ9H75ZJVm
X-Google-Smtp-Source: AGHT+IE4pMdlHZBzRIybtPg+syPs+PySUc9Nk1uvLXRsfE7U/0t69O5o5wVcE/JsP6QewXSBCaO+EnVOVMCLRSuJrjI=
X-Received: by 2002:a05:6a00:460e:b0:6da:bceb:3990 with SMTP id
 ko14-20020a056a00460e00b006dabceb3990mr3781418pfb.53.1706038119921; Tue, 23
 Jan 2024 11:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org> <20240123153421.715951-17-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-17-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:28:28 -0600
Message-ID: <CAPLW+4k-5vdkBNdewTgG72iAr0oLv1zXncnmx-qy6diJqQMNDg@mail.gmail.com>
Subject: Re: [PATCH 16/21] spi: s3c64xx: add missing blank line after declaration
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:34=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> Add missing blank line after declaration. Move initialization in the
> body of the function.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index f5474f3b3920..2abf5994080a 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1273,8 +1273,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
>  {
>         struct spi_controller *host =3D dev_get_drvdata(dev);
>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_devdat=
a(host);
> +       int ret;
>
> -       int ret =3D spi_controller_suspend(host);
> +       ret =3D spi_controller_suspend(host);

Why not just moving the empty line below the declaration block,
keeping the initialization on the variable declaration line?

>         if (ret)
>                 return ret;
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

