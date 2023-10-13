Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC37C8B42
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjJMQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjJMQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:20:23 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2041.outbound.protection.outlook.com [40.107.13.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A3059F8;
        Fri, 13 Oct 2023 09:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMmzuk57OyVfJVDba+zYQdQzv9qmD2HbDnTgb3BdrgBz7mV+QQX0/ojPZ5rSKRHLdFh2JH0+PAtkhWuhBrd/5r4bOh6apSe6q7jYEerNfwo/Gb9ZuASTG7vDD/kPmYcwpOLy6TcChMzBEzURv79lt01VeXFWJ0kEhb54l8ZyjshiJJQtFkNFLR3OWIGjntZuwCnIrJv4GMpGkFiKUkgOfLIO9GqQi8cIgkXjEaTR/vVcR//xt9stBsae9bl0kmi+jtuOh46QsPlRWER4q45PgbVjRGW9SnPfVCjNn1tFE1AJXWYcOKSMCsQS+hpHuUW26cU/mEJ8TA9imIrDT6jTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMk4J6NlHp6WqrWHx7foj9CWi7j4b2JINFUhi0e++T0=;
 b=X29NXKcURxIeclWRcX8R4OVf6ApQM04/w2FU0X9VbzWonuMoZQlNooBaj1CARW1ys53o9FZFvu2eLPMrll2T3/0do8BJhvrJTHXYnBUvhP6WB7apZoKCjQ7n3JyGQYTf5cO2vgqRgCh8f5pFcG6Uh7iceXMM2nkRmKZgemfRdM4WpyA8vOzElPckRQJZ7bHJqE4Qhw3nxXgYc9+vcJZ82Zg41zm97b3yItEcD+UT9NleyJ5R6n6QafCKuhGPnZ3+70vrbN8HlIgX/gVMf7CWd94cy7GRkye6vZDYUDEAhr+56aR4nzXA8SKzvWx5d6OLyY3oUtV3lhK/xXkhYDK5tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMk4J6NlHp6WqrWHx7foj9CWi7j4b2JINFUhi0e++T0=;
 b=RAGewvNrtz18nSEpnNHOIeJDWOpUtqpSDGIt6mN2LiLHxNY4G2M/oCGPTXG2bDANV5XYwcIN/ca/aAMXqxdA4roHOYZIyr8+GBPjzadLGfRv8upGqvBtDur+Cb1zKPtg9zK6Gfx7rUoAWFlZ5g6extNOgHzSY39u/I22cbsFDgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 16:14:50 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 16:14:50 +0000
Date:   Fri, 13 Oct 2023 19:14:46 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231013161446.st7tlemyaj3ggkgk@skbuf>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-9-kory.maincent@bootlin.com>
 <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
 <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
 <20231013090020.34e9f125@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013090020.34e9f125@kernel.org>
X-ClientProxiedBy: AS4P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VE1PR04MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 08452654-29f2-4f38-94b9-08dbcc0786d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFwlc3ONKpJMD2R+lZYIFUqVeNHgI8fbrrvDv7CuXkRcpwtsoGxfKK2SMk3XN4hDDAlsAkUxK8bzHFf4ij5s4r9waE1nOKqRssvUUYNyeiExCmar4LzQjM6lwAjP9OzgyBf9DZiyW+wQB+bcEfS2Qx2sY3OaI906R0JJknP1l7WXZNT+4h7zghVXKR1vbnUI+zZqrfjgvTN/H33EizviHmHEnc7TljbaGR4LYZk2r3GK0ODARLCwqeBxKB7+yFPppMhRNl5cgHaJYnoo4sdXKxGkZHKn/0eXgOf+TC0Yb5tUhC2/pmantecgefTlIEHHxZTOEz/am1PA4aUadFzpYuWtrnxU+ofIZUanBrAiQzvocA4+4UHvS6W3ITsAVJKH5Ad0jwXeKaRPAXLSo7/GHl+6t2JPFFLpMG3c1rHoZG3L3/X9nxX75At6koZkfwG0slLvtubCS2cBx5pDl50fCT7V4AQvDVSp3WC3cSN6plUxVuFMjLcsfQ2Pj5qsoPWcc2XmM4FiLdRs0Qxfm16H42sEXqa0zims4QEv3gGp1t3FahfZyswhOqhpVVzgq2wz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(7416002)(33716001)(6666004)(2906002)(478600001)(6486002)(41300700001)(4326008)(8676002)(8936002)(5660300002)(44832011)(6916009)(66556008)(66946007)(66476007)(83380400001)(54906003)(316002)(6506007)(26005)(6512007)(9686003)(86362001)(38100700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Kltshmxl71IUGteu7VtRgsXFxlr2Z+IlF2BqT0Rg8rm6TM8aTOgH8f9ORd?=
 =?iso-8859-1?Q?8j1oqtQ5OwUseC5ZBbEOnCQjBI8mAZMpev16JZcKsAqf7X+Pd49zWKzjlU?=
 =?iso-8859-1?Q?vb2fdTNFnibT72XPnCbe/q6TNdtgQAfuSxlmmeXILIu7y9RCXTdS+hqu+J?=
 =?iso-8859-1?Q?gEBsxOfWTdR8RZSKcZN56qVdHPJR537ztAf3QZUT8GXqegamMO7lLh5lGW?=
 =?iso-8859-1?Q?RpIA9R6hbYKC+Bt+NpU7xFxuYvHRdTVaKAR0H9FXQ0PQslmX2sCoDDwz63?=
 =?iso-8859-1?Q?3xwaozuQZ7OeAYPPKf02S+rdJdGvIJGGns34++Abapl454Lmi5t+pp1TbD?=
 =?iso-8859-1?Q?skv+b18jcXhRymNCcogt4gqi+r2UX/qAFrjpDyIOXADId2CEt3pnkYglir?=
 =?iso-8859-1?Q?kB5ezW0J0Csgfssm0vVm8Hk+8l3JuxP78fs4gQMnFJNL8liC84uUgcSHk1?=
 =?iso-8859-1?Q?r7zoDmFBw+VRvO58TkyT/gOHtq0Vs79Ez7pexnEKA+lLG9Jv5fXQzx+U00?=
 =?iso-8859-1?Q?AqEBQdETZtzKP9g1Z2+eKEacCNIRd1GK579Vc/JZ12d0iGsHeq3J/uXOBg?=
 =?iso-8859-1?Q?JlmfQ+QBGjs2pq3xiS4oZT1VKqU/XQK8e3LCIT92d+mf3eVhnywu67Nmom?=
 =?iso-8859-1?Q?8KBMw6A9kPmTR4po219n7IIiH/I8S+c7GraYTHm1g77ZU3KV0ksGEvgtwM?=
 =?iso-8859-1?Q?TYFiMpf10guK91eMC60sQ9sGBSPCsMwKDu7upXX5T8/8m0mIDZ0d2b7/4V?=
 =?iso-8859-1?Q?xk0rfpXRVRxaDBukGkVvmbiXMe1a3gNPbC4WHDfovY/HJ8bEEbhz/em7zF?=
 =?iso-8859-1?Q?ObmgRj+dDGJsjY9IWX6MwzOQUWRzVzEFFi/ZRshjjh9sjMp6d2bCkVW/4k?=
 =?iso-8859-1?Q?/ua1M6h8ZCRfBy1vw3CLzeEoFpHDpYDBB46jTRveI3WBFWb0EK6L+ZBu/Q?=
 =?iso-8859-1?Q?ISpQYQO66SDzV4K9uNEv6gltlWJHqg8d1ck0rtmBNmB4S8s3HLyvqadZkX?=
 =?iso-8859-1?Q?fDtLvbPZU6c+fKeqHrK8EANttCBlbUd+bfmnLvZa9LnyayJ5naJE0Tvy1D?=
 =?iso-8859-1?Q?hccf0lKRVR3V9B43P7kK13msp4M1O8aCGstEekg69R8ZaaFepWN8oqKQtW?=
 =?iso-8859-1?Q?FFAEUGmBgwFSQ9WgNY+NCernoo1DWUZZK+3HwpEV8HZq9EdMIT0PlR2Bb1?=
 =?iso-8859-1?Q?XLPgrItfaqS65+H7AkkusoxTEyC5T7HM25Y+NCGF7zh1i1jadcuzgM9uO3?=
 =?iso-8859-1?Q?ZyxttYbqeZZTDDGS7YEWsw9Tp6D6zWmMSM/9pcs1HQlPlPlT+j/5a1ZssI?=
 =?iso-8859-1?Q?dqM1tJ+4nXeeFo4cSwRbONEMx3Zf1cZ5Lszf+z7etr0JLow8cSbrdlwc4U?=
 =?iso-8859-1?Q?MvpXHvcaIeI7mFzdui6LeQu9vhcPQov2vV/r6RR1ke+Y3gRjY3ZpeME81e?=
 =?iso-8859-1?Q?lAdf8EnQ8F7ZeNQNZlSWDkTIU9ZMesVLklPe+/V88WiZX2oZpgkk3tbEWf?=
 =?iso-8859-1?Q?UYL/byApjxkpGET3qiPgjCntRTDSQvcd0LNcpl477OtUOxTIFVnqbPxqq3?=
 =?iso-8859-1?Q?+SpUqQbSCBIeqITJufCdRFrcE2wyhURPTDBz9/tneNg3+orr5GqM2LkgLa?=
 =?iso-8859-1?Q?8r/c6GbMrO5AmNbcgj8tzMq/zTotD+BU8dKox2Ktc10qmSuDcMU3dlbQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08452654-29f2-4f38-94b9-08dbcc0786d3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:14:50.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvdxYjJwwmqCADL9gIpgcyZxiGT2D71Wi/i7LdemnuccAJCrsy+XUMxHNryKWiwb0HjqMGqQbdVnbR+qS83LLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 09:00:20AM -0700, Jakub Kicinski wrote:
> On Tue, 10 Oct 2023 10:23:43 +0200 Köry Maincent wrote:
> > > Why do we have to set NETDEV_TIMESTAMPING here, or is this a round-about 
> > > way of enumerating 0, 1, 2 and 3?  
> > 
> > I answered you above the software timestamping should have the
> > NETDEV_TIMESTAMPING bit set as it is done from the net device driver.
> > 
> > What I was thinking is that all the new timestamping should have
> > NETDEV_TIMESTAMPING or PHYLIB_TIMESTAMPING set to know which API to pass
> > through.
> > Like we could add these in the future:
> > MAC_DMA_TIMESTAMPING = (2 << 2) | (1 >> 0),
> > MAC_PRECISION_TIMESTAMPING = (3 << 2) | (1 >> 0),
> > ...
> > PHY_SFP_TIMESTAMPING = (2 << 2) | (1 << 1),
> > ...
> 
> What is "PRECISION"? DMA is a separate block like MAC and PHY.

If DMA is a separate block like MAC and PHY, can it have its own PHC
device, and the ethtool UAPI only lists the timestamping-capable PHCs
for one NIC, and is able to select between them? Translation between the
UAPI-visible PHC index and MAC, DMA, phylib PHY, other PHY etc can then
be done by the kernel as needed.
