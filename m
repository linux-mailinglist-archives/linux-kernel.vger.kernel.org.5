Return-Path: <linux-kernel+bounces-36207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80261839D84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A476F1C23364
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56965F;
	Wed, 24 Jan 2024 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IFFUdxoO"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169BC160
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055114; cv=fail; b=S8+IdWIEGXIVRIvjMn/ucCUMSjdCAhFM2YFIZ+6H5zUsljv07kLioC46O+KJHr2y3K3dNXinXvNLi4aVK1BVX0OwOxCgQp+MHopxOwCvH2AAY1FwIz8o8+43z9o3a+GPFz6mshmQRfqWfnjJlywAMCUuUp/66dKm9gqBMtE+EwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055114; c=relaxed/simple;
	bh=mj3FGOrUZzJ3LVixmoHy8ezSlisTJH0fkKQiQITSHKI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utQgtfhtsf7Yn/JYILvk+4clVm91QVJdUz5wTnszshNhV4Lq/MtRoZUPgKrmyZA9rRLookLZOdgBi57V9/XziMwoXQou/KiF3oIhZdk1Ehre2g0HIlYBbyWce2TG2qa96yLv34vcDt0CICKUmqevKuTocbwroDTgZOaZ2+MSfLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IFFUdxoO; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCCladrrQ4LQW2vNlHUbw5TL/aQxf5htNSnxAXgX5LEsRVubAaD1VrDdFrzvwS0LYDnc795rHMzuM0cOtvAK5epJzl4V+CZS9l9SKuIhwn417BtzG/c04AuSP6d3H5Rezrms46pyxYsC33ehuD4WG4kaxDmplcUaaEkwwicE86zrvllBVNM+6k+VsD/T9gSxE1qX95cE7+zag70L6wSsvhzy9rgbOS0yBM/i37wqrQlSjvdEkxseLFqdVOJCgFr1vUowP0ChKZlfcIczmT0oct/xWELuPzXgoHZIQyKtLnrAwVH/Y5CLmc/JPPzJOxcuB6nhjoJBwUySL3EpF/KENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUxe03YPtZMzmJvYwUJoCD7iGjPLgu00s4bSszCB7zQ=;
 b=VMTIRnwkz5hmWeO4RhY9peDIrJKe9W2Q25P/N2n/6wsT0trazhuoxiDc2pkVQBWOnc60J6mJYlUITSSYLUk77L5to4w8Bh9y6QpT0CkK3NT2V/OmLwm5nhskpcuZw9ve3QrS/PFq/bbTQVRlHDJPIWBQEATW7WkVIq16d/OsmvPN+9HTHPzSzIGjkUDyMKPfcPS9Gxv1SssLeBVPKbd70ONQO8ljkRfq+zxdNv3mZTpB0/12OkjtOwwWOL2weQuVLBrVTSAMci9FCWVHXhmgTL3JYkmO5fB8xz7bVICIvSIJpIWxrUXkqaP9dhdRUvF7OZSrWFerbGid93T2Vwvfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUxe03YPtZMzmJvYwUJoCD7iGjPLgu00s4bSszCB7zQ=;
 b=IFFUdxoOO8A1HiuCXu1aVYZ7GcawB3Y6dP4O7uy6ETx4wPn79VYoFwgedYz45DfVRMCYwxUemg8S5WwqWGMQPJ2+QjI2DWPNV0kIQ+OJbLSPpJnLnDVpBxrTD91UrNZSSPPkmL3U+KP2J0+1GfuiW+RicTJOGacAAxbO2+bZjIk21KdgPvlAg7Mz40fLkt4leSdAh7GpQqsuU/buLbmUJaCt2um3CxRFjWhSdfvICj+7rqTrYv8xJUqFbO3KbTTOPxkD6/7+eDo89S0ycS0vyxwGq5VMWYUBYnkf5sCkMF329KqFC5KWgBpMbLXfFGKUI8whHLuHpXjA1pUr7EcdoA==
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 00:11:47 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::47) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 00:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 00:11:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 16:11:29 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 16:11:29 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 16:11:28 -0800
Date: Tue, 23 Jan 2024 16:11:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, Alistair Popple <apopple@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <Za63HOMZE2fuJKQ4@Asurada-Nvidia>
References: <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
 <20240122130152.GP734935@nvidia.com>
 <Za6kuE4KUPuwk7+j@Asurada-Nvidia>
 <20240122175700.GB1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240122175700.GB1455070@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ0PR12MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: 66015d2d-bdb5-4737-2261-08dc1c710e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4MqS6rcwxX/umhRYBKsJUyMYZGEu5v0qksaNjnUYe8YPGKfMIeqMhhlG1Iy3WVkosPDh//mE5O2nG7bUNvYmyMG0w6puz5gkRSJrfVdGgO093/yD5kRQOajermteFEsdjch2eyqdIy0kaURjuN84nzAJZQPC6WDkFsaZ/7OvqOHpOnB3Zev0T3D820fk3F9L7/SNLHeUx9FOuegaQOeSyro+6F2+M5sMaiooB5KC8lKnsF3+gnd2ebi21q9tFqrvq6LH7ztiaS2wIC3T/2uU0iLrbKir9d2NaVF3/9T+P1EZxEqXnQsJSjvNsChvX4at+2G7jKilq7qOITlfuueyIEn7T/dbL4hKF0xLF1/TALB181TJbrvqBLNVZALhfSdbkY9qwT58EBPrlxHDf5psn4cAWd91qbxhrSzAioxCcjNNmT9Ta84FnivjlhPFtt6gsi9Yy00HUnfZw7YcYVRJmCbtUREfLkTK0wafBIq6YwVayRncFBo4UHCDMZoM0usb2ZNu1FVz81DErypQOzZ3tWVqxVoXtcQk8wt94V2dHCPvxGeA7rZi2HQTYjQZzCED4BD11gZ++/EeLi0ZRZoMNAfpC5o3iJafyISvIcW8HNmhju9xT8BOBjphiJVqmxM4z26IXUPX1PKn7+xBoDRxgH98QbkOi2zKivI/0G+xW5J1AKglY/umRACZtQKxNLU0LlzwanF4VoGbuWfvhBySSlwWORKgGucITSahAOM8VpkjcQK+T014InCdJ0tPbLomQaZs9axlJd2wXOCO8jeqwzCcrfR2bSJI0cNVa6ox7+odHGgobu9K9ml+hL6wbF6T
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(8676002)(6666004)(33716001)(66899024)(86362001)(70206006)(54906003)(70586007)(6636002)(356005)(316002)(41300700001)(9686003)(7636003)(26005)(8936002)(47076005)(6862004)(4326008)(336012)(426003)(83380400001)(82740400003)(36860700001)(2906002)(5660300002)(478600001)(40460700003)(55016003)(40480700001)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 00:11:47.1156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66015d2d-bdb5-4737-2261-08dc1c710e12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453

