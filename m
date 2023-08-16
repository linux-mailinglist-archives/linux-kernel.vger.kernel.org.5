Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C1777E138
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244990AbjHPMNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243258AbjHPMNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:13:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308382132;
        Wed, 16 Aug 2023 05:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQOSrN2SJU63NEKC5QMDmYdgkNi9esl2geFkNeHPJBAVTvZucemUWZ3gSybZ4d27QBCxUAPj50QzHnfED7z9AXlC0t7SlOdHH5uyNeoXPxi9Um3WOd+D5kJYnb7KGO2qBmB0xK6bGXa7U4IA2VQDRXyWAMVFhok+BQ2QPixX5L4+rorQgIVmbA78dAFxKA/Ubs6HX6+1oF0WPzb3duxJHL/VYjGYafqpZx+Y2iUQXAi9bjAUIOiBDZFDD28JeK+6Vsq+57W41RPdSCy8m3Wf6i0xNkvuwRY8UrlnvizTBjrPDtirMITC4jprKtgV9owK8QE72SWT4GrRpmDPvj2JTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIYXHa11nGr9qqGHNO2hDtng8UZByaM/A2hba2ZwqqY=;
 b=Cspmi533ljGfRDc/lsH3MRYV7apfa9Tt8/51glYI8UjRJJWTPZJJXmgx9h3w/MBUIlbslYZ5aql4yaoc6WCLqeSHhYGqV1PuzyHRji3iaXwf+mv7AOtdnJ3rMJjuV8oepTbAKmvXMZ/p/U9NMUIID+sXyiP6iCAs7k8M8OUD+rJIu/yqXfRUIMfuOA7+6hKYeGP/DW05z2Mpue2ffuuIf30Im0rsra51xd3QTQMJUydnlQW5+oGSEutqGQElCVFKG2Ozz6wagxTL1bBusWg7PQwpa21CFI6lmRYr0JUcdr1QHybxucey5HyipoJ0u6RYpYEdaqgvVweGvz1zQeEHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIYXHa11nGr9qqGHNO2hDtng8UZByaM/A2hba2ZwqqY=;
 b=AA16wltVNtk9bpUBX+g/NnbdUHE6njKijt/zZRPRSKkMJ+KLYkyPeRZ8sPYkhcAnHdu5wnEuNI3HkrE+gJVqEjhLWZaHB/l5MX6m1ZTdQEntQjlpzZXLx221HxgVezbofqbT/zjUbkMkrf/a0SmajIlE/KVQ2JVaGLgeBqTGJMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 12:13:10 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 12:13:10 +0000
Date:   Wed, 16 Aug 2023 15:13:05 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload
 in channel mode
Message-ID: <20230816121305.5dio5tk3chge2ndh@skbuf>
References: <20230815082105.24549-1-rogerq@kernel.org>
 <20230815082105.24549-1-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815082105.24549-1-rogerq@kernel.org>
 <20230815082105.24549-1-rogerq@kernel.org>
