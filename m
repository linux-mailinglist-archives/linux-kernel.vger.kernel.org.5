Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00497B6DF0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbjJCQEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjJCQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:04:40 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496469E;
        Tue,  3 Oct 2023 09:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbQ3WqeUk+kleztkF+bkgxmW/asB0EqqQINJ17B7hFSwNqzTXrXYv2jKM6+jpfGOD0NLTalUp8z6zb40/FMfBRiEUIp+PhiMUKZpqQRRHZ81Zvf8EH3DyiEDIxkTnqhJ0hRIDcduJ3NQW8cJUThk7J7KpjIeFGmd3XEDbmQOxoeltiJSWt3LB6tHSWXSY0ZBgW+ZSeg27p0pVMefWpGV+s1Hj4OHU1MCZX4prIyctiO1T/g/CSWn2pQbadznoO/Y2qEyBAP3g5LlMAz3UIxUZzRiJmnxgL3711E1tCJlRTSexeBqixvDn23gUpC+XYupNHLYbAAQQp41pEH6ibC3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcYipdCZGUPHaeG3WvxhtqfGwuyJfDPsFUTZbjL8Bf8=;
 b=NWE4j12iHd0etFZmL4e/39K9iPXcBBiubvmY3ke5dmMRecJ9PExPBEseourSaU+Dh+SMQ6noIJUptFj2fHrmN7t1W7gEVVyVh2qMnJXh+3C+ECxPUkyJ6ng7kn80XmKnLUF9toPDZl4NQEX9T+7zLl/xbDVPuLv2XNL1ObWsLEV05vvF0tGLiZjUCi8SMsyosPEDF4Yt1Pe/7v0aHeCsMNB53Z42ab7ovodQLJvg/BmEolpAjuSvMqs1nvibImU+zc5ldIGDcDGjhjCB0tW8BlUuEPkV+KHcZ0lCcsUqHbfluMyf1jXEvazvtSx1UUOAwAdMnfG3bHc9SkN6XRatpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcYipdCZGUPHaeG3WvxhtqfGwuyJfDPsFUTZbjL8Bf8=;
 b=mrW8MAgLKLaQ36r0WC66S+0NguKChGzGdRuuo/cJHcagS4LzPPFK43WC3C3uV72Mtasytjw/fUzlifVc+lwGoVp8hSYW2XGpQwNBtLvl/GXFyrLFCX6Qiz7MCmU+PrI0mG2QV5hHEcCpMAc3opnNTvGQB7Sa+64MZD9XxTjrgFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 16:04:34 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 16:04:34 +0000
Date:   Tue, 3 Oct 2023 19:04:30 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 02/15] phy: introduce the
 PHY_MODE_ETHTOOL mode for phy_set_mode_ext()
