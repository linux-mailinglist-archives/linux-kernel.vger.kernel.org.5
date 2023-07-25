Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48148761974
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjGYNKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGYNKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8EE1FEB;
        Tue, 25 Jul 2023 06:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94F256170C;
        Tue, 25 Jul 2023 13:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5FAC433C7;
        Tue, 25 Jul 2023 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690290609;
        bh=kYvQojgLLojniCbFIoFeMLpW0eX9KsKVV5P8NVvO6ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SK+lo+5UzxBUqzEY8EqmRQBIQgCMWZnrx3gERo09M9o9URM7O48Gbru8Ul1+aLEUv
         dNZcG4yl0TiQy2vv54PBxwpfAYig2kRuA9f6jq0QbbOCF19QIQ+j6RDl+8wgSVhIfT
         qz32fB2+oYATYyGkg1wJC7IkQQ0V4oue9KfXmq+7mkD7FXAGL+5ihuYwg+z3Hbfz0a
         RtcjttrBO24GrVzckHFE+EdWLuAopSwca1THVRuOiOn8ZT04hlWEvcB8XbeAof4xth
         KXkICYU8KMz/OgBtEco3U748Q+3n6t/cqi4yJsk+JzLmzQZNRNDxJk11F0LqkMqedQ
         GHbsDqGp8hrdA==
Received: (nullmailer pid 2911495 invoked by uid 1000);
        Tue, 25 Jul 2023 13:10:06 -0000
Date:   Tue, 25 Jul 2023 07:10:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Message-ID: <20230725131006.GA2879331-robh@kernel.org>
References: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:40:26PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The TDA38640 has a bug in SVID mode and to enable a workaround
> remove the TDA38640 from trivial-devices and add a complete schema.
> 
> The schema adds the custom property 'infineon,en-pin-fixed-level' to
> signal a fixed level on the ENABLE pin and to enable the workaround.
> When the ENABLE pin is left floating it's internally pulled low.
> 
> If not specified the driver will continue to use the PMBUS_OPERATION
> register to enable the regulator. When specified the driver will use
> the PMBUS_ON_OFF_CONFIG register to enable the regulator.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../hwmon/pmbus/infineon,tda38640.yaml        | 50 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 50 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> new file mode 100644
> index 000000000000..520112e4e271
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,tda38640.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon TDA38640 Synchronous Buck Regulator with SVID and I2C
> +
> +description: |
> +  The Infineon TDA38640 is a 40A Single-voltage Synchronous Buck
> +  Regulator with SVID and I2C designed for Industrial use.
> +
> +  Datasheet: https://www.infineon.com/dgdl/Infineon-TDA38640-0000-DataSheet-v02_04-EN.pdf?fileId=8ac78c8c80027ecd018042f2337f00c9
> +
> +properties:
> +  compatible:
> +    enum:
> +      - infineon,tda38640
> +
> +  reg:
> +    maxItems: 1
> +
> +  infineon,en-pin-fixed-level:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Fixed level of the ENABLE pin. When specified the PMBUS_ON_OFF_CONFIG
> +      register is used to enable the regulator instead of the PMBUS_OPERATION
> +      register to workaround a bug of the tda38640 when operating in SVID-mode.
> +      If the ENABLE pin is left floating the internal pull-down causes a low
> +      level on the pin.

Neither this nor the commit message answers how do I decide if I set 
this property or not? How you work-around it is not that relevant to the 
binding.

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
> +        tda38640@40 {
> +            compatible = "infineon,tda38640";
> +            reg = <0x40>;
> +        };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 6e24c4d25ec3..2b1fbb2a672b 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -151,8 +151,6 @@ properties:
>            - infineon,slb9645tt
>              # Infineon SLB9673 I2C TPM 2.0
>            - infineon,slb9673
> -            # Infineon TDA38640 Voltage Regulator
> -          - infineon,tda38640
>              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>            - infineon,tlv493d-a1b6
>              # Infineon Multi-phase Digital VR Controller xdpe11280
> 
> base-commit: 55612007f16b5d7b1fb83a7b0f5bb686829db7c7
> -- 
> 2.41.0
> 
