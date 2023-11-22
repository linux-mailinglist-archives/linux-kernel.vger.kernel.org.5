Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464057F4D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjKVQuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbjKVQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:50:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7C6D59
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:50:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A345C433C7;
        Wed, 22 Nov 2023 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700671802;
        bh=ZFMcFjU59M2XNKlhy1XsxNfFuYDu0NpI3SyILQsRT0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fPSeQNCQqy1/x5905Xjdl5nq7QlL/tId3x7pQFXoAGW37wFFRtiWTGUUKJ/YJUR4e
         /9Nxv3QiRn8YLbTS71k2DfvyQ873pq9HsTshUHDbAfumGHRH/hgfGs37zMYSknImv9
         2xRa9GS6P1vBKasQ+XP/mf0W5RFjTGB6kwo6DeL1O3Fp+5kESIh3JsdUS0G7XAUsjb
         ZF4IxuO7V4cc8x+FJfcCYQkcPXegfEeqzgJX/x+Q9hBd7sxwgthverEd2ugTpnjJ/3
         h2rS0RRV8qd1ovaKTwKS7AR9+USkfjbswYTljgoSpMPAywz1G34liMSX23P6pfv+2w
         935H/le0J7+hg==
Date:   Wed, 22 Nov 2023 08:50:00 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231122085000.79f2d14c@kernel.org>
In-Reply-To: <20231122140850.li2mvf6tpo3f2fhh@skbuf>
References: <20231120142316.d2emoaqeej2pg4s3@skbuf>
        <20231120093723.4d88fb2a@kernel.org>
        <20231120190023.ymog4yb2hcydhmua@skbuf>
        <20231120115839.74ee5492@kernel.org>
        <20231120211759.j5uvijsrgt2jqtwx@skbuf>
        <20231120133737.70dde657@kernel.org>
        <20231120220549.cvsz2ni3wj7mcukh@skbuf>
        <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
        <20231121094354.635ee8cd@kernel.org>
        <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
        <20231122140850.li2mvf6tpo3f2fhh@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 16:08:50 +0200 Vladimir Oltean wrote:
> My understanding of Jakub's email was that he wants to see the functionality
> offered by SIOCGHWTSTAMP and SIOCSHWTSTAMP converted to netlink. I don't
> think that ethtool is the correct netlink family for that, given that
> these aren't ethtool ioctls to begin with. Maybe the new netdev netlink
> family. The conversion in its basic form would offer exactly the same
> functionality.

Well, ethtool has been the catch all for a lot of random things
for the longest time. The question is whether we want to extend
ETHTOOL_GET_TS_INFO or add a third API somewhere else. And if we
do - do we also duplicate the functionality of ETHTOOL_GET_TS_INFO
(i.e. getting capabilities)?

My vote is that keeping it in ethtool is less bad than 3rd API.

> The _listing_ of hwtstamp providers is what could be done through ethtool
> netlink, similar but not identical to the way in which you are proposing
> today (you are presenting blanket "layers" which correspond to netdev and
> phylib, rather than individual providers).
> 
> The concept of an "active phc_index" would not explicitly exist in the
> UAPI. Thus I'm not sure what's with this TSINFO_SET being floated around.
> The only thing would exist is a configurable rx_filter and tx_type per
> hwtstamp provider (aka "{phc_index, qualifier}"). User space will have
> to learn to select the hwtstamp provider it wants to configure through
> netlink, and use for its class of traffic.

"Active provider" is the one that has TX_ON, rx != FILTER_NONE, right?

> This is why I mentioned by ndo_hwtstamp_set() conversion, because
> suddenly it is a prerequisite for any further progress to be done.
> You can't convert SIOCSHWTSTAMP to netlink if there are some driver
> implementations which still use ndo_eth_ioctl(). They need to be
> UAPI-agnostic.

Right, definitely.

> I'm not sure what's with Richard's mention of the "_2" variants of the
> ioctls. Probably a low-effort suggestion which was a bit out of context.
> His main point, that you cannot extend struct hwtstamp_config as that
> has a fixed binary format, is perfectly valid though. This is why
> netlink is preferable, because if done correctly (meaning not with
> NLA_BINARY attributes), then it is much more extensible because all
> attributes are TLVs. Use NLA_BINARY, and you will run into the exact
> extensibility issues that the ioctl interface has.
