Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C5E7A639B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjISMrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjISMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:47:40 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21961CF9;
        Tue, 19 Sep 2023 05:47:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmRlHt3NllmAHNzuseIFElhJFPYVKmyqYnJ5zCbu0IYuedNv7MeNER0YlGFjOUhk5XMfYw1470O9imxHd773qFG2I23fgN2OoowacmGAuflcRcDSLgPSuBF9s6wAUavFoEnGFlbaS9iuKfO36xDPfuuRopxcYurhUMuHxuU7mEKVVz3LvjCqGL96LCx3uf60xCMGnkWKhpR/9RfSur2uKLTuzOVxdvFz2miiSgj/MUxfao8ksogy0StyEnnBJv8ELKdL7u217qSdfXbWE4/icnZUk+A7XZkNhq7bemYsalWzh9APER8QQWWARfQLBmcvTbvp/rzUaLFrUl9ErS/KZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smeA2wDTaCCy3NGf38JklHexNDaM0LTI95SzsCywREk=;
 b=gu3dniGULJBXbhZgcXKz4n4QRrri9Nuwet1topLsYgD/3V3LYPvsGWa7TjvNKFZCQWi+JQTGiGP7PIwZK/FVlYKAG6HaCDfROrDNV++8mXnoxHR8+bzXZrSmInSl0ac1Mosd/WyJm+/eRI69P7wm15Ag9a0uG8FPOxoyBi8QHmTO3OYn8u0/EaEp6lupxAfg490S68JUz4RTQEcVGPSeiJgknJbcgDofkDsZZBmNltHkET6ScV4S9AihrT61G295LIBNBF5Od57AJ9mR5jx+0COWKDr8/EoORWFur82JNfcE6HoXBcsJ+otFpRA9UOK5RDu5OGchKfEoJXQ3YEi29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smeA2wDTaCCy3NGf38JklHexNDaM0LTI95SzsCywREk=;
 b=lP7xgXQi/FAFxvY8xDSRaNXf29zljT8LK48bYFVLGu1NHNGBKeFQGbRGBHnkNjroQxML8TRRQP2kFtqjiif6M8AXZQogEtrF8whuf+bAubIsMtGpLjCXxH0NmtLl9boAeeTx4p/hs7/H2MvtI7yA9M6RxgCsKXuG+EPAMUz85/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7964.eurprd04.prod.outlook.com (2603:10a6:10:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 12:47:08 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 12:47:08 +0000
Date:   Tue, 19 Sep 2023 15:47:03 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, s-vadapalli@ti.com,
        srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rogerq@kernel.rog
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw: add mqprio qdisc
 offload in channel mode
Message-ID: <20230919124703.hj2bvqeogfhv36qy@skbuf>
References: <20230918075358.5878-1-rogerq@kernel.org>
 <20230918075358.5878-1-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918075358.5878-1-rogerq@kernel.org>
 <20230918075358.5878-1-rogerq@kernel.org>
X-ClientProxiedBy: AM0PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:208:122::14) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: d07b6f0b-23d7-46fa-806e-08dbb90e88b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2qo2ACcujx6Gxo/PKOnqtUp3i47+eHMn5t7agQ2KMwNyfh98jXTJEvmHBKUSTvKq8O9KkQ/nbDTgpxuuJ6Okh4L23s+jOlswyCz/geXhVvf1dhPXwbSyR5aRQEMV2t033LDg06km2evchVuv+2w1hgQI1dvQh8MFXJTON1pXjtW2GKdRa/Xhymb+xb+oLkk9EBafAtZrzxca0QV9DC523CQd6ILMFEeyLYh94x353VHMK1zXM2aFUL32MWEsi3YuvbXlJiHVEXLf1oMKM3V6bkxykp/muFw6SStj0+C70h0wSz23hSuvLpkIOCLN1YhJ5SKEdGmZP2KAb7gRuKekvdtxI4gm82bMD44EIMo7kL42HBHSbTTJHtykTf/EgZRVoUsBF/cwq/8OGFZafFmMXzYkywcTsGH+hVPUfiu1rsHQsQQl0zenBlbLVKnHSsXEjlOkPhOl5Ui3XGEXmGubsdXDQ/mQ7jCbqt091UYQtoDDTHkYDnJPvXWxxbNtfnNH16h1dRzmsgGlY5GYVVTcI1UVwu6fJcv4iQsY5AvXIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(376002)(39860400002)(1800799009)(186009)(451199024)(6512007)(9686003)(6486002)(6506007)(6666004)(33716001)(83380400001)(86362001)(38100700002)(1076003)(26005)(6916009)(316002)(66476007)(66946007)(41300700001)(66556008)(7416002)(2906002)(44832011)(5660300002)(4326008)(8676002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R9ehzD44wmDyWt8j7zLvAVO4iYc/NfnMLgX0FsjUqNxXKdxOF+Tz6LeQftNb?=
 =?us-ascii?Q?5strc+EVAGoM6wc+dPggNfeJEv8g4MtX6QYEHypxplL5uklM2Lp9e7w44UdZ?=
 =?us-ascii?Q?3hNxlIOa7q/+eSGYsYPCol2087vY9p0jKUmPO0en4odZzb6uoTcz8hlSVY8F?=
 =?us-ascii?Q?dwQPRj/6zWUEH/K2JEWZAL+qY2bjK62uHfTQBPmd5BwRYXmKnrRbTC5OVng2?=
 =?us-ascii?Q?Uh9p+IB61VH9Zf2E40CQJJYmEXXwWUTU4+wbd31R6dkG7IRHyAx0d18p7AhF?=
 =?us-ascii?Q?aAyFfU3/9cBXXfX8qBQzfobolRd6NOa95c3aPb+xyU9INdvO4bxvRKVu+qWX?=
 =?us-ascii?Q?GVQUQ3QvQeAV5zJDt+U1KpSIZEMuYRbY9uxPi/7V82juQSmT/ep2DBBI/l7Z?=
 =?us-ascii?Q?++kB7H/rVacOKMFxTR5JqKyewq8B4o9bH0Ltyp8Wx3rk6/knZNK4LJEcOLeB?=
 =?us-ascii?Q?CCM1XV6VgYIcDwvcKEA/dR/YWsChfKWLgSxiOmFXYCmOQXZTb8O/Yn2iawUl?=
 =?us-ascii?Q?gNEfTuRYKXDvlqZTtsDEqmYwAsOR0NbDPyRDWy8D1SgId/og/ocS7jzsog+y?=
 =?us-ascii?Q?hT5heM5BGk/FOt63tlsThhP+vc5vjSTFNf6MR+flzOPlDvxFkBZOjsLmsp8R?=
 =?us-ascii?Q?7nCsWvmE5vsNU7SIax3+rnbkP66zkYRF7ZEZ88QRtG7HfxiHtkY8MGtXWXec?=
 =?us-ascii?Q?61iQjBJjVdRMX0uLB5F7RGxvPOQsPpaRGmeG369kPGoPRzOMfiNPc1kqvo2Q?=
 =?us-ascii?Q?KYnsZhQBfZqBoQ5ZzZS0N33f0X7VC3WxEkblPX4EQUBgO9gRzB/ESnYdBAoj?=
 =?us-ascii?Q?iOe/jfzBXXMofpn0t57KkRRmynGsoedr9QZNLvtsG+Vm+dEQi0Ja2l8yQsxX?=
 =?us-ascii?Q?+/5x666W/zQJcKu15+uEYxJhXnKI0iMrbE0+r14BXDxUtVwN/ZXfNH9wPOE8?=
 =?us-ascii?Q?q69m+1jIWyN+9DHGLkwkAup9xV/tkmPMYhQq/Tl7ve7qkWbLkncM6rkio6hl?=
 =?us-ascii?Q?9av6iw8QQv7BVCF7Wuw6eyx5bZYwejCc9XSgtOXDjx7tXgU7KPxRRIVNo7RO?=
 =?us-ascii?Q?1fLEMwyDwAaZwjYtTLqBJm9mbRSnZIAqxerYe0LeGCuzWX0CsdKk0BXl2OjO?=
 =?us-ascii?Q?yrqtLuyYYQ3TJG9pJbzPHq/T/DtDsm0WeLpoAYQ3K2ND7Aq1IqJdKeTIOZCm?=
 =?us-ascii?Q?M3lwULJvgEG3hmJ0rh3pKXP3D3vYzqfR8iUKv2waOUXinigNTS2zwyQeuSmK?=
 =?us-ascii?Q?YgYft7VWKKbYYP5zH3EdvesXqChL10SCdkaeUTOaghZT0AJLFVAnNKoJ5S50?=
 =?us-ascii?Q?ZO9R/fCmdd2vx4QqAbIeb9xihVGiMAF1iYaCn/JNEstsrNNNfIV6MYxf80HB?=
 =?us-ascii?Q?qYY6t8Li6CyMqVTWc7lqkqAAPkO4dO5L5Snrf5Kwy+X3+cY0GwH6EDj/+KIp?=
 =?us-ascii?Q?XV+/P/0SO8x05Bnw7GIYQuV/0m4NRJ+VTGVNWYuOzNv5Krmg4RfU6gHKHdmm?=
 =?us-ascii?Q?4VKNSjve8kAz2bC9ZXKDBqnEpGZu2ayUzw4v54OLf/rkBUXoJwZl3WIqjqns?=
 =?us-ascii?Q?g+XhVrUOdIuVYNmAjaGIAUaeR4+J6mMrdY2B4Ou+1YjwXe/EvY1c7BeIbjMH?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07b6f0b-23d7-46fa-806e-08dbb90e88b0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 12:47:08.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dedyi7fhl3rITyaZUCeCFap+w4QxEEEMViaHDiNl1yr7XG4GLpItAEw5JIU6fRoiasfxOF2BW7nePXSjkl/v5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On Mon, Sep 18, 2023 at 10:53:58AM +0300, Roger Quadros wrote:
> -int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
> -			       void *type_data)
> -{
> -	switch (type) {
> -	case TC_QUERY_CAPS:
> -		return am65_cpsw_tc_query_caps(ndev, type_data);
> -	case TC_SETUP_QDISC_TAPRIO:
> -		return am65_cpsw_setup_taprio(ndev, type_data);
> -	case TC_SETUP_BLOCK:
> -		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
> -	default:
> -		return -EOPNOTSUPP;
> -	}
> -}
> -
> -void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
> -{
> -	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> -
> -	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
> -		return;
> -
> -	am65_cpsw_est_link_up(ndev, link_speed);
> -	port->qos.link_down_time = 0;
> -}
> -
> -void am65_cpsw_qos_link_down(struct net_device *ndev)
> -{
> -	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> -
> -	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
> -		return;
> -
> -	if (!port->qos.link_down_time)
> -		port->qos.link_down_time = ktime_get();
> -
> -	port->qos.link_speed = SPEED_UNKNOWN;
> -}
> -

