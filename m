Return-Path: <linux-kernel+bounces-166864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA938BA110
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2EF283908
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2444917BB12;
	Thu,  2 May 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l3WESkyi"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFF15FA74;
	Thu,  2 May 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678015; cv=fail; b=Bx+GtFh2k14cpuU83we2TCfU53Or5BkLuXrk6ceilILzlmyBsyox0OrNpAp5jhyCRvhU9DqdEont4RpRHj8cWiAtyMPi07+X8TxGCdbzEWrpkCI9qf2UKO1gjTq6RHPOx9UNgjVzPlSjxmQlVsWmVlm7cnGHj1wngnzU355sL6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678015; c=relaxed/simple;
	bh=d7iLaENmq7K5u2WNyJc9MDYPUK7gbjcAvWDcr57raGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IscOoiZi8+std+TXNZ6cKNLLg83efqFEbvA3Z4iDlNxLKsVq68nTD/Eq2el8JioN6ZatnFzYf89UrN7FEapI3JPsviRj/cWmIR0eGYTtF5onNqmneJ1XaVuRRrfWRoVfzI4McdWwP8ZPEVTIGr8VJUcfgCmc4E/qur7D5dyNxPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l3WESkyi; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW/g/m+/4mceI5tsmTBEYprJTgH3ednwFN/nXbI93ypCFnCiVy5EV2gQegTyCsmAO5KEBHK/HmZn0X3orQxLupRl/CK6qXrtDEz+YC5s+gqQnNRkQPdXONqLP04DSQk4TfedunapmJE655kYmG+R5Q6qwriW0lUlCFj25u2mrhT78SPXuCqk7UtUXIa6mWImkKylOjfgZBOkS2tKh95l0g1PtTCCjcwwSOgmohITskxHXQv8S7Su6hHuN42+5TMXswyMVD4HyG4Bg9Ah6JXV/Oxb/elQ63dR45HMJgqqeopqRVdWwDW2cdK/lRMjqdu5ALU3zut3eROO8cRUvJgBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZlAZQJW4ViXUV7ZL4h5lYMjH4eipfjBIhhWPYQ/Vc0=;
 b=lu1cAldMaGCbjJ3xMbZTnIhnti4BH51soE3eA+f8DRdnGPbcIOIyFCvdzRhAOkZc2FDVaKbiI2UyreyCDFp5MYD+5q8nhg7qY1NpW2BucjaHEWfNw1aMoJDxTRKnAzPtfOm9qRV/D5uCa0fOzDzSp9zKptTfGWMbKDrq0YuXW2wfUTo21IHzYSAwNtvMU0XJmms8U8xkKkwIaeWVtZWmBW81qteS0wx7JGwm+eKuUzmwUDUdpmk9uqe4wQTmhGsAA5Hec8OB+lD2h09TdrQQlK+y1KP1cjM8cMHaWecbiBsL/mqBUp+lVEeiqolAWSmVKN+qOC4nn1LJHT7IHCCsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZlAZQJW4ViXUV7ZL4h5lYMjH4eipfjBIhhWPYQ/Vc0=;
 b=l3WESkyiHe5AadCdumE2jolmidg1x0JsychYjoXisbYcAlbj4cXmx/G26DiHdR2qb7hB0GRaI52HxxQY02RfXnPZrddI6EtKTStKf8WnZ+mtn+pjpr9DCjTTT0RpUAmdlmADyL+ZRxlClrpFrqqAEvFVhb3Opijo9LKxUJNwt6NktKX37Uj5rddKbcsbV0uwkUvawBufLDEEEwTaVD2MMr8d8PNhtFUB3hNo5ECXX6j8fKHCgLY2NRZYqzjJSbiulplLqXRcG+13jAaKSxLr4J30hGQ3AiEPGgdKRPl77oYh2axp+HOgBCJse7Q2whQ/7PiyI/NUSAyBKUdusWwJLw==
