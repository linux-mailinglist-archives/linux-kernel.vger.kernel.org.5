Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681D87FFC15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376640AbjK3UOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376623AbjK3UOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:14:06 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA7D5C;
        Thu, 30 Nov 2023 12:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=QiJokDsL8QN5EiH/N+WOWgk31hOcooIUYZ6/kJVxIFs=; b=M/FFasjTuZNrAreY8dUIOLYxRJ
        mD5Qk6SW2y6l1bzv9Mk+9Lw1xoIdD5PRw1zr829LS4KGK5TWbb8pOeBCBvFUgWivUogjapvqvOhnm
        AM9NTcanmq+0zhhOv0rCXVwnklVekN/G+EVY4XtvqRFmaFa51LKzVObqzHuf/07xp8j4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r8nQ8-001hSg-8R; Thu, 30 Nov 2023 21:14:00 +0100
Date:   Thu, 30 Nov 2023 21:14:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 06/14] net: phy: at803x: move at8031 specific
 data out of generic at803x_priv
Message-ID: <568f8b22-a7d2-46c3-a539-30ecf6a85b18@lunn.ch>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-7-ansuelsmth@gmail.com>
 <47df2f0d-3410-43c2-96d3-87af47cfdcce@lunn.ch>
 <6568e4aa.050a0220.120a5.9c83@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6568e4aa.050a0220.120a5.9c83@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:38:17PM +0100, Christian Marangi wrote:
> On Thu, Nov 30, 2023 at 04:21:50PM +0100, Andrew Lunn wrote:
> > > +struct at8031_data {
> > > +	bool is_fiber;
> > > +	bool is_1000basex;
> > > +	struct regulator_dev *vddio_rdev;
> > > +	struct regulator_dev *vddh_rdev;
> > > +};
> > > +
> > >  struct at803x_priv {
> > >  	int flags;
> > >  	u16 clk_25m_reg;
> > >  	u16 clk_25m_mask;
> > >  	u8 smarteee_lpi_tw_1g;
> > >  	u8 smarteee_lpi_tw_100m;
> > > -	bool is_fiber;
> > > -	bool is_1000basex;
> > > -	struct regulator_dev *vddio_rdev;
> > > -	struct regulator_dev *vddh_rdev;
> > > +
> > > +	/* Specific data for at8031 PHYs */
> > > +	void *data;
> > >  };
> > 
> > I don't really like this void *
> > 
> > Go through at803x_priv and find out what is common to them all, and
> > keep that in one structure. Add per family private structures which
> > include the common as a member.
> 
> As you notice later in the patches, only at803x have stuff in common
> qca803xx and qca808x doesn't use the struct at all (aside from stats)

The dangers here are taking a phydev->priv and casting it. You think
it is X, but is actually Y, and bad things happen.

The helpers you have in your common.c must never do this. You can have
a at803x_priv only visible inside the at803x driver, and a
qca808x_priv only visible inside the qca808x driver. Define a
structure which is needed for the shared code in common.c, and pass it
as a parameter to these helpers.

You have a reasonably good idea what your end goal is. The tricky part
is getting there, in lots of easy to review, obviously correct steps.

	Andrew

