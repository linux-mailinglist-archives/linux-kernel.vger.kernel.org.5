Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CEA804516
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376460AbjLECih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376555AbjLECi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:38:26 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F8C119;
        Mon,  4 Dec 2023 18:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=sPB/9nJhzupGe0X/gusduBPW1Y18K5OKiwVmvCOQ20k=; b=1dolqDJMGC30Q+yJXEdqjCZsGT
        FC9Owmi66X277vtITRpMoiPso9WDx7YZk8iC6uT4AtKUEA6vksjXWyTYf4SPZnfPXbxCNMhlT5bIN
        WSfIem3wT98SZk4j7a0osv51fh75BvyTr8SwCk8iHsn5GFW+3gdSLT3FmCq9lKN1anHU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rALJr-0022eR-9b; Tue, 05 Dec 2023 03:37:55 +0100
Date:   Tue, 5 Dec 2023 03:37:55 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
 <20231128133630.7829-3-ansuelsmth@gmail.com>
 <20231204181752.2be3fd68@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204181752.2be3fd68@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 06:17:52PM -0800, Jakub Kicinski wrote:
> On Tue, 28 Nov 2023 14:36:30 +0100 Christian Marangi wrote:
> > +/**
> > + * phy_package_write_mmd - Convenience function for writing a register
> > + * on an MMD on a given PHY using the PHY package base addr, added of
> > + * the addr_offset value.
> > + * @phydev: The phy_device struct
> > + * @addr_offset: The offset to be added to PHY package base_addr
> > + * @devad: The MMD to read from
> > + * @regnum: The register on the MMD to read
> > + * @val: value to write to @regnum
> > + *
> > + * Same rules as for phy_write();
> > + *
> > + * NOTE: It's assumed that the entire PHY package is either C22 or C45.
> > + */
> 
> > +/*
> > + * phy_package_write_mmd - Convenience function for writing a register
> > + * on an MMD on a given PHY using the PHY package base addr, added of
> > + * the addr_offset value.
> > + */
> > +int phy_package_write_mmd(struct phy_device *phydev,
> > +			  unsigned int addr_offset, int devad,
> > +			  u32 regnum, u16 val);
> 
> Hm, I see there's some precedent here already for this duplicated
> semi-kdoc. It seems a bit unusual. If I was looking for kdoc and 
> found the header one I'd probably not look at the source file at all.
> 
> Andrew, WDYT?

I tend to agree. These functions should be documented once in kdoc,
and only once. I don't really care if its in the header, or the C
code, but not both.

      Andrew
