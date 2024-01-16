Return-Path: <linux-kernel+bounces-27920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCDE82F7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14211F25F38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E185C79;
	Tue, 16 Jan 2024 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt2FDwLk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8385C59;
	Tue, 16 Jan 2024 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434586; cv=none; b=krqc0sDUbzKVVQzDO1lpQb6H+i6UsEFXiYQ1imhr0SJ6x58slbtBwQtz0PH+D0gD6gzMN/ve0+A/1KRk7hNk/OlaS8E0oPsYofl46e91LE37p0z+d7Mp4nv3+S2FQbAJF2MXAx8bMnZsFk+Uu6uP4PIKt4AITUy7vI+QueCaVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434586; c=relaxed/simple;
	bh=nDrC9wTsCV4ph2iLOi/kjmUrKVaAS25bEBAFssh/F98=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=g37O4MuPxP2serrZusp7S2nxo2Svbyk4+VFr3A0CdjpBXH1TzjdYgL2v2YN3a2rpVUt+52mnU9wVmjuyu0ZWZhwwMcNR02lNpwymHcG3uaiJSkcs3LVRk+pu88DMy+fuCtF/0drBu5mc4Dm8gedwc/vf1AKRnGhLTTAo4CMQWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt2FDwLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14B4C43390;
	Tue, 16 Jan 2024 19:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434586;
	bh=nDrC9wTsCV4ph2iLOi/kjmUrKVaAS25bEBAFssh/F98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rt2FDwLkrEvke5xX3NG2XsTzU/1v1AFMfYT3gFwaDjFtMNSx6SOqH1XIkRtJBOoyh
	 mwsMlpc8GweBANnXi89yX+fAIpoxT6EWsyWKMKpLs4FIKElC12KDINnLVfxEo3AMdY
	 XEhkRRLSfe4V14sKLBqM7RP+DW8+GxDVF9O5iIf8FRYDiDm++l96OruiFu1UqmINk4
	 cnmmpOfsCcqOr4VCcRnE9QcR8OwpiDKoGUdCPU0yRunpacKpAhO5bUH5bNgi3DTtO8
	 4n2bT1APCSEQmT7Q0G011OkJoWArrWMb0WDzQ0TdzNVYmfRNshybGniknqm8+EhrkF
	 AQy2aI8+dwU2w==
Date: Tue, 16 Jan 2024 13:49:43 -0600
From: Rob Herring <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: conor.dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, lee@kernel.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-pwm@vger.kernel.org, linux4microchip@microchip.com
Subject: Re: [PATCH v2 1/3] dt-bindings: display: convert Atmel's HLCDC to DT
 schema
Message-ID: <20240116194943.GA301272-robh@kernel.org>
References: <20240116113800.82529-1-dharma.b@microchip.com>
 <20240116113800.82529-2-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116113800.82529-2-dharma.b@microchip.com>

On Tue, Jan 16, 2024 at 05:07:58PM +0530, Dharma Balasubiramani wrote:
> Convert the existing DT binding to DT schema of the Atmel's HLCDC display
> controller.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> changelog
> v1 -> v2
> - Remove the explicit copyrights.
> - Modify filename like compatible.
> - Modify title (drop words like binding/driver).
> - Modify description actually describing the hardware and not the driver.
> - Remove pinctrl properties which aren't required.
> - Ref endpoint and not endpoint-base.
> - Drop redundant info about bus-width description and add ref to video-interfaces.
> - Move 'additionalProperties' after 'Required'.
> - Drop parent node and it's other sub-device node which are not related here.
> - Add compatible to example 2 and add comments that bus-width is the diff between two examples.
> ---
>  .../atmel/atmel,hlcdc-display-controller.yaml | 110 ++++++++++++++++++
>  .../bindings/display/atmel/hlcdc-dc.txt       |  75 ------------
>  2 files changed, 110 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml b/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
> new file mode 100644
> index 000000000000..f022c294cfbc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/atmel/atmel,hlcdc-display-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel's High LCD Controller (HLCDC)
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +
> +description: |
> +  The LCD Controller (LCDC) consists of logic for transferring LCD image
> +  data from an external display buffer to a TFT LCD panel. The LCDC has one
> +  display input buffer per layer that fetches pixels through the single bus
> +  host interface and a look-up table to allow palletized display
> +  configurations.
> +
> +properties:
> +  compatible:
> +    const: atmel,hlcdc-display-controller
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  port@0:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +    description:
> +      Output endpoint of the controller, connecting the LCD panel signals.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +      reg:
> +        maxItems: 1
> +
> +      endpoint:
> +        $ref: /schemas/graph.yaml#/$defs/endpoint
> +        unevaluatedProperties: false
> +        description:
> +          Endpoint connecting the LCD panel signals.
> +
> +        properties:
> +          bus-width:
> +            description: Endpoint bus width.
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            enum: [ 12, 16, 18, 24 ]
> +
> +required:
> +  - '#address-cells'
> +  - '#size-cells'
> +  - compatible
> +  - port@0
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    //Example 1
> +
> +    display-controller {
> +      compatible = "atmel,hlcdc-display-controller";
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      port@0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <0>;
> +
> +        hlcdc_panel_output: endpoint@0 {
> +          reg = <0>;
> +          remote-endpoint = <&panel_input>;
> +        };
> +      };
> +    };
> +
> +  - |
> +    //Example 2 With a video interface override to force rgb565, bus-width=16
> +
> +    display-controller {
> +      compatible = "atmel,hlcdc-display-controller";
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      port@0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <0>;
> +        hlcdc_panel_output2: endpoint@0 {
> +          reg = <0>;
> +          remote-endpoint = <&panel_input>;
> +          bus-width = <16>;
> +        };
> +      };
> +    };

Just 1 extra property doesn't justify 2 examples.

In any case, drop the partial examples and just have 1 complete example 
in the MFD binding schema.

Rob

