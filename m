Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE37CA3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjJPJOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjJPJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:13:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E411C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:13:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8BCC433C8;
        Mon, 16 Oct 2023 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697447622;
        bh=AnYgwbfzENYPhxzW6COwmO+W4wT7z9Ci1szmPRBxn7o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fx8xFUf9eH/YUe+8cRkTQnprJw7y6E3uQnK7Pn1Qu30n+UtDOoxPcEbDrsI6fSv0+
         0ydx7T8VfJ+A1CigGv5wkkjDtR13wA0yX+kIg3tNeTMXPKTVwxMYO9pgXEL+XsRF5f
         c3addaCysAM61WIgfjtLfFV9hJqC8lU0dUJ88zKok+wV63KEGRcM3YtNipC0CibNMB
         WwF3stPTMVEttElf9M0NQGhzJIAq5lnmEogi/KkgdYGd1bT6coNIMLNU2CRePr7pGh
         RYqSDMpQ+Nb7c9Un2ibxFO5MAcKaV/VwqQBpgGzRdU+MMbngHplV78Q0Sjl7fDD8+E
         zFJjbMmpzFx7w==
Message-ID: <31422cbc-7848-4bc6-9f9c-ef1d8400123c@kernel.org>
Date:   Mon, 16 Oct 2023 12:13:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: ti: icssg_prueth: add TAPRIO offload
 support
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org,
        Roger Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20231006102028.3831341-1-danishanwar@ti.com>
 <20231011102536.r65xyzmh5kap2cf2@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231011102536.r65xyzmh5kap2cf2@skbuf>
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



