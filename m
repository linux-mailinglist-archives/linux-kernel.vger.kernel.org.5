Return-Path: <linux-kernel+bounces-119025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FC88C2D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9361C3BB45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31326FE2B;
	Tue, 26 Mar 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0diSzn1L"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B11EB56;
	Tue, 26 Mar 2024 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458040; cv=none; b=E8B/Qzqg3zn7xyr91kpkrZ6Z2FoFp/Onvxjqbr+agZ360sxGc5HWkzkS9WGdgai3nlgQd7RC7UrnoU/xVTF4YTz0yiMmmNr5bdaRi48Yf0E6WBDeoOG7eH20YeTXTl4mKioXI0h2rI5W9oo+AqWsxsDJGfx946QVwT0sOecdjhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458040; c=relaxed/simple;
	bh=xkxdvHTbd8Z8kP9MNS+4DxyaFZLV2iMtZ9unzzpMXdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjKtm1IY5/fJ7XfnrI38EB8aGWjS87ZDhejDT/kwaT+oAfnifBIXPdBsCpsOAIvSUMXlJJslZiKqynTsBcB8K1a2aB0BiAzBtuoJayRyjhjbEQ7Rl3HCx4Fgj50ODw81olQI01DYCLOToRo5ov47JH6F4B7KpXvjQ3yAUR3WWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0diSzn1L; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711458035;
	bh=xkxdvHTbd8Z8kP9MNS+4DxyaFZLV2iMtZ9unzzpMXdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0diSzn1LDvqwQpyAyJVPHUXoFynNcoZHaosB//DJvxMPy54OdzITaEdwWGqAvZaYQ
	 iUE+XZTGSDQsLSa/20IY31saU3VwsYYGjQcUcz3VQTQHNW55K9+xuSiUDiiLMTagI7
	 KBMa+EXpA1VvVOlzllJK6XdYsZckgL7xaGqSZCTv6VJ5cP7i3PYMQOuSIhdaAcj7ui
	 H1pGmCOJgh9dPJqfVk1CBHVKOXLTC5ux2gc07iOBOJ8dqfAYLfFo1pcxmJNpq1U5hu
	 a/kFGmNQwdiEtvkvpskfTObVbsApj4ddUfOBPKeQ6anzazPtswKAymN1TIP5Gb4/I3
	 4fgWdTaKz2p4A==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4CB613780480;
	Tue, 26 Mar 2024 13:00:35 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id E107F1060700; Tue, 26 Mar 2024 14:00:34 +0100 (CET)
Date: Tue, 26 Mar 2024 14:00:34 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: hsi: nokia-modem: convert to YAML
Message-ID: <6fs52p67hlgvnwfsmbdh3asv4rv3dew5kgbhpcvwbbtkxk4csv@2pbwotxezgs2>
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
 <20240325-hsi-dt-binding-v1-2-88e8e97c3aae@collabora.com>
 <58ec79cc-150e-4fef-bb4b-9d29901e9a04@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="znisws7tnra4zv4t"
Content-Disposition: inline
In-Reply-To: <58ec79cc-150e-4fef-bb4b-9d29901e9a04@linaro.org>


--znisws7tnra4zv4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 26, 2024 at 08:21:05AM +0100, Krzysztof Kozlowski wrote:
> On 25/03/2024 22:45, Sebastian Reichel wrote:
> > Convert the legacy txt binding to modern YAML.
> > No semantic change.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../devicetree/bindings/hsi/nokia-modem.txt        |  59 ------------
> >  .../devicetree/bindings/hsi/nokia-modem.yaml       | 101 +++++++++++++=
++++++++
> >  2 files changed, 101 insertions(+), 59 deletions(-)
> >=20
>=20
>=20
> > -};
> > diff --git a/Documentation/devicetree/bindings/hsi/nokia-modem.yaml b/D=
ocumentation/devicetree/bindings/hsi/nokia-modem.yaml
> > new file mode 100644
> > index 000000000000..c57cbcc7b722
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hsi/nokia-modem.yaml
>=20
> Filename should match compatibles. nokia,n9-modem.yaml or nokia,modem.yaml

Ack, I will switch to nokia,modem.yaml in v2.

> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hsi/nokia-modem.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nokia modem
> > +
> > +maintainers:
> > +  - Sebastian Reichel <sre@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nokia,n900-modem
> > +      - nokia,n950-modem
> > +      - nokia,n9-modem
> > +
>=20
> Aren't hsi-channel-ids related to hsi-channel-names? If so, they
> should be here with constraints.

Indeed. I forgot them, since they were not in the old binding :)
I will constraint them to min/max items 4 in v2.

> > +  hsi-channel-names:
> > +    items:
> > +      - const: mcsaab-control
> > +      - const: speech-control
> > +      - const: speech-data
> > +      - const: mcsaab-data

[...]

> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    hsi-client {
>=20
> This should be "modem".

Ack.

>=20
> > +        compatible =3D "nokia,n900-modem";
> > +

Thanks for the review,

-- Sebastian

--znisws7tnra4zv4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYCxu0ACgkQ2O7X88g7
+ppX/hAAhXkf0s9bqwd4TCVkEl7HVkqaHaUsDMZz6WmOTXc22K3BeJ/DGO0vfTU0
Bb4VEqv8BldN/a2nz6u0AsKVgQ+ca3WYiT2H1O+ykBE5kFSxqzZxY0PNJBmJasLM
u7YDRQpOFWMcNcDXo1ZFuXwMuomsxw93j+kAMzZtQYk2roQdSFBTatG6Roj1AfcE
m0NEWgpjteNyx+d2r+zExF/sLEr8/GL4L5erDKETk6uKRoorRUvz+ZI9EBi+7hWM
RQMBGbBW+kUEDz6YYsI9AFElCBQv1qQwh3cxjUh/gR1ScHkpVYovQ4P0Z0rAyDvh
rswzG21MnPZNfOPWPhTn9CkZ7qkNw6drCiFNLaPzObhvBm9G6fRZX7CByPqnWQaO
C2KQXJF+53eWDaRfnftURVdiH/NdgE2q2pw7LG1bUF/wKTqfqN0ARfDQ6JYmWeFG
K9mIGgZQxhI9etRrlR7k+enFRVM8eJnT524b8cTLhyw4Cv2o3B/avIGxU3bnyTsB
M3DBYU75Xg1OESy6wTv/noc5thyyCiLJS+uSqcvwyi6UYOBGJFe9O3m1Dz3RA0A7
c4tzgtrIq8ny5UO6UugOKpyGZd3meYhlyKwpgWdpqGMPgY45mkE091NL/Rki0v+1
HjwqkxgZ3uEJC9ZfU8LuVFg8q78F61zkj2vADJInlaslT3xkS/o=
=pXTQ
-----END PGP SIGNATURE-----

--znisws7tnra4zv4t--

