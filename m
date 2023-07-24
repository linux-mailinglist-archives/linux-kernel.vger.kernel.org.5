Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221A675FBCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjGXQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjGXQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:20:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A3710DE;
        Mon, 24 Jul 2023 09:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A2A6125F;
        Mon, 24 Jul 2023 16:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9E8C433C8;
        Mon, 24 Jul 2023 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690215643;
        bh=khO482gMaPy/qQC9weIQw3jsGa/RDBqNnCmrs6ht9LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SiewppIA19f9TVyl+yKSWnfIkY1Vz5gl4qq/f5gFz5OsQ6RWXGSO1rWdlMhDikwru
         Oip9q/s0adtYJHCKdFdpkA14yUIV9vhvR3oxY9D5zi9egQGpY3xunv2+FNjbz2895f
         4nYV1/yg20tdUUmCZdQCw2F3kZk4hacTIagSI5/1SCOSIzSD9d3k7n6IMY4uzy9vKg
         S0vUqsCgkH18vCbKD/vNzTIazLApwCGFEsOta8+B3JEKkSR1sWfnsf8g29W6jgRV2u
         zo9qoglmLhIWj+Ji0P56cxDLQMSLzbyaQnLUqKZFVZ8LTiSKxOy0e5jbNiMUaJVvo7
         z3XtauDIkL1Vg==
Received: (nullmailer pid 3744805 invoked by uid 1000);
        Mon, 24 Jul 2023 16:20:41 -0000
Date:   Mon, 24 Jul 2023 10:20:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <20230724162041.GA3716283-robh@kernel.org>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-4-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721212044.59666-4-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:20:42PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Provide access to the register regions and interrupt for Universal
> MAC(UMAC). The driver under the hpe,gxp-umac binding will provide an
> interface for sending and receiving networking data from both of the
> UMACs on the system.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../devicetree/bindings/net/hpe,gxp-umac.yaml | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml b/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
> new file mode 100644
> index 000000000000..c3b68c4ba7f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/hpe,gxp-umac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP Unified MAC Controller
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +description: |

Don't need '|' if no formatting to maintain. Here and elsewhere.

> +  HPE GXP 802.3 10/100/1000T Ethernet Unifed MAC controller.
> +  Device node of the controller has following properties.
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-umac
> +
> +  use-ncsi:
> +    type: boolean
> +    description: |
> +      Indicates if the device should use NCSI (Network Controlled
> +      Sideband Interface).
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  mac-address: true
> +
> +  ethernet-ports:
> +    type: object
> +    additionalProperties: false
> +    description: Ethernet ports to PHY
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^port@[0-1]$":
> +        type: object
> +        additionalProperties: false
> +        description: Port to PHY
> +
> +        properties:
> +          reg:
> +            minimum: 0
> +            maximum: 1
> +
> +          phy-handle:
> +            maxItems: 1
> +
> +        required:
> +          - reg
> +          - phy-handle
> +
> +  mdio:
> +    $ref: mdio.yaml#
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ethernet-ports
> +
> +examples:
> +  - |
> +    ethernet@4000 {
> +      compatible = "hpe,gxp-umac";
> +      reg = <0x4000 0x80>;
> +      interrupts = <22>;
> +      mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
> +      ethernet-ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +          phy-handle = <&eth_phy0>;
> +        };
> +
> +        port@1 {
> +          reg = <1>;
> +          phy-handle = <&eth_phy1>;
> +        };
> +      };
> +
> +      mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        eth_phy0: ethernet-phy@0 {
> +          reg = <0>;
> +        };
> +
> +        eth_phy1: ethernet-phy@1 {
> +          reg = <1>;
> +        };
> +      };
> +    };
> +...
> -- 
> 2.17.1
> 
