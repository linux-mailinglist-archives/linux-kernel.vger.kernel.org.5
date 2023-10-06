Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF67BB7A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjJFMbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjJFMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:30:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB8EF0
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:30:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E620FC433C8;
        Fri,  6 Oct 2023 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696595455;
        bh=HTnnMxSM+3ryrq/cM+o2D6zvCE3aQKcW3N81v1MSl1Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bQNbmsl+dZAb3S1yUnTaI48bBJZQPRvneH50v0DJJrFo3XH+7zFZstjUnI31L76pN
         plgpa5uwKqozlEsv1QEIdRPL3VAmPLHKfBIlUlEFNwC3bkZdojDA7ULbSSDTPg/XG8
         j9nC276Amu1uZ3q+cprjBw2lMVpMMy+T4qk9X0l5cHZrmDoVxk4LCxJolZ6KBBK8iq
         EbVuk38tOhm49gNieyu15bzYHKZjO+yL5pcd+apl8Y/sEyW54+1VZAd4wdwu7y/LGE
         IiuDyMul3KmhlR2FxswHchztru85Ll4iQeoj2n9KVYw53Ckv7LLhlrk2b1Nyy+874i
         q3wT7Un9CqA4Q==
Message-ID: <452b442a-dd45-49a8-8fa9-acac15201767@kernel.org>
Date:   Fri, 6 Oct 2023 15:30:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/4] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, vladimir.oltean@nxp.com
Cc:     horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230927072741.21221-1-rogerq@kernel.org>
 <20230927072741.21221-4-rogerq@kernel.org>
 <7e696ab339e423f987b3fe1d8c1fc9231dd4e92c.camel@redhat.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <7e696ab339e423f987b3fe1d8c1fc9231dd4e92c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2023 10:57, Paolo Abeni wrote:
