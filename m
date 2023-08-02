Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EDC76DAEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjHBWpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjHBWps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:45:48 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3809F2D4A;
        Wed,  2 Aug 2023 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BcA9s6B7nnGqXxdJ4+z402opSI+GaEOGt+DG2Ys8Ivg=; b=sXK7Emzdgo59rQOKYkMfCYsPdk
        qIk6ZJBK9TgfNgCRv/tDTRVO7bED9TJaoIH0mQJ3+tDUWbrvIy3U5qnaTUH+b3g7XFIXCZpOIUuBc
        ClRySUCfPL3u5VbEOcQvW4zG8B9M5m9Wjsz0WW1s5jbv72ZWDYbL8w846gyhQCnBCm2w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qRKDH-002vc6-DN; Thu, 03 Aug 2023 00:21:03 +0200
Date:   Thu, 3 Aug 2023 00:21:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Michael Walle <mwalle@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 02/11] net: phy: introduce
 phy_has_c45_registers()
Message-ID: <cdd97217-d5e5-429b-bcda-2248f0de12ce@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-2-9eb37edf7be0@kernel.org>
 <7be8b305-f287-4e99-bddd-55646285c427@lunn.ch>
 <867ae3cc05439599d63e4712bca79e27@kernel.org>
 <cf999a14e51b7f2001d9830cc5e11016@kernel.org>
 <ZMkddjabRonGe7Eu@shell.armlinux.org.uk>
 <bce942b71db8c4b9bf741db517e7ca5f@kernel.org>
 <ZMkraPZvWWKhY8lT@shell.armlinux.org.uk>
 <b0e5fbe28757d755d814727181c09f32@kernel.org>
 <7c29bfa7-b4a6-49c9-9369-d98bae98f135@lunn.ch>
 <ZMqOA+NblHun1hbo@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMqOA+NblHun1hbo@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 06:10:27PM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 02, 2023 at 06:15:19PM +0200, Andrew Lunn wrote:
> > > I'm confused now. Andrew suggested to split it into four different
> > > functions:
> > > 
> > > phy_has_c22_registers()
> > > phy_has_c45_registers()
> > > phy_has_c22_transfers()
> > > phy_has_c45_transfers()
> > > 
> > > Without a functional change. That is, either return phydev->is_c45
> > > or the inverse.
> > 
> > Without a functional change at this step of introducing the four
> > functions. Then later really implement them to do what the name
> > implies. Doing it in steps helps with bisect when it breaks something.
> > 
> > It could also be that not all four are needed, or not all four are
> > possible. But the four express the full combinations of transfers and
> > registers.
> 
> I'm left wondering how you think that phy_has_c45_registers() can
> be implemented in a useful way, because I'm at a total loss...

get_phy_c22_id() looks at the ID registers, and see if its mostly
Fs. If so, it says -ENODEV. So phy_has_c22_registers() could be
get_phy_c22_id() != -ENODEV. And you can extend that with the logic
you quoted from the standard. get_phy_c45_ids() also returns -ENODEV
if there are no devices in the package. So phy_has_c45_registers()
could be get_phy_c45_id() != -ENODEV.

This is heuristics, not something explicitly from the standard, but
the basic idea of looking for not mostly Fs has been used for a long
time.

    Andrew