Received: from CH0P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::18)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 19:26:48 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::90) by CH0P221CA0030.outlook.office365.com
 (2603:10b6:610:11d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 19:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 19:26:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 12:26:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 12:26:28 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 2 May 2024 12:26:27 -0700
Date: Thu, 2 May 2024 12:26:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <ZjPo4qUXOZzLsHW8@Asurada-Nvidia>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <63414546b1eafdf8032ac1b95ea514da6d206d63.1714451595.git.nicolinc@nvidia.com>
 <20240430163545.GS941030@nvidia.com>
 <ZjEztwhd5AN1FTCk@Asurada-Nvidia>
 <20240501130042.GC941030@nvidia.com>
 <ZjJ/S1bawYkfs1I4@Asurada-Nvidia>
 <20240502124103.GA3341011@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240502124103.GA3341011@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8995e8-eebc-4bbb-c106-08dc6addcf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4fOi2EdwrINQiVhBTg4XIjV5q1rsOR53MwDX6oNv5sG/9GKvPj9kEEJNb0f9?=
 =?us-ascii?Q?Ri0PpTpvKPaC0nJ6gzN8vDzdbX9Z0gzK77rQycl5U74a5qto4qUv9yTakX4H?=
 =?us-ascii?Q?fjwDTEnyYdLR5DAiWBXmG1YRkFYr/EUPwiJZE2EH68/vo2ezUoeCDIUY9F0z?=
 =?us-ascii?Q?DtzzGrRr6UZZVeMh5s8bRMT+B+ACyDvQqMSN2DqrZgKaMqV/opBsl155Ncay?=
 =?us-ascii?Q?uvv65mPzi5jnyUlQYUHqbulXCEkp8pZsXitkZj+kX/Jy78dLzHPdWJEtxb2S?=
 =?us-ascii?Q?aOWZPm6mj4E9CxcRO1CylWzDp0EAZKuANiaKK94fsZuVX7Yqb3pDn45Omt7j?=
 =?us-ascii?Q?VA9KYpK2TxK0pLCtcxXsMEz2x87gDrPdFp/IqeSrfpAGawFMSF7PXNEcPkYk?=
 =?us-ascii?Q?A1ikEdlR7uVx9vf/an0n/5PrSPjR6GEoN61dd2qpMxuvP/sTyG87sXFdCvUw?=
 =?us-ascii?Q?HD+YkKCY8Q5ummLXxP3NtjuuSml4BBb+vrvvNtN/VOBEDx0IzTA9A7rok1Fy?=
 =?us-ascii?Q?VtNLp7KfkBUbXWQe1zcK17IbqlFCdQ/mrcY3njdzAE+hbXpr6EhCVF7t298X?=
 =?us-ascii?Q?82abIP5IU+fVFzLhOpwnb6u/46g0qpzLuU4ORxF2UK6yL/dOQhjs/ujLAEG/?=
 =?us-ascii?Q?/iN6eqbickN7eukntAgHJItzPDpEhsJeR/JuH1R3n/RLacjTlDW9ymt+fk1a?=
 =?us-ascii?Q?MYpZJUkDJPNVQuTl69s5I8un74pbZY2C63oDTbLQUu8Skq9tY0qZEa/8dxGi?=
 =?us-ascii?Q?tBM+OPj6N1TlHzxgff1jjeuuV9ELXe8sGPh/iiGTh7OcdhUf8V6yDqla0LfP?=
 =?us-ascii?Q?sn9qW7SL/ii68lPdK5u3kt4M8Wlu9QbJFdZKThNCkTYGFnS2HMUO5PSeANt4?=
 =?us-ascii?Q?Ej3/LzQ7zBFr0iOFo3TsRtOggs61pVWud7mrjEUF1+hnLJTspQih28sIf/uU?=
 =?us-ascii?Q?W9dAbiejSlmWv/J/BdKlIUkYE/6h8eDDUk8MuHv8XdXA/R3pHPCv8BZiQf16?=
 =?us-ascii?Q?xEHZbou87gtYyYaNMJCH5ov7+BHKWIjY6RL8GzZj1IE9uIi4a09hVnXreaU6?=
 =?us-ascii?Q?QkFRuQI0XUvlnZ7yUB7Zan9mwNxVkoPaRx6GjnqaJtaHe6O31qx4sOzLXHHB?=
 =?us-ascii?Q?gF1CGuHzvU27gweXyLQFj1eym0/HsXi0f3Lht+JuSqzG/k5e9PcytOHSNtQU?=
 =?us-ascii?Q?2ji5Jz0crMcvqSFFhGo14Dz8+T/g0jBIY4sY86TNAAmMWHtmSa6VW/fk1eHT?=
 =?us-ascii?Q?d1sAYsfRx4QFmV7ar4H+Lyvq6Hbgr7597ZFg0hrzDQyw5BLsYJDYgnFtJ0sj?=
 =?us-ascii?Q?v/oFAC3JGcJZhMltNL/mLizYM3ZgCc0ealsnZAWfr/8px1i7eCwqJhaMXhfr?=
 =?us-ascii?Q?+ISXYs0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 19:26:47.2453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8995e8-eebc-4bbb-c106-08dc6addcf14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

On Thu, May 02, 2024 at 09:41:03AM -0300, Jason Gunthorpe wrote:
> On Wed, May 01, 2024 at 10:43:39AM -0700, Nicolin Chen wrote:
> > > It doesn't fix any real race, I'm not sure what this is supposed to be
> > > doing. The cmdq becomes broken and you get an ISR, so before the ISR
> > > it will still post but get stuck, during the ISR it will avoid
> > > posting, and after it will go back to posting?
> > > 
> > > Why? Just always post to the Q and let the ISR fix it?
> > 
> > Yes, we could do so. I was thinking of the worst case by giving
> > the guest OS a chance to continue (though in a slower mode), if
> > something unrecoverable happens to the VINTF/VCMDQ part.
> 
> Does that happn? The stuck vcmdq will have stuck entries on it no
> matter what, can we actually fully recover from that? Ie re-issue the
> commands on another queue?

Well, the handle_vintf0_error() should fix that and recover. And
rethinking about this, if this happens it's likely a SW bug that
we shouldn't ignore.

With that being said, the viommu infrastructure still needs an irq
forwarding that is currently missing. I'd need to draft something
likely on top of Baolu's work.

> > > So just don't use it. There is no value if the places where it should
> > > work automatically are not functioning.
> > 
> > I thought devm could work when rmmod too, not only when the probe
> > fails..
> 
> It is limited to cases when the probing driver of the passed struct
> device unbinds, including probe failure.

OK. I'll drop all devm_ and add tegra241_cmdqv_device_remove()
instead.

Thanks
Nicolin

