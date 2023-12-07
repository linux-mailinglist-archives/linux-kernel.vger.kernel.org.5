Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC73808939
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441899AbjLGNcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjLGNca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:32:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6743D1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701955955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/SBhZAK414JzvquQwqVRSEGrKebKeCBrQXSFCxn068=;
        b=DsJzOOXVnSy6HmKaCxQDwxBargdN4fmYUIrhNxPj5HTokkxQMbrHHVTth/8KsqGBrAIaDc
        N3Qvf3SkUH5ZqSW0elbLujP4rBCfKAU174RsqjCOtu/ranSX4OQOB3nAEIY5c+7Y+gOpX9
        Y7Vi7J672dHuQPtt6ng9Rz576RVvvVQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-sDPEJ0BSPdWykzQP5rcIpQ-1; Thu, 07 Dec 2023 08:32:33 -0500
X-MC-Unique: sDPEJ0BSPdWykzQP5rcIpQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77f383fa40fso85514485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955952; x=1702560752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/SBhZAK414JzvquQwqVRSEGrKebKeCBrQXSFCxn068=;
        b=MLo3dm9YJr4GS/NlGOv5CrmpUreRWfk2EqKpluSwKT9+6ORtl4IzoaKMdh+5GvRD7H
         SLj/iVlCZvyCFx75VtkKKFveGGgjEi3Z3shTofb5cKlmTHiqiDyqrdOqqbja4/+bZkgz
         pttRtzUmj7b+MWDHAXN7yAPpRvnOHQxhwc8KeBT68AJ3mpvfvpX7ltryjRs2xldDw8pk
         gKF7B0jGvY7pyG1Z2k1adNSuQI9oKUht7RvDFqNeAyZ3QEHANX2TqkmTAGQcvzHobvNU
         t7oADyNPDQQm7jqyzDlfgyAJVdiL4SKGRrO2Muo9haMmKscv8INuzqMyq7l2CQl7a/D6
         bn7w==
X-Gm-Message-State: AOJu0YyPHK9hjoDW3J6hsJe+vb35b8chFTNNZIAlkE06HREexBjQRtEz
        Q/5+J2gxfVJUEtvVnfzK8ei8ep+8soEv48IA6pj8ntBQHY25lsD4tQEU5m6M+huk0jk54FeSwlU
        3FQs2jZtt2EI3Ul2C9p1b6U+tb69Yq8Ce
X-Received: by 2002:a05:620a:8ec5:b0:77f:85a:98cc with SMTP id rg5-20020a05620a8ec500b0077f085a98ccmr1093513qkn.67.1701955952591;
        Thu, 07 Dec 2023 05:32:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8AmSmUPsew3T2IwHJ8Kz7pb8PNKlkDZy/EK5ipjXZM7iqsTnedkfLks4D4gqigy8EmBeg1g==
X-Received: by 2002:a05:620a:8ec5:b0:77f:85a:98cc with SMTP id rg5-20020a05620a8ec500b0077f085a98ccmr1093493qkn.67.1701955952267;
        Thu, 07 Dec 2023 05:32:32 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a454600b0077d797676a4sm396176qkp.122.2023.12.07.05.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:32:31 -0800 (PST)
Date:   Thu, 7 Dec 2023 07:32:29 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v2] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <vmjpuli2l6r7awtiwip6hbgmc4m7hgtbyoqi3z4rhb5chfoiu4@5ebw7tepe6mp>
References: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
 <o3abmn7ocuksmjg23rrgsib7nfm4yo5rtzlqw2np2pplg73drd@7qe4vrsx2gyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o3abmn7ocuksmjg23rrgsib7nfm4yo5rtzlqw2np2pplg73drd@7qe4vrsx2gyc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 02:56:25PM +0300, Serge Semin wrote:
