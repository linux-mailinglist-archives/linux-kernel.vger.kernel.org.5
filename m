Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57B7F7A57
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjKXR16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjKXR14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:27:56 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53385199A;
        Fri, 24 Nov 2023 09:28:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5+dA69jbopPPKQPiu19v+tnlrTmL/6C0mC7VOTaULzZVbNjEdf8NgKN9jtOV3ihsfpaZ88mxcfgmu5Q94C2sU44xGJ+o0Oyh4DCtaZYAm7dWrXRYvWWl+y8p+vWPYFpjyoZPNLaiwgwkAXltu5FDa8OSCXc+a/FhD51/wbsl3w3Tsq4x5UNIOrbrCPAr+VLx8CxfA+ggKlp1JEbpaJvGXuJ6tBluNCfzuvIA0C08+Zx0FTAWMLKqu2Y7v0j6jWENYcz4057JN8lsgoim0yO8ADCsNLUaC4GYAVyn06mcqdFfXnfeqJaBGDiY/TqRPmlkuiJaz+1PHwFCYK48szaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpWbXAwNAFXhYWLV4pokPM9F+JnBIAcMW3sm5smYZDE=;
 b=bR7LzQvNLq9HVxx+7/R16d1vpyxPchZt3v2bHJwoSBmtKUJ8j8HtyQDOW7Y4Gwtzl6d9OozZ1P9CkDB2x6Nd3zLliaKzVpFL9WvPbKcKEUheHnHv2OJerEtrtFNiELPvDrezSRjnLYLFTHx8an9LLxB7VJwQvXb0JewD+iicv3kj1uAXl/i8uBz07oi/372VYwj9BV3kYPkIMRa7Wxr790un2ey4ROHqzu150A3P39FiHLWgbwoIdFMOiIQhpGADssx1R13w9sLouBT9T8QOKUPQQB/yW7cFPIFodIHD+aD2VASFykL8K6vA9f5hfRB54mQDZVDLhNkDcjCuGeKPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpWbXAwNAFXhYWLV4pokPM9F+JnBIAcMW3sm5smYZDE=;
 b=fbDsiiGDAakKQBM8exePGqNDBZC5ZRB9k3eadNlawln4oVkuBTPZ+x1/fB7FmZ5jfSFPSzsScP9O+9ij3S/T11JbupuWbg6N93Nu05Njm2pflS27N+13QM3ZIJBH7L0eRjrqZopw+P57bLALTdAawM2ziEd9dzNFSFYyz7pL0LA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8845.eurprd04.prod.outlook.com (2603:10a6:102:20c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Fri, 24 Nov
 2023 17:27:59 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7046.015; Fri, 24 Nov 2023
 17:27:59 +0000
Date:   Fri, 24 Nov 2023 19:27:54 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Willem de Bruijn <willemb@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
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
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Mahesh Bandewar <maheshb@google.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231124172754.tneftor7uobrul5f@skbuf>
References: <20231120220549.cvsz2ni3wj7mcukh@skbuf>
 <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
 <20231121094354.635ee8cd@kernel.org>
 <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf>
 <20231122143618.cqyb45po7bon2xzg@skbuf>
 <20231122085459.1601141e@kernel.org>
 <20231122165955.tujcadked5bgqjet@skbuf>
 <20231122095525.1438eaa3@kernel.org>
 <CA+FuTSe+SOFciGf+d+e=Co22yZ56gGGkJ0WBbvfT-2P0+Ug8DQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTSe+SOFciGf+d+e=Co22yZ56gGGkJ0WBbvfT-2P0+Ug8DQ@mail.gmail.com>
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 289e765e-fc25-43c6-7bea-08dbed12b420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W13Vh/6N+iw1aXd2AnCtdVncDF+SNM8N0q8QbHfpvYPyS7XSySNqO2UEPqQKwvqHOZElxzzTflNdGt5GoYDcHB2eGqtyfS6qHwvtaffOrHUB195LsSz6xyE51jqEpFDkAdrlmGW7lt+JYJUAgeSZnqSXQndb7WoCXaNH0mbFe5LOFMiq8rzX252gR57/Ho8cHj+zrRvu80jzizInTE9PzTDufy1AMLexPB87EqoWhG8gjbOB4rJGzUuNWCCUJt4NSV+xL8BiNQBwQ+NRMndd98RmZXnTuP3a+CCMHZGbLAZP9pemAzECEtha+/ia2zlBfKMVS3DeAcMt0LhrVcOGQjYKRX11iioiU8tozd/A9kKGQXt2ca5q7CixswY/0a6MNlpvrMW+LNbXJYkO9K7BcXVsExZYW4jZsOVjmvyNxDEQZry4fTAEE/Gug1HVhiGgQRhkzdf/iCEiMLb1jfYaMfK22VWrusaYiHyL81mH93tsaXU3hiuuS469dfu9vwhXaqUh6QygVMqzHEBnbgmQcv4pO/ggdjVp5kwBDf3KG/cI+1BzWcOkq1UEumRkjjUEeq2dNRjmgLzuiAIm4lIsQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(7416002)(5660300002)(44832011)(66899024)(86362001)(41300700001)(38100700002)(33716001)(66946007)(26005)(1076003)(6916009)(66476007)(66556008)(9686003)(6512007)(54906003)(316002)(6666004)(478600001)(6486002)(966005)(6506007)(4326008)(83380400001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SNNyT4NY/zs1/8ZnMrQ2AcePNbE4FqkUie0rJq18UDLw7ZI9Y18Ct9ZDME/c?=
 =?us-ascii?Q?fjxTKFnbd5+xhHLw2idHAwzkKAhSgkIe8RqLa8CIVROJt1EV9/NP2BY4DO55?=
 =?us-ascii?Q?CSTJkf+ldfCssnR2s56GoPpy0cF51rN2NJ9pfxW34hzI7/eAa6IyJvS0alYw?=
 =?us-ascii?Q?vBfGKgBFFI+27YtyFIG3t53e6yNVTNAsFY0wabGNHetEZQwmgdIKYNnRjFCr?=
 =?us-ascii?Q?k+sPNJcamo79B3gdqTS2Lkdowr+W7uPGJnSuG+Qzx8jTTHwSGW+Rt1FMNnY5?=
 =?us-ascii?Q?NFrv9HJcmxiLEAE9TyOOhozduxLRQ7poB9KMl/I/ILaJrg7S3REsiuZg97w/?=
 =?us-ascii?Q?a2gFGt9TxQZW0BsOPiV3OeJ4e+rls6fJLOIqMcwpba98tf0tUGNXpJUhsIkJ?=
 =?us-ascii?Q?GiDMh6W2rgHbRR1Ycyw5SuDgm8PqezWpW47Dq9Y/hwig5srlPqOjNFDXx+xr?=
 =?us-ascii?Q?8EqWVB6aVFYxIe+Co/js9e68/HvjyY9VITbWTjwFkyLnj/bF4zr4Kn9Mm++r?=
 =?us-ascii?Q?klr1SDfKT9Ta5IPzfWwWQcYpCVZKojUJxu/UC8/Vj5M2BHssvJep5ATZHarU?=
 =?us-ascii?Q?XuC609GBlBc1as5Z2dmyBL9r+Ekd8pqlMW36fZ37k/YoZewmnxdMIEdx6TJY?=
 =?us-ascii?Q?zkOrew6YYuzhA2mM2v/av2F0DJdebW3MbKXz23VxRdAWDa9oQcMDnuD6IPTP?=
 =?us-ascii?Q?VwSSPcMH31FuQOqMWhCDYbSbcmuNo90i0C24+qRBVBT7c5SEY30xBP4rzKmY?=
 =?us-ascii?Q?EPpUxj4Nvlk1wRONkP7qWcB+FmVDuPHYs3s44oY30n0+uAulMhMqB9rp1CfL?=
 =?us-ascii?Q?vHeLLr/bgeduw+Hj1jWdMF07W6QVj59+XU6Xau5W0SN/qkH4uwiHkf3/wMhX?=
 =?us-ascii?Q?z7/aWKBsIGjpuW7icPBcjQ4sm3ZO09a7hy6sFP9tauuyeHai6sIVK5qmzOFW?=
 =?us-ascii?Q?mwg/g3vHud3/NqxyQCnvDKK2A1Y3C9PwJvkvFE8NxW25Q1d0Ux5NWILJ8bL9?=
 =?us-ascii?Q?NxvtI4jkt3aifLF/kMdseh090YRQv5D3zucqMFkcHmsGRKwgB9rC5ux1VfOi?=
 =?us-ascii?Q?uSHPXEpkdEV4/EUa2STGbTNQsoC/HqUaR2WUfS3uUsys5vXJIxwi1bO7bjam?=
 =?us-ascii?Q?YIxkNGv+da5Prs33jzuSpztYcJADoFpaD9QJ9o/2Uhkwr1wkkamc5REwRPDk?=
 =?us-ascii?Q?KZU66BEZrlS5+/+Is0cofQfuufB9KXmzuntaQquHYGyFI7DWQmMv+RXfezLQ?=
 =?us-ascii?Q?gyTtcEhrm2bVeq6Mv2BKWSErlMWM8pOU+FtNVKXlH0l/JuTOmeYBmTEsQl7D?=
 =?us-ascii?Q?WYYsE4Ul0Wl0P4IEWJHbB66sbeYouNhlduoSbq+mjJixrQKTDXZTUueOtlyp?=
 =?us-ascii?Q?PxGya4FURacVVOBtoK+WobaB6KCBbXYL+KA3jFe4mtghQdeHdw6jFKhm4507?=
 =?us-ascii?Q?C0WIPrOQOK2IIxGf9+jVKwz1yI+2l4kfRTv91IRcoxX9zmcij1621UW6TKQF?=
 =?us-ascii?Q?5ba9M24mvi0EtukGKIvTr/rtdpbENjiyf6N93Nd52GvZF9iOM1Wgr78S4RPR?=
 =?us-ascii?Q?j1yy9N0nXXTk5s24jFxLqgkJ4kSg/6qwIbDCMRDiAhqszFyuNDwTNtSsWJ4g?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289e765e-fc25-43c6-7bea-08dbed12b420
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 17:27:59.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxmJaiUxGbFPUTpDuATMXICG/tRkWGZbGgsyIdxdYz1ZMv8sUM4n1rbiSVBbXYmlzeiVqHbMvLYtA7dxUQ+U3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8845
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willem,

On Wed, Nov 22, 2023 at 01:11:02PM -0500, Willem de Bruijn wrote:
> There already is a disconnect between configuring hardware timestamp
> generation. Through the ioctl, which is a global admin-only interface.
> And requesting timestamps with SO_TIMESTAMPING.
> 
> Today the user of ptp4l already has to know that the admin has
> configured the right RX and TX filters. That is no different if
> multiple filters can be installed? (PHY for PTP, DMA for everything
> else).

Are you saying that ptp4l doesn't configure the RX and TX filters by
itself, just the admin had to do that? Because it does.
https://github.com/richardcochran/linuxptp/blob/master/sk.c#L59

I'm not seeing the disconnect. SO_TIMESTAMPING is for the socket,
SIOCSHWTSTAMP is for the configuration at the device level.

It _is_ different if multiple filters can be installed, because either
we let things be (and ptp4l issues the same ioctl which affects the
default hwtstamp provider, which may or may not coincide with what we
intend), or we teach ptp4l to deal with the multitude of providers that
a port may have.
