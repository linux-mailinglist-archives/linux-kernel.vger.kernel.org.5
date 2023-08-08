Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004E4774A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjHHUOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjHHUOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:14:20 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A74BA911;
        Tue,  8 Aug 2023 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=TXFRjF7K/onOiZi8P7ylgtGuh71aaBRyhInX/G1pbtc=; b=YnD2VAS1P+TJaMnsnk8R87jq86
        TyjkHpLTmWYGHTsENLT/RdYspzJXqplJ4aFMEORjjBmEzJTRZ9mp7AaDTIxYHBLmAHtPaXfgZNZI0
        v6ZeFiOAAhQeoHDHsZ0lB8yFB+G6mH/nkIBCTRRfZAI/mft0ZPWJTRSITAgzNBwx7ICA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qTRiR-003VHE-Sh; Tue, 08 Aug 2023 20:45:59 +0200
Date:   Tue, 8 Aug 2023 20:45:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next] net: stmmac: don't create the MDIO bus if
 there's no mdio node on DT
Message-ID: <82cd26a3-e63d-4251-9d43-d1d7443b9cce@lunn.ch>
References: <20230808120254.11653-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808120254.11653-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 02:02:54PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The stmmac_dt_phy() function that parses the device-tree node of the MAC
> and allocates the MDIO and PHY resources misses one use-case: when the
> MAC doesn't have a fixed link but also doesn't define its own mdio bus
> on the device tree and instead shares the MDIO lines with a different
> MAC with its PHY phandle reaching over into a different node.

It does not share the MDIO lines. The other MDIO bus master happens to
have two PHYs and there are no PHYs on this MDIO bus, so no point
instantiating it.

>  static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
>  			 struct device_node *np, struct device *dev)
>  {
> -	bool mdio = !of_phy_is_fixed_link(np);
>  	static const struct of_device_id need_mdio_ids[] = {
>  		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
>  		{},
>  	};
>  
> +	if (of_phy_is_fixed_link(np))
> +		return 0;
> +

		/**
		 * If snps,dwmac-mdio is passed from DT, always register
		 * the MDIO
		 */
		for_each_child_of_node(np, plat->mdio_node) {
			if (of_device_is_compatible(plat->mdio_node,
						    "snps,dwmac-mdio"))
				break;
		}

The comment suggests it should always be registered. This MAC might
have a fixed-phy, but that does not mean there is not an Ethernet
switch on the bus, or a PHY for some other MAC etc. MDIO busses
masters should be considered fully independent devices.

https://elixir.bootlin.com/linux/v6.5-rc5/source/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts

&fec1 {
	phy-mode = "rmii";
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_fec1>;
	status = "okay";

	fixed-link {
		speed = <100>;
		full-duplex;
	};

	mdio1: mdio {
		#address-cells = <1>;
		#size-cells = <0>;
		clock-frequency = <12500000>;
		suppress-preamble;
		status = "okay";

		switch0: switch0@0 {
			compatible = "marvell,mv88e6190";
			pinctrl-0 = <&pinctrl_gpio_switch0>;
			pinctrl-names = "default";
			reg = <0>;
			eeprom-length = <65536>;
			interrupt-parent = <&gpio3>;
			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
			interrupt-controller;
			#interrupt-cells = <2>;

Both a fixed link, and something on the MDIO bus....

     Andrew
