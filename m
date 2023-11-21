Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA75C7F3108
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjKUOfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjKUOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:35:28 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888B81A3;
        Tue, 21 Nov 2023 06:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=QKGUm3YOEgFjR/qZttfUWApAFjwkLqqdBvdeGQxH6vg=; b=h54+mbZFXArzqshetgeGPPBTIF
        o5gpQfR4+aIlRkUd1ZHanwKfUHyipyyh7QdK/sSDK2hoUIeSx9i3EN0OxBG5fIhnYwhcLa5lGE5zw
        T2tSAFDwADYzcG6h1b1F718eG0L7CUgX2FTS3dNrhpgx90M0fCqfknvu5JI+EBbaYzSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r5RqR-000lXq-O1; Tue, 21 Nov 2023 15:35:19 +0100
Date:   Tue, 21 Nov 2023 15:35:19 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 03/10] net: phy: add helpers to handle
 sfp phy connect/disconnect
Message-ID: <cd66774b-701a-43c8-9677-d3d7fd13b059@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
 <20231117162323.626979-4-maxime.chevallier@bootlin.com>
 <ac7d9aa6-e403-482b-a12a-d5821787dd4c@lunn.ch>
 <ZVyBgNcFrSubz2jn@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVyBgNcFrSubz2jn@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:08:00AM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 21, 2023 at 01:57:24AM +0100, Andrew Lunn wrote:
> > > +/**
> > > + * phy_sfp_connect_phy - Connect the SFP module's PHY to the upstream PHY
> > > + * @upstream: pointer to the upstream phy device
> > > + * @phy: pointer to the SFP module's phy device
> > > + *
> > > + * This helper allows keeping track of PHY devices on the link. It adds the
> > > + * SFP module's phy to the phy namespace of the upstream phy
> > > + */
> > > +int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
> > > +{
> > > +	struct phy_device *phydev = upstream;
> > 
> > Will this function only ever be called from a PHY driver? If so, we
> > know upstream is PHY. So we can avoid using void * and make it a
> > struct phy_device *. 
> 
> No. This function is hooked into the .connect_phy method of
> sfp_upstream_ops, and the SFP bus layer has no idea what the
> "upstream" is. In this case, it's a PHY. In the case of phylink,
> it's the phylink struct. So no, "struct phy_device *" here will
> cause build errors.

O.K, thanks for checking this. It would of been nice to have some
compile time checking what is passed is what we expect in terms of
type, but C does not allow that in this case.

	 Andrew
