Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB427585F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjGRUI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRUIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:08:24 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5C79D;
        Tue, 18 Jul 2023 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=vHDY6HY38evaUcgIwYMLfID7qjHOzGa9+X/2C1VlfUg=; b=47hKy9sUtWUOWpRN9TkFLue1Hg
        rhkA8PNF6qT40PAGwNLf/Q40VUYCepAUDRjcEBcdjPdghmVfYu3Udz4/ahwEEqcqUNtNZMZZaG+UW
        ilVmrs5R3mpzHOdCU3Oa90EuvhFnvSolYTaydGfDhbN9GAW/r/nRJ624FYs6XDUVjgHU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qLqz2-001ebh-O2; Tue, 18 Jul 2023 22:07:44 +0200
Date:   Tue, 18 Jul 2023 22:07:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 02/11] net: phy: introduce
 phy_has_c45_registers()
Message-ID: <7be8b305-f287-4e99-bddd-55646285c427@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-2-9eb37edf7be0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v3-2-9eb37edf7be0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 05:07:02PM +0200, Michael Walle wrote:
> Provide a helper to determine if the PHY has a C45 register space. This
> is a preparation patch to remove the is_c45 field. No functional change.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> v3:
>  - rename to phy_has_c45_registers()
> ---
>  drivers/net/ethernet/hisilicon/hns/hns_ethtool.c |  4 ++--
>  drivers/net/phy/bcm84881.c                       |  2 +-
>  drivers/net/phy/marvell10g.c                     |  2 +-
>  drivers/net/phy/mxl-gpy.c                        |  2 +-
>  drivers/net/phy/phy-core.c                       |  4 ++--
>  drivers/net/phy/phy.c                            |  8 +++++---
>  drivers/net/phy/phy_device.c                     |  6 +++---
>  drivers/net/phy/phylink.c                        | 12 +++++++-----
>  include/linux/phy.h                              |  5 +++++
>  9 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> index b54f3706fb97..387d24f195aa 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> @@ -916,7 +916,7 @@ static void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>  					hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
>  		ethtool_sprintf(&buff,
>  				hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
> -		if ((netdev->phydev) && (!netdev->phydev->is_c45))
> +		if (netdev->phydev && !phy_has_c45_registers(netdev->phydev))
>  			ethtool_sprintf(&buff,
>  					hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
>  
> @@ -976,7 +976,7 @@ static int hns_get_sset_count(struct net_device *netdev, int stringset)
>  		if (priv->ae_handle->phy_if == PHY_INTERFACE_MODE_XGMII)
>  			cnt--;
>  
> -		if ((!netdev->phydev) || (netdev->phydev->is_c45))
> +		if (!netdev->phydev || phy_has_c45_registers(netdev->phydev))
>  			cnt--;

These two look to be phy_has_c22_registers(). Probably. It calls
phy_loopback() and it seems to assume that only works for C22
registers, because of the genphy_loopback() call.

>  
>  		return cnt;
> diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
> index 9717a1626f3f..857344260230 100644
> --- a/drivers/net/phy/bcm84881.c
> +++ b/drivers/net/phy/bcm84881.c
> @@ -47,7 +47,7 @@ static int bcm84881_probe(struct phy_device *phydev)
>  	/* This driver requires PMAPMD and AN blocks */
>  	const u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
>  
> -	if (!phydev->is_c45 ||
> +	if (!phy_has_c45_registers(phydev) ||
>  	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
>  		return -ENODEV;

The comment indicates it. phy_has_c45_registers() is correct, and how
you access them does not matter.

> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index 55d9d7acc32e..d1c12843462f 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -499,7 +499,7 @@ static int mv3310_probe(struct phy_device *phydev)
>  	u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
>  	int ret;
>  
> -	if (!phydev->is_c45 ||
> +	if (!phy_has_c45_registers(phydev) ||
>  	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
>  		return -ENODEV;

Correct, we need the C45 registers. How we access them does not
matter.

> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index ea1073adc5a1..b4ddb9a003d9 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c
> @@ -281,7 +281,7 @@ static int gpy_probe(struct phy_device *phydev)
>  	int fw_version;
>  	int ret;
>  
> -	if (!phydev->is_c45) {
> +	if (!phy_has_c45_registers(phydev)) {
>  		ret = phy_get_c45_ids(phydev);
>  		if (ret < 0)
>  			return ret;

This is i think the oddball case which gits a patch of its own
later. This is about, did we discover the PHY via C22. If so, we need
to promote to C45. So i actually think this should be expressed
something like

	  if (phy_has_c22_registers(phydev) &&
	      !phy_has_c45_registers(phydev))

> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
> index a64186dc53f8..686a57d56885 100644
> --- a/drivers/net/phy/phy-core.c
> +++ b/drivers/net/phy/phy-core.c
> @@ -556,7 +556,7 @@ int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
>  
>  	if (phydev->drv && phydev->drv->read_mmd) {
>  		val = phydev->drv->read_mmd(phydev, devad, regnum);
> -	} else if (phydev->is_c45) {
> +	} else if (phy_has_c45_registers(phydev)) {

This i would say should be

phy_has_c45_transfers(phydev). This is about, can we do C45 transfers
on the bus, and if not, fall back to C45 over C22.

>  		val = __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
>  					 devad, regnum);
>  	} else {
> @@ -612,7 +612,7 @@ int __phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
>  
>  	if (phydev->drv && phydev->drv->write_mmd) {
>  		ret = phydev->drv->write_mmd(phydev, devad, regnum, val);
> -	} else if (phydev->is_c45) {
> +	} else if (phy_has_c45_registers(phydev)) {

same as above.

>  		ret = __mdiobus_c45_write(phydev->mdio.bus, phydev->mdio.addr,
>  					  devad, regnum, val);
>  	} else {
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index bdf00b2b2c1d..c6059ba8b9e6 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -182,7 +182,8 @@ int phy_restart_aneg(struct phy_device *phydev)
>  {
>  	int ret;
>  
> -	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
> +	if (phy_has_c45_registers(phydev) &&
> +	    !(phydev->c45_ids.devices_in_package & BIT(0)))
>  		ret = genphy_c45_restart_aneg(phydev);
>  	else
>  		ret = genphy_restart_aneg(phydev);

Correct.

> @@ -203,7 +204,7 @@ int phy_aneg_done(struct phy_device *phydev)
>  {
>  	if (phydev->drv && phydev->drv->aneg_done)
>  		return phydev->drv->aneg_done(phydev);
> -	else if (phydev->is_c45)
> +	else if (phy_has_c45_registers(phydev))
>  		return genphy_c45_aneg_done(phydev);
>  	else
>  		return genphy_aneg_done(phydev);

Correct.

> @@ -896,7 +897,8 @@ int phy_config_aneg(struct phy_device *phydev)
>  	/* Clause 45 PHYs that don't implement Clause 22 registers are not
>  	 * allowed to call genphy_config_aneg()
>  	 */
> -	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
> +	if (phy_has_c45_registers(phydev) &&
> +	    !(phydev->c45_ids.devices_in_package & BIT(0)))
>  		return genphy_c45_config_aneg(phydev);

Correct.

>  	return genphy_config_aneg(phydev);
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 226d5507c865..44968ea447fc 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -533,7 +533,7 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
>  	if (phydrv->match_phy_device)
>  		return phydrv->match_phy_device(phydev);
>  
> -	if (phydev->is_c45) {
> +	if (phy_has_c45_registers(phydev)) {
>  		for (i = 1; i < num_ids; i++) {
>  			if (phydev->c45_ids.device_ids[i] == 0xffffffff)
>  				continue;

Correct, do we have C45 ID registers, and does not matter how we got
them.

> @@ -1452,7 +1452,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  	 * exist, and we should use the genphy driver.
>  	 */
>  	if (!d->driver) {
> -		if (phydev->is_c45)
> +		if (phy_has_c45_registers(phydev))
>  			d->driver = &genphy_c45_driver.mdiodrv.driver;
>  		else
>  			d->driver = &genphy_driver.mdiodrv.driver;

Correct.

> @@ -3227,7 +3227,7 @@ static int phy_probe(struct device *dev)
>  	}
>  	else if (phydrv->get_features)
>  		err = phydrv->get_features(phydev);
> -	else if (phydev->is_c45)
> +	else if (phy_has_c45_registers(phydev))
>  		err = genphy_c45_pma_read_abilities(phydev);
>  	else
>  		err = genphy_read_abilities(phydev);

Correct.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index d0aaa5cad853..54fde8252079 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1726,7 +1726,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
>  	 * against all interface modes, which may lead to more ethtool link
>  	 * modes being advertised than are actually supported.
>  	 */
> -	if (phy->is_c45 && config.rate_matching == RATE_MATCH_NONE &&
> +	if (phy_has_c45_registers(phy) &&
> +	    config.rate_matching == RATE_MATCH_NONE &&
>  	    interface != PHY_INTERFACE_MODE_RXAUI &&
>  	    interface != PHY_INTERFACE_MODE_XAUI &&
>  	    interface != PHY_INTERFACE_MODE_USXGMII)

I would say correct. The comment above this is:

	/* Clause 45 PHYs may switch their Serdes lane between, e.g. 10GBASE-R,
	 * 5GBASE-R, 2500BASE-X and SGMII if they are not using rate matching.

I suppose a C22 PHY could as well, but none currently do, and actually
implementing anything faster than 1G without C45 is pretty difficult.

> @@ -2673,7 +2674,7 @@ static int phylink_phy_read(struct phylink *pl, unsigned int phy_id,
>  					reg);
>  	}
>  
> -	if (phydev->is_c45) {
> +	if (phy_has_c45_registers(phydev)) {
>  		switch (reg) {
>  		case MII_BMCR:
>  		case MII_BMSR:

This one is less clear. It ends up doing:

		return mdiobus_c45_read(pl->phydev->mdio.bus, prtad, devad,
					reg);

which is a C45 bus transaction. So i would actually say this should be
phy_has_c45_transfers(phydev). And maybe at some point in the future
this gets changed to use a higher level function which can do either
C45 or C45 over C22, and then the condition changed to
phy_has_c45_registers(phydev).

> @@ -2715,7 +2716,7 @@ static int phylink_phy_write(struct phylink *pl, unsigned int phy_id,
>  					 reg, val);
>  	}
>  
> -	if (phydev->is_c45) {
> +	if (phy_has_c45_registers(phydev)) {
>  		switch (reg) {
>  		case MII_BMCR:
>  		case MII_BMSR:

This is the same as the previous.

> @@ -3188,8 +3189,9 @@ static void phylink_sfp_link_up(void *upstream)
>   */
>  static bool phylink_phy_no_inband(struct phy_device *phy)
>  {
> -	return phy->is_c45 && phy_id_compare(phy->c45_ids.device_ids[1],
> -					     0xae025150, 0xfffffff0);
> +	return phy_has_c45_registers(phy) &&
> +	       phy_id_compare(phy->c45_ids.device_ids[1],
> +			      0xae025150, 0xfffffff0);
>  }

Correct, we are looking at a C45 ID.

>  static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 11c1e91563d4..fdb3774e99fc 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -766,6 +766,11 @@ static inline struct phy_device *to_phy_device(const struct device *dev)
>  	return container_of(to_mdio_device(dev), struct phy_device, mdio);
>  }
>  
> +static inline bool phy_has_c45_registers(struct phy_device *phydev)
> +{
> +	return phydev->is_c45;
> +}

And this is where it gets interesting. I think as a first step, you
should implement the four functions:

phy_has_c22_registers()
phy_has_c45_registers()
phy_has_c22_transfers()
phy_has_c45_transfers()

based on this. So there is initially no functional change.

You can then change the implementation of _transfers() based on what
the MDIO bus can do, plus the quirk for if a FUBAR microchip PHY has
been found.

Then change the implementation of _registers() based on the results of
probing for the ID registers.

That should give us a basis for a clean separation between register
spaces and bus transaction, and then adding C45 over C22 should be
more obviously correct.

	Andrew
