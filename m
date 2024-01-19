Return-Path: <linux-kernel+bounces-31261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9876832B59
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83492283714
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A825353E1E;
	Fri, 19 Jan 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fASc8a+3"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B9C53E25;
	Fri, 19 Jan 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674608; cv=none; b=GgAq7rf3J8yYNDQeWzVL3aYbdGjxlOWpmQ9XHUqkoGJ1cDgfuUw1lwywEZU8LmcKtaVY5BmDHR4sKDqwuiM3McMpBp0DPImDNUdeLIY8Hy4FTHAy+joQgnHh28r9NvgZXQ1YFH49eolLmU7LvNorEQ11US3p9iM4KPTLxxp3eoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674608; c=relaxed/simple;
	bh=bla26PPB/OlD6tPWxkqAhGJY9TUkLE14D0Fo40PLpHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/QhVbsqWwXHA2vM5NNS1FKChoJMBgtr4FGKScb3lbkn1ACfhUZYVOpN3jO8B/s98nXVD+vF9boKIAlkvMSJa0ubPlHNSCl/ukDptzHlWBDaJlKV8M5Ha4OjZnntvqW04rGZxLvqOVAprRYSK4ARr6Y4Apb1xY+WkfLoYffCFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fASc8a+3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Nh+dr8sER5lYrvOiCi2COP+Tbs+aMcxjg9bxrUnh0Uk=; b=fASc8a+3o1v9iAacv6soNk2gpC
	q0+iTjGYa0zXkJKu8dJz8WTfhS3I/Yn5RZOqCIz93HjowklUcYs/QnL1I5cwwwRfURZh3gRUc5TzN
	8BYXWjPiHafkJED8uk0RrNsw/IkMbeZDpAgHF/DCmr5r0GtU1yBcS5wc13ccx+raeST4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQpsV-005Z7m-Dy; Fri, 19 Jan 2024 15:29:51 +0100
Date: Fri, 19 Jan 2024 15:29:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [RFC PATCH v2 3/3] net: ti: icssg-prueth: Add support for ICSSG
 switch firmware
Message-ID: <f1ad5388-8a28-4b83-86d5-604d5ece84c0@lunn.ch>
References: <20240118071005.1514498-1-danishanwar@ti.com>
 <20240118071005.1514498-4-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118071005.1514498-4-danishanwar@ti.com>

On Thu, Jan 18, 2024 at 12:40:05PM +0530, MD Danish Anwar wrote:
> Add support for ICSSG switch firmware using existing Dual EMAC driver
> with switchdev.
> 
> Limitations:
> VLAN offloading is limited to 0-256 IDs.
> MDB/FDB static entries are limited to 511 entries and different FDBs can
> hash to same bucket and thus may not completely offloaded

What are the limits when using Dual EMAC driver? I'm just wondering if
we need to check that 257 VLANs have been offloaded, we cannot swap to
switch mode, keep with Dual EMAC?


> Switch mode requires loading of new firmware into ICSSG cores. This
> means interfaces have to taken down and then reconfigured to switch
> mode.

This is now out of date?

> 
> Example assuming ETH1 and ETH2 as ICSSG2 interfaces:
> 
> Switch to ICSSG Switch mode:
>  ip link set dev eth1 down
>  ip link set dev eth2 down
>  ip link add name br0 type bridge
>  ip link set dev eth1 master br0
>  ip link set dev eth2 master br0
>  ip link set dev br0 up
>  ip link set dev eth1 up
>  ip link set dev eth2 up
>  bridge vlan add dev br0 vid 1 pvid untagged self
> 
> Going back to Dual EMAC mode:
> 
>  ip link set dev br0 down
>  ip link set dev eth1 nomaster
>  ip link set dev eth2 nomaster
>  ip link set dev eth1 down
>  ip link set dev eth2 down
>  ip link del name br0 type bridge
>  ip link set dev eth1 up
>  ip link set dev eth2 up
> 
> By default, Dual EMAC firmware is loaded, and can be changed to switch
> mode by above steps
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/Kconfig               |   1 +
>  drivers/net/ethernet/ti/Makefile              |   3 +-
>  drivers/net/ethernet/ti/icssg/icssg_config.c  | 136 +++++++++++-
>  drivers/net/ethernet/ti/icssg/icssg_config.h  |   7 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 198 +++++++++++++++++-
>  .../net/ethernet/ti/icssg/icssg_switchdev.c   |   2 +-
>  6 files changed, 333 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index be01450c20dc..c72f26828b04 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -188,6 +188,7 @@ config TI_ICSSG_PRUETH
>  	select TI_ICSS_IEP
>  	select TI_K3_CPPI_DESC_POOL
>  	depends on PRU_REMOTEPROC
> +	depends on NET_SWITCHDEV
>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>  	help
>  	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index d8590304f3df..d295bded7a32 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -38,5 +38,6 @@ icssg-prueth-y := icssg/icssg_prueth.o \
>  		  icssg/icssg_config.o \
>  		  icssg/icssg_mii_cfg.o \
>  		  icssg/icssg_stats.o \
> -		  icssg/icssg_ethtool.o
> +		  icssg/icssg_ethtool.o \
> +		  icssg/icssg_switchdev.o
>  obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index afc10014ec03..eda08a87c902 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -105,28 +105,49 @@ static const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
>  	},
>  };
>  
> +static void icssg_config_mii_init_switch(struct prueth_emac *emac)

