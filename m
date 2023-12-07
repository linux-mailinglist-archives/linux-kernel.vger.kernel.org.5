Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF7808EC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443192AbjLGRWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443303AbjLGRWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:22:05 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB67FA;
        Thu,  7 Dec 2023 09:22:12 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rBI4Z-00048B-0E;
        Thu, 07 Dec 2023 17:22:04 +0000
Date:   Thu, 7 Dec 2023 17:22:01 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Jakub Kicinski <kuba@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: extend speeds up to 10G
Message-ID: <ZXH_OdREkrt-7Bwf@makrotopia.org>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
 <20231207172923.62ce530e@dellmb>
 <cdcab57e-ef73-436d-8dac-f92219e4cbf9@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdcab57e-ef73-436d-8dac-f92219e4cbf9@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 06:11:29PM +0100, Andrew Lunn wrote:
> On Thu, Dec 07, 2023 at 05:29:23PM +0100, Marek Behún wrote:
> > On Tue, 28 Nov 2023 04:00:10 +0000
> > Daniel Golle <daniel@makrotopia.org> wrote:
> > 
> > > Add 2.5G, 5G and 10G as available speeds to the netdev LED trigger.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > So what will happen when there are more speeds? Will we create a
> > separate file for each speed?
> > 
> > Will we have a separate sysfs file for 10, 100, 1000, 2500, 5000,
> > 10000, 20000, 25000, 40000, 50000, 56000, 100000, 200000, 400000,
> > 800000 ?

Yes, why not?

I also doubt we are doing to have 800GBit/s on RJ-45 copper any time
soon. And speed-indication is generally only needed for media which
supports more than one speed (ie. twisted copper pair).

> > 
> > These are all speeds from include/uapi/linux/ethtool.h.
> > 
> > Maybe we should have reused ethtool link mode bits, or something...
> 
> That gets pretty ugly. The bits are not in any logical order, since
> they just get appended onto the end as needed.
> 
> > Also, the files should only be present if the requested speed is
> > supported by the net device. So if 2500 mbps is not supported, there
> > should no be link_2500.
> 
> Yes, this would be nice. We have the information in the phy_setting
> settings[] table in phy-core.c.

I agree on that, it would be an additional patch though because that
obviously goes beyond adding some more speeds.
