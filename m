Return-Path: <linux-kernel+bounces-95291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A4874BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097A41C235CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D830F12883C;
	Thu,  7 Mar 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx4H/8c9"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3312C7F7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805703; cv=none; b=fBQTIoes+VqmO/54RFvnLCW9Qx/Ld0ZM/iAOdgSl/igZCbj80xVT0PRW84SSK4Wlks9KUpxywmnYsWdaQJGgr+uQwHZqZ2Ye1xi3n0Ba6LPi1oDtmBwSGdTb/MjO2KCgCAkxTtQfK05RxGX1fh/hAtoTh3UCgCoVZUfA+K+tujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805703; c=relaxed/simple;
	bh=Ycqfwna5vv2/3Fz8FGZLN/ciFwxNb6CI6BxyOuN3G3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGADMw51TWhEf0AWIx+KE8VRRY2WHBnN8VaZsYQWg+hC/DCFOxl0xrf84+CM8HKFTmJVpUDEE/UQ9ZXYSdus0V0wcjwFMIY+Uy0f8gyjSLEF9cDX8iOw+rKG27P8eDgalOC/Nx5vD4bfT+ycwIogJ+jRC4Y5zVjR1+ybb0y275w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx4H/8c9; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so640567276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709805701; x=1710410501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3ZN53wlMkq0k9JQSMwAY7ICJ5wERnlbCddkoAN6BhU=;
        b=Wx4H/8c9VCQgEgE/8fvN4kZvRg7Qe/vhJrz+p0/P7zSuErzKBjJAytoNLR5FdTptFF
         UmFnHOxkwAbnZB7OfHUKlaoZ2pS123cZBFcXIFjiRxKHoWv6n+hqcCKO5brf89DXe5f5
         ZuThO7RaO5JuMotub2Mf2BXVUFYdEhc85ESr77JayYsI3H8Z6aeSfa0JqMpCtek6dWK3
         UcKgn9A1wP9h6j6fanAQIGZFBkuuCvstYCazKDMW7QGl5RQHjU04acnh7w5UgSkmfkzB
         jdcAFfZM1uSBGfDXeZALQok+na7SReZn32eDrMiaTCHF9T3slkZVkh+iVhcto3iFYeCU
         rN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709805701; x=1710410501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3ZN53wlMkq0k9JQSMwAY7ICJ5wERnlbCddkoAN6BhU=;
        b=WDw3jYY+lfb5H9eLmlM1b145jHGGYbRIM/uXpEuZk3Xq6BiwMk3ynUEZnpw3M2uaFt
         uby98cRggVDBPfgDCsil6hRpO+i5zAD4MyyTYkZ24xJLtCVJW5FMCPc/cRG2ehP6qJFp
         6xSUnWTRs14oB4tT6104wMao8owWhhR/nb2shWGFsheF2CjRV4YnWcKrEWLxiqzertuX
         lZEZT71nx72sPV/8kYZb7aBfgEnN9TlNB75JY5aSc89fU/F1HluDYIhvwpZ97vR3fV2c
         cH7lKZwpzYLCExzrVBHc53SYm6e8HtqNYGEAhShJtF/UTK1yORCRlg4DUMaKuWFvYrIX
         2lkw==
X-Forwarded-Encrypted: i=1; AJvYcCXMKAbUkPDcndz9VXFD9gNhJk8Dq1xNSvmlrPxVPnamrcYU9nFNuIOUKwnYUejhqDbcjWwH5LhqgMrOH2uOd2bf62cMCQnTkFWt0AK5
X-Gm-Message-State: AOJu0YxDgFAl8orp6njpXYjlvor+qjDTZK01g3RKLvI5Mr58ITWBFoTQ
	6G7o0HMZT+AubVxYcLyzJszxgggFBmPSsiUp1alN2QHZxyjSQ7q+N/S4TQ7IiqGMektklN2sqnl
	tYLYtZ9V+ex4N88sDha0hiWksXH3onuzgn/E=
X-Google-Smtp-Source: AGHT+IGS6EU1fSL8CmxpiwqnpCtafSASmwHGJWBT9/VlVEzQRbwTeiNfDeG9ON5Dk9DGzzofIIqj9nBVXs0QDEIPDA4=
X-Received: by 2002:a25:14d7:0:b0:dc2:65f4:1541 with SMTP id
 206-20020a2514d7000000b00dc265f41541mr13629648ybu.41.1709805700861; Thu, 07
 Mar 2024 02:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307095318.3651498-1-rick.wertenbroek@gmail.com>
