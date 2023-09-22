Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F277AB0BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjIVLai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjIVLag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:30:36 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907ECCA;
        Fri, 22 Sep 2023 04:30:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38MBU8pX035772;
        Fri, 22 Sep 2023 06:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695382208;
        bh=m/weRXVRo2sWmS6+CgM0ykO9JOXlnuqj9wjqPQJ9X9k=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=KCCvf/bNJTIH69VpFCN/bvg6klKTF5gNc4iwkNqDMtBK1lycvYGKhDjOb28rc+TKG
         +dqS/MmCLtIguyCixVz8j4Nk4yFJb39N3cw7OEwsIwwu1mAeYY3vfXRMOaE54p5jID
         zSlYDugNb3PYdM5OFMg/pzKI9UpEkpoIkTXx22ao=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38MBU87v031177
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Sep 2023 06:30:08 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 06:30:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 06:30:07 -0500
Received: from [10.249.135.225] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38MBU2bB002737;
        Fri, 22 Sep 2023 06:30:02 -0500
Message-ID: <bac15752-ae40-43e0-51d2-c420635b65d2@ti.com>
Date:   Fri, 22 Sep 2023 17:00:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2] net: ti: icssg_prueth: add TAPRIO offload
 support
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <vladimir.oltean@nxp.com>,
        Simon Horman <horms@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>, Roger Quadros <rogerq@ti.com>
References: <20230921070031.795788-1-danishanwar@ti.com>
 <b3248b40-38a1-47b0-a61d-e81a451fa0a7@kernel.org>
 <ab89486b-1a3d-918b-b083-071372559fbf@ti.com>
 <1cacae47-013c-456a-9b9e-22dc1907ea91@kernel.org>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <1cacae47-013c-456a-9b9e-22dc1907ea91@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2023 4:10 PM, Roger Quadros wrote:
