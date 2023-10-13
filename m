Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18F7C8C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjJMRJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjJMRJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:09:17 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35C10D;
        Fri, 13 Oct 2023 10:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T58sSTUkS23RsllWeJe250cuZkKALMjZOgSrSg1yCbM8ktd3gC+S56hdjYtMGFokROy3m1D8hsNAEVhIQeVUzz3buI7uS991jswD8ZtVJz13dNjcqkSF+e6nCPEep4HSOEHFQ0795jhvOmdTMh1VjxP1MR9jxUtIvEOBsq8+LKZSQYbip76uhlLyBbO7P2QcTW+V4e3EqILI7jduYNkWC/i93skQ/RDEkjtnj8reHbsYnIs13Bl4dlywuREctD/skPGVOaoHoy7XuyhyRAjreli3EiMUSM3RuFCvSO+ugu8rMaA8oLKcHugvt5stHzWcnLd7yBLterECmLRPdhChBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3j5Y27JqMf0tk51QS1c8jwuqAhRWkQD1EXqUhK8fPw=;
 b=ROVR15HAzlNXbkN2BycLC6jseDDtWniPdvSXOe/GG/Xp12DaW30G5s8vsZ8T/4vuYsCf8U3n7oz8wgiQza27ncPO4JXBAPEjw2r86BUWb7xXdD30mECw6OTrUnAN0tVULV4N5wiRPT1n+kfmui6U8o4q+ONHxd3WUucUVAR2oektvKXdgk0fznEPynwX4VTtP3XTGDt/VZnAsln6dhmAQMKIzO+V6PFo4fLzyU9zB3oEzSIK4oBntMzPT5gaMgtzhD7BwwZ9lteFozsXAxX/FKZLlY48a3AM6wHoOPNtwqnM754aOhQ9l8k4tMgfJwnV7/3VvFqTJGLnLCjl3gh/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3j5Y27JqMf0tk51QS1c8jwuqAhRWkQD1EXqUhK8fPw=;
 b=onqfNYU8kRGG4m10OU8a2Wmr3W9ATReql/pVRHfDCTjynEtF6RMgwKULMcik2RBjDgUx2q/a6ixbA9RYyXreKckoFCUo1RZpleUgtrZoISYJ6g4hmgvUOgBu0AgKTsrGf6fBNZD8AKKSTp3v6C3+14Fz0V2ZQGQJkHfZy9nBWGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 17:09:07 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 17:09:07 +0000
Date:   Fri, 13 Oct 2023 20:09:03 +0300
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
Message-ID: <20231013170903.p3ycicebnfrsmoks@skbuf>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-9-kory.maincent@bootlin.com>
 <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
 <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
 <20231013090020.34e9f125@kernel.org>
 <20231013161446.st7tlemyaj3ggkgk@skbuf>
 <20231013093056.4f915df1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013093056.4f915df1@kernel.org>
