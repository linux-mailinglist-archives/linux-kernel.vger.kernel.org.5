Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB87D5752
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbjJXQEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjJXQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:04:53 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9AAD7D;
        Tue, 24 Oct 2023 09:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDzIxsV3THiNNk2Bbj7bSFGeav3fnVYhNwuvfflPSH/G3J/7ZFy5nqeHMbQhNdO+kRc9Mkivkl816kkaReQdPXqmjjxNwDT3c0iEdJNdMrpqc3Ucegf5VI3n0Qy8fdHG8/SwmB51GQdf7gPwDjnIw4uwUiUFkx4q0rKIFE4kXcvJbygpd+oCg+fDD6Lbjf7mj3TFQtvK8VFgJ/m/h5iSbLcOnyFfXCZDDmvFXQvvRpyJ47Fr2nwHQ6CZKavK+SsI9CQJwxnM7mFnkkppia3MFlc6mIKEBKlBJamj4Y+In+rFCKFH0SyRdW6fFfbRIeW8YjJr0FWolv9oMKylFNI2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0I74C9jxvpwgBwwFYXn+K1+mC5a8Cy8OVoPgvi9Q+A=;
 b=OSzMBxWAeqk3VLHNeCur0/jGgO07YYRblTi9QxT+s/5xYjCJ970I4iMrkZpK/+csYRDy4s0aZtmtTmf5y+P+LAQ2t56wkehpueS563ujSHR6xD+hDGzbSSujWAFMHKOi1FBp2R3dsVpCfRELhiwpataxfwQXM3qUvOuClFgxyy36SeTW3HI3D8JxGVkEO0LHt/1fpkkJtATREizG37phizi3LxTFKWW9QRHl7MPeuN34kX5eQYNE3jNo1e8f1fIc4eObx/gekpav0yBbzQFGDqUeDBKPT/3EbYtA/Q5xEM+443K4bV1duLXaYaxAbdZTl7fWpvTMLHxxPIVgqEiPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0I74C9jxvpwgBwwFYXn+K1+mC5a8Cy8OVoPgvi9Q+A=;
 b=T0A1dqqO/T+GsUbDWagGVXBCOZ7tg2Xz/hoEUYd91zABkq+1CA/zaCkSDg6yX4Yn6QPwh08KtHDOW23QFvPwmfwqPwDBeTs/whGYXRNncQPIt+Jn/yrOwjel572Dvzs5CTwx5hFDynsf+kTIs6yhMNZpsWeUsQVR4B1U1UOEty4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 16:04:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 16:04:47 +0000
