Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D42F7F1DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjKTT7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjKTT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:59:10 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2050.outbound.protection.outlook.com [40.107.14.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE584BE;
        Mon, 20 Nov 2023 11:59:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2XAM0uo55y7AU+Nv0SXsaDhyj3gj3xpT92Mwy+9MWrNHGV6qWB6nmAeMHzjfagjjX2aniNnX0FnOygnRh8t/pD8L5+iATt9uIurqg18a9vsLG4Uh6zHWoS+VI0HEaOyaZCrA/2ORFOlFkM2Uo8hd4R0wwxEsLPaUmGrDm0GComYhethaeTTYYAJtYMXhj7PGs4S077pVSvAwrGoRTb47MPvSZ/Ue74OKuubnSN6viYsoACypbxnruUCGriiJ8s3oFyGLihcr+QDTAzS6KfZphjdk3XVRtsMYw/QgSGe+n8EmlacHNIgAgw5uG4R3Wr9Pc45EUSOqTMaYT5wN5Lr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsYqAMvGo09QcEuvDMkpnIdd7dwwLh2yhzNYU6abE8s=;
 b=c/2QjZmQO/Q0/FA6qJfmJzxqZ10pjeczYxn8BJnHwAquR5aKYajCqX8iScmpAySW4TqjzlcYT9WaTncjHzAIQ9f4bSnImkbJI3RuN1YxRERhTO/tvCxVlf1vAry4tdfynsKil1n8fj1uRZ+cgH00ANAall3z5tepk0biAVBfKKp79vdHs0BM6nKA5CH4wTkfXEX3Xe8Xt9d6MsxYeOaocpmJuVv3equFYD2ml81d/Y7pc86SwAMLG0g50/gXJ4EsrzHwOJcSoVP3kqD7rSkEsJOacSWAWBg07SMTNUGsmxKzBSp/DQAF7jgBu2/FnrbkFe0UNzuHN4r58mJZzKjnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsYqAMvGo09QcEuvDMkpnIdd7dwwLh2yhzNYU6abE8s=;
 b=bZy+jpU/Sg4yJI4CGsgorOgU+AQgWjG1bnuXeO143zUQ0VCRznCPJX1qxHKMIENSu3PK3HfqcIgrsB2w2SKblNfgPp7AlOZLZCo7Tb2Mh0c1qlORbk2L+GI4wMdv1sMtlQVXyBVWAsiswH5z/Av8p4R2anUEtxyCdkJjEY3RXK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 19:59:03 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 19:59:02 +0000
Date:   Mon, 20 Nov 2023 21:58:58 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231120195858.wpaymolv6ws4hntp@skbuf>
References: <20231118183433.30ca1d1a@kernel.org>
 <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
 <20231120105255.cgbart5amkg4efaz@skbuf>
 <20231120121440.3274d44c@kmaincent-XPS-13-7390>
 <20231120120601.ondrhbkqpnaozl2q@skbuf>
 <20231120144929.3375317e@kmaincent-XPS-13-7390>
 <20231120142316.d2emoaqeej2pg4s3@skbuf>
 <20231120093723.4d88fb2a@kernel.org>
 <157c68b0-687e-4333-9d59-fad3f5032345@lunn.ch>
 <20231120105148.064dc4bd@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120105148.064dc4bd@kernel.org>
X-ClientProxiedBy: AM0P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::12) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM7PR04MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7ce2ee-ae7c-41e7-d8de-08dbea0324d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WF3oHowYaO422F4SdHozFoD8n2ER86braizv5bvfR6bPsgSZl11JUpYV86YMRtR8fN1DX9KKJiybqdbZ1fLR4X34eHMrGd8WQIUA2MketzplRobaZhbRhB2yIlPlh4EzLIwJaHM2Q4dSsr3ozTICKjLwh2xOzrk/Nd3hMwxMBC7dQHo1OClYv6k6Hi6iz0kYzZxL1MgIL/6wRZDBMlOfT9lNwyeXzzRnErBF+1WxvYEXDk95fph15ssDOGaT+lgZz1m1zfjg4MVujlnjSy06G4SDsDyKJ5XV1GbwYY8TJT7MfGBgPYxVH2HOLqlC0tRuYtfYiqxe156jh89Mh5kXST8nGcaAASrZq2x+V5x4NeyogRqLkgAyAbvS831hPo8nTPfzz9nDxhl6mVnGZfF0WxvKMiqvCaGHbvFQ2pGUaQp8T/CvmmxkIAOLOLXSnyGt9FCEsTpqJgF1JkEU/PF76xVSlwrvFnhkFJkIYPc/WWVOb2fJSXcjsMrzltOSWD0eae9XWWAtf5t/5CxqMSI1nQNTgPFUSJ3ZA3UyEb944tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(66899024)(5660300002)(86362001)(7416002)(44832011)(2906002)(33716001)(66574015)(9686003)(6506007)(6512007)(1076003)(26005)(83380400001)(6486002)(966005)(478600001)(6666004)(4326008)(8676002)(8936002)(38100700002)(316002)(6916009)(66946007)(54906003)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PpiRQkNWo1+w3XjjF6YLyNcmn0cJSmC9DdLZTyfWdtGqIlI8Dkxlp8Ks3/?=
 =?iso-8859-1?Q?oHkuNxF8SCwOak/GNp8zXjaVuHd/OnLpZoPzYhm4moT8G4DEZ1/X+1ribr?=
 =?iso-8859-1?Q?5AUwttvE2MKvdIFMHE4UsAQfo7+PT8rBBAGkOQAXWXCfu+c0NXjGuPM5j/?=
 =?iso-8859-1?Q?3127AhRnm2RO6MFbiXvCzsI3nfRFzDfoAkre3cQ8uYX0TEHvIlw6ES5FNp?=
 =?iso-8859-1?Q?hDWldeE5IoIsRX5QcAvtmO+Vf7ZipSdQgcAVrA4b4JJaB8dAT47oRvd7xo?=
 =?iso-8859-1?Q?HKY6xRVxDxrH+bOaXd1IOqLIb+XFDjWW4RLg7iuV2RSsjmal2M3CCdwno0?=
 =?iso-8859-1?Q?QCnsnLB2KJechrUXKBGcxCqv2y3KkhJqlTCl5ptU5C++wxmIE6Ln3XS9SW?=
 =?iso-8859-1?Q?isrX+1iZmMatgE5U8J5HhquG3s6laIxSOxe/aFTjiCHM5Z+F0IoZGEBDkq?=
 =?iso-8859-1?Q?KQkBpSy/5eGTJ/2Ee6HhBS52S7nyixfxczLzokjw5AHLEcmCqohsATTdz/?=
 =?iso-8859-1?Q?HwEI32jpvtsJ2zjRFFCa+iibxUaCg7J3VAO3m9TDLfWhg+vdy39UuxP3fh?=
 =?iso-8859-1?Q?b6ZU4Y4uVTMG8VI5FFB3y2GRQboWk0NfH4XlMbg5Y0t+NmqQTu7M+OP2yD?=
 =?iso-8859-1?Q?wa9pZAhDNFckkEw4H0l0aplZBFZl7vbsUuAT+EaCgw4x0PAOvTyTBukn4/?=
 =?iso-8859-1?Q?lObW1GnKSDCryDEH98b1gx96ZnGG8ScYPETt7TmgaTEJ6cwgo+2J8GcoZs?=
 =?iso-8859-1?Q?lN0h8hRKkVK1WiDUSfC3uYEHxrl/842Sz6N02pF4Tq0pjODRsTGPoWonbO?=
 =?iso-8859-1?Q?iFHUwD4n9oXZCMoCZeIRwn4hJqjeCS1INNnMObhlcVIqER6CtJiB+aNtmS?=
 =?iso-8859-1?Q?cp73EFsMywQKyEWuepFsDiUdW+JbT6hErc4kBkwCdJMpHlmjx4suqMcDYW?=
 =?iso-8859-1?Q?hAIm851U7TcbyNab2ssTDLE0ZFO/RuAOO1XCheVNocQa7tMlCg1fJi0w3K?=
 =?iso-8859-1?Q?6z4HG0nBGhFXa58t3R5DnupdXuodhaT0uAyVrZromYWYa7FmMaN0Ezu9V6?=
 =?iso-8859-1?Q?idPASax0x/Qfu3r5prhBjJkNdxOh+vfS2kyiojNwpanwUWULtEz8HBcZbQ?=
 =?iso-8859-1?Q?hzhh0NeJHiMzGB4i33JpnAoUCSDYPLyOL1MT6qUEccH+BlDFkYbWYYNzBt?=
 =?iso-8859-1?Q?j3EwhRP/vEFTQKL2GEMReYGvzyyUewe5mAJd/yHIJyCF1Lcfj7U4Wvwt5C?=
 =?iso-8859-1?Q?hvwNLaXvDwgvutIrncqvD7xl27HtHFNYcolo95XLw5BjHGN7z5HuK3jbYc?=
 =?iso-8859-1?Q?2ANCtRm4oedXSu18zWJuEr9wM7n8oBmj+LWEYTcnMMkcmvO7Jas8NIoxdz?=
 =?iso-8859-1?Q?05fCImrKenX5+5qiDAesjX1VGubBjHKzGrw3jnoGN2GyPfzIct4iRToltm?=
 =?iso-8859-1?Q?OOZJ33MS9kkcaMmvcoIelWNnUyKYmTyWO12wAqvmaZA1/xaXphSQ8xc7gN?=
 =?iso-8859-1?Q?P6dkdKnvWOBnTw2mSijHKE+xMh8aETfyNYedWnGYydCuMzzumtSdZhQlEj?=
 =?iso-8859-1?Q?p6tKL6y1t8sOihZC5YfUy0Lbehbdi937URhGmyHHkwueqp1hzUuqPhlVwv?=
 =?iso-8859-1?Q?0Mnxkk2iIUNxYx5aeGUrr2bLdN0cd0IYvriL6kRJQx+Br9RriqXx8Okw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7ce2ee-ae7c-41e7-d8de-08dbea0324d9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 19:59:02.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w17UQ76k4xJUhEBfAPmiAi5+ZLlehiD0otZuvqwq3CBwhIG7HYq/xQkLzUp+VJKOhKqpl6wFXkWTKFkfV2K+cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:51:48AM -0800, Jakub Kicinski wrote:
> On Mon, 20 Nov 2023 19:39:35 +0100 Andrew Lunn wrote:
> > Do you know of real hardware with a MAC and a PHY sharing a PHC?
> 
> mlx5 for sure, but other designs, too. PHY, NIC pipeline and PCIe PTM
> may all need to time stamp from a single time counter.

I'm still waiting for you to fully clarify the "per socket vs global"
aspect, but independently of that, at least I understand why this is a
counter-argument to my proposal. I need to tune it a bit (ASSUMING that
we want DMA timestamps to "look like" hwtimestamps, and not like their
own thing, to user space), because the PHC index would no longer fully
identify a hwtstamp provider, so we need something more.

I imagine both ETHTOOL_MSG_TSINFO_GET and ETHTOOL_MSG_TSINFO_SET to
support a new (nest) nlattr called ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER.

This would contain (u32) ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_PHC_INDEX
and (u32) ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_QUALIFIER. It could be
extensible in the future, but this is the baseline and forms the key.

The latter takes values from an:

enum ethtool_hwstamp_provider_qualifier {
	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_MAC,
	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_PHY,
	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_DMA,
};

with Jakub's comments about the various types providing various
qualities of timestamps, given here:
https://lore.kernel.org/netdev/20230511150902.57d9a437@kernel.org/

 - PHY - per spec, at the RS layer
 - MAC - "close to the wire" in the MAC, specifically the pipeline
   delay (PHY stamp vs MAC stamp) should be constant for all packets;
   there must be no variable-time buffering and (for Tx) the time
   stamping must be past the stage of the pipeline affected by pause
   frames
 - DMA - worst quality, variable delay timestamp, usually taken when
   packets DMA descriptors (Rx or completion) are being written


It _sounds_ like we've all been talking about the same thing for ages,
but we weren't.


So, a PHC could offer multiple hwtstamp providers, as many as there are
qualifiers to uniquely describe them. Each hwstamp provider is
represented by a single ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER nested nlattr.
In TSINFO_GET requests, there are as many ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER
nests as there are hwtstamp providers for the NIC.

In the "normal" case of one single hwtstamp provider per PHC, it would
be the responsibility of the driver to set its qualifier to the right
thing: phylib to ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_PHY, and "normal" MAC
drivers to ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_MAC. Here, the qualifier
isn't more than an extra (partially redundant) mechanism for user space
to know what it's juggling with.

As opposed to Köry's proposal (where "dev->ts_layer == PHY_TIMESTAMPING"
means actual phylib), ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_PHY describes
the PHY-like timestamp quality of any hwtstamp provider, be it provided
by a phylib PHY or a firmware-based PHY. It doesn't describe "the layer"
itself.

Does this tick all boxes?
