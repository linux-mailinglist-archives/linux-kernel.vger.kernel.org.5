Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36E7FD2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjK2Jik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2Jij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:38:39 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FE21735;
        Wed, 29 Nov 2023 01:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5iQf8HCIX4bIELCAB7Wsi7e/e75JA6+pWA/5/4r6aBI=; b=zGtJOpQEmJtQOsf6u9BE1pRaed
        XROlB9h+/2a6rQB1kPelKi0gU9qZuo+6dOD1NjKOM1dccN3H6OqINnhmsl8cPx36A8V/llrdStR7u
        h0L16jxLF8x2b7NM2eiTN9Vk9Tut4AoviWuE4J94+n3fB7Z07wJi81vgRu6+9CWtspdhB2EkpBRPz
        dtAdO7xUSJF8LTG5OZKFAJWSJ5hs7IuwUY5ZdCotDxVsxY9iVpANAiKTK90igbl+Nnz1zFvk8LxJP
        tEwXYHBViFKF2Y60yh5ZngoiFmNqC6Uv6u0mKJencaW1TlT4OMZVdhfoOJyTZw9Z4ujZjN1aLdjpV
        BipT7Jqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50696)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r8H1h-0008Vc-2V;
        Wed, 29 Nov 2023 09:38:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r8H1j-0003rk-Nh; Wed, 29 Nov 2023 09:38:39 +0000
Date:   Wed, 29 Nov 2023 09:38:39 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 08/14] net: phy: at803x: drop specific PHY id
 check from cable test functions
Message-ID: <ZWcGn7KVSpsN/1Ee@shell.armlinux.org.uk>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-9-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129021219.20914-9-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:12:13AM +0100, Christian Marangi wrote:
> @@ -1310,10 +1302,6 @@ static int at803x_cable_test_start(struct phy_device *phydev)
>  	 */
>  	phy_write(phydev, MII_BMCR, BMCR_ANENABLE);
>  	phy_write(phydev, MII_ADVERTISE, ADVERTISE_CSMA);
> -	if (phydev->phy_id != ATH9331_PHY_ID &&
> -	    phydev->phy_id != ATH8032_PHY_ID &&
> -	    phydev->phy_id != QCA9561_PHY_ID)
> -		phy_write(phydev, MII_CTRL1000, 0);
...
> +static int at8031_cable_test_start(struct phy_device *phydev)
> +{
> +	at803x_cable_test_start(phydev);
> +	phy_write(phydev, MII_CTRL1000, 0);

I don't think this is a safe change - same reasons as given on a
previous patch. You can't randomly reorder register writes like this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
