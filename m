Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F437F0852
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 19:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjKSSXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 13:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSSX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 13:23:29 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D536C2;
        Sun, 19 Nov 2023 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=+8uIKvl0kla6HC02nY6mUS9xeIycT+TgAHwRn6pDWYQ=; b=Xbx596MY1btI8UJD6Kdskrd8b+
        5zDwpCidjJmkyVlQ5kjn5u245gZeUnrn17PU9kWEInz5soKXjaZ1SB07/rgMWQ6gLUp8V0Y5D8Asp
        j8KGFPc4U3o3Hxf0J7HJuiHVfa3RMXk0O1xLLOW5S4XbWQRli/c6OO9Tv/lBoG0v5SfU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r4mRx-000a50-TY; Sun, 19 Nov 2023 19:23:17 +0100
Date:   Sun, 19 Nov 2023 19:23:17 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [net PATCH] net: phy: correctly check soft_reset ret ONLY if
 defined for PHY
Message-ID: <ca2dc1d5-ff3c-49c9-8b83-28d17c2e9138@lunn.ch>
References: <20231119151258.20201-1-ansuelsmth@gmail.com>
 <5d35be32-58bb-465d-91d9-ca3e8029373e@lunn.ch>
 <655a4c2a.5d0a0220.ead80.bb5d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655a4c2a.5d0a0220.ead80.bb5d@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 06:55:47PM +0100, Christian Marangi wrote:
> On Sun, Nov 19, 2023 at 05:24:00PM +0100, Andrew Lunn wrote:
> > On Sun, Nov 19, 2023 at 04:12:58PM +0100, Christian Marangi wrote:
> > > soft_reset call for phy_init_hw had multiple revision across the years
> > > and the implementation goes back to 2014. Originally was a simple call
> > > to write the generic PHY reset BIT, it was then moved to a dedicated
> > > function. It was then added the option for PHY driver to define their
> > > own special way to reset the PHY. Till this change, checking for ret was
> > > correct as it was always filled by either the generic reset or the
> > > custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
> > > phy: Stop with excessive soft reset"), as the generic reset call to PHY
> > > was dropped but the ret check was never made entirely optional and
> > > dependent whether soft_reset was defined for the PHY driver or not.
> > > 
> > > Luckly nothing was ever added before the soft_reset call so the ret
> > > check (in the case where a PHY didn't had soft_reset defined) although
> > > wrong, never caused problems as ret was init 0 at the start of
> > > phy_init_hw.
> > > 
> > > To prevent any kind of problem and to make the function cleaner and more
> > > robust, correctly move the ret check if the soft_reset section making it
> > > optional and needed only with the function defined.
> > 
> > I think this should target net-next, not net. It does not appear to be
> > an problem which actually affects somebody using stable kernels.
> > 
> > The change itself looks O.K.
> >
> 
> Ok to resubmit or should I wait 24h? (asking as it's a very simple
> change)

Please wait 24 hours.

> Also is the stable Cc ok?
> (that was the main reason I added the net tag to this)

No drop the Cc: Stable. Your description of the problem does not fit
the rules for stable.

    Andrew
