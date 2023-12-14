Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE6812E27
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443972AbjLNLG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443936AbjLNLGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:06:50 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE5125;
        Thu, 14 Dec 2023 03:06:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAAdKDFUtS3Co9b+DOIKkfZ8I7p00ZOtb7IZ0TN1Zc4sOyBa7ByTIZrkZ5l7UeDAM5vbYGH6qEKVo7BKBxe8g9dDpT7DYtkGg73I1EHLPTSj/XsaDr3iTRkb0tSgHdW6lGDgFY2O7nlTGbiYEV22m3oY3fpIaI7wTTzZRjH3Hgt5xr6CSEJEvBytAHauxPqiWMjlRfpYJB/Vztef3eT+tkS/G5Zkbj1ojV+ZWhzqayIs3mQk9QHXPzFLHjimDf1Tx9gfZSgWq1OnmaFKkAeZR5qY8VhpeOkgTcQYP4V64Niwck3AgPSUf1EiOuK4c0ziRCoCx2jGCGSJeJgkAcSG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vMhvVFsqz+3UhDuTSNpeSgl9cRGfiLAapnhP1MpaLY=;
 b=XUJ3nweSEty+hbbGVUcLd335Dsld5Z6Jl4jj9LHf+gjipuEiAqmLlrrqlBR9E1plfwJdpKVqVRNL+TYxC8hnL4JLBzrKegVohZxi3WsNidLzP6JPZWsI0bKO2PxYGGyfbG0BhsosP6FxXGXgg9L4CCyWjpYhp9LByLoCXfdkLEGegLhz9AzqsQJLluQAF8nGAV6A4OE5P8bWZmnx4wj8RNQUeuVPb99Hjlpb9DmF+KLTyKfIH+TJ4UiujlcZJxnJf9TNi4BOhgC0gJW/cOTM/7hTBLi/Px2xouXSBlK872mnUFSNSmKPQOYKvo3v1NOZNnYbq6KrFuyE49iuQ3fUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vMhvVFsqz+3UhDuTSNpeSgl9cRGfiLAapnhP1MpaLY=;
 b=Y7mHwu2DfogBy3JRBSlLn1Z9xpTdnPuT4u3CltqxN1EGpuRafqYibifNsOOdIhbw+ORWz1Sw9nwZN9oP5zeCOGyq2bWqn5F22tt8HdHrTX/Gj7k3SDDp0WM+CLXUuhJh8v2XR2Qyvc9bM5zRdsAztGTCSmff6V2fepb1xkSmX5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 11:06:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 11:06:52 +0000
Date:   Thu, 14 Dec 2023 13:06:48 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 08/11] net: ethernet: ti: am65-cpsw: add
 mqprio qdisc offload in channel mode
Message-ID: <20231214110648.n7rz2i7qobikavtp@skbuf>
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-9-rogerq@kernel.org>
 <20231213110721.69154-9-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110721.69154-9-rogerq@kernel.org>
 <20231213110721.69154-9-rogerq@kernel.org>
