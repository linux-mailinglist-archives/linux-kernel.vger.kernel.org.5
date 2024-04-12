Return-Path: <linux-kernel+bounces-143232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4EE8A360A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8141F22AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA314F9CF;
	Fri, 12 Apr 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QZ1Z/NMC"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32901373;
	Fri, 12 Apr 2024 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947996; cv=none; b=HktXYVRnXpmnrOZYC4QJ+FcsDxDPktdVa1dBISwgeCiiuTymYjLB7SyZSBmUAI4/PoIKlfrU89buyj5hYHKtQeK4cH4rZBpFDa9KqPKg2p35LBb2Esa8auhBx2eOOBjYFvaqCHC+1syggx+RjjYP4lF1Ylk6dHXMT1x9HcjV9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947996; c=relaxed/simple;
	bh=rXg6nyoABh1agJGbUuVsVRFpG6ePTJbGO3v5BBmZy/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tieQz00N+DdPN4Aq0hB9BUOjAf5ulGJar/3Xl6NXk+I4UvTDD4GT6bMiRliplwBq11rRjifkcJmX0Kx7y+7kG0y7LnTuf35zyiDBLMZFKX2BoKMlW2vj2EkEDcefqG0VFSfowv7MsWEC+2SK+x37yJrUug60MoYBE1wZ91ykvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QZ1Z/NMC; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43CIqftD024370;
	Fri, 12 Apr 2024 13:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712947961;
	bh=fkZrxZui6GejcFsraHF/1YZdntXULlwaQ+e3RTMRtys=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QZ1Z/NMCV3MnNz3ZdzN9dJNs0bHTz06dSpNp1SrXmXNj5tM7f0C79gJGKx/jui2Kv
	 o82OBfQ6UGuqIOgAL+jm+Lo2vgckSxIwUx0GnGoybvQumQnn/h7Hr9uyy5p2VUvPw8
	 yEWLiwCiXr5usmrHJQYFKbVw04SUoO0yUUl3Ehis=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43CIqfnl046972
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 13:52:41 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 13:52:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 13:52:40 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43CIqdDg041574;
	Fri, 12 Apr 2024 13:52:39 -0500
Message-ID: <cb13da4a-13c9-409a-a813-0ac852062163@ti.com>
Date: Fri, 12 Apr 2024 13:52:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware
To: MD Danish Anwar <danishanwar@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>,
        Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn
	<andrew@lunn.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Arnd
 Bergmann <arnd@arndb.de>, Vignesh Raghavendra <vigneshr@ti.com>,
        Vladimir
 Oltean <vladimir.oltean@nxp.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240327114054.1907278-1-danishanwar@ti.com>
 <20240327114054.1907278-4-danishanwar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240327114054.1907278-4-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/27/24 6:40 AM, MD Danish Anwar wrote:
> Add support for ICSSG switch firmware using existing Dual EMAC driver
> with switchdev.
> 
> Limitations:
> VLAN offloading is limited to 0-256 IDs.
> MDB/FDB static entries are limited to 511 entries and different FDBs can
> hash to same bucket and thus may not completely offloaded
> 
> Switch mode requires loading of new firmware into ICSSG cores. This
> means interfaces have to taken down and then reconfigured to switch
> mode.
> 
> Example assuming ETH1 and ETH2 as ICSSG2 interfaces:
> 
> Switch to ICSSG Switch mode:
>   ip link set dev eth1 down
>   ip link set dev eth2 down
>   ip link add name br0 type bridge
>   ip link set dev eth1 master br0
>   ip link set dev eth2 master br0
>   ip link set dev br0 up
>   ip link set dev eth1 up
>   ip link set dev eth2 up
>   bridge vlan add dev br0 vid 1 pvid untagged self
> 
> Going back to Dual EMAC mode:
> 
>   ip link set dev br0 down
>   ip link set dev eth1 nomaster
>   ip link set dev eth2 nomaster
>   ip link set dev eth1 down
>   ip link set dev eth2 down
>   ip link del name br0 type bridge
>   ip link set dev eth1 up
>   ip link set dev eth2 up
> 
> By default, Dual EMAC firmware is loaded, and can be changed to switch
> mode by above steps
> 

