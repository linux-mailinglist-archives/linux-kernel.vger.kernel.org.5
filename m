Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762207B3DAA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 04:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjI3ChW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 22:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3ChU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 22:37:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610E5FA;
        Fri, 29 Sep 2023 19:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696041436; x=1727577436;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=EJ0fSS6G21L5wp2Jl78k7/TgDBpfSjHR+DyAXHtcaQI=;
  b=mFF7dLXAmHVHSxaDGvn3mdLNuRMDDWR5+7SwUUxl2NQXrONy6L7YqSNM
   nS/VUBpwep+B7fnXKZXumgswBdeUIKSJVLGhxm3W7LyNMrKpaJKIkzyFs
   fTPDtgPzfoguhZXxTGUJD6eRIGgPmuOss8xSW/nC6C+ayISFpeq/my8IE
   3FlP2Fjhurl1ccOBsP9P7/QoWHItE2DwwVm/wZT0FeAAePR8PMs1HMPO1
   VVxlv8YpzbZXlSfpyEFED/5WdTNpzq6WMtGYLbjMddAcfGoAopyi9Ax+b
   h9TIOkdcggJItVsytFk1mOkeSc0ACBWsxuycggkhnBgnqW5Yn3/pBdp8A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="382327282"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="382327282"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 19:37:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="865907304"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="865907304"
Received: from jinsungk-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.192.47])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 19:37:14 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, vladimir.oltean@nxp.com,
        Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v3] net: ti: icssg_prueth: add TAPRIO offload
 support
In-Reply-To: <20230928103000.186304-1-danishanwar@ti.com>
References: <20230928103000.186304-1-danishanwar@ti.com>
Date:   Fri, 29 Sep 2023 19:37:14 -0700
Message-ID: <87edig4c9x.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MD Danish Anwar <danishanwar@ti.com> writes:

