Return-Path: <linux-kernel+bounces-69273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AED85867C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120CDB20BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF4B13849D;
	Fri, 16 Feb 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CJWXtv2b"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877A1353E4;
	Fri, 16 Feb 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113846; cv=fail; b=gDDYnwIdKy8ZVtuQSXVzprVss8sOSsEwmStzkHUXY9VouAKvTzJmPyFUSiKW9vs/bhg0cmIdzHGh1Y9+zcjK7X21CshvCc4oHG97lMpUsC4U1iE9Unk6EpaezzCgIp5Nasqd3n9gem95RA2VQSkjEhoHwE1NazW4KFNKbFxhOyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113846; c=relaxed/simple;
	bh=s5ghp3jSCzu0IR9QYDwda3Vlvkvw64yMH4ktT5pZPPM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=hl/LoS7rLLm8URtpsEVHLgtwwYHD2ExaxokUp8Pl5qlnExoBIYiUHABinu/2tZCzuqS7TXMBb5G7BCrpCBA+dzwqZX928B2p31OoiW4PoiNHPCDmELM9zls+U5HZE6AQPmI7s8sH2OpVxQmGqoJiyevk72Vwd80+DfH+ehHZsFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CJWXtv2b; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scp5Enqht/icmpZOotvRY7/I5jlQPBsjmrxudk6W+g8/BMn4E+nGCq27wdSjWj4Ah65aBdPZQgDQiMyPGD7OkXqggD1H1/dYHr+3jtcsDh1fOgnJncPlxPIrMrJwsMxL2ae+uNyQB+3KXbzyoZGYxUEMMXtHeLoOqbt3YbwIaEV3SghwNMK3CQMURSz2AdnjFKEnIGooNPe7XhmMFY54FsZ0JC41QS8qFNU5lfpLbunErfoiuCMOvkv5OxfsJMZEWIs2owMBTwmU7QFy/NQfgvIdzTMvjc13GXcWI6MB6zV16AtAoan5+opx2T51Alvr6+dH/fcCsFAFs1itZDR1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5ghp3jSCzu0IR9QYDwda3Vlvkvw64yMH4ktT5pZPPM=;
 b=b0jGrXbSMwqgFNedO95EdPcpbMAHECsOKXukQzCZHTPiXhCfxZU0U5rat5F4JhC13ou6OuFPAg1UyVa0xIB7RTpDpsa31Q25YXe2idoI9+LUtOl6ihnx54ZFP/vSsZNlip3/+4okoaXKEW/CRSiD8Q4RuOZ/WlwIb+j8CPinCF5HmqYL/WTyv8dMR6zLKOrm8b7QqGLkClOGL9cF0vbQeAbC67l7IXhbq/kcZxXQ/qrbIv1iLm0pcfoli04Yrh26n+xMQxuminKx4s8pYfV3A2fBX9BcDpMNQ0iHhb8sbntaLDPZEIoCdcskcgkb9ZcAM73Hoce5Nv9/w0w0rYnO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5ghp3jSCzu0IR9QYDwda3Vlvkvw64yMH4ktT5pZPPM=;
 b=CJWXtv2bh/3O5glmwoMqFcyMdJfQF8L69FliI9BYRpzGYoHb5awF6LLEJeNZzjH8dVFTEkLx05LYUC7VwvkYmEK8QMKr988BYpItfjXYMtySqwj7PGfFP/J7I0oS7f6qb0vtOOBT3RTvBsNgiBSJxkrllOn7XDLBGYGeR3A0+FDdUUYeBZIvkdt0Fcd6AVt9bIa3JaJfnQDaPqtEje5SZZbThxUSLbFKQLoo42azszRTD9AGicx7med9olgPk5rWyMbebcsji3x/Q3fLhytlT2ZHgtAePgngW0XKcx7EHfNzmxwSfZlsfysbDZyFpEWAJXPTsDN3GQYJFpyPyqKvMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.13; Fri, 16 Feb
 2024 20:04:01 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 20:04:01 +0000
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-10-510f42f444fb@bootlin.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v8 10/13] net: netdevsim: ptp_mock: Convert
 to netdev_ptp_clock_register
