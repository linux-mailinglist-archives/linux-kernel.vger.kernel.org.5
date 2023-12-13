Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F618113D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjLMN5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjLMN44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:56:56 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09134220;
        Wed, 13 Dec 2023 05:55:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt6tP0FfB0spcE0nL069HTuDOv26ZbYYrmtjvVvDBzJeXmgkD9KzLBNa5mDKvmYwa78+IhaP70BQQHfJnpuqYjYYvzoDtPPogUeQjcuxFaD+eX9Cc/KCV0CrCdo6rn/6YStB/E0a+ai8izdBoOA3ldC6+l9hOewqTjVCNxaFP2AprWIqdoBCwXcKLMJ5t+5OYmPPUH45r0ytqtZOnM94k13kwRggpGdno4DJu9oVub/fnzujLeN+w0X4f7sZWJoPoD1CCtb3emIJ7hf+g0bQLgIXTt9QejKO69qKtoS+NmttMjyXj1gQOJSdTpm6Agu7+qpmEQ0+73PcOGPunhKrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYtyMUEOoQq/8LX+/1KX2KaQ6rc8CiS48Adb1XNqB14=;
 b=jEmQfLNu3FT6+37fIZrhE02a2ASCkh1h99Xor05W+1GzaoyPMVhIPpkUdc1j/x8knEVqX0jjHPkIibpDXRe132fVGC77qgNrmQViUpxm3JCuQYwQw6N3EtO5PAslwc96P87TPfgX8c1fz6Jb1TYxLcjalXuu9buTozWFuMcKpKkbeTw7uzPM2j/bzLjfHPTzAobj3n1CwyVby1HjVb/HKAe2+le3BV9qNsWPnMY72cdPRRYSnD/bHdP8GllXYUcsqPSJKlMtKAj8WuNv+BhNuzeO6k9gLub3YwoOQqIzrEoXUMIl+8dHKlhKeS8zy/MBYKNCF5qX2Oh/b1ZhUdfZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYtyMUEOoQq/8LX+/1KX2KaQ6rc8CiS48Adb1XNqB14=;
 b=A29wPJpWDfpoVNSBXjO12ynJJSu3VkSoj71doTiirBSQjVzS398JmKNjQtsCptmkYxD86Tp7mYD9sCtuAurlEYy4pql5aj86JbRe6J2W2pUVuRNdI2qRkWjnYJN8MbC489NDnu9d4hVvCJvsZ9ZIo3tAOg9iR6AjvtceCtMTlrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8534.eurprd04.prod.outlook.com (2603:10a6:10:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:54:39 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:54:38 +0000
Date:   Wed, 13 Dec 2023 15:54:35 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 11/11] net: ethernet: ti: am65-cpsw: Fix
 get_eth_mac_stats