X-ClientProxiedBy: AM4PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:205::17)
 To AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS5PR04MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 015429ae-84a6-4945-7023-08dbcc0f1c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6HARZuZGBydXuxuGWPAkTI4JoNaSX54JUptUz9zfTrQaAOqySsSD5nopk/n30mpM81R5XLErVsR4PCG6XuogzD87zZHNvHwleg0YekFA1XKqxZUtDs3dT0rQeTOVYf/q5R953EVDAdD5i5EHH3k4nkimlmUr9AT7p3AU8JPw7sltK0sIIbW5FW8k9a2SBM/FD6UPl9wz84f7oyT8TmzlWVjD+jSrdh8hu701rmHeYJZBEturCZm2khsCu/g/plDg3I4hn73L5tGi7bWxnrH8FW+6h3hbf6iqHlbJEZpyaZh1wGq4Koff502KsPSTZy+sJIkImv1/FS1Dk+F0LwHc9896DlynAnmTc+eAmyRbujYaHTuXuYZMx/yDzBNoNM3Ljk6DaAITKJyNcXgVd9CvsisV3tILh8c6p/VSYQbpEROrZF8YiXeAmqQilWGJJZIa/uDuinLYTPqgL4X1FuwLvKtCMBH35Qm4HtxMYUfPVobgby4KDz+KUHC+8sekti+f4/VIWaDSj2Gu/icMxpMC9EeS0g1WVSuRI5Ed6v2yWCyrwpXRgnka7sz4oPnLyMo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6486002)(9686003)(478600001)(6512007)(6666004)(6506007)(83380400001)(86362001)(38100700002)(2906002)(33716001)(26005)(316002)(7416002)(1076003)(41300700001)(66556008)(66476007)(5660300002)(4326008)(8936002)(8676002)(66946007)(44832011)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7w6n4PiJQBLcaGnH/YCHJbiVp/TwuX8pysY2YNP3Pshdsd+Q4T0wJh8GmABK?=
 =?us-ascii?Q?bVIDYlFip9APGbWZtMvSulDV21y6QnU5qaNCEfMWqB7QtdNFtXApyKFw2/I0?=
 =?us-ascii?Q?BhVdAKGBpj6iWOcJjfzu5A7Ua/G9ZRZEwinq8iKkiMcG2O5q4n7KIogWhlBB?=
 =?us-ascii?Q?SXEuYG8tCDXU+d5bjIVx2TesoJFFyEBo1ZKnQbApWFGBmAyK8FDXk6RwqRXK?=
 =?us-ascii?Q?zEQ5+lb1uwDPaP0AbCoPSa37StS/wk6cywMIhB5ikq5Toc13rlMbMGihRSH0?=
 =?us-ascii?Q?RJ0xt3cQFHTGtUdpm2Qk2O+mzUBkJUwILrKPSSk3UUBXqLnkkvesiGbsI7u9?=
 =?us-ascii?Q?lhiypSFzoHVBiAYbqVYSDRm9u/w3Lug0RupR08llySn3692Grg76Lq1Qx/rI?=
 =?us-ascii?Q?eIAooXZdPVsFm0iYl/FvahxI7sYIwKExvF8oyQ7axzXdxMA39OyTf4Wsa8Zo?=
 =?us-ascii?Q?u3VegJzUfyR5Xj0eB9Zu6Hd1yHaCFx/Cb02sIsCkboClkZc1Als5UxKqLlgB?=
 =?us-ascii?Q?Ngfj0DImCJDd/JKoTQlGzWtJu3mgrS6Co3y92v9gow4KzKDFdRnxXgvjL62/?=
 =?us-ascii?Q?R7orGzcTpWf7ll6/Ty5MlQfn4VmYGwDL13pVM8ZWYItJqjU+jr00/IJ+9hY5?=
 =?us-ascii?Q?JYTg28ChfsWn8ABdnTFb308HUWsQhNb4P3EY+Aam/IjljkOMQcWxwlEzKz6h?=
 =?us-ascii?Q?PMumjCOZeLwfs2AMHjhSmpCri4/d6pMvYaUA8JjzRXvxgHF25trPPhecM89i?=
 =?us-ascii?Q?1ZxjKDjNWbVHPsmqXH41d78hqAvhZAhXWf4sBzL4VUycPRJaMVv2kwIZfw05?=
 =?us-ascii?Q?Yv0D9fLXqcrQokkHpE9ngQVZ4Av1shjomUFFSxjZZwPjvXfGfauQdB2k6/bc?=
 =?us-ascii?Q?xmLLvtioj9bKI0ESSKf4Ff2A6qWwPvQG9wbZsEl1LyPACeEZNWzgoRV8b76L?=
 =?us-ascii?Q?AVycVPwDDSTaVZukoaAUOJZupAjL14Smg1TmeaM1X1Yw8WEpQ8CHlRl5KVUv?=
 =?us-ascii?Q?U/9vdfNfplSN84DtnhNULX9DZB8cmpojYPIyOsrVpBgcxjfD8aLxj+sAyndp?=
 =?us-ascii?Q?HPr4rkq9jflDNktQ6Ulxq5Yw7fYy8uA2+tTeBS5BVhPvbShBDGlmZzjdAwRn?=
 =?us-ascii?Q?krRKN8RFbCP12lbwrLhaaOPGs5q/x7uLnfDlbcpO+ZdBALO0aWrXfRaeGMHc?=
 =?us-ascii?Q?GtP2H63HeCrQ0MT2IMl/H3pmasqXjmt72hQs7aoATEitgFPfHP6UvgDAVEWw?=
 =?us-ascii?Q?cktfaNQZQqry5Kd8qHEMaAxTAzsktJULAOucz+XO6VukJmJE8s/9Q2FvnXbx?=
 =?us-ascii?Q?6bkYVDntE4zsgJ3hDM3DjHLXK4BZDjIrbttrOaH8tc1ss9FGH2ORQxLzldfG?=
 =?us-ascii?Q?uRuY5p9zvIS0f1DQi+EkpiA/CNgM/uuXTKW+/ev2qWP9um2sObY5tJJdRZa5?=
 =?us-ascii?Q?3GSFUexp0Ojtf/9aGUoH6F4pyTIzI8ZU1a747KJRHQR2dzjm7yqxh2PMzZ9W?=
 =?us-ascii?Q?zE0v33OyQAG44aGC5Jiho9JxOwFXOCu5Q11XOdrT5fsXgGcE+6YvH4nan3U7?=
 =?us-ascii?Q?jqYZ6hqb2R9r0LBG+34wlwwXAuu+h8MJ9AKctX74uEzyKXFZZmwMuLHGOhEG?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015429ae-84a6-4945-7023-08dbcc0f1c58
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:09:07.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLW5TEKvgvMWfqVjZpaPKltkaNZy4vI+t+OZaO0CZ7cLdQX7HThnS/8l57WS2YULmFVEbU/DE5/pyj1K9cleQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 09:30:56AM -0700, Jakub Kicinski wrote:
> On Fri, 13 Oct 2023 19:14:46 +0300 Vladimir Oltean wrote:
> > > What is "PRECISION"? DMA is a separate block like MAC and PHY.  
> > 
> > If DMA is a separate block like MAC and PHY, can it have its own PHC
> > device, and the ethtool UAPI only lists the timestamping-capable PHCs
> > for one NIC, and is able to select between them? 
> 
> Possibly, I guess. There are some devices which use generic (i.e.
> modeled by Linux as separate struct device) DMA controllers to read 
> out packets from "MAC" FIFOs. In practice I'm not sure if any of those
> DMA controllers has time stamping capabilities.

