Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74C7FE45E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjK2X4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2X4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:56:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924ABB2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:56:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14715C433C7;
        Wed, 29 Nov 2023 23:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701302175;
        bh=FK/XJ8k7CN61Y+SQ5dJKbLrahAUivCDGaeaXNYqZt2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AFXAyTX8Shnb4CIfE2Q9iYTgz1rK2nby7PMOiNBV/45sKOjLIx5NneSuAvTv6EkaL
         JOh/PJ8LwvfYrUf5Mj8Ec9+YNi9MK95wCaAGSuqurmuQGxxlRnuAInXET197tMJ0uk
         ZqrHS/KYCVXvBPx+czULvcNeJCQ97V3TmZq6Bc3OJLbGR0deix0gKlCXmkzYdrjZM+
         se383zhQwlecOmBxmULwQIUtVYRjWnmyRWhnEZ52T1ISWl9D1bjIE/aPHM5pI+yDdp
         McUSwJa6s1GuMB/px6+xtgoGV/NkZ97VpOsClujI26bdxBH0AvZCBibYeNYy1Vp3fm
         vF4+wHzwG3PTw==
Date:   Wed, 29 Nov 2023 15:56:13 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
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
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        rrameshbabu@nvidia.com
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231129155613.58c4b93b@kernel.org>
In-Reply-To: <20231129230034.7301d8b2@kmaincent-XPS-13-7390>
References: <20231120121440.3274d44c@kmaincent-XPS-13-7390>
        <20231120120601.ondrhbkqpnaozl2q@skbuf>
        <20231120144929.3375317e@kmaincent-XPS-13-7390>
        <20231120142316.d2emoaqeej2pg4s3@skbuf>
        <20231120093723.4d88fb2a@kernel.org>
        <157c68b0-687e-4333-9d59-fad3f5032345@lunn.ch>
        <20231120105148.064dc4bd@kernel.org>
        <20231120195858.wpaymolv6ws4hntp@skbuf>
        <20231120134551.30d0306c@kernel.org>
        <20231129210959.19e1e2b7@kmaincent-XPS-13-7390>
        <20231129203700.ckpkc4r5bwwudwpf@skbuf>
        <20231129230034.7301d8b2@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 23:00:34 +0100 K=C3=B6ry Maincent wrote:
> > Not sure why you say "not used", though. Are you not planning to expose
> > the qualifier as an attribute to the listing of hwtstamp providers
> > offered to user space by ETHTOOL_MSG_TSINFO_GET? =20
>=20
> Yes I will, I was just saying that all the PHC would be set as precise fo=
r now.
> Approximate timestamp quality won't be used because IIUC there are no NIC=
 driver
> supporting it yet.

Agreed that we should add the attr from the start.

Maybe we can ask/work with Rahul <rrameshbabu@nvidia.com>
to implement the right thing in mlx5?

Failing that we can mark mlx5 as imprecise, until its sorted out.
So that we have both types in the tree.
