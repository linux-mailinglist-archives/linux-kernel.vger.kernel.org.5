Return-Path: <linux-kernel+bounces-32764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66425835FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C313B22EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D43A1BE;
	Mon, 22 Jan 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="enaIHhLE"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE103A1A5;
	Mon, 22 Jan 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919781; cv=none; b=Y71s//+gH2R4d/C3mKfd8J3rK7unT2gyoGpcjEnJauz7mfVyQKwAJ9nsfcgl7fY3eOyVU/p8jaAeLgGpNmI4i6XDuJs38M+Py1TbNLYEh3RjVumiL+/7dC+y8gFJOQOrtYQpIjbr/SxJ+Mo5rG/F4RVC4XKQfsWTuDFezaebKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919781; c=relaxed/simple;
	bh=5FCUgJm+d0z23IyY8QzAQWEaTzcpuImwv3wxkbzHWX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LNz/W1+AmEKFGpTj/CT0Aeyg2XM+Yi5wPSqhhjARlVlbgWqEHXRmoV7UJq/D7OJKEkUyBNOys+NMiIMJX+Mr7yLAbtrPT4bjU27OME8tRfBlNVaZCsW2vLvfZob9cuiqLTZ4szb6bSvsM706NJKv8AJTslI3nzbfwCFDHt8rn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=enaIHhLE; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MAZp6Q112188;
	Mon, 22 Jan 2024 04:35:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705919751;
	bh=+K/rQCn/hqlJLP3dy1hPy4J9z2pehOjOPDZTTkp8peQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=enaIHhLE9/KAkOzmgNI/LHGNp2+UNRx5MW3rjuXB5ZGX8Z2fyU6Is59GoEggRZeWy
	 7FJSU7K0vrlWw6ZmnoFaZCShCFmhkjtSwdF56iIFRTP1kNA2+KE0yFciV9ufHZqnbA
	 1m+qs4gMr1hILQe+RreWfo+cVh/EqWaGXcg6E/2k=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MAZp3E045497
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 04:35:51 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 04:35:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 04:35:50 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MAZitu059663;
	Mon, 22 Jan 2024 04:35:45 -0600
Message-ID: <d60f87d2-bfaf-40dc-97ed-481ad40aec60@ti.com>
Date: Mon, 22 Jan 2024 16:05:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/3] net: ti: icssg-prueth: Add support for ICSSG
 switch firmware
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Eric
 Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240118071005.1514498-1-danishanwar@ti.com>
 <20240118071005.1514498-4-danishanwar@ti.com>
 <f1ad5388-8a28-4b83-86d5-604d5ece84c0@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <f1ad5388-8a28-4b83-86d5-604d5ece84c0@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 19/01/24 7:59 pm, Andrew Lunn wrote:
> On Thu, Jan 18, 2024 at 12:40:05PM +0530, MD Danish Anwar wrote:
>> Add support for ICSSG switch firmware using existing Dual EMAC driver
>> with switchdev.
>>
>> Limitations:
>> VLAN offloading is limited to 0-256 IDs.
>> MDB/FDB static entries are limited to 511 entries and different FDBs can
>> hash to same bucket and thus may not completely offloaded
> 
> What are the limits when using Dual EMAC driver? I'm just wondering if
> we need to check that 257 VLANs have been offloaded, we cannot swap to
> switch mode, keep with Dual EMAC?
> 

Both Switch and dual EMAC has the same limit. Maximum 256 VIDs can ebe
offloaded in both dual EMAC and switch mode. When VID is greater than
256, we don't add the vid and return 0. You can see
prueth_switchdev_vlans_add() for details on how vlans are added.

