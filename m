Return-Path: <linux-kernel+bounces-39031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F183C9E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A611F2271D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F5D13173D;
	Thu, 25 Jan 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FP0hbtDv"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72435133414
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203402; cv=fail; b=VorL1CLFC8Vy+NB/NL06Pr1WOeqyeiIdKP1bbRb4dLs9nd4zretV6iuFlywXzM4jJSnk9BRz83EtdukwR5CUJkRnTERFq54ELk3EBum+mDPax+NGRDuzc+5o3V9QBi+AzIK7XHKIZNWO0KKb7Y7k5QN8CzZ3OEPbwLHho9grAJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203402; c=relaxed/simple;
	bh=gexdEKF+XRxquAwvPxKEmXoeJeahizlxe0PnTy91ZVQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVAURKGJ5zPvwv/LiY6XiS3CSFJb+nqaQh3ABv2Islm6DBM/ZYJzZtWsgNgiTakxIefK6u/eMyhoY3uH63pVVg/5AHy7f16YcPDz+ZnQJoGRnqp3GQCzghiE/xfNOh3xp1aTzFStffZM2z6aXiirDVQaPSY5lbPz8mGnvgCXPYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FP0hbtDv; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QycZ0Hee+vFWgB050P3ZJVF4LoB1+j6I85AXPItAuIM92dG3vOzbfyy0j2wNxZFn6Pgc1JeIhPuE982Sk0KnIQWXQGtIeild2Cz1401koIphl1j2rlAJxfualzE//B2gvi6pgfWa1K+ky2k/6mpYE5rqY5QlNXY85o+v8iwKpMHR4BK6VfmsdF4NJKqnLMnyNAi3mS7OnbF1qUz+0gDfklPtERklfIATHZToX3aJPKYrUYljTNOA8j1oNnM1yX7P190SQzH3rWPX4309uootkEK4XBKDFMEp9F/fsD9DlEMB1c06k+pIIpmoBFt/PubOoIlsLKD0MafwADXbUfNWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iI4V4EDLdKabgLARkhiFhrKC1hrJ9OEFUTKjdnpR/Y=;
 b=ecg4ul6sQPNRJtFuXa0sCzzkZ86zPLmHSOZvasDWCUIqM+eIgQiVjyU/J2oR4gSUWN4rqs/OAEWEojB0qfSM3/9AhuUIP2ZinCKGHBIqKDqVBA1wO1Em0Q2Q+1GRgvrEWwwTvZLTubWw2RMVLxNICx3mFD2hPWtL8+7JPlULz5+36YdyhTnbTaepZ4o6sYY/mNJB5zPPI5FgNF85Ixg05fQz1VAO2/14DmPgtT67wTIECuo4mYRVcApjj015dac7Gur5jM6ph1q5OmxCshvSAp58ojMbelOHWbBnK5SXOzmVfGDnExUhesmfIYpzl8EVfy3czQJClHo+iTlwMXIkDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iI4V4EDLdKabgLARkhiFhrKC1hrJ9OEFUTKjdnpR/Y=;
 b=FP0hbtDvlCXMunYAnuttfVQu2UX+uBLjNDu/JvqysgcIRkhe2JSocO9Kjt59urH9VLgLsUZPBBURLaIR7vdzNSIlr0Y7y+W+6/3s+OhqSE3R6Np0KGHLknEeB5/tJLcvrLUIDz/Z8R0jWih//PgBpIixoUYPZCAcgqnJTrex8XMJL0+7pODVwqBbl2CsTwQHOp9e9fBbxyJHjGR32IO7SB+DO6wT2X2BkYwkfdpUPcnvZV5tS5Z2i1u/MWO0ZpKhX8fuI7s2NRC1+A1D8V4IB0alYEjLgru6UbNtrooaSVC6nzxUQgNFFiWmKcpq1zT+RaxDLn9cjS0bhY8JOriPZQ==
