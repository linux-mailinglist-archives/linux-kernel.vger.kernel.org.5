Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F771797660
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjIGQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbjIGQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:07:18 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAB751A6;
        Thu,  7 Sep 2023 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W+nGXwhfP/LGZ49uX4cxuTbmxItrCPhnuVHDcPLu5RM=; b=mZSlhuKZDdh2iuo6M5q/AaVc25
        RpctXmLH7n6GGVVsapiZOy6T/cT8DbAL5h+mv6qR0ZK+xGOIRI/SZGZddWoA6hIVojmy2EUoE97Ad
        kexZ92biwY8owGWnaJxzVZ4wRKUxuGGidxFs8+GKYvxjQ3kD77DdP6ef2C3aihA+oKjc9O19AqwfF
        D0ikebCZs9IbpfkxgTUfms7uk14GBTlmiiDn8f+rLlfa4nbOeGtKadbZzPXzP84UIeTucWO7MhSJq
        RdvvS5/5KJe69w0nFwsdSsJvQBKoYRYtOLK7dLs09AzXne0Pcg/BuO+Q0OtEWAvTAkXFfywbpBvnD
        UtnCByeQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60702)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qeBNP-0001rc-2k;
        Thu, 07 Sep 2023 10:32:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qeBNP-0005j3-HT; Thu, 07 Sep 2023 10:32:39 +0100
Date:   Thu, 7 Sep 2023 10:32:39 +0100
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
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Message-ID: <ZPmYt3LJ0NnASoXF@shell.armlinux.org.uk>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <20230907092407.647139-2-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907092407.647139-2-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:23:59AM +0200, Maxime Chevallier wrote:
> @@ -640,6 +642,7 @@ struct phy_device {
>  
>  	struct device_link *devlink;
>  
> +	int phyindex;
>  	u32 phy_id;
>  
>  	struct phy_c45_device_ids c45_ids;
> @@ -761,6 +764,7 @@ struct phy_device {
>  	/* MACsec management functions */
>  	const struct macsec_ops *macsec_ops;
>  #endif
> +	struct list_head node;

I haven't yet fully looked at this, but the one thing that did stand out
was this - please name it "phy_ns_node" so that the purpose of this node
is clear.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