X-ClientProxiedBy: AS4P191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::13) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7eb77d-54cc-432e-3d83-08db9e522825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXYIumC4jFOcRTOycLhP87a8QQjdvEE7aw9YtbQsvceBsnTe6yqo7C5RKtLDAV2JYkbI9LMmZVgKGHgjrePqndlF0f7obG+OSqL5svJrOIsRr1bswvWcGwMU8FwchTFhMc660vtxfQLqmPExAT9psJUmD/bEcs2mBZtHZZDsovaequOiTP8t3lMZneVU1dh1g9shF/j1MnR1hfDr5ZR9ftxDGZ0HBmdt5cACC6uxWhcqETcFqS1h+j8ADVIO7CPz6LhM+gUGkLJ6xpyNKsZIxKVDRN9PeEoMrLYIuD7Kg78igMm8MCS1Wnbo1URxsDJimIr++AhL+CNhG0mly0ycx20BSEtO2B05p978428a0zrp6w0gQ4boGAwNmV/xkGuStQVHwqI1o04VO1oPMEdwsEdZ6YC/Sm3rL52c6uEFrsTXKh31D10TUnkyFSwb6z67th65/s5sfgshTpBjn+JtgNsoFtWLBjtWxcbrfufkje9rccG/q++jvyWpABpAVeap1paaiGNcUZcTwsdwKquOaPgZgM0qwDlzJHiR4ydq7Pzl3DcyGGUFyZrPfD8rkKMY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(8676002)(4326008)(8936002)(33716001)(66899024)(30864003)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(9686003)(6512007)(6506007)(6666004)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hwzEROBKvDcUTDsi3Sp+bOCabK98fZ3Zx3TaIJPIP9NtXs/CT+bzWc/7JxTj?=
 =?us-ascii?Q?keM63myWZPbzDK1gCkvnIYbi5U1eLB6/+kX1d0IUX4ZJiTSZS0Pc6OfpJtBD?=
 =?us-ascii?Q?KF/riCmRu+BqpUkkBqjVGBdlgFffpZv8Tmv5NLfwiQ4fZ9e7lqC3ld8LuMfi?=
 =?us-ascii?Q?HdvNsMHVgAwZ7DmytWJ4qdnT8zjI2lHg4xyPglK6fRfRlhAis3Z/fFfZxjFM?=
 =?us-ascii?Q?8hgFgiOTdPIPhX/Nz7ZQ0PnuXg2v2f2i4w6xKJZ92g/sfXEgoXcdUy3/PqIi?=
 =?us-ascii?Q?lacK1x45ym7zYL9iAc4RC/wA8KLPyMKp6+5+5nomNHLC3vi9EMFREJRV1Qk1?=
 =?us-ascii?Q?kJUmZEXHoa3Oy8lQ9g3pXofgUlFZrlQ9XFxDS0ybLoRQgic5azyybtndhZJn?=
 =?us-ascii?Q?lOGG7nx0RKYqI/rkuh5tvgbXlvMdSeoz6cvOcZdglMo6RD0wTjnpTxaBafUz?=
 =?us-ascii?Q?8Jf0egg+YbUTaInyoDc7JBXVp2vP5i+G2ujl7RQ3RouUF1WJZ8Z2wQtVhmI8?=
 =?us-ascii?Q?FHyBOcgJ4Q2QxTFDoeTiSWZWCJHy16W+JtTQXmHbRuJpS1mENDxIvWnGrEHo?=
 =?us-ascii?Q?/TUJaQJk7YihKjXnGlAiVZ/xIoSfMGQuINUxujFvS1z78Nn+h8n3iUZYgO3i?=
 =?us-ascii?Q?7DRmlEugfCBx5NuaILDjFDGRusAG197cVoj2jycYkfzqRwioK3GVlBFqo2XJ?=
 =?us-ascii?Q?yKE/K6f1RHJxb2F2n7zDN8enUjPy/0hb9MZPXRf25oZ5maUFI2uTMTN+trX6?=
 =?us-ascii?Q?Jyus+DVNrcP6J4fyyoOQRQNxaxslUhHo96qqRCechHtp+P4JXg4Gz+gqP+7q?=
 =?us-ascii?Q?Oez2q162TCloknFVtbIfm0T4B240kzjTYkJH/99QQaQJyeZMWwlP/wUII+l3?=
 =?us-ascii?Q?PCaMlTbT4W0BqkWe/0AdBT28edEd+B4zcug81qqcTGUK1Bax4m/WT7E7F8ij?=
 =?us-ascii?Q?xRIUOwgvbLzuC2pUXpG/CTu8qihk2ztX3cYJ3zmS7PV1emdbXZoKuLVLi6wo?=
 =?us-ascii?Q?inAvwPsdbvhJDKBBSprQtrhqusFztP7lwtKSkhvImkJ2GyzOUQJcBhw+ho1D?=
 =?us-ascii?Q?oswLcN8gIyZmAopXDSwsDfWDjeOIkIrTwuHbU7W29U53vZgPxwdF4EpnuxLL?=
 =?us-ascii?Q?IxtQQEOPHzx/7Uq1biENbS7sMaJzdhBIGgZHBQkZFdkmXCp67B2xsHJxSS9f?=
 =?us-ascii?Q?88xjsqFCC+5C+DiG2XjZ5CDVKVcwm2Dcm0Z2nJHonQrlumuihe57UOrVtF47?=
 =?us-ascii?Q?eiHiugxjOpOVG1piTzFpukSdXgIYW1uYqDqwyoeBbk2aacquBP7EbJOaWMnH?=
 =?us-ascii?Q?0Veu0jShAZ3Pl1Fgs2OAXBbfvxZkaO50AL0o5L7oOoDPQV3BOQzzVVX75rhI?=
 =?us-ascii?Q?iRZpUsymu8DxDtEY9QzQXzwE+n02xXfbgsoSTD6qUAjpGVfGTAMcqYIhwecu?=
 =?us-ascii?Q?j+9wx+k7uYvjeNtsV5J/kY9uZjF/4Aety/YYM0eSrlZs6H7vUg+8OIgp3Aua?=
 =?us-ascii?Q?5EkqOuOzwdgXmOOx2pDAyW4G2eNQ4XJXyUB5TDC4IZob+4WXsbx8xIn1F9kZ?=
 =?us-ascii?Q?/HqNDgB8J7dTf5RdRb0+PkTlLrnOejwkcb5TQEYOQW+kYYCzG0kk4H/DJHaX?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7eb77d-54cc-432e-3d83-08db9e522825
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:13:10.3035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRJvR3yp0ZxFtLEdt3sgRpZ3SFozaIwXkwJkmlpY5j/2M1YUExvHTpetHBxGvhfZaLMezzqyruZFDtSiRDRvDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:21:05AM +0300, Roger Quadros wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> This patch adds MQPRIO Qdisc offload in full 'channel' mode which allows
> not only setting up pri:tc mapping, but also configuring TX shapers on
> external port FIFOs. The K3 CPSW MQPRIO Qdisc offload is expected to work
> with VLAN/priority tagged packets. Non-tagged packets have to be mapped
> only to TC0.

