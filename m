Return-Path: <linux-kernel+bounces-67931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01263857335
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BCD1C20E76
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1712E75;
	Fri, 16 Feb 2024 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JmJ9Yqsz"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C845EED4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045670; cv=fail; b=jP1zL9gukhF1WrmAYus/WET3PFHAkwBbz4s7iZ8rlg2Ck4AACCP3+q/LLUpFKD2HvkS4pgfWeZxvPPFeSntglEyGSIZBwwRkcQJY8VoRzDd0tEsg9zRt0RHTP211nCU4vow2ku9n+d4g1uUROaPsIZ7u5dXiB59oGmdAcBcsfxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045670; c=relaxed/simple;
	bh=b2KFhARhxTEwc96Q7gZ9issALzJl6gHLbhhiURBYMGQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv7smI+z17yHI1QeiRvXHCKig/hLbE1DpBQHmWynxx0aZBzTwIQQmNfdwLTPfYftXmP/oLfLeFmevacqMk54Z1ngIzYE7l7EHZ08Y2svqoQ2aeTGUryzu8qAX5D7JSUwCl3hppm2HmxqiavWaR+Kpan/SLeppBlQWmsAmDfKM/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JmJ9Yqsz; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXvOXdNmO+28VnCK6VQUipqHuyzcZnRd3nb9vK/ion8wUnBtoR4uWxPCInstbD2kgb2dOgCTuQgo/Dn6RrfDyzoF/yZRJcaEEHFZjTX+azE9xn4wkyj6eATTqHCXQPBfiR4PMwR4y9kexUUEPqMVdYs8SnPCw78KbqOMmjTsAUTzu38CtZL+S8e+jCYWdvW1T5vyCkZNfVzK5iYSKAVaoJ+znoAIG+/KQTpa0yp3qVlWokDz4hlwQRnOlpnMMMO3ZBU2UkheMfUMb8oshMu5KuR0oS8th7CADkYTf+TaTfF7AsoVHYKdFQLVUzqCWzBpCdOZbsmUI8AEuLBjQxrOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSg/Lq05YI2DXsToiD1pGuFU/upA6lR7FdWPB9im6tQ=;
 b=RGiQwOQ2msXArQU9AP7Y2lKpLOAKlpEzMHb0SV5zJ90P7dBzpTiyKrDoV6hHhWTDOinXaAEQQQ5HlKLcuq1/Es3i2jdm2t1DSvu/QOPYTOo8XART+bG/no4TjZVaiy4NI5i0e51U7p01TEAkWSlS9Y11CpDImR8jQsuRn5w3K8Fg6wO+Qv2G+o2dGUO93qB0l7OIdrRKDeHKT9N4LSvh0eaR6SAOAmI0JW6AWc7dNdBogX5jPsDmFjEk+gbuQ8ZWtzyhKkxArjRT8bCz/NJlFEabZK+Kx7AJljx9U62Xw3AuS6+ikeUp1QllaynMXDHWWY9IK6aMY71LcpFmrSKHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSg/Lq05YI2DXsToiD1pGuFU/upA6lR7FdWPB9im6tQ=;
 b=JmJ9Yqsz+fCgEs07aJTz+aIQCF1CyGqPGWbecN7HHivM8B2QoMU6+0GJgKWa+TRW5QKhjcT19XGEQIGjy6ERIvgwm8Kwf0ExyhoXTO6RHPFNmfuFweDCDxdKqTlM1l9vgap1Pzu6Zac8eVIrvNbVy2zjLnyjCjSAv3d5Tu02+ZNs/zxlhN9MUic/tk84ApxDchxL9N0aDQlLCdCBMrmmv/U+ibBhQBzuYVawceDYIJu4FF2e7PAkLGz4Kbq2n01Ydk+ywUNvlotP+2Melrdtm8NbeJ1eeQCaurp21HGcx8L7YjVKxRks0BtC1M5SiWC+OVOCCi+Lj5PQBf6gi58wtQ==
Received: from CH0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:610:119::26)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 01:07:45 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::d5) by CH0PR03CA0384.outlook.office365.com
 (2603:10b6:610:119::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Fri, 16 Feb 2024 01:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 01:07:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 15 Feb
 2024 17:07:33 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 15 Feb 2024 17:07:33 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Thu, 15 Feb 2024 17:07:32 -0800
Date: Thu, 15 Feb 2024 17:07:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Keith Busch <kbusch@kernel.org>, <sagi@grimberg.me>, <hch@lst.de>,
	<axboe@kernel.dk>, <will@kernel.org>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <murphyt7@tcd.ie>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 2/2] nvme-pci: Fix iommu map (via swiotlb) failures
 when PAGE_SIZE=64KB
