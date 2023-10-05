Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92A37B9DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjJEN4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbjJENt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:49:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E60E9EC8;
        Thu,  5 Oct 2023 02:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXrny5gwjC7oRa3ZKnx7QtF38pbmSBEK146iNoqvcO55LP0RSv05PiaSImCibkQfwF5jRAC+EO/KpxdllsNsD7vJ4RcW7T57Em6QzZKctXOks9P7ajsF5CMPYGGXjrDE8aeJomRhRl2x/VaBUspxDgRf6N1whobkXv8EXqLgqcSEK7vIVkREf6kS/oizLePlxC4CDC+/W/uqlnMJRABUzbsSGPTxi8NI00sAEwNKDNImAc57vDtrb0dpvC1ZgpkdYiBZYMA+5hNZbPI7vu/IvLKqLI9aw8PDWRXZ43FJKR/3w3S9/0oVpaIf3Fci/Lvuj4tXCVTMvxw3c2xyWZnVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=as6CjNPdjFhaR9yDZqcm58YqT6JzWcue2qV5uFQC9GU=;
 b=B8+E+WFBTj5ZIdaV5I2NlwjBi/UuRRV4LMXY3tqM1OIso7lgeHd/abZ/CyVIlbMhpO0f4nvG5teEgvVGfmvetgAHf7/f3rKQ8osiKbRe9MT/EYlAWheBnbfgRm2FTct2kYcUefjvgpO8Qrjom6RN2a5CunqlU9VRx7Rkj5QkQvEQGhQn7eo5BY1K3eUGyfFpJHqWu4EKjrQVAheVUTgq5NEJI1i9DOFz7bYJhqrwbpzeFIkSOm6p9eskoqXFbYPdH997DEp1wVIyApDg2M3yxixO3zAfKtvVpMZe4hVRYNqUIbfkniEGzdr9zonB3N0Ss0U3gqst/GShegTIfTpSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as6CjNPdjFhaR9yDZqcm58YqT6JzWcue2qV5uFQC9GU=;
 b=W0SkVBkLSwODgBjNn+13IA/fYQajUBhcBKsHVWAQaRbKBWw+MG8acvWmd2ekB60o3ecXGsDaWuSnoCguQe18TSnBpNFQ9iqo55xjNW08n0qznLWHdmMlJpGw1R15ulLR0n2iIU3pPVP/lewVJfBBhaVu25tK6mTK+lH/qvqNPIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB7549.eurprd04.prod.outlook.com (2603:10a6:102:e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 09:01:46 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 09:01:46 +0000
Date:   Thu, 5 Oct 2023 12:01:41 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, s-vadapalli@ti.com,
        srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 2/4] net: ethernet: ti: am65-cpsw: add mqprio
 qdisc offload in channel mode
