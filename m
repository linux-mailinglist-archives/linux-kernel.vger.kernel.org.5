Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486617B69EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjJCNOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjJCNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:14:49 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E05F90;
        Tue,  3 Oct 2023 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZBWxmjNd8vCby7186bpocAw7l6dn7FqP/N8fvvIhwNQ=; b=ZbZ5sNuyOVjEKuk2Kc6owm9Oi+
        CVbKdlROVMemxNuPYLOm079PCNAxkqdn4FkkzHPaSiU9q0vd2xEwwJTLyUjb7sxEkJ9v6Se+YR+mO
        hyMHF6d2oMlZaBrzFAiWx0N5ARTRfQipZyGr28fZWLkAQfYIy1bRiOaRD2/jWOamKQD5/W8Rodx1t
        EZXxuHLGJBUvOFkHWeqIOCy45AXwGibkSc0bqIy27Um1+1UC0vQzlqX6CSDkf9vPyCSvEZPDhz9WV
        cui5XvDfIapsKVW+mDOebBgACDtLVTHwl3AlSmnPOOB/5KoWZS3z7Y3ZT3iGso8tvkovDyikqzr49
        EwUqFH0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38818)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qnfEW-0001l1-2j;
        Tue, 03 Oct 2023 14:14:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qnfEX-0007v4-3o; Tue, 03 Oct 2023 14:14:41 +0100
Date:   Tue, 3 Oct 2023 14:14:41 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 15/15] net: pcs: lynx: use MTIP AN/LT
 block for copper backplanes
Message-ID: <ZRwTwd18xWczDnur@shell.armlinux.org.uk>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-16-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923134904.3627402-16-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 04:49:04PM +0300, Vladimir Oltean wrote:
> +static int lynx_pcs_parse_fwnode(struct lynx_pcs *lynx)
> +{
> +	struct fwnode_handle *node = lynx->mdio->dev.fwnode;
> +	enum mtip_model model = MTIP_MODEL_AUTODETECT;
> +	struct device_node *np = to_of_node(node);
> +	struct mdio_device *mdio = lynx->mdio;
> +	struct device *dev = &mdio->dev;
> +	struct phy *phy;
> +	int i, err;
> +
> +	if (!node)
> +		return 0;
> +
> +	lynx->backplane_mode = fwnode_property_present(node, "fsl,backplane-mode");
> +	if (!lynx->backplane_mode)
> +		return 0;
> +
> +	if (fwnode_device_is_compatible(node, "fsl,lx2160a-lynx-pcs"))
> +		model = MTIP_MODEL_LX2160A;
> +
> +	lynx->num_lanes = of_count_phandle_with_args(np, "phys", "#phy-cells");
> +	if (lynx->num_lanes < 0)
> +		return lynx->num_lanes;

Is it possible for ->num_lanes to be zero at this point? If that is
possible, then ->anlt[PRIMARY_LANE] will be NULL but ->backplane_mode
will be set, so won't that cause the mtip_* calls above to pass a
NULL pointer into those functions? Is that safe? Should we trap that
case here?

If that's correct, then I don't see any point in storing
->backplane_mode, since we can then use ->num_lanes > PRIMARY_LANE
or similar instead.

> +
> +	if (WARN_ON(lynx->num_lanes > MAX_NUM_LANES))
> +		return -EINVAL;

Do we need to use WARN_ON() here, or would it be better to print a short
error-level message?

> +
> +	for (i = 0; i < lynx->num_lanes; i++) {
> +		phy = devm_of_phy_get_by_index(dev, np, i);
> +		if (IS_ERR(phy))
> +			return dev_err_probe(dev, PTR_ERR(phy),
> +					     "Failed to get SerDes PHY %d\n", i);
> +
> +		lynx->anlt[i] = mtip_backplane_create(mdio, phy, model);
> +		if (IS_ERR(lynx->anlt[i])) {
> +			err = PTR_ERR(lynx->anlt[i]);
> +
> +			while (i-- > 0)
> +				mtip_backplane_destroy(lynx->anlt[i]);
> +
> +			return err;
> +		}
> +	}
> +
> +	for (i = 1; i < lynx->num_lanes; i++) {
> +		err = mtip_backplane_add_subordinate(lynx->anlt[PRIMARY_LANE],
> +						     lynx->anlt[i]);
> +		if (WARN_ON(err)) {

Again, does this need to be a backtrace-producing WARN_ON()?

> +			/* Too many SerDes lanes in the device tree? */
> +			for (i = 0; i < lynx->num_lanes; i++)
> +				mtip_backplane_destroy(lynx->anlt[i]);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
>  {
>  	struct lynx_pcs *lynx;
> +	int err;
>  
>  	lynx = kzalloc(sizeof(*lynx), GFP_KERNEL);
>  	if (!lynx)
> @@ -327,6 +451,12 @@ static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
>  	lynx->pcs.neg_mode = true;
>  	lynx->pcs.poll = true;
>  
> +	err = lynx_pcs_parse_fwnode(lynx);
> +	if (err) {
> +		kfree(lynx);
> +		return ERR_PTR(err);
> +	}
> +
>  	return lynx_to_phylink_pcs(lynx);
>  }
>  
> @@ -392,6 +522,11 @@ EXPORT_SYMBOL_GPL(lynx_pcs_create_fwnode);
>  void lynx_pcs_destroy(struct phylink_pcs *pcs)
>  {
>  	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
> +	int i;
> +
> +	if (lynx->backplane_mode)
> +		for (i = 0; i < lynx->num_lanes; i++)
> +			mtip_backplane_destroy(lynx->anlt[i]);

Won't ->num_lanes only be non-zero when ->backplane_mode is set, so
isn't the test for ->backplane_mode redundant here?

>  
>  	mdio_device_put(lynx->mdio);
>  	kfree(lynx);
> -- 
> 2.34.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