> On Wed, 2023-09-27 at 10:27 +0300, Roger Quadros wrote:
>> Add driver support for viewing / changing the MAC Merge sublayer
>> parameters and seeing the verification state machine's current state
>> via ethtool.
>>
>> As hardware does not support interrupt notification for verification
>> events we resort to polling on link up. On link up we try a couple of
>> times for verification success and if unsuccessful then give up.
>>
>> The Frame Preemption feature is described in the Technical Reference
>> Manual [1] in section:
>> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
>>
>> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
>>
>> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
>> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 150 ++++++++++++
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 240 ++++++++++++++++----
>>  drivers/net/ethernet/ti/am65-cpsw-qos.h     | 104 +++++++++
>>  5 files changed, 454 insertions(+), 47 deletions(-)
>>
>> Changelog:
>> v5:
>> - No change
>>
>> v4:
>> - Rebase and include in the same series as mqprio support.
>>
>> v3:
>> - Rebase on top of v6.6-rc1 and mqprio support [1]
>> - Support ethtool_ops :: get_mm_stats()
>> - drop unused variables cmn_ctrl and verify_cnt
>> - make am65_cpsw_iet_link_state_update() and
>>   am65_cpsw_iet_change_preemptible_tcs() static
>>
>> [1] https://lore.kernel.org/all/20230918075358.5878-1-rogerq@kernel.org/
>>
>> v2:
>> - Use proper control bits for PMAC enable (AM65_CPSW_PN_CTL_IET_PORT_EN)
>>   and TX enable (AM65_CPSW_PN_IET_MAC_PENABLE)
>> - Common IET Enable (AM65_CPSW_CTL_IET_EN) is set if any port has
>>   AM65_CPSW_PN_CTL_IET_PORT_EN set.
>> - Fix workaround for erratum i2208. i.e. Limit rx_min_frag_size to 124
>> - Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
>>   1G link if link is inactive.
>> - resize the RX FIFO based on pmac_enabled, not tx_enabled.
>>
>> Test Procedure:
>>
>> - 2 EVMs with AM65-CPSW network port connected to each other
>> - Run iet-setup-mqprio.sh on both
>>
>> #!/bin/sh
>> #iet-setup-mqprio.sh
>>
>> ifconfig eth0 down
>> ifconfig eth1 down
>> ethtool -L eth0 tx 4
>> ethtool --set-mm eth0 pmac-enabled on tx-enabled on verify-enabled on verify-time 10 tx-min-frag-size 124
>> ifconfig eth0 up
>> sleep 10
>>
>> tc qdisc add dev eth0 handle 100: root mqprio \
>> num_tc 4 \
>> map 0 1 2 3 \
>> queues 1@0 1@1 1@2 1@3 \
>> hw 1 \
>> mode dcb \
>> fp P P P E
>>
>> tc -g class show dev eth0
>> tc qdisc add dev eth0 clsact
>> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5002 0xffff action skbedit priority 2
>> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5003 0xffff action skbedit priority 3
>> ip addr add 192.168.3.102/24 dev eth0 
>>
>> - check that MAC merge verification has succeeded
>>
>> ethtool --show-mm eth0
>>
>>         MAC Merge layer state for eth0:
>>         pMAC enabled: on
>>         TX enabled: on
>>         TX active: on
>>         TX minimum fragment size: 124
>>         RX minimum fragment size: 124
>>         Verify enabled: on
>>         Verify time: 10
>>         Max verify time: 134
>>         Verification status: SUCCEEDED
>>
>> - On receiver EVM run 2 iperf instances
>>
>> iperf3 -s -i30 -p5002&
>> iperf3 -s -i30 -p5003&
>>
>> - On sender EVM run 2 iperf instances
>>
>> iperf3 -c 192.168.3.102 -u -b200M -l1472 -u -t5 -i30 -p5002&
>> iperf3 -c 192.168.3.102 -u -b50M -l1472 -u -t5 -i30 -p5003&
>>
>> - Check IET stats on sender. Look for MACMergeFragCountTx: increments
>>
>> ethtool -I --show-mm eth0
>> MAC Merge layer state for eth0:
>> pMAC enabled: on
>> TX enabled: on
>> TX active: on
>> TX minimum fragment size: 124
>> RX minimum fragment size: 124
>> Verify enabled: on
>> Verify time: 10
>> Max verify time: 134
>> Verification status: SUCCEEDED
>> Statistics:
>>   MACMergeFrameAssErrorCount: 0
>>   MACMergeFrameSmdErrorCount: 0
>>   MACMergeFrameAssOkCount: 0
>>   MACMergeFragCountRx: 0
>>   MACMergeFragCountTx: 57824
>>   MACMergeHoldCount: 0
>>
>> - Check IET stats on receiver. Look for MACMergeFragCountRx: and
>>   MACMergeFrameAssOkCount:
>>
>> ethtool -I --show-mm eth0
>> MAC Merge layer state for eth0:
>> pMAC enabled: on
>> TX enabled: on
>> TX active: on
>> TX minimum fragment size: 124
>> RX minimum fragment size: 124
>> Verify enabled: on
>> Verify time: 10
>> Max verify time: 134
>> Verification status: SUCCEEDED
>> Statistics:
>>   MACMergeFrameAssErrorCount: 0
>>   MACMergeFrameSmdErrorCount: 0
>>   MACMergeFrameAssOkCount: 57018
>>   MACMergeFragCountRx: 57824
>>   MACMergeFragCountTx: 0
>>   MACMergeHoldCount: 0
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> index c51e2af91f69..f6b081b7e754 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/pm_runtime.h>
>>  
>>  #include "am65-cpsw-nuss.h"
>> +#include "am65-cpsw-qos.h"
>>  #include "cpsw_ale.h"
>>  #include "am65-cpts.h"
>>  
>> @@ -715,6 +716,152 @@ static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
>>  	return 0;
>>  }
>>  
>> +static void am65_cpsw_port_iet_rx_enable(struct am65_cpsw_port *port, bool enable)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
>> +	if (enable)
>> +		val |= AM65_CPSW_PN_CTL_IET_PORT_EN;
>> +	else
>> +		val &= ~AM65_CPSW_PN_CTL_IET_PORT_EN;
>> +
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_CTL);
>> +	am65_cpsw_iet_common_enable(port->common);
>> +}
>> +
>> +static void am65_cpsw_port_iet_tx_enable(struct am65_cpsw_port *port, bool enable)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	if (enable)
>> +		val |= AM65_CPSW_PN_IET_MAC_PENABLE;
>> +	else
>> +		val &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
>> +
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +}
>> +
>> +static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
>> +	u32 port_ctrl, iet_ctrl, iet_status;
>> +	u32 add_frag_size;
>> +
>> +	mutex_lock(&priv->mm_lock);
>> +
>> +	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	port_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
>> +
>> +	state->tx_enabled = !!(iet_ctrl & AM65_CPSW_PN_IET_MAC_PENABLE);
>> +	state->pmac_enabled = !!(port_ctrl & AM65_CPSW_PN_CTL_IET_PORT_EN);
>> +
>> +	iet_status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
>> +
>> +	if (iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)
>> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
>> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFIED)
>> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
>> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFY_FAIL)
>> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
>> +	else
>> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
>> +
>> +	add_frag_size = AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(iet_ctrl);
>> +	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
>> +
>> +	/* Errata i2208: RX min fragment size cannot be less than 124 */
>> +	state->rx_min_frag_size = 124;
>> +
>> +	/* FPE active if common tx_enabled and verification success or disabled (forced) */
>> +	state->tx_active = state->tx_enabled &&
>> +			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
>> +			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
>> +	state->verify_enabled = !(iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY);
>> +
>> +	state->verify_time = port->qos.iet.verify_time_ms;
>> +	state->max_verify_time = am65_cpsw_iet_get_verify_timeout_ms(AM65_CPSW_PN_MAC_VERIFY_CNT_MASK,
>> +								     port);
>> +	mutex_unlock(&priv->mm_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>> +			    struct netlink_ext_ack *extack)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
>> +	struct am65_cpsw_iet *iet = &port->qos.iet;
>> +	u32 val, add_frag_size;
>> +	int err;
>> +
>> +	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
>> +	if (err)
>> +		return err;
>> +
>> +	mutex_lock(&priv->mm_lock);
>> +
>> +	if (cfg->pmac_enabled) {
>> +		/* change TX & RX FIFO MAX_BLKS as per TRM recommendation */
>> +		if (!iet->original_max_blks)
>> +			iet->original_max_blks = readl(port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
>> +
>> +		writel(AM65_CPSW_PN_TX_RX_MAX_BLKS_IET,
>> +		       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
>> +	} else {
>> +		/* restore RX & TX FIFO MAX_BLKS */
>> +		if (iet->original_max_blks) {
>> +			writel(iet->original_max_blks,
>> +			       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
>> +		}
>> +	}
>> +
>> +	am65_cpsw_port_iet_rx_enable(port, cfg->pmac_enabled);
>> +	am65_cpsw_port_iet_tx_enable(port, cfg->tx_enabled);
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	if (cfg->verify_enabled) {
>> +		val &= ~AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
>> +		/* Reset Verify state machine. Verification won't start here.
>> +		 * Verification will be done once link-up.
>> +		 */
>> +		val |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
>> +	} else {
>> +		val |= AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
>> +	}
>> +
>> +	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
>> +	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +
>> +	/* verify_timeout_count can only be set at valid link */
>> +	port->qos.iet.verify_time_ms = cfg->verify_time;
>> +
>> +	/* enable/disable pre-emption based on link status */
>> +	am65_cpsw_iet_commit_preemptible_tcs(port);
>> +
>> +	mutex_unlock(&priv->mm_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static void am65_cpsw_get_mm_stats(struct net_device *ndev,
>> +				   struct ethtool_mm_stats *s)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	void __iomem *base = port->stat_base;
>> +
>> +	s->MACMergeFrameAssOkCount = readl(base + AM65_CPSW_STATN_IET_RX_ASSEMBLY_OK);
>> +	s->MACMergeFrameAssErrorCount = readl(base + AM65_CPSW_STATN_IET_RX_ASSEMBLY_ERROR);
>> +	s->MACMergeFrameSmdErrorCount = readl(base + AM65_CPSW_STATN_IET_RX_SMD_ERROR);
>> +	s->MACMergeFragCountRx = readl(base + AM65_CPSW_STATN_IET_RX_FRAG);
>> +	s->MACMergeFragCountTx = readl(base + AM65_CPSW_STATN_IET_TX_FRAG);
>> +	s->MACMergeHoldCount = readl(base + AM65_CPSW_STATN_IET_TX_HOLD);
>> +}
>> +
>>  const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
>>  	.begin			= am65_cpsw_ethtool_op_begin,
>>  	.complete		= am65_cpsw_ethtool_op_complete,
>> @@ -743,4 +890,7 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
>>  	.get_eee		= am65_cpsw_get_eee,
>>  	.set_eee		= am65_cpsw_set_eee,
>>  	.nway_reset		= am65_cpsw_nway_reset,
>> +	.get_mm			= am65_cpsw_get_mm,
>> +	.set_mm			= am65_cpsw_set_mm,
>> +	.get_mm_stats		= am65_cpsw_get_mm_stats,
>>  };
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index bea6fc0f324c..2004f6a020d3 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -2161,6 +2161,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
>>  	ndev_priv = netdev_priv(port->ndev);
>>  	ndev_priv->port = port;
>>  	ndev_priv->msg_enable = AM65_CPSW_DEBUG;
>> +	mutex_init(&ndev_priv->mm_lock);
>> +	port->qos.link_speed = SPEED_UNKNOWN;
>>  	SET_NETDEV_DEV(port->ndev, dev);
>>  
>>  	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
>> index f3dad2ab9828..1e4a045057fc 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
>> @@ -145,6 +145,7 @@ struct am65_cpsw_common {
>>  	bool			pf_p0_rx_ptype_rrobin;
>>  	struct am65_cpts	*cpts;
>>  	int			est_enabled;
>> +	bool			iet_enabled;
>>  
>>  	bool		is_emac_mode;
>>  	u16			br_members;
>> @@ -170,6 +171,10 @@ struct am65_cpsw_ndev_priv {
>>  	struct am65_cpsw_port	*port;
>>  	struct am65_cpsw_ndev_stats __percpu *stats;
>>  	bool offload_fwd_mark;
>> +	/* Serialize access to MAC Merge state between ethtool requests
>> +	 * and link state updates
>> +	 */
>> +	struct mutex		mm_lock;
>>  };
>>  
>>  #define am65_ndev_to_priv(ndev) \
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> index 991221d8f148..ec2986e79edd 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> @@ -4,9 +4,11 @@
>>   *
>>   * quality of service module includes:
>>   * Enhanced Scheduler Traffic (EST - P802.1Qbv/D2.2)
>> + * Interspersed Express Traffic (IET - P802.3br/D2.0)
>>   */
>>  
>>  #include <linux/pm_runtime.h>
>> +#include <linux/units.h>
>>  #include <linux/time.h>
>>  #include <net/pkt_cls.h>
>>  
>> @@ -15,50 +17,6 @@
>>  #include "am65-cpts.h"
>>  #include "cpsw_ale.h"
>>  
>> -#define AM65_CPSW_REG_CTL			0x004
>> -#define AM65_CPSW_P0_REG_TX_PRI_MAP		0x018
>> -#define AM65_CPSW_P0_REG_RX_PRI_MAP		0x020
>> -#define AM65_CPSW_P0_REG_FIFO_STATUS		0x050
>> -#define AM65_CPSW_P0_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
>> -#define AM65_CPSW_P0_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
>> -
>> -#define AM65_CPSW_PN_REG_CTL			0x004
>> -#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
>> -#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
>> -#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
>> -#define AM65_CPSW_PN_REG_EST_CTL		0x060
>> -#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
>> -#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
>> -
>> -/* AM65_CPSW_REG_CTL register fields */
>> -#define AM65_CPSW_CTL_EST_EN			BIT(18)
>> -
>> -/* AM65_CPSW_PN_REG_CTL register fields */
>> -#define AM65_CPSW_PN_CTL_EST_PORT_EN		BIT(17)
>> -
>> -/* AM65_CPSW_PN_REG_EST_CTL register fields */
>> -#define AM65_CPSW_PN_EST_ONEBUF			BIT(0)
>> -#define AM65_CPSW_PN_EST_BUFSEL			BIT(1)
>> -#define AM65_CPSW_PN_EST_TS_EN			BIT(2)
>> -#define AM65_CPSW_PN_EST_TS_FIRST		BIT(3)
>> -#define AM65_CPSW_PN_EST_ONEPRI			BIT(4)
>> -#define AM65_CPSW_PN_EST_TS_PRI_MSK		GENMASK(7, 5)
>> -
>> -/* AM65_CPSW_PN_REG_FIFO_STATUS register fields */
>> -#define AM65_CPSW_PN_FST_TX_PRI_ACTIVE_MSK	GENMASK(7, 0)
>> -#define AM65_CPSW_PN_FST_TX_E_MAC_ALLOW_MSK	GENMASK(15, 8)
>> -#define AM65_CPSW_PN_FST_EST_CNT_ERR		BIT(16)
>> -#define AM65_CPSW_PN_FST_EST_ADD_ERR		BIT(17)
>> -#define AM65_CPSW_PN_FST_EST_BUFACT		BIT(18)
>> -
>> -/* EST FETCH COMMAND RAM */
>> -#define AM65_CPSW_FETCH_RAM_CMD_NUM		0x80
>> -#define AM65_CPSW_FETCH_CNT_MSK			GENMASK(21, 8)
>> -#define AM65_CPSW_FETCH_CNT_MAX			(AM65_CPSW_FETCH_CNT_MSK >> 8)
>> -#define AM65_CPSW_FETCH_CNT_OFFSET		8
>> -#define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
>> -#define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
>> -
>>  #define TO_MBPS(x)	((x) * 8 / 1000000)
>>  
>>  enum timer_act {
>> @@ -67,10 +25,193 @@ enum timer_act {
>>  	TACT_SKIP_PROG,		/* just buffer can be updated */
>>  };
>>  
>> -/* number of priority queues per port FIFO */
>> -#define AM65_CPSW_PN_FIFO_PRIO_NUM		8
>> -#define AM65_CPSW_PN_TX_PRI_MAP_DEFAULT		0x76543210
>> +/* IET */
>> +static int am65_cpsw_iet_set_verify_timeout_count(struct am65_cpsw_port *port)
>> +{
>> +	int verify_time_ms = port->qos.iet.verify_time_ms;
>> +	int link_speed = port->qos.link_speed;
>> +	u32 val;
>> +
>> +	if (WARN_ON(link_speed == SPEED_UNKNOWN))
>> +		return -ENODEV;
>> +
>> +	/* The number of wireside clocks contained in the verify
>> +	 * timeout counter. The default is 0x1312d0
>> +	 * (10ms at 125Mhz in 1G mode).
>> +	 */
>> +	val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
>> +
>> +	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
>> +	val *= verify_time_ms;		/* count for timeout ms */
>> +	if (link_speed < SPEED_1000)
>> +		val <<= 1;	/* FIXME: Is this correct? */
>> +
>> +	if (val > AM65_CPSW_PN_MAC_VERIFY_CNT_MASK)
>> +		return -EINVAL;
>> +
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_VERIFY);
>> +
>> +	return 0;
>> +}
>> +
>> +unsigned int am65_cpsw_iet_get_verify_timeout_ms(u32 count, struct am65_cpsw_port *port)
>> +{
>> +	int link_speed = port->qos.link_speed;
>> +	u32 val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
>> +	unsigned int timeout_ms;
>> +
>> +	if (link_speed == SPEED_UNKNOWN)
>> +		link_speed = SPEED_1000;
>> +
>> +	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
>> +
>> +	timeout_ms = count / val;
>> +
>> +	if (link_speed < SPEED_1000)
>> +		timeout_ms >>= 1;	/* FIXME: Is this correct? */
>> +
>> +	return timeout_ms;
>> +}
>> +
>> +static int am65_cpsw_iet_verify_wait(struct am65_cpsw_port *port)
>> +{
>> +	u32 ctrl, status;
>> +	int try;
>> +
>> +	try = 20;
>> +	do {
>> +		/* Clear MAC_LINKFAIL bit to start Verify. */
>> +		ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +		ctrl &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
>> +		writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +
>> +		msleep(port->qos.iet.verify_time_ms);
>> +
>> +		status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
>> +		if (status & AM65_CPSW_PN_MAC_VERIFIED)
>> +			return 0;
>> +
>> +		if (status & AM65_CPSW_PN_MAC_VERIFY_FAIL) {
>> +			netdev_dbg(port->ndev,
>> +				   "MAC Merge verify failed, trying again");
>> +			/* Reset the verify state machine by writing 1
>> +			 * to LINKFAIL
>> +			 */
>> +			ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +			ctrl |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
>> +			writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +			continue;
>> +		}
>> +
>> +		if (status & AM65_CPSW_PN_MAC_RESPOND_ERR) {
>> +			netdev_dbg(port->ndev, "MAC Merge respond error");
>> +			return -ENODEV;
>> +		}
>> +
>> +		if (status & AM65_CPSW_PN_MAC_VERIFY_ERR) {
>> +			netdev_dbg(port->ndev, "MAC Merge verify error");
>> +			return -ENODEV;
>> +		}
>> +	} while (try-- > 0);
>> +
>> +	netdev_dbg(port->ndev, "MAC Merge verify timeout");
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static void am65_cpsw_iet_set_preempt_mask(struct am65_cpsw_port *port, u8 preemptible_tcs)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	val &= ~AM65_CPSW_PN_IET_MAC_PREMPT_MASK;
>> +	val |= AM65_CPSW_PN_IET_MAC_SET_PREEMPT(preemptible_tcs);
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +}
>> +
>> +/* enable common IET_ENABLE only if at least 1 port has rx IET enabled.
>> + * UAPI doesn't allow tx enable without rx enable.
>> + */
>> +void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common)
>> +{
>> +	struct am65_cpsw_port *port;
>> +	bool rx_enable = false;
>> +	u32 val;
>> +	int i;
>> +
>> +	for (i = 0; i < common->port_num; i++) {
>> +		port = &common->ports[i];
>> +		val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
>> +		rx_enable = !!(val & AM65_CPSW_PN_CTL_IET_PORT_EN);
>> +		if (rx_enable)
>> +			break;
>> +	}
>> +
>> +	val = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
>> +
>> +	if (rx_enable)
>> +		val |= AM65_CPSW_CTL_IET_EN;
>> +	else
>> +		val &= ~AM65_CPSW_CTL_IET_EN;
>> +
>> +	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
>> +	common->iet_enabled = rx_enable;
>> +}
>> +
>> +/* CPSW does not have an IRQ to notify changes to the MAC Merge TX status
>> + * (active/inactive), but the preemptible traffic classes should only be
>> + * committed to hardware once TX is active. Resort to polling.
>> + */
>> +void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
>> +{
>> +	u8 preemptible_tcs = 0;
>> +	int err;
>> +	u32 val;
>> +
>> +	if (port->qos.link_speed == SPEED_UNKNOWN)
>> +		return;
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
>> +	if (!(val & AM65_CPSW_PN_CTL_IET_PORT_EN))
>> +		return;
>> +
>> +	/* update common IET enable */
>> +	am65_cpsw_iet_common_enable(port->common);
>>  
>> +	/* update verify count */
>> +	err = am65_cpsw_iet_set_verify_timeout_count(port);
>> +	if (err) {
>> +		netdev_err(port->ndev, "couldn't set verify count: %d\n", err);
>> +		return;
>> +	}
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	if (!(val & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)) {
>> +		err = am65_cpsw_iet_verify_wait(port);
>> +		if (err)
>> +			return;
>> +	}
>> +
>> +	preemptible_tcs = port->qos.iet.preemptible_tcs;
>> +	am65_cpsw_iet_set_preempt_mask(port, preemptible_tcs);
>> +}
>> +
>> +static void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
>> +{
>> +	port->qos.iet.preemptible_tcs = preemptible_tcs;
>> +	am65_cpsw_iet_commit_preemptible_tcs(port);
> 
> I'm sorry for the late feedback, but I was unable to notice the
> following before.
> 
> It looks like am65_cpsw_iet_commit_preemptible_tcs() is always invoked
> with the priv->mm_lock lock held, except in the above call that can be
> reached without such lock held, via the am65_cpsw_qos_ndo_setup_tc().
> 
> Is that safe? If so I think it deserves at least a comment in the code.

I think it is better to call it with the priv->mm_lock held. Thanks!

-- 
cheers,
-roger
