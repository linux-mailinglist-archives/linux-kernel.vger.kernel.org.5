Return-Path: <linux-kernel+bounces-137583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E8389E443
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D731C22791
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B30158213;
	Tue,  9 Apr 2024 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsSdKsHV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585E14D71C;
	Tue,  9 Apr 2024 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693756; cv=none; b=W1Y8xdOOeWJ0lYt/kaGf4NagD8dW8iKb7OK7dRlhJMSP21ROJMGXEg24z5GhpzC6ryqPttSOCYP9cyKiaQZrBTKbnUAqBI0xneL78NF3RCLMH0yJmxNDk803I94sIM58mAVL8APb6srOCDJ/E1nOX0IafF6ia1xb3kwmoiOCEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693756; c=relaxed/simple;
	bh=pElY3ArFidXdTKrCIRLECusVZjvdupFDmgFQSwWWLi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaYqs3PEUx8RxmGBQEzib3Tit2+YgqhEmhTGH3LC7mzgybv4Ls4XtemksGL3E37PwgDnFcthJ3tirNFDg//YAbo3kBt2HTI+xPTbNLQcAMZqRa5KWxXJlWRTOdd7U6gGbF7/PUtFrqs3CTLTfb5DKMxYDmGDeKnyzTCf/VLXZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsSdKsHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B4DC433F1;
	Tue,  9 Apr 2024 20:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712693756;
	bh=pElY3ArFidXdTKrCIRLECusVZjvdupFDmgFQSwWWLi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsSdKsHVgV9UBIWVfyzFZ5UI7gXRf3wU6rhiea9ubSvXMLMkajIoAyPIDOMkmxwfo
	 QGixdt4JPbNTlZ0yMrX8FiLQoUgnGIDdcD8U+CYVnKImtImHdlJJMH0BKl80jrzfku
	 18evIIuCZC8gT8oco/FMFhcNBWdOYBX8fvKekqdonHAZZoSG+1ieOgf4oDxG+RiBOp
	 9JmSgQ6B/XvGwSm17BXqe2epR/1Y0dxRODmZKDne8B9XNMUOASVeaf3KEoM8uQSEVb
	 tjOITUVH5GCKKxFz8tGYpgSINeZCD9ae5gaXHACoISv1nvX2eoNfY/zaAwUEuZMM5C
	 WmgfBb/jm4SXg==
Date: Tue, 9 Apr 2024 13:15:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20240409201553.GA4124869@dev-arch.thelio-3990X>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
 <20240404093004.2552221-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240404093004.2552221-2-maxime.chevallier@bootlin.com>

Hi Maxime,

