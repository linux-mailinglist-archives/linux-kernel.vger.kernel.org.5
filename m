Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED17A0897
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbjINPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240750AbjINPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:07:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCDCA8;
        Thu, 14 Sep 2023 08:07:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a9cd066db5so154461066b.0;
        Thu, 14 Sep 2023 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694704063; x=1695308863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP69ASklQ06fWDPpKcoFyGEzOk0jQ6Af8rMe5+oydWg=;
        b=FNJeRbjpDliBBDgRSiMzFFYlWhM5A0ycHnsD5KmeimjX8KVAhUTrjeAUSv7SWtz871
         zsO00MdLwMb5kx5xvYEx18fHyc+akbdvOmavki87V7F4O3Gef/zzDg1IQh6VmcLDOzTB
         Hj+cz521+TcZ+FX43Q6Hy7T9f3DxKFnVnhEIGcnckpJGHyoQxSdeh1tEpqwGsHFxofL/
         OpxMzG8gYb+qyWNu+JkbQhAlXrxWR0VK3RtW35zBuYjXSwJ66tT4riQhAAKeoM2cBv4n
         6P4MwTXlt/v7N2zUhmtlHfy6zO5GEXTPeAt3GUcBLPYBtvSLkuiG8/Tnd8lnh13zhCtO
         xdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704063; x=1695308863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP69ASklQ06fWDPpKcoFyGEzOk0jQ6Af8rMe5+oydWg=;
        b=DhgbNpHQi8VaPcFLrx3MvSlOi0PX/BOC9MMn6f5MpFEaXliDsm9UQFpCgQ/PP3gyzy
         VtmmTxnREl3dCUYZtPYWoZwUwlPyvVdvCem3fygCVVtqJ/LF5M2xWNHucr02NjeEAr3h
         ezNbvExIP37qqafmO40NNFAElaItMX9jIAF+L9/iJ6y7sQm4o6dh5ly1hKFGNB6m2dfN
         lY80XGZo7ghxqjFnlDnOxYmdHoDxu7IaElUbMZpNqKO4TIWYDayZeGPqodXAdFbQ5P+/
         EmkI/BLUsjqAQcpGD9EVCGlp5IptLo5ypFYQdLxeuQ612VX9K+RDMzeK580rEftBAd6F
         CevA==
X-Gm-Message-State: AOJu0YweSY8mJv3xJN+Gh2iXDKUlg/O564UV0iRN26qEWD2l86yvot2g
        UzvLQkykY2+R6JyhpRrrVAA=
X-Google-Smtp-Source: AGHT+IG8KP3B9bjG4pI05wOHvPQCGugo4l8D48ar7CYi3L5ylg3/8JmO5GnaECy6z/Cpdjkqmo6/yw==
X-Received: by 2002:a17:906:2102:b0:99d:ed5e:cc79 with SMTP id 2-20020a170906210200b0099ded5ecc79mr4916268ejt.31.1694704062506;
        Thu, 14 Sep 2023 08:07:42 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906114d00b00992afee724bsm1117405eja.76.2023.09.14.08.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:07:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 14/17] pmdomain: sunxi: Move Kconfig option to the pmdomain
 subsystem
Date:   Thu, 14 Sep 2023 17:07:39 +0200
Message-ID: <2696832.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230914111912.586764-1-ulf.hansson@linaro.org>
References: <20230914111912.586764-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 14. september 2023 ob 13:19:12 CEST je Ulf Hansson napisa=
l(a):
> The Kconfig option belongs closer to the corresponding implementation,
> hence let's move it from the soc subsystem to the pmdomain subsystem.
>=20
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: <linux-sunxi@lists.linux.dev>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/pmdomain/Kconfig       |  1 +
>  drivers/pmdomain/sunxi/Kconfig | 10 ++++++++++
>  drivers/soc/sunxi/Kconfig      |  9 ---------
>  3 files changed, 11 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/pmdomain/sunxi/Kconfig
>=20
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 67049ebf7265..39f358f27f2e 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -13,5 +13,6 @@ source "drivers/pmdomain/rockchip/Kconfig"
>  source "drivers/pmdomain/samsung/Kconfig"
>  source "drivers/pmdomain/st/Kconfig"
>  source "drivers/pmdomain/starfive/Kconfig"
> +source "drivers/pmdomain/sunxi/Kconfig"
>=20
>  endmenu
> diff --git a/drivers/pmdomain/sunxi/Kconfig b/drivers/pmdomain/sunxi/Kcon=
fig
> new file mode 100644
> index 000000000000..17781bf8d86d
> --- /dev/null
> +++ b/drivers/pmdomain/sunxi/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config SUN20I_PPU
> +	bool "Allwinner D1 PPU power domain driver"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on PM
> +	select PM_GENERIC_DOMAINS
> +	help
> +	  Say y to enable the PPU power domain driver. This saves power
> +	  when certain peripherals, such as the video engine, are idle.
> diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
> index c5070914fc6a..8aecbc9b1976 100644
> --- a/drivers/soc/sunxi/Kconfig
> +++ b/drivers/soc/sunxi/Kconfig
> @@ -19,12 +19,3 @@ config SUNXI_SRAM
>  	  Say y here to enable the SRAM controller support. This
>  	  device is responsible on mapping the SRAM in the sunXi SoCs
>  	  whether to the CPU/DMA, or to the devices.
> -
> -config SUN20I_PPU
> -	bool "Allwinner D1 PPU power domain driver"
> -	depends on ARCH_SUNXI || COMPILE_TEST
> -	depends on PM
> -	select PM_GENERIC_DOMAINS
> -	help
> -	  Say y to enable the PPU power domain driver. This saves power
> -	  when certain peripherals, such as the video engine, are idle.