In-Reply-To: <20240307095318.3651498-1-rick.wertenbroek@gmail.com>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Thu, 7 Mar 2024 11:01:03 +0100
Message-ID: <CAAEEuhrxR14nrVqeqV_OfHjqkMaKx1S6KzcnsJqr02VUnS8oyA@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip: Fix typo in function names
To: rick.wertenbroek@heig-vd.ch
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 10:54=E2=80=AFAM Rick Wertenbroek
<rick.wertenbroek@gmail.com> wrote:
>
> Several functions had "rochchip" instead of "rockchip" in their name.
> Replace "rochchip" by "rockchip".
>
> Signed-off-By: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |  4 ++--
>  drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers=
/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 76b9cf417591..35d5c18661a3 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -245,7 +245,7 @@ static int rockchip_combphy_exit(struct phy *phy)
>         return 0;
>  }
>
> -static const struct phy_ops rochchip_combphy_ops =3D {
> +static const struct phy_ops rockchip_combphy_ops =3D {
>         .init =3D rockchip_combphy_init,
>         .exit =3D rockchip_combphy_exit,
>         .owner =3D THIS_MODULE,
> @@ -352,7 +352,7 @@ static int rockchip_combphy_probe(struct platform_dev=
ice *pdev)
>                 return ret;
>         }
>
> -       priv->phy =3D devm_phy_create(dev, NULL, &rochchip_combphy_ops);
> +       priv->phy =3D devm_phy_create(dev, NULL, &rockchip_combphy_ops);
>         if (IS_ERR(priv->phy)) {
>                 dev_err(dev, "failed to create combphy\n");
>                 return PTR_ERR(priv->phy);
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy=
/rockchip/phy-rockchip-snps-pcie3.c
> index 121e5961ce11..3cdc7625b308 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -187,7 +187,7 @@ static const struct rockchip_p3phy_ops rk3588_ops =3D=
 {
>         .phy_init =3D rockchip_p3phy_rk3588_init,
>  };
>
> -static int rochchip_p3phy_init(struct phy *phy)
> +static int rockchip_p3phy_init(struct phy *phy)
>  {
>         struct rockchip_p3phy_priv *priv =3D phy_get_drvdata(phy);
>         int ret;
> @@ -210,7 +210,7 @@ static int rochchip_p3phy_init(struct phy *phy)
>         return ret;
>  }
>
> -static int rochchip_p3phy_exit(struct phy *phy)
> +static int rockchip_p3phy_exit(struct phy *phy)
>  {
>         struct rockchip_p3phy_priv *priv =3D phy_get_drvdata(phy);
>
> @@ -219,9 +219,9 @@ static int rochchip_p3phy_exit(struct phy *phy)
>         return 0;
>  }
>
> -static const struct phy_ops rochchip_p3phy_ops =3D {
> -       .init =3D rochchip_p3phy_init,
> -       .exit =3D rochchip_p3phy_exit,
> +static const struct phy_ops rockchip_p3phy_ops =3D {
> +       .init =3D rockchip_p3phy_init,
> +       .exit =3D rockchip_p3phy_exit,
>         .set_mode =3D rockchip_p3phy_set_mode,
>         .owner =3D THIS_MODULE,
>  };
> @@ -280,7 +280,7 @@ static int rockchip_p3phy_probe(struct platform_devic=
e *pdev)
>                 return priv->num_lanes;
>         }
>
> -       priv->phy =3D devm_phy_create(dev, NULL, &rochchip_p3phy_ops);
> +       priv->phy =3D devm_phy_create(dev, NULL, &rockchip_p3phy_ops);
>         if (IS_ERR(priv->phy)) {
>                 dev_err(dev, "failed to create combphy\n");
>                 return PTR_ERR(priv->phy);
> --
> 2.25.1
>

Compiled and tested on RK3588 boards (FriendlyElec NanoPC-T6, and CM3588).
"grep -rni rochchip ." inside the kernel folder to make sure no
occurrence was missed.

Best regards,
Rick

