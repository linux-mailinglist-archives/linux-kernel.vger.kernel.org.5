Return-Path: <linux-kernel+bounces-108714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98AF880F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F398283AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119DD3BB48;
	Wed, 20 Mar 2024 09:50:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9FB3BB29
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928238; cv=none; b=DYx6BhOCJZzujPUvfQdRV2O5ZSXGAleJrm533dT7Gx4aicJ8ugG602/BSQyMgoqkbAf0PlbRTmOCUcbsfsYz5VE+9ndSmVLP9Xk+NLZSFCKgD81ddUuFS7PQgks0NC1GAomVLiz6tuDtlJfeVrAmISOja+Rh912QTbqO7gyTsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928238; c=relaxed/simple;
	bh=wHg5Tp79tcyRD1xov2jjLRvQ7Y30WT+/wgl0YB86ngo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3VKMpW0vMlXeQYIUlhdnxcX3BQzm8hYiKuBGCSuGwp7TaVDyiNrIvRFsR4Nqs0zBs8avogWIpv1iyf/qVqlDjash2Jjd59e6h6aq5JeVR+jJjt1jsbCwYvZI/o9wUHFLp4Gh3hlYah9wqzY90O2jU8976J+dd35NDRAzAvA8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rmsaM-0007mr-HP; Wed, 20 Mar 2024 10:50:14 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rmsaL-007RNZ-Sm; Wed, 20 Mar 2024 10:50:13 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 742742A816C;
	Wed, 20 Mar 2024 09:50:13 +0000 (UTC)
Date: Wed, 20 Mar 2024 10:50:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: imx: imx8mp: Add pm_runtime support for power
 saving
Message-ID: <20240320-posing-quit-ab4b13557cc9-mkl@pengutronix.de>
References: <1710925851-5643-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dg7lsu7kl5krtzdz"
Content-Disposition: inline
In-Reply-To: <1710925851-5643-1-git-send-email-shengjiu.wang@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--dg7lsu7kl5krtzdz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.03.2024 17:10:51, Shengjiu Wang wrote:
> Add pm_runtime support for power saving. In pm runtime suspend
> state the registers will be reseted, so add registers save
> in pm runtime suspend and restore them in pm runtime resume.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
> changes in v2:
> - move pm_runtime_enable before the clk register
>=20
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 150 +++++++++++++++++++++++---
>  1 file changed, 137 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-=
imx8mp-audiomix.c
> index 55ed211a5e0b..6042280d6404 100644
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
> @@ -26,6 +29,12 @@
>  #define SAI7_MCLK_SEL		0x314
>  #define PDM_SEL			0x318
>  #define SAI_PLL_GNRL_CTL	0x400
> +#define SAI_PLL_FDIVL_CTL0	0x404
> +#define SAI_PLL_FDIVL_CTL1	0x408
> +#define SAI_PLL_SSCG_CTL	0x40C
> +#define SAI_PLL_MNIT_CTL	0x410
> +#define IPG_LP_CTRL		0x504
> +#define REGS_NUM		16

not needed

> =20
>  #define SAIn_MCLK1_PARENT(n)						\
>  static const struct clk_parent_data					\
> @@ -182,13 +191,65 @@ static struct clk_imx8mp_audiomix_sel sels[] =3D {
>  	CLK_SAIn(7)
>  };
> =20
> +struct clk_imx8mp_audiomix_regs {
> +	u32 regs_num;
> +	u32 regs_off[];

nitpick: if the offsets fit into an u16 you can save some space.

> +};
> +
> +static const struct clk_imx8mp_audiomix_regs audiomix_regs =3D {
> +	.regs_num =3D REGS_NUM,
> +	.regs_off =3D {
> +		CLKEN0,
> +		CLKEN1,
> +		EARC,
> +		SAI1_MCLK_SEL,
> +		SAI2_MCLK_SEL,
> +		SAI3_MCLK_SEL,
> +		SAI5_MCLK_SEL,
> +		SAI6_MCLK_SEL,
> +		SAI7_MCLK_SEL,
> +		PDM_SEL,
> +		SAI_PLL_GNRL_CTL,
> +		SAI_PLL_FDIVL_CTL0,
> +		SAI_PLL_FDIVL_CTL1,
> +		SAI_PLL_SSCG_CTL,
> +		SAI_PLL_MNIT_CTL,
> +		IPG_LP_CTRL
> +	},
> +};

