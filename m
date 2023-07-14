Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D87544F0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjGNW1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGNW1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:27:32 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C22D48;
        Fri, 14 Jul 2023 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=GtEHO/Q5Yft3ebwH0TleGwrRN8mzf3QmoyzqWl6nYKM=; b=ym
        o0JOGxQh+RWTLHKKBgk/FszLD0slJ+4eMe5bujgGYhxet/rTB0QEnkKhFckrzTXcLLQy/EWlW282S
        Pxv5vXxwqKWIaBXMVsIeVOv78ReLBmgF8ekOB6tFU10kGvJRHRsjm/ow9MSjMRVd7KlBtNrfMzoNm
        uWQO8Nvn6SoKznw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qKRFw-001OX4-2q; Sat, 15 Jul 2023 00:27:20 +0200
Date:   Sat, 15 Jul 2023 00:27:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Subject: Re: [PATCH v2 1/2 net-next] net: phy: mscc: add support for CLKOUT
 ctrl reg for VSC8531 and similar
Message-ID: <ab0ca942-5e84-4663-a0ed-689f023624b6@lunn.ch>
References: <20230713202123.231445-1-alex@shruggie.ro>
 <cad1d05d-acdd-454b-a9f8-06262cf8495b@lunn.ch>
 <CAH3L5QrtFwTqqFKjPrMFCz4JgUWOFWFUJXpN71Gyprcd33A7hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH3L5QrtFwTqqFKjPrMFCz4JgUWOFWFUJXpN71Gyprcd33A7hg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 09:09:14AM +0300, Alexandru Ardelean wrote:
> On Thu, Jul 13, 2023 at 11:35 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +set_reg:
> > > +     mutex_lock(&phydev->lock);
> > > +     rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_GPIO,
> > > +                           VSC8531_CLKOUT_CNTL, mask, set);
> > > +     mutex_unlock(&phydev->lock);
> >
> > What is this mutex protecting?
> 
> This was inspired by vsc85xx_edge_rate_cntl_set().
> Which has the same format.

phy_modify_paged() locks the MDIO bus while it swaps the page, so
nothing else can use it. That also protects the read/modify/write.

Nothing is modifying phydev, so the lock is not needed for that
either.

> I'll re-test with this lock removed.
> I may be misremembering (or maybe I did something silly at some
> point), but there was a weird stack-trace warning before adding this
> lock there.
> This was with a 5.10.116 kernel version.

This patch is for net-next, please test there.

When testing for locking issues, and when doing development in
general, it is a good idea to turn on CONFIG_PROVE_LOCKING and
CONFIG_DEBUG_ATOMIC_SLEEP.

	Andrew
