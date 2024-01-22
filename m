Return-Path: <linux-kernel+bounces-33214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A131836655
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E6628EEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672C46427;
	Mon, 22 Jan 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF69lYdG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7C4176A;
	Mon, 22 Jan 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935376; cv=none; b=N5D77o8UB+txGI1mCddR40qDGRuh0hjuCYNE4RKDLtQZyuAd36asjx40o0g+dATTupG8vzHN20+LfP00TSFj+wJXEXBK9+S5hOnd5vP4QgymfHwG4u8A6oXN+UE54AX4f0/iPuj1aIIqeD5vMjA6zIZcZZfi4bP3fK1aR+G6Dlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935376; c=relaxed/simple;
	bh=aylFoYFUNFDwJsODArIOK0d6BnWENGefvOy/9zETano=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ailz+TkVBDoZmvRVS+YqpU6xVrdQf6EacjDOnJDjFk350hJdpJq+lZDAryGwtoO9vsxN50TJosV01BS0K5pmk41SsjSLJ8LTtCFxi6EmOc4s9K/USWXTT/8FHe8eiAsjMXDf9fh/UKp+iIlhKAgfSUQMhtnEW8ogrjBkoM5mO2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF69lYdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6468C43390;
	Mon, 22 Jan 2024 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935375;
	bh=aylFoYFUNFDwJsODArIOK0d6BnWENGefvOy/9zETano=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lF69lYdGrvMV1bT1hg/5DzxS20FbA4Ah7UaL9p1jiDmR1zA7PdY5nSrRaEyzMelNB
	 iB4igEA6RBKx5rP6sm4hLAQcsSElqObxT0lK/AjnxCDzSnGrHdgXSpyzhKFX7pls+/
	 SDyKfxIZF4FqNwVu+qH1o2NseSOD+QTlKJZJArLtdUJcrvPJfowgsNfvf5/+p1lJAO
	 K/EOe2UbqpTszK6Dci4ZCv44aUB/vLhvWUxqnmqqfAmjDkDwbseLtlKlB/xsZwaLpO
	 7Uot3P6JWc9O+KaPragbwuwW8aYwqOAGvhwyY9uHDMpzI7OL9BwmkOqbAW+6o4EtbA
	 kmBPqoS3P6zzQ==
Date: Mon, 22 Jan 2024 14:56:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: can: mpfs: add missing required clock
Message-ID: <20240122-uncoated-cherub-a29cba1c0035@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
 <20240122-breeder-lying-0d3668d98886@spud>
 <20240122-surely-crimp-ba4a8c55106d-mkl@pengutronix.de>
 <20240122-cruelly-dainty-002081f0beb2@spud>
 <20240122-smokeless-ion-63e4148c22e5-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VZgP6gFILu/j/CyX"
Content-Disposition: inline
In-Reply-To: <20240122-smokeless-ion-63e4148c22e5-mkl@pengutronix.de>


--VZgP6gFILu/j/CyX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 03:46:04PM +0100, Marc Kleine-Budde wrote:
> On 22.01.2024 14:21:04, Conor Dooley wrote:
> > On Mon, Jan 22, 2024 at 02:13:16PM +0100, Marc Kleine-Budde wrote:
> > > On 22.01.2024 12:19:50, Conor Dooley wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > >=20
> > > > The CAN controller on PolarFire SoC has an AHB peripheral clock _an=
d_ a
> > > > CAN bus clock. The bus clock was omitted when the binding was writt=
en,
> > > > but is required for operation. Make up for lost time and add it.
> > > >=20
> > > > Cautionary tale in adding bindings without having implemented a real
> > > > user for them perhaps.
> > > >=20
> > > > Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN=
 controller")
> > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml     | 6 ++=
++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/net/can/microchip,mp=
fs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.=
yaml
> > > > index 45aa3de7cf01..01e4d4a54df6 100644
> > > > --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.=
yaml
> > > > +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.=
yaml
> > > > @@ -24,7 +24,9 @@ properties:
> > > >      maxItems: 1
> > > > =20
> > > >    clocks:
> > > > -    maxItems: 1
> > > > +    items:
> > > > +      - description: AHB peripheral clock
> > > > +      - description: CAN bus clock
> > >=20
> > > What about adding clock-names, so that the order can be checked
> > > automatically?
> >=20
> > I don't personally care for doing so, but if your heart is set on having
> > them, then sure.
>=20
> Usually the CAN driver needs to have the clock rate of the clocks that
> the basis for the CAN bus clock. Looking at the clocks description it's
> probably the 2nd one.
>=20
> With clock-names we can automatically check that the 2nd clock is always
> the CAN clock.

I think we already had this discussion on v1, where I said that the
binding requires the clocks to be in that order, regardless of whether
or not clock-names is provided. You feel more strongly about it than I
do, so I will add them when I get around to sending a v3.

Cheers,
Conor.

--VZgP6gFILu/j/CyX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6CCQAKCRB4tDGHoIJi
0pBqAP9YBmYf5WMQ1g9eFFxDgDvxgLL7NbWukSK4TuirCpfVHwD/Vdz4dl59G+UV
fpzZQ35NUAbACLJ4724ApN5rJRTBQQU=
=WsOe
-----END PGP SIGNATURE-----

--VZgP6gFILu/j/CyX--

