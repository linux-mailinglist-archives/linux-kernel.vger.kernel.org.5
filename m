Return-Path: <linux-kernel+bounces-35771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E12839648
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A411C2335D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A677FBDD;
	Tue, 23 Jan 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fta0TOH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126263518;
	Tue, 23 Jan 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030626; cv=none; b=W1gg148dmIaOxBUs45Z0TmZnQsWcn8RXcrZi0wPyOiRIZveB5EM96KJbjRxAy+WkA02TT3UmWm6VLX8VJy8eM1ZI6YUQtZKwJC6YvjH3bgEcvPYgXXi6wn7pr4OgyUoh8AljopODEBmjovCp9b6c6ImbFWqUeYPryAr5tYJh6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030626; c=relaxed/simple;
	bh=femgqPkSEbLEE9OmJM4uIzxaC1oRXQv/pdyrNKGtr8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShiP2H/eCvAAWeGNvaCjn5lLU6u+mheOHyhRgftX5eMyZSmG9HzZ6502J6wTpx/4rQbuaFQWuftnrlnDNTXT20au5kh55/ffRNZxXwomOzy6ISTO8TM8w9g+VkS8X7+OA2mPnUKXJPUdRN+plNouNNk1LS8pIG8MGTuZlAL+N9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fta0TOH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB86C433F1;
	Tue, 23 Jan 2024 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706030626;
	bh=femgqPkSEbLEE9OmJM4uIzxaC1oRXQv/pdyrNKGtr8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fta0TOH3tYq/WKjiidHvlkG2hPr3JzDIjDfhlqVRhOlp9HHNSimElSS7FDSqDYPNL
	 ZkaSHgVkDbtE6t8PFjdkX4jUQTedln6xmoT9nMHmlFi5NdsI3xuLAQnTL5JVX3oegx
	 W3r11RvNH/hrWTEegf38z+JY2NW6UYBYJD7bWl3LGruEbvLSNw7csDZwemEl8sFll/
	 xp+Heyq2kENomXSOIBFlfihPR7ofERTlwQ2FOdAqQCm7qAP9fVqFf0rl/mgfWI9BP2
	 k9/ZPtnweshaeP/a4DNjdVzZJ7L4y7ca833lFcza2vz1ja7TJdtKcwYrXoTv4IhUFC
	 O/wttq99ywYOw==
Date: Tue, 23 Jan 2024 17:23:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Marek Vasut <marex@denx.de>,
	Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
Message-ID: <20240123-atlas-dart-7e955e7e24e5@spud>
References: <20240123135014.614858-1-dev@pschenker.ch>
 <20240123-ripening-tabby-b97785375990@spud>
 <b2e232de11cee47a5932fccc2d151a9c7c276784.camel@pschenker.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="puDO/bicEa8XZtpY"
Content-Disposition: inline
In-Reply-To: <b2e232de11cee47a5932fccc2d151a9c7c276784.camel@pschenker.ch>


--puDO/bicEa8XZtpY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 05:17:53PM +0100, Philippe Schenker wrote:
>=20
>=20
> On Tue, 2024-01-23 at 16:06 +0000, Conor Dooley wrote:
> > On Tue, Jan 23, 2024 at 02:50:13PM +0100, Philippe Schenker wrote:
> > > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> > >=20
> > > This commit adds the dt-binding for KSZ8567, a robust 7-port
> > > Ethernet switch. The KSZ8567 features two RGMII/MII/RMII
> > > interfaces,
> > > each capable of gigabit speeds, complemented by five 10/100 Mbps
> > > MAC/PHYs.
> > >=20
> > > Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> > This device has all the same constraints as the other ones in this
> > binding, why is it not compatible with any of them? If it isn't, the
> > compatible should mention why it is not.
>=20
> Hi Conor, Thanks for your message!
>=20
> I need the compatible to make sure the correct ID of the switch is
> being set in the driver as well as its features.

Are the features of this switch such that a driver for another ksz
switch would not work (even in a limited capacity) with the 8567?
Things like the register map changing or some feature being removed are
examples of why it may not work.

> You mean I shall mention the reason in the commit-message, or where?

Yes.

Thanks,
Conor

> > > =A0Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
> > > =A01 file changed, 1 insertion(+)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > index c963dc09e8e1..52acc15ebcbf 100644
> > > --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > @@ -31,6 +31,7 @@ properties:
> > > =A0=A0=A0=A0=A0=A0 - microchip,ksz9893
> > > =A0=A0=A0=A0=A0=A0 - microchip,ksz9563
> > > =A0=A0=A0=A0=A0=A0 - microchip,ksz8563
> > > +=A0=A0=A0=A0=A0 - microchip,ksz8567
> > > =A0
> > > =A0=A0 reset-gpios:
> > > =A0=A0=A0=A0 description:
> > > --=20
> > > 2.34.1
> > >=20

--puDO/bicEa8XZtpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa/2HAAKCRB4tDGHoIJi
0iK5AP9Rxz/Mwx+CVYnGDVHIuqf+Y0VRbXv4MLXFsmG1xnO9wgEAkK7LkNWYo2x/
8DecwgALjn0eGXmhJXFDg8p2At5CsgY=
=KMN+
-----END PGP SIGNATURE-----

--puDO/bicEa8XZtpY--

