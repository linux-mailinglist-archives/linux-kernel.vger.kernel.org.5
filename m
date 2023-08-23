Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3102B785E33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbjHWRJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbjHWRJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:09:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD55E6D;
        Wed, 23 Aug 2023 10:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD9F62C07;
        Wed, 23 Aug 2023 17:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7589BC433CB;
        Wed, 23 Aug 2023 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692810589;
        bh=WPvAkPh8AunP/lNvri8BRVfUDHESTWdheGKzVZNfuQs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fPAdYWHFcJSmlFRtEquy4q0hkIj/keX9dvaPI0fAzpFs9SMJmKHM1W+0C5kRbp13D
         v0JGKX3SEbbiz5WqGUM+xjrfgotZPHwn7blD2aaY+/GqExIh8/d+9wyMpKWM9MbUFh
         gYc2jPggM7x5EXaMgM1jt/g9cT0da2qTs5lvVHpOT82i2nUSHKH2EkmoRHH0cRqTkj
         0UH7SBcH3rTAkU/lRdp4DN79JjzrKQ1mZd9R3yDM4iy70Z2pdCxBxkOO6XrXF9jFng
         ociCJI6PouPtW40u+HDSIIE/tT4bVSj/v/p4jAXYIJcTebZ54Wf4HAShtfQP72leid
         rovrzf3dsQtRA==
Received: (nullmailer pid 2496484 invoked by uid 1000);
        Wed, 23 Aug 2023 17:09:46 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     peteryin <peteryin.openbmc@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, johnny_huang@aspeedtech.com,
        joel@jms.id.au, linux-kernel@vger.kernel.org,
        peteryin <peter.yin@quantatw.com>, robh+dt@kernel.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@aj.id.au,
        eajames@linux.ibm.com
In-Reply-To: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
References: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
Message-Id: <169281058628.2496450.12875634767226591718.robh@kernel.org>
Subject: Re: [PATCH] Title: Select GPIO command source.
Date:   Wed, 23 Aug 2023 12:09:46 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Aug 2023 00:08:10 +0800, peteryin wrote:
> From: peteryin <peter.yin@quantatw.com>
> 
> Description:
>   The capability to choose the GPIO command source
> between ARM LPC and Coprocessor CPU is supported.
> 
> Test Plan:
> Get Bank gpio command source
>   e.g.
>   cd /sys/bus/platform/drivers/aspeed-command-source/
>   cat 1e780000.gpio-command-source/bank_abcd
>   ARM ARM ARM ARM
> 
> Set Bank gpio command source.
>   e.g.
>   cd /sys/bus/platform/drivers/aspeed-command-source/
> 
>   echo "A ARM" > 1e780000.gpio-command-source/bank_abcd
>   or
>   echo "A LPC" > 1e780000.gpio-command-source/bank_abcd
>   or$
>   echo "A COP" > 1e780000.gpio-command-source/bank_abcd
> 
> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
> ---
>  .../sysfs-driver-aspeed-gpio-command-source   |  24 ++
>  .../soc/aspeed/gpio-command-source.yaml       |  58 ++++
>  drivers/soc/aspeed/Kconfig                    |   9 +
>  drivers/soc/aspeed/Makefile                   |   1 +
>  drivers/soc/aspeed/aspeed-command-source.c    | 266 ++++++++++++++++++
>  5 files changed, 358 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
>  create mode 100644 drivers/soc/aspeed/aspeed-command-source.c
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml:38:3: [error] syntax error: expected <block end>, but found '?' (syntax)
./Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml:39:6: [error] missing starting space in comment (comments)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.example.dts'
Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml:38:3: expected <block end>, but found '?'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml:38:3: expected <block end>, but found '?'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230823160810.1067102-1-peteryin.openbmc@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