On Thu, Apr 04, 2024 at 11:29:51AM +0200, Maxime Chevallier wrote:
> Link topologies containing multiple network PHYs attached to the same
> net_device can be found when using a PHY as a media converter for use
> with an SFP connector, on which an SFP transceiver containing a PHY can
> be used.
>=20
> With the current model, the transceiver's PHY can't be used for
> operations such as cable testing, timestamping, macsec offload, etc.
>=20
> The reason being that most of the logic for these configuration, coming
> from either ethtool netlink or ioctls tend to use netdev->phydev, which
> in multi-phy systems will reference the PHY closest to the MAC.
>=20
> Introduce a numbering scheme allowing to enumerate PHY devices that
> belong to any netdev, which can in turn allow userspace to take more
> precise decisions with regard to each PHY's configuration.
>=20
> The numbering is maintained per-netdev, in a phy_device_list.
> The numbering works similarly to a netdevice's ifindex, with
> identifiers that are only recycled once INT_MAX has been reached.
>=20
> This prevents races that could occur between PHY listing and SFP
> transceiver removal/insertion.
>=20
> The identifiers are assigned at phy_attach time, as the numbering
> depends on the netdevice the phy is attached to. The PHY index can be
> re-used for PHYs that are persistent.
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V11: - No changes
> V10: - No changes
> V9: - No changes
> V8: - Rebase on net-next and fixed conflicts
> V7: - Protected the phy_link_topo helpers/stubs with IS_REACHABLE
> V6: - Made link_topo a pointer
>     - Reworked the init/cleanup sequence
>     - Added phy_index recycling if possible
> V5: - Dropped the ASSERT_RTNL()
>     - Made the phy_link_topo_get_phy inline
> V4: - Moved the phy_link_topo_init() code to an inline header function
>     - Made the code build without phylib
> V3: - Renamed to phy_link_topology
>     - Added assertions for RTNL
>     - Various cleanups of leftover, unused test code
>     - Made the PHY index u32
>=20
>  MAINTAINERS                            |   2 +
>  drivers/net/phy/Makefile               |   2 +-
>  drivers/net/phy/phy_device.c           |   7 ++
>  drivers/net/phy/phy_link_topology.c    | 105 +++++++++++++++++++++++++
>  include/linux/netdevice.h              |   4 +-
>  include/linux/phy.h                    |   4 +
>  include/linux/phy_link_topology.h      |  72 +++++++++++++++++
>  include/linux/phy_link_topology_core.h |  25 ++++++
>  include/uapi/linux/ethtool.h           |  16 ++++
>  net/core/dev.c                         |   9 +++
>  10 files changed, 244 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/phy/phy_link_topology.c
>  create mode 100644 include/linux/phy_link_topology.h
>  create mode 100644 include/linux/phy_link_topology_core.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 909c2c531d8e..db0aa3a926ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8016,6 +8016,8 @@ F:	include/linux/mii.h
>  F:	include/linux/of_net.h
>  F:	include/linux/phy.h
>  F:	include/linux/phy_fixed.h
> +F:	include/linux/phy_link_topology.h
> +F:	include/linux/phy_link_topology_core.h
>  F:	include/linux/phylib_stubs.h
>  F:	include/linux/platform_data/mdio-bcm-unimac.h
>  F:	include/linux/platform_data/mdio-gpio.h
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 202ed7f450da..1d8be374915f 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for Linux PHY drivers
> =20
>  libphy-y			:=3D phy.o phy-c45.o phy-core.o phy_device.o \
> -				   linkmode.o
> +				   linkmode.o phy_link_topology.o
>  mdio-bus-y			+=3D mdio_bus.o mdio_device.o
> =20
>  ifdef CONFIG_MDIO_DEVICE
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 6c6ec9475709..452fc8b3406d 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -29,6 +29,7 @@
>  #include <linux/phy.h>
>  #include <linux/phylib_stubs.h>
>  #include <linux/phy_led_triggers.h>
> +#include <linux/phy_link_topology.h>
>  #include <linux/pse-pd/pse.h>
>  #include <linux/property.h>
>  #include <linux/rtnetlink.h>
> @@ -1511,6 +1512,11 @@ int phy_attach_direct(struct net_device *dev, stru=
ct phy_device *phydev,
> =20
>  		if (phydev->sfp_bus_attached)
>  			dev->sfp_bus =3D phydev->sfp_bus;
> +
> +		err =3D phy_link_topo_add_phy(dev->link_topo, phydev,
> +					    PHY_UPSTREAM_MAC, dev);
> +		if (err)
> +			goto error;
>  	}
> =20
>  	/* Some Ethernet drivers try to connect to a PHY device before
> @@ -1938,6 +1944,7 @@ void phy_detach(struct phy_device *phydev)
>  	if (dev) {
>  		phydev->attached_dev->phydev =3D NULL;
>  		phydev->attached_dev =3D NULL;
> +		phy_link_topo_del_phy(dev->link_topo, phydev);
>  	}
>  	phydev->phylink =3D NULL;
> =20
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_li=
nk_topology.c
> new file mode 100644
> index 000000000000..985941c5c558
> --- /dev/null
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Infrastructure to handle all PHY devices connected to a given netdev,
> + * either directly or indirectly attached.
> + *
> + * Copyright (c) 2023 Maxime Chevallier<maxime.chevallier@bootlin.com>
> + */
> +
> +#include <linux/phy_link_topology.h>
> +#include <linux/netdevice.h>
> +#include <linux/phy.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/xarray.h>
> +
> +struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
> +{
> +	struct phy_link_topology *topo;
> +
> +	topo =3D kzalloc(sizeof(*topo), GFP_KERNEL);
> +	if (!topo)
> +		return ERR_PTR(-ENOMEM);
> +
> +	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
> +	topo->next_phy_index =3D 1;
> +
> +	return topo;
> +}
> +
> +void phy_link_topo_destroy(struct phy_link_topology *topo)
> +{
> +	if (!topo)
> +		return;
> +
> +	xa_destroy(&topo->phys);
> +	kfree(topo);
> +}
> +
> +int phy_link_topo_add_phy(struct phy_link_topology *topo,
> +			  struct phy_device *phy,
> +			  enum phy_upstream upt, void *upstream)
> +{
> +	struct phy_device_node *pdn;
> +	int ret;
> +
> +	pdn =3D kzalloc(sizeof(*pdn), GFP_KERNEL);
> +	if (!pdn)
> +		return -ENOMEM;
> +
> +	pdn->phy =3D phy;
> +	switch (upt) {
> +	case PHY_UPSTREAM_MAC:
> +		pdn->upstream.netdev =3D (struct net_device *)upstream;
> +		if (phy_on_sfp(phy))
> +			pdn->parent_sfp_bus =3D pdn->upstream.netdev->sfp_bus;
> +		break;
> +	case PHY_UPSTREAM_PHY:
> +		pdn->upstream.phydev =3D (struct phy_device *)upstream;
> +		if (phy_on_sfp(phy))
> +			pdn->parent_sfp_bus =3D pdn->upstream.phydev->sfp_bus;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +	pdn->upstream_type =3D upt;
> +
> +	/* Attempt to re-use a previously allocated phy_index */
> +	if (phy->phyindex) {
> +		ret =3D xa_insert(&topo->phys, phy->phyindex, pdn, GFP_KERNEL);
> +
> +		/* Errors could be either -ENOMEM or -EBUSY. If the phy has an
> +		 * index, and there's another entry at the same index, this is
> +		 * unexpected and we still error-out
> +		 */
> +		if (ret)
> +			goto err;
> +		return 0;
> +	}
> +
> +	ret =3D xa_alloc_cyclic(&topo->phys, &phy->phyindex, pdn, xa_limit_32b,
> +			      &topo->next_phy_index, GFP_KERNEL);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	kfree(pdn);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
> +
> +void phy_link_topo_del_phy(struct phy_link_topology *topo,
> +			   struct phy_device *phy)
> +{
> +	struct phy_device_node *pdn =3D xa_erase(&topo->phys, phy->phyindex);
> +
> +	/* We delete the PHY from the topology, however we don't re-set the
> +	 * phy->phyindex field. If the PHY isn't gone, we can re-assign it the
> +	 * same index next time it's added back to the topology
> +	 */
> +
> +	kfree(pdn);
> +}
> +EXPORT_SYMBOL_GPL(phy_link_topo_del_phy);
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0c198620ac93..d45f330d083d 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -40,7 +40,6 @@
>  #include <net/dcbnl.h>
>  #endif
>  #include <net/netprio_cgroup.h>
> -
>  #include <linux/netdev_features.h>
>  #include <linux/neighbour.h>
>  #include <uapi/linux/netdevice.h>
> @@ -52,6 +51,7 @@
>  #include <net/net_trackers.h>
>  #include <net/net_debug.h>
>  #include <net/dropreason-core.h>
> +#include <linux/phy_link_topology_core.h>
> =20
>  struct netpoll_info;
>  struct device;
> @@ -1974,6 +1974,7 @@ enum netdev_reg_state {
>   *	@fcoe_ddp_xid:	Max exchange id for FCoE LRO by ddp
>   *
>   *	@priomap:	XXX: need comments on this one
> + *	@link_topo:	Physical link topology tracking attached PHYs
>   *	@phydev:	Physical device may attach itself
>   *			for hardware timestamping
>   *	@sfp_bus:	attached &struct sfp_bus structure.
> @@ -2364,6 +2365,7 @@ struct net_device {
>  #if IS_ENABLED(CONFIG_CGROUP_NET_PRIO)
>  	struct netprio_map __rcu *priomap;
>  #endif
> +	struct phy_link_topology	*link_topo;
>  	struct phy_device	*phydev;
>  	struct sfp_bus		*sfp_bus;
>  	struct lock_class_key	*qdisc_tx_busylock;
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index e6e83304558e..8c848c79b1fd 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -550,6 +550,9 @@ struct macsec_ops;
>   * @drv: Pointer to the driver for this PHY instance
>   * @devlink: Create a link between phy dev and mac dev, if the external =
phy
>   *           used by current mac interface is managed by another mac int=
erface.
> + * @phyindex: Unique id across the phy's parent tree of phys to address =
the PHY
> + *	      from userspace, similar to ifindex. A zero index means the PHY
> + *	      wasn't assigned an id yet.
>   * @phy_id: UID for this device found during discovery
>   * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
>   * @is_c45:  Set to true if this PHY uses clause 45 addressing.
> @@ -650,6 +653,7 @@ struct phy_device {
> =20
>  	struct device_link *devlink;
> =20
> +	u32 phyindex;
>  	u32 phy_id;
> =20
>  	struct phy_c45_device_ids c45_ids;
> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_t=
opology.h
> new file mode 100644
> index 000000000000..6b79feb607e7
> --- /dev/null
> +++ b/include/linux/phy_link_topology.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PHY device list allow maintaining a list of PHY devices that are
> + * part of a netdevice's link topology. PHYs can for example be chained,
> + * as is the case when using a PHY that exposes an SFP module, on which =
an
> + * SFP transceiver that embeds a PHY is connected.
> + *
> + * This list can then be used by userspace to leverage individual PHY
> + * capabilities.
> + */
> +#ifndef __PHY_LINK_TOPOLOGY_H
> +#define __PHY_LINK_TOPOLOGY_H
> +
> +#include <linux/ethtool.h>
> +#include <linux/phy_link_topology_core.h>
> +
> +struct xarray;
> +struct phy_device;
> +struct net_device;
> +struct sfp_bus;
> +
> +struct phy_device_node {
> +	enum phy_upstream upstream_type;
> +
> +	union {
> +		struct net_device	*netdev;
> +		struct phy_device	*phydev;
> +	} upstream;
> +
> +	struct sfp_bus *parent_sfp_bus;
> +
> +	struct phy_device *phy;
> +};
> +
> +struct phy_link_topology {
> +	struct xarray phys;
> +	u32 next_phy_index;
> +};
> +
> +static inline struct phy_device *
> +phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
> +{
> +	struct phy_device_node *pdn =3D xa_load(&topo->phys, phyindex);
> +
> +	if (pdn)
> +		return pdn->phy;
> +
> +	return NULL;
> +}
> +
> +#if IS_REACHABLE(CONFIG_PHYLIB)
> +int phy_link_topo_add_phy(struct phy_link_topology *topo,
> +			  struct phy_device *phy,
> +			  enum phy_upstream upt, void *upstream);
> +
> +void phy_link_topo_del_phy(struct phy_link_topology *lt, struct phy_devi=
ce *phy);
> +
> +#else
> +static inline int phy_link_topo_add_phy(struct phy_link_topology *topo,
> +					struct phy_device *phy,
> +					enum phy_upstream upt, void *upstream)
> +{
> +	return 0;
> +}
> +
> +static inline void phy_link_topo_del_phy(struct phy_link_topology *topo,
> +					 struct phy_device *phy)
> +{
> +}
> +#endif
> +
> +#endif /* __PHY_LINK_TOPOLOGY_H */
> diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_l=
ink_topology_core.h
> new file mode 100644
> index 000000000000..0a6479055745
> --- /dev/null
> +++ b/include/linux/phy_link_topology_core.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PHY_LINK_TOPOLOGY_CORE_H
> +#define __PHY_LINK_TOPOLOGY_CORE_H
> +
> +struct phy_link_topology;
> +
> +#if IS_REACHABLE(CONFIG_PHYLIB)
> +
> +struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
> +void phy_link_topo_destroy(struct phy_link_topology *topo);
> +
> +#else
> +
> +static inline struct phy_link_topology *phy_link_topo_create(struct net_=
device *dev)
> +{
> +	return NULL;
> +}
> +
> +static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
> +{
> +}
> +
> +#endif
> +
> +#endif /* __PHY_LINK_TOPOLOGY_CORE_H */
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 11fc18988bc2..95c2f09f0d0a 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2268,4 +2268,20 @@ struct ethtool_link_settings {
>  	 * __u32 map_lp_advertising[link_mode_masks_nwords];
>  	 */
>  };
> +
> +/**
> + * enum phy_upstream - Represents the upstream component a given PHY dev=
ice
> + * is connected to, as in what is on the other end of the MII bus. Most =
PHYs
> + * will be attached to an Ethernet MAC controller, but in some cases, th=
ere's
> + * an intermediate PHY used as a media-converter, which will driver anot=
her
> + * MII interface as its output.
> + * @PHY_UPSTREAM_MAC: Upstream component is a MAC (a switch port,
> + *		      or ethernet controller)
> + * @PHY_UPSTREAM_PHY: Upstream component is a PHY (likely a media conver=
ter)
> + */
> +enum phy_upstream {
> +	PHY_UPSTREAM_MAC,
> +	PHY_UPSTREAM_PHY,
> +};
> +
>  #endif /* _UAPI_LINUX_ETHTOOL_H */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9b821d96eff3..928cf377e843 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -158,6 +158,7 @@
>  #include <net/page_pool/types.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/rps.h>
> +#include <linux/phy_link_topology_core.h>
> =20
>  #include "dev.h"
>  #include "net-sysfs.h"
> @@ -10962,6 +10963,12 @@ struct net_device *alloc_netdev_mqs(int sizeof_p=
riv, const char *name,
>  #ifdef CONFIG_NET_SCHED
>  	hash_init(dev->qdisc_hash);
>  #endif
> +	dev->link_topo =3D phy_link_topo_create(dev);
> +	if (IS_ERR(dev->link_topo)) {
> +		dev->link_topo =3D NULL;
> +		goto free_all;
> +	}
> +
>  	dev->priv_flags =3D IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
>  	setup(dev);
> =20
> @@ -11050,6 +11057,8 @@ void free_netdev(struct net_device *dev)
>  	free_percpu(dev->xdp_bulkq);
>  	dev->xdp_bulkq =3D NULL;
> =20
> +	phy_link_topo_destroy(dev->link_topo);
> +
>  	/*  Compatibility with error handling in drivers */
>  	if (dev->reg_state =3D=3D NETREG_UNINITIALIZED) {
>  		netdev_freemem(dev);
> --=20
> 2.44.0
>=20

I bisected a crash that I see on one of my test devices to this change
in -next as commit 6916e461e793 ("net: phy: Introduce ethernet link
topology representation"). Here is the stack trace passed through
scripts/decode_stacktrace.sh:

[    0.000000] Linux version 6.9.0-rc2-debug-00664-g6916e461e793 (nathan@de=
v-arch.thelio-3990X) (x86_64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) =
2.41) #1 SMP PREEMPT_DYNAMIC Tue Apr  9 12:13:50 MST 2024
=2E..
[    5.616112] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[    5.616148] #PF: supervisor write access in kernel mode
[    5.616168] #PF: error_code(0x0002) - not-present page
[    5.616185] PGD 0 P4D 0
[    5.616199] Oops: 0002 [#1] PREEMPT SMP PTI
[    5.616216] CPU: 1 PID: 263 Comm: (udev-worker) Not tainted 6.9.0-rc2-de=
bug-00664-g6916e461e793 #1 70fb9ac6019045b1a6f31076c518c9320a4bc47a
[    5.616255] Hardware name: ASUSTeK COMPUTER INC. Q302LA/Q302LA, BIOS Q30=
2LA.203 05/15/2014
[    5.616279] RIP: 0010:_raw_spin_lock (arch/x86/include/asm/atomic.h:115 =
(discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discrim=
inator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4)=
 include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlo=
ck.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:134 (discrimina=
tor 4) kernel/locking/spinlock.c:154 (discriminator 4))=20
[ 5.616301] Code: 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 =
f3 0f 1e fa 0f 1f 44 00 00 65 ff 05 e8 51 30 4c 31 c0 ba 01 00 00 00 <f0> 0=
f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 97 01 00 00 90 c3 cc cc
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	00 66 90             	add    %ah,-0x70(%rsi)
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	f3 0f 1e fa          	endbr64
  17:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1c:	65 ff 05 e8 51 30 4c 	incl   %gs:0x4c3051e8(%rip)        # 0x4c30520b
  23:	31 c0                	xor    %eax,%eax
  25:	ba 01 00 00 00       	mov    $0x1,%edx
  2a:*	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)		<-- trapping instruc=
tion
  2e:	75 05                	jne    0x35
  30:	c3                   	ret
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	89 c6                	mov    %eax,%esi
  37:	e8 97 01 00 00       	call   0x1d3
  3c:	90                   	nop
  3d:	c3                   	ret
  3e:	cc                   	int3
  3f:	cc                   	int3

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
   4:	75 05                	jne    0xb
   6:	c3                   	ret
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	89 c6                	mov    %eax,%esi
   d:	e8 97 01 00 00       	call   0x1a9
  12:	90                   	nop
  13:	c3                   	ret
  14:	cc                   	int3
  15:	cc                   	int3
[    5.616355] RSP: 0000:ffffc3aec04bba38 EFLAGS: 00010246
[    5.617083] RAX: 0000000000000000 RBX: ffffa032d3db1c40 RCX: 00000000000=
00000
[    5.617785] RDX: 0000000000000001 RSI: ffffffffc10385e3 RDI: 00000000000=
00000
[    5.618502] RBP: ffffa032cdb2f800 R08: 0000000000000020 R09: 00000000000=
00000
[    5.619224] R10: ffffc3aec04bba40 R11: 0000000000000001 R12: 00000000000=
00000
[    5.619970] R13: 0000000000000000 R14: ffffa032c5ea3000 R15: ffffa032c11=
f80a8
[    5.620722] FS:  00007f67d520b540(0000) GS:ffffa033d6e80000(0000) knlGS:=
0000000000000000
[    5.621393] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.622152] CR2: 0000000000000000 CR3: 0000000103eaa004 CR4: 00000000001=
706f0
[    5.622942] Call Trace:
[    5.623653]  <TASK>
[    5.624329] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dum=
pstack.c:434)=20
[    5.625025] ? page_fault_oops (arch/x86/mm/fault.c:713 (discriminator 1)=
)=20
[    5.625791] ? exc_page_fault (arch/x86/include/asm/paravirt.h:693 arch/x=
86/mm/fault.c:1513 arch/x86/mm/fault.c:1563)=20
[    5.626525] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)=
=20
[    5.626535] ? phy_link_topo_add_phy (drivers/net/phy/phy_link_topology.c=
:46) libphy
[    5.627954] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:115 (discrim=
inator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4=
) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include=
/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187=
 (discriminator 4) include/linux/spinlock_api_smp.h:134 (discriminator 4) k=
ernel/locking/spinlock.c:154 (discriminator 4))=20
[    5.627963] phy_link_topo_add_phy (include/linux/xarray.h:977 drivers/ne=
t/phy/phy_link_topology.c:80) libphy
[    5.629462] phy_attach_direct (drivers/net/phy/phy_device.c:1516) libphy
[    5.629504] phylink_connect_phy (drivers/net/phy/phylink.c:1983) phylink
[    5.631030] ax88772_bind (drivers/net/usb/asix_devices.c:710 drivers/net=
/usb/asix_devices.c:919) asix
[    5.631049] usbnet_probe (drivers/net/usb/usbnet.c:1745) usbnet
[    5.631062] ? __pfx_read_tsc (arch/x86/kernel/tsc.c:1129)=20
[    5.631068] ? ktime_get_mono_fast_ns (kernel/time/timekeeping.c:438 kern=
el/time/timekeeping.c:452 kernel/time/timekeeping.c:492)=20
[    5.631075] usb_probe_interface (drivers/usb/core/driver.c:400)=20
[    5.631082] really_probe (drivers/base/dd.c:578 drivers/base/dd.c:656)=
=20
[    5.631087] ? __pfx___driver_attach (drivers/base/dd.c:1155)=20
[    5.631091] __driver_probe_device (drivers/base/dd.c:798)=20
[    5.631094] driver_probe_device (drivers/base/dd.c:828)=20
[    5.631098] __driver_attach (drivers/base/dd.c:1215)=20
[    5.631102] bus_for_each_dev (drivers/base/bus.c:368)=20
[    5.631108] bus_add_driver (drivers/base/bus.c:673)=20
[    5.631112] driver_register (drivers/base/driver.c:246)=20
[    5.631117] usb_register_driver (drivers/usb/core/driver.c:1068)=20
[    5.631120] ? __pfx_asix_driver_init (drivers/net/usb/asix_devices.c:745=
) asix
[    5.631134] do_one_initcall (init/main.c:1238)=20
[    5.631141] do_init_module (kernel/module/main.c:2538)=20
[    5.631147] init_module_from_file (kernel/module/main.c:3169)=20
[    5.631153] idempotent_init_module (include/linux/spinlock.h:351 kernel/=
module/main.c:3131 kernel/module/main.c:3185)=20
[    5.631158] __x64_sys_finit_module (include/linux/file.h:47 kernel/modul=
e/main.c:3207 kernel/module/main.c:3189 kernel/module/main.c:3189)=20
[    5.631163] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) =
arch/x86/entry/common.c:83 (discriminator 1))=20
[    5.631168] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:173 arch/=
x86/entry/common.c:98)=20
[    5.631171] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:173 arch/=
x86/entry/common.c:98)=20
[    5.631174] ? exc_page_fault (arch/x86/include/asm/paravirt.h:693 arch/x=
86/mm/fault.c:1513 arch/x86/mm/fault.c:1563)=20
[    5.631179] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:12=
9)=20
[    5.631187] RIP: 0033:0x7f67d4d2488d
[ 5.631217] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 =
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01 f0 ff ff 73 01 c3 48 8b 0d 73 14 0d 00 f7 d8 64 89 01 48
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	ff c3                	inc    %ebx
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00=20
   c:	90                   	nop
   d:	f3 0f 1e fa          	endbr64
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping =
instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 73 14 0d 00 	mov    0xd1473(%rip),%rcx        # 0xd14ad
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 73 14 0d 00 	mov    0xd1473(%rip),%rcx        # 0xd1483
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[    5.631219] RSP: 002b:00007fff5a3fea18 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[    5.631223] RAX: ffffffffffffffda RBX: 000055883cfb16b0 RCX: 00007f67d4d=
2488d
[    5.631226] RDX: 0000000000000004 RSI: 00007f67d52ea376 RDI: 00000000000=
00019
[    5.631229] RBP: 00007f67d52ea376 R08: 0000000000000001 R09: fffffffffff=
ffe88
[    5.631231] R10: 0000000000000050 R11: 0000000000000246 R12: 00000000000=
20000
[    5.631233] R13: 000055883cfaf050 R14: 0000000000000000 R15: 000055883cf=
b6ea0
[    5.631238]  </TASK>
[    5.631239] Modules linked in: sha512_ssse3 uvcvideo btusb(+) sha1_ssse3=
 ptp aesni_intel btrtl pps_core videobuf2_vmalloc ax88796b snd_hda_codec_hd=
