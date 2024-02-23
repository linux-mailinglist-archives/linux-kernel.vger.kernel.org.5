Return-Path: <linux-kernel+bounces-77867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C6C860B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400FD2867C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160601428B;
	Fri, 23 Feb 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AmafpoBd"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341513AED;
	Fri, 23 Feb 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673061; cv=none; b=jyxpOoc/3ZqXq9ljvU7sthr82HPRGekyvAmB7ijjnTITaJZatCqZhXm/AawIJ/8sdcT+Mfj4om8HZ+WQ72aMesD+pWS0qljrJgZIVgUzsNXU80gD1CRub/5n+aBpGZLx/6nlfCmuaUAQ9IJ9qoD+taZy6eLnpIPGL/1tLAWlGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673061; c=relaxed/simple;
	bh=Zy3SMLmt8pGMydjkzFdmM0PmQbY7r8ryjdNREVrkfl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLURg+JhvN8cMOJE3snc4HkiKPKIHAUdl8+AauHAMMoGP57TRQd25Rfcol2n9YKxSfhTYTs9ucw7x7JX4NRIz01oypR5PLiT2sXyv5Va123Kf/BCBQ0RuxfIsNxOMGqRNlii3eEk8mVlW7DlKhVQF01aoslniF/auWoWqlSltG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AmafpoBd; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N7Nx28103156;
	Fri, 23 Feb 2024 01:23:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708673039;
	bh=I15+U15s4BkbtqWCxrkPQxoGaPo/O6ZQRZby9bdA0Y0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=AmafpoBdllN0Q8OSwH3/KdTvdiXhh1AQBaTEq2+Y4VKBJ80Wr9bXVeGPuVfj0Fp0V
	 KVh2aVlJrJIuL0M4joh7HY/YPNRSIZBULmKEo7ACzLwKl0aa5MJgEsEQxHZCq6Nt+1
	 MFGvBVUklQ0qeP++oyfoCaaHDgE9O5a6eHl56HKA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N7Nxtl005480
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 01:23:59 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 01:23:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 01:23:59 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N7NwOK015497;
	Fri, 23 Feb 2024 01:23:58 -0600
Date: Fri, 23 Feb 2024 12:53:57 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Julien Massot <julien.massot@collabora.com>
CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Devarsh
 Thakkar <devarsht@ti.com>,
        Changhuang Liang
	<changhuang.liang@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Jayshri Pawar <jpawar@cadence.com>
Subject: Re: Re: [PATCH RFC 02/21] media: cadence: csi2rx: configure DPHY
 before starting source stream
Message-ID: <hwujywmmyu4fkth62dg22zq4oxsvjqjydmcjyukzejoksgdlht@tdqff4qbtbvb>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
 <20240222-multistream-v1-2-1837ed916eeb@ti.com>
 <766a4e5b-01fc-4fee-affa-9921ed7cd8f3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d42cue34zwly6f6x"
Content-Disposition: inline
In-Reply-To: <766a4e5b-01fc-4fee-affa-9921ed7cd8f3@collabora.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--d42cue34zwly6f6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Julien,

On Feb 22, 2024 at 15:29:54 +0100, Julien Massot wrote:
> Hi Jai,
>=20
> On 2/22/24 12:31, Jai Luthra wrote:
> > From: Pratyush Yadav <p.yadav@ti.com>
> >=20
> > When the source device is operating above 1.5 Gbps per lane, it needs to
> > send the Skew Calibration Sequence before sending any HS data. If the
> > DPHY is initialized after the source stream is started, then it might
> > miss the sequence and not be able to receive data properly. Move the
> > start of source subdev to the end of the sequence to make sure
> > everything is ready to receive data before the source starts streaming.
> >=20
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
>=20
> Thanks for your patch!
> This patch is useful even at lower data rate than 1.5 Gbps.
> I'm having the issue at 800Mbps with max96714F deserializer.
>=20
> Should this patch deserve a Fixes tag?

Thanks, yes in that case I will add the fixes tag and repost this fix=20
separately so it can be picked sooner.