Date: Fri, 16 Feb 2024 11:48:30 -0800
In-reply-to: <20240216-feature_ptp_netnext-v8-10-510f42f444fb@bootlin.com>
Message-ID: <871q9cgor3.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: eef35c70-da02-4db7-9010-08dc2f2a6ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sgCKktBmgB6OwyGYmYx19XODkAzKF4wdsImWkmuxaFaGUxxhdPeT92T6eou/Lpneh1zukR6nXSVhqSdQcdLM2U5IXQ1S486KXQR6FBBQhRxoYKUI8/V5NP0llHVS+LI9Cvhh0y4VhSGcPfbhA6NCOyJTLQhcHp/3HLgZdaPUhGU4+4iVKG7quZ7KwEIVwGFto9WWuUOvpC+HHu0Ltni1UI8UnlShwR6/mPccapI6qlYh6AaD/GTUb0TZZl90Iw1EWvGhr1XwbdlO/SYg/SwTx52vdfx3bUlTCmXkc8Yg7H7ueTQ4yuRWOCzG/BOhnXNkg785m1zzmsMdLOKg/KvRextdywrdxzTMI/VrJsWBegsdd8/EuCg3g8Mb6u0FkxaZ+hzzqrh0hXg2e0OnaEd7ARb/WaF7xmNkq3MH6JfTpkS+neUsMaUvH/vDqpRwRt7ciP8sprjw6KJi6CLVgEqqFHiAmuPo5JqrprVsbFDNTAQM0tRM8ur2UNygCtXeQT6PILy4IW0wvJdcEiPzqtOC+6xiO+RAVOXLyXXJoYvt+q7xu6QE/T8eB9OrZNznl/p1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(7416002)(6666004)(26005)(6512007)(8936002)(36756003)(6506007)(6486002)(478600001)(38100700002)(2616005)(83380400001)(4326008)(8676002)(66946007)(66476007)(86362001)(66556008)(5660300002)(54906003)(316002)(6916009)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LDALfNHR+QP6XMJV/C0JPjaJY15FrZGJY1rlucq/jCryYXFN7JTZcsG6M/rB?=
 =?us-ascii?Q?kFMeKTUySaV6W8hbEXOD4f5t2o+wvNqL+8S/dAUp1vmHGJ+ej4Mh9WWKdcNr?=
 =?us-ascii?Q?s7AFtO1oWR+o28wR2dVtjUOueNGLPucM3nqZu6n+5/XdzDIoJURTmW4N7a8f?=
 =?us-ascii?Q?WCDwL46I0RwTFmszX4Tb/gCdpach7BX/q3k4iJPdvmL03QxQwLbsaXeny/m2?=
 =?us-ascii?Q?9Se5apMYVTghxon60BOyoEhHZ/Oet6/67f6agPBJv+isMhZYyCmh/9irvXFY?=
 =?us-ascii?Q?rKd4jxgS+jmho+M6DPml+iGTLJr/TntY8SGhX14v1nquqC/X4HxtxmltjhYJ?=
 =?us-ascii?Q?QONgyVjn4LP7T5MdGAprDYnuIEp7UtlnH9TdP8LIMKBEKyATQIy/KBQtSuqw?=
 =?us-ascii?Q?CBJEgckW//z9vMrFOA+HSxzpCfXKlRgnj9ZmCT4J7i9RTuqx0cvbvSjxEFyh?=
 =?us-ascii?Q?WY48cPkaa8MSmTmaT7XNKP0GGAfx4WQhnUqFyqexP9mVdNod0RjlKIJ7UTz/?=
 =?us-ascii?Q?ZTYQmCLHMT/kBRyho2QdlSv5K49don1o55ARtoUhgykqka/EHU5fkmnKRRAC?=
 =?us-ascii?Q?9Bdd2Y1IkqYXeHgE4Pf02iLQdzrZF50x0hG68IU2loxiMJyDiMPL7HEp1SJm?=
 =?us-ascii?Q?0oLe4iriw4DiKxazzOC5Tm0s/wC8u0EdkuFpRCwFD0VEiJaeZy65sevtkeoV?=
 =?us-ascii?Q?dsWFZHwATZo4tqcEvB/AcysHc31xdt5JAIrULGuxPBmFokMidCT/PH/cqqHc?=
 =?us-ascii?Q?zUrFkuhpo28Xa0rBBOr0Ok5L/v1ztq+BfSWcczOzIiYPFo3XWbwh5OtKwta7?=
 =?us-ascii?Q?/Bw6FakL0vETnZMOp/pYfb0Eiy6mL+9NTmkpxElb/uC36rqGruDjS5OG1QHi?=
 =?us-ascii?Q?45gp7QauXshjwiPz4m0Pr1q3tAMsaNjQL3r5HanlEj7qMQBqBayfTuddpi5U?=
 =?us-ascii?Q?sEhZipGV9tuqqBdB7UmAikz/DeG3JjZJjsFlMZvaKcL2hymybGqKKHzuqjd4?=
 =?us-ascii?Q?tzo9UOxjSUuDzJVD6hSX7NXvHh5FjRN3C1pxMI6VryA0KQBa/GOtKOhHdV4V?=
 =?us-ascii?Q?iXAPirE/mE/OioxXNtdrfjnivD50gaBXwfyN0gvRxnX0yNjA8NkIfNFI42bq?=
 =?us-ascii?Q?W/vxY3Cit5tpiN3JAzs/OclRUhIfVFT0wFcwNu+5yHMkuvjkRGtVoBXoLA87?=
 =?us-ascii?Q?FbQ5EAexZP9GD53cxZlUXvjZ3S7PaCcPORxYwWL+Nrgr151JTLEnJsUwT8dU?=
 =?us-ascii?Q?WmNUISz2FW7ziWIj2bqq6uIpz6w3sp+QCHn7HrJ8d3O/rsWvWSaLaY/iPyJn?=
 =?us-ascii?Q?sLskf7nsicf8uzzw9nIdW/M7TULmpV9nEjeAgwSfsua9ABXQUJQK+2N+faYy?=
 =?us-ascii?Q?23iFqa7peXs2LolEL/kU61an34YEQ/sBWycoDECfUXLqtjEc8jkN6IhiQ/SW?=
 =?us-ascii?Q?AtL7cf1zkHQ31Mu+Ju0KywmNmEEfbBlT3I0dyI4+i2xmp6fl52bC5muOG1Wp?=
 =?us-ascii?Q?NlVs2nVaCeMINyHsxYtx8ZOorfdsQedtCXcsYBRFR0RA/jFwTQcw9P5LuD2g?=
 =?us-ascii?Q?2O1bgcFSCaQMVRyjHDNxsCgFigQGtlJoMfVjebYDTJDsD3asQACBZ7vju5/x?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef35c70-da02-4db7-9010-08dc2f2a6ae9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 20:04:00.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Akat9Y/cG+SiSkWGteXfjIH40RyATGXEt5UocBWrE8zO8V1fDWicU9wHobuHCCN+lxu/+yzkIMZZnOQJ7ukwrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

On Fri, 16 Feb, 2024 16:52:28 +0100 Kory Maincent <kory.maincent@bootlin.com> wrote:
> The hardware registration clock for net device is now using
> netdev_ptp_clock_register to save the net_device pointer within the PTP
> clock xarray. netdevsim is registering its ptp through the mock driver.
> It is the only driver using the mock driver to register a ptp clock.
> Convert the mock driver to the new API.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Shouldn't we move the mock driver in the netdevsim directory as it is only
> used by netdevsim driver?

This gets interesting. I think the reason it live under drivers/ptp
rather than drivers/net/netdevsim is because a bunch of reference/simple
phc implementations live under drivers/ptp already. In the case of mlx5,
it lives under the mlx5 driver directory to avoid needing to export
symbols between some mlx5_ptp driver and the netdev driver. I think
since the mock-up driver makes for a good reference for developers
wanting to know what it would take to implement the functionality for a
phc, it is fine living under drivers/ptp. That is just my opinion
though.

>
> Changes in v8:
> - New patch
> ---

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

