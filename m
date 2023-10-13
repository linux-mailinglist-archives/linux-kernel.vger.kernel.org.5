Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1B57C8CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjJMR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:56:15 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9179CC0;
        Fri, 13 Oct 2023 10:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxha38c06wS07yY6+p1ldgxEnBGRJmFvgemcFEIze1nxXOulUeXNbePCgPzCsgc+g3LTZusjOA0clncxFLtFme0UXuDgyKmToT6GMtIWWwvoA6A1VgebhszgeyeeG6/rmvaSZ2rB1EPuV6Z3vkqWXHQbuOkc4TaRivsjqTyYnOHmFh3aJSjPiDUiXq5dnuLgX0ejQTwW+1Lpqm9qvmB8121LgvJo3IcUqDDt/IqdRag90nWdKvfxDqb3ESuRPwVsJqhPwjrllsWHPj6q3OB9+3vQuQUiLgDn286NaZMjSmcSbrlgajpO2/m8/BsL4Oz/gC6/5mptuxhG8bDg5chdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCmpA4wtRtWPuJRvcQcutTTqxAWTnLoethvpcTTQjmk=;
 b=Ne0nuL+0Dt74gJP0QXE9TaxUtKJsJiJTnpz0jYkBgWKnGYSX3PvKb1ur3Xd03UGxF7X9ne+ATE6HDr9a2VZK+V719A53NzWvCcKcbYu9rOJkxaBAM4WylPYefIEdeedAxyCkQ98JLMEPtEGNzHWl5ioX/9PJO3X22AALHMX7hO402350fx8T/4EoG/DVbisNOSjtHy7Gx/dqgkFATdhC0Lsh0FiCoe6Z5KGrLkxPvpmUprWFpGP4wHlI1CpXWBMEQHxkrzh+Muu6ErMxA5sdjGtEV7syORRnZEvT1GQ+EAJGNHIHqUfLAwNi2+vJ8N4DXi7x2TJbZjsHNjOIoxZcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCmpA4wtRtWPuJRvcQcutTTqxAWTnLoethvpcTTQjmk=;
 b=LMFJPBF8Td223yZAosqUuD68ALtHQYDss5fucqbhc1S0mhjygDRiTTAcmQ9fyHe57eMRui/xpRTwhFNEMILultOc1z3kDMxUnEiHFAINecHGT+5FRExOykAR9UTYxLslzxQ30nhNtsbm+mQGFe5YdxjElIqQK0dXl/lSqq3mVJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB7183.eurprd04.prod.outlook.com (2603:10a6:800:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 17:56:07 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 17:56:06 +0000
Date:   Fri, 13 Oct 2023 20:56:01 +0300
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
Message-ID: <20231013175601.5mpyx7cjy6cp6sdb@skbuf>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-9-kory.maincent@bootlin.com>
 <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
 <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
 <20231013090020.34e9f125@kernel.org>
 <20231013161446.st7tlemyaj3ggkgk@skbuf>
 <20231013093056.4f915df1@kernel.org>
 <20231013170903.p3ycicebnfrsmoks@skbuf>
 <20231013104606.174664a2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013104606.174664a2@kernel.org>
X-ClientProxiedBy: AM0PR02CA0188.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::25) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 836e7e00-0b85-46b9-b58a-08dbcc15ac57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3e9IIbZXCYmuMGTdMloc/qj+/eFZ9oMdyidsluVKL+WgjW6l2L9ZFM4tiGZZYI34F9SnYTPaqAVKSmzGJ+dXEMPlVEc9F7kHY8TDzJOafk2xGaOsrA3ghr7qffyxWimB9NHoy+MxNHXg/K7knOJdSlIOVQ8nZanHUifj+tsHyiqR3KX0ylutsYwWAqTLbyCETOQBr16+A9w4ycefn55JQG5hNdwL9QNJ1IfXQAI++IoOXy8lkcSjfLS5/8tPcqMaRoDGMxW08JcvCdoHxvsR5cIoHQoFCOnkJCRb8jkl3+7dOjzScr/hlteabzRhJ7tJFqdIqA0WM3yMzt8JV6o/8Wqt8FFBR8I75dMYepmZ938GEAEonGi3uXaiOIsfrAFt2M6SOpwI+trjsIp36uVCzzkJ7JZNKTdVrdEx77zzRryXDKjrwHWJwCYpJ841uOaieVBcrwQ/SxA7j3PC+2xyD7gv5BOpOrxA9M0UIllS4dQSvjuXCb0wXs42MIdtnuA4lV0Yh40Rhfm10Ag81OdU+ATTJyb/pQrwSm0L1WU8t/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6666004)(6512007)(9686003)(6506007)(966005)(478600001)(6486002)(1076003)(316002)(26005)(2906002)(7416002)(83380400001)(33716001)(41300700001)(6916009)(8936002)(66476007)(66556008)(5660300002)(44832011)(4326008)(66946007)(8676002)(54906003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?veeThAhkDL+JtIdiwG554pbGds13rf6UTUuFDnotCRUIxMEp7coJ77udOKYb?=
 =?us-ascii?Q?anLIxKbr3hzfHPl18rlPLK3CvWr1S8IFzXbMC92OUmyViX+wJ1slHo5zBYov?=
 =?us-ascii?Q?rOMXj2IaWMzRUwh6VMFqYTeccdtPn2VXy6xoL5Pjddyfn/lxJOYWeqZyneS0?=
 =?us-ascii?Q?ucGW6HsOff5Gyrjj3RsECXQSfaCdobnMGwHWcXJNaTxQGTxJmiaSoiWs5/S9?=
 =?us-ascii?Q?T8iHecM984oKj4QRy3HtR9OLRTOT7a4zWdcH5efSVO5VLdvIfbjRR3QYtSPF?=
 =?us-ascii?Q?IVzQUyfTEUSfFMl8AzBEac14ygy2mp41IrbXKSG3oBOEDbecMYQfQvTAVEky?=
 =?us-ascii?Q?VP4lEY02OzMzGfx1lYQjjQaOuW78U58xPEWPpFs1X+oADxjHs9KSyk9VOFxN?=
 =?us-ascii?Q?6ezjDqlowxPzId+pVmk0KRNu35R+202LfXp64slsLeNUKu6gJNHCmIU4Kg/r?=
 =?us-ascii?Q?YojwsLc0KqVFqXghcTZ+fxor6PKGv63VPUu1PmC3qMVDIvlVbmj7pVd8OZbZ?=
 =?us-ascii?Q?DQX74lJxtPN1+rP+9TOxg7Zu2t5/zdWvYTG0FttJV6wWOGGRk1lUV8jx5LYj?=
 =?us-ascii?Q?fa6KFBy60ez2BlYZSwXPM8qH7BKOksD5EjXHXrRTIY4mttdydlIBPUCPt/aP?=
 =?us-ascii?Q?u+WObFLz8kMvLxSulZ4RMJFIiwcFS5t2VKaiBZ4jlyqmAe8bNSu9b8AJhfCN?=
 =?us-ascii?Q?sq8GRp66lFfs823rqzvGEPZCwwA7Qt0nxKA9J2Lh2f1Ah68TqDpR3Nt+pjoj?=
 =?us-ascii?Q?mMw7G58LGhvxhExYeMS0iwyKSc99/itadZoBF19Mbtii1zi8Abv5c5sF6PmJ?=
 =?us-ascii?Q?bsHJb6E1wlS79Z8Uvr8lKBmj1nbqkAUwKgFHSD8QdzggogGQABWaU6gsk/iD?=
 =?us-ascii?Q?49YayMb7rfnEbPUC/6L3ETphl+fLC1Cxql4ZXsKfn/Kf8WfGWCK4arZ3JJtb?=
 =?us-ascii?Q?sjl3zjOOye9JwlB+sr+9lMuu8jIErokRBggIMkmjIA/GgfbGhrmNpFaOiYoH?=
 =?us-ascii?Q?e7kIpJ5snK6BMxl8q2AIfacugtwT02kwh3iwCnvWq+caz+llhTPZwLfzLuhW?=
 =?us-ascii?Q?hmwQgXc3Vj88rqFkutinMs3LkM4c0DJa6G/C1Osq4CFPav+aI+zF3EcWxnEc?=
 =?us-ascii?Q?2xgqLfVN3sdPkZhtI3niAQ2o5/kKNEG5oyeqaJIyrL8Nrm+Bj4o9rm9LB0gU?=
 =?us-ascii?Q?B0DnD1EKf29ivdgylMqym3xlionClkzGAMAizb/3P7g7zr1VAxYgk81dRLbg?=
 =?us-ascii?Q?3PvNAzvJKHw8aeXhJDdjcLuW1J83JZmE0u59qbNzmKeJTf+fh8x0rwKLnYsg?=
 =?us-ascii?Q?I/OAp5fVgUC53fvPz+Z5Wd5gqjxCjAPlaNi3nRqvKo/RS8GjGDzrkrqOx7KR?=
 =?us-ascii?Q?J+xKA9J2SErSdIeqsi5O4n2yPkzNtp051SDLW25/YAhN08V2iuG9imAOxCif?=
 =?us-ascii?Q?ONzWintEmP2YhoH8VypW1kHz9lgmncAV6R8BS6+EEkaH/5bDGcDyTz4Viv95?=
 =?us-ascii?Q?yLdMDFjMpm8bnhjqELWynY3mf/qrsmi255cwfM0tFEnSgfcYiXJsBIgxLtae?=
 =?us-ascii?Q?iMNYV2POqlp0r5C9mOV1eRJdksu1uAgbka0DO+2MTLR0+RfwNHNryeaeLkL+?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836e7e00-0b85-46b9-b58a-08dbcc15ac57
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:56:06.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbkF/VEl2eKCtd/8RbKganXpPziQPpnUGQiVr/T/LOEY6PCjzjgDtimGMiQ23NgRKMTjAh0BCJt/4KqtcvwXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 10:46:06AM -0700, Jakub Kicinski wrote:
> On Fri, 13 Oct 2023 20:09:03 +0300 Vladimir Oltean wrote:
> > > > Translation between the UAPI-visible PHC index and MAC, DMA, phylib
> > > > PHY, other PHY etc can then be done by the kernel as needed.  
> > > 
> > > Translation by the kernel at which point?  
> > 
> > The gist of what I'm proposing is for the core ethtool netlink message
> > handler to get just the phc_index as an attribute. No other information
> > as to what it represents. Not that it's netdev, DMA, phylib PHY or whatnot.
> > 
> > The ethtool kernel code would iterate through the stuff registered in
> > the system for the netdev, calling get_ts_info() or phy_ts_info() on it,
> > until it finds something which populates struct ethtool_ts_info ::
> > phc_index with the phc_index retrieved from netlink.
> > 
> > Then, ethtool just talks with the timestamper that matched that phc_index.
> > 
> > Same idea would be applied for the command that lists all timestamping
> > layers for a netdev. Check get_ts_info(), phy_ts_info(dev->phydev), and
> > can be extended in the future.
> 
> I see, that could work. The user would then dig around sysfs to figure
> out which PHC has what characteristics?

Yup. /sys/class/ptp/ptp<N>/ gives you everything else you need to know
about the PHC index that's configured as the active timestamper for this
netdev. It's just that (and I need to stress this again) the
timestamping-capable DMA blocks that you're talking about, but I've
never seen, should be able to fully implement a ptp_clock, with their
own clock operations and friends.

> > > IMHO it'd indeed be clearer for the user to have an ability to read 
> > > the PHC for SOF_..._DMA via ETHTOOL_MSG_TS_LIST_GET_REPLY as a separate
> > > entry, rather than e.g. assume that DMA uses the same PHC as MAC.  
> > 
> > I'm not really sure what you're referring to, with SOF_..._DMA.
> > The DMA, if presented as a PHC as I am proposing, would play the role of
> > the hardware timestamp provider (think SOF_TIMESTAMPING_TX_HARDWARE |
> > SOF_TIMESTAMPING_RX_HARDWARE), so there will be no driver-visible
> > special socket option flags for DMA timestamping.
> 
> Each packet may want different timestamp tho, especially on Tx it
> should be fairly easy for socket to request to get "real" MAC stamps,
> while most get cheaper DMA stamps. Currently some drivers run flow
> matching to find PTP packets and automatically give them better quality
> timestamps :(
> 
> Even if at the config level we use PHCs we need to translate that into
> some SKBTX_* bit, don't we?

I think Richard had something to say about that being wishful thinking:
https://lore.kernel.org/netdev/ZGw46hrpiqCVNeXS@hoboy.vegasvil.org/

On RX I'm not sure how you'd know in advance if the packet is going to
be routed to a socket that wants DMA or MAC timestamps. And having a
socket with hardware timestamps from one provider in one direction, and
another provider in the other direction, is.... not sane as a kernel API?
