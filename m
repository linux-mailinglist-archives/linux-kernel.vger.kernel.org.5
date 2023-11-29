Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28967FD4EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjK2LHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjK2LHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:07:25 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B13C172E;
        Wed, 29 Nov 2023 03:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cKOfMVE2W4N3jeYF+QDJoKs2t5s3uglE1xOHGeLFmiI=; b=IGBmZD/UjaDEPNJp0tJi9yf8ll
        dnIBkkid9jAcAYvAyqEVoWEGXsErHT85ymeq3Bw38vedSI6BYSpVCcTvRouRYXFXx6tPZm+anwBsJ
        4F+Bhkbjl42VtSW/3G4VZ3DKRW5BaW1m4LOt6KIOFMRCcQ7t1LxJak3CaEJ4Z0xGSYvodOcXBv6+/
        C3Zo6XtJoZ/9yCBTKxnTYurmgRo+t+ADyZ701kSUbfWXAk75J9Kt9G8FmttWt/9Hsdvb6+XIKdXpz
        fdqaZby3XcdY/3+KU9duayG+wHUTX6BcogMHeuM/HwiKzO/VC8m0fXR9JAr4Po4cdilY93qzxq/HH
        aXfh3VYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39236)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r8IPZ-0000Cf-34;
        Wed, 29 Nov 2023 11:07:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r8IPb-0003vl-JR; Wed, 29 Nov 2023 11:07:23 +0000
Date:   Wed, 29 Nov 2023 11:07:23 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
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
Message-ID: <ZWcbazz0cLvXk7CN@shell.armlinux.org.uk>
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

Andrew,

On Wed, Nov 29, 2023 at 03:12:13AM +0100, Christian Marangi wrote:
>  static int at8035_parse_dt(struct phy_device *phydev)
>  {
>  	struct device_node *node = phydev->mdio.dev.of_node;
> @@ -2205,8 +2213,8 @@ static struct phy_driver at803x_driver[] = {
>  	.handle_interrupt	= at803x_handle_interrupt,
>  	.get_tunable		= at803x_get_tunable,
>  	.set_tunable		= at803x_set_tunable,
> -	.cable_test_start	= at803x_cable_test_start,
> -	.cable_test_get_status	= at803x_cable_test_get_status,
> +	.cable_test_start	= at8031_cable_test_start,
> +	.cable_test_get_status	= at8031_cable_test_get_status,
>  }, {
>  	/* Qualcomm Atheros AR8030 */
>  	.phy_id			= ATH8030_PHY_ID,
> @@ -2243,8 +2251,8 @@ static struct phy_driver at803x_driver[] = {
>  	.handle_interrupt	= at803x_handle_interrupt,
>  	.get_tunable		= at803x_get_tunable,
>  	.set_tunable		= at803x_set_tunable,
> -	.cable_test_start	= at803x_cable_test_start,
> -	.cable_test_get_status	= at803x_cable_test_get_status,
> +	.cable_test_start	= at8031_cable_test_start,
> +	.cable_test_get_status	= at8031_cable_test_get_status,
>  }, {
>  	/* Qualcomm Atheros AR8032 */
>  	PHY_ID_MATCH_EXACT(ATH8032_PHY_ID),
> @@ -2259,7 +2267,7 @@ static struct phy_driver at803x_driver[] = {
>  	.config_intr		= at803x_config_intr,
>  	.handle_interrupt	= at803x_handle_interrupt,
>  	.cable_test_start	= at803x_cable_test_start,
> -	.cable_test_get_status	= at803x_cable_test_get_status,
> +	.cable_test_get_status	= at8032_cable_test_get_status,
>  }, {
>  	/* ATHEROS AR9331 */
>  	PHY_ID_MATCH_EXACT(ATH9331_PHY_ID),
> @@ -2272,7 +2280,7 @@ static struct phy_driver at803x_driver[] = {
>  	.config_intr		= at803x_config_intr,
>  	.handle_interrupt	= at803x_handle_interrupt,
>  	.cable_test_start	= at803x_cable_test_start,
> -	.cable_test_get_status	= at803x_cable_test_get_status,
> +	.cable_test_get_status	= at8032_cable_test_get_status,
>  	.read_status		= at803x_read_status,
>  	.soft_reset		= genphy_soft_reset,
>  	.config_aneg		= at803x_config_aneg,
> @@ -2288,7 +2296,7 @@ static struct phy_driver at803x_driver[] = {
>  	.config_intr		= at803x_config_intr,
>  	.handle_interrupt	= at803x_handle_interrupt,
>  	.cable_test_start	= at803x_cable_test_start,
> -	.cable_test_get_status	= at803x_cable_test_get_status,
> +	.cable_test_get_status	= at8032_cable_test_get_status,
>  	.read_status		= at803x_read_status,
>  	.soft_reset		= genphy_soft_reset,
>  	.config_aneg		= at803x_config_aneg,

We could _really_ do with moving away from an array of PHY driver
structures in phylib because patches like this are hard to properly
review. The problem is there is little context to say _which_ driver
instance is being changed. The only thing that saves us above are
the comments on the next instance - but those may not be present
if we're modifying something in the middle of each definition.

The same issue happens with the mv88e6xxx driver, with that big
array in chip.c, where we have loads of function pointers. It's
far from ideal.

Maybe we should consider moving to a model where each driver is
defined as a separate named structure, and then we have an array
of pointers to each driver, which is then passed into a new PHY
driver registration function? This way, at least the @@ line will
identify to a reviewer which instance is being modified.

This won't help the problem of a patch being mis-applied due to
there not being sufficient differences in context, but if one
subsequently diffs after applying such a change and compares the
patch to the original, there will be a difference in the @@ line.
(However, arguably that level of checking is unlikely to happen.)


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