You only need an array with the offsets, use ARRAY_SIZE() to get the
number of entries in the array.

> +
> +struct clk_imx8mp_audiomix_drvdata {
> +	void __iomem *base;
> +	u32 regs_save[REGS_NUM];

make use of ARRAY_SIZE() here

> +};
> +
> +static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool sa=
ve)
> +{
> +	struct clk_imx8mp_audiomix_drvdata *drvdata =3D dev_get_drvdata(dev);
> +	void __iomem *base =3D drvdata->base;
> +	int i;
> +
> +	if (save) {
> +		for (i =3D 0; i < audiomix_regs.regs_num; i++)
> +			drvdata->regs_save[i] =3D readl(base + audiomix_regs.regs_off[i]);
> +	} else {
> +		for (i =3D 0; i < audiomix_regs.regs_num; i++)
> +			writel(drvdata->regs_save[i], base + audiomix_regs.regs_off[i]);
> +	}
> +}
> +
>  static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
>  {
> +	struct clk_imx8mp_audiomix_drvdata *drvdata;
>  	struct clk_hw_onecell_data *priv;
>  	struct device *dev =3D &pdev->dev;
>  	void __iomem *base;
>  	struct clk_hw *hw;
> -	int i;
> +	int i, ret;
> +
> +	drvdata =3D devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);

You already allocate memory with devm_kzalloc() below. Why not increase
the size?

Rename clk_imx8mp_audiomix_drvdata to clk_imx8mp_audiomix_priv
and add struct clk_hw_onecell_data to it.

