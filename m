Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240007676D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjG1URA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjG1UQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:16:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074C4483;
        Fri, 28 Jul 2023 13:16:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6EEA621F5;
        Fri, 28 Jul 2023 20:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1DEC433C8;
        Fri, 28 Jul 2023 20:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690575416;
        bh=z+gdMsxHU/7YKL9vhgSuvNK2Nl2t+BdQQB04fK3kaxg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VjV2emDeaa46kCYj97nEakfERp2X5HQbMXwwOHf2lVmTjVx4+PL2sCt9kQhVtU9qP
         SeGnCbtalKjl4bHUldfHzpIKa4A0O9XqQO2BlfwgAhSvClEBVlZYGHpzetRJ/mZJB1
         SbCiV6gLdTk+ptQPtEfn8mpF6iAY7kbT3bQn1gBfpiEDiL9TJdbfcqywxXJdcUcfFI
         sRes9xYF8bl+SFStNhOMlSOfA3XmnWQ1GVhGsbunaQ7m5/rCbFVvo/pSNTPn6Iec9b
         IqnwPmC2Umyaazx9jw1tWHwIvpxhrCbtPYVkSL4IxwGUwzNjwnnhRwZGyCrt9LPgmY
         vImnhSw11L+Qg==
Received: (nullmailer pid 1272797 invoked by uid 1000);
        Fri, 28 Jul 2023 20:16:54 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <ZMQU7ap9CxfY5eIu@standask-GA-A55M-S2HP>
References: <ZMQU7ap9CxfY5eIu@standask-GA-A55M-S2HP>
Message-Id: <169057541402.1272771.5559155896859483307.robh@kernel.org>
Subject: Re: [RFC] dt-bindings: gpio: brcm,kona-gpio: convert to YAML
Date:   Fri, 28 Jul 2023 14:16:54 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Jul 2023 21:20:13 +0200, Stanislav Jakubek wrote:
> Convert Broadcom Kona family GPIO controller bindings to DT schema.
> 
> Changes during conversion:
>   - add used, but previously undocumented SoC-specific compatibles
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> RFC since dt_binding_check is giving me these errors/warnings:
> 
> Documentation/devicetree/bindings/gpio/brcm,kona-gpio.example.dts:21.23-34.11: Warning (interrupts_property): /example-0/gpio@35003000: Missing interrupt-parent
> 
> The old txt bindings and all current DTs do not use interrupt-parent AFAICT,
> so I'm not sure what to do about that.
> 
> Documentation/devicetree/bindings/gpio/brcm,kona-gpio.example.dtb: gpio@35003000: interrupts: [[0], [106], [4], [0], [115], [4], [0], [114], [4], [0], [113], [4], [0], [112], [4], [0], [111], [4]] is too long
> 
> Here I'm not even sure what the issue is.
> 
>  .../bindings/gpio/brcm,kona-gpio.txt          | 52 -------------
>  .../bindings/gpio/brcm,kona-gpio.yaml         | 77 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 78 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/gpio/brcm,kona-gpio.example.dts:21.23-34.11: Warning (interrupts_property): /example-0/gpio@35003000: Missing interrupt-parent
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.example.dtb: gpio@35003000: interrupts: [[0], [106], [4], [0], [115], [4], [0], [114], [4], [0], [113], [4], [0], [112], [4], [0], [111], [4]] is too long
	from schema $id: http://devicetree.org/schemas/gpio/brcm,kona-gpio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ZMQU7ap9CxfY5eIu@standask-GA-A55M-S2HP

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

