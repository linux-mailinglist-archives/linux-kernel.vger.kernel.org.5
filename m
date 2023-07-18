Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2502375745A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGRGiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjGRGiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71D10E2;
        Mon, 17 Jul 2023 23:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF2CE61484;
        Tue, 18 Jul 2023 06:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2E2C433CA;
        Tue, 18 Jul 2023 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689662272;
        bh=lkqYV4xx86Ti2v26sOBZLYVym3rSZZUqRoPkM+IKoIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErVVeclVfGNmw++ELI2ou+/DJlthBIAb8F+aOVs2HNeAeXox2fhR4yU/63Vldz/Ho
         fX2HnwwDRgt44w5Hxp7h5qjarW2E4bzDoLsCzKwvckViiTKS8rRMXIT7lUpCmBiMQ4
         cqvAv6Er76p9wv3yLZND7LmDKTf/V40xIEhm9ZE+4//X6h3x4rU8yb+OE/NhajahNH
         UtbKFVmFqB9NkvULpl+OBVFo66DEdz5hyu0yQ/nNktnKdWXttolPgyewitgThonTCs
         YxcLZLGCx3c4aEYC5K5N7/rQ7LRoM5fOVpYY7H0fdJ39deYqsa9Qp4FaGKCkH0SGjM
         W3IKaoLF/9IIg==
Date:   Tue, 18 Jul 2023 14:37:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
Message-ID: <20230718063715.GL9559@dragon>
References: <20230705174932.3652479-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705174932.3652479-1-hugo@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 01:49:32PM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> USB OTG is currently broken on the Variscite Symphony EVK and imx8mn
> nano SOM.
> 
> The PTN5150 circuitry on newer versions of the Symphony EVK board has
> a non-standard configuration in which the PTN5150 IRQ pin is left
> unconnected, and the PTN5150 ID pin is connected to GPIO1_IO11. This
> requires changes to the ptn5150 driver to support this new mode.
> Variscite have indicated their intention to submit those changes
> upstream.
> 
> In the meantime, import device tree changes from linux-5.15 branch of
> varigit repos to at least make the USB OTG port operate correctly in
> host mode.
> 
> Fixes: 7358e05bddca ("arm64: dts: imx8mn-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MN")

Has USB OTG been ever worked at all?  If the answer is no, it's not
a fix but a new feature, and I would suggest you rework the patch
subject and drop the Fixes tag.

Shawn

> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> Link: [v1] https://lkml.org/lkml/2023/7/4/702
> 
> Changes from v1:
> - Add comments about PTN5150 IRQ/ID line connections
> - Remove "typec1_con: connector" node
> - Change IRQ type to IRQ_TYPE_EDGE_FALLING
> 
>  .../dts/freescale/imx8mn-var-som-symphony.dts | 32 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> index 406a711486da..a7a57442cb81 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> @@ -1,11 +1,14 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> + * Supports Symphony evaluation board versions >= 1.4a.
> + *
>   * Copyright 2019-2020 Variscite Ltd.
>   * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
>   */
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/usb/pd.h>
>  #include "imx8mn-var-som.dtsi"
>  
>  / {
> @@ -100,14 +103,26 @@ enet-sel-hog {
>  		};
>  	};
>  
> +	/*
> +	 * For Symphony board version <= 1.4, the PTN5150 IRQ pin is connected
> +	 * to GPIO1_IO11 on the SoM (R106 present, R132 absent). From Symphony
> +	 * board version >= 1.4a, the PTN5150 ID pin is connected to GPIO1_IO11
> +	 * on the SoM (R106 absent, R132 present).
> +	 */
>  	extcon_usbotg1: typec@3d {
>  		compatible = "nxp,ptn5150";
>  		reg = <0x3d>;
>  		interrupt-parent = <&gpio1>;
> -		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_ptn5150>;
>  		status = "okay";
> +
> +		port {
> +			typec1_dr_sw: endpoint {
> +				remote-endpoint = <&usb1_drd_sw>;
> +			};
> +		};
>  	};
>  };
>  
> @@ -148,8 +163,21 @@ &uart3 {
>  };
>  
>  &usbotg1 {
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	usb-role-switch;
>  	disable-over-current;
> -	extcon = <&extcon_usbotg1>, <&extcon_usbotg1>;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	status = "okay";
> +
> +	port {
> +		usb1_drd_sw: endpoint {
> +			remote-endpoint = <&typec1_dr_sw>;
> +		};
> +	};
>  };
>  
>  &iomuxc {
> 
> base-commit: d528014517f2b0531862c02865b9d4c908019dc4
> -- 
> 2.30.2
> 
