Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF84778EC6E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345339AbjHaLse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjHaLsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB163C5;
        Thu, 31 Aug 2023 04:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 423316146C;
        Thu, 31 Aug 2023 11:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F35C433C8;
        Thu, 31 Aug 2023 11:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693482509;
        bh=lt6Dfc0PcUO4CkQPKYP4ayUpOMx8UlAuNXxheoPljfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6ueSnFewdHLh/k/xGULrXbf+/onOyOO68DI/jTtTT8cBdkteTuDGSReu1qUqBkGR
         VPEi0a6V34fyiytWfzOj+bmDUdkcFhcYZHcpz7Gh1ZcYrvfN9/SyIxR/9KLyFIlH6+
         zlottUp6b4VQb+eb0PWes1UTj/dVRaOfwycRMaTwI/3irRCUoTOEZyoaReFhjEbe6d
         2F9Cla0RwXylhNpsyg71p5y7wCp8n8WRbwUsbsI6+40At5wpw0eg3s4rg9LlPJQccg
         FiksDXiE2mIWOjP40mV/MHCMPRXseDsDW35Rz75O3gwejpDQtYQv119+euBfd1Cf8G
         QUaDYz/UvS1uA==
Received: (nullmailer pid 1959264 invoked by uid 1000);
        Thu, 31 Aug 2023 11:48:27 -0000
Date:   Thu, 31 Aug 2023 06:48:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: touchscreen: add overlay-touchscreen
 and overlay-buttons properties
Message-ID: <20230831114827.GA1941458-robh@kernel.org>
References: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v4-2-5c6c0fc1eed6@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510-feature-ts_virtobj_patch-v4-2-5c6c0fc1eed6@wolfvision.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:17:10PM +0200, Javier Carrasco wrote:
> The overlay-touchscreen object defines an area within the touchscreen
> where touch events are reported and their coordinates get converted to
> the overlay origin. This object avoids getting events from areas that
> are physically hidden by overlay frames.
> 
> For touchscreens where overlay buttons on the touchscreen surface are
> provided, the overlay-buttons object contains a node for every button
> and the key event that should be reported when pressed.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../bindings/input/touchscreen/touchscreen.yaml    | 152 +++++++++++++++++++++
>  1 file changed, 152 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> index 895592da9626..d90cbb4932b5 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> @@ -80,6 +80,158 @@ properties:
>    touchscreen-y-plate-ohms:
>      description: Resistance of the Y-plate in Ohms
>  
> +  overlay-touchscreen:
> +    description: Clipped touchscreen area
> +
> +      This object can be used to describe a frame that restricts the area
> +      within touch events are reported, ignoring the events that occur outside
> +      this area. This is of special interest if the touchscreen is shipped
> +      with a physical overlay on top of it with a frame that hides some part
> +      of the original touchscreen area.
> +
> +      The x-origin and y-origin properties of this object define the offset of
> +      a new origin from where the touchscreen events are referenced.
> +      This offset is applied to the events accordingly. The x-size and y-size
> +      properties define the size of the overlay-touchscreen (effective area).
> +
> +      The following example shows the new touchscreen area and the new origin
> +      (0',0') for the touch events generated by the device.
> +
> +                   Touchscreen (full area)
> +         ┌────────────────────────────────────────┐
> +         │    ┌───────────────────────────────┐   │
> +         │    │                               │   │
> +         │    ├ y-size                        │   │
> +         │    │                               │   │
> +         │    │      overlay-touchscreen      │   │
> +         │    │                               │   │
> +         │    │                               │   │
> +         │    │            x-size             │   │
> +         │   ┌└──────────────┴────────────────┘   │
> +         │(0',0')                                 │
> +        ┌└────────────────────────────────────────┘
> +      (0,0)
> +
> +     where (0',0') = (0+x-origin,0+y-origin)

What happens if touchscreen-inverted-x/y are set?

Though the existing binding never defines what the non-inverted 
orientation is.

> +
> +    type: object
> +
> +    properties:
> +      x-origin:
> +        description: horizontal origin of the clipped area
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      y-origin:
> +        description: vertical origin of the clipped area
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      x-size:
> +        description: horizontal resolution of the clipped area
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      y-size:
> +        description: vertical resolution of the clipped area
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +        required:
> +          - x-origin
> +          - y-origin
> +          - x-size
> +          - y-size
> +
> +  overlay-buttons:
> +    description: list of nodes defining the buttons on the touchscreen
> +
> +      This object can be used to describe buttons on the touchscreen area,
> +      reporting the touch events on their surface as key events instead of
> +      the original touch events.
> +
> +      This is of special interest if the touchscreen is shipped with a
> +      physical overlay on top of it where a number of buttons with some
> +      predefined functionality are printed. In that case a specific behavior
> +      is expected from those buttons instead of raw touch events.
> +
> +      The overlay-buttons properties define a per-button area as well as an
> +      origin relative to the real touchscreen origin. Touch events within the
> +      button area are reported as the key event defined in the linux,code
> +      property. Given that the key events do not provide coordinates, the
> +      button origin is only used to place the button area on the touchscreen
> +      surface. Any event outside the overlay-buttons object is reported as a
> +      touch event with no coordinate transformation.
> +
> +      The following example shows a touchscreen with a single button on it
> +
> +              Touchscreen (full area)
> +        ┌───────────────────────────────────┐
> +        │                                   │
> +        │                                   │
> +        │   ┌─────────┐                     │
> +        │   │button 0 │                     │
> +        │   │KEY_POWER│                     │
> +        │   └─────────┘                     │
> +        │                                   │
> +        │                                   │
> +       ┌└───────────────────────────────────┘
> +     (0,0)
> +
> +      The overlay-buttons object can  be combined with the overlay-touchscreen
> +      object as shown in the following example. In that case only the events
> +      within the overlay-touchscreen object are reported as touch events.
> +
> +                  Touchscreen (full area)
> +        ┌─────────┬──────────────────────────────┐
> +        │         │                              │
> +        │         │    ┌───────────────────────┐ │
> +        │ button 0│    │                       │ │
> +        │KEY_POWER│    │                       │ │
> +        │         │    │                       │ │
> +        ├─────────┤    │  overlay-touchscreen  │ │
> +        │         │    │                       │ │
> +        │         │    │                       │ │
> +        │ button 1│    │                       │ │
> +        │ KEY_INFO│   ┌└───────────────────────┘ │
> +        │         │(0',0')                       │
> +       ┌└─────────┴──────────────────────────────┘
> +     (0,0)
> +
> +    type: object
> +
> +    patternProperties:
> +      '^button-':
> +        type: object
> +        description:
> +          Each button (key) is represented as a sub-node.
> +
> +        properties:
> +          label:
> +            $ref: /schemas/types.yaml#/definitions/string
> +            description: descriptive name of the button
> +
> +          linux,code: true
> +
> +          x-origin:
> +            description: horizontal origin of the button area
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          y-origin:
> +            description: vertical origin of the button area
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          x-size:
> +            description: horizontal resolution of the button area
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          y-size:
> +            description: vertical resolution of the button area
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +        required:
> +          - linux,code
> +          - x-origin
> +          - y-origin
> +          - x-size
> +          - y-size

We have the same properties defined twice. Move all the common ones to a 
$def entry and then reference it here and in overlay-touchscreen.

$defs:
  overlay-node:
    type: object
    properties:
      x-origin:
      ...

And then here:

'^button-':
  $ref: '#/$defs/overlay-node
  unevaluatedProperties: false

  properties:
    label:
      ...


Rob
