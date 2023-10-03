Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80CA7B65ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbjJCJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjJCJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:57:52 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2060.outbound.protection.outlook.com [40.107.215.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D17291;
        Tue,  3 Oct 2023 02:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzKHhnOCCgDRCxePCiUbbAywgXAO5oxRZeW57rDffMubhmPEbVdz00+/etDJTqXGmV7tB1ZFECgpLlyTlGF0c1SlDhQonCl7iLwmhcl3kajWem/bMilAmiGCFbeTH07nuoiDY/DPzirDhQyLlp7qdo7nMhZVElMmrvlW+PO/+1HyvqDbSePK8TpayGnLsppyJzhGcpu6evgQb3CjpxlQ0HS+mKbIio6CDpPWW2Jg5mcbD040RlSrx6BwFutvYenwYVB1Jx5p24iHWJJE1a2fxCQUtDEfNjynHmWmCOWkMO+6HpjUwXHCYNno7ErxMo5CSGSlUZzYfGhem/1rBlUWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beMPptTS38oOm3/K2oivq24ZKbBZrRcEqCqyS691/w4=;
 b=Yvj7b5xxa1LCh2oJoUq0WskzsxIGgjz+FnHYWE2YyI/ymSdIIGx8xixXGArblpmx1VfD5eE3Ivlzx3phJFYh021DGgIVw/Ers7hg6KICzrYZ53XaahHH6z8k5mcfJSZ6ixQF/dN7Fw37IW7BKvXltTHkI1qmYgEAsmN6gs+DGPbQNK7wPHOGTkx7rA4EIPK7pVt6CNuVk+s0fLtZ7mVvVdrtEFmH6SVba7ZdJhe7c7u4+32GTigBvTZC2BWl4p8mInM7ZOjPKfYIvEELcfLdnAQui6Hl+btTxZ6S7r6weGd8ER6BF65SF5X+L8rFMToiPV42MsRUEThkZJ977fnwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beMPptTS38oOm3/K2oivq24ZKbBZrRcEqCqyS691/w4=;
 b=ID476V1nRe9MktTE1ySkOfNungMEJZdGUCBqyA7h4uxAcC+YJrO6sVgpAKwsW+n9xX5d6X1mElJNr/TTJvPyLuVFwdsHZC0JmnRsuTs8x2KuP/t4wpobJolgCGM89AtUF0Lqw0e2Qos7E8d2RrmwLdglLxoyfWVXQr+B8dj4Agg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB3810.apcprd01.prod.exchangelabs.com
 (2603:1096:820:40::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 09:57:44 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 09:57:44 +0000
Date:   Tue, 3 Oct 2023 17:57:41 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/4] tty: serial: 8250: Add support for MOXA PCIe boards
 to switch interface between RS422/RS485
Message-ID: <ZRvllYZS3ks+dOYc@moxa-ThinkCentre-M90t>
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
 <20231002015702.30509-5-crescentcy.hsieh@moxa.com>
 <92aed0d9-791f-4708-8a73-4c78457a710e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92aed0d9-791f-4708-8a73-4c78457a710e@kernel.org>
X-ClientProxiedBy: PS2PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::20) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB3810:EE_
X-MS-Office365-Filtering-Correlation-Id: 662543b1-7342-4a31-1d51-08dbc3f7308f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvz5edIMviohXxToNeRKkhGe/CTmyMd/Ox3UdRd5mHSMZw+ZRCtgrbST1tq3+tHTH44bV8KWJzOBGa8F5HW7SkhhkKJZDDaCti5MTBWsQPDs+KyU08vo4+9s75hTBoYvFtj4TVRN/ZgiBuDCNX/axXA8ANa9eNOfEmwiwol76J+NCjE5rKQgdk0ItFSOvnoSd0IpjPuu/K9xrQfNPP0ZON007uaCml4tP4M1amfdBwGXnqgMAaCmvupv16iOX3Auaaqeli7GOblH+m20MqNfDdA+nX048yZan8fmCEbkP8wSEEh2tvn3gwBytT6C3VQHd8Geu7lpR/sxAy/hBRTgE2pZmNRFuPFEgP/7ZJFFKJ21rsGf5UNI9UQSj2rkXM5vFTFUnmrM65uho+YzJdagR8HtZik6SDn+L6qgqPvZB6MLXGLUIv+s1OjcvGUKJa6psMWbFc8rBAUTIxeAgnFPgM2oLWQ6HBdJYsZbdboGm6LbxnB+qzEZQOakJAaNbfvrO7EigZPCpTbbh9Lko7vU2PGWTw0o+eqr05X5aJqyW8hbi925bUs1IuiRr2BkTFte9scQx4oVRVX6LXTgJODJzuvEkk9xUN2tA7GtRiFREKwnTLD1k2OO77A/H9ErcQMlGRUiBSm3pOW+M75incbFxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(6916009)(9686003)(6512007)(66476007)(52116002)(6506007)(38350700002)(38100700002)(33716001)(478600001)(66946007)(86362001)(6486002)(26005)(66556008)(316002)(4326008)(5660300002)(41300700001)(8676002)(8936002)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NxuYp3/G8kPHdtoDE/IlXUMWAXYNPUAlnKGzM5FqlXFoFY5l81Ct9/j8rcn5?=
 =?us-ascii?Q?xgifl6V+NC87kL0mCjSMpwXWw0oUzGlMnUR7FShyc31OrS1LXvEQqC49mKT1?=
 =?us-ascii?Q?WTrlyiT20hCiR5sR2O85Sy++3X+2Fnt/A+YdKNIS0bfxYeQhAh4o0lfJaj/P?=
 =?us-ascii?Q?zL2pm2amnGNH5x52ekjzXmrwE4ljW4n2b4upMZJLN8+7+u/elTglWnd9DKm/?=
 =?us-ascii?Q?JR9W3XtXGuE8C7dr5zSL70EfuR/psFcecvqVILbX+koSZTAYs/iRyLusp0Yu?=
 =?us-ascii?Q?RFweRF1NrpCpxVV+gL9bqkwndj8ioLg830YYWANODHOGkm4/Kf7A73dWcFt7?=
 =?us-ascii?Q?5OwpuwCjA96WhWM3pA1ncvaz/7KLrJEOaA91n5EjvL6FNF2sjgZcIE18pmI/?=
 =?us-ascii?Q?rPsbAMxLhxX6eROjQv2vDDDUL3f9rJPupqZrvH4IU6Bz8NWzbmzyFxD+hUzR?=
 =?us-ascii?Q?Ds3J7yyrBWevS36MDBNq4Ze+0CUa2+CLyU5sW+VvRG+FdV4+8taRtd2vAIBL?=
 =?us-ascii?Q?WNugi8Je54hMlyEmHP3cuV45RABK2nFBwcQ0CJRvoJG1aZBQg2gid2s3uQk4?=
 =?us-ascii?Q?TqpmCIDFgUlm3aRg7MUithbwDsfXt2Lm7w1E5orAm3TG/FKMTDp/GB5ZkObe?=
 =?us-ascii?Q?Xx3v7N7JXqkWHA48X8DUf2bq0Pl4X3MLgpJcrCYT+tnDyzt4DI9ATYOCM9BF?=
 =?us-ascii?Q?BTeNKVJo59S9npHmMzXWtuaXgKdwTkGnJmSy065T123CteXHu/rTTw8to51G?=
 =?us-ascii?Q?No5m9rPXKKmhL38vv0YnD9hfk0CmnMkD5kcLhKz3gENZvreukx5hHX4NsJID?=
 =?us-ascii?Q?l2VHKH0GcG/LkKOKDOEL92aj1q/3zbC4fTukMnwQtHBtdbS2xRU0fnt54kAg?=
 =?us-ascii?Q?UE7L+By8HMsuDcz5aVLXRk5XW/q0MOwzvqTMoJrgMPYD5KZKV7uiOrWhOJAY?=
 =?us-ascii?Q?eHpbqBYYPlUUp0BvmI5VSq70VGLQoaRa5fVRbZvep7uL4fWNc041rv2q4Y4R?=
 =?us-ascii?Q?UncGXss3RsI2WHP13fsf946USJvjzD0HYBXsoYlBlqlUo4zkmVM+3ycxBLHQ?=
 =?us-ascii?Q?lS/hakbu/yaLNqs/nSkf0jfGnv6HgnkBacnNje525mH1pBrh45FXmCldQkpB?=
 =?us-ascii?Q?Bs5GhgiTIzeQfLElQx6MISrBfbjdjPBEO/zN1yefch8sL2hp2gm8tL/6QisY?=
 =?us-ascii?Q?hmK4z1rWu5YAaRAQO3JeJ0Ijng32dc+f2DGHbiWfbcJT1/qznW9aBxZjvysy?=
 =?us-ascii?Q?GQILwLE7Q4WAibfqlzWv3Mf2xYYoSHZrZlQOxSRPcLMfk8dWt7gshz9gvj1V?=
 =?us-ascii?Q?VibycsmfxItIFMGm/msdTlc17BAE15JjJyDo+1ofhFelCGVM7vA+Vzaue+sh?=
 =?us-ascii?Q?K4yEJbPeqsudNEWegVf7hVUtU1LEx3GCDjl4XJa8unHxAVk4iqiH3mJX/uCr?=
 =?us-ascii?Q?a5eQ9DSDSLJixgfVJukmw+HzHKIK+iKuqkhBRBMyS/yJlhjxplh0NTXmRR7U?=
 =?us-ascii?Q?lFo12rBvroQEA1C8WufOlu1MMJU1wUsq1RNxreTzTUiFYOxNX1SAQvSd+Olb?=
 =?us-ascii?Q?l3WE3tMdwBMFNs7AVmLWhlDRBw9Csf7UsmaZ0w8pE6iwl1xCa2uVY96gSRp4?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662543b1-7342-4a31-1d51-08dbc3f7308f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 09:57:44.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5rpATJnBX8uYzbYkuzPVAf8KQeA83u2ztJVS46C5XmGQ4RTJdCywG/s3twt38KqR4qjxl5xnaaVwq9Fa4PXgvSJiBVWNQHebhKfYhTUncQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB3810
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:19:26AM +0200, Jiri Slaby wrote:
> On 02. 10. 23, 3:57, Crescent CY Hsieh wrote:
> > MOXA PCIe boards have 4 serial interfaces and don't require additional
> > stuff to switch between interfaces:
> > 
> > - RS232
> > - RS422
> > - RS485_2W (half-duplex)
> > - RS485_4W (full-duplex)
> > 
> > By using ioctl command "TIOCRS485", it can switch between default
> > interface and RS485 if supported.
> > 
> > That means, for RS422/RS485 board, it can switch between RS422 and
> > RS485 by setting the flags within struct serial_rs485.
> > 
> > However, for the RS232/RS422/RS485 board, it can only switch between
> > RS232 and RS485, there's no flag for switching interface into RS422.
> > 
> > This patch adds a flag call "SER_RS422_ENALBED" in serial.h and modifies
> 
> Hopefully not SER_RS422_ENALBED.

What if I use an existing flag within struct serial_rs485 to represent
RS422 as a workaround solution?

> > @@ -1299,7 +1299,7 @@ static int uart_get_icount(struct tty_struct *tty,
> >   #define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | \
> >   				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
> > -				 SER_RS485_TERMINATE_BUS)
> > +				 SER_RS485_TERMINATE_BUS | SER_RS422_ENALBED)
> 
> So have you tested this at all?

I have tested it by switching the serial interface using TIOCSRS485
ioctl command, but it seems that I send the wrong patch which mistyping
SER_RS422_ENABLED.

---
Sincerely,
Crescent CY Hsieh