mi asix(+) videobuf2_memops btintel mac80211 crypto_simd phylink cryptd uvc=
 btbcm videobuf2_v4l2 selftests spi_nor mtd btmtk rapl videodev asus_nb_wmi=
 libarc4 usbnet joydev vfat ak8975 iTCO_wdt asus_wmi mii iwlwifi videobuf2_=
common hid_multitouch intel_cstate at24 intel_pmc_bxt spi_intel_platform sn=
d_hda_codec_realtek sparse_keymap fat mousedev hid_generic mei_pxp iTCO_ven=
dor_support intel_rapl_msr spi_intel i915 mei_hdcp platform_profile libphy =
mc bluetooth intel_uncore snd_hda_codec_generic i2c_i801 snd_hda_scodec_com=
ponent psmouse crc16 cfg80211 pcspkr processor_thermal_device_pci_legacy sn=
d_hda_intel usbhid ecdh_generic i2c_smbus snd_intel_dspcfg intel_soc_dts_io=
sf processor_thermal_device lpc_ich rfkill i2c_algo_bit drm_buddy inv_mpu60=
50_i2c snd_hda_codec mei_me i2c_mux processor_thermal_wt_hint ttm snd_hwdep=
 processor_thermal_rfim mei processor_thermal_rapl intel_gtt
