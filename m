Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CA679D586
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjILQBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjILQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:01:18 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F1210DE;
        Tue, 12 Sep 2023 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=tq30nNEn1JgDcmHrMM18jbiaohWzwQumlsnaeQ+8IIk=; b=aM2k488CKyE2crSflT163ivYer
        ciAx3XA8NFqMOpS3fWZf/gpZfPgddwUO38cNtdcHOruuguEPo5weJzALuW5C4Nfcg994puYZ3Lgpv
        Ui9SkVa9tqB0ajjpMOLyXwbh47S+bDscfdOJNv3FozhdoHOTMsGq2mMDvzMNKdO1HsEc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qg5p8-006FFK-Pb; Tue, 12 Sep 2023 18:01:10 +0200
Date:   Tue, 12 Sep 2023 18:01:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 4/7] net: ethtool: add a netlink command to
 list PHYs
Message-ID: <72a5cd8f-d776-479c-9d7f-191900d19342@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <20230907092407.647139-5-maxime.chevallier@bootlin.com>
 <ZPmfOOsqoO02AcBH@shell.armlinux.org.uk>
 <20230907141635.20bcaa59@pc-7.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907141635.20bcaa59@pc-7.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:16:35PM +0200, Maxime Chevallier wrote:
> Hello Russell,
> 
> On Thu, 7 Sep 2023 11:00:24 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Thu, Sep 07, 2023 at 11:24:02AM +0200, Maxime Chevallier wrote:
> > > +#define PHY_MAX_ENTRIES	16
> > > +
> > > +struct phy_list_reply_data {
> > > +	struct ethnl_reply_data		base;
> > > +	u8 n_phys;
> > > +	u32 phy_indices[PHY_MAX_ENTRIES];  
> > 
> > Please could you detail the decision making behind 16 entries - is this
> > arbitary or based on something?
> > 
> > Also, please consider what we should do if we happen to have more than
> > 16 entries.
> 
> Ah indeed it was totally arbitrary, the idea was to have a fixed-size
> reply struct, so that we can populate the
> ethnl_request_ops.reply_data_size field and not do any manual memory
> management. But I can store a pointer to the array of phy devices,
> dynamically allocated and we won't have to deal with this fixed,
> arbitrary-sized array anymore.

I think Jakub already commented on this somewhere, but netlink should
allow for arbitrary long lists.

      Andrew
