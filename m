Return-Path: <linux-kernel+bounces-94454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61001874011
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBF5282389
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EBE13E7F5;
	Wed,  6 Mar 2024 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6MCOKtM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957513DBB7;
	Wed,  6 Mar 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751673; cv=none; b=hrXPX/8WzmXZ0NM/61A4IE/BR6T8fwbx5miF8YBCEfToDge87SBQxeO9tzNnxs/OD1eXIgLlHsIlFyOkvFy+tOyQFrRrSO+CEMnsBsOaJKdul6LNsSNllYD0dANK1047t8edoVMWUb8sHGVrkQCoYNa5C7ZH/kst98sMxnkAnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751673; c=relaxed/simple;
	bh=3odgSEutskxjlCVQ+GErJHuBC9au4O5jwj/6YLzNhiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhA3tCB7LS31R2UxePs0L8jBuhkYDEUP9tdu3v2LU2kfobQlNKgv8XKtc7GWlScWaCNLHIJOymN/jziNtbBAfIa2CzTCS8qxLFeerToYlEj/b7C5T0T5a3yYqCysfP/iGglC19pHn1k8F2s+t00GHpiJx/ub7vGX7lHnKisc8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6MCOKtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B85C433F1;
	Wed,  6 Mar 2024 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709751672;
	bh=3odgSEutskxjlCVQ+GErJHuBC9au4O5jwj/6YLzNhiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6MCOKtMM0vj01yqO81QJq0phuhXPFCPAFMezBGz1AsFH7U5FAwbu1gzQTijn15XP
	 BAO50kTcUeHjV0F0XgbMjf1kvGULg1h0QYVYXK67LbLMEKHoenO0R8VzZGFWWbcTMR
	 yE/R+h5ruuUQNG6Y3WqITx0OZGNPL3Y5MFosHDUWBPruBeawpfXELkMS6HhOauir0P
	 RXqh44tDiD9iABeRYXTof5ZkK+WfeGkIMinICDcTqTG3auv98IXUY5GPWWhkkDISaA
	 nWHkKWMV+ViZ8JW3GCrbcbCgBAo5EO8f9RCpFmjeZ/WA1ulXQXVeIRUDbzIBU6Lx9M
	 4bVGYVUMfKgAg==
Date: Wed, 6 Mar 2024 19:01:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Message-ID: <20240306-ripeness-dimple-e360a031ccde@spud>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
 <20240306-spree-islamist-957acf0ee368@spud>
 <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mIS2Ako9u5OaxKJQ"
Content-Disposition: inline
In-Reply-To: <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>


--mIS2Ako9u5OaxKJQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 07:48:57PM +0100, Andrew Lunn wrote:
> > > +description:
> > > +  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethe=
rnet
> > > +  PHY to enable 10BASE=E2=80=91T1S networks. The Ethernet Media Acce=
ss Controller
> > > +  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compat=
ible
> > > +  with the IEEE 802.3 standard and a 10BASE-T1S physical layer trans=
ceiver
> > > +  integrated into the LAN8650/1. The communication between the Host =
and
> > > +  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Se=
rial
> > > +  Interface (TC6).
> > > +
> > > +allOf:
> > > +  - $ref: ethernet-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - const: microchip,lan8650
> > > +          - const: microchip,lan8651
> >=20
> > The order here is wrong, lan8561 needs to come before the fallback of
> > lan8650.
>=20
> I don't think it is a fallback. There are two devices, and hence two
> different compatibles. So i suspect the -items: is wrong here?

It'd just be a two entry enum then, but I did take a quick look at the
driver earlier and saw:
+static const struct of_device_id lan865x_dt_ids[] =3D {
+	{ .compatible =3D "microchip,lan8650" },
+	{ .compatible =3D "microchip,lan8651" },
+	{ /* Sentinel */ }
+};

That, along with no other of_device_is_compatible() type operations
made me think that having a fallback actually was suitable.

You cropped it out, but the patch had:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: microchip,lan8650
> +          - const: microchip,lan8651
> +      - enum:
> +          - microchip,lan8650

So it doesn't appear to be an accidental items in place of an enum,
since the other compatible is in another enum.

I just noticed also that that enum should actually be const, so I'd
expect this to be:
  compatible:
    oneOf:
      - items:
          - const: microchip,lan8651
          - const: microchip,lan8650

      - const: microchip,lan8650

--mIS2Ako9u5OaxKJQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZei9cAAKCRB4tDGHoIJi
0jMxAQD2iy4HggGTwYp8gKBk+89kAsbo3O85mifjZSW0IgAsrgD9ESTpywdH3c9C
VikUWvKQXuWPhWhgqreZE6CqDcXsbgM=
=jQ66
-----END PGP SIGNATURE-----

--mIS2Ako9u5OaxKJQ--

