Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9167479D6B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbjILQtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbjILQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:49:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C54110;
        Tue, 12 Sep 2023 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6llGpFBr5L+Q2Nmimc2SvggKuqaRf8GostcQCX30dVo=; b=qZkdGbw6IBcyMcqfQfYzu+oiKn
        2Xi18pK7v5BZ5bUo7YA0bwRvYON1AsXiy3D2jWQMs1Le5x99fNBlUvACNWghw22S1yjcTYKGrXbyY
        q6GOPVw9B36X2+VnEHYlpyNZruWcF0JFZGFK7rdRH1kxPeY5ctEskPnrWjT3bCITGzgTyoJYt0R/D
        W9Ha5kIEXKz6l9Z3VbELaiu3DPNLeWwtL7ceBMl7MiO4VtoB7NHpXDWUsVzr5Hf+TkeD+84BeqyGR
        j7EcBT4GgAFLQ9IDVXKZ9Ut01TTli/VEfHp+K9soQAW5hXQ+G2lKoReulG6fdqUKvXowzZD0y59j3
        9PjsUo4g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42686)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qg6a0-0001TE-1v;
        Tue, 12 Sep 2023 17:49:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qg6a0-0002s6-B0; Tue, 12 Sep 2023 17:49:36 +0100
Date:   Tue, 12 Sep 2023 17:49:36 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] net: dsa: vsc73xx: convert to PHYLINK
Message-ID: <ZQCWoIjvAJZ1Qyii@shell.armlinux.org.uk>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-3-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912122201.3752918-3-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 02:21:56PM +0200, Pawel Dembicki wrote:
> +static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
> +					unsigned int mode,
> +					phy_interface_t interface,
> +					struct phy_device *phydev,
> +					int speed, int duplex,
> +					bool tx_pause, bool rx_pause)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +	u32 val;
> +
> +	if (speed == SPEED_1000)
> +		val = VSC73XX_MAC_CFG_GIGA_MODE | VSC73XX_MAC_CFG_TX_IPG_1000M;
> +	else
> +		val = VSC73XX_MAC_CFG_TX_IPG_100_10M;
> +
> +	if (interface == PHY_INTERFACE_MODE_RGMII)
> +		val |= VSC73XX_MAC_CFG_CLK_SEL_1000M;
> +	else
> +		val |= VSC73XX_MAC_CFG_CLK_SEL_EXT;

I know the original code tested against PHY_INTERFACE_MODE_RGMII, but
is this correct, or should it be:

	if (phy_interface_is_rgmii(interface))

since the various RGMII* modes are used to determine the delay on the
PHY side.

Even so, I don't think that is a matter for this patch, but a future
(or maybe a preceeding patch) to address.

Other than that, I think it looks okay.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