You are talking about the forwarding path (RX QoS classification) here?

For the local termination path, TX queue selection should be independent
of VLAN PCP, correct? I see am65_cpsw_nuss_ndo_slave_xmit() looks at
skb_get_queue_mapping(), which should be set correctly by netdev_core_pick_tx(),
based on netdev_get_prio_tc_map(dev, skb->priority). Do the queues/channels
selected by the xmit procedure have their own priority? I.e. if an
application uses the SO_PRIORITY API but doesn't use VLAN PCP, the TX
queue selection done by the driver will still prioritize its traffic as
it should?

Side note: for customizing the RX QoS classification, my understanding
is that you can use the dcbnl app priority table to modify the
port-default QoS class to a value other than 0 (among other stuff).

I see some rx_prio_map handling in am65_cpsw_qos_mqprio_init(), and it's
not clear at all to me that tc-mqprio should ever affect RX prioritization.

> 
> - TX traffic classes must be rated starting from TC that has highest
> priority and with no gaps
> - Traffic classes are used starting from 0, that has highest priority

TC0 has highest priority?

> - min_rate defines Committed Information Rate (guaranteed)
> - max_rate defines Excess Information Rate (non guaranteed) and offloaded
> as (max_rate[i] - tcX_min_rate[i])
> - VLAN/priority tagged packets mapped to TC0 will exit switch with VLAN tag
> priority 0
> 
> The configuration example:
>  ethtool -L eth1 tx 5
>  ethtool --set-priv-flags eth1 p0-rx-ptype-rrobin off
> 
>  tc qdisc add dev eth1 parent root handle 100: mqprio num_tc 3 \
>  map 0 0 1 2 0 0 0 0 0 0 0 0 0 0 0 0 \
>  queues 1@0 1@1 1@2 hw 1 mode channel \
>  shaper bw_rlimit min_rate 0 100mbit 200mbit max_rate 0 101mbit 202mbit
> 
>  tc qdisc replace dev eth2 handle 100: parent root mqprio num_tc 1 \
>  map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 hw 1
> 
>  ip link add link eth1 name eth1.100 type vlan id 100
>  ip link set eth1.100 type vlan egress 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> 
> In the above example two ports share the same TX CPPI queue 0 for low
> priority traffic. 3 traffic classes are defined for eth1 and mapped to:
> TC0 - low priority, TX CPPI queue 0 -> ext Port 1 fifo0, no rate limit
> TC1 - prio 2, TX CPPI queue 1 -> ext Port 1 fifo1, CIR=100Mbit/s, EIR=1Mbit/s
> TC2 - prio 3, TX CPPI queue 2 -> ext Port 1 fifo2, CIR=200Mbit/s, EIR=2Mbit/s
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c |   3 +
>  drivers/net/ethernet/ti/am65-cpsw-qos.c  | 295 ++++++++++++++++++++++-
>  drivers/net/ethernet/ti/am65-cpsw-qos.h  |  14 ++
>  3 files changed, 311 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index bebcfd5e6b57..fc5810ae803a 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -632,6 +632,9 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
>  	/* restore vlan configurations */
>  	vlan_for_each(ndev, cpsw_restore_vlans, port);
>  
> +	/* Initialize QoS */
> +	am65_cpsw_qos_mqprio_init(port);
> +
>  	phylink_start(port->slave.phylink);
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> index eced87fa261c..a82ca2e09561 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> @@ -17,9 +17,12 @@
>  
>  #define AM65_CPSW_REG_CTL			0x004
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
> @@ -56,6 +59,12 @@ enum timer_act {
>  	TACT_SKIP_PROG,		/* just buffer can be updated */
>  };
>  
> +/* number of traffic classes (FIFOs) per port */
> +#define AM65_CPSW_PN_TC_NUM			8
> +#define AM65_CPSW_PN_TX_PRI_MAP_DEFAULT		0x76543210
> +
> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data);

