Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4F782E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjHUQZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHUQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14503E4;
        Mon, 21 Aug 2023 09:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D2F963E19;
        Mon, 21 Aug 2023 16:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F864C433C7;
        Mon, 21 Aug 2023 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692635119;
        bh=oZ7WQRQ9itjy25Tt/rRhlhdNXYXUxndS4PkMFVRCZFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CyHF7SPDkZ6ovolJzYQOcbwsmF0II6J72m2P+P6w2qyxivXmEcRz3V2yGeFWQdEao
         7LCs811khkt6TKYCOU6SMNaRylk9AUphGjiYQaGEETmW8xWY4IfjcLgiO+XuDi5GeH
         nXE2QZGHusr7PAhXy1trksze0ASTg8rpegrFlT80HrUTVobKp21fecGyefR8WMRwzf
         YDNuwwj+yInw/z7eF9GLoRK473tZyIbHeaMxEC4Ps0Gg6YjSwsVVB6atW0YegAvRn8
         AwxKjGvcUjJbbkGRzRinzdinaVoRgnPykCc/mNPQRrEVownudwITKsq4TGFz/WP51e
         t+8lW320iAOVw==
Received: (nullmailer pid 1844508 invoked by uid 1000);
        Mon, 21 Aug 2023 16:25:17 -0000
Date:   Mon, 21 Aug 2023 11:25:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, badhri@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: connector: Add child nodes for
 multiple PD capabilities
Message-ID: <20230821162517.GA1832382-robh@kernel.org>
References: <20230807174159.1140957-1-kyletso@google.com>
 <20230807174159.1140957-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807174159.1140957-2-kyletso@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 01:41:58AM +0800, Kyle Tso wrote:
> Define a new optional property "capabilities" which is a child node
> under connector to contain multiple USB Power Delivery capabilities.
> 
> Define a new property with pattern (e.g. caps-0, caps-1) which is a

A property in json-schema terms, but for DT it's a node not a property. 
'Define a child node ...' would be clearer.

> child node under "capabilities". Each node contains PDO data of a
> selectable Power Delivery capability.
> 
> Also define common properties for source-pdos, sink-pdos, and
> op-sink-microwatt that can be referenced.

Why do we need this? What issue does this solve? The commit message 
should answer those questions (always).

> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> v1 -> v2:
> - move source/sink-pdos to $defs and reference them in properties
> 
>  .../bindings/connector/usb-connector.yaml     | 80 +++++++++++++------
>  1 file changed, 57 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 1c4d3eb87763..c6b02dbda83f 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -117,28 +117,10 @@ properties:
>    # The following are optional properties for "usb-c-connector" with power
>    # delivery support.
>    source-pdos:
> -    description: An array of u32 with each entry providing supported power
> -      source data object(PDO), the detailed bit definitions of PDO can be found
> -      in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
> -      Source_Capabilities Message, the order of each entry(PDO) should follow
> -      the PD spec chapter 6.4.1. Required for power source and power dual role.
> -      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
> -      defined in dt-bindings/usb/pd.h.
> -    minItems: 1
> -    maxItems: 7
> -    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    $ref: "#/$defs/source-pdos"
>  
>    sink-pdos:
> -    description: An array of u32 with each entry providing supported power sink
> -      data object(PDO), the detailed bit definitions of PDO can be found in
> -      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
> -      Sink Capabilities Message, the order of each entry(PDO) should follow the
> -      PD spec chapter 6.4.1. Required for power sink and power dual role. User
> -      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
> -      in dt-bindings/usb/pd.h.
> -    minItems: 1
> -    maxItems: 7
> -    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    $ref: "#/$defs/sink-pdos"
>  
>    sink-vdos:
>      description: An array of u32 with each entry, a Vendor Defined Message Object (VDO),
> @@ -164,9 +146,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>  
>    op-sink-microwatt:
> -    description: Sink required operating power in microwatt, if source can't
> -      offer the power, Capability Mismatch is set. Required for power sink and
> -      power dual role.
> +    $ref: "#/$defs/op-sink-microwatt"
>  
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
> @@ -228,6 +208,30 @@ properties:
>        SNK_READY for non-pd link.
>      type: boolean
>  
> +  capabilities:
> +    description: A child node to contain all the selectable USB Power Delivery capabilities.
> +    type: object
> +
> +    patternProperties:
> +      "^caps-[0-9]+$":
> +        description: Child nodes under "capabilities" node. Each node contains a selectable USB
> +          Power Delivery capability.
> +        type: object
> +
> +        properties:
> +          source-pdos:
> +            $ref: "#/$defs/source-pdos"
> +
> +          sink-pdos:
> +            $ref: "#/$defs/sink-pdos"
> +
> +          op-sink-microwatt:
> +            $ref: "#/$defs/op-sink-microwatt"
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
>  dependencies:
>    sink-vdos-v1: [ 'sink-vdos' ]
>    sink-vdos: [ 'sink-vdos-v1' ]
> @@ -235,6 +239,36 @@ dependencies:
>  required:
>    - compatible
>  
> +$defs:

Make this:

$defs:
  capabilities:
    properties:
      ...

And then just reference "#/$defs/capabilities" at the top-level and in 
caps-[0-9] node schema.

You'll need to use unevaluatedProperties instead of additionalProperties 
as well.

> +  source-pdos:
> +    description: An array of u32 with each entry providing supported power
> +      source data object(PDO), the detailed bit definitions of PDO can be found
> +      in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
> +      Source_Capabilities Message, the order of each entry(PDO) should follow
> +      the PD spec chapter 6.4.1. Required for power source and power dual role.
> +      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
> +      defined in dt-bindings/usb/pd.h.
> +    minItems: 1
> +    maxItems: 7
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  sink-pdos:
> +    description: An array of u32 with each entry providing supported power sink
> +      data object(PDO), the detailed bit definitions of PDO can be found in
> +      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
> +      Sink Capabilities Message, the order of each entry(PDO) should follow the
> +      PD spec chapter 6.4.1. Required for power sink and power dual role. User
> +      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
> +      in dt-bindings/usb/pd.h.
> +    minItems: 1
> +    maxItems: 7
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  op-sink-microwatt:
> +    description: Sink required operating power in microwatt, if source can't
> +      offer the power, Capability Mismatch is set. Required for power sink and
> +      power dual role.
> +
>  allOf:
>    - if:
>        properties:
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 
