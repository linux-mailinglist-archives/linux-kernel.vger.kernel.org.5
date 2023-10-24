Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122E37D5A72
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbjJXS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343918AbjJXS2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:28:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E254A2;
        Tue, 24 Oct 2023 11:28:49 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso69056691fa.3;
        Tue, 24 Oct 2023 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698172127; x=1698776927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTND06KKW954BVYcuOIRNTzHHZcvdqYsQeg2uMm3Vos=;
        b=H2EKLnU+DSdRAUmZQgYm3pJaUsH8JRQtlEyFNFLk0u4XOoWCZsENUkqL0VAJ4YpKXr
         ufpb74sOysHmaP0+9l6T/maYl1iaMbWaVpas61t16aocfmUtUodHufzYuaNVFBFqp60N
         SC83y520uuOATGHma7BUJW4R1921sZhInkN8gFpccbxWVMoL62oEKrTiIZBimokgPIN8
         ony3CUxCQpMJ8jvsClTLnIme2nz/HyXEz12vvsd8umw48RGg/q01cgTCVVEU9hehHiEY
         Rb93UamGV1e/WSNK94389tzVTgK1uq6IWn4Y+f3eKl/j/cOt0P1Ia8Kv+NgpC0paIWsQ
         DVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172127; x=1698776927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTND06KKW954BVYcuOIRNTzHHZcvdqYsQeg2uMm3Vos=;
        b=hNGG8AvW5XaZr7/uY956F/pL/062XHq1ufu+27ldV19EjdZkRziJ3B+Mab0+pcBQSP
         0PxBp7bi2yDRKsEaEUXpfRYQx5d2XplI3x432I1mFqpbKcvnpqYJkwubnBjlc7GBqR4l
         LwLIR41CiJpgLFJXqM9z9w5rGLgK2mkuneqOAqDQG8V6iRoLxrH4pSWKlN/J9drP6/Qr
         WVFMWqzZhcWOJXAvoaLu2ju1iaJjUPsEZ8ebgN1f6bLrp35JZB8vsYs6gbCIdGQ+CCFz
         QciQgSI//Yp4ToYv7X0xzgtUKiOyRx09wUTs4uKsBgI6HojanH2IqA/uXvQJI25iSOrV
         FShA==
X-Gm-Message-State: AOJu0YyfReCpbQsUx6gQ4sqTvi8FqhonBy8jjcCnA66AgDrpirXTle57
        uSE/aPypbaTIlO/dkBA72CY=
X-Google-Smtp-Source: AGHT+IHh68C3TTL3eYVJAvZtTdQmZqSspK4jRmLFo9cBMVR3rZl0ZzLxDWWNAmumNfhjzO36y8ir+g==
X-Received: by 2002:a2e:b0c3:0:b0:2c5:1702:a434 with SMTP id g3-20020a2eb0c3000000b002c51702a434mr9408575ljl.52.1698172126774;
        Tue, 24 Oct 2023 11:28:46 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b009b928eb8dd3sm8569063ejq.163.2023.10.24.11.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:28:46 -0700 (PDT)