Message-ID: <20231005090141.bjya2lfarcs3ujhb@skbuf>
References: <20230927072741.21221-1-rogerq@kernel.org>
 <20230927072741.21221-3-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927072741.21221-3-rogerq@kernel.org>
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 1254a4dd-911d-4ba7-50dc-08dbc581b3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7usVn4ig7eV+n2TgKhr0hg7oD/+Ihcp3vNCHLlTbzcJs5oGiTVWTwD6K4tvwc6r7l6dOFGh3aAIznc2FGUsNaDuJ1DTi10cxZ9EkF8pBJH6SNB49qn5ExhJvMvoWRw6lEeoQHE/jn5Ku/XG9UPEbAdn0Vt5WxLjm2vVrlKsIc461r6AsdTsWHPhjwiCclp6W+TduycViXPV58YhrguTuJcMJjQBgk2wiZLPk84Y0JR8sCl2L+BqxGriNQwcz0TANJKGmV8Xhjsj/VELB6kOU2M/u/aLddfNDwqtMbActryt5tAws22cnYAgB9ugpyhZCEe0XoM6xZ2YXqhxvb2MxXHJFv7N0r5DLv1OrEPHxh/Zvju47dI7vhLZwT5VWrN2FD/8N8zpi2YEwk296SIHKTh79cDfp6feNrP6N5QPu0P/uxEyUC4TdzSoP0BmhdhSFJxjFuU+m+y2H8YXr/VUe9vBdSNcpI4BUWzdsG1o3b3FB9A2lKeFvrsnumaHfEsT/HKGClQniN0MKzpF9OGq2BmmVhaLKlLseO5QfxW2n8NJM21vAI9TRITLtGcmZqty5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66556008)(66946007)(316002)(66476007)(1076003)(6506007)(6666004)(9686003)(26005)(6512007)(478600001)(6916009)(6486002)(44832011)(4326008)(41300700001)(5660300002)(8936002)(8676002)(83380400001)(86362001)(7416002)(2906002)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J+irrokrA6kwLsrmqqRYa9uBpdXYIXFBZsQE8NL3X4Lc1BYLFvqTPNizx0XJ?=
 =?us-ascii?Q?UJ35JLk42foZVW4Tm7zPqDiiVZ0FVgsfkTcuJEVFCs9u72lISV0QxMiT7PcJ?=
 =?us-ascii?Q?jgtvyR1rYGQeMAbkpkFQuqHWPY8RKVGUteAltsgeG19OFdmPxLfeENAinu2l?=
 =?us-ascii?Q?cnVhR1sOI3MSu8Cr7VN3acFU3q20n61dk7a/waHfDB/OhJsGituyC7OQIWek?=
 =?us-ascii?Q?ROtxLSLfTjuSF5nGak87CpPoZDZA4Oi4fmI4M/CN3nAXy9DEP1ti5LFl5Nir?=
 =?us-ascii?Q?+kRrown06FfTS71+1Gmp+MYQyXA/gajEa1Z1cMDHLnWHwTy1q5KMzb8g0iIu?=
 =?us-ascii?Q?NzMqMUh0//e/RQmpP0tmPm49TeESusyznnRFbuSj5qYZFu4/B9qdmXH0A28l?=
 =?us-ascii?Q?vlcukrkYrcv2Kcznwimg7arZs6cb+0XyBaMbLMzzcjLXcGQ/O5BOJU/my/39?=
 =?us-ascii?Q?D9rJ/f8ObnR7zzcqU5zlNlJqwYiUOhwXEceElqaSSxeD7f1Tr+2J9L+v6s7e?=
 =?us-ascii?Q?Kwj0tUdSCv3aRI5XGd0cCCSRh6h567OahfRTRL1ivWG/L5M0DfHi/V1rfgzS?=
 =?us-ascii?Q?YPC6V9OE1seTOUPymbWY9fH8FFkK7xQ3a82a/vhXlYIC+jm5GVJ7BnF8rcNo?=
 =?us-ascii?Q?fAa+IPB1w6k/HrFIj1bynEWBxXxcwXkESAF0POLdmwcN9GdkZ7xzC6LOS6DY?=
 =?us-ascii?Q?TmMxFBT3nYJxFgk1RiSy49Q6F6wC37DQ3NL8MUwZ+VMdeP9noeeCREQlwPbI?=
 =?us-ascii?Q?uWs2zMErYwrbYFw9ZaH9+g8aFle9BaVUnww0COHWrrNXrD1PPIhC7Smy03M1?=
 =?us-ascii?Q?d0bFXCwy71dAQx2dQh7Bjll79oBqUaZagaiOxSmsVqbPBXuC2yQTb/PQYZ2R?=
 =?us-ascii?Q?gYN2IBBdhOgyglE8N+dHZe6FhLawIdax8xKjY0qCXVN9syeOUhKjbunGfYHB?=
 =?us-ascii?Q?r78CN5dyqVUaGPZId9PBwXfr1PGqDTMqEVLSgS5A5iWPXvzW1ALTkp77799c?=
 =?us-ascii?Q?mz+LpPHY9h7ma3CPorkRsE2pR2gjORX7GDL1qsLLnMoM7BqOxAxNhgc5GVJM?=
 =?us-ascii?Q?NXHY0rRbcJbykpGbg7nCRA4m6E0ryPGXtI1U36dUKBemBQPniLJn+2cEJd+l?=
 =?us-ascii?Q?/WIzLx9DcpscdMLzwimwhSg5x+0NHr2kWC9DgxYWa7iBWM2OwSWQdhV6gm1F?=
 =?us-ascii?Q?IbjZgh933im2jHnUDWWcPcSPCE/UCgIzJ6BUrX5vBVS6igfq6b/BjaSc/T6T?=
 =?us-ascii?Q?GpDGMiTa+BGVe9XH6Y8UwPjCG5suJ0TIurY9KMvUWtAyN5rKLJcb+OrlT3bp?=
 =?us-ascii?Q?TUyub9WZWgJQxmdehDo9Qsq7hGP+7yoZ1MXkRXvXdc1CyO00gx7rpcqqLu7T?=
 =?us-ascii?Q?f1lI7lJraBC8YKjC7r8mFPctNfSwvKgi6ghzkINDEdt4XBVG7Mt5SEtgtN6q?=
 =?us-ascii?Q?ZiwnM0c1xbRRGO/6CDHub27jplLBCPn0ozHii0tUx8lsttT4AS8Dt6hjJ3w3?=
 =?us-ascii?Q?MVggOLT6y1SNKHgFQJeu2NwgTkWLKcAuucGTs9GKQHLcVTEvVqusSFrAF7e0?=
 =?us-ascii?Q?eLPkvze5CXRsSOv+5xE98ktlIh0OVDTJGQle8jJnLHI+H3hD3W/GokaPASiq?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1254a4dd-911d-4ba7-50dc-08dbc581b3c4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 09:01:46.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LqB1694KRoCu1pa7ylkEeaRnO9B+nquwUBvy4oqA4oRbol9JdMqiTR4zZIpycV1zq/Ubguw80+rVA9cyNKh+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7549
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:27:39AM +0300, Roger Quadros wrote:
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> index f91137d8e73b..991221d8f148 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> @@ -16,10 +16,19 @@
>  #include "cpsw_ale.h"
>  
>  #define AM65_CPSW_REG_CTL			0x004
> +#define AM65_CPSW_P0_REG_TX_PRI_MAP		0x018
> +#define AM65_CPSW_P0_REG_RX_PRI_MAP		0x020
> +#define AM65_CPSW_P0_REG_FIFO_STATUS		0x050
> +#define AM65_CPSW_P0_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
> +#define AM65_CPSW_P0_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
> +
>  #define AM65_CPSW_PN_REG_CTL			0x004
> +#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
> +#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
>  #define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
>  #define AM65_CPSW_PN_REG_EST_CTL		0x060
>  #define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
> +#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
>  
>  /* AM65_CPSW_REG_CTL register fields */
>  #define AM65_CPSW_CTL_EST_EN			BIT(18)
> @@ -50,12 +59,18 @@
>  #define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
>  #define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
>  
> +#define TO_MBPS(x)	((x) * 8 / 1000000)
> +
>  enum timer_act {
>  	TACT_PROG,		/* need program timer */
>  	TACT_NEED_STOP,		/* need stop first */
>  	TACT_SKIP_PROG,		/* just buffer can be updated */
>  };
>  
> +/* number of priority queues per port FIFO */
> +#define AM65_CPSW_PN_FIFO_PRIO_NUM		8
> +#define AM65_CPSW_PN_TX_PRI_MAP_DEFAULT		0x76543210

