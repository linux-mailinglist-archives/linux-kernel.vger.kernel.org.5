Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7627E801607
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjLAWPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAWPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:15:38 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C5310D;
        Fri,  1 Dec 2023 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=O4CthWDfvVmWbJZJbZ85nPI4SK2uYVkYLn0z69Q22W0=; b=l6A1jUNIVGUmVp+FLKEIqfjkF7
        kBTtTOAPfafxrKH1goS4Whl4hdAThLfYlfthkBx3fxrqHjWW1pxyZsWcN340S4Fj7VPkpxVoft0Es
        gJI4mM/aMJfJ0wcSRDvubRqMXa3mi+CQeaRzJhGS5xAJ3aVhQ1OLxVJOKJpmSFx3/fUg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r9BnA-001o0X-GC; Fri, 01 Dec 2023 23:15:24 +0100
Date:   Fri, 1 Dec 2023 23:15:24 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        quentin.schulz@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH] net: mdio: enable optional clock when registering a phy
 from devicetree
Message-ID: <84c102fa-e3f4-4454-82c9-95eea7eeb941@lunn.ch>
References: <20231201142453.324697-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201142453.324697-1-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:24:53PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The ethernet-phy binding (now) specifys that phys can declare a clock
> supply. Phy driver itself will handle this when probing the phy-driver.
> 
> But there is a gap when trying to detect phys, because the mdio-bus needs
> to talk to the phy to get its phy-id. Using actual phy-ids in the dt like
>        compatible = "ethernet-phy-id0022.1640",
>                     "ethernet-phy-ieee802.3-c22";
> of course circumvents this, but in turn hard-codes the phy.
> 
> With boards often having multiple phy options and the mdio-bus being able
> to actually probe devices, this feels like a step back.
> 
> So check for the existence of a phy-clock per the -dtbinding in the
> of_mdiobus_register_phy() and enable the clock around the
> fwnode_mdiobus_register_phy() call which tries to determine the phy-id.

Why handle this separately to the reset GPIO and the reset controller?

    Andrew
