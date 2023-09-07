Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3F79765E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjIGQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjIGQHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:07:04 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA534494;
        Thu,  7 Sep 2023 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gCpGKkejF5ano+ddHvulYheBRNA10sJ3FKKCtzoQ/2M=; b=CoK3DZGebBuUjc1zlbq8QQE7UM
        MuzJA3m6PZ0XPacQ9QVvLyPbuWmJqzaiflqJuDetgBCmkFM7LQr5YIqvi6EaMCEOLCJxrSH+h/rFE
        hdpamoSQsFDo/1RgfyO5SR//szeo1dXuXMFFMfGpEpWrY5rOzpbQqDxG2jp5WkskBjzZ9w3nVwh8D
        9+Ugvb+X3NfU5JEC7ixd5iklIveW4dJLB5L6Bj5tPQEwEHMFQSjkVUCy126XBj1e1QaFFYEfol2Kx
        FlxKo60t5zLjUpnKEiD8dOWEOrl50H6D4rpkAe6UjzZjtptHGtkkGSFjYMOgi1NDk0dSq7zbmjklS
        AwZOh+zA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52808)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qeBoI-0001zB-02;
        Thu, 07 Sep 2023 11:00:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qeBoG-0005kC-NX; Thu, 07 Sep 2023 11:00:24 +0100
Date:   Thu, 7 Sep 2023 11:00:24 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 4/7] net: ethtool: add a netlink command to
 list PHYs
Message-ID: <ZPmfOOsqoO02AcBH@shell.armlinux.org.uk>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <20230907092407.647139-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907092407.647139-5-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:24:02AM +0200, Maxime Chevallier wrote:
> +#define PHY_MAX_ENTRIES	16
> +
> +struct phy_list_reply_data {
> +	struct ethnl_reply_data		base;
> +	u8 n_phys;
> +	u32 phy_indices[PHY_MAX_ENTRIES];

Please could you detail the decision making behind 16 entries - is this
arbitary or based on something?

Also, please consider what we should do if we happen to have more than
16 entries.

Finally, using u8 before an array of u32 can leave 3 bytes of padding.
It would be better to use u32 for n_phys to avoid that padding.

> +	mutex_lock(&phy_ns->ns_lock);
> +	list_for_each_entry(phydev, &phy_ns->phys, node)
> +		data->phy_indices[data->n_phys++] = phydev->phyindex;

I think this loop should limit its iterations to ensure that the
array can't overflow.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
