Return-Path: <linux-kernel+bounces-37967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E007D83B8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808BD1F23AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E8882A;
	Thu, 25 Jan 2024 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Csu2L+Ey"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9ED79EA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706159378; cv=fail; b=uJJK/gV11XKbKDuLYLVtzAqMHEszlDhtLbzpa9L6zbrq6KwrjR5H42b8+DLMkXMgoqtm+9SKyXYOJN+UgonYPPAmZQlBUnf0glkpn9kGBolo50PfIjzZ5g4CZEB9tvkNC/Uu1gatHSvO3VlZ/0jrxy1wyHpReNr7Kff2kklpvYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706159378; c=relaxed/simple;
	bh=CTYj+rrUpAhnGbixaHAmJnoNUg5yFQfM2sNvvV9e2Pw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdRQPW5DG9ffq5MrgH5wmkifb3L86QykF84O9pIf/lXWz+Noh3qko+OFNmRqPlEs2QLSGkZYOJYoqMhOChFSzzi9TfjyN5cY0XQMXiWNBMsXPafwFOpDsP0ytoTfGxGt2Bg4JEHO4S8CkclyGGmJDVepFr5kfnA8LLI5jmhvmDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Csu2L+Ey; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrMWmDdlbtm93LOMyb/lGwesUnFuIfRlA4/fNB/zJUB8iW48j30o1sJXtzkwCdbREhK68wTuIa9eqc14j/PlYZadX0BNxLPM1zNT1lbAtB86UuUzuUbWJqnSv/8btKchlmj7ZOdxrw2w5LV9WsfaU+b35rpzX3ujqg591csHr5S0sAtNzF+mqe97Fa/mZi7kPe8XnZcR45gIO0eMgrk5Zm47IMTiZuB4tGymv6vNJ3+UnSYX/B/jNf59c0ybvcYKvptmThnMo4RDZfJZQS7IvjDB1gsKcn/R9xjvY3XJzUCQdHPtE/I9uIjtduC4VMUDDkqzkZA37pCqUw3SyhgXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yCxrTvVleZRYpxYm9ANgD4MX11mmB25b9SfkTJpDpI=;
 b=M5BBddt4QwyZvD1giWFsKZONXtnKpt4V3HQQqUFu0vjbt5xqPNthCXm9V5UeQ+vjUGKws+yVAlDXVOTlxcrrho8U7GlJRA2ZLkuntWx9QhLsq3DMgcapNahwckuk613cAIrFrPjd1p2Oo52pvyljiJclJqe3s7l4QL1Bn7CY7toMImiwEQhU2TK7cfrChrI2j+whe0HyxwGBUzTMOgzxENWm6t2LR5kj1EDbRDcqohtWgiwf0ms2kgTXQsr3N7T4EU+JJsRF7PE1d5FX0dvB3W69ZvDAAm6acURm4zYnsPiV/pbwxCnK1ru0MPOm7+e56+PZTvPRAIsk3K5aRAxytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yCxrTvVleZRYpxYm9ANgD4MX11mmB25b9SfkTJpDpI=;
 b=Csu2L+EyRte1ZsqCo8ZWvtpsCbzBxINy5CoiqHj3NVzbk4FHmfaNV7T6nKyGCLVLybkp1hNrxQOS4P1bf77hPgr8RgncTNdx5DvnKxEahTa+S77zsuhnejFRiZGFqaoKpZHQUygC8MT7GXBHz0FR8KUKCRn4HtXrA4BjxLSrkONEIwpn6IKWdzn6Vc558iwIxOsXxHw6hmvvgxv2w9fFVKYM4NpIOXWivQdiGuqwT7JssQ3LdgTnAlS6BoLyVRCh6OE4d46AahRRn2Hbfd6C9kfn77PMZTLSEj9XHP+LJAmmPBcCZ8vzPizVRAkbPcEkwH0HLDe+/bR7KGc8qsz4yw==
