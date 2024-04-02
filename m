Return-Path: <linux-kernel+bounces-128040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B9C89554D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB65B25557
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E383CDD;
	Tue,  2 Apr 2024 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0QvUGak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1AD60B96;
	Tue,  2 Apr 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064400; cv=none; b=C5DtNcgA1AK47FSGSup5SVCrYoqMq+sopbR0bfeKFvGTnmF3rxdwgbONW5vFxfdLyc0J6YqTQS5yGRAMAA2BGzMG9KJZjyaqPBcmQ8l0QxMuJUZqspsGPmQGY86jPldQnp8+QsyOUOTy3Pj1JFY2JdDzSSyk9oqDlb8djMcPpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064400; c=relaxed/simple;
	bh=hlqVVxyxG9QM5oLoAbqmZw1d52KMspKeP5w+isXcmUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLBcZ9+we1dbJSXInThoDvENohMDzPABVUJUvZtzwsonUMYi9wtqvLSJ5ySnsmR7/7rBwoUA04XiEy4AAZsgbjv7THEQhlGLGwjHCQIcRGdQ4O4zgVXWeVhqEpkadYLPEmROErgcMbneW7RyouHsG3ZCk0+lh2pJ3ewO3/MqQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0QvUGak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B01C433F1;
	Tue,  2 Apr 2024 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712064399;
	bh=hlqVVxyxG9QM5oLoAbqmZw1d52KMspKeP5w+isXcmUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0QvUGakpXWyePXz3YTw9UULDkBXS8HtxsPzUwn3eHy3mDLAVRUKrHObi27q2RJvn
	 bmrgx1/nPFt8iR7FvNti3ADybQDmbXLZqgO3bmEcTihr7zKjZjCrSbocAKlD5S05pQ
	 VVO41SLuxOzHlVtoVUPLkNquXKs/g3koyxBRPqVuLSmSWYuFnHug0hwYTMGJSiNXms
	 Mgbnps1L/GRy2pgbMMp31/rcwQghSfhjowzBw5F+PsosXirsDyGWbhZ3lj95Pan0sJ
	 6MbAagg+umYcYoFBAePZ4JR0c0IIkW5vOtEKVU1yCyJ0Rcu9zdkCB/ze/NOkngD1Z/
	 5hVV4kbZktECA==
Date: Tue, 2 Apr 2024 08:26:37 -0500
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
Subject: Re: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240402132637.GA3744978-robh@kernel.org>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>

On Tue, Mar 26, 2024 at 03:04:48PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> PSE PI setup may encompass multiple PSE controllers or auxiliary circuits
> that collectively manage power delivery to one Ethernet port.
> Such configurations might support a range of PoE standards and require
> the capability to dynamically configure power delivery based on the
> operational mode (e.g., PoE2 versus PoE4) or specific requirements of
> connected devices. In these instances, a dedicated PSE PI node becomes
> essential for accurately documenting the system architecture. This node
> would serve to detail the interactions between different PSE controllers,
> the support for various PoE modes, and any additional logic required to
> coordinate power delivery across the network infrastructure.
> 
> The old usage of "#pse-cells" is unsuficient as it carries only the PSE PI
> index information.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v3:
> - New patch
> 
> Changes in v4:
> - Remove $def
> - Fix pairset-names item list
> - Upgrade few properties description
> - Update the commit message
> 
> Changes in v5:
> - Fix yamllint error.
> - Replace underscore by dash in properties names.
> - Add polarity-supported property.
> 
> Changes in v6:
> - Reorder the pairset pinout table documentation to shrink the lines size.
> - Remove pairset and polarity as required fields.
> - Add vpwr-supply regulator supply.
> ---
>  .../bindings/net/pse-pd/pse-controller.yaml        | 102 ++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> index 2d382faca0e6..03f7f215c162 100644
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
> @@ -22,11 +23,106 @@ properties:
>      description:
>        Used to uniquely identify a PSE instance within an IC. Will be
>        0 on PSE nodes with only a single output and at least 1 on nodes
> -      controlling several outputs.
> +      controlling several outputs which are not described in the pse-pis
> +      subnode. This property is deprecated, please use pse-pis instead.
>      enum: [0, 1]
>  
> -required:
> -  - "#pse-cells"
> +  pse-pis:
> +    type: object
> +    description:
> +      Overview of the PSE PIs provided by the controller.
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +    patternProperties:
> +      "^pse-pi@[0-9a-f]+$":
> +        type: object
> +        description:
> +          PSE PI for power delivery via pairsets, compliant with IEEE
> +          802.3-2022, Section 145.2.4. Each pairset comprises a positive and
> +          a negative VPSE pair, adhering to the pinout configurations
> +          detailed in the standard.
> +          See Documentation/networking/pse-pd/pse-pi.rst for details.
> +
> +        properties:
> +          reg:
> +            description:
> +              Address describing the PSE PI index.
> +            maxItems: 1
> +
> +          "#pse-cells":
> +            const: 0
> +
> +          pairset-names:
> +            $ref: /schemas/types.yaml#/definitions/string-array
> +            description:
> +              Names of the pairsets as per IEEE 802.3-2022, Section 145.2.4.
> +              Valid values are "alternative-a" and "alternative-b". Each name

