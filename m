Return-Path: <linux-kernel+bounces-151549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA528AB061
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D50D1F2469A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8543D12E1F3;
	Fri, 19 Apr 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7oQWewo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984712DDB8;
	Fri, 19 Apr 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535682; cv=none; b=dK5Tb56XpgxLO245k4ryebuCzB0kwTEDI3ziKRsQbDoKtbEmIHEMGgFNhaSrlFGPyzCWiVwD6L0TA5UccOKpFpsbVPkplwzRuxXfwXJNYMWkdadCCLRdZtI8ELmzFyYQ7N4IB814Dyyg9yvOqiayLOq5OlQ8qMd8tRRHh4EVoBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535682; c=relaxed/simple;
	bh=rjZuH2RNoPHVFiJFLYwvZB1FBSLtOukO9uEvQlaCLC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az5KbzkTNGZSNxq9OYI1DXm0jAempLXHShJw1WOjdTjQvNqU+w+mWU/RLQv6NMYiv6syL+7e3mVYrfDrJ4oaTyQSXDK13lh9jdl6jHxdnfh71NW5eWRqWogyO4B7b0+Q5TVldIX+X7qsX7q9c1Pq135JDtHs5HBAeDzo3fChxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7oQWewo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25936C4AF68;
	Fri, 19 Apr 2024 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713535682;
	bh=rjZuH2RNoPHVFiJFLYwvZB1FBSLtOukO9uEvQlaCLC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q7oQWewoDaWdOgYxMQ2ukGY48LSdhEWx1Otl6NL/TTr+dfGVMzoDhU3xs8U+Vh03h
	 h5b0vAwEUh0w5Y49GqRXTA3x6vXCtnvxjQ4gozeRKlb9SXka7NLec8p11CW/x98aJl
	 h5Lb+91utT3HTnj0JuWh7Xi436hMqCY/QTT9qqXHmHFOk931dWFEtI8LLQsVwB7nz8
	 LG5253uOY1du1nubU90M1bj7wt/5V/bTVlruSp8dRagHLqh2Bo5QGeuSWXlnz5Hipz
	 /gecHLXUIG2MGhaiGur1A5yaQe4R7eEow4vtXUbWk7COMzVEaOYU8P2WPM54eleU2Z
	 X9eUEDw0nTkew==
Date: Fri, 19 Apr 2024 15:07:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
Message-ID: <20240419-glue-pyramid-584728c0076a@spud>
References: <20240419124506.1531035-1-rilian.la.te@ya.ru>
 <20240419124506.1531035-3-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ov99zUVbexXa5Um/"
Content-Disposition: inline
In-Reply-To: <20240419124506.1531035-3-rilian.la.te@ya.ru>


--ov99zUVbexXa5Um/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 03:45:02PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
>=20
> Add EXAR XR20M1172 UART compatible line into devicetree documentation.

What you're doing is obvious from the diff, why this exar device is
related to the nxp devices is what should be mentioned here.

Thanks,
Conor.

>=20
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml =
b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> index 5dec15b7e7c3..c4bedf23368b 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> @@ -12,6 +12,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - exar,xr20m1172
>        - nxp,sc16is740
>        - nxp,sc16is741
>        - nxp,sc16is750
> --=20
> 2.34.1
>=20

--ov99zUVbexXa5Um/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiJ6uAAKCRB4tDGHoIJi
0s5fAP9IKK3nOQ4Jai8TvAbCaITTWmCJhHo3WB/T9hOiaHVNVQD/cVSvMGYRW79m
TbjX6eFGGbOtnYE3sPYmC7tlV8+2PAw=
=EuDz
-----END PGP SIGNATURE-----

--ov99zUVbexXa5Um/--