>> Switch mode requires loading of new firmware into ICSSG cores. This
>> means interfaces have to taken down and then reconfigured to switch
>> mode.
> 
> This is now out of date?
> 
>>
>> Example assuming ETH1 and ETH2 as ICSSG2 interfaces:
>>
>> Switch to ICSSG Switch mode:
>>  ip link set dev eth1 down
>>  ip link set dev eth2 down
>>  ip link add name br0 type bridge
>>  ip link set dev eth1 master br0
>>  ip link set dev eth2 master br0
>>  ip link set dev br0 up
>>  ip link set dev eth1 up
>>  ip link set dev eth2 up
>>  bridge vlan add dev br0 vid 1 pvid untagged self
>>
>> Going back to Dual EMAC mode:
>>
>>  ip link set dev br0 down
>>  ip link set dev eth1 nomaster
>>  ip link set dev eth2 nomaster
>>  ip link set dev eth1 down
>>  ip link set dev eth2 down
>>  ip link del name br0 type bridge
>>  ip link set dev eth1 up
>>  ip link set dev eth2 up
>>
>> By default, Dual EMAC firmware is loaded, and can be changed to switch
>> mode by above steps
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/Kconfig               |   1 +
>>  drivers/net/ethernet/ti/Makefile              |   3 +-
>>  drivers/net/ethernet/ti/icssg/icssg_config.c  | 136 +++++++++++-
>>  drivers/net/ethernet/ti/icssg/icssg_config.h  |   7 +
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 198 +++++++++++++++++-
>>  .../net/ethernet/ti/icssg/icssg_switchdev.c   |   2 +-
>>  6 files changed, 333 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
>> index be01450c20dc..c72f26828b04 100644
>> --- a/drivers/net/ethernet/ti/Kconfig
>> +++ b/drivers/net/ethernet/ti/Kconfig
>> @@ -188,6 +188,7 @@ config TI_ICSSG_PRUETH
>>  	select TI_ICSS_IEP
>>  	select TI_K3_CPPI_DESC_POOL
>>  	depends on PRU_REMOTEPROC
>> +	depends on NET_SWITCHDEV
>>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>>  	help
>>  	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
>> index d8590304f3df..d295bded7a32 100644
>> --- a/drivers/net/ethernet/ti/Makefile
>> +++ b/drivers/net/ethernet/ti/Makefile
>> @@ -38,5 +38,6 @@ icssg-prueth-y := icssg/icssg_prueth.o \
>>  		  icssg/icssg_config.o \
>>  		  icssg/icssg_mii_cfg.o \
>>  		  icssg/icssg_stats.o \
>> -		  icssg/icssg_ethtool.o
>> +		  icssg/icssg_ethtool.o \
>> +		  icssg/icssg_switchdev.o
>>  obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> index afc10014ec03..eda08a87c902 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> @@ -105,28 +105,49 @@ static const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
>>  	},
>>  };
>>  
>> +static void icssg_config_mii_init_switch(struct prueth_emac *emac)
> 
> I'm surprised you need to configure the MII interface different in
> switch mode. Please could you explain this a bit more.>

Sure, I'll explain.

TX_MUX_SEL0 (BIT(8)) of TXCFG register indicated weather the port is
connected to txpru0 or txpru1

0h = TX data from PRU0 is selected
1h = TX data from PRU1 is selected

Refer to section 6.5.14.11.3 of TRM [1].

In dual EMAC mode, for port0 the connected PRU cores are pru0, rtu0 and
txpru0 similarly for port1 the connected PRU cores are pru1, rtu1 and
txpru1. Port0 and port1 can not communicate among each other as they
don't share any PRU cores. So BIT(8) for port0 is 0h (meaning TX data
from PRU0 is selected) and BIT(8) for port1 is 1h (meaning TX data from
PRU1 is selected)

In switch mode, for port0 the connected PRU cores are pru0, rtu0 and
*txpru1* similarly for port1 the connected PRU cores are pru1, rtu1 and
*txpru0*.

In switch mode, port0 is connected to txpru1 and port1 is connected to
txpru0. This enables the firmware to do the forwarding between the
ports. Now to enable this configuration BIT(8) needs to be set
differently in switch mode. BIT(8) for port0 is 1h (meaning TX data from
PRU1 is selected) and BIT(8) for port1 is 0h (meaning TX data from PRU0
is selected). This enables the forwarding between ports.

So MII interface needs to be configured differently for MAC and switch
mode. The only difference being the BIT(8)


