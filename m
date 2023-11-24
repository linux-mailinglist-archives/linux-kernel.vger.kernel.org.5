Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53FF7F7A77
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjKXRek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjKXRef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:34:35 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B771BC1;
        Fri, 24 Nov 2023 09:34:38 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3954620005;
        Fri, 24 Nov 2023 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700847276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laVIeNuGyFNN2rVJzpoTnXeNYtbS9ZVvlwtfDxQdzIk=;
        b=NEgPb+vOyRQ1ywouxZWdYL2UIT0XGQo8B+dEqnidX5Zf5XUSs5CzP59hDWMa/19kgEUU+3
        XlwIG+5nrVnuOSfJhXCPDGQYfCSjuRuqCcAQrENgGuWkqD2qFKxGiYEEQ073A6N4nx/KD5
        CijJY2CwV9x0+DVAjbZfUKsb1AbxzXpLuP229W0teCce18Fp3jiYPkPgfbY6yByFBn5GMJ
        J6gtEPcx1KcrXfDsBArJH2zkti+xFPVEgP90EBFl4873ggMU+qv/KmISx/YC9tJYK4feKG
        oir2q+YPUObGtB+L03HCeTRDkiHog+Zy+1sWEbD7IMb9Q+y4zxQbRv0GPVLQrA==
Date:   Fri, 24 Nov 2023 18:34:31 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <20231124183431.5d4cc189@kmaincent-XPS-13-7390>
In-Reply-To: <20231124154343.sr3ajyueoshke6tn@skbuf>
References: <20231120220549.cvsz2ni3wj7mcukh@skbuf>
        <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
        <20231121094354.635ee8cd@kernel.org>
        <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
        <20231122140850.li2mvf6tpo3f2fhh@skbuf>
        <20231122085000.79f2d14c@kernel.org>
        <20231122165517.5cqqfor3zjqgyoow@skbuf>
        <20231122100142.338a2092@kernel.org>
        <20231123160056.070f3311@kmaincent-XPS-13-7390>
        <20231123093205.484356fc@kernel.org>
        <20231124154343.sr3ajyueoshke6tn@skbuf>
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

On Fri, 24 Nov 2023 17:43:43 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Thu, Nov 23, 2023 at 09:32:05AM -0800, Jakub Kicinski wrote:
> > On Thu, Nov 23, 2023 at 04:00:56PM +0100, K=C3=B6ry Maincent wrote: =20
> > > So, do we have a consensus? Vlad, do you agree on putting all under
> > > ethtool?
> > >=20
> > > ETHTOOL_GET_TS_INFO will be in charge of replacing the SIOCGHWSTAMP
> > > implementation. Need to add ETHTOOL_A_TSINFO_PHC_INDEX
> > > ETHTOOL_A_TSINFO_QUALIFIER to the request.
> > >=20
> > > ETHTOOL_GET_TS_INFO will list all the hwtstamp provider (aka "{phc_in=
dex,
> > > qualifier}") through the dumpit callback. I will add a filter to be a=
ble
> > > to list only the hwtstamp provider of one netdev.
> > >=20
> > > ETHTOOL_SET_TS_INFO will be in charge of replacing the SIOCSHWSTAMP
> > > implementation. =20
> >=20
> > If not we can do a vote/poll? Maybe others don't find the configuration
> > of timestamping as confusing as me. =20
>=20
> If you mean the ETHTOOL_MSG_TSINFO_GET netlink message (ETHTOOL_GET_TS_IN=
FO
> is an ioctl), you're saying that you want to move the entire contents of
> SIOCGHWSTAMP there, by making the kernel call ndo_hwtstamp_get() in
> addition to the existing __ethtool_get_ts_info()?

Yes.
=20
> Yeah, I don't know, I don't have a real objection, I guess it's fine.
>=20
> What will be a bit of an "?!" moment for users is when ethtool gains
> support for the SIOCGHWSTAMP/SIOCSHWSTAMP netlink replacements, but not
> for the original ioctls. So hwstamp_ctl will be able to change timestampi=
ng
> configuration, but ethtool wouldn't - all on the same system. Unless
> ethtool gains an ioctl fallback for a ioctl that was never down its alley.

Yes indeed. Would it break things if both ioctls and netlink can get and set
the hwtstamps configuration? It is only configuration. Both happen under
rtnl_lock it should be alright.

The question is which hwtstamp provider will the original ioctls be able to
change? Maybe the default one (MAC with phy whitelist) and only this one.

> But by all means, still hold a poll if you want to. I would vote for
> ethtool netlink, not because it's great, just because I don't have a
> better alternative to propose.

If you agree on that choice, let's go. Jakub and your are the most proactive
reviewers in this patch series. Willem you are the timestamping maintainer =
do
you also agree on this?=20
If anyone have another proposition let them speak now, or forever remain
silent! ;)

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