On 11/10/2023 13:25, Vladimir Oltean wrote:
> On Fri, Oct 06, 2023 at 03:50:28PM +0530, MD Danish Anwar wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
>> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
>> configuration. EST allows express queue traffic to be scheduled
>> (placed) on the wire at specific repeatable time intervals. In
>> Linux kernel, EST configuration is done through tc command and
>> the taprio scheduler in the net core implements a software only
>> scheduler (SCH_TAPRIO). If the NIC is capable of EST configuration,
>> user indicate "flag 2" in the command which is then parsed by
>> taprio scheduler in net core and indicate that the command is to
>> be offloaded to h/w. taprio then offloads the command to the
>> driver by calling ndo_setup_tc() ndo ops. This patch implements
>> ndo_setup_tc() to offload EST configuration to ICSSG.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>> Cc: Roger Quadros <rogerq@ti.com>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>>
>> Changes from v3 to v4:
>> *) Rebased on the latest next-20231005 linux-next.
> 
> The tree that the patch will be applied to is
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git,
> not linux-next.
> 
>> *) Addressed Roger and Vinicius' comments and moved all the validations to
>>    emac_taprio_replace() API.
>> *) Modified emac_setup_taprio() API to use switch case based on taprio->cmd
>>    and added emac_taprio_destroy() and emac_taprio_replace() APIs.
>> *) Modified the documentation of structs / enums in icssg_qos.h by using
>>    the correct kdoc format.
>>
>> Changes from v2 to v3:
>> *) Rebased on the latest next-20230928 linux-next.
>> *) Retained original authorship of the patch.
>> *) Addressed Roger's comments and modified emac_setup_taprio() and
>>    emac_set_taprio() APIs accordingly.
>> *) Removed netif_running() check from emac_setup_taprio().
>> *) Addressed Vinicius' comments and added check for MIN and MAX cycle time.
>> *) Added check for allocation failure of est_new in emac_setup_taprio().
>>
>> Changes from v1 to v2:
>> *) Rebased on the latest next-20230921 linux-next.
>> *) Dropped the RFC tag as merge window is open now.
>> *) Splitted this patch from the switch mode series [v1].
>> *) Removed TODO comment as asked by Andrew and Roger.
>> *) Changed Copyright to 2023 as asked by Roger.
>>
>> v3: https://lore.kernel.org/all/20230928103000.186304-1-danishanwar@ti.com/
>> v2: https://lore.kernel.org/all/20230921070031.795788-1-danishanwar@ti.com/
>> v1: https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/
>>
>>  drivers/net/ethernet/ti/Makefile             |   3 +-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   6 +
>>  drivers/net/ethernet/ti/icssg/icssg_qos.c    | 301 +++++++++++++++++++
>>  drivers/net/ethernet/ti/icssg/icssg_qos.h    | 113 +++++++
>>  5 files changed, 426 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
>>
>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
>> index 34fd7a716ba6..0df60ded1b2d 100644
>> --- a/drivers/net/ethernet/ti/Makefile
>> +++ b/drivers/net/ethernet/ti/Makefile
>> @@ -37,5 +37,6 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
>>  		  icssg/icssg_config.o \
>>  		  icssg/icssg_mii_cfg.o \
>>  		  icssg/icssg_stats.o \
>> -		  icssg/icssg_ethtool.o
>> +		  icssg/icssg_ethtool.o \
>> +		  icssg/icssg_qos.o
>>  obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 6635b28bc672..89c301716926 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -1166,7 +1166,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
>>  	return 0;
>>  }
>>  
>> -static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
>> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
>>  {
>>  	u32 hi_rollover_count, hi_rollover_count_r;
>>  	struct prueth_emac *emac = clockops_data;
>> @@ -1403,6 +1403,8 @@ static int emac_ndo_open(struct net_device *ndev)
>>  		napi_enable(&emac->tx_chns[i].napi_tx);
>>  	napi_enable(&emac->napi_rx);
>>  
>> +	icssg_qos_tas_init(ndev);
> 
> I believe the intention is for this code to be run before any taprio
> offload is added, correct? But it is possible for the user to add an
> offloaded Qdisc even while the netdev has not yet been brought up.
> Is that case handled correctly, or will it simply result in NULL pointer
> dereferences (tas->config_list)?
> 
>> +
>>  	/* start PHY */
>>  	phy_start(ndev->phydev);
>>  
>> @@ -1669,6 +1671,7 @@ static const struct net_device_ops emac_netdev_ops = {
>>  	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
>>  	.ndo_eth_ioctl = emac_ndo_ioctl,
>>  	.ndo_get_stats64 = emac_ndo_get_stats64,
>> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>>  };
>>  
>>  /* get emac_port corresponding to eth_node name */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index 8b6d6b497010..7cbf0e561905 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -37,6 +37,7 @@
>>  #include "icssg_config.h"
>>  #include "icss_iep.h"
>>  #include "icssg_switch_map.h"
>> +#include "icssg_qos.h"
>>  
>>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>>  #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
>> @@ -174,6 +175,8 @@ struct prueth_emac {
>>  
>>  	struct pruss_mem_region dram;
>>  
>> +	struct prueth_qos qos;
>> +
>>  	struct delayed_work stats_work;
>>  	u64 stats[ICSSG_NUM_STATS];
>>  };
>> @@ -285,4 +288,7 @@ u32 icssg_queue_level(struct prueth *prueth, int queue);
>>  void emac_stats_work_handler(struct work_struct *work);
>>  void emac_update_hardware_stats(struct prueth_emac *emac);
>>  int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
>> +
>> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
>> +
>>  #endif /* __NET_TI_ICSSG_PRUETH_H */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>> new file mode 100644
>> index 000000000000..c8c4450c41bb
>> --- /dev/null
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>> @@ -0,0 +1,301 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Texas Instruments ICSSG PRUETH QoS submodule
>> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +#include <linux/printk.h>
>> +#include "icssg_prueth.h"
>> +#include "icssg_switch_map.h"
>> +
>> +static void tas_update_fw_list_pointers(struct prueth_emac *emac)
>> +{
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +
>> +	if ((readb(tas->active_list)) == TAS_LIST0) {
>> +		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST0;
>> +		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST1;
>> +	} else {
>> +		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST1;
>> +		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST0;
>> +	}
>> +}
>> +
>> +static void tas_update_maxsdu_table(struct prueth_emac *emac)
>> +{
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +	u16 __iomem *max_sdu_tbl_ptr;
>> +	u8 gate_idx;
>> +
>> +	/* update the maxsdu table */
>> +	max_sdu_tbl_ptr = emac->dram.va + TAS_QUEUE_MAX_SDU_LIST;
>> +
>> +	for (gate_idx = 0; gate_idx < TAS_MAX_NUM_QUEUES; gate_idx++)
>> +		writew(tas->max_sdu_table.max_sdu[gate_idx], &max_sdu_tbl_ptr[gate_idx]);
>> +}
>> +
>> +static void tas_reset(struct prueth_emac *emac)
>> +{
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +	int i;
>> +
>> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
>> +		tas->max_sdu_table.max_sdu[i] = 2048;
>> +
>> +	tas_update_maxsdu_table(emac);
>> +
>> +	writeb(TAS_LIST0, tas->active_list);
>> +
>> +	memset_io(tas->fw_active_list, 0, sizeof(*tas->fw_active_list));
>> +	memset_io(tas->fw_shadow_list, 0, sizeof(*tas->fw_shadow_list));
>> +}
>> +
>> +static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
>> +{
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +	int ret;
>> +
>> +	if (tas->state == state)
>> +		return 0;
>> +
>> +	switch (state) {
>> +	case TAS_STATE_RESET:
>> +		tas_reset(emac);
>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
>> +		tas->state = TAS_STATE_RESET;
>> +		break;
>> +	case TAS_STATE_ENABLE:
>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
>> +		tas->state = TAS_STATE_ENABLE;
>> +		break;
>> +	case TAS_STATE_DISABLE:
>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
>> +		tas->state = TAS_STATE_DISABLE;
>> +		break;
>> +	default:
>> +		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	if (ret)
>> +		netdev_err(emac->ndev, "TAS set state failed %d\n", ret);
>> +	return ret;
>> +}
>> +
>> +static int tas_set_trigger_list_change(struct prueth_emac *emac)
>> +{
>> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +	struct ptp_system_timestamp sts;
>> +	u32 change_cycle_count;
>> +	u32 cycle_time;
>> +	u64 base_time;
>> +	u64 cur_time;
>> +
>> +	if (admin_list->cycle_time < TAS_MIN_CYCLE_TIME)
>> +		return -EINVAL;
> 
> Shouldn't this verification have been part of emac_taprio_replace(), and
> have a proper extack?
> 
>> +
>> +	cycle_time = admin_list->cycle_time - 4; /* -4ns to compensate for IEP wraparound time */
> 
> Details? Doesn't this make the phase alignment of the schedule diverge
> from what the user expects?
> 
>> +	base_time = admin_list->base_time;
>> +	cur_time = prueth_iep_gettime(emac, &sts);
>> +
>> +	if (base_time > cur_time)
>> +		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
>> +	else
>> +		change_cycle_count = 1;
> 
> I see that the base_time is only used to calculate the number of cycles
> relative to cur_time. Taprio users want to specify a basetime value
> which indicates the phase alignment of the schedule. This is important
> when the device is synchronized over PTP with other switches in the
> network. Can you explain how is the basetime taken into consideration in
> your implementation?
> 
>> +
>> +	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
>> +	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
>> +	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
>> +
>> +	/* config_change cleared by f/w to ack reception of new shadow list */
>> +	writeb(1, &tas->config_list->config_change);
>> +	/* config_pending cleared by f/w when new shadow list is copied to active list */
>> +	writeb(1, &tas->config_list->config_pending);
>> +
>> +	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
>> +}
>> +
>> +static int tas_update_oper_list(struct prueth_emac *emac)
>> +{
>> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +	u32 tas_acc_gate_close_time = 0;
>> +	u8 idx, gate_idx, val;
>> +	int ret;
>> +
>> +	if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)
>> +		return -EINVAL;
>> +
>> +	tas_update_fw_list_pointers(emac);
>> +
>> +	for (idx = 0; idx < admin_list->num_entries; idx++) {
>> +		writeb(admin_list->entries[idx].gate_mask,
>> +		       &tas->fw_shadow_list->gate_mask_list[idx]);
>> +		tas_acc_gate_close_time += admin_list->entries[idx].interval;
>> +
>> +		/* extend last entry till end of cycle time */
>> +		if (idx == admin_list->num_entries - 1)
>> +			writel(admin_list->cycle_time,
>> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
>> +		else
>> +			writel(tas_acc_gate_close_time,
>> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
>> +	}
>> +
>> +	/* clear remaining entries */
>> +	for (idx = admin_list->num_entries; idx < TAS_MAX_CMD_LISTS; idx++) {
>> +		writeb(0, &tas->fw_shadow_list->gate_mask_list[idx]);
>> +		writel(0, &tas->fw_shadow_list->win_end_time_list[idx]);
>> +	}
>> +
>> +	/* update the Array of gate close time for each queue in each window */
>> +	for (idx = 0 ; idx < admin_list->num_entries; idx++) {
>> +		/* On Linux, only PRUETH_MAX_TX_QUEUES are supported per port */
>> +		for (gate_idx = 0; gate_idx < PRUETH_MAX_TX_QUEUES; gate_idx++) {
>> +			u8 gate_mask_list_idx = readb(&tas->fw_shadow_list->gate_mask_list[idx]);
>> +			u32 gate_close_time = 0;
>> +
>> +			if (gate_mask_list_idx & BIT(gate_idx))
>> +				gate_close_time = readl(&tas->fw_shadow_list->win_end_time_list[idx]);
>> +
>> +			writel(gate_close_time,
>> +			       &tas->fw_shadow_list->gate_close_time_list[idx][gate_idx]);
>> +		}
>> +	}
>> +
>> +	/* tell f/w to swap active & shadow list */
>> +	ret = tas_set_trigger_list_change(emac);
>> +	if (ret) {
>> +		netdev_err(emac->ndev, "failed to swap f/w config list: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Wait for completion */
>> +	ret = readb_poll_timeout(&tas->config_list->config_change, val, !val,
>> +				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
>> +	if (ret) {
>> +		netdev_err(emac->ndev, "TAS list change completion time out\n");
>> +		return ret;
>> +	}
>> +
>> +	tas_update_fw_list_pointers(emac);
>> +
>> +	return 0;
>> +}
>> +
>> +static void emac_cp_taprio(struct tc_taprio_qopt_offload *from,
>> +			   struct tc_taprio_qopt_offload *to)
>> +{
>> +	int i;
>> +
>> +	*to = *from;
>> +	for (i = 0; i < from->num_entries; i++)
>> +		to->entries[i] = from->entries[i];
>> +}
>> +
>> +static int emac_taprio_replace(struct net_device *ndev,
>> +			       struct tc_taprio_qopt_offload *taprio)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct tc_taprio_qopt_offload *est_new;
>> +	int ret, idx;
>> +
>> +	if (taprio->cycle_time_extension) {
>> +		netdev_err(ndev, "Failed to set cycle time extension");
> 
> "failed" implies that the driver tried to do something, but it didn't work.
> Maybe "Cycle time extension not supported"? Also, NL_SET_ERR_MSG_MOD().
> 
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (taprio->num_entries == 0 ||
> 
> Cannot happen. See sch_taprio.c:
> 
> 	if (new_admin->num_entries == 0) {
> 		NL_SET_ERR_MSG(extack, "There should be at least one entry in the schedule");
> 		err = -EINVAL;
> 		goto free_sched;
> 	}
> 
>> +	    taprio->num_entries > TAS_MAX_CMD_LISTS) {
>> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "unsupported num_entries %ld in taprio config\n",
>> +				       taprio->num_entries);
> 
> Better to say what's the hardware maximum, than to report back num_entries
> as being not supported.
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* If any time_interval is 0 in between the list, then exit */
>> +	for (idx = 0; idx < taprio->num_entries; idx++) {
>> +		if (taprio->entries[idx].interval == 0) {
>> +			NL_SET_ERR_MSG_MOD(taprio->extack, "0 interval in taprio config not supported\n");
>> +			return -EINVAL;
>> +		}
>> +	}
> 
> Also not possible, see fill_sched_entry()
> 
> 	/* The interval should allow at least the minimum ethernet
> 	 * frame to go out.
> 	 */
> 	if (interval < min_duration) {
> 		NL_SET_ERR_MSG(extack, "Invalid interval for schedule entry");
> 		return -EINVAL;
> 	}
> 
>> +
>> +	if (emac->qos.tas.taprio_admin)
>> +		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
>> +
>> +	est_new = devm_kzalloc(&ndev->dev,
>> +			       struct_size(est_new, entries, taprio->num_entries),
>> +			       GFP_KERNEL);
>> +	if (!est_new)
>> +		return -ENOMEM;
> 
> You don't need to allocate est_new, you can keep a reference on taprio
> using taprio_offload_get(), and call taprio_offload_put() to release the
> reference when you're done with it.

taprio_offload_free() actually.

Also need fix Kconfig dependecy so this driver depends on NET_SCH_TAPRIO.

> 
>> +
>> +	emac_cp_taprio(taprio, est_new);
>> +	emac->qos.tas.taprio_admin = est_new;
>> +	ret = tas_update_oper_list(emac);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =  tas_set_state(emac, TAS_STATE_ENABLE);
>> +	if (ret)
>> +		devm_kfree(&ndev->dev, est_new);
>> +
>> +	return ret;
>> +}

-- 
cheers,
-roger
