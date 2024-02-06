Return-Path: <linux-kernel+bounces-55319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F384BAF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C881F2527D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89941C06;
	Tue,  6 Feb 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InhSnCUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDF1109;
	Tue,  6 Feb 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237156; cv=none; b=tkpnxRTQoY7mw9XSfDyx7px6Idf5qIMcAmcQhB/2SeWi9TmztC1AyltVae3I/bEJon5lFGoucn5ikUCaUqrUzCFi7ge5wAG9RMZVRYTraKVDxItwODO5gjl8lkXEWpyU7xP6Dj8cS4u7s9U2JUzz8ZqgeUEw0rp/oEAphzXIZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237156; c=relaxed/simple;
	bh=VUVf9m+WpTmCOVnNMaOwkUB5XVPEoBw58bzOPnIkiW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQJ8kfgVezwgFbcRjH7G0kN3DOfhoo2ZyVZIC/K8VdjtiXjH25zC78fSGYjDq36nRJi3nMxXcWwtdCVKSfqjLFMckcfDUft+nFUk15MVAweTJuD3hkxtdyQt5weY/9OF1NSR+ds65jKd9gb63u7+bTH980j3BypVCuMvpoY1CdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InhSnCUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990B6C433C7;
	Tue,  6 Feb 2024 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707237155;
	bh=VUVf9m+WpTmCOVnNMaOwkUB5XVPEoBw58bzOPnIkiW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InhSnCUvkTocP2EuFSB8wXe5XoRhXPnCJWLvJPtGmNFYnhfkx32p1VY+NDXJ/tz8v
	 v9Q/JvOgJVcOMYV1WkQSjPAbmmSq5NvATxL7yR36wc8WO6E2X7yZqzAGJpTK2wQXst
	 YwKKx9TCqpOOdUrCwO09ZwE/Pt1+rDpIGNvoym7BwL5eMXcQZKiTtppWeP4Jp01aNj
	 cC5uQae8LpnnTWEd/k2cd1423ghlMtPlzfpJYKhR6wu/HSUtGXdIN2II8O7rAq+Him
	 51ou/AWe0CPyNY4sBlqdOWVGtbGeeWK5s7/F2qW54rKvcnYQJsgy5EyftJoqCc86AQ
	 xL2yy5ISBD7JQ==
Date: Tue, 6 Feb 2024 16:32:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v6 05/10] dt-bindings: net: Document Qcom
 QCA807x PHY package
Message-ID: <20240206-correct-viscous-1f8c163f4d0c@spud>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
 <20240205164851.1351-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a/vFkjiZ+/oGlKeY"
Content-Disposition: inline
In-Reply-To: <20240205164851.1351-6-ansuelsmth@gmail.com>


--a/vFkjiZ+/oGlKeY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Christian,

On Mon, Feb 05, 2024 at 05:48:37PM +0100, Christian Marangi wrote:
> Document Qcom QCA807x PHY package.
>=20
> Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> 1000BASE-T PHY-s.
>=20
> Document the required property to make the PHY package correctly
> configure and work.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

I think this looks pretty decent, some minor comments.

> +  qcom,package-mode:
> +    description: |
> +      PHY package can be configured in 3 mode following this table:
> +
> +                    First Serdes mode       Second Serdes mode
> +      Option 1      PSGMII for copper       Disabled
> +                    ports 0-4
> +      Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
> +                    ports 0-4
> +      Option 3      QSGMII for copper       SGMII for
> +                    ports 0-3               copper port 4
> +
> +      PSGMII mode (option 1 or 2) is configured dynamically by the driver

I'd drop mention of the driver here, with s/by the driver//.

> +      based on the presence of a connected SFP device.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - qsgmii
> +      - psgmii
> +    default: psgmii
> +
> +  qcom,tx-driver-strength-milliwatt:

Is this a typo? Should not it be "drive-strength"? There's 39 mentions
in tree of "driver-strength" and 3500 for "drive-strength".

Otherwise I think the review comments have been resolved:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--a/vFkjiZ+/oGlKeY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcJfHQAKCRB4tDGHoIJi
0tXdAQCygPRitHtARrZJDmyO9gAZQRI5ZN6riGQM9vasnNvVqwD/YZY1UhnCp8RP
gpI63/IURIEemQZndCY9SfLKbTrt9gA=
=2+Jh
-----END PGP SIGNATURE-----

--a/vFkjiZ+/oGlKeY--