Message-ID: <20231003160430.cildofvlwyrwindb@skbuf>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-3-vladimir.oltean@nxp.com>
 <5293ccd0-cb88-a196-fa26-aa6fe1e3a52a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5293ccd0-cb88-a196-fa26-aa6fe1e3a52a@gmail.com>
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b562ab-e651-4e1f-8671-08dbc42a6f8e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OdokSb6t6bAMzbq2MFVezWBHWa2tI9FGRHO0iKXA6Z64j2v9IP0U9fmiGX5LDE9YfskIQjX1mGJDKzBEnkJ8QdgPAURKzAsrXpukcMX6MxiX7A4WlVccFEBicG7q3axAvWoW9L1U1v/KId73Lz99DMs9HZq1H6/VEdYJg/A78+xwNkTQ3NNnDWSs6y4YQNql7hpDxnq5higWjLnBfso5ZAO0u3jrf0iDV57i4dGd9G6GmzMgx0AoETbjrt/O7VAesJzP0RevhxvnbhIEEQtP9zMMki33uX7Z74HlraV3BPenIe2Oa9x7fn9KWHo7SrKfBkT41xP59cQJN2Mbc9gMpRlIJuEnoFoM4O9PuiXNmjlSJ1Qv6ZeQe9da9iXdGuvA1XXLImBgubuYxJ6s7N2Kf+YoeFPTduA375KN0Zz3p1WnSL2RueoIp9PbTJ/m9uJbubMFd+HbD2/rH2HqsELS52SCBhPVR8ted2gp9Yx7ENaD/kWATuStt7pNRPt2Gv2GxhqyI8RxIXcjdldSih30TSK2u9IPCPNS+Sl38istx8gETRd5s+0yz0+saiLwvjg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(33716001)(38100700002)(6916009)(316002)(86362001)(54906003)(66946007)(66476007)(66556008)(6666004)(26005)(6506007)(1076003)(9686003)(6512007)(6486002)(478600001)(7416002)(4744005)(2906002)(3716004)(8676002)(8936002)(41300700001)(4326008)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17H632FIS7h4zBnt84z4ZL3ZoIitYd7my+NmLsR6c/sDw1NZDVU8+utySL7R?=
 =?us-ascii?Q?3ZlTFJzEtFuVZXJ9Oo+g1sYF/JmkFxKtuC5XOeUeihEtbWI68zDr2Rh4q4TZ?=
 =?us-ascii?Q?ZvIe1cWK7w7YWpWqSA8xRZsWdsv+3EI6uN+PC0+gbo6biNaIeZk0x72sv8Iy?=
 =?us-ascii?Q?E52CGkl6bz2LCPHn+oiGlzIIfPN2s65JYxgJDya/9CtfU3nLP0+Bc9QoW+RA?=
 =?us-ascii?Q?0kWZeLhCvlihI/+kMZFyXoHdqibS2Rx3H2OSxLOUEcTcGgAgNjGHGqB0X3UH?=
 =?us-ascii?Q?HJTSxeApCaVqeaojxc1NhLZpZfRhNOv8C9EmaGZN9Z3HW9YgyyK3W76+gMDn?=
 =?us-ascii?Q?k2im3I4SFWljrEMmWF1O8J9L9dRFhoQEdBmgGhBigQupCCEje1d/t7CmA0ea?=
 =?us-ascii?Q?BNcQdcoHOqhjdcKCYYVa83izJ6MRfr6L6EPpCw9+TKcrbTwoSq0Gc3FdMM/K?=
 =?us-ascii?Q?nXRPNcSVA9a4kQLCllzebceL9oGt9YZXL1gLUX0T9Um8+hMvan9USkf+B1Yg?=
 =?us-ascii?Q?0JTf0ZoA2Qyu2hRbc6sxZNKsEjL3huo4NsNtDtxQciFENjarFXtkEYSqF1Mm?=
 =?us-ascii?Q?GRz9VpF3SQjNk0Kz/nH0eDK/LGQj0zvpa/xUVpvI4ZUw43q9v6c7jKEJ/IFr?=
 =?us-ascii?Q?BArOWovlspH62n1oLMmSJw7EOETIOg92UwyrXjWLeNTL30U3LKyL7kuXYpXH?=
 =?us-ascii?Q?l8/cZufq0g98RHPoFGmX9h80LXWnfbkjiSmhO7pfYAhT4Dsvoas2NYP8sm0O?=
 =?us-ascii?Q?EmW4I8pZg+GiMtWpX5g1FFbJGGC0Ms17xMkIWkz86tWB2Z2Io2f4Jdkc586h?=
 =?us-ascii?Q?ppYNTP2ljQ5x5ub/H9l8t7WT5TLZUmPSytHcfRREkyRtA6Kssbq0mI8PlOgy?=
 =?us-ascii?Q?/WbiS4+yJWPbHNRszzz/Ir8w92r4TM8/yjbaBL9aeAOaICJuMG+2Yd3mQ1uR?=
 =?us-ascii?Q?hEF9c5owt9BiWLlnACyAI/SYGXUKcJIwyxlwiXQisip/XcHHjxOWglBbZoeZ?=
 =?us-ascii?Q?dFLZr7gCf/mNZWXhjrRJrb7OIpHpmv4RT7UwwMCpE/CkK18LHWC8v0sgnoBW?=
 =?us-ascii?Q?ogVXKKXKmoaxmMsPF5ckZr/JiiwtMTCsjlc0zrQdrVrERay5symy0+VLNIm9?=
 =?us-ascii?Q?s32OtbHPJVFM/EybsuQ6GBZN0YtyLaiETls2VBpCzUXeOtVy5wgHJ/8YKr/7?=
 =?us-ascii?Q?DuoEvsb4xwWqbhqCqOQC4Wj13z4AjOTEORk8iWhGYWQ2kldf2CcolJps/BSr?=
 =?us-ascii?Q?HdphKJPlxdWHb1ZeRpHkOelSJKAejZgP0zJ823Ur/QP7Ngb07qL+LlnChsyr?=
 =?us-ascii?Q?Hacn5dI8degYgevIFIKdsTsR+WX292QSTycT57jf/1xuRnRDg6bxPLZF4ZvA?=
 =?us-ascii?Q?l+skmAfN/wRJziZGvWQH4soL3jeQpg9A30KQrCstuqNmQoUZR6VCoAO4o3P3?=
 =?us-ascii?Q?B09PyRjUelDGSeBPZqKTxQs8ehPmsWl9PrTSk5cWGRt3xHfqLAuFsXLx/Z4r?=
 =?us-ascii?Q?lfmSBPGWnuJ2gGk+Z0wHO42OuAwuu3lOFPJR0PH5sB5Om2utPTHTF++KcGFT?=
 =?us-ascii?Q?3hbcLVfcFd7QwQRut7lvN4swepFTAPmoqMzWV4vScD2L2yejcoVJt9qqdz14?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b562ab-e651-4e1f-8671-08dbc42a6f8e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:04:34.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUvjk5fYPNWKqByvhuEPLzatODkRkUYZo0yM1Rq2+gCqg7vzUXxrrwrChENwnByqgIMkcCFXd+VLlV/C6zX+vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Mon, Oct 02, 2023 at 12:19:57PM -0700, Florian Fainelli wrote:
> > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > index 6be348f1fa0e..72ef4afcda81 100644
> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -39,6 +39,7 @@ enum phy_mode {
> >   	PHY_MODE_UFS_HS_B,
> >   	PHY_MODE_PCIE,
> >   	PHY_MODE_ETHERNET,
> > +	PHY_MODE_ETHTOOL,
> 
> Not feeling very comfortable with using ETHTOOL here because that is a Linux
> sub-subsystem name as opposed to the other enumeration values which are
> electrical modes of operation and/or industry standards names.
> 
> How about PHY_MODE_ETHERNET_EXPLICIT or PHY_MODE_ETHERNET_LINKMODE?
> -- 
> Florian
>

I agree with your sentiment. I can rename this to PHY_MODE_ETHERNET_LINKMODE.
