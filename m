Return-Path: <linux-kernel+bounces-164320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7276E8B7C45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813A4B25607
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EBE17BB16;
	Tue, 30 Apr 2024 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kF0d8B9b"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7458176FAC;
	Tue, 30 Apr 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492285; cv=fail; b=QZdGs9++H4UHqXa4/hplU64PwK2HUXM6wTP8IxSJDs/KRLcBqygppv5YhEbV7P+jxMPe01vyj1pt9FX+SNrcKfQHCxo0WcH0M9O88Z3z+qTcbI2s+sei4dOUgQ0vxNuS4dt99fZZeyVr/b4RADfSJ+zRmLq7bb/7wL7M5fxtSoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492285; c=relaxed/simple;
	bh=E+eCVsqIaFqH+T1em3QbyYjpZoCP9/J4OPJLB6oXKuA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q41cYhP6gLvX4O5QgjeLWQujQOTEnH17w6yg0qnQTfl9GfnNYNfFmaUD+wT1tdzT52mhloO4eiCMUTSUx1Q++m4K/+4HK/n9IKaLZFUTviVb0kJD/NDBERuEqTXIRI3pJZCnO49qJbpQTNsK8xBJ6doW0jtA3y3ze0ddsh2RlSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kF0d8B9b; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyCzK7+N8ovX5oUCNXSxxFfP5cYSj3//HIXLtP/Fg0v4PDrEfIM7ZQpn9IFGZIPl1EmhSeWygW6T5WCjlL2biIEMVKQffcivN7ob9l/u3zqO518B77SWfoWXYW5KF3RgYeLIF71h6vTgI1WVmho2NrA6bZoUV1BGDBC3hRQHENNY8rvX1P3Xht8pbU+4EriJL/GceZKo21Wsb67CaVD/Jqd+fnaPq1cmb+Df4avVlAbBY4vnakIsrUEypHsh90Qk5TTMloKSItFf9e2GfVwAZG4jfFmPFkWwPvvpvJUiuriiRxwT6lEacDvnGWuj0hy/gJzThTK8C4Zr1YcZcWYihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcTCn8yUypxOhtpAqrSckzopxqTmDsIOOh8CyAUFtmc=;
 b=JRvzIPm9EmwI+64fhfZTbV82gfzIpJlVtMg7fZmk7/7MWCxnMfMQkYei+Y5w+bK/fqbappB4iPxRviS++QUpfsBTJKblfEFP6mT3Z2R0I8VZsTTedcbY8DTgimrhmopXIHwUNBC+BnjiHPJHB8AqTH/0ENWgGzPaHxx4r0o39QPFNP12CIcp9u30bhC1dLGtAsJvV7x6MxYcxxX/ryiDPAy63kPy0VMu6IuVQiMESA/+JZJ8QNJoyxkkYjJUXXe3oPxRg4K0UBi+EI2u6HowcgHWqLKdOLw6gION/TWgWMbwDActl0wbh8UjV3QLjju6/YwIQY/oUBZo1SxOv2NyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcTCn8yUypxOhtpAqrSckzopxqTmDsIOOh8CyAUFtmc=;
 b=kF0d8B9b8ISdXHkGPLLiRoM3/ty/LFWW84c+XKm/ApOiAyd1M6161c93rDIEZCyHDtLRem3n+t9vNZb95/Ch48kbYdggdvY+ep/ZVIepyjqOKOsZxNR+75cxA6AkbUj2bNzacSfluxW/uq9HRpjHqtMlFjJNUfMuistqP0YFeKFVn2T7Gd+mNG7vc3OE/TsLfsUkOxlJiL0YsvbmjBp/1LhaeyJiOCrXHelR/4yG+5IPZkDQ15jp4wWvjgUOet5HhN3QJUUytnxd6QGR88aK1r0jxtAHgZYxureZS0dU5LxpTj/KIzF2iE2pdo95knNKDeeJvm0E5BZNEtd/L6KHZQ==
Received: from PH7P220CA0103.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::29)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 15:51:17 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::e4) by PH7P220CA0103.outlook.office365.com
 (2603:10b6:510:32d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 15:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:51:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 08:50:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Apr 2024 08:50:56 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 08:50:55 -0700
Date: Tue, 30 Apr 2024 08:50:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] iommu/arm-smmu-v3: Make arm_smmu_cmdq_init
 reusable