[    5.631322]  inv_mpu6050 video snd_hda_core drm_display_helper intel_rap=
l_common snd_pcm inv_sensors_timestamp snd_timer processor_thermal_wt_req d=
rm_kms_helper dell_smo8800 acpi_als int3400_thermal pinctrl_lynxpoint indus=
trialio_triggered_buffer processor_thermal_power_floor snd processor_therma=
l_mbox cec wmi kfifo_buf int340x_thermal_zone acpi_thermal_rel industrialio=
 soundcore soc_button_array asus_wireless mac_hid pkcs8_key_parser crypto_u=
ser drm fuse dm_mod loop nfnetlink zram ip_tables x_tables serio_raw atkbd =
libps2 vivaldi_fmap sha256_ssse3 xhci_pci xhci_pci_renesas i8042 serio btrf=
s blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq
[    5.631374] CR2: 0000000000000000
[    5.631377] ---[ end trace 0000000000000000 ]---

If there is any additional information I can provide or patches I can
test, I am more than happy to do so.

Cheers,
Nathan

# bad: [11cb68ad52ac78c81e33b806b531f097e68edfa2] Add linux-next specific f=
iles for 20240408
# good: [fec50db7033ea478773b159e0e2efb135270e3b7] Linux 6.9-rc3
git bisect start '11cb68ad52ac78c81e33b806b531f097e68edfa2' 'fec50db7033ea4=
78773b159e0e2efb135270e3b7'
# bad: [b5ae7d7ff5458d024c8d8be346e405dd53bfe573] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect bad b5ae7d7ff5458d024c8d8be346e405dd53bfe573
# good: [54f6c30962ec3738fa235457efe3a304f180e335] Merge branch 'renesas-cl=
k' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.g=
it
git bisect good 54f6c30962ec3738fa235457efe3a304f180e335
# bad: [267e31750ae89f845cfe7df8f577b19482d9ef9b] Merge branch 'phy-listing=
-link_topology-tracking'
git bisect bad 267e31750ae89f845cfe7df8f577b19482d9ef9b
# good: [992c287d87780abd184c67a303dec3361b7cb408] dt-bindings: net: snps,d=
wmac: Align 'snps,priority' type definition
git bisect good 992c287d87780abd184c67a303dec3361b7cb408
# good: [0ccf50df61f98a9f98d46524be4baa00c88c499d] Merge tag 'ath-next-2024=
0402' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
git bisect good 0ccf50df61f98a9f98d46524be4baa00c88c499d
# good: [0cd1453b7e55064d06b49eebe34ffb43748ba12e] mlxsw: pci: Remove mlxsw=
_pci_sdq_count()
git bisect good 0cd1453b7e55064d06b49eebe34ffb43748ba12e
# good: [da48a65f3ff4155364fb9e3efe0bfba58291da6b] bnxt_en: Fix PTP firmwar=
e timeout parameter
git bisect good da48a65f3ff4155364fb9e3efe0bfba58291da6b
# good: [ff8877b04ef282b2bdb16c9dccc2e42216a34f62] netlink: specs: ethtool:=
 define header-flags as an enum
git bisect good ff8877b04ef282b2bdb16c9dccc2e42216a34f62
# good: [9f06f87fef689d28588cde8c7ebb00a67da34026] net: skbuff: generalize =
the skb->decrypted bit
git bisect good 9f06f87fef689d28588cde8c7ebb00a67da34026
# bad: [0ec5ed6c130e3906ba4ec82d740444a21504fbbf] net: sfp: pass the phy_de=
vice when disconnecting an sfp module's PHY
git bisect bad 0ec5ed6c130e3906ba4ec82d740444a21504fbbf
# good: [d133ef1ee2a256ba5a589493cd28dccfede6af11] net: phy: marvell: imple=
ment cable test for 88E1111
git bisect good d133ef1ee2a256ba5a589493cd28dccfede6af11
# bad: [6916e461e7933d3d003441291c543938f2ccb371] net: phy: Introduce ether=
net link topology representation
git bisect bad 6916e461e7933d3d003441291c543938f2ccb371
# first bad commit: [6916e461e7933d3d003441291c543938f2ccb371] net: phy: In=
troduce ethernet link topology representation

