Return-Path: <linux-kernel+bounces-150412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7808A9EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41A3286EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F716EBE3;
	Thu, 18 Apr 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYdA9rPg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA76D3B18D;
	Thu, 18 Apr 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454799; cv=none; b=Qmjioeyurkww2TqgWZ++rZrqw7HpHWDoslUKmsecGcnGGFl5KMRNp+T5CUolXqpk4RDSCrMCsH+XdKQ0WZF3jsN7s4NCpQ+1DvDVgAgMCMpAgHL5rTPGbb/lAdMcXzMb7K7g+T3dtqQ5lxXmD83j3nexcAXZnQ50FgcVbeZcriY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454799; c=relaxed/simple;
	bh=eZMo4P2E3CI3NQ6VH6HqGAvDmu58DfAbXNVuH3h7jwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPe3xYsaUgnn6Wktkp+DML8ssB4YDCCMOh6jGpXhOpwK3ob6nbw3DVDOxlrZkhP8jtKeBZjEBYv4WdL9rhaRoxUNEDzgxqI0R6fw30Scj2iRGVYLkkpnpJTqbOKAUmJMweLd9hb3euL9FpKPnGHa6lgQQZ53S4uvknxoU622TrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYdA9rPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353BCC113CC;
	Thu, 18 Apr 2024 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713454799;
	bh=eZMo4P2E3CI3NQ6VH6HqGAvDmu58DfAbXNVuH3h7jwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYdA9rPgLqH9mQrFMhFCJ0IxNEI1EPG1KW8IjdO8N34qYNd0IW7o+DhVI0Qvqo0/O
	 nvZFc+kcsRtbdHHv3NpSVBq2Mbm3hBoEcVQoCOtxs8Feosp5VMtSHzD+ObJJDE+yVh
	 GiQELdSH/N9ITBo1vWmCE2Kb3Yr+xPzzd5CFKaK3n0bAJYIVHLlDZmrX/WeQdtpbCy
	 hAhQFdzzZJPdpNRUwKgew/X6ZJ/ImN2r2DmcfmTf9ztDXj7zVS9+yAtD/UWeex7Eru
	 Mpb8W6ZEcLbI6mlxAiMFQRM2jJOxJc4BUNTw02oYt6d5ZV/cz3GkEtdwj9HIgFGGw3
	 JgSE8/YIRYMMw==
Date: Thu, 18 Apr 2024 16:39:52 +0100
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
Subject: Re: [PATCH net-next v4 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Message-ID: <20240418-hypnosis-oblong-028c107e6c3f@spud>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-13-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OMoF28WElBeQfUgK"
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-13-Parthiban.Veerasooran@microchip.com>


--OMoF28WElBeQfUgK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 06:26:48PM +0530, Parthiban Veerasooran wrote:
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
> index 000000000000..4fdec0ba3532
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml

Filename matching a compatible please.


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
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#

Can you use the same referencing style for both elements here please?


Otherwise, looks aight to me, so with those fixed:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: microchip,lan8650
> +      - items:
> +          - const: microchip,lan8651
> +          - const: microchip,lan8650
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
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-max-frequency
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      ethernet@0 {
> +        compatible =3D "microchip,lan8651", "microchip,lan8650";
> +        reg =3D <0>;
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&eth0_pins>;
> +        interrupt-parent =3D <&gpio>;
> +        interrupts =3D <6 IRQ_TYPE_EDGE_FALLING>;
> +        local-mac-address =3D [04 05 06 01 02 03];
> +        spi-max-frequency =3D <15000000>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f41b7f2257d2..2172431a1935 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14378,6 +14378,7 @@ MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DR=
IVER
>  M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/net/microchip,lan865x.yaml
>  F:	drivers/net/ethernet/microchip/lan865x/lan865x.c
> =20
>  MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
> --=20
> 2.34.1
>=20

--OMoF28WElBeQfUgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiE+yAAKCRB4tDGHoIJi
0p0YAQCAdG43pmde0U/WZ/1qUZLp+G75xP7+MuDgEJBmYJK+ZQD+LbWbLS+rfHQD
5Lbz0TgMasyOgD4o28CfPhXnnRx9hQc=
=TRKB
-----END PGP SIGNATURE-----

--OMoF28WElBeQfUgK--

