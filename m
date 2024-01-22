Return-Path: <linux-kernel+bounces-33076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B377836423
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA221F24AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D763CF50;
	Mon, 22 Jan 2024 13:13:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125BD3C6AB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929234; cv=none; b=VY9adPqS0o9EPuFYvfty0EyhsdKsTtHzSuCH3fmlgtwe1hGG/dwUkrW026tydM5jubB3WlCg+myMq2F9KRFuH2AAGyTy1d/svp96In4njk93nO0GKE3YsPJi2lVgZXrN0++oQE+XEQfLwmpEHbSsLuS2dfYCOxbUqGu/US6tz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929234; c=relaxed/simple;
	bh=5R7j8Dl9cK0KfAuJewWJ6X7E8Pn2vi+QuvLjLtLOAz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHY0MACZhGiRCZZuqkeP8N/m+kBJ0dys1nlR3jDIF1/lACEfgIO3XCmUMTY2J4mJ7r5VH56mLN75aqMG0OitH0O3Jw+642OXoH/79V4zQLDKkbPIpQKNx9feKwaSFnNsF8kNTOTPqyXoHk3JAgrLYEW/IOnOJUmFVYSTX7g+/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rRu75-0005ez-Pg; Mon, 22 Jan 2024 14:13:19 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rRu73-001biB-E1; Mon, 22 Jan 2024 14:13:17 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EDDCF27B58F;
	Mon, 22 Jan 2024 13:13:16 +0000 (UTC)
Date: Mon, 22 Jan 2024 14:13:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: can: mpfs: add missing required clock
Message-ID: <20240122-surely-crimp-ba4a8c55106d-mkl@pengutronix.de>
References: <20240122-catty-roast-d3625dbb02fe@spud>
 <20240122-breeder-lying-0d3668d98886@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gm5qx6ivqj7qxcxg"
Content-Disposition: inline
In-Reply-To: <20240122-breeder-lying-0d3668d98886@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--gm5qx6ivqj7qxcxg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.01.2024 12:19:50, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
> CAN bus clock. The bus clock was omitted when the binding was written,
> but is required for operation. Make up for lost time and add it.
>=20
> Cautionary tale in adding bindings without having implemented a real
> user for them perhaps.
>=20
> Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN contr=
oller")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml     | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can=
=2Eyaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> index 45aa3de7cf01..01e4d4a54df6 100644
> --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> @@ -24,7 +24,9 @@ properties:
>      maxItems: 1
> =20
>    clocks:
> -    maxItems: 1
> +    items:
> +      - description: AHB peripheral clock
> +      - description: CAN bus clock

What about adding clock-names, so that the order can be checked
automatically?

> =20
>  required:
>    - compatible
> @@ -39,7 +41,7 @@ examples:
>      can@2010c000 {
>          compatible =3D "microchip,mpfs-can";
>          reg =3D <0x2010c000 0x1000>;
> -        clocks =3D <&clkcfg 17>;
> +        clocks =3D <&clkcfg 17>, <&clkcfg 37>;
>          interrupt-parent =3D <&plic>;
>          interrupts =3D <56>;
>      };
> --=20
> 2.43.0
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gm5qx6ivqj7qxcxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmWuaecACgkQvlAcSiqK
BOiItAgAiVb1F3nml4JkuMIY7dmQo5gzshMOge9YwxV+CViwK6+VZN81W+a+uBRC
nG6H9blRP6/eWCGmJMty07eR8pnzfzh1F7fdSr3ZjVJAtPcNY/Ywc5ByKebJz8jS
bXxVgQ4cxcMzl54lO6xd0cFi9cCAIc8ENFStCmEhc65/KJMu8uDcitYv2T1fDj3d
mrs7ok2oKy0JvVoQUVdeSfcWj3KxK4Hl4HX4cDZlsQhLuNRcRm17k5Xf8wtqiW+T
Qi0Lyzls8rj/Phk0qKpWpcsMxVa76FAYj6W6yyW0s0mP+0piGLWfxNYqdXsvkOvh
7ak8HyX1amqRf3OBh6/9Uk1imCpACw==
=oZCM
-----END PGP SIGNATURE-----

--gm5qx6ivqj7qxcxg--

