Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4D17F20C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjKTW5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKTW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:56:59 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F45A2;
        Mon, 20 Nov 2023 14:56:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU+uXuMNTS7Bfo7c/C4O7jALHBzr1RPKM94Q00h0lWoPBKT1+BctE5UWt1oPmf7mpZwnXvhULlyBonC+rrADcxPYzupYYZwfkdmkp2E/6tAQbxkSJilcVxJJ0dPEs98Fn66p+H3RYXE6Db3f5YbfybcuIsSStUP5BgzsGd9DFka8zHQhKGeIS5q3hBHakM/x2HCdoG6oIQ939A4XJvAj965Ok4RP5iL8aTZ6nB0kl9fVuBiQU4mQY7oN+aB0mdcsizw0O4LTCp6GKFHfo8OxALX+N4Eqq1GdiWSypEqWw6w9yC8VKs6XamukhH9jAKoMm5I8BUncGB2b/dqNLxAWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe+Ib5eJbqiN4vt6qRW3d77brRqvq0EcetFZGQk6rNI=;
 b=MQayQxpfLehBFv5e1RM6MueyIorriAI+IaRrVs35WFKOvFkhKpA9j7GXAqHhDJMRMOqwSc5/v4Y5WTBKeLIJgOkmYrhniWp6mM7unKEn9a8gkDk45/rtGOyr+xvruaZJg5awqbaC3fOESxHL/9/ZI10g9pr7PqdqfgTXU9+ZKMnAwyqSjg9gS83tO7xhpPjmULOf2lLgAmu0oPG8nbOMR/ZGbPaFq7e0ZcAnfgevpHgIDo9p15RsDDNh263QIlyesha/ExQBs5bA6SlldgY1HjCHStPO61Ua2Yt/A6DN5x//5JEOf3d8dQVN9TMi8yK5OvIKrLJ4Yxq5CmHSARPMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe+Ib5eJbqiN4vt6qRW3d77brRqvq0EcetFZGQk6rNI=;
 b=WDTANa8z7u7n9SZsSiMMIYwP+VuXXqJ9D0RkbZSjsoBZ1iJXPlT0Prp7SNL+C7vU6A/ZyircfuDl2p0+EjuAqSInABgcEe6sojoAxTDXB2WYtXIRi0f8cAZq/zBSIO/WkRRfin+Cy0u/UdffA1eRJjLd2BXXDvi93INHf81uUWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 22:56:53 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.017; Mon, 20 Nov 2023
 22:56:52 +0000
Date:   Tue, 21 Nov 2023 00:56:48 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 2/7] net: ethernet: am65-cpsw: cleanup TAPRIO
 handling
Message-ID: <20231120225648.pgvzd2jejg5jll2t@skbuf>
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-3-rogerq@kernel.org>
 <20231120140147.78726-3-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120140147.78726-3-rogerq@kernel.org>
 <20231120140147.78726-3-rogerq@kernel.org>
