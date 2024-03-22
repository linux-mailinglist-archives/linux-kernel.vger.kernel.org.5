Return-Path: <linux-kernel+bounces-111905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F366588726C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF01F288B18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0133560BAC;
	Fri, 22 Mar 2024 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvrERC+H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B460B80;
	Fri, 22 Mar 2024 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130382; cv=none; b=KmBGxS8COES5e29TDAXe0w6VTdICxckTsFgnj9TbcfV5/7HwPKCTvhcIUq3m7B68p1sQbD0QjzCd2YDX2SCzvm/y1oz3P6yUaNR5EjURz9CLnuQI29tAWB6wFDZpWvYnN6d5mZE9M9OzJOpBDpqidbUir6EAgPnbiEI14wsT9l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130382; c=relaxed/simple;
	bh=vYsHN5tUpWVy+FYsrra2eYCMPyeaVlBd8+QL+Nh9b5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHgzTNAdRBaVqbJEHntt8speeq8F1CDgSUCamiSznjwPessBlWknC19t24hXeCKBJfv6Xxf7fQeFBIu+91WNBSm4VTacgF0G3/lfSMhWrg+d9l9CKk9r2hNEnM7peOjcZyYElY7juOgZeEdv8PW8Wwn2+rqBog4Igclmt/lSb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvrERC+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CEAC433F1;
	Fri, 22 Mar 2024 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711130382;
	bh=vYsHN5tUpWVy+FYsrra2eYCMPyeaVlBd8+QL+Nh9b5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvrERC+HC9ArLBwp5Fh3Xrsa3y5UQi9zCRFAfd9lTmymxC+aQbv7hNJVjfxZxZMrJ
	 pECB2rBIhEokCw5c+Or39sRuvgLWvuWpU/HrY9ti1WFSZAgsrhs24UB6BCk8YYjvWu
	 1T9prFLrcbvmEoNSzCrHgN2UE70qsLjPSsnD62FRSPazKgRxP8eUVu0erjqCW809hE
	 4pmE47B/VZKdlKLh7NVwshneoqtSlMZFdxi4DQDTp8vP9ZYWEr7zDDmqovQxVkBUBS
	 8TpNVPNfQKanvTdjOeTkbesQDpUacMpUbXBfI+22IFUd4XPV39sHU2evasKP7n75t/
	 rSMCMlyxXDvQQ==
Date: Fri, 22 Mar 2024 17:59:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] dt-bindings: hwmon: ibmpowernv: convert to
 dtschema
Message-ID: <20240322-papaya-diabolic-e7c2c4319eb2@spud>
References: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
 <20240322-hwmon_dtschema-v2-2-570bee1acecb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1BqIBqYDHfkBFwJe"
Content-Disposition: inline
In-Reply-To: <20240322-hwmon_dtschema-v2-2-570bee1acecb@gmail.com>


--1BqIBqYDHfkBFwJe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 07:45:27AM +0100, Javier Carrasco wrote:
> Convert existing binding to support validation.
>=20
> This is a straightforward conversion with now new properties.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/ibm,powernv.yaml     | 37 ++++++++++++++++=
++++++
>  .../devicetree/bindings/hwmon/ibmpowernv.txt       | 23 --------------
>  2 files changed, 37 insertions(+), 23 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ibm,powernv.yaml b/D=
ocumentation/devicetree/bindings/hwmon/ibm,powernv.yaml
> new file mode 100644
> index 000000000000..b26d42bce938
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ibm,powernv.yaml

Filename should really match one of the compatibles. "powernv" is not a
type of hwmon as far as a quick google reports so I think its a poor
choice here regardless. With a compatible for the filename:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ibm,powernv.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IBM POWERNV platform sensors
> +
> +maintainers:
> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ibm,opal-sensor-cooling-fan
> +      - ibm,opal-sensor-amb-temp
> +      - ibm,opal-sensor-power-supply
> +      - ibm,opal-sensor-power
> +
> +  sensor-id:
> +    description:
> +      An opaque id provided by the firmware to the kernel, identifies a
> +      given sensor and its attribute data.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - sensor-id
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sensor {
> +        compatible =3D "ibm,opal-sensor-cooling-fan";
> +        sensor-id =3D <0x7052107>;
> +    };
> diff --git a/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt b/Doc=
umentation/devicetree/bindings/hwmon/ibmpowernv.txt
> deleted file mode 100644
> index f93242be60a1..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -IBM POWERNV platform sensors
> -----------------------------
> -
> -Required node properties:
> -- compatible: must be one of
> -		"ibm,opal-sensor-cooling-fan"
> -		"ibm,opal-sensor-amb-temp"
> -		"ibm,opal-sensor-power-supply"
> -		"ibm,opal-sensor-power"
> -- sensor-id: an opaque id provided by the firmware to the kernel, identi=
fies a
> -	     given sensor and its attribute data
> -
> -Example sensors node:
> -
> -cooling-fan#8-data {
> -	sensor-id =3D <0x7052107>;
> -	compatible =3D "ibm,opal-sensor-cooling-fan";
> -};
> -
> -amb-temp#1-thrs {
> -	sensor-id =3D <0x5096000>;
> -	compatible =3D "ibm,opal-sensor-amb-temp";
> -};
>=20
> --=20
> 2.40.1
>=20

--1BqIBqYDHfkBFwJe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3HCQAKCRB4tDGHoIJi
0jNGAP9qE1RgXwHh+bJHGrruo2IG/PvvUFE4CGzM4LgWwflF/AEAiZNvtVyjY0Ni
4RDUtWjJKj6uVoLcSS6AW+psuIZ81g0=
=vQA/
-----END PGP SIGNATURE-----

--1BqIBqYDHfkBFwJe--