I'm surprised you need to configure the MII interface different in
switch mode. Please could you explain this a bit more.

> +{
> +	struct prueth *prueth = emac->prueth;
> +	int mii = prueth_emac_slice(emac);
> +	u32 txcfg_reg, pcnt_reg, txcfg;
> +	struct regmap *mii_rt;
> +
> +	mii_rt = prueth->mii_rt;
> +
> +	txcfg_reg = (mii == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
> +				       PRUSS_MII_RT_TXCFG1;
> +	pcnt_reg = (mii == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
> +				       PRUSS_MII_RT_RX_PCNT1;
> +
> +	txcfg = PRUSS_MII_RT_TXCFG_TX_ENABLE |
> +		PRUSS_MII_RT_TXCFG_TX_AUTO_PREAMBLE |
> +		PRUSS_MII_RT_TXCFG_TX_IPG_WIRE_CLK_EN;
> +
> +	if (emac->phy_if == PHY_INTERFACE_MODE_MII && mii == ICSS_MII1)
> +		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
> +	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && mii == ICSS_MII0)
> +		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
> +
> +	regmap_write(mii_rt, txcfg_reg, txcfg);
> +	regmap_write(mii_rt, pcnt_reg, 0x1);
> +}
> +
>  static void icssg_config_mii_init(struct prueth_emac *emac)
>  {
> -	u32 rxcfg, txcfg, rxcfg_reg, txcfg_reg, pcnt_reg;
>  	struct prueth *prueth = emac->prueth;
>  	int slice = prueth_emac_slice(emac);
> +	u32 txcfg, txcfg_reg, pcnt_reg;
>  	struct regmap *mii_rt;
>  
>  	mii_rt = prueth->mii_rt;
>  
> -	rxcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RXCFG0 :
> -				       PRUSS_MII_RT_RXCFG1;
>  	txcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
>  				       PRUSS_MII_RT_TXCFG1;
>  	pcnt_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
>  				       PRUSS_MII_RT_RX_PCNT1;
>  
> -	rxcfg = MII_RXCFG_DEFAULT;
>  	txcfg = MII_TXCFG_DEFAULT;
>  
> -	if (slice == ICSS_MII1)
> -		rxcfg |= PRUSS_MII_RT_RXCFG_RX_MUX_SEL;
> -
>  	/* In MII mode TX lines swapped inside ICSSG, so TX_MUX_SEL cfg need
>  	 * to be swapped also comparing to RGMII mode.
>  	 */
> @@ -135,7 +156,6 @@ static void icssg_config_mii_init(struct prueth_emac *emac)
>  	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && slice == ICSS_MII1)
>  		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
>  
> -	regmap_write(mii_rt, rxcfg_reg, rxcfg);
>  	regmap_write(mii_rt, txcfg_reg, txcfg);
>  	regmap_write(mii_rt, pcnt_reg, 0x1);
>  }
> @@ -249,6 +269,66 @@ static int emac_r30_is_done(struct prueth_emac *emac)
>  	return 1;
>  }
>  
> +static int prueth_switch_buffer_setup(struct prueth_emac *emac)
> +{
> +	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
> +	struct icssg_rxq_ctx __iomem *rxq_ctx;
> +	struct prueth *prueth = emac->prueth;
> +	int slice = prueth_emac_slice(emac);
> +	u32 addr;
> +	int i;
> +
> +	addr = lower_32_bits(prueth->msmcram.pa);
> +	if (slice)
> +		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
> +
> +	if (addr % SZ_64K) {
> +		dev_warn(prueth->dev, "buffer pool needs to be 64KB aligned\n");
> +		return -EINVAL;
> +	}

What happens if its not? Do we cleanly stay in Dual EMAC mode without
any loss of configuration? Or do bad things happen? Maybe this should
be checked at probe time, so you can deny the swap to switch mode
quickly and easily?

	Andrew

