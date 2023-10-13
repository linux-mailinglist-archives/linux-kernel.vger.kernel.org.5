Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15AC7C8E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjJMUPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjJMUPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:15:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B59BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:15:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953FEC433C8;
        Fri, 13 Oct 2023 20:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697228107;
        bh=E3+dZ0gO7twUQSKLtNiS/mkH2B9x8cmNDaJpgepLg8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y+MuLCIvcVqb9CfklV543jhsCSzIgWsevDuqNSl5yfnYh20EYYFfg2orc7ZLpAYWx
         3lj/HShq8p/wIOEDd5opfnj8bR/AfQKeWWssVw6RDCOsh0oiQigxaXD3NJSeZdoqXZ
         g7jtQYS0YydDbm5V39DR1l/OKKuCmlMJy5Bpm7x8bfSQlJUfo05pkBXTh+HKjhnGtD
         UxLcz+2brd/hvjxuwnTAmF4aE85lTc8r7Vj+QgzRE0cQYdeU7vivt/+WDDvx1YesQo
         FLtpLXmBDH1uSXM3/43HSDByYJAmjXK/ULsR7vXl5dfnb0g9tEvgwZc7TjzcNmdeUg
         vwQa19h9Y878w==
Date:   Fri, 13 Oct 2023 13:15:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231013131505.2b27e3b8@kernel.org>
In-Reply-To: <20231013175601.5mpyx7cjy6cp6sdb@skbuf>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
        <20231009155138.86458-9-kory.maincent@bootlin.com>
        <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
        <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
        <20231013090020.34e9f125@kernel.org>
        <20231013161446.st7tlemyaj3ggkgk@skbuf>
        <20231013093056.4f915df1@kernel.org>
        <20231013170903.p3ycicebnfrsmoks@skbuf>
        <20231013104606.174664a2@kernel.org>
        <20231013175601.5mpyx7cjy6cp6sdb@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 20:56:01 +0300 Vladimir Oltean wrote:
> > > I'm not really sure what you're referring to, with SOF_..._DMA.
> > > The DMA, if presented as a PHC as I am proposing, would play the role=
 of
> > > the hardware timestamp provider (think SOF_TIMESTAMPING_TX_HARDWARE |
> > > SOF_TIMESTAMPING_RX_HARDWARE), so there will be no driver-visible
> > > special socket option flags for DMA timestamping. =20
> >=20
> > Each packet may want different timestamp tho, especially on Tx it
> > should be fairly easy for socket to request to get "real" MAC stamps,
> > while most get cheaper DMA stamps. Currently some drivers run flow
> > matching to find PTP packets and automatically give them better quality
> > timestamps :(
> >=20
> > Even if at the config level we use PHCs we need to translate that into
> > some SKBTX_* bit, don't we? =20
>=20
> I think Richard had something to say about that being wishful thinking:
> https://lore.kernel.org/netdev/ZGw46hrpiqCVNeXS@hoboy.vegasvil.org/

=F0=9F=A4=B7=EF=B8=8F

> On RX I'm not sure how you'd know in advance if the packet is going to
> be routed to a socket that wants DMA or MAC timestamps. And having a
> socket with hardware timestamps from one provider in one direction, and
> another provider in the other direction, is.... not sane as a kernel API?

For DC NICs all the timestamps are based on the same PHC. The use case
is to get MAC/precise stamps for PTP and DMA/rough stamps for TCP CC.

Agreed that stamps from different PHCs in different directions would=20
be weird.

Thinking about it again we want the ability to configure the rx filter
per stamping point. MAC stamps PTP frames and DMA stamps all the rest.
For Tx we need to know whether app wanted DMA or MAC stamp (more
or less whether it's PTP again, without running a classifier on the
packet).