> From: Roger Quadros <rogerq@ti.com>
>
> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST =E2=80=93 de=
fined
> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
> configuration. EST allows express queue traffic to be scheduled
> (placed) on the wire at specific repeatable time intervals. In
> Linux kernel, EST configuration is done through tc command and
> the taprio scheduler in the net core implements a software only
> scheduler (SCH_TAPRIO). If the NIC is capable of EST configuration,
> user indicate "flag 2" in the command which is then parsed by
> taprio scheduler in net core and indicate that the command is to
> be offloaded to h/w. taprio then offloads the command to the
> driver by calling ndo_setup_tc() ndo ops. This patch implements
> ndo_setup_tc() to offload EST configuration to ICSSG.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> Changes from v2 to v3:
> *) Rebased on the latest next-20230828 linux-next.
> *) Retained original authorship of the patch.
> *) Addressed Roger's comments and modified emac_setup_taprio() and
>    emac_set_taprio() APIs accordingly.
> *) Removed netif_running() check from emac_setup_taprio().
> *) Addressed Vinicius' comments and added check for MIN and MAX cycle tim=
e.
> *) Added check for allocation failure of est_new in emac_setup_taprio().
>
> Changes from v1 to v2:
> *) Rebased on the latest next-20230821 linux-next.
> *) Dropped the RFC tag as merge window is open now.
> *) Splitted this patch from the switch mode series [v1].
> *) Removed TODO comment as asked by Andrew and Roger.
> *) Changed Copyright to 2023 as asked by Roger.
>
> v2: https://lore.kernel.org/all/20230921070031.795788-1-danishanwar@ti.co=
m/
> v1: https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.c=
om/
>
>  drivers/net/ethernet/ti/Makefile             |   3 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   6 +
>  drivers/net/ethernet/ti/icssg/icssg_qos.c    | 295 +++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_qos.h    | 124 ++++++++
>  5 files changed, 431 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
>
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/M=
akefile
> index 34fd7a716ba6..0df60ded1b2d 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -37,5 +37,6 @@ icssg-prueth-y :=3D k3-cppi-desc-pool.o \
>  		  icssg/icssg_config.o \
>  		  icssg/icssg_mii_cfg.o \
>  		  icssg/icssg_stats.o \
> -		  icssg/icssg_ethtool.o
> +		  icssg/icssg_ethtool.o \
> +		  icssg/icssg_qos.o
>  obj-$(CONFIG_TI_ICSS_IEP) +=3D icssg/icss_iep.o
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/e=
thernet/ti/icssg/icssg_prueth.c
> index 6635b28bc672..89c301716926 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1166,7 +1166,7 @@ static int emac_phy_connect(struct prueth_emac *ema=
c)
>  	return 0;
>  }
>=20=20
> -static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_tim=
estamp *sts)
> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp =
*sts)
>  {
>  	u32 hi_rollover_count, hi_rollover_count_r;
>  	struct prueth_emac *emac =3D clockops_data;
> @@ -1403,6 +1403,8 @@ static int emac_ndo_open(struct net_device *ndev)
>  		napi_enable(&emac->tx_chns[i].napi_tx);
>  	napi_enable(&emac->napi_rx);
>=20=20
> +	icssg_qos_tas_init(ndev);
> +
>  	/* start PHY */
>  	phy_start(ndev->phydev);
>=20=20
> @@ -1669,6 +1671,7 @@ static const struct net_device_ops emac_netdev_ops =
=3D {
>  	.ndo_set_rx_mode =3D emac_ndo_set_rx_mode,
>  	.ndo_eth_ioctl =3D emac_ndo_ioctl,
>  	.ndo_get_stats64 =3D emac_ndo_get_stats64,
> +	.ndo_setup_tc =3D icssg_qos_ndo_setup_tc,
>  };
>=20=20
>  /* get emac_port corresponding to eth_node name */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/e=
thernet/ti/icssg/icssg_prueth.h
> index 8b6d6b497010..7cbf0e561905 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -37,6 +37,7 @@
>  #include "icssg_config.h"
>  #include "icss_iep.h"
>  #include "icssg_switch_map.h"
> +#include "icssg_qos.h"
>=20=20
>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>  #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
> @@ -174,6 +175,8 @@ struct prueth_emac {
>=20=20
>  	struct pruss_mem_region dram;
>=20=20
> +	struct prueth_qos qos;
> +
>  	struct delayed_work stats_work;
>  	u64 stats[ICSSG_NUM_STATS];
>  };
> @@ -285,4 +288,7 @@ u32 icssg_queue_level(struct prueth *prueth, int queu=
e);
>  void emac_stats_work_handler(struct work_struct *work);
>  void emac_update_hardware_stats(struct prueth_emac *emac);
>  int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
> +
> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp =
*sts);
> +
>  #endif /* __NET_TI_ICSSG_PRUETH_H */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethe=
rnet/ti/icssg/icssg_qos.c
> new file mode 100644
> index 000000000000..95a8b1902879
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Texas Instruments ICSSG PRUETH QoS submodule
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include <linux/printk.h>
> +#include "icssg_prueth.h"
> +#include "icssg_switch_map.h"
> +
> +static void tas_update_fw_list_pointers(struct prueth_emac *emac)
> +{
> +	struct tas_config *tas =3D &emac->qos.tas.config;
> +
> +	if ((readb(tas->active_list)) =3D=3D TAS_LIST0) {
> +		tas->fw_active_list =3D emac->dram.va + TAS_GATE_MASK_LIST0;
> +		tas->fw_shadow_list =3D emac->dram.va + TAS_GATE_MASK_LIST1;
> +	} else {
> +		tas->fw_active_list =3D emac->dram.va + TAS_GATE_MASK_LIST1;
> +		tas->fw_shadow_list =3D emac->dram.va + TAS_GATE_MASK_LIST0;
> +	}
> +}
> +
> +static void tas_update_maxsdu_table(struct prueth_emac *emac)
> +{
> +	struct tas_config *tas =3D &emac->qos.tas.config;
> +	u16 __iomem *max_sdu_tbl_ptr;
> +	u8 gate_idx;
> +
> +	/* update the maxsdu table */
> +	max_sdu_tbl_ptr =3D emac->dram.va + TAS_QUEUE_MAX_SDU_LIST;
> +
> +	for (gate_idx =3D 0; gate_idx < TAS_MAX_NUM_QUEUES; gate_idx++)
> +		writew(tas->max_sdu_table.max_sdu[gate_idx], &max_sdu_tbl_ptr[gate_idx=
]);
> +}
> +
> +static void tas_reset(struct prueth_emac *emac)
> +{
> +	struct tas_config *tas =3D &emac->qos.tas.config;
> +	int i;
> +
> +	for (i =3D 0; i < TAS_MAX_NUM_QUEUES; i++)
> +		tas->max_sdu_table.max_sdu[i] =3D 2048;
> +
> +	tas_update_maxsdu_table(emac);
> +
> +	writeb(TAS_LIST0, tas->active_list);
> +
> +	memset_io(tas->fw_active_list, 0, sizeof(*tas->fw_active_list));
> +	memset_io(tas->fw_shadow_list, 0, sizeof(*tas->fw_shadow_list));
> +}
> +
> +static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
> +{
> +	struct tas_config *tas =3D &emac->qos.tas.config;
> +	int ret;
> +
> +	if (tas->state =3D=3D state)
> +		return 0;
> +
> +	switch (state) {
> +	case TAS_STATE_RESET:
> +		tas_reset(emac);
> +		ret =3D emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
> +		tas->state =3D TAS_STATE_RESET;
> +		break;
> +	case TAS_STATE_ENABLE:
> +		ret =3D emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
> +		tas->state =3D TAS_STATE_ENABLE;
> +		break;
> +	case TAS_STATE_DISABLE:
> +		ret =3D emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
> +		tas->state =3D TAS_STATE_DISABLE;
> +		break;
> +	default:
> +		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	if (ret)
> +		netdev_err(emac->ndev, "TAS set state failed %d\n", ret);
> +	return ret;
> +}
> +
> +static int tas_set_trigger_list_change(struct prueth_emac *emac)
> +{
> +	struct tc_taprio_qopt_offload *admin_list =3D emac->qos.tas.taprio_admi=
n;
> +	struct tas_config *tas =3D &emac->qos.tas.config;
> +	struct ptp_system_timestamp sts;
> +	u32 change_cycle_count;
> +	u32 cycle_time;
> +	u64 base_time;
> +	u64 cur_time;
> +
> +	if (admin_list->cycle_time < TAS_MIN_CYCLE_TIME)
> +		return -EINVAL;
> +
> +	cycle_time =3D admin_list->cycle_time - 4; /* -4ns to compensate for IE=
P wraparound time */
> +	base_time =3D admin_list->base_time;
> +	cur_time =3D prueth_iep_gettime(emac, &sts);
> +
> +	if (base_time > cur_time)
> +		change_cycle_count =3D DIV_ROUND_UP_ULL(base_time - cur_time, cycle_ti=
me);
> +	else
> +		change_cycle_count =3D 1;
> +
> +	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
> +	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUN=
T);
> +	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
> +
> +	/* config_change cleared by f/w to ack reception of new shadow list */
> +	writeb(1, &tas->config_list->config_change);
> +	/* config_pending cleared by f/w when new shadow list is copied to acti=
ve list */
> +	writeb(1, &tas->config_list->config_pending);
> +
> +	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
> +}
> +
> +static int tas_update_oper_list(struct prueth_emac *emac)
> +{
> +	struct tc_taprio_qopt_offload *admin_list =3D emac->qos.tas.taprio_admi=
n;
> +	struct tas_config *tas =3D &emac->qos.tas.config;
> +	u32 tas_acc_gate_close_time =3D 0;
> +	u8 idx, gate_idx, val;
> +	int ret;
> +
> +	if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)
> +		return -EINVAL;
> +
> +	tas_update_fw_list_pointers(emac);
> +
> +	for (idx =3D 0; idx < admin_list->num_entries; idx++) {
> +		writeb(admin_list->entries[idx].gate_mask,
> +		       &tas->fw_shadow_list->gate_mask_list[idx]);
> +		tas_acc_gate_close_time +=3D admin_list->entries[idx].interval;
> +
> +		/* extend last entry till end of cycle time */
> +		if (idx =3D=3D admin_list->num_entries - 1)
> +			writel(admin_list->cycle_time,
> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
> +		else
> +			writel(tas_acc_gate_close_time,
> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
> +	}
> +
> +	/* clear remaining entries */
> +	for (idx =3D admin_list->num_entries; idx < TAS_MAX_CMD_LISTS; idx++) {
> +		writeb(0, &tas->fw_shadow_list->gate_mask_list[idx]);
> +		writel(0, &tas->fw_shadow_list->win_end_time_list[idx]);
> +	}
> +
> +	/* update the Array of gate close time for each queue in each window */
> +	for (idx =3D 0 ; idx < admin_list->num_entries; idx++) {
> +		/* On Linux, only PRUETH_MAX_TX_QUEUES are supported per port */
> +		for (gate_idx =3D 0; gate_idx < PRUETH_MAX_TX_QUEUES; gate_idx++) {
> +			u8 gate_mask_list_idx =3D readb(&tas->fw_shadow_list->gate_mask_list[=
idx]);
> +			u32 gate_close_time =3D 0;
> +
> +			if (gate_mask_list_idx & BIT(gate_idx))
> +				gate_close_time =3D readl(&tas->fw_shadow_list->win_end_time_list[id=
x]);
> +
> +			writel(gate_close_time,
> +			       &tas->fw_shadow_list->gate_close_time_list[idx][gate_idx]);
> +		}
> +	}
> +
> +	/* tell f/w to swap active & shadow list */
> +	ret =3D tas_set_trigger_list_change(emac);
> +	if (ret) {
> +		netdev_err(emac->ndev, "failed to swap f/w config list: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait for completion */
> +	ret =3D readb_poll_timeout(&tas->config_list->config_change, val, !val,
> +				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
> +	if (ret) {
> +		netdev_err(emac->ndev, "TAS list change completion time out\n");
> +		return ret;
> +	}
> +
> +	tas_update_fw_list_pointers(emac);
> +
> +	return 0;
> +}
> +
> +static int emac_set_taprio(struct prueth_emac *emac)
> +{
> +	struct tc_taprio_qopt_offload *taprio =3D emac->qos.tas.taprio_admin;
> +	int ret;
> +
> +	switch (taprio->cmd) {
> +	case TAPRIO_CMD_DESTROY:
> +		ret =3D tas_set_state(emac, TAS_STATE_DISABLE);
> +		break;
> +	case TAPRIO_CMD_REPLACE:
> +		ret =3D tas_update_oper_list(emac);
> +		if (ret)
> +			return ret;
> +		ret =3D  tas_set_state(emac, TAS_STATE_ENABLE);

Double space here.

> +		break;
> +	default:
> +		ret =3D -EOPNOTSUPP;
> +	}
> +
> +	return ret;
> +}
> +
> +static void emac_cp_taprio(struct tc_taprio_qopt_offload *from,
> +			   struct tc_taprio_qopt_offload *to)
> +{
> +	int i;
> +
> +	*to =3D *from;
> +	for (i =3D 0; i < from->num_entries; i++)
> +		to->entries[i] =3D from->entries[i];
> +}
> +
> +static int emac_setup_taprio(struct net_device *ndev, void *type_data)
> +{
> +	struct tc_taprio_qopt_offload *taprio =3D type_data;
> +	struct prueth_emac *emac =3D netdev_priv(ndev);
> +	struct tc_taprio_qopt_offload *est_new;
> +	int ret, idx;
> +
> +	if (taprio->cycle_time_extension) {
> +		netdev_err(ndev, "Failed to set cycle time extension");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (taprio->num_entries =3D=3D 0 ||
> +	    taprio->num_entries > TAS_MAX_CMD_LISTS) {
> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "unsupported num_entries %ld in=
 taprio config\n",
> +				       taprio->num_entries);
> +		return -EINVAL;
> +	}
> +
> +	/* If any time_interval is 0 in between the list, then exit */
> +	for (idx =3D 0; idx < taprio->num_entries; idx++) {
> +		if (taprio->entries[idx].interval =3D=3D 0) {
> +			NL_SET_ERR_MSG_MOD(taprio->extack, "0 interval in taprio config not s=
upported\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (emac->qos.tas.taprio_admin)
> +		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
> +
> +	est_new =3D devm_kzalloc(&ndev->dev,
> +			       struct_size(est_new, entries, taprio->num_entries),
> +			       GFP_KERNEL);
> +	if (!est_new)
> +		return -ENOMEM;
> +
> +	emac_cp_taprio(taprio, est_new);
> +	emac->qos.tas.taprio_admin =3D est_new;
> +	ret =3D emac_set_taprio(emac);

This looks weird. I am thinking about the case that taprio->cmd is
'_DESTROY', the validation that you do will fail, and it will return
-EINVAL, right? Am I missing something?

I was expecting to see something similar to what is done in
emac_set_taprio() here before the validation.

> +	if (ret)
> +		devm_kfree(&ndev->dev, est_new);

Also, in case of error, 'tas.taprio_admin' has an already freed pointer,
and it's possible that you will try to free it again.

> +
> +	return ret;
> +}
> +
> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type t=
ype,
> +			   void *type_data)
> +{
> +	switch (type) {
> +	case TC_SETUP_QDISC_TAPRIO:
> +		return emac_setup_taprio(ndev, type_data);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +void icssg_qos_tas_init(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac =3D netdev_priv(ndev);
> +	bool need_setup =3D false;
> +	struct tas_config *tas;
> +
> +	tas =3D &emac->qos.tas.config;
> +
> +	if (tas->state =3D=3D TAS_STATE_ENABLE)
> +		need_setup =3D true;
> +
> +	tas->config_list =3D emac->dram.va + TAS_CONFIG_CHANGE_TIME;
> +	tas->active_list =3D emac->dram.va + TAS_ACTIVE_LIST_INDEX;
> +
> +	tas_update_fw_list_pointers(emac);
> +
> +	tas_set_state(emac, TAS_STATE_RESET);
> +
> +	if (need_setup)
> +		emac_set_taprio(emac);
> +}
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethe=
rnet/ti/icssg/icssg_qos.h
> new file mode 100644
> index 000000000000..c3d455adc0f8
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#ifndef __NET_TI_ICSSG_QOS_H
> +#define __NET_TI_ICSSG_QOS_H
> +
> +#include <linux/atomic.h>
> +#include <linux/netdevice.h>
> +#include <net/pkt_sched.h>
> +
> +/**
> + * Maximum number of gate command entries in each list.
> + */
> +#define TAS_MAX_CMD_LISTS   (16)
> +
> +/**
> + * Maximum number of transmit queues supported by implementation
> + */
> +#define TAS_MAX_NUM_QUEUES  (8)
> +
> +/**
> + * Minimum cycle time supported by implementation (in ns)
> + */
> +#define TAS_MIN_CYCLE_TIME  (1000000)
> +
> +/**
> + * Minimum cycle time supported by implementation (in ns)
> + */
> +#define TAS_MAX_CYCLE_TIME  (4000000000)
> +
> +/**
> + * Minimum TAS window duration supported by implementation (in ns)
> + */
> +#define TAS_MIN_WINDOW_DURATION  (10000)
> +
> +/**
> + * List number 0 or 1. Also the value at memory location TAS_ACTIVE_LIST=
_INDEX
> + */
> +enum tas_list_num {
> +	TAS_LIST0 =3D 0,
> +	TAS_LIST1 =3D 1
> +};
> +
> +/**
> + * state of TAS in f/w
> + */
> +enum tas_state {
> +	/* PRU's are idle */
> +	TAS_STATE_DISABLE =3D 0,
> +	/* Enable TAS */
> +	TAS_STATE_ENABLE =3D 1,
> +	/* Firmware will reset the state machine */
> +	TAS_STATE_RESET =3D 2,
> +};
> +
> +/**
> + * Config state machine variables. See IEEE Std 802.1Q-2018 8.6.8.4
> + */
> +struct tas_config_list {
> +	/* New list is copied at this time */
> +	u64 config_change_time;
> +	/* config change error counter, incremented if
> +	 * admin->BaseTime < current time and TAS_enabled is true
> +	 */
> +	u32 config_change_error_counter;
> +	/* True if list update is pending */
> +	u8 config_pending;
> +	/* Set to true when application trigger updating of admin list
> +	 * to active list, cleared when configChangeTime is updated
> +	 */
> +	u8 config_change;
> +};
> +
> +/**
> + * Max SDU table. See IEEE Std 802.1Q-2018 12.29.1.1
> + */
> +struct tas_max_sdu_table {
> +	u16 max_sdu[TAS_MAX_NUM_QUEUES];
> +};
> +
> +/**
> + * TAS List Structure based on firmware memory map
> + */
> +struct tas_firmware_list {
> +	/* window gate mask list */
> +	u8 gate_mask_list[TAS_MAX_CMD_LISTS];
> +	/* window end time list */
> +	u32 win_end_time_list[TAS_MAX_CMD_LISTS];
> +	/* Array of gate close time for each queue in each window */
> +	u32 gate_close_time_list[TAS_MAX_CMD_LISTS][TAS_MAX_NUM_QUEUES];
> +};
> +
> +/**
> + * Main Time Aware Shaper Handle
> + */
> +struct tas_config {
> +	enum tas_state state;
> +	struct tas_max_sdu_table max_sdu_table;
> +	/* Config change variables */
> +	struct tas_config_list __iomem *config_list;
> +	/* Whether list 1 or list 2 is the operating list */
> +	u8 __iomem *active_list;
> +	/* active List pointer, used by firmware */
> +	struct tas_firmware_list __iomem *fw_active_list;
> +	/* shadow List pointer, used by driver */
> +	struct tas_firmware_list __iomem *fw_shadow_list;
> +};
> +
> +struct prueth_qos_tas {
> +	struct tc_taprio_qopt_offload *taprio_admin;
> +	struct tc_taprio_qopt_offload *taprio_oper;
> +	struct tas_config config;
> +};
> +
> +struct prueth_qos {
> +	/* IET data structure goes here */
> +	struct prueth_qos_tas tas;
> +};
> +
> +void icssg_qos_tas_init(struct net_device *ndev);
> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type t=
ype,
> +			   void *type_data);
> +#endif /* __NET_TI_ICSSG_QOS_H */
> --=20
> 2.34.1
>

--=20
Vinicius