Could you split the code movement to a separate change?

> +	if (port->qos.link_speed != SPEED_UNKNOWN) {
> +		if (min_rate_total > port->qos.link_speed) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack, "TX rate min %llu exceeds link speed %d\n",
> +					       min_rate_total, port->qos.link_speed);
> +			return -EINVAL;
> +		}
> +
> +		if (max_rate_total > port->qos.link_speed) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack, "TX rate max %llu exceeds link speed %d\n",
> +					       max_rate_total, port->qos.link_speed);
> +			return -EINVAL;
> +		}
> +	}

Link speeds can be renegotiated, and the mqprio offload can be installed
while the link is down. So this restriction, while honorable, has limited
usefulness.

> +
> +	p_mqprio->shaper_en = 1;

s/1/true/

> +	p_mqprio->max_rate_total = max_t(u64, min_rate_total, max_rate_total);
> +
> +	return 0;
> +}
> +
> +static void am65_cpsw_reset_tc_mqprio(struct net_device *ndev)
> +{
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
> +	struct am65_cpsw_common *common = port->common;
> +
> +	p_mqprio->shaper_en = 0;

s/0/false/

> +	p_mqprio->max_rate_total = 0;
> +
> +	am65_cpsw_tx_pn_shaper_reset(port);
> +	netdev_reset_tc(ndev);
> +	netif_set_real_num_tx_queues(ndev, common->tx_ch_num);
> +
> +	/* Reset all Queue priorities to 0 */
> +	writel(0,
> +	       port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);

What exactly needs pm_runtime_get_sync()? This writel() doesn't?

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
> +	if (!num_tc) {
> +		am65_cpsw_reset_tc_mqprio(ndev);
> +		return 0;
> +	}
> +
> +	ret = pm_runtime_get_sync(common->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(common->dev);
> +		return ret;
> +	}
