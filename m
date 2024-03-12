Return-Path: <linux-kernel+bounces-99708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ABB878C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C16B2146D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF4ECC;
	Tue, 12 Mar 2024 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XQ2VdGSP"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18763C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710204779; cv=fail; b=ZauTDcQtYmy8i7vijL5lgqbyRH42BFcfK6zRMFvJfJnitTA4TIIa3sCCxzj2x36JNv+cifTyJzKIEs9hkO3lPVkfarm1iMyWPHbeYmd3sH7KUTr64njUg6wZL3Rzmdh09Ut0WIfBCJbaZ0Y/v9vWOFQSkrIoqtIJHygh0XRxbNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710204779; c=relaxed/simple;
	bh=ikWChl78pb0ae4+iV3dIlSdAj6mVDcDp79QQOfDTmxE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEyPopB5Kp4WRNAdoL7wfLQiuFgNBJPK00C5s+lKrrdXdm+1f1x4GtcO+QUvKmFw5+vRKX+Ix7/SH9xNqhgU2vYmuZ6HpvIEQL5akI5yMybBf2RoYXRwEZPZ1zF1xBTF4lo2mMd/dE6gwgX9tGhtS1429xekOyO8nDmrGnLHjL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XQ2VdGSP; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxgZWihFRe5rbt4hHjDEre35eBxH4ZzG3nHzaPH8f6Iq/FsfCUVa+DjGhsPLZbWJy2JRaWeH5sH9/H5L9X2VTFv/JakrmS7x83mHtQezbacJp1n30ZVb4uvvLEBlb6mwtGbSuyfNZTN7A9Rse7YaGSvIQppnzLCUlJJy2iLOL8RB+iyL4+D8q2rNw3TYjGJVX7Tdw9W0IxnxMmzAmBLW0CalJL4mvgPo+S/rXj8n4yxjr7X88/zI8tUrQFrkQfuHxfJv0OIKFBv0hgCjOpTR6/37Kz98/C9j7IlsJApVyhgFyP25QjgZBwVQMQPPOonq0C1yAxW8f1/HeDKEad+/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/UlMVhNULMCD9xMdj87hULzGcX4fnehHFK1alxUWmU=;
 b=RqZtP/h5rm9ADIb+fyXzfaXG7gpOBZOPD6sPaRB/A2HrrPZspMWdJZVX4DhSxfTBUyYu1u9UGXwoH4WArm3sx3rvSVmukHwI9Pur72HL41cin5QpXp2OlLo32VSSTZXDQgwUr7RNA0QcDWwCI/k5tAXRQ6TN+igrNVUe19wfwXbwNa7RWbDLA0L4zgR5IEosKSlJkqs6Q2b18hsDylzay45HmXKcl9JJduUIcng+NNpg2dd284KMqqdFrUaqAjP7PB1KtTpjyXIa1twYWyfO7ODZgPHn31MSBlH2vU6JyJAkM0Vp3N56JoL5WVhQwnRzYA4cLSQMsvo9YhaMzdgd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=tesarici.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/UlMVhNULMCD9xMdj87hULzGcX4fnehHFK1alxUWmU=;
 b=XQ2VdGSPU8VeFSbBc0VbzEjpA/Rd6wEEunkOcW/UezXLybID8bvXIqy9VajMZD+DV2gb6ufJX/GCLSuXwC0O5wYbviDVePU5d1dhMKTCp/YYuk6PTJs0H33NsvG5ztArMmTZxS4/29Zg5D967v8RtUKQ4Cusnj2QwB932a3q87KlC0bqd0wiWUXLB7MszjYYWnbiIRxhx47QAOcTmuufV/rPIes5aXjIEwME1F3Yke/cOdk/UJtc1e18H5fkFxDY15cPD2E7p9DMWHySoPT8mlW1oWx8gcgjgI5BGoUsSgUx5fv+311Qhbit5JcwZGXooGm/KAlCApcxRWW18QZ6RQ==
Received: from BN0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:408:e5::21)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 00:52:52 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::de) by BN0PR02CA0046.outlook.office365.com
 (2603:10b6:408:e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 00:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 00:52:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 17:52:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 11 Mar
 2024 17:52:33 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 17:52:32 -0700
Date: Mon, 11 Mar 2024 17:52:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>, Michael Kelley
	<mhklinux@outlook.com>
CC: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-team@android.com"
	<kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v6 4/6] swiotlb: Fix alignment checks when both
 allocation and DMA masks are present
