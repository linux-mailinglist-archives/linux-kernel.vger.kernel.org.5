Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE08F779132
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjHKOBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjHKOBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:01:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19015EA;
        Fri, 11 Aug 2023 07:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9388F65F21;
        Fri, 11 Aug 2023 14:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49620C433CB;
        Fri, 11 Aug 2023 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762464;
        bh=0s5wP3CAzd2q8jr6ZDnh6gZc7XWv0qM2wbnelK+oBfw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FRi2NcPCRnlo17mCf2hzdsixSu/xX7rlDTuKlIMaJDBQh+bALd3nbIKNK3AB/NHQK
         yaLT0NgeD/cSBAMuHc0zW5s3ECPqvHxoVzTAZd+KiCRUHAkKbO9ZQln73Zf+zROf6E
         wuwaurtj21JT7C4OVvM2X+t8s85focUM1GUWM14lM6fMYHf6lUpwq0eZjMjUtJmRaL
         m3vvpFsg4CPyGoaZgYBG/WapMTwByJiK1EaciwPMU5t+/C353ThFXqQFmHIyWocnWQ
         DO7COUWj2rniSnawsbmDjZ2SkTazULHsuqzXLHquTrTIcB7gpZzM1K9aeONCZiD3nC
         3Rv0cgNFKXyCQ==
Received: (nullmailer pid 3323005 invoked by uid 1000);
        Fri, 11 Aug 2023 14:00:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org,
        Peter Griffin <peter.griffin@linaro.org>
In-Reply-To: <20230810-dt-bindings-sti-v1-1-4f73ffc37d87@linaro.org>
References: <20230810-dt-bindings-sti-v1-1-4f73ffc37d87@linaro.org>
Message-Id: <169176235800.3319973.14484381470653978029.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Convert the sti pin controller bindings
 to YAML
Date:   Fri, 11 Aug 2023 08:00:55 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 23:53:17 +0200, Linus Walleij wrote:
> This rewrites the STi pin control bindings to use YAML.
> 
> These bindings came early in the development of pin control
> bindings so they are a bit obscure, and required a bit of
> uncommon regexp work.
> 
> The reason why these bindings need to be converted and
> preserved can be seen in the two new added compatibles,
> which are for the SpaceX Starlink chip "gllcff" which uses
> a derivative of this pin controller.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-st.txt     | 174 ---------------
>  .../bindings/pinctrl/st,sti-pinctrl.yaml           | 238 +++++++++++++++++++++
>  2 files changed, 238 insertions(+), 174 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
group: size (9) error for type phandle-array
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.example.dtb: nand-pins: group: b'nand_grp\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
group: size (9) error for type phandle-array
pin: size (7) error for type phandle-array
group: size (11) error for type phandle-array
group: size (10) error for type phandle-array
group: size (10) error for type phandle-array
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.example.dtb: nand-pins: group: b'nand_grp\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.example.dtb: gpio35_alt-pins: pin: b'gpio35\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.example.dtb: dectpd-pins: group: b'dectpd_grp\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.example.dtb: dsl_gpio8-pins: group: b'dsl_gpio8\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.example.dtb: dsl_gpio9-pins: group: b'dsl_gpio9\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
group: size (10) error for type phandle-array
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.example.dtb: uart1-pins: group: b'uart1_grp\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/afe/temperature-transducer.example.dtb: temperature-sensor-0: sense-offset-millicelsius: 'anyOf' conditional failed, one must be fixed:
	4294694146 is greater than the maximum of 2147483647
	from schema $id: http://devicetree.org/schemas/property-units.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/afe/temperature-transducer.example.dtb: temperature-sensor-1: sense-offset-millicelsius: 'anyOf' conditional failed, one must be fixed:
	4294694146 is greater than the maximum of 2147483647
	from schema $id: http://devicetree.org/schemas/property-units.yaml#
group: size (9) error for type phandle-array
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.example.dtb: nand-pins: group: b'nand_grp\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
group: size (9) error for type phandle-array
pin: size (7) error for type phandle-array
group: size (11) error for type phandle-array
group: size (10) error for type phandle-array
group: size (10) error for type phandle-array
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.example.dtb: nand-pins: group: b'nand_grp\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.example.dtb: gpio35_alt-pins: pin: b'gpio35\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.example.dtb: dectpd-pins: group: b'dectpd_grp\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.example.dtb: dsl_gpio8-pins: group: b'dsl_gpio8\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.example.dtb: dsl_gpio9-pins: group: b'dsl_gpio9\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
group: size (10) error for type phandle-array
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.example.dtb: uart1-pins: group: b'uart1_grp\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/sc27xx-fg.example.dtb: battery: ocv-capacity-table-0:0: [4185000, 100, 4113000, 95, 4066000, 90, 4022000, 85, 3983000, 80, 3949000, 75, 3917000, 70, 3889000, 65, 3864000, 60, 3835000, 55, 3805000, 50, 3787000, 45, 3777000, 40, 3773000, 35, 3770000, 30, 3765000, 25, 3752000, 20, 3724000, 15, 3680000, 10, 3605000, 5, 3400000, 0] is too long
	from schema $id: http://devicetree.org/schemas/power/supply/battery.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/battery.example.dtb: battery: ocv-capacity-table-0:0: [4185000, 100, 4113000, 95, 4066000, 90] is too long
	from schema $id: http://devicetree.org/schemas/power/supply/battery.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/battery.example.dtb: battery: ocv-capacity-table-1:0: [4200000, 100, 4185000, 95, 4113000, 90] is too long
	from schema $id: http://devicetree.org/schemas/power/supply/battery.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/battery.example.dtb: battery: ocv-capacity-table-2:0: [4250000, 100, 4200000, 95, 4185000, 90] is too long
	from schema $id: http://devicetree.org/schemas/power/supply/battery.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/battery.example.dtb: battery: ocv-capacity-celsius: 'anyOf' conditional failed, one must be fixed:
	[4294967286, 0, 10] is too long
	4294967286 is greater than the maximum of 2147483647
	from schema $id: http://devicetree.org/schemas/property-units.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/battery.example.dtb: battery: operating-range-celsius: 'anyOf' conditional failed, one must be fixed:
	[4294967266, 50] is too long
	4294967266 is greater than the maximum of 2147483647
	from schema $id: http://devicetree.org/schemas/property-units.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/battery.example.dtb: battery: ambient-celsius: 'anyOf' conditional failed, one must be fixed:
	[4294967291, 50] is too long
	4294967291 is greater than the maximum of 2147483647
	from schema $id: http://devicetree.org/schemas/property-units.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810-dt-bindings-sti-v1-1-4f73ffc37d87@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