>> +{
>> +	struct prueth *prueth = emac->prueth;
>> +	int mii = prueth_emac_slice(emac);
>> +	u32 txcfg_reg, pcnt_reg, txcfg;
>> +	struct regmap *mii_rt;
>> +
>> +	mii_rt = prueth->mii_rt;
>> +
>> +	txcfg_reg = (mii == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
>> +				       PRUSS_MII_RT_TXCFG1;
>> +	pcnt_reg = (mii == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
>> +				       PRUSS_MII_RT_RX_PCNT1;
>> +
>> +	txcfg = PRUSS_MII_RT_TXCFG_TX_ENABLE |
>> +		PRUSS_MII_RT_TXCFG_TX_AUTO_PREAMBLE |
>> +		PRUSS_MII_RT_TXCFG_TX_IPG_WIRE_CLK_EN;
>> +
>> +	if (emac->phy_if == PHY_INTERFACE_MODE_MII && mii == ICSS_MII1)
>> +		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
>> +	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && mii == ICSS_MII0)
>> +		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
>> +
>> +	regmap_write(mii_rt, txcfg_reg, txcfg);
>> +	regmap_write(mii_rt, pcnt_reg, 0x1);
>> +}
>> +
>>  static void icssg_config_mii_init(struct prueth_emac *emac)
>>  {
>> -	u32 rxcfg, txcfg, rxcfg_reg, txcfg_reg, pcnt_reg;
>>  	struct prueth *prueth = emac->prueth;
>>  	int slice = prueth_emac_slice(emac);
>> +	u32 txcfg, txcfg_reg, pcnt_reg;
>>  	struct regmap *mii_rt;
>>  
>>  	mii_rt = prueth->mii_rt;
>>  
>> -	rxcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RXCFG0 :
>> -				       PRUSS_MII_RT_RXCFG1;
>>  	txcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
>>  				       PRUSS_MII_RT_TXCFG1;
>>  	pcnt_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
>>  				       PRUSS_MII_RT_RX_PCNT1;
>>  
>> -	rxcfg = MII_RXCFG_DEFAULT;
>>  	txcfg = MII_TXCFG_DEFAULT;
>>  
>> -	if (slice == ICSS_MII1)
>> -		rxcfg |= PRUSS_MII_RT_RXCFG_RX_MUX_SEL;
>> -
>>  	/* In MII mode TX lines swapped inside ICSSG, so TX_MUX_SEL cfg need
>>  	 * to be swapped also comparing to RGMII mode.
>>  	 */
>> @@ -135,7 +156,6 @@ static void icssg_config_mii_init(struct prueth_emac *emac)
>>  	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && slice == ICSS_MII1)
>>  		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
>>  
>> -	regmap_write(mii_rt, rxcfg_reg, rxcfg);
>>  	regmap_write(mii_rt, txcfg_reg, txcfg);
>>  	regmap_write(mii_rt, pcnt_reg, 0x1);
>>  }
>> @@ -249,6 +269,66 @@ static int emac_r30_is_done(struct prueth_emac *emac)
>>  	return 1;
>>  }
>>  
>> +static int prueth_switch_buffer_setup(struct prueth_emac *emac)
>> +{
>> +	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
>> +	struct icssg_rxq_ctx __iomem *rxq_ctx;
>> +	struct prueth *prueth = emac->prueth;
>> +	int slice = prueth_emac_slice(emac);
>> +	u32 addr;
>> +	int i;
>> +
>> +	addr = lower_32_bits(prueth->msmcram.pa);
>> +	if (slice)
>> +		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
>> +
>> +	if (addr % SZ_64K) {
>> +		dev_warn(prueth->dev, "buffer pool needs to be 64KB aligned\n");
>> +		return -EINVAL;
>> +	}
> 
> What happens if its not? Do we cleanly stay in Dual EMAC mode without
> any loss of configuration? Or do bad things happen? Maybe this should
> be checked at probe time, so you can deny the swap to switch mode
> quickly and easily?
> 

This is independent of MAC or switch. The MSMC address always needs to
be 64KB aligned. This is a bug in Firmware. If it's not 64KB aligned bad
things might happen, that's why we just stop and return -EINVAL. The
interface will simply not work. The same check is also done in
prueth_emac_buffer_setup().

During probe we make sure that the MSMC is aligned with 64KB. You can
have a look at prueth_probe() [2]. After probe during open() we check
again to see if MSMC is 64KB aligned and then only do the needed
configuration. I can move this check from individual switch / mac APIs
to the beginning of ndo_open() if you want that.

> 	Andrew


[1]
https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf?ts=1705918869984&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FAM6548

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/ti/icssg/icssg_prueth.c?h=v6.8-rc1#n2079

-- 
Thanks and Regards,
Danish

