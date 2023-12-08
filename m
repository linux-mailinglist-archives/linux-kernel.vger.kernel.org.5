Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E74B809CA4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjLHG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjLHG6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:58:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226BC1724
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:58:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0810C433C7;
        Fri,  8 Dec 2023 06:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702018689;
        bh=GMos9O4HmmM+U55/J8+WlvlVh/uZHHlzuooomDAHT8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=poAC46PKgZhBiAFlrbze1CMXAMTKpwovQsFdJgOEkVmN7GQu2TDRfmUPf2AQwHWlH
         /ltyjzWd2/4XtT6kOALILrTKGzZDC1lfoxJsseDAKV1Kpd+wIFGr0A/kqzizofxPNH
         OF/O9+bD8mzuE9+tbQ5cgYrWesJYMKUdHiqesRvRssMTJaSkwkuaDb1Xtv3OEHTguz
         XlI2+YnDRUIAJ7hxsJqWtO6XzwItfBxmpl9x1qG65JaJcY3GOxr9Gu+5MEB8UzAKk/
         og1GQzvJy+IJm9LNkS68ooB6lwUJtl8WkbFO67PyeK6Ly9OhgssdWURyDZ35lE0bka
         LigbPHxmusB6g==
Date:   Fri, 8 Dec 2023 07:58:04 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Daniel Golle <daniel@makrotopia.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: extend speeds up to 10G
Message-ID: <20231208075804.4f8559e6@dellmb>
In-Reply-To: <cdcab57e-ef73-436d-8dac-f92219e4cbf9@lunn.ch>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
        <20231207172923.62ce530e@dellmb>
        <cdcab57e-ef73-436d-8dac-f92219e4cbf9@lunn.ch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 18:11:29 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Dec 07, 2023 at 05:29:23PM +0100, Marek Beh=C3=BAn wrote:
> > On Tue, 28 Nov 2023 04:00:10 +0000
> > Daniel Golle <daniel@makrotopia.org> wrote:
> >  =20
> > > Add 2.5G, 5G and 10G as available speeds to the netdev LED trigger.
> > >=20
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch> =20
> >=20
> > So what will happen when there are more speeds? Will we create a
> > separate file for each speed?
> >=20
> > Will we have a separate sysfs file for 10, 100, 1000, 2500, 5000,
> > 10000, 20000, 25000, 40000, 50000, 56000, 100000, 200000, 400000,
> > 800000 ?
> >=20
> > These are all speeds from include/uapi/linux/ethtool.h.
> >=20
> > Maybe we should have reused ethtool link mode bits, or something... =20
>=20
> That gets pretty ugly. The bits are not in any logical order, since
> they just get appended onto the end as needed.
>=20
> > Also, the files should only be present if the requested speed is
> > supported by the net device. So if 2500 mbps is not supported, there
> > should no be link_2500. =20
>=20
> Yes, this would be nice. We have the information in the phy_setting
> settings[] table in phy-core.c.

What if the netdev does not have a PHY? The MAC also has speed
information. Maybe create a function
  bool dev_supports_speed(netdev, speed)
?

Marek