> 
> 
> On 22/09/2023 07:58, MD Danish Anwar wrote:
>> On 21/09/23 16:12, Roger Quadros wrote:
>>> Hi Danish,
>>>
>>> On 21/09/2023 10:00, MD Danish Anwar wrote:
>>>
>>> Can you please retain patch authorhsip?
>>>
>>
>> Sure Roger. This patch was not applying clearly on latest linux-next so
>> I had to manually apply it. I must have lost authorship while doing
>> this. I will reset the authorship.
>>
>>>> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
>>>> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
>>>> configuration. EST allows express queue traffic to be scheduled
>>>> (placed) on the wire at specific repeatable time intervals. In
>>>> Linux kernel, EST configuration is done through tc command and
>>>> the taprio scheduler in the net core implements a software only
>>>> scheduler (SCH_TAPRIO). If the NIC is capable of EST configuration,
>>>> user indicate "flag 2" in the command which is then parsed by
>>>> taprio scheduler in net core and indicate that the command is to
>>>> be offloaded to h/w. taprio then offloads the command to the
>>>> driver by calling ndo_setup_tc() ndo ops. This patch implements
>>>> ndo_setup_tc() to offload EST configuration to ICSSG.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>> Cc: Roger Quadros <rogerq@ti.com>
>>>> Cc: Andrew Lunn <andrew@lunn.ch>
>>>>
>>>> Changes from v1 to v2:
>>>> *) Rebased on the latest next-20230821 linux-next.
>>>> *) Dropped the RFC tag as merge window is open now.
>>>> *) Splitted this patch from the switch mode series [v1].
>>>> *) Removed TODO comment as asked by Andrew and Roger.
>>>> *) Changed Copyright to 2023 as asked by Roger.
>>>>
>>>> v1: https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/
>>>>
>>>>  drivers/net/ethernet/ti/Makefile             |   3 +-
>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   7 +
>>>>  drivers/net/ethernet/ti/icssg/icssg_qos.c    | 286 +++++++++++++++++++
>>>>  drivers/net/ethernet/ti/icssg/icssg_qos.h    | 119 ++++++++
>>>>  5 files changed, 418 insertions(+), 2 deletions(-)
>>>>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>>>>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
>>>>
>>>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
>>>> index 34fd7a716ba6..0df60ded1b2d 100644
>>>> --- a/drivers/net/ethernet/ti/Makefile
>>>> +++ b/drivers/net/ethernet/ti/Makefile
>>>> @@ -37,5 +37,6 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
>>>>  		  icssg/icssg_config.o \
>>>>  		  icssg/icssg_mii_cfg.o \
>>>>  		  icssg/icssg_stats.o \
>>>> -		  icssg/icssg_ethtool.o
>>>> +		  icssg/icssg_ethtool.o \
>>>> +		  icssg/icssg_qos.o
>>>>  obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> index 6635b28bc672..89c301716926 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> @@ -1166,7 +1166,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
>>>> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
>>>>  {
>>>>  	u32 hi_rollover_count, hi_rollover_count_r;
>>>>  	struct prueth_emac *emac = clockops_data;
>>>> @@ -1403,6 +1403,8 @@ static int emac_ndo_open(struct net_device *ndev)
>>>>  		napi_enable(&emac->tx_chns[i].napi_tx);
>>>>  	napi_enable(&emac->napi_rx);
>>>>  
>>>> +	icssg_qos_tas_init(ndev);
>>>> +
>>>>  	/* start PHY */
>>>>  	phy_start(ndev->phydev);
>>>>  
>>>> @@ -1669,6 +1671,7 @@ static const struct net_device_ops emac_netdev_ops = {
>>>>  	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
>>>>  	.ndo_eth_ioctl = emac_ndo_ioctl,
>>>>  	.ndo_get_stats64 = emac_ndo_get_stats64,
>>>> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>>>>  };
>>>>  
>>>>  /* get emac_port corresponding to eth_node name */
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>> index 8b6d6b497010..5712a65bced4 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>> @@ -37,6 +37,7 @@
>>>>  #include "icssg_config.h"
>>>>  #include "icss_iep.h"
>>>>  #include "icssg_switch_map.h"
>>>> +#include "icssg_qos.h"
>>>>  
>>>>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>>>>  #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
>>>> @@ -174,6 +175,9 @@ struct prueth_emac {
>>>>  
>>>>  	struct pruss_mem_region dram;
>>>>  
>>>> +	struct prueth_qos qos;
>>>> +	struct work_struct ts_work;
>>>> +
>>>>  	struct delayed_work stats_work;
>>>>  	u64 stats[ICSSG_NUM_STATS];
>>>>  };
>>>> @@ -285,4 +289,7 @@ u32 icssg_queue_level(struct prueth *prueth, int queue);
>>>>  void emac_stats_work_handler(struct work_struct *work);
>>>>  void emac_update_hardware_stats(struct prueth_emac *emac);
>>>>  int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
>>>> +
>>>> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
>>>> +
>>>>  #endif /* __NET_TI_ICSSG_PRUETH_H */
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>>>> new file mode 100644
>>>> index 000000000000..63a19142ee69
>>>> --- /dev/null
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>>>> @@ -0,0 +1,286 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/* Texas Instruments ICSSG PRUETH QoS submodule
>>>> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
>>>> + */
>>>> +
>>>> +#include <linux/printk.h>
>>>> +#include "icssg_prueth.h"
>>>> +#include "icssg_switch_map.h"
>>>> +
>>>> +static void tas_update_fw_list_pointers(struct prueth_emac *emac)
>>>> +{
>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>> +
>>>> +	if ((readb(tas->active_list)) == TAS_LIST0) {
>>>> +		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST0;
>>>> +		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST1;
>>>> +	} else {
>>>> +		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST1;
>>>> +		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST0;
>>>> +	}
>>>> +}
>>>> +
>>>> +static void tas_update_maxsdu_table(struct prueth_emac *emac)
>>>> +{
>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>> +	u16 __iomem *max_sdu_tbl_ptr;
>>>> +	u8 gate_idx;
>>>> +
>>>> +	/* update the maxsdu table */
>>>> +	max_sdu_tbl_ptr = emac->dram.va + TAS_QUEUE_MAX_SDU_LIST;
>>>> +
>>>> +	for (gate_idx = 0; gate_idx < TAS_MAX_NUM_QUEUES; gate_idx++)
>>>> +		writew(tas->max_sdu_table.max_sdu[gate_idx], &max_sdu_tbl_ptr[gate_idx]);
>>>> +}
>>>> +
>>>> +static void tas_reset(struct prueth_emac *emac)
>>>> +{
>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
>>>> +		tas->max_sdu_table.max_sdu[i] = 2048;
>>>> +
>>>> +	tas_update_maxsdu_table(emac);
>>>> +
>>>> +	writeb(TAS_LIST0, tas->active_list);
>>>> +
>>>> +	memset_io(tas->fw_active_list, 0, sizeof(*tas->fw_active_list));
>>>> +	memset_io(tas->fw_shadow_list, 0, sizeof(*tas->fw_shadow_list));
>>>> +}
>>>> +
>>>> +static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
>>>> +{
>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>> +	int ret;
>>>> +
>>>> +	if (tas->state == state)
>>>> +		return 0;
>>>> +
>>>> +	switch (state) {
>>>> +	case TAS_STATE_RESET:
>>>> +		tas_reset(emac);
>>>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
>>>> +		tas->state = TAS_STATE_RESET;
>>>> +		break;
>>>> +	case TAS_STATE_ENABLE:
>>>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
>>>> +		tas->state = TAS_STATE_ENABLE;
>>>> +		break;
>>>> +	case TAS_STATE_DISABLE:
>>>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
>>>> +		tas->state = TAS_STATE_DISABLE;
>>>> +		break;
>>>> +	default:
>>>> +		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);
>>>> +		ret = -EINVAL;
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	if (ret)
>>>> +		netdev_err(emac->ndev, "TAS set state failed %d\n", ret);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int tas_set_trigger_list_change(struct prueth_emac *emac)
>>>> +{
>>>> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>> +	struct ptp_system_timestamp sts;
>>>> +	u32 change_cycle_count;
>>>> +	u32 cycle_time;
>>>> +	u64 base_time;
>>>> +	u64 cur_time;
>>>> +
>>>> +	cycle_time = admin_list->cycle_time - 4; /* -4ns to compensate for IEP wraparound time */
>>>> +	base_time = admin_list->base_time;
>>>> +	cur_time = prueth_iep_gettime(emac, &sts);
>>>> +
>>>> +	if (base_time > cur_time)
>>>> +		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
>>>> +	else
>>>> +		change_cycle_count = 1;
>>>> +
>>>> +	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
>>>> +	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
>>>> +	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
>>>> +
>>>> +	/* config_change cleared by f/w to ack reception of new shadow list */
>>>> +	writeb(1, &tas->config_list->config_change);
>>>> +	/* config_pending cleared by f/w when new shadow list is copied to active list */
>>>> +	writeb(1, &tas->config_list->config_pending);
>>>> +
>>>> +	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
>>>> +}
>>>> +
>>>> +static int tas_update_oper_list(struct prueth_emac *emac)
>>>> +{
>>>> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>> +	u32 tas_acc_gate_close_time = 0;
>>>> +	u8 idx, gate_idx, val;
>>>> +	int ret;
>>>> +
>>>> +	tas_update_fw_list_pointers(emac);
>>>> +
>>>> +	for (idx = 0; idx < admin_list->num_entries; idx++) {
>>>> +		writeb(admin_list->entries[idx].gate_mask,
>>>> +		       &tas->fw_shadow_list->gate_mask_list[idx]);
>>>> +		tas_acc_gate_close_time += admin_list->entries[idx].interval;
>>>> +
>>>> +		/* extend last entry till end of cycle time */
>>>> +		if (idx == admin_list->num_entries - 1)
>>>> +			writel(admin_list->cycle_time,
>>>> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
>>>> +		else
>>>> +			writel(tas_acc_gate_close_time,
>>>> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
>>>> +	}
>>>> +
>>>> +	/* clear remaining entries */
>>>> +	for (idx = admin_list->num_entries; idx < TAS_MAX_CMD_LISTS; idx++) {
>>>> +		writeb(0, &tas->fw_shadow_list->gate_mask_list[idx]);
>>>> +		writel(0, &tas->fw_shadow_list->win_end_time_list[idx]);
>>>> +	}
>>>> +
>>>> +	/* update the Array of gate close time for each queue in each window */
>>>> +	for (idx = 0 ; idx < admin_list->num_entries; idx++) {
>>>> +		/* On Linux, only PRUETH_MAX_TX_QUEUES are supported per port */
>>>> +		for (gate_idx = 0; gate_idx < PRUETH_MAX_TX_QUEUES; gate_idx++) {
>>>> +			u8 gate_mask_list_idx = readb(&tas->fw_shadow_list->gate_mask_list[idx]);
>>>> +			u32 gate_close_time = 0;
>>>> +
>>>> +			if (gate_mask_list_idx & BIT(gate_idx))
>>>> +				gate_close_time = readl(&tas->fw_shadow_list->win_end_time_list[idx]);
>>>> +
>>>> +			writel(gate_close_time,
>>>> +			       &tas->fw_shadow_list->gate_close_time_list[idx][gate_idx]);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	/* tell f/w to swap active & shadow list */
>>>> +	ret = tas_set_trigger_list_change(emac);
>>>> +	if (ret) {
>>>> +		netdev_err(emac->ndev, "failed to swap f/w config list: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/* Wait for completion */
>>>> +	ret = readb_poll_timeout(&tas->config_list->config_change, val, !val,
>>>> +				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
>>>> +	if (ret) {
>>>> +		netdev_err(emac->ndev, "TAS list change completion time out\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	tas_update_fw_list_pointers(emac);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int emac_set_taprio(struct prueth_emac *emac)
>>>> +{
>>>> +	struct tc_taprio_qopt_offload *taprio = emac->qos.tas.taprio_admin;
>>>> +	int ret;
>>>> +
>>>> +	if (taprio->cmd == TAPRIO_CMD_DESTROY)
>>>> +		return tas_set_state(emac, TAS_STATE_DISABLE);
>>>> +
>>>> +	if (taprio->cmd != TAPRIO_CMD_REPLACE)
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	ret = tas_update_oper_list(emac);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	return tas_set_state(emac, TAS_STATE_ENABLE);
>>>> +}
>>>> +
>>>> +static void emac_cp_taprio(struct tc_taprio_qopt_offload *from,
>>>> +			   struct tc_taprio_qopt_offload *to)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	*to = *from;
>>>> +	for (i = 0; i < from->num_entries; i++)
>>>> +		to->entries[i] = from->entries[i];
>>>> +}
>>>> +
>>>> +static int emac_setup_taprio(struct net_device *ndev, struct tc_taprio_qopt_offload *taprio)
>>>
>>> Please change this to
>>> 	static int emac_setup_taprio(struct net_device *ndev, void *type_data)
>>>
>>> and later add
>>> 	struct tc_taprio_qopt_offload *taprio = type_data;
>>
>> Sure.
>>
>>>> +{
>>>> +	struct prueth_emac *emac = netdev_priv(ndev);
>>>> +	struct tc_taprio_qopt_offload *est_new;
>>>> +	int ret, idx;
>>>> +
>>>> +	if (!netif_running(ndev)) {
>>>> +		netdev_err(ndev, "interface is down, link speed unknown\n");
>>>> +		return -ENETDOWN;
>>>> +	}
>>>
>>> Do we really need this?
>>>
>>> How about handling the taprio->cmd with a switch statement
>>> and adding helper functions for each case?
>>>
>>
>> emac_set_taprio() is already doing something like this.
>> It only implements TAPRIO_CMD_REPLACE and TAPRIO_CMD_DESTROY. Others are
>> not supported.
>>
>> static int emac_set_taprio(struct prueth_emac *emac)
>> {
>> 	struct tc_taprio_qopt_offload *taprio = emac->qos.tas.taprio_admin;
>> 	int ret;
>>
>> 	if (taprio->cmd == TAPRIO_CMD_DESTROY)
>> 		return tas_set_state(emac, TAS_STATE_DISABLE);
>>
>> 	if (taprio->cmd != TAPRIO_CMD_REPLACE)
>> 		return -EOPNOTSUPP;
>>
>> 	ret = tas_update_oper_list(emac);
>> 	if (ret)
>> 		return ret;
>>
>> 	return tas_set_state(emac, TAS_STATE_ENABLE);
>> }
>>
>> emac_setup_taprio() is first doing all the neccessary check and then
>> calling emac_set_taprio(), which actually perform actions based on the
>> taprio->cmd. I think I'll keep this as it is.
> 
> OK but pleae at least use switch statement in emac_set_taprio()
> and error out in default: case.
> 

Sure. I'll do that.

>>
>>> So emac_setup_taprio() reduces to
>>>
>>> static int emac_setup_taprio(struct net_device *ndev, void *type_data)
>>> {
>>> 	struct tc_taprio_qopt_offload *taprio = type_data;
>>> 	int err = 0;
>>>
>>>         switch (taprio->cmd) {
>>>         case TAPRIO_CMD_REPLACE:
>>>                 err = emac_taprio_replace(ndev, taprio);
>>>                 break;
>>>         case TAPRIO_CMD_DESTROY:
>>>                 emac_taprio_destroy(ndev);
>>>                 break;
>>>         case TAPRIO_CMD_STATS:
>>>                 emac_taprio_stats(ndev, &taprio->stats);
>>>                 break;
>>>         case TAPRIO_CMD_QUEUE_STATS:
>>>                 emac_taprio_queue_stats(ndev, &taprio->queue_stats);
>>>                 break;
>>>         default:
>>>                 err = -EOPNOTSUPP;
>>>         }
>>>
>>> 	return err;
>>> }
>>>
> 

-- 
Thanks and Regards,
Md Danish Anwar
