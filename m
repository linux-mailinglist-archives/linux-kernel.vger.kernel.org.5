Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238B87F1FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjKTWGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKTWGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:06:01 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C36CB;
        Mon, 20 Nov 2023 14:05:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktbpzWWFK+zI7FQFsUBbzTIDCPJfEGMNw5kkI/HgUbWIuh50vhroTOZYPieU2vBOPV+2BzhkPfxoW0pe5n4AnBnoEBoNuX6yQLmNaIYHTdfsf1BOviPtFrBkgywXncI4jKbOgIj+cN8Xj1SF4HLOO3YlG4yLRtinExsEpsSimudFcE/U99ycZlehD00DbIerA2h4w3g0XpwkFlW9QqMf3zrCgqdEIrozgGUkpSBnuJQ8pcTwNdewJWdLg7Jif6zPIHzPR24C+eTHaNXFgBi7Ss82MTXmWPrzZH8Bn6ZUGnTH9ffoR6NTlyWbLJZHf9WdxHFoJoFhy/YVvkaJLXdzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vIEiFWDFLgsVdxjBvu41vCGjl9hnaRqyBLV6ov3NO4=;
 b=S3NPRtsu7JN6HTKFvzn5Abb9WPzOFlZAFhwVZxt+cfmjcgRpKn3hGCEVcFrfbtDInSE5CObe9zZawckQXtexz47n/yOssXQnY9gW42Zd25T9roFo/e9A1MZpBkdMJan2xX05LfnQs2d2GRNmPHj1x13o3gJWe+zuSKaNhmvLGAjerQk84C15Zk3sC4VH8a6ji9tEjAOHxr289G3W/wu/4wrjICHmulOFUTslCEpx8Vpap+TVaGRxB4ZbEFUPkO8QOPigoa3PzLQBJIpsc2XIMwJFInqltGq593SCiOI6fu5Hi/W5jx+YyMFOigO/4dINUDZtZgabHlr3e+MgH8DfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vIEiFWDFLgsVdxjBvu41vCGjl9hnaRqyBLV6ov3NO4=;
 b=GMLg8NFD9B7xWXLuELecJSjJFYgCKLe6HfNh/0dB35ddOVe4ezjPBimMk/ZpvfQYX4nmftNmFW/BlrelcJrWT9upvNf06voGSgG+N3sTB8FP0i+9VydlMVfEGpt9wegJlr8laF+/3K/xqFhKmMiR0IlYra11CYMHKV9JQoksRI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com (2603:10a6:10:103::19)
 by PR3PR04MB7258.eurprd04.prod.outlook.com (2603:10a6:102:80::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Mon, 20 Nov
 2023 22:05:55 +0000
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::4dc0:8e9a:cf2b:137]) by DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::4dc0:8e9a:cf2b:137%5]) with mapi id 15.20.7025.017; Mon, 20 Nov 2023
 22:05:54 +0000
Date:   Tue, 21 Nov 2023 00:05:49 +0200
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
Message-ID: <20231120220549.cvsz2ni3wj7mcukh@skbuf>
References: <20231120105255.cgbart5amkg4efaz@skbuf>
 <20231120121440.3274d44c@kmaincent-XPS-13-7390>
 <20231120120601.ondrhbkqpnaozl2q@skbuf>
 <20231120144929.3375317e@kmaincent-XPS-13-7390>
 <20231120142316.d2emoaqeej2pg4s3@skbuf>
 <20231120093723.4d88fb2a@kernel.org>
 <20231120190023.ymog4yb2hcydhmua@skbuf>
 <20231120115839.74ee5492@kernel.org>
 <20231120211759.j5uvijsrgt2jqtwx@skbuf>
 <20231120133737.70dde657@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120133737.70dde657@kernel.org>
