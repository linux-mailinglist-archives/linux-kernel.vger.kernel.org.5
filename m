Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D487B70C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbjJCS0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjJCS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:26:13 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBD983;
        Tue,  3 Oct 2023 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=8kSMH9mFqlEMXMzJocJNXqDhfdneaQ4QxIN0eEXIpF4=; b=iWYRx9ujoGpS1M3bid/rdR2a74
        laVYS2fLJAupCJS4QXe4dPW/AVtfuKeAb/V3sgOeD5MwYWAK1HVGT1v6oNhIt6dwz07zZ7ARAZcMy
        ul60nlEbBP3OODvmQgr2HeM3hJVBax6iAt/vF/k7ycEiZ+R71wVNaR6knoFXd2QRgbA0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qnk5p-00899E-74; Tue, 03 Oct 2023 20:26:01 +0200
Date:   Tue, 3 Oct 2023 20:26:01 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to
 get PHY information
Message-ID: <ffc6ff4a-d1af-4643-a538-fd13e6be9e06@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <20230907092407.647139-7-maxime.chevallier@bootlin.com>
 <20230908084606.5707e1b1@kernel.org>
 <20230914113613.54fe125c@fedora>
 <20231003065535.34a3a4e0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003065535.34a3a4e0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 06:55:35AM -0700, Jakub Kicinski wrote:
> On Thu, 14 Sep 2023 11:36:13 +0200 Maxime Chevallier wrote:
> > I'm currently implementing this, and I was wondering if it could be
> > worth it to include a pointer to struct phy_device directly in
> > ethnl_req_info.
> > 
> > This would share the logic for all netlink commands that target a
> > phy_device :
> > 
> >  - plca
> >  - pse-pd
> >  - cabletest
> >  - other future commands
> > 
> > Do you see this as acceptable ? we would grab the phy_device that
> > matches the passed phy_index in the request, and if none is specified,
> > we default to dev->phydev.
> 
> You may need to be careful with that. It could work in practice but 
> the req_info is parsed without holding any locks, IIRC. And there
> may also be some interplay between PHY state and ethnl_ops_begin().

We also need to ensure it is totally optional. There are MAC drivers
which reinvent the wheel in firmware. They can have multiple PHYs, or
PHY and SFP in parallel etc. All the typologies which you are
considering for phylink. Ideally we want the uAPI to work for
everybody, not just phylink. Its not our problem how said firmware
actually works, and what additional wheels they need to re-implement,
but we should try not to block them.

    Andrew