The answer is not completely satisfactory, I guess. My proposal would
only work if the common denominator for a hardware timestamp provider
could be modeled as a struct ptp_clock, like we do for MAC and phylib
PHYs already, and we call ptp_clock_index() to get the phc_index that
serves as the UAPI token for it.

> > Translation between the UAPI-visible PHC index and MAC, DMA, phylib
> > PHY, other PHY etc can then be done by the kernel as needed.
> 
> Translation by the kernel at which point?

The gist of what I'm proposing is for the core ethtool netlink message
handler to get just the phc_index as an attribute. No other information
as to what it represents. Not that it's netdev, DMA, phylib PHY or whatnot.

The ethtool kernel code would iterate through the stuff registered in
the system for the netdev, calling get_ts_info() or phy_ts_info() on it,
until it finds something which populates struct ethtool_ts_info ::
phc_index with the phc_index retrieved from netlink.

Then, ethtool just talks with the timestamper that matched that phc_index.

Same idea would be applied for the command that lists all timestamping
layers for a netdev. Check get_ts_info(), phy_ts_info(dev->phydev), and
can be extended in the future.

> IMHO it'd indeed be clearer for the user to have an ability to read 
> the PHC for SOF_..._DMA via ETHTOOL_MSG_TS_LIST_GET_REPLY as a separate
> entry, rather than e.g. assume that DMA uses the same PHC as MAC.

I'm not really sure what you're referring to, with SOF_..._DMA.
The DMA, if presented as a PHC as I am proposing, would play the role of
the hardware timestamp provider (think SOF_TIMESTAMPING_TX_HARDWARE |
SOF_TIMESTAMPING_RX_HARDWARE), so there will be no driver-visible
special socket option flags for DMA timestamping.
