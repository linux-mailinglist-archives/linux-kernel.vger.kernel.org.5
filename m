Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA87F1D01
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjKTTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjKTTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:00:34 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB92110;
        Mon, 20 Nov 2023 11:00:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auxoFr32gIDgHGnSldYfaZnEFiajFMOlSuIe1v5TSXyBkH72y74p6wpiUtrVrbmdQxTLbWa3wdp2MaslGW0gdxkMKlGf82IpM/iEr22BYVrKsEx6ex0kFdXnXA2dZ7ij85BrB8xkHa/9t1vGHBbeXg2FLHD2L+MXGqCYcp4LUadM+u7n2ANKErzLm5Pwh0jTCZYZAaJflHfC9Jsv65nYSu6RplwRBhuO8XGeshrNnlhcbsa77g4GARXeU4U7bqqOIc7b1IRQEsIp61MUQFL72yVqfAQBzZx3UvmkLp5YjgRDg/nPiEOkFIDAnJmbaRtK6omO3zqdleUH2QR3xfwCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjFgWk6xbqwmX2w5m+KL7YYfXNiLEGvGUJC49wx9f88=;
 b=PhpuKMKrk/a2vZUkE+zIbqP2acTAn9nKlnp0145Z4qgWg2Tzb1Xa0J5xagrT3d90lzEUsNeQek7ehuanvAq3I3AtOpHCmNUdU36irxRobPil8RTI8GfywsbqZqBxJ+zmsC/Nh7eAQxLDqI6w/I23yQOpOvR6EnBS7T+HeXnywtO/rWae0EWX4hWlCCoRO8+7GYRe453PaVt5hnxJrZf+MwW1me8TOvD56h/hmZumoKAsQ5wgBxcjjB6e+BG0CewNxL/+MpBM7WK7cqGigGDM9J7uIKUMpbWjQV3F34c8d6gxNc8dMq8Rag+n4Zs5LwI/MvabkrlCaIEiwVGNqPg46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjFgWk6xbqwmX2w5m+KL7YYfXNiLEGvGUJC49wx9f88=;
 b=SBW21hBrf3FpTmjt4y1X5BbFaLOwHBHtIXRz65rZTk1sRAu4Wber8TQbtmxEz7AWCFSBjDRFw6O0wJSrIG3O/+yATkA3NXg3AbSOT8UbaAmYs1Pu46SIel8taTqyq0JbmeCv3+AxwyFJqr0PED3BR2zQ96e8B2LbgeTq3ywi0O0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8694.eurprd04.prod.outlook.com (2603:10a6:10:2dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 19:00:27 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 19:00:27 +0000
Date:   Mon, 20 Nov 2023 21:00:23 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <20231120190023.ymog4yb2hcydhmua@skbuf>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
 <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
 <20231118183433.30ca1d1a@kernel.org>
 <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
 <20231120105255.cgbart5amkg4efaz@skbuf>
 <20231120121440.3274d44c@kmaincent-XPS-13-7390>
 <20231120120601.ondrhbkqpnaozl2q@skbuf>
 <20231120144929.3375317e@kmaincent-XPS-13-7390>
 <20231120142316.d2emoaqeej2pg4s3@skbuf>
 <20231120093723.4d88fb2a@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120093723.4d88fb2a@kernel.org>
X-ClientProxiedBy: AM4PR07CA0014.eurprd07.prod.outlook.com
 (2603:10a6:205:1::27) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efd792d-2472-469a-801b-08dbe9faf58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0EZFJDrbXMxgYldlI0R/fx42DpbXAkDbIR2gtgdcvRPhvS3BtwrjXRXK4hLw8WmKjdkBZXOa2PRtxuGSdy8Hi4eetthyJG4RBVXGhWTOsaqcTOwDWWhurDJ/ZY7oXrUuReSOv+69TFP+P8Hkr9RmrwWZJnDd68jVrZI3q9c2aVnRrf9/dE/WpZIV6esA/FonWLiy7nnDKZ9XBYJp7g6jboDxGt0UNZDqeo862IALeFAZ2bewsxzbRcbJRIsYQajgnf8Q+8kfW6Wmem/zGGuGiMAu77WU+ffTyZR2IMAarrqWcTjgvO6k8fPLp6evze5opxU/8KRnrogheFvCpNv1wD7E1tZ/uzPnkABr84+YgTf8f5ZMInVIa8RB0bfYj4+V0JqdPI9zszXi/1o/oSWZq1qcBp+yH7qY21TTEbejgKCejSmAHWk04Boy16hO6egKnx6NzjVc0G2teMI6TN6vcKNVk+Hrnk+URdsGhbrJnZGoiztVsj6EYoFTYP65/xK/csM9stcMXvG95o/j/cNuzURI8FXhxNQ7YIHPXgw+EMJuHFF3NwMmGQWAi5ujLRD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(6512007)(26005)(1076003)(6666004)(9686003)(6916009)(316002)(6486002)(478600001)(83380400001)(66946007)(66556008)(66476007)(54906003)(44832011)(7416002)(8936002)(8676002)(4326008)(86362001)(38100700002)(5660300002)(2906002)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?khAMglkBP/70k4Buhga35KngCQc2Xja19ZzmuXFxtteSjCC4fkECY1oUhV?=
 =?iso-8859-1?Q?YTyPfJj+bFUrSkf5uK1XeycANnx8g4o4tlKuORb1Phk2yVWXhyCozK6D+h?=
 =?iso-8859-1?Q?/DcazAH8KOU87SR2CTb3nbs10WyRUGp4mlva2oSkVgi5/DEl7uO1+xdQFV?=
 =?iso-8859-1?Q?8k31p2RSHKwBmjsRYahfeT506X/+FWQOG95aPnqrCKKMb5ikRA0roqU8Wm?=
 =?iso-8859-1?Q?pWhPdoPsxQ0mKuA9uLfslpRw/HrkAhGvdX9goh4ubl9Xj4gR/lO0eia3Ha?=
 =?iso-8859-1?Q?k8QdaYAg22cTMf9ovogfBOmMVftLZkOeL0luAY0JGSHgTr4h1qYGZ/J3kD?=
 =?iso-8859-1?Q?xV2UhwKftAw2L2W7HgJlreeIDRyg6P5MddAnwZ1J1+yviSgsRftM6CbGpa?=
 =?iso-8859-1?Q?dhl4YRTXgvM6mrcI4LjERpblEwYmCFL2uyS8kcSznacEXrrU9wAcKOOZBz?=
 =?iso-8859-1?Q?M/tM20A2yYdOB8C5qkJoBQeRDvbOCTMPqCQANd8u9/0BgGzkAFbKTV0Ujo?=
 =?iso-8859-1?Q?T1naKf8f2G8+76FzyxjsfgVpl4x2EbD3HZ5xfTHFyg/4QohCYJ9JnrXkp3?=
 =?iso-8859-1?Q?kUV5ZxpZyiZMCbYC+/zZFzbQCvM+myUVfBUnj2Nb69WQZe4qGVHYLTzGsJ?=
 =?iso-8859-1?Q?0iNBzN/Wg/1KIyoWn25XU6GiA1uTTQNtuh00E68kjFI4XtSc09tNX091rh?=
 =?iso-8859-1?Q?mJYPeCMKMMySgBOs96wnFT0uVneFKkxmdJUgiTRtkelTCUAifY5SEjcuvj?=
 =?iso-8859-1?Q?zSfHXlfToXXGQYY4rvIW8VkMgCp8lEdxL7wd5VwWoGcfC6LbevukzunEZA?=
 =?iso-8859-1?Q?fd00rP2uN1m8dF5k/8zOnrIjfvxfZ10iDQuViHYvAYWJzAeGe3dsb9Ji1W?=
 =?iso-8859-1?Q?N4p2YM7In+lr272feR49I2XbGZtAZmI6H5VJFVqn+EbDeYQHYPXkrY8sba?=
 =?iso-8859-1?Q?asfTPdWxkfMX/7iv2t8R+rcBAlkUGVAZ/SFmhKtsIeQ6AxZO17aLtNosbh?=
 =?iso-8859-1?Q?uvya6hAIRPBhKU39Y0TW29dsrspR8/4huIkfaceH1XIOuavR+oroOU47d0?=
 =?iso-8859-1?Q?VNKCDkEvCYg1YNlzNTO+7muVUad334n5/yQNrVgJBRi4j3KGmlo/gXp7R7?=
 =?iso-8859-1?Q?EqXYLgMs0cGyTzuDuADc+wwytoP2YtjzBe6hv3Pe0YC7Q1vs1vvv5IsHIg?=
 =?iso-8859-1?Q?FyK2+A1tCHYevYWIt7qsaL7tuL2jSZhB9RtJOJX0TNE0eYohJCDBP4/bMp?=
 =?iso-8859-1?Q?+RSjnXVNAcf7yXPIrL1vC1ogMepfsU4R+7tSn1LKWxmbIZmJA8pz3kvhrN?=
 =?iso-8859-1?Q?aedW9Z8dVYnJJNYYcthY+uCyN6KiuQBk3dJ9n7gQRrU6NoZ8ZMY0WTaZ4D?=
 =?iso-8859-1?Q?5MtnWrtWvYJlMpVgtv0oK0O7Kr7BFQmaD3hbIqXOFq390tvGs+Mb4BuKU6?=
 =?iso-8859-1?Q?jW4g2LqfdiYXvN68L1HcCu/mqbg934P6D+EcnwKeMLU5PsQp06UeEzBp4K?=
 =?iso-8859-1?Q?lUqtII6Qf7/pfcM60b4Mr1cog9ePkvVCcgl528MGNAaP9Z8ECPuuqL/hhi?=
 =?iso-8859-1?Q?nGCAdRDxEs229DYTy1Jt7+6wc+2UZ3gBpQh3dbTeO8srSmplx/Q8QiDFU5?=
 =?iso-8859-1?Q?biOOO+3VipCnf8DtnY9GCaRSrCEt4SHCZ2W4nk3Cv0JqvaaFMGtAN37Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efd792d-2472-469a-801b-08dbe9faf58a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 19:00:27.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQFb7Yn5MtVxaT3DdZmAyrj7jo5TgMrGjDz84LEVKt5Wb+wFdapjk8ALlcimJpDi5coxoQFxhi2rMTpX+UFKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8694
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:37:23AM -0800, Jakub Kicinski wrote:
> On Mon, 20 Nov 2023 16:23:16 +0200 Vladimir Oltean wrote:
> > In previous email discussions, I was proposing to Jakub and you "what if
> > we didn't let user space select a specific layer like PHY_TIMESTAMPING
> > or MAC_TIMESTAMPING at all, but just select a specific phc_index as the
> > provider of hardware timestamps"?
> 
> What about my use case of having a NIC which can stamp at a low rate
> at the PHY (for PTP) and high rate at the DMA block (for congestion
> control)? Both stamp points have the same PHC index.

Well, first of all, given my understanding of the "laws of physics",
I think something has to give in your use case description. I can't
see how on RX, the NIC can decide in advance whether to provide low
rate MAC timestamps for packets going to a socket and high rate DMA
timestamps for packets going to another socket. It can either provide
MAC timestamps, or DMA timestamps, or an unreliable, unpresentable to
user space, mix.

But maybe I'm wrong and there are NICs which can do that filtering.
If such NIC exists, then I guess a SOF_TIMESTAMPING_RX_DMA flag should
be added to the socket layer, and the NIC driver provides timestamps
according to the skb->sk->sk_tsflags, and that problem is completely out
of scope for Köry's patch set - and implicitly compatible with it, since
as you say, the device-wide timestamping layer - PHC index - does not
really change.

If I'm not wrong and the MAC-or-DMA timestamp selection is NIC-wide
(which diverges from your problem description), then neither Köry's work
nor my "everything is a phc_index" proposal will bring your use case to
fruition without further work. Here I would avoid speculating, because a
lot will depend upon the details which you haven't really given.

One question will be whether, in the case of "NIC-wide DMA timestamps",
DMA timestamps should be presented as hardware timestamps - struct
scm_timestamping[2] from CMSG_DATA() - or as their own thing, that user
space needs explicit support for - by parsing a new cmsg level/type.
If DMA timestamps won't look to user space like hardware timestamps,
then the use case is again out of scope for Köry's work, as far as I see
it.

Another simple question is - if NICs do this today - probably by giving
the "unrepresentable mix" to user space in an implicit, hardcoded and
very fine tuned way such that nobody bats an eye - then what is there
more to support? Are you looking at extra UAPI as a way to legitimize
hacks, or do you feel there is extra control that applications can gain?
