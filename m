Return-Path: <linux-kernel+bounces-128051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58566895565
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA2C2870D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789208594C;
	Tue,  2 Apr 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNa7jZ5w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9608526C;
	Tue,  2 Apr 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064516; cv=none; b=B8npAjewq4rVMPfDbjQDQRSWwJuHGIUwmvYi6gEYIMnmo6mfSIghReGQNznM30G9eUr/M7BnCdnDi6oHzyreEGndomkkdrqWaw9RNyy1b7X0sQorqxB5wybx6j1LQqZqwJIwlMwSyiUKE++LUw2LSWESjl2wOF1eMMnQBr4SGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064516; c=relaxed/simple;
	bh=gJ+tjsxOhWRYZLxqPN3VmcdtoCk55RCuOzh5/mLZ88Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MI8lpTmcNSspNaLWDZ3SfQJYy1mMwafSkm01YvfVFbVfmH7uPkfza9QenBbRDjLFYxH9yhY4NVIDo1oJ8GnRJgvp7LSuKk5CqcPDQbtku48gToPBOhCog3I+cnPnj6NCrL1og05MKPz+1XG5adXy2HY9+JeEFvKs1Q6SxGrvQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNa7jZ5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CB9C433F1;
	Tue,  2 Apr 2024 13:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712064516;
	bh=gJ+tjsxOhWRYZLxqPN3VmcdtoCk55RCuOzh5/mLZ88Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNa7jZ5wJPvUw0DqkPcwWDyVR9VZjUk8HE/K0B5WYaId84xXJTxA8EKyJnK9h3hV/
	 5bd0n09EwQyNVAhHFKOnBOJRabBwBXvJkYng44glL2zGGE9RXKqTCefzda7Bpnql2N
	 UMTr7HoX2MIHSFiF8n+E0P8nc9Nm2TAtsPVQCpEEuPpO7CY6w3MJf5WO5Pi/VC4fEi
	 WWE8xwfkkAva+ocK24QvPfGiW8QhCG+loMHu1YkgXf517SRjh6BK4O9x1ui+DmdPW9
	 xo7wZCkzfgYokg3JKzFFV4GC/sBlaB+cxzYPlTmjZ6tHK7KutbzHrfzboIyNCzrPjw
	 VO1VLWcd3K3nw==
Date: Tue, 2 Apr 2024 08:28:34 -0500
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
Subject: Re: [PATCH net-next v6 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <20240402132834.GB3744978-robh@kernel.org>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-14-c1011b6ea1cb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-feature_poe-v6-14-c1011b6ea1cb@bootlin.com>

On Tue, Mar 26, 2024 at 03:04:51PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add the PD692x0 I2C Power Sourcing Equipment controller device tree
> bindings documentation.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v2:
> - Enhance ports-matrix description.
> - Replace additionalProperties by unevaluatedProperties.
> - Drop i2c suffix.
> 
> Changes in v3:
> - Remove ports-matrix parameter.
> - Add description of all physical ports and managers.
> - Add pse_pis subnode moving to the API of pse-controller binding.
> - Remove the MAINTAINERS section for this driver as I will be maintaining
>   all pse-pd subsystem.
> 
> Changes in v5:
> - Remove defs used only once.
> - Replace underscore by dash.
> - Add description.
> ---
>  .../bindings/net/pse-pd/microchip,pd692x0.yaml     | 158 +++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> new file mode 100644
> index 000000000000..62ea4363cba3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/microchip,pd692x0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PD692x0 Power Sourcing Equipment controller
> +
> +maintainers:
> +  - Kory Maincent <kory.maincent@bootlin.com>
> +
> +allOf:
> +  - $ref: pse-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pd69200
> +      - microchip,pd69210
> +      - microchip,pd69220
> +
> +  reg:
> +    maxItems: 1
> +
> +  managers:
> +    type: object
> +    description:
> +      List of the PD69208T4/PD69204T4/PD69208M PSE managers. Each manager
> +      have 4 or 8 physical ports according to the chip version. No need to
> +      specify the SPI chip select as it is automatically detected by the
> +      PD692x0 PSE controller. The PSE managers have to be described from
> +      the lowest chip select to the greatest one, which is the detection
> +      behavior of the PD692x0 PSE controller. The PD692x0 support up to
> +      12 PSE managers which can expose up to 96 physical ports. All
> +      physical ports available on a manager have to be described in the
> +      incremental order even if they are not used.
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
> +      "^manager@0[0-9]|1[0-2]$":

Unit-addresses are typically in hex.

Is 'manager' something specific to this device or should be common?

> +        $ref: /schemas/graph.yaml#/properties/ports

This is not using the graph binding. Furthermore, I don't want to see 
new cases of 'port' node names which are not graph nodes. We have it 
already with ethernet switches, but 'ethernet-port' is preferred over 
'port'.

Why is this one 'managers' and the other device binding 'channels'?

> +        description:
> +          PD69208T4/PD69204T4/PD69208M PSE manager exposing 4 or 8 physical
> +          ports.
> +
> +        properties:
> +          reg:
> +            description:
> +              Incremental index of the PSE manager starting from 0, ranging
> +              from lowest to highest chip select, up to 12.
> +            maxItems: 1
> +
> +        patternProperties:
> +          '^port@[0-7]$':
> +            type: object
> +            required:
> +              - reg

Any property you want is allowed in this node. You are missing 
'additionalProperties'.

> +
> +        required:
> +          - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - pse-pis
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ethernet-pse@3c {
> +        compatible = "microchip,pd69200";
> +        reg = <0x3c>;
> +
> +        managers {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          manager@0 {
> +            reg = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            phys0: port@0 {
> +              reg = <0>;
> +            };
> +
> +            phys1: port@1 {
> +              reg = <1>;
> +            };
> +
> +            phys2: port@2 {
> +              reg = <2>;
> +            };
> +
> +            phys3: port@3 {
> +              reg = <3>;
> +            };
> +          };
> +
> +          manager@1 {
> +            reg = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            phys4: port@0 {
> +              reg = <0>;
> +            };
> +
> +            phys5: port@1 {
> +              reg = <1>;
> +            };
> +
> +            phys6: port@2 {
> +              reg = <2>;
> +            };
> +
> +            phys7: port@3 {
> +              reg = <3>;
> +            };
> +          };
> +        };
> +
> +        pse-pis {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          pse_pi0: pse-pi@0 {
> +            reg = <0>;
> +            #pse-cells = <0>;
> +            pairset-names = "alternative-a", "alternative-b";
> +            pairsets = <&phys0>, <&phys1>;

It is very strange that you are describing the connections within a 
device.


> +            polarity-supported = "MDI", "S";
> +          };
> +          pse_pi1: pse-pi@1 {
> +            reg = <1>;
> +            #pse-cells = <0>;
> +            pairset-names = "alternative-a";
> +            pairsets = <&phys2>;
> +            polarity-supported = "MDI";
> +          };
> +        };
> +      };
> +    };
> 
> -- 
> 2.25.1
> 