X-ClientProxiedBy: AM0PR04CA0060.eurprd04.prod.outlook.com
 (2603:10a6:208:1::37) To DB8PR04MB6459.eurprd04.prod.outlook.com
 (2603:10a6:10:103::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6459:EE_|PR3PR04MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aec3ddc-c197-4c35-df17-08dbea14dde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmsi1x9J7BacTv+U/4xWHPVXleDA71cUiB3EO4wbADb60AlgdENybOl1ESYR6G5ZNZotdjlrRiZ6shRWmGSaKzqI8d0OzWT5URqALZNZxmlOhx0noQ+qlHsjELJm+Fppq84HPDK91JMeFgsF7Lmlwk9YX5dhOAqij8Z/JVH8yO6IGIt/ZWUO6lfNr9Xh5qsMT62TDMDi56iWnxrdA73rhAWuJ4qKYkxDAlhCV+4zA5DO54R9HBFrsC4bijtSKCg1D+MfzBqp/yQbv4WTQaKb5FZ64Eyrsno+dMbGad9FLj+3o9WUrDd/JFTx+L7O6APiyiMMUR+dlxiftzjDjVZCcTVoDS34xQihk1H1dR4yJxcRCiYTBKvL7hUv/mhJlGDbSbZ91+IB0mP7lAD6yRnFyDQUt0FZGk80I2BwmdNOAGSZFbNFqm+qVPte6YVMDZeBEy05FMC4jHXuLW16Nxn3gXQnlu2I1nRVlceIuik7X3YpcWyvQsz7fBKElfvwnpYd0yCpqHGdpyMbzPPxzCREQg9wZsy2y/cGR69CXqSiH/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6916009)(316002)(66946007)(54906003)(66556008)(66476007)(26005)(4326008)(8676002)(8936002)(38100700002)(41300700001)(33716001)(44832011)(86362001)(2906002)(4744005)(5660300002)(7416002)(966005)(6486002)(478600001)(9686003)(6512007)(6666004)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FtK9LRRRGBEUMzidq2qT5bmZQAnNXu/co4U8YCR5LzmeDwvx2n1zFwVyKS?=
 =?iso-8859-1?Q?U5s/ytjCi9JfcttbmN+zQ1ud6gyYyqtui1LBwaWO6PEZiwTXScKF1o14lr?=
 =?iso-8859-1?Q?TL02ggf5AgdXOntQzI5YFVB+qE/6ItYMxiHbqLN92H5HPuLhm5Z2EDKTGp?=
 =?iso-8859-1?Q?PTehZXDXIQykEsuYbEJnjyPpQLZOP7s87XaO2/J4VfpBAZFn0FPZqYLwmf?=
 =?iso-8859-1?Q?MIQScll7+v2uZjRcA7mVZtCKXz6MCndyjhCsykxnJQKU8/F4Yo9nsVoByh?=
 =?iso-8859-1?Q?6bJ5KotUVEFQhtUvn4Ja6lEe33nhPd7qs65mGrEPAufCT9yJNWKV8c7Dmz?=
 =?iso-8859-1?Q?MgbZ02BJw4fkTaag9DVj00MCVBIqhIn5rG+twP7X6Jx0tjyLcK2z7iPeLJ?=
 =?iso-8859-1?Q?Wz9RI/TwKNoRLWLBoqAtiuraATVJmxPc1KbsXdkG6o+zOKrK2Z1byCVMub?=
 =?iso-8859-1?Q?vArYu9PmlC5VTpzdtKEuDsTb8wU1ub+UPX9qn9MCr8IeVWRoTsyV85snIt?=
 =?iso-8859-1?Q?TyLHqNNHGrs5I6ehpOb/P6kmFHh0cg7UTuqjHb26pU0XWYhSntdP20wwvm?=
 =?iso-8859-1?Q?pT5XQk6FW6sN2L9Hczr/xInxsApR6umWqJUEV8KFNq+mizGghL/RaW8gmB?=
 =?iso-8859-1?Q?wPo2d34sI0JToGEjINx+UDXJER0JcoUqCUFl8Wy7ZX0BXpJEXD1Si+rqiV?=
 =?iso-8859-1?Q?t4R8DY3IYboOcDJmOEwNFcLkEw/7ES+2czeVgdGd8rBbEcmgM/pOX5p6vI?=
 =?iso-8859-1?Q?FXGV9UauOLg1F8otM82mkiiE2Nf0UAvceLyQK5cIV3jCqcSl7rMAR4nxGL?=
 =?iso-8859-1?Q?4Ggi6rCJoANZRO982EO42AOcNF1WJEHdDjs2bsGnm0lZ3fR9rtPzfFNRjn?=
 =?iso-8859-1?Q?xZYLBqJ9lurQIuoKgLv890BOSIQQU7efsKjGeSMy/gywJW5uaaFZEVWy1M?=
 =?iso-8859-1?Q?PDxWyvAsvRACv+IgBnOmYghuHul2w/IfvlKmwtqc5Qtumq17CTFvDafPoA?=
 =?iso-8859-1?Q?lobxHMLrcND5r+fMGC1I2ir23n6/6zMq23fpMHmlmq1dZ9esJeqSnJlI66?=
 =?iso-8859-1?Q?Z3C2gAA2hXcb6r2hTOwLrjhgdZkp3Oo59rAcIdrX2zk9ZxV9Xs9sWJk4Bx?=
 =?iso-8859-1?Q?m3DjtfZ8mdWBvxO2NLMijSVGCBKwo2bsNf2PydlsW8OhbiIDMJzlGgVoP7?=
 =?iso-8859-1?Q?a/duEBLBTAMW6IKBdvY7OZFYSu6BGqGatluLXb5LHlRnmlCHe/eFcjhnKG?=
 =?iso-8859-1?Q?6ndHXW30kHzz6JVBUHQH5SCPTyTaiKTPlsJwta5nzoCsZF3wub4JlK83+u?=
 =?iso-8859-1?Q?ZZQQ+C9nDw9PB6d/GgjpImTVSwtJFL4aOkDcz+6GnS/RHhP3Rp9q1s+KCm?=
 =?iso-8859-1?Q?nIkVD6yNv1WdJBWKbmgkeIHQzYlCYlPHzgAsTTojvqvlb0mqahxyJ0arnL?=
 =?iso-8859-1?Q?50bjGD1pEbc7oHuSn1vb4K40fc4vsoPeXwEcdtai/QPaQwgTXCj+SKm+HK?=
 =?iso-8859-1?Q?8KRLlagZDvsTkB7M+uhLssL3NkXvBoNQTRofsnOTUyg955uhtgXuIYU6Wn?=
 =?iso-8859-1?Q?526G4CKaca/2FrtmaScP292RwSigtSEu9IQ1nDgmTkoF6k0xxkMB8KVDiV?=
 =?iso-8859-1?Q?a7feedUsxf6er1v19xrVL9LRJnIxI3xzxB/2wuNDrptcx8iDtOugXyeA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aec3ddc-c197-4c35-df17-08dbea14dde7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 22:05:54.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRf301wSRCNSRu1jjcSUNCRirsMGduvJu1guWEjD+oA4vWXkTGX1WxpmsFMwzgNpPb8GHvjYe3lkwjSzrRbfBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7258
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 01:37:37PM -0800, Jakub Kicinski wrote:
> > Is it an accurate summary?
> 
> Yes.
> 
> For now we can impose the requirement that only one can be active 
> easily at the kernel level. But the uAPI should allow expressing more.

I see. That's quite something to think about for Köry. In its defense,
I also agree that this idea seems the most orthogonal to everything else
that we have or may want to add in the future, and is not likely to
become obsoleted by some other mechanism that can achieve the same
thing, but in a more flexible way. It's just that it's quite the task.

I sense it may be time to dust off and submit the rest of my
ndo_hwtstamp_get()/ ndo_hwtstamp_set() conversions before a netlink
conversion of SIOCGHWTSTAMP/SIOCSHWTSTAMP could even take place...
https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v9