> +	if (!drvdata)
> +		return -ENOMEM;
> =20
>  	priv =3D devm_kzalloc(dev,
>  			    struct_size(priv, hws, IMX8MP_CLK_AUDIOMIX_END),
> @@ -202,6 +263,18 @@ static int clk_imx8mp_audiomix_probe(struct platform=
_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> =20
> +	drvdata->base =3D base;
> +	dev_set_drvdata(dev, drvdata);
> +
> +	/*
> +	 * pm_runtime_enable needs to be called before clk register.
> +	 * That is to make core->rpm_enabled to be true for clock
> +	 * usage.
> +	 */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(sels); i++) {
>  		if (sels[i].num_parents =3D=3D 1) {
>  			hw =3D devm_clk_hw_register_gate_parent_data(dev,
> @@ -216,8 +289,10 @@ static int clk_imx8mp_audiomix_probe(struct platform=
_device *pdev)
>  				0, NULL, NULL);
>  		}
> =20
> -		if (IS_ERR(hw))
> -			return PTR_ERR(hw);
> +		if (IS_ERR(hw)) {
> +			ret =3D PTR_ERR(hw);
> +			goto err_clk_register;
> +		}
> =20
>  		priv->hws[sels[i].clkid] =3D hw;
>  	}
> @@ -232,8 +307,10 @@ static int clk_imx8mp_audiomix_probe(struct platform=
_device *pdev)
> =20
>  	hw =3D imx_dev_clk_hw_pll14xx(dev, "sai_pll", "sai_pll_ref_sel",
>  				    base + 0x400, &imx_1443x_pll);
> -	if (IS_ERR(hw))
> -		return PTR_ERR(hw);
> +	if (IS_ERR(hw)) {
> +		ret =3D PTR_ERR(hw);
> +		goto err_clk_register;
> +	}
>  	priv->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL] =3D hw;
> =20
>  	hw =3D devm_clk_hw_register_mux_parent_data_table(dev,
> @@ -241,26 +318,71 @@ static int clk_imx8mp_audiomix_probe(struct platfor=
m_device *pdev)
>  		ARRAY_SIZE(clk_imx8mp_audiomix_pll_bypass_sels),
>  		CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>  		base + SAI_PLL_GNRL_CTL, 16, 1, 0, NULL, NULL);
> -	if (IS_ERR(hw))
> -		return PTR_ERR(hw);
> +	if (IS_ERR(hw)) {
> +		ret =3D PTR_ERR(hw);
> +		goto err_clk_register;
> +	}
> +
>  	priv->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS] =3D hw;
> =20
>  	hw =3D devm_clk_hw_register_gate(dev, "sai_pll_out", "sai_pll_bypass",
>  				       0, base + SAI_PLL_GNRL_CTL, 13,
>  				       0, NULL);
> -	if (IS_ERR(hw))
> -		return PTR_ERR(hw);
> +	if (IS_ERR(hw)) {
> +		ret =3D PTR_ERR(hw);
> +		goto err_clk_register;
> +	}
>  	priv->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_OUT] =3D hw;
> =20
>  	hw =3D devm_clk_hw_register_fixed_factor(dev, "sai_pll_out_div2",
>  					       "sai_pll_out", 0, 1, 2);
> -	if (IS_ERR(hw))
> -		return PTR_ERR(hw);
> +	if (IS_ERR(hw)) {
> +		ret =3D PTR_ERR(hw);
> +		goto err_clk_register;
> +	}
> +
> +	ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
> +					  priv);
> +	if (ret)
> +		goto err_clk_register;
> +
> +	pm_runtime_put_sync(dev);
> +	return 0;
> +
> +err_clk_register:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	return ret;
> +}
> +
> +static int clk_imx8mp_audiomix_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> =20
> -	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
> -					   priv);
> +	return 0;
>  }
> =20
> +static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
> +{
> +	clk_imx8mp_audiomix_save_restore(dev, true);
> +
> +	return 0;
> +}
> +
> +static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
> +{
> +	clk_imx8mp_audiomix_save_restore(dev, false);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops clk_imx8mp_audiomix_pm_ops =3D {
> +	SET_RUNTIME_PM_OPS(clk_imx8mp_audiomix_runtime_suspend,
> +			   clk_imx8mp_audiomix_runtime_resume, NULL)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				      pm_runtime_force_resume)
> +};
> +
>  static const struct of_device_id clk_imx8mp_audiomix_of_match[] =3D {
>  	{ .compatible =3D "fsl,imx8mp-audio-blk-ctrl" },
>  	{ /* sentinel */ }
> @@ -269,9 +391,11 @@ MODULE_DEVICE_TABLE(of, clk_imx8mp_audiomix_of_match=
);
> =20
>  static struct platform_driver clk_imx8mp_audiomix_driver =3D {
>  	.probe	=3D clk_imx8mp_audiomix_probe,
> +	.remove =3D clk_imx8mp_audiomix_remove,
>  	.driver =3D {
>  		.name =3D "imx8mp-audio-blk-ctrl",
>  		.of_match_table =3D clk_imx8mp_audiomix_of_match,
> +		.pm =3D &clk_imx8mp_audiomix_pm_ops,
>  	},
>  };
> =20
> --=20
> 2.34.1
>=20
>=20
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dg7lsu7kl5krtzdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmX6sVIACgkQKDiiPnot
vG+C8wf/Xah1rNxEXUwiw6io34xu8AlN0etcD73JWODKbWXBfVpcDxIVY4HHlJbO
GNSFXuBSDHyPHpvZLyM+Lbn8tiTPsltO4X5lKuDJyTI/JYouu0FWky53nAbcoWVM
LEZVVuBhX23C0BMdmFJGI538WU/D4eZZh+K+S7E7JNWBVyFBaUWctubU1dQHm0pz
8+mga/ozfesW8ZytpthSt1OAUe/kWx9lE+aUffKg5CB692SFQ7vuWlLDUh8x6G+E
V62rg5xWbeMSJgeG/167SqNDvvXtc/RpW3ku++mQgUDe2nkG3eKaej+2ZuyyV9EQ
bNKl3xa7GBR3C00zDDruxyb080UjbA==
=g8lf
-----END PGP SIGNATURE-----

--dg7lsu7kl5krtzdz--

