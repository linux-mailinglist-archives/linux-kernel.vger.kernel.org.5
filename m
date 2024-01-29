Return-Path: <linux-kernel+bounces-43007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C788840A31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7A41F272AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD9154445;
	Mon, 29 Jan 2024 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCzSPJNF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B815442B;
	Mon, 29 Jan 2024 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542634; cv=none; b=b/LPSTBU1DuV8rl29+NXc3ZGNSOv2+KFUPWEoHYRlBIam1H0Zrp0XxsFynpxOu0mrPl2W3yxR67RG6l4ANTg/mZk/T3upyvlKj1ydlhATtPrArWfEa9gRSrn4p2dsLII0OEc38j/fuNKW52iATwzZi12FSGAfwfXlhg6eYz6vtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542634; c=relaxed/simple;
	bh=l8Gerv/RnUXdqS32Hvg6dJnaeNoXsPQ5rKnHUXy1+3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqT8bZVId88yM4fQ3rpH/pZmeNRhsk2yH/vLIZTxTRC+JcjD3oSBLAVGbQxabwr6Q0Ra1MExIqNcvBeWkmv8+lUzPfhOB6+SV8C+oliWNMkL9N8dC2yZaAtq172qXUt+pKEXULpLDjpwbDcsJ2djUU647U6L1hxJa/Xqre3NbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCzSPJNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DC7C433F1;
	Mon, 29 Jan 2024 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706542634;
	bh=l8Gerv/RnUXdqS32Hvg6dJnaeNoXsPQ5rKnHUXy1+3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCzSPJNF1f+jY8xMHnlLtWyLXT1HI1n9Z4l5hknVao0Sj9ZK35v8ZQshRQKY/BcQh
	 U/LfUyh8lv+z9SSWk3kI8YaLHmO+7bYfg+L2dUKlx6/eCn2T2wJond/WgS4SsVssIK
	 snu2PTE8kFw76oRqBBHS45J3rBnMwFsZpkaSVFfjtE1C8gsMbo0Dlyigho3/J4REU6
	 P8soMwsIBftAs5Gdwfqx8QWi64XaOVfBXJYqCtDfdLK0NXJPj5rgpa24gLKmRAqM1S
	 MNY60Zf+1CYLoDlW1j6B9CoTcS0LTvRXnW3r7BSx6yH9Q/9wyqbVFzMsctmng9N1h2
	 h9oqmmVm0apTA==
Date: Mon, 29 Jan 2024 15:37:08 +0000
From: Conor Dooley <conor@kernel.org>
To: William Qiu <william.qiu@starfivetech.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-can@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 2/4] dt-bindings: can: Add bindings for CAST CAN
 Controller
Message-ID: <20240129-garnet-polar-65afd461a1c6@spud>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
 <20240129031239.17037-3-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2qZLto2B8G05buYu"
Content-Disposition: inline
In-Reply-To: <20240129031239.17037-3-william.qiu@starfivetech.com>


--2qZLto2B8G05buYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey William,

On Mon, Jan 29, 2024 at 11:12:37AM +0800, William Qiu wrote:
> Add bindings for CAST CAN Controller
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../devicetree/bindings/net/can/cast,can.yaml | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/cast,can.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/cast,can.yaml b/Do=
cumentation/devicetree/bindings/net/can/cast,can.yaml
> new file mode 100644
> index 000000000000..ea52132d9b1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/cast,can.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/cast,can.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CAST CAN controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +allOf:
> +  - $ref: can-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,can
> +    then:
> +      required:
> +        - starfive,syscon

If you've got property related stuff in the allOf, move it down after
the property definitions.

> +properties:
> +  compatible:
> +    enum:
> +      - cast,can
> +      - cast,canfd

I don't like these uber generic compatibles that have no users as a
fallback. Allowing them in the binding only really discourages people
=66rom creating device specific compatibles.
Secondly, this is some purchased IP that I am sure has a versioning
scheme and the compatibles that you have created do not reflect that.
If they were being used as a fallback, I would request some versioning.
That's not going to really work though since the canfd features on the
jh7110 require setting u0_can_ctrl_can_fd_enable, so neither of these
compatibles really has a use right now.

> +      - starfive,can

Just "starfive,can"? Can you please add device specific compatibles for
the SoCs on which this is used?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: apb_clk
> +      - const: timer_clk
> +      - const: can_clk

Drop _clk, they're all clocks!

> +
> +  resets:
> +    minItems: 3
> +
> +  reset-names:
> +    items:
> +      - const: rst_apb
> +      - const: rst_core
> +      - const: rst_timer

Same here, drop rst_

> +
> +  starfive,syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to System Register Controller syscon no=
de
> +          - description: offset of SYS_SYSCON_NE__SAIF__SYSCFG register =
for CAN controller

The docs I have call this register "SYS_SYSCONSAIF__SYSCFG". Did the
names change since the TRM I have was written?

> +          - description: shift of SYS_SYSCON_NE__SAIF__SYSCFG register f=
or CAN controller
> +          - description: mask of SYS_SYSCON_NE__SAIF__SYSCFG register fo=
r CAN controller
> +    description:
> +      Should be four parameters, the phandle to System Register Controll=
er
> +      syscon node and the offset/shift/mask of SYS_SYSCON_NE__SAIF__SYSC=
FG register
> +      for CAN controller.

Cheers,
Conor.

--2qZLto2B8G05buYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfGJAAKCRB4tDGHoIJi
0naRAP9mnACAXbLoF5wZAI6lRZERQ91NOgTNtwrrOxfxsnoi6QEAuxoA1rFwLJSd
w8okICO/nnTr5tVns55t5LOoIKk5wwA=
=jD/W
-----END PGP SIGNATURE-----

--2qZLto2B8G05buYu--