Received: from BYAPR07CA0099.namprd07.prod.outlook.com (2603:10b6:a03:12b::40)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 17:23:18 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::d3) by BYAPR07CA0099.outlook.office365.com
 (2603:10b6:a03:12b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Thu, 25 Jan 2024 17:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 17:23:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 09:23:02 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 09:23:02 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 25 Jan 2024 09:23:01 -0800
Date: Thu, 25 Jan 2024 09:23:00 -0800
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
Message-ID: <ZbKY9BmXZiHPiEOk@Asurada-Nvidia>
References: <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
 <20240122130152.GP734935@nvidia.com>
 <Za6kuE4KUPuwk7+j@Asurada-Nvidia>
 <20240122175700.GB1455070@nvidia.com>
 <Za63HOMZE2fuJKQ4@Asurada-Nvidia>
 <20240125135537.GP1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240125135537.GP1455070@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ee553d-93fa-4f98-9004-08dc1dca5238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mB9EpIMItV+bpjG3pqdY5Qnkqy+Ihc8qP6HGkje1qJKehHG3erjzrDWPC7oqZt3SwsurUkNOiqGPhNif11ZiyVh97q/xijCp3dl9Gdp8dkL8Sp0npDs+BMWdHr9bb2k9u+iLYQSR2195LS43U9i9tffoKpjIrLuHZmbNNxV8UeNvMWUPz9aEuRbRuVIf9vfKsaDZ+MgyKXi4Y952KQpVS0PelEzUmHhU3ZCaXKh2UDub3qATMT4nKUR+8x5tvPh+cd0GmFONfMhxrkw2dkZMGQTbbU3VB32SrkFNVfp32/oIl4pDnZzciEaIxqemoomC0uq4IjrOamd2sIuzdZEmnatqgmwr/uVzVjpIgfzZLBq2hZ0VNkXOhKE9Mhk3Stfl8auV4WxpmSCjTTCOQvgnHAMDGSWfJ3fkXeQwr8cUAag/1zkkW6ZnpRj2x8EYuZMhG7HGzHdyh2REXN6L94zz6PD0aisr3FqtOoKvytYahEe8uB+LLxFQQGeFwnE+NQNKv/06aVJbk7QHhgLhb58J4M1ezS4egtzqMAgta3YB+W6f5hzYPOAnjkmGzSBn0LjbWPWd5oZ20domMhxPDznsF5qqq9Yh37DhXHMoLn+ZmajZcbict/GEn9LWH2yj9QVeFOydNR/NlQWRsKMK3LbY2ZyuSUEhXZ7HWSgreLfzOn+aHQ11p0zTGfJeztaohkBLNhe39HDhBQhGUkpQBnBb+iorJf7eHmr2K61BUQs30jDZ9ZrLKQL3DR9c+tLwJ4Nm
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(70586007)(316002)(54906003)(9686003)(26005)(70206006)(55016003)(6636002)(7636003)(82740400003)(478600001)(356005)(40460700003)(33716001)(40480700001)(8936002)(4326008)(8676002)(6862004)(5660300002)(47076005)(426003)(83380400001)(36860700001)(336012)(86362001)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 17:23:17.8399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ee553d-93fa-4f98-9004-08dc1dca5238
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200

On Thu, Jan 25, 2024 at 09:55:37AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 23, 2024 at 04:11:09PM -0800, Nicolin Chen wrote:
> > > prevented strongly. Broadly speaking if SVA is pushing too high an
> > > invalidation workload then we need to agressively trim it, and do so
> > > dynamically. Certainly we should not have a tunable that has to be set
> > > right to avoid soft lockup.
> > > 
> > > A tunable to improve performance, perhaps, but not to achieve basic
> > > correctness.
> > 
> > So, should we make an optional tunable only for those who care
> > about performance? Though I think having a tunable would just
> > fix both issues.
> 
> When the soft lockup issue is solved you can consider if a tunable is
> still interesting..

Yea, it would be on top of the soft lockup fix. I assume we are
still going with your change: arm_smmu_inv_range_too_big, though
I wonder if we should apply before your rework series to make it
a bug fix..

> > > Maybe it is really just a simple thing - compute how many invalidation
> > > commands are needed, if they don't all fit in the current queue space,
> > > then do an invalidate all instead?
> > 
> > The queue could actually have a large space. But one large-size
> > invalidation would be divided into batches that have to execute
> > back-to-back. And the batch size is 64 commands in 64-bit case,
> > which might be too small as a cap.
> 
> Yes, some notable code reorganizing would be needed to implement
> something like this
> 
> Broadly I'd sketch sort of:
> 
>  - Figure out how fast the HW can execute a lot of commands
>  - The above should drive some XX maximum number of commands, maybe we
>    need to measure at boot, IDK
>  - Strongly time bound SVA invalidation:
>    * No more than XX commands, if more needed then push invalidate
>      all
>    * All commands must fit in the available queue space, if more
>      needed then push invalidate all
>  - The total queue depth must not be larger than YY based on the
>    retire rate so that even a full queue will complete invalidation
>    below the target time.
> 
> A tunable indicating what the SVA time bound target should be might be
> appropriate..

Thanks for listing it out. I will draft something with that, and
should we just confine it to SVA or non DMA callers in general?

Nicolin