Received: from BL0PR0102CA0005.prod.exchangelabs.com (2603:10b6:207:18::18) by
 DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.26; Thu, 25 Jan 2024 05:09:33 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::2a) by BL0PR0102CA0005.outlook.office365.com
 (2603:10b6:207:18::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Thu, 25 Jan 2024 05:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 05:09:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 21:09:25 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 24 Jan 2024 21:09:24 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 21:09:24 -0800
Date: Wed, 24 Jan 2024 21:09:22 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "zhangzekun (A)" <zhangzekun11@huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, Alistair Popple
	<apopple@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <ZbHtAobfttD2frwo@Asurada-Nvidia>
References: <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
 <20240122130152.GP734935@nvidia.com>
 <Za6kuE4KUPuwk7+j@Asurada-Nvidia>
 <098d64da-ecf5-4a23-bff9-a04840726ef0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <098d64da-ecf5-4a23-bff9-a04840726ef0@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM6PR12MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 52060eb3-4988-4682-0508-08dc1d63d154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uunFEdtvjz9R4Ld/sQe/W+k9598X9uAlV7SlmpC6xxrWJGumTalBICCWRoqzK3Un0mAF1AGTsCGVRtXv7JbNaPBtuhZPwDO/NgM4CoXhH0f9xL9Y1L67YShHcMmcZG6V+AwFFnHsc6NIsVJZ9sF+J2TQfumy80zApf3gxQeu2AbWIB9zZ7BQE0KpfBstaxA16+7enU7ciMMxGYqPyYT8FG8Oo0qClXSlj2NQOHmm8LOnKXBe68fzSd98m+P06EurmGp6pyYSoS2W5sK5l0bVQjFTSZbYqu7ApiT/0IcMwfM4Xzkxa/pvvAAMCEeLgstiFr+gP9RUIAeyKCIanuOwgdRNfaTCBVx9YhSliw4N9sdWqbMjkr/ugwk1XtPUEJOpalNFQfbE7WkJ1KRIWyJNTHbxjBSwDagawy66F1xOYOVR0yofyQgyUWTpgn04/EjgILhmmlsUUma8UdMIgj3MQALMNXINBJFqMAUat+Ix+8iKdM9epavaXJhxYhC4fWug1gnYgTCsGB0JpV31rUkhfbBV05F26fu9NjIojQCoqnOecMiiLOmxXmbHwVmZlRqQpQHQn2gRjhUaRND3domt5KmVxtzuuE8cmCv/fGEqKfTHKAc1JANSOFs6ua0Wp+uPLiww87hUbhs8ANltcA5/pQqC1JFYQK00sG1ToLu8QTOKJkSx5eSOKsWGpOT8drUCSVfDHxuEG31SyAlk10LGdGZp51m7UedPwOy4F9xrl0mpOzjkP7UZ2aWDlGXsR+pYmMxiI6o44L5slJoYX/bI8VW+WPGwjzDH/cAE2Q2HNtTQ76/OVQ/XWSCb4PV72Az8
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(4744005)(83380400001)(2906002)(426003)(336012)(4326008)(5660300002)(356005)(36860700001)(33716001)(47076005)(41300700001)(966005)(55016003)(478600001)(26005)(86362001)(40460700003)(40480700001)(70586007)(70206006)(82740400003)(54906003)(6916009)(316002)(8936002)(8676002)(9686003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 05:09:32.8805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52060eb3-4988-4682-0508-08dc1d63d154
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878

On Wed, Jan 24, 2024 at 02:20:14PM +0800, zhangzekun (A) wrote:
> Also, it seems to me that SVA use cases and, say, DMA API cases are
> somewhat different where we may be willing to wait longer for DMA API.
 
> Hmm, the lockup that my patch fixed was for an SVA case that
> doesn't seem to involve DMA API:
> https://lore.kernel.org/linux-iommu/20230901203904.4073-1-nicolinc@nvidia.com/
> 
> And the other lockup fix for a non-SVA case from Zhang doesn't
> seem to involve DMA API either:
> https://lore.kernel.org/linux-iommu/e74ea905-d107-4202-97ca-c2c509e7aa1e@huawei.com/
> 
> 
> Hi, Nicolin
> 
> These patches do involve DMA APIs, because it modifies arm_smmu_tlb_inv_walk() which will be called when unmapping dma address space.
> 
> iommu_dma_unmap_page
>    __iommu_dma_unmap
>        __iommu_unmap
>            arm_smmu_unmap_pages
>                arm_lpae_unmap_pages
>                    io_pgtable_tlb_flush_walk
>                        arm_smmu_tlb_inv_walk
> 

Oh, thanks for clarifying. I was just looking at your trace log
there, but overlooked other places.

