Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430797B2250
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjI1Q3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1Q3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:29:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AC81A3;
        Thu, 28 Sep 2023 09:29:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A15C433C8;
        Thu, 28 Sep 2023 16:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695918555;
        bh=LG+moJvLbepueQzWQQecSwms6HjXEU/1gKFwfkORCTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouERZ/MprezX3a5c9ZZTjxPB9BLKv1tLho8yqQpBMqsMzMWRz0B4CIdMajfvsmgFB
         LxmJuqTfegmUH3a3wkWcG+NUR3YOdX6FZcWHNtIvZn11z4XbdcFEBuiWYPMLHleWrK
         XIcOJQkB0VhqWE02X/LBIZSDa3CBgQjLKZ35XoD7DXVXh9IvzEHx0jVHcMDyTJNwNa
         2MP5vAoPmI9Wvjc+16LAt6/x3imPZ4wih39MQw+2pPsJTEntU5pRcax9AG+9ZRdGIg
         ji/Povq0mb9W4jHO/gHapz+oSIZOHADJkgoNsgtJYgl9nlxok7GoRx8qhMeUFb52XJ
         jxQlWNHGz7Hcw==
Received: (nullmailer pid 815154 invoked by uid 1000);
        Thu, 28 Sep 2023 16:29:12 -0000
Date:   Thu, 28 Sep 2023 11:29:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93
Message-ID: <169591855248.815095.5147614277877224854.robh@kernel.org>
References: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
 <20230926-vf610-gpio-v4-2-b57b7f6e8368@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926-vf610-gpio-v4-2-b57b7f6e8368@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Sep 2023 11:33:18 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8ULP and i.MX93 actually has two interrupts for each gpio
> controller, one for Trustzone non-secure world, one for secure world.
> 
> And they has one register based, not two as i.MX7ULP or VF610.
> 
> Although the Linux Kernel driver gpio-vf610.c could work with
> fsl,imx7ulp-gpio compatible, it is based on some tricks did in
> device tree with some offset added to base address.
> 
> So actually i.MX8ULP/i.MX93 is not compatible with i.MX7ULP.
> 
> Last, i.MX93 is directly derived from i.MX8ULP, so make i.MX93 GPIO
> compatible with i.MX8ULP
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/gpio/gpio-vf610.yaml       | 36 +++++++++++++++++++---
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