Date:   Tue, 24 Oct 2023 21:28:42 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Russell King <linux@armlinux.org.uk>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231024182842.flxrg3hjm3scnhjo@skbuf>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Tue, Oct 24, 2023 at 03:20:31PM +0200, Linus Walleij wrote:
> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - The top node had no address size or cells.
> - switch0@0 is not OK, should be ethernet-switch@0.
> - ports should be ethernet-ports
> - port@0 should be ethernet-port@0
> - PHYs should be named ethernet-phy@
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../dts/marvell/armada-3720-espressobin-ultra.dts  |  14 +-
>  .../boot/dts/marvell/armada-3720-espressobin.dtsi  |  20 +--
>  .../boot/dts/marvell/armada-3720-gl-mv1000.dts     |  20 +--
>  .../boot/dts/marvell/armada-3720-turris-mox.dts    | 189 +++++++++++----------
>  .../boot/dts/marvell/armada-7040-mochabin.dts      |  24 ++-
>  .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |  22 +--
>  arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |  42 +++--
>  7 files changed, 164 insertions(+), 167 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index f9abef8dcc94..870bb380a40a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -126,32 +126,32 @@ &switch0 {
>  
>  	reset-gpios = <&gpiosb 23 GPIO_ACTIVE_LOW>;
>  
> -	ports {
> -		switch0port1: port@1 {
> +	ethernet-ports {
> +		switch0port1: ethernet-port@1 {
>  			reg = <1>;
>  			label = "lan0";
>  			phy-handle = <&switch0phy0>;
>  		};
>  
> -		switch0port2: port@2 {
> +		switch0port2: ethernet-port@2 {
>  			reg = <2>;
>  			label = "lan1";
>  			phy-handle = <&switch0phy1>;
>  		};
>  
> -		switch0port3: port@3 {
> +		switch0port3: ethernet-port@3 {
>  			reg = <3>;
>  			label = "lan2";
>  			phy-handle = <&switch0phy2>;
>  		};
>  
> -		switch0port4: port@4 {
> +		switch0port4: ethernet-port@4 {
>  			reg = <4>;
>  			label = "lan3";
>  			phy-handle = <&switch0phy3>;
>  		};
>  
> -		switch0port5: port@5 {
> +		switch0port5: ethernet-port@5 {
>  			reg = <5>;
>  			label = "wan";
>  			phy-handle = <&extphy>;
> @@ -160,7 +160,7 @@ switch0port5: port@5 {
>  	};
>  
>  	mdio {
> -		switch0phy3: switch0phy3@14 {
> +		switch0phy3: ethernet-phy@14 {
>  			reg = <0x14>;
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index 5fc613d24151..86ec0df1c676 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -145,19 +145,17 @@ &usb2 {
>  };
>  
>  &mdio {
> -	switch0: switch0@1 {
> +	switch0: ethernet-switch@1 {
>  		compatible = "marvell,mv88e6085";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		reg = <1>;
>  
>  		dsa,member = <0 0>;
>  
> -		ports {
> +		ethernet-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			switch0port0: port@0 {
> +			switch0port0: ethernet-port@0 {
>  				reg = <0>;
>  				label = "cpu";
>  				ethernet = <&eth0>;
> @@ -168,19 +166,19 @@ fixed-link {
>  				};
>  			};
>  
> -			switch0port1: port@1 {
> +			switch0port1: ethernet-port@1 {
>  				reg = <1>;
>  				label = "wan";
>  				phy-handle = <&switch0phy0>;
>  			};
>  
> -			switch0port2: port@2 {
> +			switch0port2: ethernet-port@2 {
>  				reg = <2>;
>  				label = "lan0";
>  				phy-handle = <&switch0phy1>;
>  			};
>  
> -			switch0port3: port@3 {
> +			switch0port3: ethernet-port@3 {
>  				reg = <3>;
>  				label = "lan1";
>  				phy-handle = <&switch0phy2>;
> @@ -192,13 +190,13 @@ mdio {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			switch0phy0: switch0phy0@11 {
> +			switch0phy0: ethernet-phy@11 {
>  				reg = <0x11>;
>  			};
> -			switch0phy1: switch0phy1@12 {
> +			switch0phy1: ethernet-phy@12 {
>  				reg = <0x12>;
>  			};
> -			switch0phy2: switch0phy2@13 {
> +			switch0phy2: ethernet-phy@13 {
>  				reg = <0x13>;
>  			};
>  		};

I looked at U-Boot's ft_board_setup() from board/Marvell/mvebu_armada-37xx/board.c
and it doesn't appear to do anything with the switch. But after the MOX precedent
(which is _still_ problematic, more below), I still think we are way too
trigger-happy with this, and it would be good to ask someone who has the
Espressobin to test.

Pali, you are the last committer on the Linux DTS, could you please boot-test
this change, or at least confirm that as far as you know, there are no bootloader
dependencies on the precise node name for the switch and its child nodes?

> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> index b1b45b4fa9d4..63fbc8352161 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> @@ -152,31 +152,29 @@ &uart0 {
>  };
>  
>  &mdio {
> -	switch0: switch0@1 {
> +	switch0: ethernet-switch@1 {
>  		compatible = "marvell,mv88e6085";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		reg = <1>;
>  
>  		dsa,member = <0 0>;
>  
> -		ports: ports {
> +		ports: ethernet-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			port@0 {
> +			ethernet-port@0 {
>  				reg = <0>;
>  				label = "cpu";
>  				ethernet = <&eth0>;
>  			};
>  
> -			port@1 {
> +			ethernet-port@1 {
>  				reg = <1>;
>  				label = "wan";
>  				phy-handle = <&switch0phy0>;
>  			};
>  
> -			port@2 {
> +			ethernet-port@2 {
>  				reg = <2>;
>  				label = "lan0";
>  				phy-handle = <&switch0phy1>;
> @@ -185,7 +183,7 @@ port@2 {
>  				nvmem-cell-names = "mac-address";
>  			};
>  
> -			port@3 {
> +			ethernet-port@3 {
>  				reg = <3>;
>  				label = "lan1";
>  				phy-handle = <&switch0phy2>;
> @@ -199,13 +197,13 @@ mdio {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			switch0phy0: switch0phy0@11 {
> +			switch0phy0: ethernet-phy@11 {
>  				reg = <0x11>;
>  			};
> -			switch0phy1: switch0phy1@12 {
> +			switch0phy1: ethernet-phy@12 {
>  				reg = <0x12>;
>  			};
> -			switch0phy2: switch0phy2@13 {
> +			switch0phy2: ethernet-phy@13 {
>  				reg = <0x13>;
>  			};
>  		};

Enrico, I see the GL-MV1000 device tree submission is relatively new.
Could you please ACK this change as well?

> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 9eab2bb22134..cdf1b8bdb230 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -304,7 +304,12 @@ phy1: ethernet-phy@1 {
>  		reg = <1>;
>  	};
>  
> -	/* switch nodes are enabled by U-Boot if modules are present */
> +	/*
> +	 * NOTE: switch nodes are enabled by U-Boot if modules are present
> +	 * DO NOT change this node name (switch0@10) even if it is not following
> +	 * conventions! Deployed U-Boot binaries are explicitly looking for
> +	 * this node in order to augment the device tree!
> +	 */

Not "this node", but all switch nodes!

>  	switch0@10 {
>  		compatible = "marvell,mv88e6190";
>  		reg = <0x10>;
> @@ -317,92 +322,92 @@ mdio {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			switch0phy1: switch0phy1@1 {
> +			switch0phy1: ethernet-phy@1 {
>  				reg = <0x1>;
>  			};
>  
> -			switch0phy2: switch0phy2@2 {
> +			switch0phy2: ethernet-phy@2 {
>  				reg = <0x2>;
>  			};
>  
> -			switch0phy3: switch0phy3@3 {
> +			switch0phy3: ethernet-phy@3 {
>  				reg = <0x3>;
>  			};
>  
> -			switch0phy4: switch0phy4@4 {
> +			switch0phy4: ethernet-phy@4 {
>  				reg = <0x4>;
>  			};
>  
> -			switch0phy5: switch0phy5@5 {
> +			switch0phy5: ethernet-phy@5 {
>  				reg = <0x5>;
>  			};
>  
> -			switch0phy6: switch0phy6@6 {
> +			switch0phy6: ethernet-phy@6 {
>  				reg = <0x6>;
>  			};
>  
> -			switch0phy7: switch0phy7@7 {
> +			switch0phy7: ethernet-phy@7 {
>  				reg = <0x7>;
>  			};
>  
> -			switch0phy8: switch0phy8@8 {
> +			switch0phy8: ethernet-phy@8 {
>  				reg = <0x8>;
>  			};
>  		};
>  
> -		ports {
> +		ethernet-ports {

U-Boot code does this, so you can't rename "ports":

	/*
	 * now if there are more switches or a SFP module coming after,
	 * enable corresponding ports
	 */
	if (id < peridot + topaz - 1) {
		res = fdt_status_okay_by_pathf(blob,
					       "%s/switch%i@%x/ports/port@a",
					       mdio_path, id, addr);
	} else if (id == peridot - 1 && !topaz && sfp) {
		res = fdt_status_okay_by_pathf(blob,
					       "%s/switch%i@%x/ports/port-sfp@a",
					       mdio_path, id, addr);
	} else {
		res = 0;
	}

>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			port@1 {
> +			ethernet-port@1 {

or "port@.*", or "port-sfp@a", for the same reason. Here and everywhere
in this device tree. Basically only the ethernet-phy rename seems safe.

>  				reg = <0x1>;
>  				label = "lan1";
>  				phy-handle = <&switch0phy1>;
>  			};
>  
> -			port@2 {
> +			ethernet-port@2 {
>  				reg = <0x2>;
>  				label = "lan2";
>  				phy-handle = <&switch0phy2>;
>  			};
>  
> -			port@3 {
> +			ethernet-port@3 {
>  				reg = <0x3>;
>  				label = "lan3";
>  				phy-handle = <&switch0phy3>;
>  			};
>  
> -			port@4 {
> +			ethernet-port@4 {
>  				reg = <0x4>;
>  				label = "lan4";
>  				phy-handle = <&switch0phy4>;
>  			};
>  
> -			port@5 {
> +			ethernet-port@5 {
>  				reg = <0x5>;
>  				label = "lan5";
>  				phy-handle = <&switch0phy5>;
>  			};
>  
> -			port@6 {
> +			ethernet-port@6 {
>  				reg = <0x6>;
>  				label = "lan6";
>  				phy-handle = <&switch0phy6>;
>  			};
>  
> -			port@7 {
> +			ethernet-port@7 {
>  				reg = <0x7>;
>  				label = "lan7";
>  				phy-handle = <&switch0phy7>;
>  			};
>  
> -			port@8 {
> +			ethernet-port@8 {
>  				reg = <0x8>;
>  				label = "lan8";
>  				phy-handle = <&switch0phy8>;
>  			};
>  
> -			port@9 {
> +			ethernet-port@9 {
>  				reg = <0x9>;
>  				label = "cpu";
>  				ethernet = <&eth1>;
> @@ -410,7 +415,7 @@ port@9 {
>  				managed = "in-band-status";
>  			};
>  
> -			switch0port10: port@a {
> +			switch0port10: ethernet-port@a {
>  				reg = <0xa>;
>  				label = "dsa";
>  				phy-mode = "2500base-x";
> @@ -430,7 +435,7 @@ port-sfp@a {
>  		};
>  	};
>  
> -	switch0@2 {
> +	ethernet-switch@2 {

It's funny that you add a comment TO NOT rename switch nodes, then you
proceed to do just that.

Having that said, we need to suppress these warnings for the Marvell
schema only:

arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dtb: switch0@10: $nodename:0: 'switch0@10' does not match '^(ethernet-)?switch(@.*)?$'
        from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dtb: ethernet-switch@12: ethernet-ports: 'port-sfp@a' does not match any of the regexes: '^(ethernet-)?port@[0-9]+$', 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

because someone _will_ fix them and break the boot in the process.

Rob, Krzysztof, Conor, do you have any suggestion on how to achieve that?

>  		compatible = "marvell,mv88e6085";
>  		reg = <0x2>;
>  		dsa,member = <0 0>;
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> index 48202810bf78..40b7ee7ead72 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> @@ -301,10 +301,8 @@ eth2phy: ethernet-phy@1 {
>  	};
>  
>  	/* 88E6141 Topaz switch */
> -	switch: switch@3 {
> +	switch: ethernet-switch@3 {
>  		compatible = "marvell,mv88e6085";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		reg = <3>;
>  
>  		pinctrl-names = "default";
> @@ -314,35 +312,35 @@ switch: switch@3 {
>  		interrupt-parent = <&cp0_gpio1>;
>  		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
>  
> -		ports {
> +		ethernet-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			swport1: port@1 {
> +			swport1: ethernet-port@1 {
>  				reg = <1>;
>  				label = "lan0";
>  				phy-handle = <&swphy1>;
>  			};
>  
> -			swport2: port@2 {
> +			swport2: ethernet-port@2 {
>  				reg = <2>;
>  				label = "lan1";
>  				phy-handle = <&swphy2>;
>  			};
>  
> -			swport3: port@3 {
> +			swport3: ethernet-port@3 {
>  				reg = <3>;
>  				label = "lan2";
>  				phy-handle = <&swphy3>;
>  			};
>  
> -			swport4: port@4 {
> +			swport4: ethernet-port@4 {
>  				reg = <4>;
>  				label = "lan3";
>  				phy-handle = <&swphy4>;
>  			};
>  
> -			port@5 {
> +			ethernet-port@5 {
>  				reg = <5>;
>  				label = "cpu";
>  				ethernet = <&cp0_eth1>;
> @@ -355,19 +353,19 @@ mdio {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			swphy1: swphy1@17 {
> +			swphy1: ethernet-phy@17 {
>  				reg = <17>;
>  			};
>  
> -			swphy2: swphy2@18 {
> +			swphy2: ethernet-phy@18 {
>  				reg = <18>;
>  			};
>  
> -			swphy3: swphy3@19 {
> +			swphy3: ethernet-phy@19 {
>  				reg = <19>;
>  			};
>  
> -			swphy4: swphy4@20 {
> +			swphy4: ethernet-phy@20 {
>  				reg = <20>;
>  			};
>  		};

Robert, would you mind ACKing the MOCHAbin change?

> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> index 4125202028c8..67892f0d2863 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> @@ -497,42 +497,42 @@ ge_phy: ethernet-phy@0 {
>  		reset-deassert-us = <10000>;
>  	};
>  
> -	switch0: switch0@4 {
> +	switch0: ethernet-switch@4 {
>  		compatible = "marvell,mv88e6085";
>  		reg = <4>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&cp1_switch_reset_pins>;
>  		reset-gpios = <&cp1_gpio1 24 GPIO_ACTIVE_LOW>;
>  
> -		ports {
> +		ethernet-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			port@1 {
> +			ethernet-port@1 {
>  				reg = <1>;
>  				label = "lan2";
>  				phy-handle = <&switch0phy0>;
>  			};
>  
> -			port@2 {
> +			ethernet-port@2 {
>  				reg = <2>;
>  				label = "lan1";
>  				phy-handle = <&switch0phy1>;
>  			};
>  
> -			port@3 {
> +			ethernet-port@3 {
>  				reg = <3>;
>  				label = "lan4";
>  				phy-handle = <&switch0phy2>;
>  			};
>  
> -			port@4 {
> +			ethernet-port@4 {
>  				reg = <4>;
>  				label = "lan3";
>  				phy-handle = <&switch0phy3>;
>  			};
>  
> -			port@5 {
> +			ethernet-port@5 {
>  				reg = <5>;
>  				label = "cpu";
>  				ethernet = <&cp1_eth2>;
> @@ -545,19 +545,19 @@ mdio {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			switch0phy0: switch0phy0@11 {
> +			switch0phy0: ethernet-phy@11 {
>  				reg = <0x11>;
>  			};
>  
> -			switch0phy1: switch0phy1@12 {
> +			switch0phy1: ethernet-phy@12 {
>  				reg = <0x12>;
>  			};
>  
> -			switch0phy2: switch0phy2@13 {
> +			switch0phy2: ethernet-phy@13 {
>  				reg = <0x13>;
>  			};
>  
> -			switch0phy3: switch0phy3@14 {
> +			switch0phy3: ethernet-phy@14 {
>  				reg = <0x14>;
>  			};
>  		};

Russell, could you please do the same for this device tree?

> diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
> index 32cfb3e2efc3..7538ed56053b 100644
> --- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
> +++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
> @@ -207,11 +207,9 @@ phy0: ethernet-phy@0 {
>  		reg = <0>;
>  	};
>  
> -	switch6: switch0@6 {
> +	switch6: ethernet-switch@6 {
>  		/* Actual device is MV88E6393X */
>  		compatible = "marvell,mv88e6190";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		reg = <6>;
>  		interrupt-parent = <&cp0_gpio1>;
>  		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
> @@ -220,59 +218,59 @@ switch6: switch0@6 {
>  
>  		dsa,member = <0 0>;
>  
> -		ports {
> +		ethernet-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			port@1 {
> +			ethernet-port@1 {
>  				reg = <1>;
>  				label = "p1";
>  				phy-handle = <&switch0phy1>;
>  			};
>  
> -			port@2 {
> +			ethernet-port@2 {
>  				reg = <2>;
>  				label = "p2";
>  				phy-handle = <&switch0phy2>;
>  			};
>  
> -			port@3 {
> +			ethernet-port@3 {
>  				reg = <3>;
>  				label = "p3";
>  				phy-handle = <&switch0phy3>;
>  			};
>  
> -			port@4 {
> +			ethernet-port@4 {
>  				reg = <4>;
>  				label = "p4";
>  				phy-handle = <&switch0phy4>;
>  			};
>  
> -			port@5 {
> +			ethernet-port@5 {
>  				reg = <5>;
>  				label = "p5";
>  				phy-handle = <&switch0phy5>;
>  			};
>  
> -			port@6 {
> +			ethernet-port@6 {
>  				reg = <6>;
>  				label = "p6";
>  				phy-handle = <&switch0phy6>;
>  			};
>  
> -			port@7 {
> +			ethernet-port@7 {
>  				reg = <7>;
>  				label = "p7";
>  				phy-handle = <&switch0phy7>;
>  			};
>  
> -			port@8 {
> +			ethernet-port@8 {
>  				reg = <8>;
>  				label = "p8";
>  				phy-handle = <&switch0phy8>;
>  			};
>  
> -			port@9 {
> +			ethernet-port@9 {
>  				reg = <9>;
>  				label = "p9";
>  				phy-mode = "10gbase-r";
> @@ -280,7 +278,7 @@ port@9 {
>  				managed = "in-band-status";
>  			};
>  
> -			port@a {
> +			ethernet-port@a {
>  				reg = <10>;
>  				ethernet = <&cp0_eth0>;
>  				phy-mode = "10gbase-r";
> @@ -293,35 +291,35 @@ mdio {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			switch0phy1: switch0phy1@1 {
> +			switch0phy1: ethernet-phy@1 {
>  				reg = <0x1>;
>  			};
>  
> -			switch0phy2: switch0phy2@2 {
> +			switch0phy2: ethernet-phy@2 {
>  				reg = <0x2>;
>  			};
>  
> -			switch0phy3: switch0phy3@3 {
> +			switch0phy3: ethernet-phy@3 {
>  				reg = <0x3>;
>  			};
>  
> -			switch0phy4: switch0phy4@4 {
> +			switch0phy4: ethernet-phy@4 {
>  				reg = <0x4>;
>  			};
>  
> -			switch0phy5: switch0phy5@5 {
> +			switch0phy5: ethernet-phy@5 {
>  				reg = <0x5>;
>  			};
>  
> -			switch0phy6: switch0phy6@6 {
> +			switch0phy6: ethernet-phy@6 {
>  				reg = <0x6>;
>  			};
>  
> -			switch0phy7: switch0phy7@7 {
> +			switch0phy7: ethernet-phy@7 {
>  				reg = <0x7>;
>  			};
>  
> -			switch0phy8: switch0phy8@8 {
> +			switch0phy8: ethernet-phy@8 {
>  				reg = <0x8>;
>  			};
>  		};

Chris, does this look okay?
