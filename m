Return-Path: <linux-kernel+bounces-33146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C8E83653F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69AF3B22F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F863D3B6;
	Mon, 22 Jan 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aULTBvzO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3803D0AB;
	Mon, 22 Jan 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933271; cv=none; b=jwfaoPP1RtrCADVCphMXxuEPjs1ZlIlgzU9oNIvBAgzOFjn2bE3Vn9mI3w2PDa7rmwnmGwLjc9DFBHD7yidULBwxFBdXOTF6/bfJM54a0/uDmKZvhMnf5TZCnPUWxgabY1p+tCVRoMoq2+m8Q5ztj7sxEnuZfcfjwal6s3ZpCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933271; c=relaxed/simple;
	bh=sx/SZLbzMQXRoEFA2HncNv0TFxOKZA5thjdd5ftlYe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCauYN+R2AovxEL+GbzfHBReJjofTmYR/97kabCpFe7qq0ckLHnggLbZHxHMjj9fDO/4MQvEC/0l1JT4aUYIjSEQUu62fs1PYwvaWrXJzZnpch28X1AeBBxIqLt2w5+NPGmQbWBE6eVZccBgoY93gsBrfUXWEqS5L1s5jP6/Sq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aULTBvzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F2FC43390;
	Mon, 22 Jan 2024 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705933270;
	bh=sx/SZLbzMQXRoEFA2HncNv0TFxOKZA5thjdd5ftlYe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aULTBvzOcVWXQIjlnSyRyEMNDtqOjd3XEOyS8vuVrbiYHUA7YtaRnRjRc9Z9d25Sg
	 CqrCc9VQ5U02axVUdBL8THASd0iD3CqiiczGwsv7P61HCxDSa06iAOLsKxkDi3rSsd
	 ZIzh1VlKgWGaVRF94JjyzQaeednEnO9saZS0FFK1SI2klZPrtrs5wa6hrfwEbmz3/q
	 kxGxwBcIBe7DQDGX/ASVUHH6GwMt/wcTDX4D9G6GpY+dVUV+761IJsAKRUVXec2mjb
	 GnO2zyWh5L/nRHdrDKXj0npYtFpVBowpgjCjlzqfJ0ZwAij3KGddkhl1l+C3/APBSZ
	 zplaUPlvFcPpA==
Date: Mon, 22 Jan 2024 14:21:04 +0000
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
Message-ID: <20240122-cruelly-dainty-002081f0beb2@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
 <20240122-breeder-lying-0d3668d98886@spud>
 <20240122-surely-crimp-ba4a8c55106d-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DgDTawVh/uoBk6a9"
Content-Disposition: inline
In-Reply-To: <20240122-surely-crimp-ba4a8c55106d-mkl@pengutronix.de>


--DgDTawVh/uoBk6a9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 02:13:16PM +0100, Marc Kleine-Budde wrote:
> On 22.01.2024 12:19:50, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
> > CAN bus clock. The bus clock was omitted when the binding was written,
> > but is required for operation. Make up for lost time and add it.
> >=20
> > Cautionary tale in adding bindings without having implemented a real
> > user for them perhaps.
> >=20
> > Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN con=
troller")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml     | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-c=
an.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> > index 45aa3de7cf01..01e4d4a54df6 100644
> > --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> > @@ -24,7 +24,9 @@ properties:
> >      maxItems: 1
> > =20
> >    clocks:
> > -    maxItems: 1
> > +    items:
> > +      - description: AHB peripheral clock
> > +      - description: CAN bus clock
>=20
> What about adding clock-names, so that the order can be checked
> automatically?

I don't personally care for doing so, but if your heart is set on having
them, then sure.

Cheers,
Conor.

--DgDTawVh/uoBk6a9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa550AAKCRB4tDGHoIJi
0mG6AQCzkwjYc3ET9xROc6H+kOYEOP7ViMXoh/nf1GZddfy7NQD+Ny8uVB9lFx5n
5oK3FNCWB0tKkiI3fXCZswAn1hOjGA0=
=3HmK
-----END PGP SIGNATURE-----

--DgDTawVh/uoBk6a9--

