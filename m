Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0279C7F6238
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbjKWPBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345983AbjKWPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:00:55 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EECBD4A;
        Thu, 23 Nov 2023 07:01:00 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CB7BC0007;
        Thu, 23 Nov 2023 15:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700751659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67t1kQ5eApWl1dAvZGC/sSzZTqCDw1OnraYDpdtwPb0=;
        b=fMJ+MHbePAqSLetgUTxkoWL/yRltcQ5W6pj/ZeyrU0uBwtrQhzeaOl4yuWR6rQ5akSd74C
        MMUYTY6Z8qOcT3WD0p9rhAIMxkv1oAVx/8kmuLht5f7vmqn8xisgK51eESVTf718MKjwxh
        oq5PLpJyTm8MmCPet+utW5pDbsW02M4vDZc0sEqKQUhWc90DQNA0qZt664kdp3J3T1T/fl
        B9tCq9uGNkJtPSI1FYHRJlVYxWwvq12IFSKFZOa8cloJIgNIpYYTWsdS5qUglrja8lWLCq
        d5htaDWLWfNdP7ZJk8zJQGkDYlKtVhemZ+T9MgaDdvzReQfr+GgxXDRAbnKkDg==
Date:   Thu, 23 Nov 2023 16:00:56 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
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
Message-ID: <20231123160056.070f3311@kmaincent-XPS-13-7390>
In-Reply-To: <20231122100142.338a2092@kernel.org>
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
        <20231122100142.338a2092@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 10:01:42 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 22 Nov 2023 18:55:17 +0200 Vladimir Oltean wrote:
> > > Well, ethtool has been the catch all for a lot of random things
> > > for the longest time. The question is whether we want to extend
> > > ETHTOOL_GET_TS_INFO or add a third API somewhere else. And if we
> > > do - do we also duplicate the functionality of ETHTOOL_GET_TS_INFO
> > > (i.e. getting capabilities)?
> > >=20
> > > My vote is that keeping it in ethtool is less bad than 3rd API.   =20
> >=20
> > With SIOCSHWTSTAMP also implemented by CAN (and presumably also by
> > wireless in the future), I do wonder whether ethtool is the right place
> > for the netlink conversion. =20
>=20
> ethtool currently provides the only way we have to configure ring
> length, ring count, RSS, UDP tunnels etc.
>=20
> It's a matter of taste, IMO ethtool is a bit of a lost cause already
> and keeping things together (ethtool already has TS_INFO) is cleaner
> than spreading them around.
>=20
> > I wouldn't suggest duplicating ETHTOOL_GET_TS_INFO towards the netdev
> > netlink family. =20
>=20
> FTR so far the netdev family is all about SW configuration. We should
> probably keep it that way, so it doesn't become ginormous. It's easy
> enough to create a new family, if needed.

So, do we have a consensus? Vlad, do you agree on putting all under ethtool?

ETHTOOL_GET_TS_INFO will be in charge of replacing the SIOCGHWSTAMP
implementation. Need to add ETHTOOL_A_TSINFO_PHC_INDEX
ETHTOOL_A_TSINFO_QUALIFIER to the request.

ETHTOOL_GET_TS_INFO will list all the hwtstamp provider (aka "{phc_index,
qualifier}") through the dumpit callback. I will add a filter to be able to
list only the hwtstamp provider of one netdev.

ETHTOOL_SET_TS_INFO will be in charge of replacing the SIOCSHWSTAMP
implementation.

Is that ok for you?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