Message-ID: <ZjETXla+hTBR9E8E@Asurada-Nvidia>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <47a2ec844ec42694872d3c3b1a09f1b870712f78.1714451595.git.nicolinc@nvidia.com>
 <20240430142408.GR941030@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430142408.GR941030@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c59e82-024c-4651-7989-08dc692d5eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s9KXutjuBu8TIxSQRd9XuStoSzOCxLdn5OclUxRaJsZCx5gfN52gSPpsNC1y?=
 =?us-ascii?Q?du60YQH30o0wDoMi/9fJXhYzVyBADY62/KkzO7HQUaODcZTuTFybNi//1XIJ?=
 =?us-ascii?Q?t0Vyh8hdYbQ7iBExith8hPaQ1Jnxl4ZBLeDlUv23pl+YeSSxJ/gEgsM4M6fi?=
 =?us-ascii?Q?pQDlBYVT1MrgrntkOHhke4Na1Xdm8h1ePJcgaXard82fPgpUREfmzf46AnTl?=
 =?us-ascii?Q?16RmjeZlG17w3n/INpnADx4IY5eC/rYUotsA5LVV1i88sS7MYU2U/g1H0JBZ?=
 =?us-ascii?Q?ZjgYjlwPazI4VbWUmuJvRQgLNgoFJ0+G2jgZKizosAxtT6bpZqoM24aYFmzF?=
 =?us-ascii?Q?jB7VBU/oP+3yFailkE8navCZDs+AW60T9SniyZCYbPgo3VmPmutYJljZbLoI?=
 =?us-ascii?Q?fk94bMKJmRZuTOctKtvJutdzHwHPf7wvd5IVY26bDMXXmoIaoaUxx/ZRIP97?=
 =?us-ascii?Q?EfLQFi1PlB5GiJmrDGy7XdjkhOYq3v97wOZGAFctCWi1R3gHPAvOtPO1d2EK?=
 =?us-ascii?Q?4mTM6952IYQiirYi1cZRt4Jd2xsHGI5kyiA3VmtB8PYjQmdccudAmBLHzHNu?=
 =?us-ascii?Q?4wQ8TYIaAd41jn3ZdFXFQUOnMxbnI0mm/NBnxbAIobM7Vb9SLKDj6z8X/av6?=
 =?us-ascii?Q?1a+G6+tcklmRijX7inH/o/wM+/rPuWTpoN8caBECnIv5J5UFabOnogSiMi19?=
 =?us-ascii?Q?/lj1V+iRInpCWO+DCuQ1d5gVHeXneOBFt+H3rHAMWkbPzxujpxnBWMEEMUhE?=
 =?us-ascii?Q?8W1/6Rgj2IXT/7eSzbSdoqIqBoicWqhqd8qQYo/uHRvJ1/Oh+AmlrmJhcLPN?=
 =?us-ascii?Q?VQB5OOXHG2u4fl8XiK08k3TtoSAZmMWnYHTJ0TL5aynz/rwEJAZE1R1V+vhh?=
 =?us-ascii?Q?vEHEVHD8NsiL4+WJ4ka0LDWJtGoXfu85xQontIhsUQzG52Nx3Vcd+E8jaEGR?=
 =?us-ascii?Q?a/xRXkI0GPe5PQmuHbKkRRHMLnwCP5imKvxnAirDMCgB5dnnYl5sYDq4jX63?=
 =?us-ascii?Q?/W9RQQ6CAh4X/YkUKnFuRf3VpvuKBdbhBU6dnQMDqcEa5Vnu63EjKXTIRp1+?=
 =?us-ascii?Q?aF976UQYKzCI+SPf9pTZif8WtMg/dtnKchg1LjRWYy7YCVd46tPaAcrJq4CG?=
 =?us-ascii?Q?MwysqRestWXn/PuDsdZn4FFZz1+9RUgvRB5y4ejMT75r9HLEr/FAsD1ZjBsA?=
 =?us-ascii?Q?UQ0UGulT+LVT19i2iXXaX5zJsJCkDoWXPRfSpis8Lp1RPySYuGkh8l6EICxJ?=
 =?us-ascii?Q?BRYBMA/nIOyUAwIE5urJMx140tD3Ws6cL0ABpIF63xRpUGFOa7dLvfVUXM6n?=
 =?us-ascii?Q?GoXL6z1kun+oANFySroy4DYpcOYsoQWgOhoz5Sedtlm6D2Z2yGFoTZE/7Jb7?=
 =?us-ascii?Q?H1tQlqe6iwWEduONuXpeBfIHadHH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:51:16.1258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c59e82-024c-4651-7989-08dc692d5eab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566

On Tue, Apr 30, 2024 at 11:24:08AM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 29, 2024 at 09:43:46PM -0700, Nicolin Chen wrote:
> > The CMDQV extension in NVIDIA Tegra241 SoC resues the arm_smmu_cmdq
> > structure while the queue location isn't same as smmu->cmdq.
> > 
> > Add a cmdq argument to arm_smmu_cmdq_init() function and shares its
> > define in the header for CMDQV driver to use.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +++
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> I would squash this patch and the next together:
> 
> iommu/arm-smm-v3: Make symbols public
> 
> The symbols arm_smmu_cmdq_init() and __arm_smmu_cmdq_skip_err() need
> to be used by the tegra241-cmdqv.c compilation unit in the next
> patch. Remove the static and put prototypes in the header.
> 
> But the code is fine
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Then, arm_smmu_init_one_queue could be moved to this patch too.

Thanks
Nicolin

