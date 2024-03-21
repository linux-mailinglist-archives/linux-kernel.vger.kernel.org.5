Return-Path: <linux-kernel+bounces-109827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6403A88562D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3E31C21079
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF808383B5;
	Thu, 21 Mar 2024 09:05:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C05446DD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011926; cv=none; b=mg2+GKqAfIFBZOpTeLiJqAVnrX1p30V+3tfcq0+IMK3+ODOe6QSMiA6MBwWYY1wzW0oTOqpWdUpC/dEYSTw1WTCr4esbPYouSJRRQw4yGKgCcbTtlKryjFOSL3duJjZpw2b/zYAq57Bu5+OYPNh5/Bc3LHMaQF0o76K0u+f9bKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011926; c=relaxed/simple;
	bh=9IyX9VQ0UZOYUm24nSmmirQeHR+zSjf33d/U4cQ9MiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD9xpdAfYfPjVKU+2cW1R2nRZLqOOcwPzi500R/OBk4UDJx8B+LHUZRPOXdrpXbUuQ+uuMcSPeCrKNao/8c5WfGRMAmRQugKMBVWEN79jjWq3UABwX65B8TaKHVuH5NPna1+5DdbTBRdG6K+6XOSv9+AckI50osKw47EJvDtz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rnEM3-0003TV-Nk; Thu, 21 Mar 2024 10:04:55 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rnEM2-007cVx-T9; Thu, 21 Mar 2024 10:04:54 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 760542A8A7F;
	Thu, 21 Mar 2024 09:04:54 +0000 (UTC)
Date: Thu, 21 Mar 2024 10:04:53 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: imx: imx8mp: Add pm_runtime support for power
 saving
Message-ID: <20240321-apply-swore-f9c17ad3a8d2-mkl@pengutronix.de>
References: <1711010211-6825-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7z4esfqbug4ywn5r"
Content-Disposition: inline
In-Reply-To: <1711010211-6825-1-git-send-email-shengjiu.wang@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--7z4esfqbug4ywn5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.03.2024 16:36:51, Shengjiu Wang wrote:
> Add pm_runtime support for power saving. In pm runtime suspend
> state the registers will be reseted, so add registers save
> in pm runtime suspend and restore them in pm runtime resume.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
> changes in v3:
> - remove REGS_NUM, use the ARRAY_SIZE
> - merge clk_imx8mp_audiomix_drvdata and clk_hw_onecell_data together.

Look way nicer, but still room for improvement.

> changes in v2:
> - move pm_runtime_enable before the clk register
>=20
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 157 ++++++++++++++++++++++----
>  1 file changed, 136 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-=
imx8mp-audiomix.c
> index 55ed211a5e0b..5ae33bce8ad8 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -7,10 +7,12 @@
> =20
>  #include <linux/clk-provider.h>
>  #include <linux/device.h>
> +#include <linux/io.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> =20
>  #include <dt-bindings/clock/imx8mp-clock.h>
> =20
> @@ -18,6 +20,7 @@
> =20
>  #define CLKEN0			0x000
>  #define CLKEN1			0x004
> +#define EARC			0x200
>  #define SAI1_MCLK_SEL		0x300
>  #define SAI2_MCLK_SEL		0x304
>  #define SAI3_MCLK_SEL		0x308
> @@ -26,6 +29,11 @@
>  #define SAI7_MCLK_SEL		0x314
>  #define PDM_SEL			0x318
>  #define SAI_PLL_GNRL_CTL	0x400
> +#define SAI_PLL_FDIVL_CTL0	0x404
> +#define SAI_PLL_FDIVL_CTL1	0x408
> +#define SAI_PLL_SSCG_CTL	0x40C
> +#define SAI_PLL_MNIT_CTL	0x410
> +#define IPG_LP_CTRL		0x504
> =20
>  #define SAIn_MCLK1_PARENT(n)						\
>  static const struct clk_parent_data					\
> @@ -182,26 +190,82 @@ static struct clk_imx8mp_audiomix_sel sels[] =3D {
>  	CLK_SAIn(7)
>  };
> =20
> +static const u16 audiomix_regs[] =3D {
> +	CLKEN0,
> +	CLKEN1,
> +	EARC,
> +	SAI1_MCLK_SEL,
> +	SAI2_MCLK_SEL,
> +	SAI3_MCLK_SEL,
> +	SAI5_MCLK_SEL,
> +	SAI6_MCLK_SEL,
> +	SAI7_MCLK_SEL,
> +	PDM_SEL,
> +	SAI_PLL_GNRL_CTL,
> +	SAI_PLL_FDIVL_CTL0,
> +	SAI_PLL_FDIVL_CTL1,
> +	SAI_PLL_SSCG_CTL,
> +	SAI_PLL_MNIT_CTL,
> +	IPG_LP_CTRL,
> +};
> +
> +struct clk_imx8mp_audiomix_priv {
> +	void __iomem *base;
> +	struct clk_hw_onecell_data *clk_hw_data;
> +	u32 regs_save[ARRAY_SIZE(audiomix_regs)];

Put the "struct clk_hw_onecell_data clk_hw_data" at the end of the
struct. Then allocating should be easier and you don't need the
additional pointer.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7z4esfqbug4ywn5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmX7+DMACgkQKDiiPnot
vG8IVQf2O5/UkwGcC3bi6XlI+KC+dh+zm8EbiuYW62sdysCPOWaJiETytc186x/E
YaABZOfWMeH+liQM/GCMIumSeixIEd4o3fY56edmW24lE3oUtEnDTsdEDLchMaOe
5aLweRpoVbwlKyx17z0cB+ct64AvfsUP/F67kJLikpS/S5WNtpR9kupkLDypZ5Zt
yXVwKsRHt095Krn2lHlaRBKV96cbwCmPQN+FWLhwjkUsUAlHyHoc9jHIfRN7cATQ
hyMaJr/WOFfA58JQOUelntlnEp8Td/c+IwSHadD+aHOUUQ4jnW2jNuhx2dZh1jUS
Kptm9jdx4XpV94CGDj5lFQLlUttl
=tk43
-----END PGP SIGNATURE-----

--7z4esfqbug4ywn5r--