> Fixes: 3295cf1241d3 ("media: cadence: Add support for external dphy")
>=20
> Reviewed-by: Julien Massot <julien.massot@collabora.com>
> Tested-by: Julien Massot <julien.massot@collabora.com>
>=20
> > ---
> >   drivers/media/platform/cadence/cdns-csi2rx.c | 26 ++++++++++++++-----=
-------
> >   1 file changed, 14 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/med=
ia/platform/cadence/cdns-csi2rx.c
> > index 70b7f8a9e4f2..75e602c1d762 100644
> > --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> > +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> > @@ -243,10 +243,6 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
> >   	writel(reg, csi2rx->base + CSI2RX_STATIC_CFG_REG);
> > -	ret =3D v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true=
);
> > -	if (ret)
> > -		goto err_disable_pclk;
> > -
> >   	/* Enable DPHY clk and data lanes. */
> >   	if (csi2rx->dphy) {
> >   		reg =3D CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
> > @@ -256,6 +252,13 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
> >   		}
> >   		writel(reg, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> > +
> > +		ret =3D csi2rx_configure_ext_dphy(csi2rx);
> > +		if (ret) {
> > +			dev_err(csi2rx->dev,
> > +				"Failed to configure external DPHY: %d\n", ret);
> > +			goto err_disable_pclk;
> > +		}
> >   	}
> >   	/*
> > @@ -295,14 +298,9 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
> >   	reset_control_deassert(csi2rx->sys_rst);
> > -	if (csi2rx->dphy) {
> > -		ret =3D csi2rx_configure_ext_dphy(csi2rx);
> > -		if (ret) {
> > -			dev_err(csi2rx->dev,
> > -				"Failed to configure external DPHY: %d\n", ret);
> > -			goto err_disable_sysclk;
> > -		}
> > -	}
> > +	ret =3D v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true=
);
> > +	if (ret)
> > +		goto err_disable_sysclk;
> >   	clk_disable_unprepare(csi2rx->p_clk);
> > @@ -316,6 +314,10 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
> >   		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
> >   	}
> > +	if (csi2rx->dphy) {
> > +		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> > +		phy_power_off(csi2rx->dphy);
> > +	}
> >   err_disable_pclk:
> >   	clk_disable_unprepare(csi2rx->p_clk);
> >=20
>=20
> --=20
> Julien Massot
> Senior Software Engineer
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--d42cue34zwly6f6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXYSAoACgkQQ96R+SSa
cUW0aQ/7Bjl7xgSgf4s0ztLi8Hz5vnH1BhLHwToMWRNFv0UqGTTL+4+QuhwLN+HM
eAGC85SaEEKf2N/rqt8uK0t1VNDjXkGlgBKKO+4LkCAxecmccuzf8ugAzc/MOMDl
d6CC1gdocGLGFth3zIifarTsKHDoFqB7b0ySUNn/GU/Qk6ixmz8Ye36iALzNVMIy
sYrBbuiA8fSQ8HAAz6MtEVBUoifQpHr6B5/+rtu/tlnYMHP4aGyDbsAIwYhEqWrS
Zyy+/kyps8RX9Hs6ynRcq2ppwbOD80INjiTSublrMy/sz9GV5lKnM5VmWnuFiK8u
YEYtBO32j2y4LeqKq2UhbTyvKghMk4qKzP9KNK7WbvD5p0kUXDk60Y9/6m1Anird
GbpqZWCOLUqQ8oLotEbjYUygSr0EjXac3OWpMQEivgM1PJLCbroS7y+G6oNMZWKt
gkFXAQWcoTjKVoHD3NDfktrgbiboPJ/gPHk5i5KDXPuGutRtdRfj83VwhoJsJONR
j2vKUG7Um2lb/LmJlXIjOIlvu279tfQptkjeW8JsTdUYRXFH+sRv05aEKBazaOz7
/CI4AbgOf3TLRtqsWQ+Dne7o8zgEtihxIedWfhD4LPtKF+WSRqYXBpCS9K/7vxT1
oQm8rnNEdHdgaFmFsbFMpxeLjXjDgfUOfeQz+ywrBf37cecpUUg=
=X4cL
-----END PGP SIGNATURE-----

--d42cue34zwly6f6x--

