Return-Path: <linux-kernel+bounces-94383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B8873E58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B38C1F234C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A0D13E7D5;
	Wed,  6 Mar 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On481HuE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03513BAF5;
	Wed,  6 Mar 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748994; cv=none; b=GFXu/HnPdaOtclbM/eK4aLYmQCdRxJXwIRyjZtOiCfstEeG7XXS2vGTSUiuaZ4v+2v7PfSNMcLWrtNgmqfVjvtY9Tat/gXT3FrOV9ySNTkBfth8v/d4jn0ZG4N0bW7WBP4OqQnnIJNo+GvjrrqsuOrE3v9LNM5CmeWpcxW8T004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748994; c=relaxed/simple;
	bh=tbBRCaVo+InwOYa4J6KLxUWcsfoWs0IB2yezyi2bp08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQvyskSyJtuJck+aca5BenBsDjycND1bp5j0VXI4cRsa35+CCAkwgPh1A8MeTNYAh0vuqOWELv3+lXV7Dl3UUo+7g2grlCiNSUL4dBhTywa3blSW78m16lDz6HfWO0LQ8HMvN2mx84VV9w2mFMsXWToQMQtdm+wwjMP2uoTmXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On481HuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4889C433F1;
	Wed,  6 Mar 2024 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709748993;
	bh=tbBRCaVo+InwOYa4J6KLxUWcsfoWs0IB2yezyi2bp08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On481HuEnTCVzcRBpoCcsH7kUp/WqPowKz8ggMRH22YjUOKgSOc/s8AypODCtNPfT
	 Id6Ny3910rp52Ys3aivv+4DQZIq8DLzkscMIeP/rOcsyGqArNYAOtj9HCFs++2Dydw
	 AD3nzHHiCNVduLGzzvJlymj4hH7dmiXnZ2vffDe1KRP2Ydu0qPjdYGSnFqtN/kFX09
	 JdnZVpbZg5VvFQkV84I0dOWTRx9OfcNFHei8gqHYtAe9zEYTv83UfXa1o7GokKCdtQ
	 i5H2i0qm+/kSgsBrqRWNeOu15gxCMKgl0EXuT/ykdjldXL90hH0r5spPRGQYgIHf4Q
	 14TWzzyUTOMkg==
Date: Wed, 6 Mar 2024 18:16:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Message-ID: <20240306-spree-islamist-957acf0ee368@spud>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mTPtQiM3l9AbfMu+"
Content-Disposition: inline
In-Reply-To: <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>


--mTPtQiM3l9AbfMu+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 02:20:17PM +0530, Parthiban Veerasooran wrote:
> The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
> PHY to enable 10BASE-T1S networks. The Ethernet Media Access Controller
> (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
> with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
> integrated into the LAN8650/1. The communication between the Host and the
> MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
> Interface (TC6).
>=20
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  .../bindings/net/microchip,lan865x.yaml       | 80 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan86=
5x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan865x.yaml=
 b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
> new file mode 100644
> index 000000000000..ee52f9d8e93c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/microchip,lan865x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN8650/1 10BASE-T1S MACPHY Ethernet Controllers
> +
> +maintainers:
> +  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> +
> +description:
> +  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
> +  PHY to enable 10BASE=E2=80=91T1S networks. The Ethernet Media Access C=
ontroller
> +  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
> +  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiv=
er
> +  integrated into the LAN8650/1. The communication between the Host and
> +  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
> +  Interface (TC6).
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: microchip,lan8650
> +          - const: microchip,lan8651

The order here is wrong, lan8561 needs to come before the fallback of
lan8650.

> +      - enum:
> +          - microchip,lan8650
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt from MAC-PHY asserted in the event of Receive Chunks
> +      Available, Transmit Chunk Credits Available and Extended Status
> +      Event.
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    minimum: 15000000
> +    maximum: 25000000

You're missing a reference to spi-peripheral-props where this property
is defined.

Thanks,
Conor.

--mTPtQiM3l9AbfMu+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeiy+gAKCRB4tDGHoIJi
0sEyAP9vKKL7S6v67sm8LpUGgEB1xcFQscjGQHYHiNpCJc91nQEAuiL8Ui5nA319
6/NDoP4DozSDQSxF+xuFFl8A5bOsIA4=
=TG4y
-----END PGP SIGNATURE-----

--mTPtQiM3l9AbfMu+--

