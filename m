Return-Path: <linux-kernel+bounces-59487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD684F7D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE711F254F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8176BFA1;
	Fri,  9 Feb 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dodLnal6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52503F9FD;
	Fri,  9 Feb 2024 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489833; cv=none; b=YrTwCq2XtWFlUCTKEetJgLAnDK6Euy3EJgCybQvP5X65+42tPe9fAtASpObLo9WHVRCDCv3a8eD72gn0Z48nRpPUbGPiXFtxTlAK9Ygj8JZapgZYhgjK23iyeudGnBGCiHOLssZ02EhZNO3ZUBtppas2kppGQOwenaOUsYm7rwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489833; c=relaxed/simple;
	bh=KmmKjKyNVxZ2zfv9PoMRLGWQZNpQOaUBoweL3NKHvQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLL9v28gQCh8lTJgzvjfRd6yzaqVbM/kI7zqq5CMCvon6dTiJ9topN8FNJ+MVB7xUZVIufB67ftxiesuiVU0YmCRtuXp/H2rrQvliHL7wkStTaG1up96CKyiqdubK6aSDpCPzp5EZrmPGU7Lv811kAdoCfoZ8ZlxcAApwDJtL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dodLnal6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C863CC433C7;
	Fri,  9 Feb 2024 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707489832;
	bh=KmmKjKyNVxZ2zfv9PoMRLGWQZNpQOaUBoweL3NKHvQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dodLnal6ogcyPZ8QKbpJwzkd0EKmrFdRjxra6Z9xIMmt98VWzrZYsePnEGgbFl2NB
	 k3As2Qi+0TTp0wXkSKeAoJBCh73YJyv1D+GtKntz13QPToJ2r61W10bosALVTJHC9G
	 RU/UEK5nQmVWgixyJcTc1njUoTpab1kyvynsQspB02YFwTfN5Pfmb6reEmRTdRErET
	 bt3KCCCuXFhNE6c0gvDB2LystI1n0Bl/IsZ7cvRTQKv6qEk+lAcnA4lgHMvYJblo5g
	 UFxQhCCYEN2yNTpqPx5GNCugovL3CLN9FoPPYru0mGJKRr93y9Lqrxd/jCGUnSTnFZ
	 oXCRPsX8ZGjuQ==
Date: Fri, 9 Feb 2024 14:43:49 +0000
From: Rob Herring <robh@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 10/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240209144349.GA3678044-robh@kernel.org>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-10-531d2674469e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208-feature_poe-v3-10-531d2674469e@bootlin.com>

On Thu, Feb 08, 2024 at 02:08:47PM +0100, Kory Maincent wrote:
> Before hand we set "#pse-cell" to 1 to define a PSE controller with

#pse-cells

> several PIs (Power Interface). The drawback of this was that we could not
> have any information on the PI except its number.

Then increase it to what you need. The whole point of #foo-cells is that 
it is variable depending on what the provider needs. 

> Add support for pse_pis and pse_pi node to be able to have more information
> on the PI like the number of pairset used and the pairset pinout.

Please explain the problem you are trying to solve, not your solution. I 
don't understand what the problem is to provide any useful suggestions 
on the design.

> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>

Is this a recognized tag? First I've seen it.

> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v3:
> - New patch
> ---
>  .../bindings/net/pse-pd/pse-controller.yaml        | 101 ++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> index 2d382faca0e6..dd5fb53e527a 100644
> --- a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> @@ -13,6 +13,7 @@ description: Binding for the Power Sourcing Equipment (PSE) as defined in the
>  
>  maintainers:
>    - Oleksij Rempel <o.rempel@pengutronix.de>
> +  - Kory Maincent <kory.maincent@bootlin.com>
>  
>  properties:
>    $nodename:
> @@ -22,11 +23,105 @@ properties:
>      description:
>        Used to uniquely identify a PSE instance within an IC. Will be
>        0 on PSE nodes with only a single output and at least 1 on nodes
> -      controlling several outputs.
> +      controlling several outputs which are not described in the pse_pis
> +      subnode. This property is deprecated, please use pse_pis instead.
>      enum: [0, 1]
>  
> -required:
> -  - "#pse-cells"
> +  pse_pis:
> +    $ref: "#/$defs/pse_pis"
> +
> +$defs:

$defs is for when you need multiple copies of the same thing. I don't 
see that here.

> +  pse_pis:
> +    type: object
> +    description:
> +      Kind of a matrix to identify the concordance between a PSE Power
> +      Interface and one or two (PoE4) physical ports.
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^pse_pi@[0-9]+$":

Unit-addresses are hex.

> +        $ref: "#/$defs/pse_pi"
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +  pse_pi:
> +    description:
> +      PSE PI device for power delivery via pairsets, compliant with IEEE
> +      802.3-2022, Section 145.2.4. Each pairset comprises a positive and a
> +      negative VPSE pair, adhering to the pinout configurations detailed in
> +      the standard.
> +    type: object
> +    properties:
> +      reg:
> +        maxItems: 1

As you are defining the addressing here, you need to define what the 
"addresses" are.

> +
> +      "#pse-cells":
> +        const: 0
> +
> +      pairset-names:
> +        description:
> +          Names of the pairsets as per IEEE 802.3-2022, Section 145.2.4. Valid
> +          values are "alternative-a" and "alternative-b". Each name should
> +          correspond to a phandle in the 'pairset' property pointing to the
> +          power supply for that pairset.
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        minItems: 1
> +        maxItems: 2
> +        items:
> +          - enum:
> +            - "alternative-a"
> +            - "alternative-b"

This leaves the 2nd entry undefined. You need the dictionary form of 
'items' rather than a list. IOW, Drop the '-' under items.

> +
> +      pairsets:
> +        description:
> +          List of phandles, each pointing to the power supply for the
> +          corresponding pairset named in 'pairset-names'. This property aligns
> +          with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
> +          PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145–3)
> +          | Conductor | Alternative A (MDI-X) | Alternative A (MDI) | Alternative B(X) | Alternative B(S) |
> +          |-----------|-----------------------|---------------------|------------------|------------------|
> +          | 1         | Negative VPSE         | Positive VPSE       | —                | —                |
> +          | 2         | Negative VPSE         | Positive VPSE       | —                | —                |
> +          | 3         | Positive VPSE         | Negative VPSE       | —                | —                |
> +          | 4         | —                     | —                   | Negative VPSE    | Positive VPSE    |
> +          | 5         | —                     | —                   | Negative VPSE    | Positive VPSE    |
> +          | 6         | Positive VPSE         | Negative VPSE       | —                | —                |
> +          | 7         | —                     | —                   | Positive VPSE    | Negative VPSE    |
> +          | 8         | —                     | —                   | Positive VPSE    | Negative VPSE    |
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        minItems: 1
> +        maxItems: 2
> +
> +    required:
> +      - reg
> +      - "#pse-cells"
> +      - pairset-names
> +      - pairsets
> +
> +allOf:
> +  - if:
> +      required:
> +        - "#pse-cells"
> +    then:
> +      not:
> +        required:
> +          - pse-pis
> +
> +  - if:
> +      required:
> +        - pse-pis
> +    then:
> +      not:
> +        required:
> +          - "#pse-cells"
>  
>  additionalProperties: true
>  
> 
> -- 
> 2.25.1
> 

