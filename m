Return-Path: <linux-kernel+bounces-78948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5720861B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF24A1C23E34
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2B1420B8;
	Fri, 23 Feb 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozowuSY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B2133991;
	Fri, 23 Feb 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711928; cv=none; b=Nr+vUUfH7oVyI3Ry2/2h3sIQxJN0jqFl+NuqDUS+6rLpSeZnjNZmUaiMpK3r6eOQf4/nm67sIB20c3FpgEckSFETXovcOJiHSeY7bsUHz7T32aC/ZL+ehgon/JTdktlwepfhsVB0+Y1po76qTndjxrTYpHyXWcpyBXjW/9FM5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711928; c=relaxed/simple;
	bh=X5+KKKEiF1rSjfbI8HVxegm2HjFlZd71yRviY+OKX3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyCfq0OzhTJ9P+e2GaBsIaVgrwXCbMzodtDV6HumpArwQpmvs3qbzbJ8gfV4ioHlnKbg+3PTMcqSInjD8h1GAMqu1kUctfNLn1b2CFttN1BzB/JOq+Ngzg1KKFGGkQvJL7nlNMXVwG/vtqW+9eFmCBBzi92B6B/5dG7OGQspzqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozowuSY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C5FC433F1;
	Fri, 23 Feb 2024 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708711928;
	bh=X5+KKKEiF1rSjfbI8HVxegm2HjFlZd71yRviY+OKX3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozowuSY25/bBDPulRu2KQueBT926KJJgdNx+4OpDWQQASAP9Zs55yjQsO4PeqLnYd
	 p4MG2nraj0PtSt/JwPREzgd/d96l2hSbvDcnLAfy0WTobTSZd7IcjJv89tYugMdxaa
	 JxEgcgY1lchhfgOo4WN9APrldq7aMBevbN7KBn5S8FgdtwwUZdnH5MTv9Pdl/DAScA
	 WfnPldTdhOoB6VuoQ/RZDENR1wzi4I5AAAM8eUJP72gsvzOhzFzwtrGHcJb7N+UWU8
	 KMnUHrderJMEY4Ghi2B0D7GBHTwzo6Vo/GnUKLCtSh73fAAQY8CW1jHVfYi5kBEQ+z
	 /jrms99DbiSwA==
Date: Fri, 23 Feb 2024 18:12:02 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Kevin Hilman <khilman@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/8] dt-bindings: usb: ti,j721e-usb: drop useless
 compatible list
Message-ID: <20240223-clarity-variably-206b01b7276a@spud>
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
 <20240223-j7200-usb-suspend-v3-1-b41c9893a130@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2uJqstsxxkeMiVZB"
Content-Disposition: inline
In-Reply-To: <20240223-j7200-usb-suspend-v3-1-b41c9893a130@bootlin.com>


--2uJqstsxxkeMiVZB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 05:05:25PM +0100, Th=E9o Lebrun wrote:
> Compatible can be A or B, not A or B or A+B. Remove last option.
> A=3Dti,j721e-usb and B=3Dti,am64-usb.
>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Do=
cumentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 95ff9791baea..949f45eb45c2 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -11,12 +11,9 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    oneOf:
> -      - const: ti,j721e-usb
> -      - const: ti,am64-usb
> -      - items:
> -          - const: ti,j721e-usb
> -          - const: ti,am64-usb

Correct, this makes no sense. The devices seem to be compatible though,
so I would expect this to actually be:
oneOf:
  - const: ti,j721e-usb
  - items:
      - const: ti,am64-usb
      - const: ti,j721e-usb

> +    enum:
> +      - ti,j721e-usb
> +      - ti,am64-usb
> =20
>    reg:
>      maxItems: 1
>=20
> --=20
> 2.43.2
>=20

--2uJqstsxxkeMiVZB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjf8gAKCRB4tDGHoIJi
0vJjAP0Z1I8RoVCej2LQjpvzqdfx5ed9h5bwcp5hHZ/8SjS0qgEAllHSOHA3dx1t
2rVw1vW/7ervNyKDPv5Aoh5DVldMlQo=
=+mAw
-----END PGP SIGNATURE-----

--2uJqstsxxkeMiVZB--

