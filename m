Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261817CC55A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbjJQN7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:59:13 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B346F5;
        Tue, 17 Oct 2023 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=LwuQtc6BAEH37KxR4NT7V8Ve+ukUxIEjORvi7ui3JHI=; b=hr
        W9hrfJTecFcxkf91ofdGB59NoYEqMm1qWQPvnOlb7MJUyuWjDT6spSz5Xi7bbqXTxATaJ1w3R/BIa
        b3KCCTHPu29PquXAIwOvvnk91Q4GNLdr/oESLqIN6OL/E3FRcBUHieYPsHNIlUzTPP7NTyMJaZaWU
        uwFkRC3aebRBvXw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qskb9-002U7a-Kb; Tue, 17 Oct 2023 15:59:03 +0200
Date:   Tue, 17 Oct 2023 15:59:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, wangpeiyang1@huawei.com,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
Message-ID: <06cd6f53-e0af-4bdf-a684-68fc55b9b436@lunn.ch>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
 <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
 <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
 <73b41fe2-12dd-4fc0-a44d-f6f94e6541fc@lunn.ch>
 <ef5489f9-43b4-ee59-699b-3f54a30c00aa@huawei.com>
 <e7219114-774f-49d0-8985-8875fd351b60@lunn.ch>
 <a21beff2-9f38-d354-6049-aed20c18c8d4@huawei.com>
 <150d8d95-a6cd-dc28-618b-6cc5295b4bf9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150d8d95-a6cd-dc28-618b-6cc5295b4bf9@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:03:01PM +0800, Jijie Shao wrote:
> 
> on 2023/7/31 17:10, Jijie Shao wrote:
> > 
> > on 2023/7/30 2:23, Andrew Lunn wrote:
> > > >      Now i wounder if you are fixing the wrong thing. Maybe you
> > > > should be
> > > >      fixing the PHY so it does not report up and then down? You
> > > > say 'very
> > > >      snall intervals', which should in fact be 1 second. So is the PHY
> > > >      reporting link for a number of poll intervals? 1min to 10 minutes?
> > > > 
> > > >                Andrew
> > > > 
> > > > Yes, according to the log records, the phy polls every second,
> > > > but the link status changes take time.
> > > > Generally, it takes 10 seconds for the phy to detect link down,
> > > > but occasionally it takes several minutes to detect link down,
> > > What PHY driver is this?
> > > 
> > > It is not so clear what should actually happen with auto-neg turned
> > > off. With it on, and the link going down, the PHY should react after
> > > about 1 second. It is not supposed to react faster than that, although
> > > some PHYs allow fast link down notification to be configured.
> > > 
> > > Have you checked 802.3 to see what it says about auto-neg off and link
> > > down detection?
> > > 
> > > I personally would not suppress this behaviour in the MAC
> > > driver. Otherwise you are going to have funny combinations of special
> > > cases of a feature which very few people actually use, making your
> > > maintenance costs higher.
> > > 
> > >         Andrew
> 
> Hi Andrew,
> We've rewritten the commit log to explain this problem,
> Would you please take some time to review that?
> 
> The following is the new commit log:
> This patch is to correct a wrong log info "link down/up" in hns3 driver.
> When setting autoneg off without changing speed and duplex, the link
> should be not changed. However in hns3 driver, it print link down/up once
> incorrectly. We trace the phy machine state and find the phy change form
> PHY_UP to PHY_RUNNING. No other state of PHY occurs during this process.
> MDIO trace also indicate the link is on. The wrong log info and mdio
> trace are showed as followed:
> 
> [  843.720783][  T367] hns3 0000:35:00.0 eth1: set link(phy): autoneg=0,
> speed=10, duplex=1
> [  843.736087][  T367] hns3 0000:35:00.0 eth1: link down
> [  843.773506][   T17] RTL8211F Gigabit Ethernet mii-0000:35:00.0:02: PHY
> state change UP -> RUNNING
> [  844.674668][   T31] hns3 0000:35:00.0 eth1: link up

I still think this is totally valid and correct.

When you turn auto-neg off the link partner is going to react to that,
it might drop the link. After a while, the link partner will give up
trying to perform auto-neg and might fall back to 10/Half. At which
point, the link might allow traffic flow. However, in this example,
you have a duplex mis-match, so it might not work correctly.

Turning off auto-neg is something you need to do at both ends, and you
need to then force both ends to the same settings. Link down is
expected. I would actually be suppressed if no link down events were
reported.

	Andrew
