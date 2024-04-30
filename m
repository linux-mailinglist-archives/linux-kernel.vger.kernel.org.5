Return-Path: <linux-kernel+bounces-164478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090528B7E01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C5D2885BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A894184135;
	Tue, 30 Apr 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPhi/PZL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C91836EE;
	Tue, 30 Apr 2024 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496128; cv=none; b=LDd6TTiOJMX2dwIxljQwCgX7/jD2r+EunYJ0m58hNR91WaYP+ijhx7bUo/6PXUcdFjRgUZptQYjo4xOYnnJYLEH2G2yCFNCakbJ1Tn5vaKOscoi5fAJHsm2LANhkDcGUHgkWmm7qK/GQk0cxLMixRyQ+xF3sEA1KzoXh2R9TK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496128; c=relaxed/simple;
	bh=afEaKbtT3sTJoRjqGUMv4dNh/Opd3i+knlydOHpRElM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXlEvahINiZ+L0AtSKdvNihfBoXtU+9Cv/WKLyC0hSk15sc1Tbtpiw/v2Dm9qAdYNFciQaj973tSU9A9kIQULgA4BZaE9DXpww94ui+f5oUP3ZoUL0ciLKFqJbcOPVzgbX0g1XZ3xzua0oSBvFbxI4WfmunS3Gasm/O/d1oeRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPhi/PZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B00C2BBFC;
	Tue, 30 Apr 2024 16:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714496128;
	bh=afEaKbtT3sTJoRjqGUMv4dNh/Opd3i+knlydOHpRElM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPhi/PZLth6a7tETJJ+1u7dd7WBmJV/4L8EVw17ALRH7e0EUUEvxWtVyGsKklLnim
	 Pd/Wb6IDT2rdxIT7fXIIHs0DMQg/EV/dgbQxn63BiHJMefIlIJqvJe2DQM9sXeZP+j
	 NPPpEsmXNjkMUxzx4xuOQs+SLgPrfJZrf6eBqPsrg84SBN9HCoUpJsvq1l33UoV6/9
	 JZP42clG60jChHV5M6zLW+aep8PnvZL4hn8rAov1AAVsKIGLAxfkCIcfId4vyoYJSj
	 oT0Yq9p5CRzrXXeyhNcv+tZU934jkTvci1B+4KoSobX8MZvZLVq0fqPee9WHMao4el
	 ZnOtaZKWFlRVg==
Date: Tue, 30 Apr 2024 17:55:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew@lunn.ch, ramon.nordin.rodriguez@ferroamp.se, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <20240430-sharpie-manor-fd53df03b77d@spud>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder>
 <20240427-vaporizer-pencil-be6a25030f08@spud>
 <1ae4f1d5-140b-41b1-9191-da14fd67d409@microchip.com>
 <243dab3b-ac07-4d88-8c43-aed53a34cea9@lunn.ch>
 <bc54d514-cd93-4b12-a10a-3d613efc98a2@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="js/VJxOTZJXlYBp3"
Content-Disposition: inline
In-Reply-To: <bc54d514-cd93-4b12-a10a-3d613efc98a2@microchip.com>


--js/VJxOTZJXlYBp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 01:30:22PM +0000, Parthiban.Veerasooran@microchip.c=
om wrote:
> Hi Andrew,
>=20
> On 29/04/24 5:39 pm, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> >> Looks like, the below changes needed to work correctly,
> >>
> >> lan865x.c:
> >> - compatible string to be changed like below as it is a fallback for a=
ll
> >> variants,
> >>        .compatible =3D "microchip,lan8650"
> >> - DRV_NAME to be changed like below,
> >>        #define DRV_NAME                        "lan8650"
> >>
> >> microchip,lan865x.example.dts for lan8650:
> >> - compatible string to be changed like below,
> >>        .compatible =3D "microchip,lan8650";
> >>        OR
> >> microchip,lan865x.example.dts for lan8651:
> >> - compatible string to be changed like below,
> >>        compatible =3D "microchip,lan8651", "microchip,lan8650";
> >>
> >> I tested with the above changes and there was no issues observed. Any
> >> comments on this? Otherwise we can stick with these changes for the ne=
xt
> >> version.
> >=20
> > As Conor said, this is probably relying on the fallback
> > mechanism. Please look at other SPI devices, e.g. hwmon, and see how
> > they probe for multiple different devices.
> I just referred the below drivers for the spi devices handling along=20
> with the compatible,
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/davic=
om/dm9051.c#L1239
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/adi/a=
din1110.c#L1644
>=20
> lan8650 - MAC-PHY chip
> lan8651 - ETH Click-Mikroe with MAC-PHY chip
>=20
> So, they are different in interface but not in functionality. There is=20
> no difference in the configuration. So let's consider lan8650 is the=20
> fallback option for lan8651.
>=20
> By referring the above links, I have restructured the code like below to=
=20
> support with lan8651 fallback. Still there is no change in the existing=
=20
> device tree binding. This is the only change in lan865x.c.
>=20
> static const struct spi_device_id spidev_spi_ids[] =3D {
>          { .name =3D "lan8650" },
>          {},
> };
>=20
> static const struct of_device_id lan865x_dt_ids[] =3D {
>          { .compatible =3D "microchip,lan8650" },
>          { /* Sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
>=20
> static struct spi_driver lan865x_driver =3D {
>          .driver =3D {
>                  .name =3D DRV_NAME,
>                  .of_match_table =3D lan865x_dt_ids,
>           },
>          .probe =3D lan865x_probe,
>          .remove =3D lan865x_remove,
>          .id_table =3D spidev_spi_ids,
> };
>=20
> I also referred the below two links for the device tree binding and=20
> driver in case of fallback.

Did you also verify that the warning from the spi core is no longer
generated when using compatible =3D "microchip,lan8651", "microchip,lan8650=
"?

--js/VJxOTZJXlYBp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEieAAKCRB4tDGHoIJi
0rXJAQCg3c5KEmlcUVnAQeoyvJAbMOXTrqTIe+5HNtP5ghxVCQD9H3u3qZgPhyOU
umMo7Mi2fXou2ruId81UEDb48eDqIQ0=
=yp6N
-----END PGP SIGNATURE-----

--js/VJxOTZJXlYBp3--