> +static void am65_cpsw_reset_tc_mqprio(struct net_device *ndev)
> +{
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
> +	struct am65_cpsw_common *common = port->common;
> +
> +	p_mqprio->shaper_en = false;
> +	p_mqprio->max_rate_total = 0;
> +
> +	am65_cpsw_tx_pn_shaper_reset(port);
> +	netdev_reset_tc(ndev);
> +	netif_set_real_num_tx_queues(ndev, common->tx_ch_num);

If this never gets changed from the value set by am65_cpsw_nuss_ndo_slave_open(),
then there is no reason to call netif_set_real_num_tx_queues() here.

> +
> +	/* Reset all Queue priorities to 0 */
> +	writel(0, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);

To 0 or to AM65_CPSW_PN_TX_PRI_MAP_DEFAULT (which is now unused)?
Also, do I understand correctly that immediately after boot, TX_PRI_MAP
will have a different value than after the deletion of the mqprio root qdisc
(if AM65_CPSW_PN_TX_PRI_MAP_DEFAULT represents the hardware default value)?
The behavior needs to be identical in the 2 cases, since both represent
"no mqprio offload".

> +}
> +
> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
> +{
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
> +	struct am65_cpsw_common *common = port->common;
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	int tc, offset, count, ret, prio;
> +	u8 num_tc = qopt->num_tc;
> +	u32 tx_prio_map = 0;
> +	int i;
> +
> +	memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
> +
> +	ret = pm_runtime_get_sync(common->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(common->dev);
> +		return ret;
> +	}
> +
> +	if (!num_tc) {
> +		am65_cpsw_reset_tc_mqprio(ndev);
> +		goto exit_put;
> +	}
> +
> +	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio);
> +	if (ret)
> +		goto exit_put;

At "exit_put" we have "return 0" and this discards the value of "ret".

> +
> +	netdev_set_num_tc(ndev, num_tc);
> +
> +	/* Multiple Linux priorities can map to a Traffic Class
> +	 * A Traffic Class can have multiple contiguous Queues,
> +	 * Queues get mapped to Channels (thread_id),
> +	 *	if not VLAN tagged, thread_id is used as packet_priority
> +	 *	if VLAN tagged. VLAN priority is used as packet_priorit
> +	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
> +	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
> +	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
> +	 * assume that Queue_n gets mapped to header_priority_n. We can then
> +	 * set the switch priority in pn_tx_pri_map.
> +	 */
> +
> +	for (tc = 0; tc < num_tc; tc++) {
> +		prio = tc;
> +
> +		/* For simplicity we assign the same priority (TCn) to
> +		 * all queues of a Traffic Class.
> +		 */
> +		for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++)
> +			tx_prio_map |= prio << (4 * i);
> +
> +		count = qopt->count[tc];
> +		offset = qopt->offset[tc];
> +		netdev_set_tc_queue(ndev, tc, count, offset);
> +	}

I think this is okay.

> +
> +	writel(tx_prio_map,
> +	       port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);

Nit: This can be written on a single line.

> +
> +	am65_cpsw_tx_pn_shaper_apply(port);
> +
> +exit_put:
> +	pm_runtime_put(common->dev);
> +	return 0;
> +}
> +
>  int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  			       void *type_data)
>  {
