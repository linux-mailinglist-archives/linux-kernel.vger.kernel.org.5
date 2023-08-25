Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0ED788899
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245107AbjHYNaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245109AbjHYN3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:29:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC221FDF;
        Fri, 25 Aug 2023 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=kby7pl3idO/bMWkcA00Dzg9yYh2+GlYM7ZuG4/jazKQ=; b=hgYdt44QpM0bWTPJZ+RS3zhlQC
        Pjl5YKidc/tsjgkF0lLKfl45YFwmHZVA0WXIIJijXQOEUbentcnVeBl7eNHfCluVmnAGMyMLwpw6U
        b/G6JCczb+7qaiOrv/w9hCad/Co/qISuxx6AYGNfS0AZVQ+hsHHbhgkc+DVqxbuQdFcA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qZWsU-0055pj-6Z; Fri, 25 Aug 2023 15:29:30 +0200
Date:   Fri, 25 Aug 2023 15:29:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, sebastian.tobuschat@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Message-ID: <95f66997-c6dd-4bbc-b1ef-dad1e7ed533e@lunn.ch>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
 <ZOikKUjRvces_vVj@hog>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOikKUjRvces_vVj@hog>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 02:52:57PM +0200, Sabrina Dubroca wrote:
> [Some of the questions I'm asking are probably dumb since I don't know
> anything about phy drivers. Sorry if that's the case.]
> 
> General code organization nit: I think it would be easier to review
> the code if helpers functions were grouped by the type of object they
> work on. All the RXSA-related functions together, all the TXSA
> functions together, same for RXSC and then TXSC/SecY. Right now I see
> some RXSA functions in a group of TXSA functions, another in the
> middle of a group of RXSC functions. It makes navigating through the
> code a bit less convenient.

For networking, and Linux in general, forward declarations are not
liked. Functions should appear before they are used. That places a bit
of restrictions on ordering, but in general you can still group code
in meaningful ways.

> 2023-08-24, 12:16:13 +0300, Radu Pirea (NXP OSS) wrote:
> > +static int nxp_c45_macsec_write(struct phy_device *phydev, u16 reg, u32 val)
> > +{
> > +	WARN_ON_ONCE(reg % 4);
> > +
> > +	reg = reg / 2;
> > +	phy_write_mmd(phydev, MDIO_MMD_VEND2,
> > +		      VEND1_MACSEC_BASE + reg, val);
> > +	phy_write_mmd(phydev, MDIO_MMD_VEND2,
> > +		      VEND1_MACSEC_BASE + reg + 1, val >> 16);
> 
> Can these calls fail? ie, do you need to handle errors like in
> nxp_c45_macsec_read (and then in callers of nxp_c45_macsec_write)?

Access to PHY devices can fail, but if it does, such failures are
generally fatal and there is no real recovery, also the next read/
write is also likely to fail. So we do recommend checking return codes
and just return the error up the stack. That failure might get trapped
up the stack, and turned into a phy_error() call which will disable
the PHY.

> > +static bool nxp_c45_rx_sc_valid(struct nxp_c45_secy *phy_secy,
> > +				struct macsec_rx_sc *rx_sc)
> > +{
> > +	u16 port =  (__force u64)rx_sc->sci >> (ETH_ALEN * 8);
> 
> u64 sci = be64_to_cpu((__force __be64)rx_sc->sci);

why is the __force needed? What happens with a normal cast?

    Andrew
