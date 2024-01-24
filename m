Return-Path: <linux-kernel+bounces-37444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AA483B023
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABFB1F24832
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361880058;
	Wed, 24 Jan 2024 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfHQT/4w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66DE7A721;
	Wed, 24 Jan 2024 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117807; cv=none; b=BavDTyqbxP4e0Z6y3yw9OhBCsv3QfdpIaLsy4h7kzzJzxhP+2EbAt5ZXnvEITMbcJOklLUF+dRAI1goxIAwiEklAmlsgGaEHHjK5LJ4Selg7JSvsUXGDATXa8Suyg0etMrZbgDzYP0xy2Gn8ggC8HAQ9UNlZJfoX1/e2YYTyMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117807; c=relaxed/simple;
	bh=3QjO5uCSOpQMB1ILZjNIw1kPsnLX3nr9mMc6N4yRg+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTPc97pVeLXJFUGZPr91NoOLnoaMu00FZpmRBUjpR2hvdY1c8ob2FPAscN4FicVGi2ipyrZYPxr9QX8wLfKjqbpTB+rYoJ4NDP3Xr0jqZA/a4p5eftolpTHVAB1QR/bGrbDN3ppHp7xs3H4sBHzhKAnPbO7GO2yjIXKuk3dE2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfHQT/4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC9BC433C7;
	Wed, 24 Jan 2024 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706117807;
	bh=3QjO5uCSOpQMB1ILZjNIw1kPsnLX3nr9mMc6N4yRg+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfHQT/4wRpas5NbBh4dvRllcQgejipPwdW9F8UsLdv3WNhhuTuxoLRxU30t/usubJ
	 dZAvB+HlbtIMsXE2q1Gpyl0l3n1QZFiGSNqt94Ev8wwAcmMbbrHrgfsoO7xBTbAV/j
	 4b9VZFH2yCt/Qa+1UQSCT4H93l7oeuFH+RU1S81A6ejzRaHh4Airspl9iy/WhPhTU8
	 VMDX343eg80HVv8Cw+SXgj/RhVjXqUEBqh0wnqQRnCG60hQ15ttKjMstgqOFiDQo7c
	 E0yJLnz3S6x+hlq6lsdh0fZ8T2dU+G8q1yyU9zYtlwLbj8HR+RLBqliUY2UxOaQnlN
	 FiUhAVBaQJwZg==
Date: Wed, 24 Jan 2024 17:36:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: ran.wang_1@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, mark.rutland@arm.com,
	pku.leo@gmail.com, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches
 avoiding vbus glitch
Message-ID: <20240124-unclothed-dodgy-c78b1fffa752@spud>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Uq4A7ICogxopmKU"
Content-Disposition: inline
In-Reply-To: <20240119213130.3147517-1-Frank.Li@nxp.com>


--0Uq4A7ICogxopmKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 04:31:28PM -0500, Frank Li wrote:
> From: Ran Wang <ran.wang_1@nxp.com>
>=20
> When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> (or its control signal) will turn on immediately on related Root Hub
> ports. Then the VBUS will be de-asserted for a little while during xhci
> reset (conducted by xhci driver) for a little while and back to normal.
>=20
> This VBUS glitch might cause some USB devices emuration fail if kernel
> boot with them connected. One SW workaround which can fix this is to
> program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> host mode in DWC3 driver(per signal measurement result, it will be too
> late to do it in xhci-plat.c or xhci.c).
>=20
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Reviewed-by: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Docum=
entation/devicetree/bindings/usb/snps,dwc3.yaml
> index 203a1eb66691f..dbf272b76e0b5 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -273,6 +273,13 @@ properties:
>        with an external supply.
>      type: boolean
> =20
> +  snps,host-vbus-glitches:
> +    description:
> +      When set, power off all Root Hub ports immediately after
> +      setting host mode to avoid vbus (negative) glitch happen in later
> +      xhci reset. And the vbus will back to 5V automatically when reset =
done.
> +    type: boolean

Why do we want to have a property for this at all? The commit message
seems to describe a problem that's limited to specific configurations
and appears to be somethng the driver should do unconditionally.

Could you explain why this cannot be done unconditionally please?

Thanks,
Conor.

> +
>    snps,is-utmi-l1-suspend:
>      description:
>        True when DWC3 asserts output signal utmi_l1_suspend_n, false when
> --=20
> 2.34.1
>=20

--0Uq4A7ICogxopmKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbFKqQAKCRB4tDGHoIJi
0nx/AQChEWeSmwbix3trVsvSb6aCXaoxtg2NUedV62nkNzkaXQD+Ll463rzca8jG
QHuKwBLVhjTuY45xu/Mbvva5xvUwBwE=
=xy2x
-----END PGP SIGNATURE-----

--0Uq4A7ICogxopmKU--

