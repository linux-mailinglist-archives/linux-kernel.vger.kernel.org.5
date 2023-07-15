Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158F7754662
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 04:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjGOCrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 22:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGOCrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 22:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C741980;
        Fri, 14 Jul 2023 19:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBDB561E19;
        Sat, 15 Jul 2023 02:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65F7C433C8;
        Sat, 15 Jul 2023 02:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689389234;
        bh=cSL9tSXE1IYkMTAzMwc2gHb95tSzr+oNTr7zMsZ9vDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqCnKzlOw+c5jOXlp0PuUA0EL9dIzvtBPSgh8F0gOLHJ/jgfYWhBDXBs9q3iQIqdJ
         kPmdeohANF8QOE26tIyLiEkzmqXEMQ7Xgh4Sb4F9RzhElqnbv/DXRg7Xglt8+8F5Tx
         AmI3tC8lfFdDxA3Ji80o83oRFLu3/YA1tpIEmnqzmWVGM+ge7225yZRy9gkjW94U0w
         Ms0+LAxH6W0GtpEk360OpAUPHpNDjbBYmouNOpiKDoLnfz/1D+lm8W9BfVCdjokevN
         6JAeg/62rVzsY/jP2tTyDd94I9lAIuTPzoyHUDt+/5jLKK+qqURCrVk3k3M2QMyl3S
         viiIK1nEz4k+w==
Received: (nullmailer pid 875753 invoked by uid 1000);
        Sat, 15 Jul 2023 02:47:11 -0000
Date:   Fri, 14 Jul 2023 20:47:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samin Guo <samin.guo@starfivetech.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Message-ID: <20230715024711.GB872287-robh@kernel.org>
References: <20230714101406.17686-1-samin.guo@starfivetech.com>
 <20230714101406.17686-2-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714101406.17686-2-samin.guo@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 06:14:05PM +0800, Samin Guo wrote:
> The motorcomm phy (YT8531) supports the ability to adjust the drive
> strength of the rx_clk/rx_data.
> 
> The YT8531 RGMII LDO voltage supports 1.8V/3.3V, and the
> LDO voltage can be configured with hardware pull-up resistors to match
> the SOC voltage (usually 1.8V). The software can read the registers
> 0xA001 obtain the current LDO voltage value.
> 
> When we configure the drive strength, we need to read the current LDO
> voltage value to ensure that it is a legal value at that LDO voltage.
> 
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
> ---
>  .../bindings/net/motorcomm,yt8xxx.yaml        | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
> index 157e3bbcaf6f..097bf143af35 100644
> --- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
> @@ -52,6 +52,52 @@ properties:
>        for a timer.
>      type: boolean
>  
> +  motorcomm,rx-clk-driver-strength:
> +    $ref: /schemas/types.yaml#/definitions/uint32

As the units are uA, drop the type and add '-microamp' suffix. 
'motorcomm,rx-clk-drv-microamp' is probably sufficient.

> +    description: |
> +      drive strength of rx_clk rgmii pad.
> +      |----------------------------------|
> +      |        rx_clk ds map table       |
> +      |----------------------------------|
> +      | DS(3b) |  wol@1.8v  |  wol@3.3v  |
> +      |________|_________________________|
> +      |        | current(uA)| current(uA)|
> +      |   000  |     1200   |    3070    |
> +      |   001  |     2100   |    4080    |
> +      |   010  |     2700   |    4370    |
> +      |   011  |     2910   |    4680    |
> +      |   100  |     3110   |    5020    |
> +      |   101  |     3600   |    5450    |
> +      |   110  |     3970   |    5740    |
> +      |   111  |     4350   |    6140    |
> +      |--------|------------|------------|
> +    enum: [ 1200, 2100, 2700, 2910, 3070, 3110, 3600, 3970,
> +            4080, 4350, 4370, 4680, 5020, 5450, 5740, 6140 ]
> +    default: 2910
> +
> +  motorcomm,rx-data-driver-strength:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      drive strength of rx_data/rx_ctl rgmii pad.
> +      |----------------------------------|
> +      |        rx_data ds map table      |
> +      |----------------------------------|
> +      | DS(3b) |  wol@1.8v  |  wol@3.3v  |
> +      |________|_________________________|
> +      |        | current(uA)| current(uA)|
> +      |   000  |     1200   |    3070    |
> +      |   001  |     2100   |    4080    |
> +      |   010  |     2700   |    4370    |
> +      |   011  |     2910   |    4680    |
> +      |   100  |     3110   |    5020    |
> +      |   101  |     3600   |    5450    |
> +      |   110  |     3970   |    5740    |
> +      |   111  |     4350   |    6140    |
> +      |--------|------------|------------|
> +    enum: [ 1200, 2100, 2700, 2910, 3070, 3110, 3600, 3970,
> +            4080, 4350, 4370, 4680, 5020, 5450, 5740, 6140 ]
> +    default: 2910
> +
>    motorcomm,tx-clk-adj-enabled:
>      description: |
>        This configuration is mainly to adapt to VF2 with JH7110 SoC.
> -- 
> 2.17.1
> 