Message-ID: <Zc61UhUfzwenYKVE@Asurada-Nvidia>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
 <Zcv7uI6VrMc2EuGT@kbusch-mbp>
 <ZcxZD2GXmR5+vC/k@Asurada-Nvidia>
 <Zc1qpr4zCy1N0OND@kbusch-mbp>
 <Zc2XHbcXZzV2a61n@Asurada-Nvidia>
 <7f14727d-3ca6-45ec-9251-f166f74a8f7c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f14727d-3ca6-45ec-9251-f166f74a8f7c@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 0608099c-c4cd-4081-45b5-08dc2e8baf4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VU0HZoThP4exs1AONdOHmOteR+RBE23sr7UunZAsinLwg7EA15+6k6/FYvq8vpGk6JYysVk1jwqoBj/jWpvLJZHg/ekyz8/sMFEQgJr5KfUvpFy3y6AtBhYC4gaJVN/pAICIv2SOQJRECnX0RppZSN0JyejfRnQ56pp1Pyjk83o494A/yZKPaOdp7C4K99gpeyVEuBZL7GiXDNi2PWkZBgpXQjzhFDyUsxaSBaUS2uFHd4xjMEDTmwFDMUjel7771+iCKhrIPPR+6BTdBgehsdu6XfyekUv8ysv2dp7cyoQqSn8cQKNdqoPaN//1YpTo5ObSqBEGDoetjEqFXlqpehgh/7XRQjKQ+X88Uzo4ZSVIJ6edy94i1jTIn/F0AkIMKcXqZRPFX1re4eERIAg21LkKbvcxQ2hMVUeUToTypjr5opvbJnnHpU5iq6sLmpWFKih4biutY8qmrimgcqVdew2Nv/MVRbzFqhAbP0cVcsmwRP6qopdSi0mc27sjP0Ep4zp5eCvm5eN82QYbpTgExeQjIgMkS53hYRvHeiJXKB8hQmw6rZbmJgB+S+hYFTuDx4NGEvfOgFN+XGiJFaiJkFmvD6gGZL8TCEsVybBKCZLM01OkGoWg3Aigd0qEDpSJCUR/OEub1JMZ/6kqNhDtUhSJwCnnKkpC1Y0XcMdZLxM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(36860700004)(186009)(46966006)(40470700004)(336012)(316002)(86362001)(33716001)(83380400001)(6916009)(70586007)(53546011)(9686003)(82740400003)(478600001)(5660300002)(7416002)(7636003)(426003)(54906003)(70206006)(2906002)(26005)(4326008)(8936002)(356005)(8676002)(41300700001)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 01:07:45.4704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0608099c-c4cd-4081-45b5-08dc2e8baf4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317

On Thu, Feb 15, 2024 at 12:01:34PM +0000, Robin Murphy wrote:
> On 15/02/2024 4:46 am, Nicolin Chen wrote:
> > On Wed, Feb 14, 2024 at 06:36:38PM -0700, Keith Busch wrote:
> > > On Tue, Feb 13, 2024 at 10:09:19PM -0800, Nicolin Chen wrote:
> > > > On Tue, Feb 13, 2024 at 04:31:04PM -0700, Keith Busch wrote:
> > > > > On Tue, Feb 13, 2024 at 01:53:57PM -0800, Nicolin Chen wrote:
> > > > > > @@ -2967,7 +2967,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
> > > > > >                dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
> > > > > >        else
> > > > > >                dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > > > > -     dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
> > > > > > +     dma_set_min_align_mask(&pdev->dev, PAGE_SIZE - 1);
> > > > > >        dma_set_max_seg_size(&pdev->dev, 0xffffffff);
> > > > > 
> > > > > I recall we had to do this for POWER because they have 64k pages, but
> > > > > page aligned addresses IOMMU map to 4k, so we needed to allow the lower
> > > > > dma alignment to efficiently use it.
> > > > 
> > > > Thanks for the input!
> > > > 
> > > > In that case, we might have to rely on iovad->granule from the
> > > > attached iommu_domain:
> > > 
> > > I explored a bit more, and there is some PPC weirdness that lead to
> > > NVME_CTRL_PAGE_SIZE, I don't find the dma min align mask used in that
> > > path. It looks like swiotlb is the only user for this, so your original
> > > patch may be just fine.
> > 
> > Oh, that'll be great if we confirmed. And I think I forgot to add
> > CC line to the stable trees: the two patches should be applicable
> > cleanly to older kernels too. Let's wait for some day, so people
> > can give some tests and reviews. Then I will respin a v2 with the
> > CC line.
> 
> Hmm, as far as I understand, NVME_CTRL_PAGE_SIZE represents the
> alignment that NVMe actually cares about, so if specifying that per the
> intended purpose of the API doesn't work then it implies the DMA layer
> is still not doing its job properly, thus I'd rather keep digging and
> try to fix that properly.
>
> FWIW I have a strong suspicion that iommu-dma may not be correctly doing
> what it thinks it's trying to do, so I would definitely think it
> worthwhile to give that a really close inspection in light of Will's
> SWIOTLB fixes.

Yes. Let's figure out what's breaking Will's change.

Thanks
Nicolin