X-ClientProxiedBy: VI1PR04CA0052.eurprd04.prod.outlook.com
 (2603:10a6:802:2::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GV1PR04MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: aa51e1de-7c5e-42c0-25b1-08dbfc94c695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXAL0Yo3xO5AWtfx+0yr2x1r9wUA9QVnOyhrBtfv3vFoFI22RbXJzf+jecIc4+qWC9E3KxlI9pwuDVzYY1SaKUmTw7T08HBl3FgVMau7sdD28jadoMeJ/+uTYHV6MutGiDoGJG8ZujyJQnQEcWBpOHPiL0oFEUKGYVoHE1By1Pt1iLJCQUa677Nn4iw7jFN4n3g8i41UAlqnrPc9G27MDNNJ4PwgO0KUomJslNBaB+9rDVes17VROfPFu966uAZcYYSiZNYsiIpXFAijaFS2HzzThrrYoPZZxMkwvjZ+xnJ30owxCRBbuq+4rsxorhofbzWvHm06oGaZ3UzsM9u/xNhPQN/41LJoDhs35sd3N7/5FoP5tqqA4X3bKbtVS0Cfjz7JdbAti3sOv62uTQhLi9ABBqRT26h9BW6jVVN+cAF846v763aj4GT9fffN30lCfxPVma8GMpkRB5BEihgnUQJC4A+FPS3lIhsqkLSybSHlRkQD3HmKJUVfgeuW0VmcBAK8s+RQJF1aNlAwFvBS8JxWiKPtrnUknqpUH/23auCl19M44Y07K5AYlqvkbLwA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(478600001)(6486002)(38100700002)(26005)(1076003)(6506007)(6512007)(9686003)(2906002)(8676002)(41300700001)(8936002)(5660300002)(4326008)(7416002)(86362001)(44832011)(6916009)(316002)(66556008)(66946007)(66476007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8+UQ6wjompOJBrGwsb8FYPOl6sK6O+BziZ5X3MTA0gL9n29llkILd0KQpwp?=
 =?us-ascii?Q?nnEg4Enn+BmQxQwn3jDSfDeQt7YEaofDgibEkmzdT/7gYuMFiHRlKIhi8BoP?=
 =?us-ascii?Q?VgZuQdNpVink/LLStHIAHwxlNdjrQVHrUqBIbgwDJJ8o6lhcnlkXCQr95cRi?=
 =?us-ascii?Q?V/jxksfqqaQGzyiMDqqZjM82aqevAb+Jn2SaY/LsrPZRo0wiVbfbtXa9CkC4?=
 =?us-ascii?Q?YO8+CRg03LvcQGtX2c3Idou17ZqcgHOkCKQV6iVirGJkbRRM+kNoLyfuwowH?=
 =?us-ascii?Q?d4tDpHtw4cvNCNthK39aATdPvSYUjBEhDxrv5cO+GtRCwQulRMpkJBjqEN+Q?=
 =?us-ascii?Q?YF6RZR/nw9hzodw7w092dHWjBCospfImYwDLCNFlQ4yTJ2WChEU4pVqRt+2m?=
 =?us-ascii?Q?K2i+Y2bQGn4VxIF5Ajvvenx6ftyUUIjOfHC58EA8OSPz65GPubc8qPabESjH?=
 =?us-ascii?Q?oFapsfXXjmWf+vHoYTpYYV6y3t+XSWdeuinmRVoew6ccMk9wmYeMWw03wng/?=
 =?us-ascii?Q?Lv7eHA8o/htJHa2heABYVQRVedJFNXsFaKcSqkfakUvnSztnMR0K6RjegfRs?=
 =?us-ascii?Q?e/jjScZl320mGg3XruhtiDSKowLYhHQrlRqIeedm1lVvvwoiI6qwE2RTjDat?=
 =?us-ascii?Q?T0bF4CRc4ed1LWUCcGc1mFYecV/1B4hGY/xeJBVDRvaLQoQ6NNpVYuQykr9w?=
 =?us-ascii?Q?p1fDmEq7ZsENkegIMpmvN736AU0eHIwHSYiRxcYFlZUadVuvLsnmpaMuUdcr?=
 =?us-ascii?Q?pSpiholRTJ2onVCj4yu0Nk+JVA9P9L+yNgR3cz2r+E7gp/F+F3PjEflq1hZR?=
 =?us-ascii?Q?TwNJ++RZ9M0xosuLOlVb38H4Be4NkwwqgaY3+BH90VnzLCnekBmuZIaFiLnl?=
 =?us-ascii?Q?yMoei28L+Vfq51sdHWucA9POYB2Vfnr1UZhH/JfIuBxYp1DDHophsOhCHQAe?=
 =?us-ascii?Q?f0p1bhph4rlD4an4ZwHw4AoSjFT5r1a3LD/kbdmEDvQmuhnOjrm+mpHVlytD?=
 =?us-ascii?Q?jx2wj6DDuR8TnREOqFktancQYXQIfmxoNNkxjUPkdplHWfgDCLRA9gPJqLE3?=
 =?us-ascii?Q?cNbUt78RZd++5cvRDhWB35AyqNXmJCUgz56Ya0Kl+YlhMjdYE4fSUKUoMvxP?=
 =?us-ascii?Q?fJQJxMCvVqAllQBn0JKWsV9VvQ31OuKWCZYcTf7U+DXj4ePuHBRmUVChHjkz?=
 =?us-ascii?Q?Zn99y9tpCNXShNBQQWsopSYtOJuCb7WLedWTVBdtSPHIt+ytP32Jg80ArQUe?=
 =?us-ascii?Q?F2Rdy8boeu6w2muJEyr7yU+cESIME9DQAhnQ6oRub8ynl+w4ng2N9bgg1NAs?=
 =?us-ascii?Q?/MaG960/PnWh1sK0jVLMKsDXp1DYn7JKwmkOsjKatzkJzQJ3WKLThudqYUmQ?=
 =?us-ascii?Q?4wvT+8JD0PiHPCPXj5hr2IcGOruMFdvP1rzBiVloER+8qmICOY+Qg1JPEnie?=
 =?us-ascii?Q?PHeJ9/UzlkwSOekrJSyNHToo7bNSE9l8TzYrQkZSId4n88MvB6p8zBchYTaq?=
 =?us-ascii?Q?2IhVxHgYHMq5BjYY3sWDsn/aGLKRUlqgZ+JdhtGnaurq3vNcpZ7ti9XiB8Oc?=
 =?us-ascii?Q?aAmNcbLlpnyKZZb0Zj3WT8TSlurV1ZAU9Da44vyd6nuogdxcr8I7JMlduARB?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa51e1de-7c5e-42c0-25b1-08dbfc94c695
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 11:06:52.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUXsB1p5lfSx7FI3VEnVh4wr74EFFfPlgJ+F+A8YyGDAqKsD5+U1RLnAoCGBhsH2ulKxI//Wr/c0vJyXyUJL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:07:18PM +0200, Roger Quadros wrote:
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
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "TX tc%d rate max>0 but min=0\n",
> +						       i);
> +				return -EINVAL;
> +			}
> +
> +			if (mqprio->max_rate[i] &&
> +			    mqprio->max_rate[i] < mqprio->min_rate[i]) {
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "TX tc%d rate min(%llu)>max(%llu)\n",
> +						       i, mqprio->min_rate[i],
> +						       mqprio->max_rate[i]);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		ch_msk = GENMASK(num_tc - 1, i);
> +		if ((min_rate_msk & BIT(i)) && (min_rate_msk ^ ch_msk)) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack,
> +					       "Min rate must be set sequentially hi->lo tx_rate_msk%x\n",
> +					       min_rate_msk);
> +			return -EINVAL;
> +		}
> +
> +		if ((max_rate_msk & BIT(i)) && (max_rate_msk ^ ch_msk)) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack,
> +					       "Max rate must be set sequentially hi->lo tx_rate_msk%x\n",
> +					       max_rate_msk);
> +			return -EINVAL;
> +		}
> +	}

Netlink extack strings don't need \n at the end.
