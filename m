Return-Path: <linux-kernel+bounces-31612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE18330DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97031C21864
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A01C58AA4;
	Fri, 19 Jan 2024 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5I8brMRs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3610A56456;
	Fri, 19 Jan 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704444; cv=none; b=rJk1UiaJEWBtDj9cEw0tf/ciOx7qiymHFHqa6WS37rHGEINb4HKDuUJ6uDQPnq04koYbFlSTHfOsmkzqH78fUkbMqqhbh5mbSbBZfLWExJpidy48gtQnsUT8eAluuwm7KwUoGh/XJAHT+Rl9W30ofGcAn5Sv1vfZGMhFd9n8gdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704444; c=relaxed/simple;
	bh=VjppsFpbyCWxgORJcPpUoA4qYbTq4NNlOZd+L1VwhMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM9XZilf5ZJfzg/slvOPkVBjcV6AyIqubk2cHjMGr6eKxXfhomtIGMfsWl1U55Odf6OU6W3WdohdKx3jNbel92aqcT7xCygs0SsT4LJ62eE9v4CPCjKhceb6b8FhMnaePtkVlXm6zxbHy8mLGUm/all6n9CoBEJIVYgl5s3SXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5I8brMRs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705704438;
	bh=VjppsFpbyCWxgORJcPpUoA4qYbTq4NNlOZd+L1VwhMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5I8brMRsyz14hP+kX8WRzO8EbIC5sNnul5fNCCC0rUXq6NdphWWXy4m28JaUND2sR
	 XeK/RCtp/nJn5FdwzHYqBT8bdDZtaAGagm1r2Sxv0qJuMOhks7Q+zGvU0+FPTwPxfJ
	 6res/AScL1rWZMnoyneFaD1DswIJfvtN2wlZVFGFh8roBcPB3rIRV84H7UoulIzpwB
	 9qgweRcUDOohiNPOppHAaje9XVZIoTM0qiC+CT3i+SjnW5pPKfBIlo0eSXVBtqq4Ek
	 tIUDD/BvzJEzzqY9TbKs871vMvLc0vFV8wstEPdcSxOqtox0qWhZHYEC9hIrVq8CQk
	 BhsPshCEW5RAg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BEE4A37813C4;
	Fri, 19 Jan 2024 22:47:18 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 2FE2510609DF; Fri, 19 Jan 2024 23:47:18 +0100 (CET)
Date: Fri, 19 Jan 2024 23:47:18 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Johan Jonker <jbx6244@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 3/3] phy: rockchip: Add Samsung HDMI/DP Combo PHY driver
Message-ID: <eodlujrytdm6gugcbaz3efnjvgg7sbvsqedwllmleh4ar6e7cr@3ejicokdjzcd>
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
 <20240119193806.1030214-4-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h4tpubuhecincak7"
Content-Disposition: inline
In-Reply-To: <20240119193806.1030214-4-cristian.ciocaltea@collabora.com>


--h4tpubuhecincak7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Cristian,

On Fri, Jan 19, 2024 at 09:38:03PM +0200, Cristian Ciocaltea wrote:
> Add driver for the Rockchip HDMI/eDP TX Combo PHY found on RK3588 SoC.
>=20
> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
> and eDP links.  The maximum data rate is 12Gbps (HDMI 2.1 FRL), while
> the minimum is 250Mbps (HDMI 2.1 TMDS).
>=20
> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

The driver has multiple sequences looking like this (this is just one
example of many):

> +	hdptx_write(hdptx, CMN_REG0087, 0x04);
> +	hdptx_write(hdptx, CMN_REG0089, 0x00);
> +	hdptx_write(hdptx, CMN_REG008A, 0x55);
> +	hdptx_write(hdptx, CMN_REG008B, 0x25);
> +	hdptx_write(hdptx, CMN_REG008C, 0x2c);
> +	hdptx_write(hdptx, CMN_REG008D, 0x22);
> +	hdptx_write(hdptx, CMN_REG008E, 0x14);
> +	hdptx_write(hdptx, CMN_REG008F, 0x20);
> +	hdptx_write(hdptx, CMN_REG0090, 0x00);
> +	hdptx_write(hdptx, CMN_REG0091, 0x00);
> +	hdptx_write(hdptx, CMN_REG0092, 0x00);
> +	hdptx_write(hdptx, CMN_REG0093, 0x00);
> +	hdptx_write(hdptx, CMN_REG0095, 0x00);
> +	hdptx_write(hdptx, CMN_REG0097, 0x02);
> +	hdptx_write(hdptx, CMN_REG0099, 0x04);
> +	hdptx_write(hdptx, CMN_REG009A, 0x11);
> +	hdptx_write(hdptx, CMN_REG009B, 0x00);