X-ClientProxiedBy: AM0PR04CA0094.eurprd04.prod.outlook.com
 (2603:10a6:208:be::35) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2dc0ae-fc59-4a82-3156-08dbea1bfc9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E12NHQFrNdJNOw1shkajdPU8LF7rIK7XY8TjGDTg/6IM74cjREk2WLLnuo33EHMau16hyTxQH2G0CseF0f2aqUNw42kBRy4nLxPEK22TNrpxbMJrKTNsdUSjcoLt6Nne4/fgYru1o9T9scIpDlHk1WHnakGzXhC1uTn4KT/Oui+alKUxkf0MM415pmJiXOeqylj5bi3uM/LDQhtXdVWeRm/xd365isfSOr89xN6Oxb6nqrTUGzj2Ky+GuE3uljYM5QrWy+U/FVvMqY8csZewQ87FS7Za+9lVJzMIdXYhSTpHOU/7TuDeqGL9zEIWZpLANlMVnj6wjtoBf1dKCFA1DydRcBKIXGHYUGtWmyCHkz5Hr17BYQ0LxVprC1tF4JOlTudw9Wi0uKf+jOHUi7yq3gqKHj3r8Y2FdWWNZ8wax5t3vygecSRHyCSAhiFZJfWkkxL7fbSBRQIJYDHBMoX+OZGi/odUxBcr28EqsGgE8EI+0KzGtNiE7d3BUabcWyDwa3p/R7E4z/XJ5bxv+QxQBTAI8C3uhm4jaS+ps75B3+52NN+AOw9TqSn/KGIRPaMt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(5660300002)(86362001)(7416002)(44832011)(2906002)(33716001)(9686003)(6506007)(6512007)(1076003)(26005)(83380400001)(6486002)(478600001)(6666004)(4326008)(8676002)(8936002)(38100700002)(66476007)(66556008)(316002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d6XpERhdQ0JGDkfAcYqqole2G46Z97Ud42lSc21g5wDSBZQngVOn1N9n1MeN?=
 =?us-ascii?Q?hE5iLEubz8pf+4jqXh1MYK+e6/Em8sgHudJb9nL2/laGuU0C39jvmeiiePt1?=
 =?us-ascii?Q?ZTHdnIyLjLet++E3u6doO19hQsOkJhnkatBhKfDIvW4yUo6369qNFIhJsGp6?=
 =?us-ascii?Q?L7iZJ+gV11K4KKZiAcvnaixj2FAyQ6Q1eL015XVHXY/t/OHcsxQORUrybPfl?=
 =?us-ascii?Q?hIHQu6sGXkWyoNTXT/LTVFCSACrOq9al4YIOAhPel1/G65/L4A57sKSMYs1C?=
 =?us-ascii?Q?TY66yaOWRIpYbXJ6lZ4BxDZRdA/CswFUOajhAIl/VluBCiWF02kaP8GC07fc?=
 =?us-ascii?Q?2Afht4JRMuOlaib1pRkX7JEeqIfTle44LOY140zkVE/ADjk07D2OfQVd09zX?=
 =?us-ascii?Q?QpEu7CyofjF9wnAy51A776jBRL82l8m/PHZcar2VGiOTEuZbkCQ24OdYrwRi?=
 =?us-ascii?Q?7UnZD4gn/hfqEI97E+DbBDJEzn0tYIVJEgHG/MXQCW3Mnkt+oCDUv2ZHjRh8?=
 =?us-ascii?Q?DxZlmSxESwc7zLzMJwXqCsI1Abv0qbuHnI1xKiKJyRcP0wXbjPcpJXW/cdJc?=
 =?us-ascii?Q?M7eRbVl+Mub6R0aPEK3eZr50XqyRwkVrfosCrxKcc8o6ckKcDUkJrRmTSmsH?=
 =?us-ascii?Q?DZLl+rxDrMmfhOd9C6+KzvJMMbv1YLMgthyQTNrIIGR9cpx82LnMwMoiYTBk?=
 =?us-ascii?Q?F0Mfp5hiOXc/pNaSz3HzJu7+4iGLjF2054iKX2WjvWOrSIdHH891wR+1jYHE?=
 =?us-ascii?Q?9OaTxYMW3emtwXhMO95BP+iT1vDPXAhQdUjhZZae6BRmPu1mMBSIhZBYIybc?=
 =?us-ascii?Q?K4u4QEthgndkTQFCVUnDMs3mEIiXB1UOwZhnAmM79pfCSG+jYGl+75VaYI7N?=
 =?us-ascii?Q?h8i6hbhVnP51JxAByOiQAx6GaGMI6yo+OV+Q5Yz6m7VGK7SQ01zbhBuVO/Ky?=
 =?us-ascii?Q?b9cVUILVOiQe8FmRc/7rp/jm59n0+82RHSWhHPIea3vv44Jk5RKwIPB2as5T?=
 =?us-ascii?Q?jMmF8pwupVWatT6GFCUzipt1IoNLCYnLc/m66vK433ZAYufhXFWeNllyomFW?=
 =?us-ascii?Q?PaisQyQSYhR+rSNW1/RM9Fv/PvR5sBivDpOFW5AOpUNGUcl7+wtdxmNQJlMJ?=
 =?us-ascii?Q?VwrqYPVGejl98x/fr2Ob4V7TfCNNqnQja03S02VkyRITLYOG5gCInDiC5SIs?=
 =?us-ascii?Q?MVSV+Q25nAj/AKPXxrxclQIpkSX/HVmOM6KoOBuyfwJeyo3DyxNzW8st91qP?=
 =?us-ascii?Q?Iewn4JlY00PYGrVusEE1J0Z3WJ1wcyPArqcHAKzfECMpv3H1m4aR7L8VmPbt?=
 =?us-ascii?Q?p6G0NeKTSuNzlJnNnPW8NY0OKodoyw8zd1OsyN4Jg9tH2eksl1DopaBXxd8o?=
 =?us-ascii?Q?5arqPxcVgcih5OfArpCQd4syCAjyKcsI4FBOGvBX4eW3Jr1kjZ0AvFkOM9h+?=
 =?us-ascii?Q?cyCIggQSMD6/aDwnH/NDy6sO+6XuEXC92ak1Fb+Kn6nr8jfGu8dL0AWJiTwb?=
 =?us-ascii?Q?P6/2OYKsqiOJojq11epGMHIZOjyJ1QIPYfDemhiHDPmAItJFXiUkax6KweLw?=
 =?us-ascii?Q?MYwsgVK+TiFX8Gw4AcYnMkXBrPQhHGkKHKnjJYepmhcu3KTnAMbYu9YxvvG7?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2dc0ae-fc59-4a82-3156-08dbea1bfc9c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 22:56:52.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OD4pN35qfGuAf8tfN2iUt7n09XVtBAPaU+A+TkHLmJ0wbQYhgDzyWiU1drdefkOrbQLocAXbo7SYSOcywl+jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:01:42PM +0200, Roger Quadros wrote:
> -static int am65_cpsw_configure_taprio(struct net_device *ndev,
> -				      struct am65_cpsw_est *est_new)
> +static void am65_cpsw_cp_taprio(struct tc_taprio_qopt_offload *from,
> +				struct tc_taprio_qopt_offload *to)
> +{
> +	int i;
> +
> +	*to = *from;
> +	for (i = 0; i < from->num_entries; i++)
> +		to->entries[i] = from->entries[i];
> +}

I think I mentioned this before: have you looked at taprio_offload_get()
and taprio_offload_put()?

> +
> +static int am65_cpsw_taprio_replace(struct net_device *ndev,
> +				    struct tc_taprio_qopt_offload *taprio)
>  {
>  	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
> +	struct netlink_ext_ack *extack = taprio->mqprio.extack;
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>  	struct am65_cpts *cpts = common->cpts;
>  	int ret = 0, tact = TACT_PROG;
> +	struct am65_cpsw_est *est_new;
>  
> -	am65_cpsw_est_update_state(ndev);
> +	if (!netif_running(ndev)) {
> +		NL_SET_ERR_MSG_MOD(extack, "interface is down, link speed unknown\n");

The extack message doesn't need a \n.

> +		return -ENETDOWN;
> +	}
>  
> -	if (est_new->taprio.cmd == TAPRIO_CMD_DESTROY) {
> -		am65_cpsw_stop_est(ndev);
> -		return ret;
> +	if (common->pf_p0_rx_ptype_rrobin) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "p0-rx-ptype-rrobin flag conflicts with taprio qdisc\n");

Also here.

> +		return -EINVAL;
> +	}
> +
> +	if (port->qos.link_speed == SPEED_UNKNOWN)
> +		return -ENOLINK;
> +
> +	if (taprio->cycle_time_extension) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "cycle time extension not supported");

Here it's ok.

> +		return -EOPNOTSUPP;
>  	}
