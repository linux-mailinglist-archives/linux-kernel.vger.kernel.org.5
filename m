Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957477C8DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjJMTSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMTSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:18:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97C7A9;
        Fri, 13 Oct 2023 12:18:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4054f790190so27930335e9.2;
        Fri, 13 Oct 2023 12:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697224682; x=1697829482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iit3JEMy1ldZPVE3Qn48s36Bx3IDXl6/hu1ThfQ0zpw=;
        b=U5IUudSaW06NWXcmsSe/ddmADbx3tLcCN4zJpkxa85ut4Z3Ws/A30hSLcpn0IN2V0E
         v85qG37t8syg77SClcwsAB3n2C634dDYkJlHAopTvMerr67BnGKT5XTTqNhsQASEgQ2m
         SOTIAeML3AKQGUTRufbw/idBrDOLdug6DEwzlby/mVrm+KrvhHaVH8eHW11CRq8UEVnX
         RhIf8iAEKbq5/bOcSzp2rP1pb63KBH2ms5shRBVR/150Bk93SyNpMZ5M6b2KG8Zr9ufD
         x0g2RBbxpBh/NNgoFj0F5Qdt1//FXIYsY1irWjvKztak9mOZluTN1cT+3AZzfspyzwjW
         SwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697224682; x=1697829482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iit3JEMy1ldZPVE3Qn48s36Bx3IDXl6/hu1ThfQ0zpw=;
        b=rK9Ful8v7VKpAQv2wibpVeRGagJxXgHLqnXkE5d4WfZ7rlZKnwWN8/tdpoCgS3Q2yK
         nl+6t3SwmDVLfCnGBPhb7B/xk4Wck23+3+/ZjC6+rhw1Se+qvy8RAOL4ijg9rYoIfwP8
         y5Cb2C6XUj9PMZWKCgfFCLkF6aoM0r7mxtRp2VvQ2QAciExSjhJMrRD1VQI2S5nW8ieM
         cnIjneU082+fHLXfj5jwDaFNo06zzd0seyZRxU2G0xIEKD+0DMud1K9YjiXYZaOO3GLN
         BoHW5hVH8iSHLbfPrsA2stfVK8PtShHqBr9mXSPmewVf8qsmr6vD9U/H3doLdRVttX2E
         nItg==
X-Gm-Message-State: AOJu0YzxkPPbJx+E4UkwH+K3yMeUxd6HM/fGXZYmK8x68/WN64fDrn6H
        uBZmPymU9c+Zo9riuUlOHPoeMT6X29185Q==
X-Google-Smtp-Source: AGHT+IGZU15lurFpPHW0mP4UekjRaDRff8LahYeBpQhkcx13RIh2+RpNLvLGx5O1g30JEnlz3008Lw==
X-Received: by 2002:a7b:c851:0:b0:406:5301:4320 with SMTP id c17-20020a7bc851000000b0040653014320mr24858359wml.16.1697224681750;
        Fri, 13 Oct 2023 12:18:01 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c4fd600b003fe2b081661sm929916wmq.30.2023.10.13.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:18:01 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     conor@kernel.org, Julian Ribbeck <julian.ribbeck@gmx.de>
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        julian.ribbeck@gmx.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        robh+dt@kernel.org, samuel@sholland.org, wens@csie.org
Subject: Re: [PATCH v4 1/2] ARM: dts: sun7i: Add Iteaduino Plus A20
Date:   Fri, 13 Oct 2023 21:18:00 +0200
Message-ID: <2242644.iZASKD2KPV@jernej-laptop>
In-Reply-To: <20231006090154.9289-1-julian.ribbeck@gmx.de>
References: <20230929-given-making-f3fac6afb176@spud>
 <20231006090154.9289-1-julian.ribbeck@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 06. oktober 2023 ob 11:01:30 CEST je Julian Ribbeck napisal(a):
> Iteaduino Plus A20 is very similar to Iteaduino Plus A10. In fact it
> shares the same breakout board and the Itead Core A20 on top of it, is
> only adapted to support the dual-core A20.
> 
> This commits enables the following hardware:
> 
> * HDMI Video output
> * USB
> * SATA (untested due to lack of hardware I could attach)
> * Ethernet
> * MMC storage
> * UART
> * USB OTG (untested, because I don't own an USB OTG cable/device)
> 
> Signed-off-by: Julian Ribbeck <julian.ribbeck@gmx.de>
> ---
>  arch/arm/boot/dts/allwinner/Makefile          |   1 +
>  .../sun7i-a20-itead-iteaduino-plus.dts        | 104 ++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 arch/arm/boot/dts/allwinner/sun7i-a20-itead-iteaduino-plus.dts
> 
> diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
> index eebb5a0c873a..39af5ad94590 100644
> --- a/arch/arm/boot/dts/allwinner/Makefile
> +++ b/arch/arm/boot/dts/allwinner/Makefile
> @@ -124,6 +124,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-haoyu-marsboard.dtb \
>  	sun7i-a20-hummingbird.dtb \
>  	sun7i-a20-itead-ibox.dtb \
> +	sun7i-a20-itead-iteaduino-plus.dts \

This should be .dtb.

Other than that:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

I'll fix it while applying.

For future reference, please follow proper patch submission procedure:
- each revision should be sent in separate thread
- each new revision should contain changelog, either in cover letter (when
there is more than one patch) or below --- line in each patch
- compatible description patch comes before first usage (I'll invert order
when applying)

Best regards,
Jernej

>  	sun7i-a20-i12-tvbox.dtb \
>  	sun7i-a20-icnova-a20-adb4006.dtb \
>  	sun7i-a20-icnova-swac.dtb \
> diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-itead-iteaduino-plus.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-itead-iteaduino-plus.dts
> new file mode 100644
> index 000000000000..c9f9b0275381
> --- /dev/null
> +++ b/arch/arm/boot/dts/allwinner/sun7i-a20-itead-iteaduino-plus.dts
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-itead-core-common.dtsi"
> +
> +/ {
> +	model = "Itead Iteaduino Plus A20";
> +	compatible = "itead,iteaduino-plus-a20", "allwinner,sun7i-a20";
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&ac_power_supply {
> +	status = "okay";
> +};
> +
> +&ahci {
> +	target-supply = <&reg_ahci_5v>;
> +	status = "okay";
> +};
> +
> +&axp209 {
> +	interrupt-parent = <&nmi_intc>;
> +	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +};
> +
> +&battery_power_supply {
> +	status = "okay";
> +};
> +
> +&codec {
> +	stauts = "okay";
> +};
> +
> +&de {
> +	status = "okay";
> +};
> +
> +&emac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emac_pa_pins>;
> +	phy-handle = <&phy1>;
> +	status = "okay";
> +};
> +
> +&emac_sram {
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	phy1: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
> +	status = "okay";
> +};
> +
> +&otg_sram {
> +	status = "okay";
> +};
> +
> +&reg_ahci_5v {
> +	status = "okay";
> +};
> +
> +&reg_usb0_vbus {
> +	status = "okay";
> +};
> +
> +&usb_otg {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +&usbphy {
> +	usb0_vbus-supply = <&reg_usb0_vbus>;
> +};
> --
> 2.42.0
> 
> 




