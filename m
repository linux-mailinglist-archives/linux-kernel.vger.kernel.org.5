Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA497F4EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbjKVSB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVSBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:01:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A9F101
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:01:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0567C433C8;
        Wed, 22 Nov 2023 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700676111;
        bh=DWUiekk1hXft3g2yCopiERCaH6fhza4b69cZTvVcpdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nQIgQnzE8sTuB2DQUrkEMhm03hfOt5YWmPcs0VsVDtftb/G48o6iBHxOmw20lS9be
         DaegCqg2DP/BsE/B8n4Bo+08u4yNMfJ8CJZdfsFovhf9u6eORI5FRqev+i/kIJABSs
         GZsh+6A2/E5VqM1izplteYHYi4FC5E8h+MfoSvq+GeA6WFIEPfaujwnXieIQ9O93h+
         KEIamZvzC6GMENp4JuTC654m+8q97bu1fSkLR/gDkS6e8f7uXGn/yXa96YxBqVf2Og
         yntLYbTY6uMkbWuXOV003GzruNZm1V1isg/X+YMlt9/NiKwv651heL0bAY2ffsPmEP
         rqsT4iPbYwSSA==
Date:   Wed, 22 Nov 2023 10:01:42 -0800
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
Message-ID: <20231122100142.338a2092@kernel.org>
In-Reply-To: <20231122165517.5cqqfor3zjqgyoow@skbuf>
References: <20231120190023.ymog4yb2hcydhmua@skbuf>
        <20231120115839.74ee5492@kernel.org>
        <20231120211759.j5uvijsrgt2jqtwx@skbuf>
        <20231120133737.70dde657@kernel.org>
        <20231120220549.cvsz2ni3wj7mcukh@skbuf>
        <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
        <20231121094354.635ee8cd@kernel.org>
        <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
        <20231122140850.li2mvf6tpo3f2fhh@skbuf>
        <20231122085000.79f2d14c@kernel.org>
        <20231122165517.5cqqfor3zjqgyoow@skbuf>
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

On Wed, 22 Nov 2023 18:55:17 +0200 Vladimir Oltean wrote:
> > Well, ethtool has been the catch all for a lot of random things
> > for the longest time. The question is whether we want to extend
> > ETHTOOL_GET_TS_INFO or add a third API somewhere else. And if we
> > do - do we also duplicate the functionality of ETHTOOL_GET_TS_INFO
> > (i.e. getting capabilities)?
> > 
> > My vote is that keeping it in ethtool is less bad than 3rd API.  
> 
> With SIOCSHWTSTAMP also implemented by CAN (and presumably also by
> wireless in the future), I do wonder whether ethtool is the right place
> for the netlink conversion.

ethtool currently provides the only way we have to configure ring
length, ring count, RSS, UDP tunnels etc.

It's a matter of taste, IMO ethtool is a bit of a lost cause already
and keeping things together (ethtool already has TS_INFO) is cleaner
than spreading them around.

> I wouldn't suggest duplicating ETHTOOL_GET_TS_INFO towards the netdev
> netlink family.

FTR so far the netdev family is all about SW configuration. We should
probably keep it that way, so it doesn't become ginormous. It's easy
enough to create a new family, if needed.