Date:   Tue, 24 Oct 2023 12:04:40 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 1/1] tty: i3c: add TTY over I3C master support
Message-ID: <ZTfrGAyf194yxX4q@lizhi-Precision-Tower-5810>
References: <20231020160027.3663772-1-Frank.Li@nxp.com>
 <2023102105-outfit-legroom-1633@gregkh>
 <ZTaewidgtcDaBega@lizhi-Precision-Tower-5810>
 <2023102457-galore-uphill-4c84@gregkh>
 <ZTfVV3DW8jqH6ek9@lizhi-Precision-Tower-5810>
 <2023102442-immorally-repost-e736@gregkh>
 <ZTfp+c60YOiwDUFd@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTfp+c60YOiwDUFd@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: cefb481f-ba90-4731-5bee-08dbd4aaf1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+MRnEa9VVujF7Aibn5SkdZCuPE8OUDaLjXn1MSmPhnC3BLRMnUUeX/lB0FhQNP9vXx0Am1SoVAnvWDh10pvOF6CGXuvoZs4pYXVlayTtszbIFrH+wmengmZ6Racz+H70aCLf0zNZUzWYsIUbhGrDPghmsTs6BYI3hdMg/R1ZybuHNNNtddykh3ioqR/xiAQ8cly9z5eArU6hS3k9uwhHlJN2bvLQfzI1tGM7UN/ihrTJwyuVUe03mQb735XtimMpuzpUD4gvvRBD3NKr95hsya549mqYRFQKB/3ZCPkd9hkIHTEqhlWKpX6F/2n2zdE5SXjPJ0J/rrCiLvH8dLWQmtZfiDZWuVmvImzz9m8gC4f3277vuM32KxtqGW7chTcOJprJQ5zE5sV7b95iTt7X0EganlJub9nCiSE/OH3BvQiQBrKVXSBfAbAFEEzJXvF0n+I1ZMgT4ylzCGxZuXCnHcgtA7SV6+vJzaWSDQR578VGt2uYTwdysnEpA90I6bG6snFQyJI0F1GfNRAxk3OJh5ADe92+SGbJGBu6qSAmSdh1x9Ni4p9C2K7V2LTeQ/1T63W1i6aCu6Plpb4TaXtDwBT4ZGODOC2Tn0Eo1STFMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(38350700005)(66899024)(66476007)(6916009)(66556008)(66946007)(86362001)(316002)(38100700002)(52116002)(83380400001)(6512007)(9686003)(6666004)(6506007)(33716001)(6486002)(478600001)(966005)(41300700001)(8676002)(5660300002)(4326008)(2906002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0mgIpQz1JvXUbiybvP8r3S3zQf3nCtpMftvoACKIR4KuvhfQ8GHsqA2PZkAd?=
 =?us-ascii?Q?8kC9K03jB1BFGGTyB4Rtnc9XN1Th8tMiNh5JE13bXkbDAphViUDVHLywjQix?=
 =?us-ascii?Q?CF4p+EecxdeZlc/zYb2AzU29yLaRe+383g9j2fRIgx0mM/6+iAszpW04QE9z?=
 =?us-ascii?Q?PNdT7y2UVbh7tuN27fGYisPkz79nZvW95BCL0nWf/PPqkzP2I5zS4GsgXRrW?=
 =?us-ascii?Q?Ykvb7foy1WA70Wgj28CYlGw5oolKWHpGhqjUDPDPAr4RCsVzlBHEXu3VTk8J?=
 =?us-ascii?Q?EXgQNnIdAh+1TPuD9oYV7WEpPnGGMY3aoCP9pL7ZNOg5/lX3PhqRPbE9yP8B?=
 =?us-ascii?Q?+BJNMWZ6ikDOHfb8ceu4Wm70FvB6ZbHezPlxIpvDl5MO5z6nKZ74dFpx6muj?=
 =?us-ascii?Q?wIVYLKImW1ofxY7UOh6MGVoIlMAIMqqBnnc+fcVHXnpGhLfjMD3iG0ftEpvr?=
 =?us-ascii?Q?/OqlTlsm5kO6bxrLMMNdTcG8AMtsqjEkicP43NDGlrXYzOpBh5FaX6srafk1?=
 =?us-ascii?Q?LEUQQ8rb31x1doNvCYyoTpY47CIAOi2kVB2G2KCAghA/3eF7BPWV3gJiF+U1?=
 =?us-ascii?Q?GpMAkd3ClA4ACXgotBsEBmOCan9a+FuaRSw4rt1T8YGxYSXlTfgggaikB4mt?=
 =?us-ascii?Q?43KsbCOgY6KDDjJCYJCSKrSpZ0BZGY1ckre8H5GHiE6kg6aL+furMHAqGRak?=
 =?us-ascii?Q?QkI+bb65MxPi+nNR10nJcfCXPA17u/No6UYDdgYH5LI6l5wwU38AJ7X5hVTO?=
 =?us-ascii?Q?khVj7dRVgaasLFsKQ2XhLsIf0PALIsoZRO7yn6NSSAwkPNQixBjO+69GmFZz?=
 =?us-ascii?Q?snAQUI00cIU3AfWVlSPYdcXQj+dIZVnXEknVkALGfIfv1mmLf/CtSSopfDYi?=
 =?us-ascii?Q?HzomvMDmcZW890CuxXp5ozAVU7ttNooeaTBfS7VKZ0VVnSVBBwZ2940E4Qli?=
 =?us-ascii?Q?GYcW2bCwtGlQ7WfKsnMKrhMrGUdMWIWuFxp3slOBA6GxZm2MC5uBvnmQrbX4?=
 =?us-ascii?Q?IpW7QXD1UoTvP/AmBGi+WehxJPmxspNvYkf00JOACgqe0DTa1SnfxjN3HppX?=
 =?us-ascii?Q?+KOv4RSuq9GAg5bgBmIOL+uj3/8KP89QYM242gK0zAFv36iWbuTVZru/6y/d?=
 =?us-ascii?Q?Up9lgLU7DRPqx8Llh5YDfdS0FA/lLe5nqHSb/SqZNNnAP1PFeSKvDaLathn0?=
 =?us-ascii?Q?jNSZoR2Hdg6cfaBsF6n1AedwyilDiPz6WKoDYXfmyIYWgp0G11jHlEwI3JnM?=
 =?us-ascii?Q?zssbQtxJtNuNT0Zslwx/E2V+Etf6CiYCBRjCq+b7ZST6KonqW9M/WMCxZE2l?=
 =?us-ascii?Q?7DpmR3KsBFtksYv6LdIpyP27NZzGMhonAqcfETZ+5jMSpe82pwdLhAS4PaD1?=
 =?us-ascii?Q?MZFJ7aPIMI+pDsKU+yc+4TGsDDm1JtPNE+6DHes8VQ2sDsLdXNFA8D2TGKDP?=
 =?us-ascii?Q?k1Ir4A5ugM1fi3CBTaBKOj631jQ4NJSEBErPMYt2Pt1sIWzn5TV8cQvUJby/?=
 =?us-ascii?Q?gbKlY+dSo6PlgsM0bjxIsS3TRTf07VPl/mYSYHojVZZN5o2fjsxcpdh+4AzX?=
 =?us-ascii?Q?9cEjJ8Ao+UJ9SmQARuyRNDlqUOzMnuKZdt5HKlZW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefb481f-ba90-4731-5bee-08dbd4aaf1fe
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:04:47.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd06OypoTvIyBfd1SxOb7gqd3qKoOKzxqkomb8OU86uQHIE7/L87Y1XVFI+wLbvjQRC3lfh8vRRHCv1QHNPqTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6991
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:59:53AM -0400, Frank Li wrote:
> On Tue, Oct 24, 2023 at 05:05:47PM +0200, Greg KH wrote:
> > On Tue, Oct 24, 2023 at 10:31:51AM -0400, Frank Li wrote:
> > > On Tue, Oct 24, 2023 at 11:30:33AM +0200, Greg KH wrote:
> > > > On Mon, Oct 23, 2023 at 12:26:42PM -0400, Frank Li wrote:
> > > > > On Sat, Oct 21, 2023 at 07:02:40PM +0200, Greg KH wrote:
> > > > > > Note, your subject line needs to change.
> > > > > > 
> > > > > > On Fri, Oct 20, 2023 at 12:00:27PM -0400, Frank Li wrote:
> > > > > > > In typical embedded Linux systems, UART consoles require at least two pins,
> > > > > > > TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
> > > > > > > present, we can save these two pins by using this driver. Pins is crucial
> > > > > > 
> > > > > > "Pins are crucial"
> > > > > > 
> > > > > > > resources, especially in small chip packages.
> > > > > > > 
> > > > > > > This introduces support for using the I3C bus to transfer console tty data,
> > > > > > > effectively replacing the need for dedicated UART pins. This not only
> > > > > > > conserves valuable pin resources but also facilitates testing of I3C's
> > > > > > > advanced features, including early termination, in-band interrupt (IBI)
> > > > > > > support, and the creation of more complex data patterns. Additionally,
> > > > > > > it aids in identifying and addressing issues within the I3C controller
> > > > > > > driver.
> > > > > > 
> > > > > > But where is the serial data ending up at?  Not a normal uart, what is
> > > > > > on the other end?  And do line settings mean anything here?
> > > > > 
> > > > > Currently, it use slave i3c code. 
> > > > > https://lore.kernel.org/imx/20231018215809.3477437-1-Frank.Li@nxp.com/T/#t
> > > > > 
> > > > > idealy build an i3c->usb dongle to bride it to usb acm. 
> > > > 
> > > > So no one has built such a thing yet to determine if any of this works?
> > > 
> > > It is easy to proof concept by I3C slave code and USB gadget ACM, then pipe
> > > two tty (ttyACM0 and ttySI3C0 together).
> > 
> > So you have not actually tested this?  why write a driver that no one is
> > using?
> 
> I3c slave side tty at
> https://lore.kernel.org/imx/20231018215809.3477437-1-Frank.Li@nxp.com/T/#t
> 
> I just have not tested tty to USB part. This patch is major for tty -> i3c
> master -> i3c taret -> tty now.
> 
> As my previous said, two major purpose now. 
> 1. Save two pads.
> 2. Test i3c master and i3c target driver. I3C target driver frame was
> written by me and posted. It needs a driver to verify it works. In stead of
> write a test driver (such as i2c slave, pci-endpoint), it is better to
> write an actual function driver, such as tty. It can exchange message
> between two boards, which connected by SDA/SCL.
> 
> Frank
> > 
> > > Of we also can implement a USB to I3C class standard, base on this, reuse
> > > this tty driver at host side.
> > 
> > Is there a USB I3C standard?  I see i3c descriptors assigned by the
> > USB-IF, but haven't dug to see if there's more than that anywhere...

Sorry, forget answer this quesiton. Yes, it is standard class. Spec is in
usb.org. I have not found actual usage mode yet. 

> > 
> > thanks,
> > 
> > greg k-h
