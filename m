Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86257CC0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbjJQKqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:46:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094B3B0;
        Tue, 17 Oct 2023 03:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ROQZdDcLut5ViR2MKWTEe7ujDUIt2VMvj7Y8134W1Do=; b=UAe8MUhsddOe2s6WwFUT3m0YdX
        nKeI/8fZLVWEOltPVdHSx609o4C59e2by21Ke+Wj5JhcHp4tQz9IihlOM3HnOfNwlDmJc9C6Fa3DG
        ipBLCU0feoGodloXbVWpEqwgSH2AEQtfm4QAj+43MnNfNU5Bc8a4+4W3nNDTaS+79PPHWlJkupJtX
        VxOwRabCWnNtrduVbOpIaZ9jjvEmFFfzGdzwjmJH2NX4O7hgC13UOh6vASlYthfxORgPbfs0u8282
        ZFfqBXVY0JLzQFF6WOZRUFTkQodoApQjEKH6HGy2HSdf6uV/a5Vmh4o+UjlKyXkjGxxEkk/aZFBT5
        ePNON4ag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48774)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qshaK-00036p-10;
        Tue, 17 Oct 2023 11:46:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qshaK-0006ca-OQ; Tue, 17 Oct 2023 11:46:00 +0100
Date:   Tue, 17 Oct 2023 11:46:00 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        Bryan.Whitehead@microchip.com, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V1 6/7] net: lan743x: Add support to the phylink
 framework
Message-ID: <ZS5l6Ko0NeaotV2Q@shell.armlinux.org.uk>
References: <20231017094208.4956-1-Raju.Lakkaraju@microchip.com>
 <20231017094208.4956-7-Raju.Lakkaraju@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017094208.4956-7-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 03:12:07PM +0530, Raju Lakkaraju wrote:
> +static void lan743x_phylink_mac_config(struct phylink_config *config,
> +				       unsigned int link_an_mode,
> +				       const struct phylink_link_state *state)
> +{
> +	struct net_device *netdev = to_net_dev(config->dev);
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	bool status;
> +	int ret;
> +
> +	lan743x_mac_cfg_update(adapter, state->link, state->speed,
> +			       state->advertising);

Another case of not reading the phylink documentation... :( I *really*
don't see why we bother to write documentation, from my experience, it
seems to be totally a write-only thing... no one seems to bother
reading it.

/**
 * mac_config() - configure the MAC for the selected mode and state
 * @config: a pointer to a &struct phylink_config.
 * @mode: one of %MLO_AN_FIXED, %MLO_AN_PHY, %MLO_AN_INBAND.
 * @state: a pointer to a &struct phylink_link_state.
 *
 * Note - not all members of @state are valid.  In particular,
 * @state->lp_advertising, @state->link, @state->an_complete are never
 * guaranteed to be correct, and so any mac_config() implementation must
 * never reference these fields.
...
 * The action performed depends on the currently selected mode:
 *
 * %MLO_AN_FIXED, %MLO_AN_PHY:
...
 *   Valid state members: interface, advertising.
 *   Deprecated state members: speed, duplex, pause.
...
 * %MLO_AN_INBAND:
...
 *   Valid state members: interface, an_enabled, pause, advertising.

So "link" and "speed" are not valid. They're certainly not valid now
that the pre-March 2020 legacy support has been removed.

The only time that you get to know what speed the link is operating at
is after the link has been negotiated and is up - and you will be told
via the mac_link_up() function (or in the case of a PCS, via the
pcs_link_up() function.) You can't know before that point what speed
the link will be operating at because its dependent on the results of
link negotiation.

I haven't bothered to look more deeply at this patch, because I regard
any patch that gets this wrong to be utter trash (sorry that's a bit
hard, but I see people not bothering to read documentation all too
often and it pisses me off that I've gone to the bother of writing it
and it just gets ignored.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
