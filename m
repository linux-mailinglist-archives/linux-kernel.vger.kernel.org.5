Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6C7C7A63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443104AbjJLX03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443094AbjJLX01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:26:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE17C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:26:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176C8C433CA;
        Thu, 12 Oct 2023 23:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697153185;
        bh=qNqWoA/ZDLB/uXCHNS8ySDtf00nZP74HHvVGjttkErQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HKWW41YQy8EqNpNGM+UUKpc+RgJDT9JWw0QCWmqprmhVz5h0QulhwY8JfidW38YWT
         kreoZcDSL4oFttV2dRMx+v2DuddjZI0/yB/HA2uHlh98EADBUMpH726kyIFwKlvg4x
         8CJJIb4M1nW0ldfOVGb3I4FZGqr8rxTYWeAizA+4jmaUHuz2CR34yKnN216yLYNO9t
         Q7yNlM3mwpsje2zZ76/9y5RtJ3YPg6h6oU9IImpklyO1+j1SkUf27tsOCg0D3I3V9j
         N85228TKgf371oxZ1kXdwAYp8u65FWKwZgXKAWOz/sxsLS4WwyMeuCy+hoGBd4fDD1
         wm7fzxeKRwjbA==
Received: (nullmailer pid 2140553 invoked by uid 1000);
        Thu, 12 Oct 2023 23:26:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org>
References: <20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org>
 <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org>
Message-Id: <169715318309.2140513.13293051505659071749.robh@kernel.org>
Subject: Re: [PATCH 2/3] RFC: dt-bindings: marvell: Rewrite in schema
Date:   Thu, 12 Oct 2023 18:26:23 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Oct 2023 00:35:15 +0200, Linus Walleij wrote:
> This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> in YAML schema.
> 
> The current text binding says:
>   WARNING: This binding is currently unstable. Do not program it into a
>   FLASH never to be changed again. Once this binding is stable, this
>   warning will be removed.
> 
> Well that never happened before we switched to YAML markup,
> we can't have it like this, what about fixing the mess?
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 249 +++++++++++++++++++++
>  .../devicetree/bindings/net/dsa/marvell.txt        | 109 ---------
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 250 insertions(+), 110 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.example.dtb: switch@0: mdio-external: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.example.dtb: switch@0: Unevaluated properties are not allowed ('mdio-external' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

