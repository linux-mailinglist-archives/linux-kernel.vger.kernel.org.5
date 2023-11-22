Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97217F4D75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjKVQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKVQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:55:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1973711F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:55:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC1BC433C8;
        Wed, 22 Nov 2023 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700672101;
        bh=/HIV4nv7BwN/w2cy+QdtiFk+dKAvRZKKzDdyVmdvCTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KR4e4C+osYMJhRZdNk+Z3tKtx/ELNllIcM5ctQ9iaKO/6UFJbizuxnjIiS2OOIIag
         H0G7j6JiBnn0YVPusnWuQpsYzxS7GXtTXiZ/eLmYWiCO5gvsmuxh8C0rPn9DQTTnqI
         thM63BtDn5Br5fHgqgFW0LtSOpSXNEGUV6/Iedzgumz8b9Lvksq8qM1nGp8QSTrkNa
         RntTFRZDf+9oG7HpE/SHRdxc/dI4lJfqd5ZGg/LSA7osksz1MiHtnGPbHsm4Y1ORKV
         LrOpnjkDbTvuM1lMh+rO9OBlFR2dXpkpAecUBmmyBogBNsDom/dhIw8KoXbCkM9ia6
         fcci4vBjOdv8w==
Date:   Wed, 22 Nov 2023 08:54:59 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231122085459.1601141e@kernel.org>
In-Reply-To: <20231122143618.cqyb45po7bon2xzg@skbuf>
References: <20231120093723.4d88fb2a@kernel.org>
        <20231120190023.ymog4yb2hcydhmua@skbuf>
        <20231120115839.74ee5492@kernel.org>
        <20231120211759.j5uvijsrgt2jqtwx@skbuf>
        <20231120133737.70dde657@kernel.org>
        <20231120220549.cvsz2ni3wj7mcukh@skbuf>
        <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
        <20231121094354.635ee8cd@kernel.org>
        <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
        <20231122140850.li2mvf6tpo3f2fhh@skbuf>
        <20231122143618.cqyb45po7bon2xzg@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 16:36:18 +0200 Vladimir Oltean wrote:
> @Jakub, for your long-term "MAC timestamps for PTP, DMA for everything else".
> How do you see this? I guess we need some sort of priority function in
> the UAPI between hwtstamp providers.
> 
> And even with that, I think the enums that we currently have for filters
> are not specific enough. The most we could expose is:
> 
>                       MAC provider                      DMA provider
> 
> hwtstamp_rx_filters   HWTSTAMP_FILTER_PTP_V2_EVENT      HWTSTAMP_FILTER_ALL
> tx_type               HWTSTAMP_TX_ON                    HWTSTAMP_TX_ON
> 
> but it isn't clear: for PTP, does the DMA provider give you an RX
> timestamp too?

If we phrase it as "precise / approximate" rather than "MAC / DMA" - it
seems fairly intuitive to give the best timestamp available for a given
packet, no?

> What about a TX timestamp?

I was thinking - socket flag to make packets for a given socket request
precise timestamps.
