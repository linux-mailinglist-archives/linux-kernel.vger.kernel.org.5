Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58E7C4D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbjJKI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJKI16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:27:58 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176129D;
        Wed, 11 Oct 2023 01:27:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1169360002;
        Wed, 11 Oct 2023 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697012875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tAl6wI267mdYSd5CG5718M4Naq5umv5wPjrfbzBjjTk=;
        b=IbJagmVNv9BmJV/Bk5syT4UgbLmG1Ihv1V1/9IA1g+O/kgec2Yzou3NA4q82G6/O0bPfqL
        xVQztLWHj8nR4DWyH5VNhPjzE2cU8IcXfgiOmsXDBuGCbaGWU7anPlCosMDsZ8Uxr5O8Kz
        H6Ni4o4uLsD7ufzPQPz0tCHET50qIAIvvCpP8J775sZw2K+cWpKcfiRq6ube9+1EGtYPy3
        gw69qKXhzHaYi8VdYp/0wlmtgnVeRDUPwSJeqSykjTdEgXXrYF25A4Tdc5gqPxUd2xuavv
        3l3qbN2cniCHyPCGa3CwzldrfbPV3MMAEDWC33vPl0BzqimYKM0nl8XCTPTwtA==
Date:   Wed, 11 Oct 2023 10:27:49 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 01/16] net: Convert PHYs hwtstamp callback
 to use kernel_hwtstamp_config
Message-ID: <20231011102749.6fb29adb@kmaincent-XPS-13-7390>
In-Reply-To: <ZSVvywM8OLG12OhR@kernel.org>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
        <20231009155138.86458-2-kory.maincent@bootlin.com>
        <ZSVvywM8OLG12OhR@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 17:37:47 +0200
Simon Horman <horms@kernel.org> wrote:

> ...
>=20
> > diff --git a/drivers/net/phy/nxp-c45-tja11xx.c
> > b/drivers/net/phy/nxp-c45-tja11xx.c index 7ab080ff02df..416484ea6eb3 10=
0644
> > --- a/drivers/net/phy/nxp-c45-tja11xx.c
> > +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> > @@ -1022,24 +1022,21 @@ static bool nxp_c45_rxtstamp(struct mii_timesta=
mper
> > *mii_ts, }
> > =20
> >  static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
> > -			    struct ifreq *ifreq)
> > +			    struct kernel_hwtstamp_config *config,
> > +			    struct netlink_ext_ack *extack)
> >  {
> >  	struct nxp_c45_phy *priv =3D container_of(mii_ts, struct nxp_c45_phy,
> >  						mii_ts);
> >  	struct phy_device *phydev =3D priv->phydev;
> >  	const struct nxp_c45_phy_data *data;
> > -	struct hwtstamp_config cfg;
> > =20
> > -	if (copy_from_user(&cfg, ifreq->ifr_data, sizeof(cfg)))
> > -		return -EFAULT;
> > -
> > -	if (cfg.tx_type < 0 || cfg.tx_type > HWTSTAMP_TX_ON)
> > +	if (cfg->tx_type < 0 || cfg->tx_type > HWTSTAMP_TX_ON) =20
>=20
> Hi K=C3=B6ry,
>=20
> cfg is removed from this function by this patch, but is used here.

Thanks for your review.
Indeed there is a mistake here. It will be fixed it next version.