Can you avoid forward declarations?

> +
>  static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
>  {
>  	return port->qos.est_oper || port->qos.est_admin;
> @@ -541,7 +550,6 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
>  	ktime_t cur_time;
>  	s64 delta;
>  
> -	port->qos.link_speed = link_speed;
>  	if (!am65_cpsw_port_est_enabled(port))
>  		return;
>  
> @@ -795,6 +803,8 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  		return am65_cpsw_tc_query_caps(ndev, type_data);
>  	case TC_SETUP_QDISC_TAPRIO:
>  		return am65_cpsw_setup_taprio(ndev, type_data);
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return am65_cpsw_setup_mqprio(ndev, type_data);
>  	case TC_SETUP_BLOCK:
>  		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
>  	default:
> @@ -802,10 +812,15 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  	}
>  }
>  
> +static void am65_cpsw_tx_pn_shaper_link_up(struct am65_cpsw_port *port);
> +
>  void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
>  {
>  	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>  
> +	port->qos.link_speed = link_speed;
> +	am65_cpsw_tx_pn_shaper_link_up(port);
> +
>  	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>  		return;
>  
> @@ -937,3 +952,281 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
>  		       host->port_base + AM65_CPSW_PN_REG_PRI_CIR(tx_ch));
>  	}
>  }
> +
> +static void am65_cpsw_tx_pn_shaper_apply(struct am65_cpsw_port *port)
> +{
> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
> +	struct am65_cpsw_common *common = port->common;
> +	struct tc_mqprio_qopt_offload *mqprio;
> +	bool shaper_en;
> +	u32 rate_mbps;
> +	int i;
> +
> +	mqprio = &p_mqprio->mqprio_hw;
> +	shaper_en = p_mqprio->shaper_en && !p_mqprio->shaper_susp;
> +
> +	for (i = 0; i < mqprio->qopt.num_tc; i++) {
> +		rate_mbps = 0;
> +		if (shaper_en) {
> +			rate_mbps = mqprio->min_rate[i] * 8 / 1000000;
> +			rate_mbps = am65_cpsw_qos_tx_rate_calc(rate_mbps,
> +							       common->bus_freq);
> +		}
> +
> +		writel(rate_mbps,
> +		       port->port_base + AM65_CPSW_PN_REG_PRI_CIR(i));
> +	}
> +
> +	for (i = 0; i < mqprio->qopt.num_tc; i++) {

No need for 2 loops?

> +		rate_mbps = 0;
> +		if (shaper_en && mqprio->max_rate[i]) {
> +			rate_mbps = mqprio->max_rate[i] - mqprio->min_rate[i];
> +			rate_mbps = rate_mbps * 8 / 1000000;
> +			rate_mbps = am65_cpsw_qos_tx_rate_calc(rate_mbps,
> +							       common->bus_freq);
> +		}
> +
> +		writel(rate_mbps,
> +		       port->port_base + AM65_CPSW_PN_REG_PRI_EIR(i));
> +	}
> +}
> +
> +static void am65_cpsw_tx_pn_shaper_link_up(struct am65_cpsw_port *port)
> +{
> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
> +	struct am65_cpsw_common *common = port->common;
> +	bool shaper_susp = false;
> +
> +	if (!p_mqprio->enable || !p_mqprio->shaper_en)
> +		return;
> +
> +	if (p_mqprio->max_rate_total > port->qos.link_speed)
> +		shaper_susp = true;
> +
> +	if (p_mqprio->shaper_susp == shaper_susp)
> +		return;
> +
> +	if (shaper_susp)
> +		dev_info(common->dev,
> +			 "Port%u: total shaper tx rate > link speed - suspend shaper\n",
> +			 port->port_id);
> +	else
> +		dev_info(common->dev,
> +			 "Port%u: link recover - resume shaper\n",
> +			 port->port_id);
> +
> +	p_mqprio->shaper_susp = shaper_susp;
> +	am65_cpsw_tx_pn_shaper_apply(port);
> +}
> +
> +void am65_cpsw_qos_mqprio_init(struct am65_cpsw_port *port)
> +{
> +	struct am65_cpsw_host *host = am65_common_get_host(port->common);
> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
> +	struct tc_mqprio_qopt_offload *mqprio;
> +	u32 tx_prio_map = 0, rx_prio_map;
> +	int i, fifo;
> +
> +	mqprio = &p_mqprio->mqprio_hw;
> +	rx_prio_map = readl(host->port_base + AM65_CPSW_PN_REG_RX_PRI_MAP);
> +
> +	if (p_mqprio->enable) {
> +		for (i = 0; i < AM65_CPSW_PN_TC_NUM; i++) {
> +			fifo = mqprio->qopt.prio_tc_map[i];
> +			tx_prio_map |= fifo << (4 * i);
> +		}
> +
> +		netdev_set_num_tc(port->ndev, mqprio->qopt.num_tc);
> +		for (i = 0; i < mqprio->qopt.num_tc; i++) {
> +			netdev_set_tc_queue(port->ndev, i,
> +					    mqprio->qopt.count[i],
> +					    mqprio->qopt.offset[i]);

How else do you use the TX queue counts and offsets given by mqprio?
Don't you need to somehow tell the hardware that these TX queues are
configured for traffic class i? I'm not seeing that.

> +			if (!i) {
> +				p_mqprio->tc0_q = mqprio->qopt.offset[i];
> +				rx_prio_map &= ~(0x7 << (4 * p_mqprio->tc0_q));
> +			}
> +		}
> +	} else {
> +		/* restore default configuration */
> +		netdev_reset_tc(port->ndev);
> +		tx_prio_map = AM65_CPSW_PN_TX_PRI_MAP_DEFAULT;

I'm not sure how the default (no mqprio) tx_prio_map works. Local
termination (xmit from Linux) will use a single queue, but forwarding

> +		rx_prio_map |= p_mqprio->tc0_q << (4 * p_mqprio->tc0_q);
> +		p_mqprio->tc0_q = 0;
> +	}
> +
> +	writel(tx_prio_map,
> +	       port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
> +	writel(rx_prio_map,
> +	       host->port_base + AM65_CPSW_PN_REG_RX_PRI_MAP);
> +
> +	am65_cpsw_tx_pn_shaper_apply(port);
> +}
> +
> +static int am65_cpsw_mqprio_verify(struct am65_cpsw_port *port,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	int i;
> +
> +	for (i = 0; i < mqprio->qopt.num_tc; i++) {
> +		unsigned int last = mqprio->qopt.offset[i] +
> +				    mqprio->qopt.count[i];
> +
> +		if (mqprio->qopt.offset[i] >= port->ndev->real_num_tx_queues ||
> +		    !mqprio->qopt.count[i] ||
> +		    last >  port->ndev->real_num_tx_queues)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Set struct tc_mqprio_caps :: validate_queue_counts = true and you don't
need to do this.

> +
> +static int am65_cpsw_mqprio_verify_shaper(struct am65_cpsw_port *port,
> +					  struct tc_mqprio_qopt_offload *mqprio,
> +					  u64 *max_rate)
> +{
> +	struct am65_cpsw_common *common = port->common;
> +	u64 min_rate_total = 0, max_rate_total = 0;
> +	u32 min_rate_msk = 0, max_rate_msk = 0;
> +	bool has_min_rate, has_max_rate;
> +	int num_tc, i;
> +
> +	has_min_rate = !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
> +	has_max_rate = !!(mqprio->flags & TC_MQPRIO_F_MAX_RATE);
> +
> +	if (!has_min_rate && has_max_rate)
> +		return -EOPNOTSUPP;

Please use tc_mqprio_qopt_offload :: extack for error message reporting
(everywhere).

> +
> +	if (!has_min_rate)
> +		return 0;
> +
> +	num_tc = mqprio->qopt.num_tc;
> +
> +	for (i = num_tc - 1; i >= 0; i--) {
> +		u32 ch_msk;
> +
> +		if (mqprio->min_rate[i])
> +			min_rate_msk |= BIT(i);
> +		min_rate_total +=  mqprio->min_rate[i];
> +
> +		if (has_max_rate) {
> +			if (mqprio->max_rate[i])
> +				max_rate_msk |= BIT(i);
> +			max_rate_total +=  mqprio->max_rate[i];
> +
> +			if (!mqprio->min_rate[i] && mqprio->max_rate[i]) {
> +				dev_err(common->dev, "TX tc%d rate max>0 but min=0\n",
> +					i);

Recently, NL_SET_ERR_MSG_FMT was introduced which allows you to keep the
%d formatting.

> +				return -EINVAL;
> +			}
> +
> +			if (mqprio->max_rate[i] &&
> +			    mqprio->max_rate[i] < mqprio->min_rate[i]) {
> +				dev_err(common->dev, "TX tc%d rate min(%llu)>max(%llu)\n",
> +					i, mqprio->min_rate[i],
> +					mqprio->max_rate[i]);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		ch_msk = GENMASK(num_tc - 1, i);
> +		if ((min_rate_msk & BIT(i)) && (min_rate_msk ^ ch_msk)) {
> +			dev_err(common->dev, "TX Min rate limiting has to be enabled sequentially hi->lo tx_rate_msk%x\n",
> +				min_rate_msk);
> +			return -EINVAL;
> +		}
> +
> +		if ((max_rate_msk & BIT(i)) && (max_rate_msk ^ ch_msk)) {
> +			dev_err(common->dev, "TX max rate limiting has to be enabled sequentially hi->lo tx_rate_msk%x\n",
> +				max_rate_msk);
> +			return -EINVAL;
> +		}
> +	}
> +	min_rate_total *= 8;
> +	min_rate_total /= 1000 * 1000;
> +	max_rate_total *= 8;
> +	max_rate_total /= 1000 * 1000;
> +
> +	if (port->qos.link_speed != SPEED_UNKNOWN) {
> +		if (min_rate_total > port->qos.link_speed) {
> +			dev_err(common->dev, "TX rate min exceed %llu link speed %d\n",
> +				min_rate_total, port->qos.link_speed);
> +			return -EINVAL;
> +		}
> +
> +		if (max_rate_total > port->qos.link_speed) {
> +			dev_err(common->dev, "TX rate max exceed %llu link speed %d\n",
> +				max_rate_total, port->qos.link_speed);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	*max_rate = max_t(u64, min_rate_total, max_rate_total);
> +
> +	return 0;
> +}
> +
> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
> +{
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
> +	struct am65_cpsw_common *common = port->common;
> +	struct am65_cpsw_mqprio *p_mqprio;
> +	bool has_min_rate;
> +	int num_tc, ret;
> +	u64 max_rate;
> +
> +	p_mqprio = &port->qos.mqprio;
> +
> +	if (!mqprio->qopt.hw)
> +		goto skip_check;

Will ndo_setup_tc(TC_SETUP_QDISC_MQPRIO) ever get called if mqprio->qopt.hw is 0?
I don't think so:

mqprio_init():

	/* If the mqprio options indicate that hardware should own
	 * the queue mapping then run ndo_setup_tc otherwise use the
	 * supplied and verified mapping
	 */
	if (qopt->hw) {
		err = mqprio_enable_offload(sch, qopt, extack);
		if (err)
			return err;
	} else {
		netdev_set_num_tc(dev, qopt->num_tc);
		for (i = 0; i < qopt->num_tc; i++)
			netdev_set_tc_queue(dev, i,
					    qopt->count[i], qopt->offset[i]);
	}

> +
> +	if (mqprio->mode != TC_MQPRIO_MODE_CHANNEL)
> +		return -EOPNOTSUPP;
> +
> +	num_tc = mqprio->qopt.num_tc;
> +	if (num_tc > AM65_CPSW_PN_TC_NUM)
> +		return -ERANGE;
> +
> +	if ((mqprio->flags & TC_MQPRIO_F_SHAPER) &&
> +	    mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE)
> +		return -EOPNOTSUPP;
> +
> +	ret = am65_cpsw_mqprio_verify(port, mqprio);
> +	if (ret)
> +		return ret;
> +
> +	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio, &max_rate);
> +	if (ret)
> +		return ret;
> +
> +skip_check:
> +	ret = pm_runtime_get_sync(common->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(common->dev);
> +		return ret;
> +	}
> +
> +	if (mqprio->qopt.hw) {
> +		memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
> +		has_min_rate = !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
> +		p_mqprio->enable = 1;
> +		p_mqprio->shaper_en = has_min_rate;
> +		p_mqprio->shaper_susp = !has_min_rate;
> +		p_mqprio->max_rate_total = max_rate;
> +	} else {
> +		unsigned int tc0_q = p_mqprio->tc0_q;

Same comment about qopt.hw: isn't this dead code?

> +
> +		memset(p_mqprio, 0, sizeof(*p_mqprio));
> +		p_mqprio->mqprio_hw.qopt.num_tc = AM65_CPSW_PN_TC_NUM;
> +		p_mqprio->tc0_q = tc0_q;
> +	}
> +
> +	if (!netif_running(ndev))
> +		goto exit_put;
> +
> +	am65_cpsw_qos_mqprio_init(port);
> +
> +exit_put:
> +	pm_runtime_put(common->dev);
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
> index 0cc2a3b3d7f9..247a42788687 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
> @@ -7,8 +7,10 @@
>  
>  #include <linux/netdevice.h>
>  #include <net/pkt_sched.h>
> +#include <net/pkt_cls.h>

mqprio was moved from pkt_cls.h to pkt_sched.h in commit 9adafe2b8546
("net/sched: move struct tc_mqprio_qopt_offload from pkt_cls.h to pkt_sched.h").
I don't think you need pkt_cls.h.

>  
>  struct am65_cpsw_common;
> +struct am65_cpsw_port;
>  
>  struct am65_cpsw_est {
>  	int buf;
> @@ -16,6 +18,16 @@ struct am65_cpsw_est {
>  	struct tc_taprio_qopt_offload taprio;
>  };
>  
> +struct am65_cpsw_mqprio {
> +	struct tc_mqprio_qopt_offload mqprio_hw;
> +	u64 max_rate_total;
> +
> +	unsigned enable:1;
> +	unsigned shaper_en:1;
> +	unsigned shaper_susp:1;
> +	unsigned tc0_q:3;

Sorry, I don't really understand what's the deal with this tc0_q.
Could you explain? It seems to persist in the port's rx_prio_map when
p_mqprio->enable transitions from true to false. But I don't understand
why. Also, part of its handling is dead code, I think.

> +};
> +
>  struct am65_cpsw_ale_ratelimit {
>  	unsigned long cookie;
>  	u64 rate_packet_ps;
> @@ -26,6 +38,7 @@ struct am65_cpsw_qos {
>  	struct am65_cpsw_est *est_oper;
>  	ktime_t link_down_time;
>  	int link_speed;
> +	struct am65_cpsw_mqprio mqprio;
>  
>  	struct am65_cpsw_ale_ratelimit ale_bc_ratelimit;
>  	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
> @@ -35,6 +48,7 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  			       void *type_data);
>  void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
>  void am65_cpsw_qos_link_down(struct net_device *ndev);
> +void am65_cpsw_qos_mqprio_init(struct am65_cpsw_port *port);
>  int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
>  void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
>  
> 
> base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> -- 
> 2.34.1
>