Don't state constraints in prose which are defined as schema 
constraints.

> +              should correspond to a phandle in the 'pairset' property
> +              pointing to the power supply for that pairset.
> +            minItems: 1
> +            maxItems: 2
> +            items:
> +              enum:
> +                - alternative-a
> +                - alternative-b
> +
> +          pairsets:
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +            description:
> +              List of phandles, each pointing to the power supply for the
> +              corresponding pairset named in 'pairset-names'. This property
> +              aligns with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
> +              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145\u20133)
> +              |-----------|---------------|---------------|---------------|---------------|
> +              | Conductor | Alternative A | Alternative A | Alternative B | Alternative B |
> +              |           |    (MDI-X)    |     (MDI)     |      (X)      |      (S)      |
> +              |-----------|---------------|---------------|---------------|---------------|
> +              | 1         | Negative VPSE | Positive VPSE | \u2014             | \u2014             |
> +              | 2         | Negative VPSE | Positive VPSE | \u2014             | \u2014             |
> +              | 3         | Positive VPSE | Negative VPSE | \u2014             | \u2014             |
> +              | 4         | \u2014             | \u2014             | Negative VPSE | Positive VPSE |
> +              | 5         | \u2014             | \u2014             | Negative VPSE | Positive VPSE |
> +              | 6         | Positive VPSE | Negative VPSE | \u2014             | \u2014             |
> +              | 7         | \u2014             | \u2014             | Positive VPSE | Negative VPSE |
> +              | 8         | \u2014             | \u2014             | Positive VPSE | Negative VPSE |
> +            minItems: 1
> +            maxItems: 2

"pairsets" does not follow the normal design pattern of foos, foo-names, 
and #foo-cells. You could add #foo-cells I suppose, but what would cells 
convey? I don't think it's a good fit for what you need.

The other oddity is the number of entries and the names are fixed. That 
is usually defined per consumer. 

As each entry is just a power rail, why can't the regulator binding be 
used here?

> +
> +          polarity-supported:
> +            $ref: /schemas/types.yaml#/definitions/string-array
> +            description:
> +              Polarity configuration supported by the PSE PI pairsets.
> +            minItems: 1
> +            maxItems: 4
> +            items:
> +              enum:
> +                - MDI-X
> +                - MDI
> +                - X
> +                - S
> +
> +          vpwr-supply:
> +            description: Regulator power supply for the PSE PI.

I don't see this being used anywhere.

> +
> +        required:
> +          - reg
> +          - "#pse-cells"
> +
> +oneOf:
> +  - required:
> +      - "#pse-cells"
> +  - required:
> +      - pse-pis
>  
>  additionalProperties: true
>  
> 
> -- 
> 2.25.1
> 

