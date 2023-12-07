Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D2808E57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjLGRLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGRLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:11:41 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CB110EB;
        Thu,  7 Dec 2023 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=/UFjD58fhtoLAst150cniGCGsb0qSuthtkjBFrtzgWQ=; b=To
        9TIVrzpz8t2dkPVK0anb4qxU9D9czgjdViR0/5xmzbyUMZRjVvyo5P2lmhcNuJERkM8VokSq7XMJO
        qSd67bYlbk5ZKI8vAgFda7Et3yyidIceUOXxFK59lTr19DOWiJ+lATtOEru/23HUrjkkZ+WprR+dT
        AFMDiUn+EUptw/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rBHuL-002Kqt-1h; Thu, 07 Dec 2023 18:11:29 +0100
Date:   Thu, 7 Dec 2023 18:11:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Daniel Golle <daniel@makrotopia.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: extend speeds up to 10G
Message-ID: <cdcab57e-ef73-436d-8dac-f92219e4cbf9@lunn.ch>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
 <20231207172923.62ce530e@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207172923.62ce530e@dellmb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 05:29:23PM +0100, Marek Behún wrote:
> On Tue, 28 Nov 2023 04:00:10 +0000
> Daniel Golle <daniel@makrotopia.org> wrote:
> 
> > Add 2.5G, 5G and 10G as available speeds to the netdev LED trigger.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> So what will happen when there are more speeds? Will we create a
> separate file for each speed?
> 
> Will we have a separate sysfs file for 10, 100, 1000, 2500, 5000,
> 10000, 20000, 25000, 40000, 50000, 56000, 100000, 200000, 400000,
> 800000 ?
> 
> These are all speeds from include/uapi/linux/ethtool.h.
> 
> Maybe we should have reused ethtool link mode bits, or something...

That gets pretty ugly. The bits are not in any logical order, since
they just get appended onto the end as needed.

> Also, the files should only be present if the requested speed is
> supported by the net device. So if 2500 mbps is not supported, there
> should no be link_2500.

Yes, this would be nice. We have the information in the phy_setting
settings[] table in phy-core.c.

	 Andrew
