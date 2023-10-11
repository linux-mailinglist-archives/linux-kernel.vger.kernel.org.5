Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2517C5571
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346435AbjJKN3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjJKN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:29:53 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2898;
        Wed, 11 Oct 2023 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697030991; x=1728566991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uqCKkITqY7o9Wro6IUy56o74CCueKFTjVVMW7hwdn8M=;
  b=gM0exQiCRM0+SWeAjj71+yrKwAyd3uCiM6w95Ge2Wzm9uSRIGDxZl3Mw
   jt0ehsRoigfZmBKpZBADluVVt0FaQ+IOB4VH90qREUwk0xefEDNRHVPSW
   ON/h5XBodcngfHWZjRdgSKqFomw7zUFkaKkx259f1MXqEtO3W3y3l7HPI
   3QQaQ8iawmVYaKP6CPmXtaZJk2svqEELNfaNxXBLuYZ7yoWNnEB/wljNM
   OZ8YhxF+klJbEQQVSvHLi8a+vfU2MeuDP4rz9DzO95QGot3l/WzrKqTrg
   KOiRqyl/BNEUZJIg3QgQUVvAhY5QQblVunFMP/sXX/nzgS+zhIUe9zH+u
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,216,1694728800"; 
   d="scan'208";a="33407590"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Oct 2023 15:29:49 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0FA5C280082;
        Wed, 11 Oct 2023 15:29:49 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 3/3] net: phy: micrel: Fix forced link mode for KSZ886X switches
Date:   Wed, 11 Oct 2023 15:29:49 +0200
Message-ID: <3767760.kQq0lBPeGt@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231011123856.1443308-3-o.rempel@pengutronix.de>
References: <20231011123856.1443308-1-o.rempel@pengutronix.de> <20231011123856.1443308-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

Am Mittwoch, 11. Oktober 2023, 14:38:56 CEST schrieb Oleksij Rempel:
> Address a link speed detection issue in KSZ886X PHY driver when in
> forced link mode. Previously, link partners like "ASIX AX88772B"
> with KSZ8873 could fall back to 10Mbit instead of configured 100Mbit.
>=20
> The issue arises as KSZ886X PHY continues sending Fast Link Pulses (FLPs)
> even with autonegotiation off, misleading link partners in autoneg mode,
> leading to incorrect link speed detection.
>=20
> Now, when autonegotiation is disabled, the driver sets the link state
> forcefully using KSZ886X_CTRL_FORCE_LINK bit. This action, beyond just
> disabling autonegotiation, makes the PHY state more reliably detected by
> link partners using parallel detection, thus fixing the link speed
> misconfiguration.
>=20
> With autonegotiation enabled, link state is not forced, allowing proper
> autonegotiation process participation.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/micrel.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 927d3d54658e..12f093aed4ff 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1729,9 +1729,35 @@ static int ksz886x_config_aneg(struct phy_device
> *phydev) {
>  	int ret;
>=20
> -	ret =3D genphy_config_aneg(phydev);
> -	if (ret)
> -		return ret;
> +	if (phydev->autoneg !=3D AUTONEG_ENABLE) {
> +		ret =3D genphy_setup_forced(phydev);
> +		if (ret)
> +			return ret;
> +
> +		/* When autonegotation is disabled, we need to manually=20
force
> +		 * the link state. If we don't do this, the PHY will keep
> +		 * sending Fast Link Pulses (FLPs) which are part of the
> +		 * autonegotiation process. This is not desired when
> +		 * autonegotiation is off.
> +		 */
> +		ret =3D phy_set_bits(phydev, MII_KSZPHY_CTRL,
> +				   KSZ886X_CTRL_FORCE_LINK);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* Make sure, the link state is not forced.
> +		 * Otherwise, the PHY we create a link by skipping the

PHY will create?

> +		 * autonegotiation process.
> +		 */
> +		ret =3D phy_clear_bits(phydev, MII_KSZPHY_CTRL,
> +				     KSZ886X_CTRL_FORCE_LINK);
> +		if (ret)
> +			return ret;

Isn't this call to phy_clear_bits() a fix for autonegotiation mode? This=20
should be a separate patch then.

Best regards,
Alexander

> +
> +		ret =3D genphy_config_aneg(phydev);
> +		if (ret)
> +			return ret;
> +	}
>=20
>  	/* The MDI-X configuration is automatically changed by the PHY after
>  	 * switching from autoneg off to on. So, take MDI-X configuration=20
under


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