Message-ID: <Ze+nT+4Radnd/iyw@Asurada-Nvidia>
References: <20240308152829.25754-1-will@kernel.org>
 <20240308152829.25754-5-will@kernel.org>
 <20240311210507.217daf8b@meshulam.tesarici.cz>
 <SN6PR02MB41576E58DDF5A56FC6FC1EB6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB41576E58DDF5A56FC6FC1EB6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: a75a6d77-22b9-4bda-f791-08dc422ebf28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0kESdDY42AG9EqQOIPsTaRT7HS1jre3FGGwTSK5UaXmqUrt+BQXzikw8pdxVESDNdZOAQIeodmpMbEciK/YcAHCfPoYbhMJM3cAplvJyo+GhizrZwfO+bklelXj3U1gmuMCb5GRZf2n32gGWMhXq9sZTh/gyQd6kGH0spalqIEdzFDsezFy28meutY5dduUEWU0b0j5zin7pW9DxwlqdBycZ36f+rdjR1hrH0udyUSYYCTp9mx+PV8+TYd1IIyeKqPERTBMRuROe+JJ0LNX17pbg1C4n8ycqt4jCf9yDWZZtqwEZfe7FC9NuabtXhv6lDuQMiPKybRKu0Y8MNnk8s1C9KwCpe2fM79jlSCoxjI0LV8rgfVJ2o7paKnO0D3fDjtl3e6O7gnxUO8/XdiKccdSjgvoTEUeeIROc4/r3c6dNF3JxZ6TElh1Hi2J2kpHWDcCYCfO+2h1GhHYy/g7iGuulvV5/q3RJ+LLGeEKdxn1yV4BthC6CXXf+nMh14Zl44lIE4b++zrs7x8+XvbEqdRHsnjRj2/hFXBucxyi/eklPVmhoNxhUgBN2oZUe5IgEEFzx9yNot/YcWvl0V8PKP2c35oKzSyDEauDumZQKd3mRWcSxzzlwqEqUex4QLHBfLpu12qZbRJLQAj9g9PjgRcznqVu1+YnS5jrxxbRrX0NUA75IbPWyZdk1LhLTsZLz0Jf+bFEI3bVv0ClJ/o6cZrmPvgtV1yoSl8OTIc7zZPfUx2L7YBoTINxRHTYj3Vxun1cbmk6iDBufm0I8rNTKHWY9ZfX1i71C48KVCWxFhEE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400014)(376005)(32650700005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 00:52:51.8923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a75a6d77-22b9-4bda-f791-08dc422ebf28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555

On Mon, Mar 11, 2024 at 09:36:10PM +0000, Michael Kelley wrote:
> From: Petr Tesařík <petr@tesarici.cz>
> > I find it somewhat surprising that NVMe does not
> > in fact require that the NVME_CTRL_PAGE_SHIFT low bits are preserved,
> > as suggested by Nicolin's successful testing.
> >
> > Why is that?
> 
> I saw only one stack trace from Nicolin, and it was file system buffer
> flushing code that initiated the I/O.  In such cases, it's very likely that the
> original address is at least 4K aligned.  Hence the offset is zero and
> the low bits will typically be correct.

Though I didn't dig any deeper here, I do see some unaligned
original addresses passed in at the top level:
       fsck.ext4-286     [004] .....     2.594190: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: be750600
       fsck.ext4-286     [004] .....     2.613032: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: be780400
       fsck.ext4-286     [004] .....     2.614096: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: be7c0600
       fsck.ext4-286     [004] .....     2.614103: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: be7e0400
           mount-288     [005] .....     2.615157: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: be800400
      multipathd-405     [003] .....     3.062878: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: bda40218
      multipathd-502     [002] .....     3.231721: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: bd3107b8
           mount-525     [002] .....     3.250281: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: bd340200
      multipathd-529     [004] .....     3.259053: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: be620478
      multipathd-571     [005] .....     3.292893: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: be900328
      multipathd-580     [005] .....     3.318832: iommu_dma_map_page: calling swiotlb_tbl_map_single with phys: be9207c8

Or is that a different "original address"?

Thanks
Nicolin