Message-ID: <20231213135435.czao6wjighpskcvz@skbuf>
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-12-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110721.69154-12-rogerq@kernel.org>
X-ClientProxiedBy: FR4P281CA0350.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::12) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aac39dc-1c73-431e-6571-08dbfbe30c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujbJMiT0umazlG2Ukgxwj0zVxgoOdwka1b+y1q9tMiQ/LhwiPSHsDO5sXi/FJZR/CKAobLmZyAzyHSFshKdqTia0n+t7SkyyjgA1tute+6HyMEbTXz/r3zNaVkssNX6M7ALQXY+5iY/IyC0zlnd8wwyk5vxGv7zy0NKxKGLMjvJUGPf0dvp9WO8e0cyIW67LN053Q6aD/lBjJpmuLPGo2BL+kRsHwYb3Dm6ZAYwiOY4DUwl4yhUsjEUMTlT72pj5gQbWhz8nYyk+gWpqhQG1MvNmUHKvAykscqrecaRRA99sefLBWPSHwmBFkpvAE/tCEzv4xQdW4Y5crJqw533rY8NgzhP0pAG7/fsBkwC86SicRIezxGbGkg+uOzqP2OSjJg1ftaZDhqQRzeB/yA0J5pn4/IIe97XmyDxUbrk6L7GX+0B/eIQvYbwHH33Wg4lE6UedEGAbkjawTxiqeOXltnD1R+br8mmlZ9b2FX5LP5NfMXqIdwwb517cdu3cHOE+ft55XleGXoGPAal7amsxdI0dSYiApk7MvAFk2Myirf7gbuceQAvRbZQu4P6OV2aK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(1076003)(26005)(6506007)(6512007)(6666004)(9686003)(83380400001)(8676002)(5660300002)(7416002)(44832011)(4326008)(8936002)(33716001)(41300700001)(2906002)(6486002)(478600001)(316002)(6916009)(66556008)(66946007)(66476007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9891gg5aTIrso4xAAIaEkHn86FfVc19R2ODivkKYjF0SZg+/LPixnTWSKKYl?=
 =?us-ascii?Q?X88fOHA+TDQibr5dkbHCXHhfF03zt7KQZJlRpokdLMkr1EEok0+8K86+gaID?=
 =?us-ascii?Q?W348rX9h4NTnLBY6RoIyNWpmtRLOIaDMdm5CCaPxX8fczWiPPj6Wz76KLoJl?=
 =?us-ascii?Q?PvkNiojK38BJg1+O+72ADeNMxUErPDoTSebxbscVjS/lBU8LsZfCuODPL01j?=
 =?us-ascii?Q?a2wd/k0a0P/ShyTiB64EDD4wGyJ7c53q6kwO3bDMcRR5SkIEpo3P8U/LkBrh?=
 =?us-ascii?Q?+tikoIIa4E5jo/AcDtkXJYXDfVWCTYcm147ubEVe4e6Hqvjnipi+JpIOAjyL?=
 =?us-ascii?Q?gkernb4P9afQZyzUj154XwSLeYP4gl8XedWmehy7XdI+6E3Uwf9OoE7xVXb1?=
 =?us-ascii?Q?c/bkRvJGY1PisHtVBZbNlIzFtHLfJ8kV01KFMnfwr3znH1o6/XRZpFUruv4B?=
 =?us-ascii?Q?adSI0EBT+99ApYRfJMIeZ8fKMR0XRa2xnvflnKDWjQQOhlj36LBbXgLN6VWW?=
 =?us-ascii?Q?Eg8tP0qw0AAeAXbj5NbhpLbqM2PXzXPMprOPs0OIUuSRe2g25xVp4rqkVrWO?=
 =?us-ascii?Q?hnQGa8L8g9nDqnB+jg3qcOYe4Sqn5/6778b2JbzGaXN8qrHpiRcMlNU2qb3a?=
 =?us-ascii?Q?RY4+IakSSgD588JE/ovksrrLkUUduFCVk2nHKS2YjEnpXg+TGQP67MFTx4Vv?=
 =?us-ascii?Q?SLAsocUmWrA4mGgFLQDfLaRtJq2DqrIlY/0BAzqTKWAzXXhmK54qOwerTitZ?=
 =?us-ascii?Q?+FSVLirBlQvoIy5WbcH8/3Ghb0XMh5lJZNDVOlnsaaYFlt2YQW913tPD7aeh?=
 =?us-ascii?Q?b9pCZ5CgX13W1we3t21iKdBLqBFbFkMbhZi3GONLa1RPfTjuHicnJ5MM17tq?=
 =?us-ascii?Q?puB5/IMAMFY+MPSTmVNQxiYz6qC6sQERK8dU9iz/9XsfagXE1V+csQR7FeaI?=
 =?us-ascii?Q?CyIvegS/a1I0Yvd1JwbycRGXst/d6GjmtwYuCNYhSDC6TdzALLruEDp8mFT0?=
 =?us-ascii?Q?RKnybBTfxTOaP1WDwdpPTEHufKeMs8JTynG+X+UFsVqGuo0/Au9ihsl/L4De?=
 =?us-ascii?Q?2VT76CTFym69wH441YtIjAOJ/iZ0IuDoKsgwPViXT/759MHoO2+9CCZm6/ws?=
 =?us-ascii?Q?UwrGPjelQg2bfz7GUyF+OQxuDIZbO+954mFsZGbthYoj+LRkuw0K5AQSsomu?=
 =?us-ascii?Q?5/1KN/RuQr3zJJR2Oj/evVj0Y8IjfyeiRtQo6UqsX+Qm1F6zi1rf/ayu0ZDw?=
 =?us-ascii?Q?ohbm6PF+XX1Hp5tV0bDVUN/MMu6ACt+KVc79YhvjVpCeKfhtzLC1n3VksRoB?=
 =?us-ascii?Q?vbJVG6T2OWg2wjb4dPSsMvfG/zW1etsmzueAIiaXIIzoSUCn343+Grd6qczC?=
 =?us-ascii?Q?4Ix5DdKYSnwPOY8TC1o2tLbLRn52yEpU+KNGBX+Kp7Yix1YRjvzn/4PhCJqy?=
 =?us-ascii?Q?cPrFYS8N86Kf9bXjFpQSEIK6rqXfIXff8Iy6H/Kl5H+MC/bUljuG3nOSZcQi?=
 =?us-ascii?Q?8IbwgjcSQIPCDvDcMzWoybeF9Hvy06AW3ec039j+abHxv/cxjEeswQgbMUKN?=
 =?us-ascii?Q?Uqt2jJqDrhQHnayqIy8O0zwA3Yr+JHIfHFMLqHyyORZ4hF7wymcVkvR1Cx3Z?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aac39dc-1c73-431e-6571-08dbfbe30c57
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:54:38.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/KCx3CW2JfsP8L75wevDtrGgqTeaQ9c6pgZqutHf2n/XEXkdI+UIAUwf0Nc33DdZr3Af0ei3ne7cnsoIRiCtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:07:21PM +0200, Roger Quadros wrote:
> We do not support individual stats for PMAC and EMAC so
> report only aggregate stats.
> 
> Fixes: 67372d7a85fc ("net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> Changelog:
> 
> v8: initial commit
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> index d2baffb05d55..35e318458b0c 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> @@ -671,6 +671,9 @@ static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
>  
>  	stats = port->stat_base;
>  
> +	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		return;
> +
>  	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
>  	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
>  	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
> -- 
> 2.34.1
>

Fixes are only fixes if they address a visible issue. And the blamed
commit is the one that made the issue visible - the same one that
"git bisect" would lead to - not necessarily the commit that introduced
the code being changed.

If you look at net/ethtool/stats.c, it will only accept ETHTOOL_MAC_STATS_SRC_AGGREGATE
for drivers that don't support the MAC Merge layer.

	if ((src == ETHTOOL_MAC_STATS_SRC_EMAC ||
	     src == ETHTOOL_MAC_STATS_SRC_PMAC) &&
	    !__ethtool_dev_mm_supported(dev)) {
		NL_SET_ERR_MSG_MOD(info->extack,
				   "Device does not support MAC merge layer");
		ethnl_ops_complete(dev);
		return -EOPNOTSUPP;
	}

So, there was nothing broken in commit 67372d7a85fc ("net: ethernet:
am65-cpsw: Add standard Ethernet MAC stats to ethtool").

The first broken commit is when you add support for get_mm(), such that
__ethtool_dev_mm_supported() returns true.

And because you don't add bugs in the code just to fix them later in the
series, you need to order the patches such that all the dependencies for
get_mm() are in place before the get_mm() support is added.

Translated to your case, this patch must not be 11/11, and it must have
the Fixes: tag dropped, and it must explain in the commit message that
it is preparatory work.

--
pw-bot: changes-requested