On Mon, Jan 22, 2024 at 01:57:00PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 22, 2024 at 09:24:08AM -0800, Nicolin Chen wrote:
> > > Or do we need to measure at boot time invalidation performance and set
> > > a threshold that way?
> > 
> > I see. We can run an invalidation at default max_tlbi_ops to
> > get its delay in msec or usec, and then set as the threshold
> > "xx ms" in the idea one.
> > 
> > > Also, it seems to me that SVA use cases and, say, DMA API cases are
> > > somewhat different where we may be willing to wait longer for DMA API.
> > 
> > Hmm, the lockup that my patch fixed was for an SVA case that
> > doesn't seem to involve DMA API:
> > https://lore.kernel.org/linux-iommu/20230901203904.4073-1-nicolinc@nvidia.com/
> > 
> > And the other lockup fix for a non-SVA case from Zhang doesn't
> > seem to involve DMA API either:
> > https://lore.kernel.org/linux-iommu/e74ea905-d107-4202-97ca-c2c509e7aa1e@huawei.com/
> > 
> > Maybe we can treat DMA API a bit different. But I am not sure
> > about the justification of leaving it to wait longer. Mind
> > elaborating?
> 
> Well, there are two issues.. The first is the soft lockup, that should
> just be reliably prevented. The timer, for instance, is a reasonable
> stab at making that universally safe.
> 
> Then there is the issue of just raw invalidation performance, where
> SVA particularly is linked to the mm and the longer invalidation takes
> the slower the apps will be. We don't have any idea where future DMA
> might hit the cache, so it is hard to know if all invalidation is not
> the right thing..
> 
> DMA api is often lazy and the active DMA is a bit more predictable, so
> perhaps there is more merit in spending more time to narrow the
> invalidation.
> 
> The other case was vfio unmap for VM tear down, which ideally would
> use whole ASID invalidation.

I see! Then we need a flag to pass in __iommu_dma_unmap or so.
If a caller is in dma-iommu.c, do a longer per-page invalidation.

> If your issue is softlockup, not performance, then that should be

We have both issues.

> prevented strongly. Broadly speaking if SVA is pushing too high an
> invalidation workload then we need to agressively trim it, and do so
> dynamically. Certainly we should not have a tunable that has to be set
> right to avoid soft lockup.
> 
> A tunable to improve performance, perhaps, but not to achieve basic
> correctness.

So, should we make an optional tunable only for those who care
about performance? Though I think having a tunable would just
fix both issues.

> Maybe it is really just a simple thing - compute how many invalidation
> commands are needed, if they don't all fit in the current queue space,
> then do an invalidate all instead?

The queue could actually have a large space. But one large-size
invalidation would be divided into batches that have to execute
back-to-back. And the batch size is 64 commands in 64-bit case,
which might be too small as a cap.

Thanks
Nicolin

