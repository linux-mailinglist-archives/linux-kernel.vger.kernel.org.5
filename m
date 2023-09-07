Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296F3797A66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbjIGRje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245181AbjIGRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:39:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB310DF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:38:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337F7C32789;
        Thu,  7 Sep 2023 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694089398;
        bh=+FPqQmfAEDH5QfVgXOSft5l8Wk2lgGmonNPo5dQtgkk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p6TovHQoK75xbCZAbDXTiuzaPnPDvFNW4ptU5QeWO5JBkYrkm+921EcY0qy57QuRU
         Vml45MUlRp8LJTDSLxIOVicjFwIaxMYE+oFXKbHUua4V1RLjnwxLCBxs+/rhPfltgW
         Q1kCuBvSit25sxc9HcUSzmkM0Rg6Bt0RHxDDtrl5ozG6BiiLqt6REi3k4CAL9n/Ps7
         T1I4LNCimaP5Nca6JL0wofylQZDvH3B/o47M0TAI7aOyDuDpXXf8eKeH/Ytc5mYO9o
         +DE6Yk4VsX3JPF6mLmnc+oJEKSngJhMgSamon8o+ZxJP5znp/B6MGgTGRxEgOnrkiw
         PO7hKnsSEtVHg==
Message-ID: <d492bdeb-6bb6-4891-ba5e-7658a6e5e6ec@kernel.org>
Date:   Thu, 7 Sep 2023 15:23:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 4/4] net: ti: icssg_prueth: add TAPRIO
 offload support
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Simon Horman <horms@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        r-gunasekaran@ti.com
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-5-danishanwar@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230830110847.1219515-5-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/2023 14:08, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@kernel.org>
> 
> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
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
>  drivers/net/ethernet/ti/Makefile             |   3 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   7 +
>  drivers/net/ethernet/ti/icssg/icssg_qos.c    | 294 +++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_qos.h    | 119 ++++++++
>  5 files changed, 426 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
> 
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 3adceff760ce..de348c20eff9 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -38,5 +38,6 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
>  		  icssg/icssg_mii_cfg.o \
>  		  icssg/icssg_stats.o \
>  		  icssg/icssg_ethtool.o \
> -		  icssg/icssg_switchdev.o
> +		  icssg/icssg_switchdev.o \
> +		  icssg/icssg_qos.o
>  obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 5b7e7297ce23..3236af45aa4e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1179,7 +1179,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
>  	return 0;
>  }
>  
> -static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
>  {
>  	u32 hi_rollover_count, hi_rollover_count_r;
>  	struct prueth_emac *emac = clockops_data;
> @@ -1416,6 +1416,8 @@ static int emac_ndo_open(struct net_device *ndev)
>  		napi_enable(&emac->tx_chns[i].napi_tx);
>  	napi_enable(&emac->napi_rx);
>  
> +	icssg_qos_init(ndev);
> +
>  	/* start PHY */
>  	phy_start(ndev->phydev);
>  
> @@ -1695,6 +1697,7 @@ static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
>  	.ndo_eth_ioctl = emac_ndo_ioctl,
>  	.ndo_get_stats64 = emac_ndo_get_stats64,
> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>  };
>  
>  /* get emac_port corresponding to eth_node name */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 6e18da06c786..43b67213d8c7 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -37,6 +37,7 @@
>  #include "icssg_config.h"
>  #include "icss_iep.h"
>  #include "icssg_switch_map.h"
> +#include "icssg_qos.h"
>  
>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>  #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
> @@ -186,6 +187,9 @@ struct prueth_emac {
>  	struct devlink_port devlink_port;
>  	int port_vlan;
>  
> +	struct prueth_qos qos;
> +	struct work_struct ts_work;
> +
>  	struct delayed_work stats_work;
>  	u64 stats[ICSSG_NUM_STATS];
>  };
> @@ -331,4 +335,7 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
>  void emac_stats_work_handler(struct work_struct *work);
>  void emac_update_hardware_stats(struct prueth_emac *emac);
>  int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
> +
> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
> +
>  #endif /* __NET_TI_ICSSG_PRUETH_H */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> new file mode 100644
> index 000000000000..e8102703e257
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Texas Instruments ICSSG PRUETH QoS submodule
> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/

2023 here and rest of series.

> + */
> +
> +#include <linux/printk.h>
> +#include "icssg_prueth.h"
> +#include "icssg_switch_map.h"
> +
> +static void icssg_qos_tas_init(struct net_device *ndev);
> +
> +void icssg_qos_init(struct net_device *ndev)
> +{
> +	icssg_qos_tas_init(ndev);
> +
> +	/* IET init goes here */

Please drop this comment.

> +}
> +

<snip>

-- 
cheers,
-roger