> Hi Andrew
> 
> On Wed, Dec 06, 2023 at 05:46:09PM -0600, Andrew Halaney wrote:
> > The stmmac_dt_phy() function, which parses the devicetree node of the
> > MAC and ultimately causes MDIO bus allocation, misinterprets what
> > fixed-link means in relation to the MAC's MDIO bus. This results in
> > a MDIO bus being created in situations it need not be.
> > 
> > Currently a MDIO bus is created if the description is either:
> > 
> >     1. Not fixed-link
> >     2. fixed-link but contains a MDIO bus as well
> > 
> > The "1" case above isn't always accurate. If there's a phy-handle,
> > it could be referencing a phy on another MDIO controller's bus[1]. In
> > this case currently the MAC will make a MDIO bus and scan it all
> > anyways unnecessarily.
> > 
> > There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
> > be created and scanned for a phy. This case can also be inferred from
> > the platform description by not having a phy-handle && not being
> > fixed-link. This hits case "1" in the current driver's logic.
> > 
> > Let's improve the logic to create a MDIO bus if either:
> > 
> >     - Devicetree contains a MDIO bus
> >     - !fixed-link && !phy-handle (legacy handling)
> > 
> > Below upstream devicetree snippets can be found that explain some of
> > the cases above more concretely.
> > 
> > Here's[0] a devicetree example where the MAC is both fixed-link and
> > driving a switch on MDIO (case "2" above). This needs a MDIO bus to
> > be created:
> > 
> >     &fec1 {
> >             phy-mode = "rmii";
> > 
> >             fixed-link {
> >                     speed = <100>;
> >                     full-duplex;
> >             };
> > 
> >             mdio1: mdio {
> >                     switch0: switch0@0 {
> >                             compatible = "marvell,mv88e6190";
> >                             pinctrl-0 = <&pinctrl_gpio_switch0>;
> >                     };
> >             };
> >     };
> > 
> > Here's[1] an example where there is no MDIO bus or fixed-link for
> > the ethernet1 MAC, so no MDIO bus should be created since ethernet0
> > is the MDIO master for ethernet1's phy:
> > 
> >     &ethernet0 {
> >             phy-mode = "sgmii";
> >             phy-handle = <&sgmii_phy0>;
> > 
> >             mdio {
> >                     compatible = "snps,dwmac-mdio";
> >                     sgmii_phy0: phy@8 {
> >                             compatible = "ethernet-phy-id0141.0dd4";
> >                             reg = <0x8>;
> >                             device_type = "ethernet-phy";
> >                     };
> > 
> >                     sgmii_phy1: phy@a {
> >                             compatible = "ethernet-phy-id0141.0dd4";
> >                             reg = <0xa>;
> >                             device_type = "ethernet-phy";
> >                     };
> >             };
> >     };
> > 
> >     &ethernet1 {
> >             phy-mode = "sgmii";
> >             phy-handle = <&sgmii_phy1>;
> >     };
> > 
> > Finally there's descriptions like this[2] which don't describe the
> > MDIO bus but expect it to be created and the whole address space
> > scanned for a phy since there's no phy-handle or fixed-link described:
> > 
> >     &gmac {
> >             phy-supply = <&vcc_lan>;
> >             phy-mode = "rmii";
> >             snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
> >             snps,reset-active-low;
> >             snps,reset-delays-us = <0 10000 1000000>;
> >     };
> > 
> > [0] https://elixir.bootlin.com/linux/v6.5-rc5/source/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
> > [1] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > [2] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/rockchip/rk3368-r88.dts#L164
> 
> Thank you for the patch. Please find a comment below.
> 
> > 
> > Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 85 ++++++++++------------
> >  1 file changed, 37 insertions(+), 48 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 1ffde555da47..7da461fe93f6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -296,69 +296,39 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
> >  }
> >  
> >  /**
> > - * stmmac_dt_phy - parse device-tree driver parameters to allocate PHY resources
> > - * @plat: driver data platform structure
> > - * @np: device tree node
> > - * @dev: device pointer
> > - * Description:
> > - * The mdio bus will be allocated in case of a phy transceiver is on board;
> > - * it will be NULL if the fixed-link is configured.
> > - * If there is the "snps,dwmac-mdio" sub-node the mdio will be allocated
> > - * in any case (for DSA, mdio must be registered even if fixed-link).
> > - * The table below sums the supported configurations:
> > - *	-------------------------------
> > - *	snps,phy-addr	|     Y
> > - *	-------------------------------
> > - *	phy-handle	|     Y
> > - *	-------------------------------
> > - *	fixed-link	|     N
> > - *	-------------------------------
> > - *	snps,dwmac-mdio	|
> > - *	  even if	|     Y
> > - *	fixed-link	|
> > - *	-------------------------------
> > + * stmmac_of_get_mdio() - Gets the MDIO bus from the devicetree
> > + * @np: devicetree node
> >   *
> > - * It returns 0 in case of success otherwise -ENODEV.
> > + * The MDIO bus will be searched for in the following ways:
> > + * 1. The compatible is "snps,dwc-qos-ethernet-4.10" && a "mdio" named
> > + *    child node exists
> > + * 2. A child node with the "snps,dwmac-mdio" compatible is present
> > + *
> > + * Return: The MDIO node if present otherwise NULL
> >   */
> > -static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
> > -			 struct device_node *np, struct device *dev)
> > +static struct device_node *stmmac_of_get_mdio(struct device_node *np)
> >  {
> > -	bool mdio = !of_phy_is_fixed_link(np);
> >  	static const struct of_device_id need_mdio_ids[] = {
> >  		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
> >  		{},
> >  	};
> > +	struct device_node *mdio_node = NULL;
> >  
> >  	if (of_match_node(need_mdio_ids, np)) {
> > -		plat->mdio_node = of_get_child_by_name(np, "mdio");
> > +		mdio_node = of_get_child_by_name(np, "mdio");
> >  	} else {
> >  		/**
> >  		 * If snps,dwmac-mdio is passed from DT, always register
> >  		 * the MDIO
> >  		 */
> > -		for_each_child_of_node(np, plat->mdio_node) {
> > -			if (of_device_is_compatible(plat->mdio_node,
> > +		for_each_child_of_node(np, mdio_node) {
> > +			if (of_device_is_compatible(mdio_node,
> >  						    "snps,dwmac-mdio"))
> >  				break;
> >  		}
> >  	}
> >  
> > -	if (plat->mdio_node) {
> > -		dev_dbg(dev, "Found MDIO subnode\n");
> > -		mdio = true;
> > -	}
> > -
> > -	if (mdio) {
> > -		plat->mdio_bus_data =
> > -			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
> > -				     GFP_KERNEL);
> > -		if (!plat->mdio_bus_data)
> > -			return -ENOMEM;
> > -
> > -		plat->mdio_bus_data->needs_reset = true;
> > -	}
> > -
> > -	return 0;
> > +	return mdio_node;
> >  }
> >  
> >  /**
> > @@ -417,6 +387,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct plat_stmmacenet_data *plat;
> >  	struct stmmac_dma_cfg *dma_cfg;
> > +	bool legacy_mdio;
> >  	int phy_mode;
> >  	void *ret;
> >  	int rc;
> > @@ -471,10 +442,28 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
> >  	if (of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr) == 0)
> >  		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
> >  
> > -	/* To Configure PHY by using all device-tree supported properties */
> > -	rc = stmmac_dt_phy(plat, np, &pdev->dev);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> > +	plat->mdio_node = stmmac_of_get_mdio(np);
> > +	if (plat->mdio_node)
> > +		dev_dbg(&pdev->dev, "Found MDIO subnode\n");
> > +
> 
> > +	/* Legacy devicetrees allowed for no MDIO bus description and expect
> > +	 * the bus to be scanned for devices. If there's no phy or fixed-link
> > +	 * described assume this is the case since there must be something
> > +	 * connected to the MAC.
> > +	 */
> > +	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
> > +	if (legacy_mdio)
> > +		dev_info(&pdev->dev, "Deprecated MDIO bus assumption used\n");
> > +
> > +	if (plat->mdio_node || legacy_mdio) {
> > +		plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
> > +						   sizeof(struct stmmac_mdio_bus_data),
> > +						   GFP_KERNEL);
> > +		if (!plat->mdio_bus_data)
> > +			return ERR_PTR(-ENOMEM);
> > +
> > +		plat->mdio_bus_data->needs_reset = true;
> > +	}
> 
> Why did you decide to move this out of the dedicated function?
> stmmac_probe_config_dt() is already overwhelmed with various
> non-coherent actions. The method has already got to being too long to
> follow the kernel coding style limit (I have got a not submitted yet
> cleanup patchset which step-by-step fixes that). Could you please get
> the chunk above back to the respective function and, for instance,
> just change it's name to something like stmmac_mdio_setup()? (I prefer
> having "_setup" suffix because some of the locally defined static
> methods already use it: stmmac_axi_setup(), stmmac_mtl_setup().)

Sure, I can put it back in. I'll probably keep stmmac_of_get_mdio()
(which is named in the style I see in the current file -- although as
you highlight that shouldn't be taken as the best example of clean),
and have stmmac_mdio_setup() call that and and mimic the inputs/outputs
of the current function (moving the rest of the added code from
stmmac_probe_config_dt() back into that function).

Thanks for the feedback, let me know if you still think that abstraction
isn't ideal (or wait till I post it :P) and I'll go with exactly as you
said. I'm not _too_ opinionated on it, but thought stmmac_dt_phy()
didn't explain much and stmmac_of_get_mdio() was self-explanatory enough
that it helped readability.

> 
> -Serge(y)
> 
> >  
> >  	of_property_read_u32(np, "tx-fifo-depth", &plat->tx_fifo_size);
> >  
> > 
> > ---
> > base-commit: fd8a79b63710acb84321be3ce74be23c876873fb
> > change-id: 20231127-stmmac-no-mdio-node-1db9da8a25d9
> > 
> > Best regards,
> > -- 
> > Andrew Halaney <ahalaney@redhat.com>
> > 
> > 
> 

