Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE37F448D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjKVLBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbjKVLBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:01:34 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C053197;
        Wed, 22 Nov 2023 03:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwe6LYlPtfbcO/6mv+/W64CsQ18O9jr1GrzrOaf49XV5dVWfXRQFBUWwnpAkyYgnMzu3Rbep2Jmpa/N0wARuvymGrRKZ47G8YedmAzaaEfBGqg/QHaAD3/6R8l3gTZza1eqk21yWKK+7yLVTeDJhxWqJZe9wcMqu5z7CYbG3DfsdoEn2NiLqtxmp2MCrqMxaEreeJcp1WLZtaWArawR2jHkCZSYbNdS3LtsmyHSuI7aqwYgg6OPy/jd6pIuxjXdvd1hLoHEZzzHOgdbJSURosMyQ1c8VCwpAfIECvGBJUU5PFRaTlZfbhSQO/b8sGhBUSJVMZNV5yEciJFSxS+8lcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRvIUBjViEEv67oGnkHMUKJ+9PFZDXoeh3NisHLOIb8=;
 b=MWgTGfbhSJy5BbimLSau/Q9zrDjMC0CkJOa0jTGS51zPFJoBxfbQALZlBHcIeS1jOvjV7vulNDV4PeS+t05vONKf1LC08xo56dcFYIPN4T+CLkkA0R4lGBXKTYCBBd6HuYbjwhE6agxxAW3rV90XVJTgN8Q9QzKthtPBQ1yf9zi6IW4BiKavqrcsQmmnIJ0w8vKX4xcc4XsXPYE+R/VMpsJfB3eVE8FPp59zY7UpshEFRcMJZ4Mx4evMIIYCnV0F0zy8d58yJjcDYNLYOLK7c6GMqi1Hs2g+bMzIMZUQoU5Remoq4cy9g5FWUTOC/5hpYWJ13UcvkT4HpiAM9uH3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRvIUBjViEEv67oGnkHMUKJ+9PFZDXoeh3NisHLOIb8=;
 b=V1I0R+iUczMFdxjAP+zAuHzt54VfmaX1AlAj7dYZb1QhwuCKfRR7hAPuSbU8Hm5HLfXbeo01Jegyum86nPPqJ/p9cmRpDsRIYFByj1ZIO1Z7mwcZhkxUG2ZwSO8kg2koUNApzPbUKeo4JirIsZh5jmL907RueIZFGo4sZ50ugLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8530.eurprd04.prod.outlook.com (2603:10a6:20b:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 11:01:26 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:01:26 +0000
Date:   Wed, 22 Nov 2023 13:01:20 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, claudiu.manoil@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: enetc: add ethtool::get_channels support
Message-ID: <20231122110120.crs4rh2utjweswsc@skbuf>
References: <20231122102540.3766699-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122102540.3766699-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR09CA0099.eurprd09.prod.outlook.com
 (2603:10a6:803:78::22) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 91930301-8850-474d-4987-08dbeb4a5dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmN0yziFUQjz7u3LwoHOQQBHaDNMQpn/0Q5EQMspzv/b1Sk6qapqLPF4wk0elQ537wawQB9nPAIhBkhg0POB1eJQxfHfNQ9LFZVCMp/l+ViFGj6y0Xoucz5aEE0lE5+URHhfCgMBmDsE7YVBo6UC7yJ/OSwNqQlVAekchO+NzqCw5ffiaImHAijvUTpTbYXD9Hf+3Wk9ybqn0eJ/LbIbH9jahIkTnyawhp9k35lJldccuLloZFbH/HqOhCOJkh8kpoqlljN6kueKyYTL2QZTQ4LLsOMUfDyY6iv2z+vZpvtA16gjePmlMpO2BehAqmb6RZAOK/lXTOh+1EHd/srlkBfoFM+oRDJTaSW89PD8KUO+P4F9TOqBbX1sltPiSf5xRv2/ZT7HsaPqjrSYrVBjexgF7rF3SsdaqrYgJI356ECpG8aaR4lIwKwS0WFS7CxH2JNbQiAZNRh1q/3D8trGqHDOU4m/xlO2LRUHC155M85t1qA198SIq+Wrmd35zAST2b5DAOTIMgsc9xspKOyVDH8tqO9dnEXkD9FF3JOeO+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(230922051799003)(186009)(1800799012)(451199024)(1076003)(26005)(6512007)(9686003)(86362001)(38100700002)(44832011)(5660300002)(2906002)(6506007)(508600001)(83380400001)(6666004)(6636002)(6862004)(8676002)(66476007)(4326008)(8936002)(33716001)(966005)(66556008)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?39aKDk/NuTA0XKi18n27lN/FBvSVFNHOBINkJcbChUT1JVAN+IQDrjVAguk8?=
 =?us-ascii?Q?/hGou58zz09jXef2dFqUB5Lg3wYZa8gYC6+lp/Ybs/eHPl1f9Msu7/oWdePH?=
 =?us-ascii?Q?NzN+91J/QuITyjhTcxdM9WCJYsEpSH7Y87cI759dGdYxOnkKEfsXUP5VI1p/?=
 =?us-ascii?Q?Df60sZb2jHoO9GeYAWzHasjHhjdF5kdeOqlmVfouUYH/2d41hR7yipKeld6t?=
 =?us-ascii?Q?vnDaXmO9A0MBrtLJtjwce+deh8kdh/klMhQkfh8o8IUR5kaMeIO2VomaWkxw?=
 =?us-ascii?Q?MWoc7ccx/aFFj2+Ej0CYnqiBhMYPnJYaJcvbNzqKSeXz1lNakqf7JK0hJJjb?=
 =?us-ascii?Q?1jx1ueOBN3Xeun+bg+/D1wEalw5SR25iWyDRhxG+MS8u5HAKyc77ZUn0jeBz?=
 =?us-ascii?Q?RNkFujaLYrNF7p1pGpQJYXb5UsI/zUS8cPt52RU7gEVDInjIkcz/nmyS489B?=
 =?us-ascii?Q?93dHuhY89YvDTtE37IPPkYikwnx8dGCC/dK0Hsq7twWdz/m+roHPpVh/bCgD?=
 =?us-ascii?Q?Aw0CsnBkx6iej3VP+0d3/muJdcOwr/aBPR4N4GqqaZhDpw24apRItnxoPOFF?=
 =?us-ascii?Q?iuC7Q3pYHheG3rRxGilTWVdDiL0wliDHd/HLhroIMKYIhr7Nxs+g9AtA6/Rf?=
 =?us-ascii?Q?y4R5SibCXyW+Lkf/i3FhosX68E1UxJlodFTJgRhJy3aT6J5VMtkFhMd3vIgv?=
 =?us-ascii?Q?mLKm6U7tOsuaZRUJN86Er3MYf9saa/FBT4A/DsqYxtBGMFLnWL58ZXPJHorK?=
 =?us-ascii?Q?AXWbzTNdX/Douz+s9DSHonhjX3Ou8tpu6DPQYtoWBDUCrFoB/v5RH3NJutaA?=
 =?us-ascii?Q?GpdAwyPpJIbK1cPncTxXMmAM11d1k12chfQ7xr7z5XmHjbz0AK+79gbD+8Vy?=
 =?us-ascii?Q?qNCc5IN/Urw9/JZLsPvpGpcVCvxiq21ht3BKkYCiaAzFd5fv6CMkWXHVTUho?=
 =?us-ascii?Q?F60g2+iDWSPVnGBCPaf8rY1o9A0An2zXfIWjN3nNczLr/AFVvcpXrA3l/oOY?=
 =?us-ascii?Q?zfr3TCWdkwBcYj9m8Q6xbjA3pWRSQ+nvXPCRM7roKW70JUJm4CAUj3M/T5uy?=
 =?us-ascii?Q?j54UsdRlt/SXqp61VBKGS5YO+841PtDk29Duwx54OYWrsBN1jZUgqPPwdGGJ?=
 =?us-ascii?Q?afI216gpcSzOpx0F8BcY6AL5cCqv0gQ9OQQuCb6C5TmPlaYcBptfpVYIwgAb?=
 =?us-ascii?Q?/YQjpnKwaLzBocOP5IamSK+SrOy7usjKxg2lCitlVJOwzfwbG1/LHo8dAQ6q?=
 =?us-ascii?Q?XBdHghAdr9BgypeRQ8BGu5OXehxUuEsJgp78KtZuTye7fGlLJfDIvpccAbTm?=
 =?us-ascii?Q?D3wTWRdxkS0FWAwdOY0RSDH5CxtnBTMYeD3WLuU2e6OCf0owDFobMswmgO9O?=
 =?us-ascii?Q?255cYVZN9onhyXHncYPFDgJomKXvWYT9mHsr/jUMdcnNYLnRmeqCBZGsLNYh?=
 =?us-ascii?Q?w/+1lSp0hmynsIr9815hNjiwX0O2ZFEnPnV8Bi4KVc43gwTPUjDUtN5UfG1j?=
 =?us-ascii?Q?mzF5+FG3YIe7+w4y9SIsKR8/U8Oyta+u91zZkunPwbg5gaIioIyEqBsf7OaL?=
 =?us-ascii?Q?qRpVrgP4xmgM/AVU7N41sKIAtv8wwMAi04U1AeyM1I9CQU8B9YG6QD1L4YVz?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91930301-8850-474d-4987-08dbeb4a5dc2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:01:26.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2crn+xiRihBBrrlehr7rZgHmUStdp4/Ole2fEbSqkgbMzlkQkvZCj9R2V/C6HoyGHicwItm7upLOpt00T2qRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8530
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Wed, Nov 22, 2023 at 06:25:40PM +0800, Wei Fang wrote:
> Since ETHTOOL_MSG_RSS_GET netlink message [1] has been applied to
> ethtool tree, there is a netlink error when using "ethtool -x eno0"
> command to get RSS information from fsl-enetc driver, and the user
> cannot get the information, the error logs are as follows:
> 
> root@ls1028ardb:~# ./ethtool -x eno0
> netlink error: Operation not supported
> 
> The rationale is that ethtool will issue a ETHTOOL_MSG_CHANNELS_GET
> netlink message to get the number of Rx ring. However, the fsl-enetc
> driver doesn't support ethtool::get_channels, so it directly returns
> -EOPNOTSUPP error.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/ethtool.git/commit/?id=ffab99c1f3820e21d65686e030dcf2c4fd0a8bd0
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

I think we have 2 problems on our hands.

1. enetc is not the only driver that doesn't report ETHTOOL_MSG_CHANNELS_GET.
   So it is a general issue for Sudheer Mogilappagari's implementation
   of "ethtool -x" using netlink. The ioctl-based implementation used to
   look at ETHTOOL_GRXRINGS which was handled in the kernel through
   ethtool_ops :: get_rxnfc.

2. I used to have a different implementation (and interpretation) of
   ETHTOOL_MSG_CHANNELS_GET for enetc anyway, which associated channels
   not with rings, but with interrupt vectors (making the reported
   channels combined):
   https://patchwork.kernel.org/project/netdevbpf/patch/20230206100837.451300-6-vladimir.oltean@nxp.com/

I would suggest finding a way for the user space implementation to not
assume that ETHTOOL_MSG_CHANNELS_GET is implemented by the driver.
