Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C86F7F06DA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjKSOap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjKSOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:30:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE757E6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 06:30:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83B8C433C8;
        Sun, 19 Nov 2023 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700404236;
        bh=eOMs0R+u0SwhjuMi1iHFc1y5jybj049QsB5U6zvo1ks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YzHxS9EojFktpb2cgsh3ypQjf/0Q/oJXIW4Vjk/U3YTiSL9PjhNqsqGMOqVJA4pcO
         4AjzclOu6PJoxdmOfOWS4dlaYsnQro8pA4IKifjGXEc+AI1V/fOBaEa3F9TMI0PWoh
         X5UbGcuJI7pJb42FD0IJJ6dzjIy8ilUT+5LvMhcSw+0/iSCQF9lsMFXm97u0w0TRcR
         hDSgJ81/0Zq2GbdnDX+wvesmxWJj66yYWWgPy0YMMp7vRLpeSDnPX06gH/CfFpnDMl
         BQ0bBSn8YEZp/b4VVNwH9+seTSwfTWM7X+3A65VL6wx9dfOkxczVTx7sex/1GV8KXg
         NEv6e/vVPNaZA==
Date:   Sun, 19 Nov 2023 14:30:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: add support for Vishay
 VEML6075
Message-ID: <20231119143015.205c0219@jic23-huawei>
In-Reply-To: <20231110-veml6075-v1-2-354b3245e14a@gmail.com>
References: <20231110-veml6075-v1-0-354b3245e14a@gmail.com>
        <20231110-veml6075-v1-2-354b3245e14a@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2023 05:58:04 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The Vishay VEML6075 is a 16-bit digital UVA and UVB sensor with I2C
> interface.
> 
> Add bindings and an example for the Vishay VEML6075.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hmm. This is a very simple device and we have a bunch of similar vishay light
sensor bindings. One option here would be to combine all the binding
docs and add an explicit check for no interrupts being specified for this
compatible.

Perhaps that should be a follow up patch though given how simple this is
and a desire to not slow down merging the driver.

One comment inline,

Jonathan


> ---
>  .../bindings/iio/light/vishay,veml6075.yaml        | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> new file mode 100644
> index 000000000000..f8e2db29af42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/vishay,veml6075.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Vishay VEML6075 UVA and UVB sensor
> +
> +maintainers:
> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: vishay,veml6075
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor

The description doesn't really add anything.
  vdd-supply: true

is sufficient.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        uv-sensor@10 {
> +            compatible = "vishay,veml6075";
> +            reg = <0x10>;
> +            vdd-supply = <&vdd_reg>;
> +        };
> +    };
> +...
> 