Instead of the repetitive calls to regmap_write, it's better to do
it like this:

static const struct reg_sequence some_init_seq[] =3D {
	REG_SEQ0(CMN_REG0087, 0x04),
	REG_SEQ0(CMN_REG0089, 0x00),
	REG_SEQ0(CMN_REG008A, 0x55),
	REG_SEQ0(CMN_REG008B, 0x25),
	REG_SEQ0(CMN_REG008C, 0x2c),
	REG_SEQ0(CMN_REG008D, 0x22),
	REG_SEQ0(CMN_REG008E, 0x14),
	REG_SEQ0(CMN_REG008F, 0x20),
	REG_SEQ0(CMN_REG0090, 0x00),
	REG_SEQ0(CMN_REG0091, 0x00),
	REG_SEQ0(CMN_REG0092, 0x00),
	REG_SEQ0(CMN_REG0093, 0x00),
	REG_SEQ0(CMN_REG0095, 0x00),
	REG_SEQ0(CMN_REG0097, 0x02),
	REG_SEQ0(CMN_REG0099, 0x04),
	REG_SEQ0(CMN_REG009A, 0x11),
	REG_SEQ0(CMN_REG009B, 0x00),
};

regmap_multi_reg_write(hdptx->regmap, some_init_seq, ARRAY_SIZE(some_init_s=
eq));

> +static const struct of_device_id rockchip_hdptx_phy_of_match[] =3D {
> +	{ .compatible =3D "rockchip,rk3588-hdptx-phy", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_hdptx_phy_of_match);
> +
> +static struct platform_driver rockchip_hdptx_phy_driver =3D {
> +	.probe  =3D rockchip_hdptx_phy_probe,
> +	.driver =3D {
> +		.name =3D "rockchip-hdptx-phy",
> +		.pm =3D &rockchip_hdptx_phy_pm_ops,
> +		.of_match_table =3D of_match_ptr(rockchip_hdptx_phy_of_match),

Remove of_match_ptr(). It's a nop, since the driver depends on OF.

Greetings,

-- Sebastian

--h4tpubuhecincak7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmWq++sACgkQ2O7X88g7
+pod7w//ThYbzmy1lztKq6Q/lBLNvHn771BBP8vGzErGsecU6e8sAv4yc8kjOk1X
Tj3MAlMP9jrl35kNCouj55qupzaaUO4+kWxKWGSB9M0J2uwPPlnxWBghYrvlLqpU
OpqdyhA2lY27WXb4opiG5WlO4fCka2gPvCmVaEgsRBzvGm8pE5XAEh6wFKyu1nQb
3rKNhUxDyvE6xsEub1qA6EU4LUz+L5MgnewjZgUo9tXQ8sXZtCnzmio89mjKXxqy
YZRJJeeMQo2lRD9CSMrrunqRMxfr++EAVfNabqjl6LeCj2LYUyquBVLrl5UWEgyl
U0I1OanUHZf6bnSxjq4MWQXzsvGJFT8u0WaBExHeFMmiza1u9UOw/OojOsiYgipy
82ZjkGUwrRRPFG9MR4gnFOAj6QRVcmGiuWcTpN7btyzYxkJok5mC3EJApnEhuSpQ
q/3/RJ/twqXnmXM0sBVk83SFak8A7JkqIQvpLdAYmpykyzp6jB03CpXsE+LCBQD1
BgHgTPwwYmd7cQPJO2hjMPYkxXDYYbPHCw+83UHmcDrA/AKO0cv75Y1Rvdtb/AxR
8W3h5yOHNL3azY7kwDuVyCBaozX5e0+cyMeDSmj3BA6QsygUKvij7oo4GGX1lH+w
AHedQgPgS8/v36Fe80myNNj/9bq691npdqKlsVJXXRIMI8mFL+w=
=833U
-----END PGP SIGNATURE-----

--h4tpubuhecincak7--