This was asked before, maybe I missed the answer, but why do we
default to Dual-EMAC firmware? I remember when I was working on
the original ICSS-ETH driver, we started with the Dual-EMAC
firmware as the switch firmware was not ready yet (and EMAC mode
was easier). Now that we have both available, if we just use Switch
firmwar by default, what would we lose? Seems that would solve
the issues with re-loading firmware at runtime (configuration loss
and dropping packets, etc..).

Andrew

> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>   drivers/net/ethernet/ti/Kconfig              |   1 +
>   drivers/net/ethernet/ti/Makefile             |   3 +-
>   drivers/net/ethernet/ti/icssg/icssg_config.c | 136 +++++++++++--
>   drivers/net/ethernet/ti/icssg/icssg_config.h |   7 +
>   drivers/net/ethernet/ti/icssg/icssg_prueth.c | 198 ++++++++++++++++++-
>   5 files changed, 332 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index 1530d13984d4..9b5f5f680b35 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -188,6 +188,7 @@ config TI_ICSSG_PRUETH
>   	select TI_ICSS_IEP
>   	select TI_K3_CPPI_DESC_POOL
>   	depends on PRU_REMOTEPROC
> +	depends on NET_SWITCHDEV
>   	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>   	depends on PTP_1588_CLOCK_OPTIONAL
>   	help
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index d8590304f3df..d295bded7a32 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -38,5 +38,6 @@ icssg-prueth-y := icssg/icssg_prueth.o \
>   		  icssg/icssg_config.o \
>   		  icssg/icssg_mii_cfg.o \
>   		  icssg/icssg_stats.o \
> -		  icssg/icssg_ethtool.o
> +		  icssg/icssg_ethtool.o \
> +		  icssg/icssg_switchdev.o
>   obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index 970e6ef9ba64..5b2064d1b03b 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -105,28 +105,49 @@ static const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
>   	},
>   };
>   
> +static void icssg_config_mii_init_switch(struct prueth_emac *emac)
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
>   static void icssg_config_mii_init(struct prueth_emac *emac)
>   {
> -	u32 rxcfg, txcfg, rxcfg_reg, txcfg_reg, pcnt_reg;
>   	struct prueth *prueth = emac->prueth;
>   	int slice = prueth_emac_slice(emac);
> +	u32 txcfg, txcfg_reg, pcnt_reg;
>   	struct regmap *mii_rt;
>   
>   	mii_rt = prueth->mii_rt;
>   
> -	rxcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RXCFG0 :
> -				       PRUSS_MII_RT_RXCFG1;
>   	txcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
>   				       PRUSS_MII_RT_TXCFG1;
>   	pcnt_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
>   				       PRUSS_MII_RT_RX_PCNT1;
>   
> -	rxcfg = MII_RXCFG_DEFAULT;
>   	txcfg = MII_TXCFG_DEFAULT;
>   
> -	if (slice == ICSS_MII1)
> -		rxcfg |= PRUSS_MII_RT_RXCFG_RX_MUX_SEL;
> -
>   	/* In MII mode TX lines swapped inside ICSSG, so TX_MUX_SEL cfg need
>   	 * to be swapped also comparing to RGMII mode.
>   	 */
> @@ -135,7 +156,6 @@ static void icssg_config_mii_init(struct prueth_emac *emac)
>   	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && slice == ICSS_MII1)
>   		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
>   
> -	regmap_write(mii_rt, rxcfg_reg, rxcfg);
>   	regmap_write(mii_rt, txcfg_reg, txcfg);
>   	regmap_write(mii_rt, pcnt_reg, 0x1);
>   }
> @@ -249,6 +269,66 @@ static int emac_r30_is_done(struct prueth_emac *emac)
>   	return 1;
>   }
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
> +
> +	bpool_cfg = emac->dram.va + BUFFER_POOL_0_ADDR_OFFSET;
> +	/* workaround for f/w bug. bpool 0 needs to be initilalized */
> +	for (i = 0; i <  PRUETH_NUM_BUF_POOLS; i++) {
> +		writel(addr, &bpool_cfg[i].addr);
> +		writel(PRUETH_EMAC_BUF_POOL_SIZE, &bpool_cfg[i].len);
> +		addr += PRUETH_EMAC_BUF_POOL_SIZE;
> +	}
> +
> +	if (!slice)
> +		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
> +	else
> +		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
> +
> +	for (i = PRUETH_NUM_BUF_POOLS;
> +	     i < 2 * PRUETH_SW_NUM_BUF_POOLS_HOST + PRUETH_NUM_BUF_POOLS;
> +	     i++) {
> +		/* The driver only uses first 4 queues per PRU so only initialize them */
> +		if (i % PRUETH_SW_NUM_BUF_POOLS_HOST < PRUETH_SW_NUM_BUF_POOLS_PER_PRU) {
> +			writel(addr, &bpool_cfg[i].addr);
> +			writel(PRUETH_SW_BUF_POOL_SIZE_HOST, &bpool_cfg[i].len);
> +			addr += PRUETH_SW_BUF_POOL_SIZE_HOST;
> +		} else {
> +			writel(0, &bpool_cfg[i].addr);
> +			writel(0, &bpool_cfg[i].len);
> +		}
> +	}
> +
> +	if (!slice)
> +		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
> +	else
> +		addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
> +
> +	rxq_ctx = emac->dram.va + HOST_RX_Q_PRE_CONTEXT_OFFSET;
> +	for (i = 0; i < 3; i++)
> +		writel(addr, &rxq_ctx->start[i]);
> +
> +	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
> +	writel(addr - SZ_2K, &rxq_ctx->end);
> +
> +	return 0;
> +}
> +
>   static int prueth_emac_buffer_setup(struct prueth_emac *emac)
>   {
>   	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
> @@ -325,13 +405,41 @@ static void icssg_init_emac_mode(struct prueth *prueth)
>   	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
>   }
>   
> +static void icssg_init_switch_mode(struct prueth *prueth)
> +{
> +	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
> +	int i;
> +
> +	if (prueth->emacs_initialized)
> +		return;
> +
> +	/* Set VLAN TABLE address base */
> +	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
> +			   addr <<  SMEM_VLAN_OFFSET);
> +	/* Set enable VLAN aware mode, and FDBs for all PRUs */
> +	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, FDB_EN_ALL);
> +	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)(prueth->shram.va +
> +			    EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET);
> +	for (i = 0; i < SZ_4K - 1; i++) {
> +		prueth->vlan_tbl[i].fid = i;
> +		prueth->vlan_tbl[i].fid_c1 = 0;
> +	}
> +
> +	if (prueth->hw_bridge_dev)
> +		icssg_class_set_host_mac_addr(prueth->miig_rt, prueth->hw_bridge_dev->dev_addr);
> +	icssg_set_pvid(prueth, prueth->default_vlan, PRUETH_PORT_HOST);
> +}
> +
>   int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>   {
>   	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
>   	struct icssg_flow_cfg __iomem *flow_cfg;
>   	int ret;
>   
> -	icssg_init_emac_mode(prueth);
> +	if (prueth->is_switch_mode)
> +		icssg_init_switch_mode(prueth);
> +	else
> +		icssg_init_emac_mode(prueth);
>   
>   	memset_io(config, 0, TAS_GATE_MASK_LIST0);
>   	icssg_miig_queues_init(prueth, slice);
> @@ -345,7 +453,10 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>   	regmap_update_bits(prueth->miig_rt, ICSSG_CFG_OFFSET,
>   			   ICSSG_CFG_DEFAULT, ICSSG_CFG_DEFAULT);
>   	icssg_miig_set_interface_mode(prueth->miig_rt, slice, emac->phy_if);
> -	icssg_config_mii_init(emac);
> +	if (prueth->is_switch_mode)
> +		icssg_config_mii_init_switch(emac);
> +	else
> +		icssg_config_mii_init(emac);
>   	icssg_config_ipg(emac);
>   	icssg_update_rgmii_cfg(prueth->miig_rt, emac);
>   
> @@ -368,7 +479,10 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>   	writeb(0, config + SPL_PKT_DEFAULT_PRIORITY);
>   	writeb(0, config + QUEUE_NUM_UNTAGGED);
>   
> -	ret = prueth_emac_buffer_setup(emac);
> +	if (prueth->is_switch_mode)
> +		ret = prueth_switch_buffer_setup(emac);
> +	else
> +		ret = prueth_emac_buffer_setup(emac);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
> index 0d5d5d253b7a..cc923f1d4387 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
> @@ -35,6 +35,13 @@ struct icssg_flow_cfg {
>   	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
>   	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
>   
> +#define PRUETH_SW_BUF_POOL_SIZE_HOST	SZ_4K
> +#define PRUETH_SW_NUM_BUF_POOLS_HOST	8
> +#define PRUETH_SW_NUM_BUF_POOLS_PER_PRU 4
> +#define MSMC_RAM_SIZE_SWITCH_MODE \
> +	(MSMC_RAM_SIZE + \
> +	(2 * PRUETH_SW_BUF_POOL_SIZE_HOST * PRUETH_SW_NUM_BUF_POOLS_HOST))
> +
>   #define PRUETH_SWITCH_FDB_MASK ((SIZE_OF_FDB / NUMBER_OF_FDB_BUCKET_ENTRIES) - 1)
>   
>   struct icssg_rxq_ctx {
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 9168ab3c4b9e..725b5de05e00 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -27,6 +27,7 @@
>   #include <linux/remoteproc/pruss.h>
>   #include <linux/regmap.h>
>   #include <linux/remoteproc.h>
> +#include <net/switchdev.h>
>   
>   #include "icssg_prueth.h"
>   #include "icssg_mii_rt.h"
> @@ -54,6 +55,10 @@
>   
>   #define prueth_napi_to_emac(napi) container_of(napi, struct prueth_emac, napi_rx)
>   
> +#define DEFAULT_VID		1
> +#define DEFAULT_PORT_MASK	1
> +#define DEFAULT_UNTAG_MASK	1
> +
>   /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>   #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>   
> @@ -558,6 +563,8 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>   	} else {
>   		/* send the filled skb up the n/w stack */
>   		skb_put(skb, pkt_len);
> +		if (emac->prueth->is_switch_mode)
> +			skb->offload_fwd_mark = emac->offload_fwd_mark;
>   		skb->protocol = eth_type_trans(skb, ndev);
>   		napi_gro_receive(&emac->napi_rx, skb);
>   		ndev->stats.rx_bytes += pkt_len;
> @@ -890,6 +897,19 @@ struct icssg_firmwares {
>   	char *txpru;
>   };
>   
> +static struct icssg_firmwares icssg_switch_firmwares[] = {
> +	{
> +		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
> +		.rtu = "ti-pruss/am65x-sr2-rtu0-prusw-fw.elf",
> +		.txpru = "ti-pruss/am65x-sr2-txpru0-prusw-fw.elf",
> +	},
> +	{
> +		.pru = "ti-pruss/am65x-sr2-pru1-prusw-fw.elf",
> +		.rtu = "ti-pruss/am65x-sr2-rtu1-prusw-fw.elf",
> +		.txpru = "ti-pruss/am65x-sr2-txpru1-prusw-fw.elf",
> +	}
> +};
> +
>   static struct icssg_firmwares icssg_emac_firmwares[] = {
>   	{
>   		.pru = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
> @@ -909,7 +929,10 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>   	struct device *dev = prueth->dev;
>   	int slice, ret;
>   
> -	firmwares = icssg_emac_firmwares;
> +	if (prueth->is_switch_mode)
> +		firmwares = icssg_switch_firmwares;
> +	else
> +		firmwares = icssg_emac_firmwares;
>   
>   	slice = prueth_emac_slice(emac);
>   	if (slice < 0) {
> @@ -1411,6 +1434,21 @@ static int emac_ndo_open(struct net_device *ndev)
>   
>   	queue_work(system_long_wq, &emac->stats_work.work);
>   
> +	if (prueth->is_switch_mode) {
> +		icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
> +				  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
> +				  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
> +				  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
> +				  ICSSG_FDB_ENTRY_BLOCK,
> +				  true);
> +		icssg_vtbl_modify(emac, emac->port_vlan | DEFAULT_VID,
> +				  BIT(emac->port_id) | DEFAULT_PORT_MASK,
> +				  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
> +				  true);
> +		icssg_set_pvid(emac->prueth, emac->port_vlan, emac->port_id);
> +		emac_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
> +	}
> +
>   	return 0;
>   
>   reset_tx_chan:
> @@ -1945,6 +1983,148 @@ static void prueth_put_cores(struct prueth *prueth, int slice)
>   		pru_rproc_put(prueth->pru[slice]);
>   }
>   
> +static void prueth_offload_fwd_mark_update(struct prueth *prueth)
> +{
> +	int set_val = 0;
> +	int i;
> +
> +	if (prueth->br_members == (PRUETH_PORT_MII0 | PRUETH_PORT_MII1))
> +		set_val = 1;
> +
> +	dev_dbg(prueth->dev, "set offload_fwd_mark %d\n", set_val);
> +
> +	for (i = PRUETH_MAC0; i < PRUETH_NUM_MACS; i++) {
> +		struct prueth_emac *emac = prueth->emac[i];
> +
> +		if (!emac || !emac->ndev)
> +			continue;
> +
> +		emac->offload_fwd_mark = set_val;
> +	}
> +}
> +
> +bool prueth_dev_check(const struct net_device *ndev)
> +{
> +	if (ndev->netdev_ops == &emac_netdev_ops && netif_running(ndev)) {
> +		struct prueth_emac *emac = netdev_priv(ndev);
> +
> +		return emac->prueth->is_switch_mode;
> +	}
> +
> +	return false;
> +}
> +
> +static int prueth_netdevice_port_link(struct net_device *ndev,
> +				      struct net_device *br_ndev,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +	int err;
> +
> +	if (!prueth->br_members) {
> +		prueth->hw_bridge_dev = br_ndev;
> +	} else {
> +		/* This is adding the port to a second bridge, this is
> +		 * unsupported
> +		 */
> +		if (prueth->hw_bridge_dev != br_ndev)
> +			return -EOPNOTSUPP;
> +	}
> +
> +	err = switchdev_bridge_port_offload(br_ndev, ndev, emac,
> +					    &prueth->prueth_switchdev_nb,
> +					    &prueth->prueth_switchdev_bl_nb,
> +					    false, extack);
> +	if (err)
> +		return err;
> +
> +	prueth->br_members |= BIT(emac->port_id);
> +
> +	if (prueth->br_members & BIT(PRUETH_PORT_MII0) &&
> +	    prueth->br_members & BIT(PRUETH_PORT_MII1)) {
> +		prueth->is_switch_mode = true;
> +		prueth->default_vlan = 1;
> +		emac->port_vlan = prueth->default_vlan;
> +	}
> +
> +	prueth_offload_fwd_mark_update(prueth);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static void prueth_netdevice_port_unlink(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +
> +	prueth->br_members &= ~BIT(emac->port_id);
> +
> +	prueth->is_switch_mode = false;
> +	emac->port_vlan = 0;
> +
> +	prueth_offload_fwd_mark_update(prueth);
> +
> +	if (!prueth->br_members)
> +		prueth->hw_bridge_dev = NULL;
> +}
> +
> +/* netdev notifier */
> +static int prueth_netdevice_event(struct notifier_block *unused,
> +				  unsigned long event, void *ptr)
> +{
> +	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	struct netdev_notifier_changeupper_info *info;
> +	int ret = NOTIFY_DONE;
> +
> +	if (ndev->netdev_ops != &emac_netdev_ops)
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_CHANGEUPPER:
> +		info = ptr;
> +
> +		if (netif_is_bridge_master(info->upper_dev)) {
> +			if (info->linking)
> +				ret = prueth_netdevice_port_link(ndev, info->upper_dev, extack);
> +			else
> +				prueth_netdevice_port_unlink(ndev);
> +		}
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return notifier_from_errno(ret);
> +}
> +
> +static int prueth_register_notifiers(struct prueth *prueth)
> +{
> +	int ret = 0;
> +
> +	prueth->prueth_netdevice_nb.notifier_call = &prueth_netdevice_event;
> +	ret = register_netdevice_notifier(&prueth->prueth_netdevice_nb);
> +	if (ret) {
> +		dev_err(prueth->dev, "can't register netdevice notifier\n");
> +		return ret;
> +	}
> +
> +	ret = prueth_switchdev_register_notifiers(prueth);
> +	if (ret)
> +		unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
> +
> +	return ret;
> +}
> +
> +static void prueth_unregister_notifiers(struct prueth *prueth)
> +{
> +	prueth_switchdev_unregister_notifiers(prueth);
> +	unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
> +}
> +
> +static const struct of_device_id prueth_dt_match[];
> +
>   static int prueth_probe(struct platform_device *pdev)
>   {
>   	struct device_node *eth_node, *eth_ports_node;
> @@ -2072,6 +2252,10 @@ static int prueth_probe(struct platform_device *pdev)
>   	}
>   
>   	msmc_ram_size = MSMC_RAM_SIZE;
> +	prueth->is_switchmode_supported = prueth->pdata.switch_mode;
> +	if (prueth->is_switchmode_supported)
> +		msmc_ram_size = MSMC_RAM_SIZE_SWITCH_MODE;
> +
>   
>   	/* NOTE: FW bug needs buffer base to be 64KB aligned */
>   	prueth->msmcram.va =
> @@ -2167,6 +2351,14 @@ static int prueth_probe(struct platform_device *pdev)
>   		phy_attached_info(prueth->emac[PRUETH_MAC1]->ndev->phydev);
>   	}
>   
> +	if (prueth->is_switchmode_supported) {
> +		ret = prueth_register_notifiers(prueth);
> +		if (ret)
> +			goto netdev_unregister;
> +
> +		sprintf(prueth->switch_id, "%s", dev_name(dev));
> +	}
> +
>   	dev_info(dev, "TI PRU ethernet driver initialized: %s EMAC mode\n",
>   		 (!eth0_node || !eth1_node) ? "single" : "dual");
>   
> @@ -2236,6 +2428,8 @@ static void prueth_remove(struct platform_device *pdev)
>   	struct device_node *eth_node;
>   	int i;
>   
> +	prueth_unregister_notifiers(prueth);
> +
>   	for (i = 0; i < PRUETH_NUM_MACS; i++) {
>   		if (!prueth->registered_netdevs[i])
>   			continue;
> @@ -2333,10 +2527,12 @@ static const struct dev_pm_ops prueth_dev_pm_ops = {
>   static const struct prueth_pdata am654_icssg_pdata = {
>   	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
>   	.quirk_10m_link_issue = 1,
> +	.switch_mode = 1,
>   };
>   
>   static const struct prueth_pdata am64x_icssg_pdata = {
>   	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
> +	.switch_mode = 1,
>   };
>   
>   static const struct of_device_id prueth_dt_match[] = {

