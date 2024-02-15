Return-Path: <linux-kernel+bounces-66296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308058559E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8E01C21E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F26ABA;
	Thu, 15 Feb 2024 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OTgnz/43"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09387484
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707972399; cv=fail; b=BZFHKbjFWTByOJOUWTndRUJI3fyv4UlQ+t25QllpSLMyONSUbcWo9YLePoUY4oOpe3KMLdZ504wadyCGlIXlzggwzpth8e7+Z9qr/fxfEfW2G9VjeAn2+59TamxllaJ9UYXEde2YElCB/H444Dqo1SxlZHiqPftdJc/5Zj77JgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707972399; c=relaxed/simple;
	bh=416UEHPihLgbtW7/rFh1lnK19uRPRsyx69NipeCzoRM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3yJYA9pvRJpOgmJMkdW6lM9ZJpxFBfYGqaDoLzOTYwCF/hUFHU2Lqqqz5T7qrvJm0Xt5Lzy/9yYDyXltQtz/qRTiKm9Y9I5OUrRejXAYA0l4oNPLOHIRI7OkUQZO8Ee5+ZsAmdSJ9p40kNaVRgiKyclLOm4eJ5Qi79p/Vt+ghw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OTgnz/43; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf5Asy7oL0aaZ+e5TKtl7f51ma/J105HIAuUZuiq4oMA2vTlcx8ZrO5HwRcbGLAKMZQraXT+W080gaKnaYQ0aFs0KH7PUjCMqrtnOdMdeFJXrVtUR1RJ1xHXPo8suXXaO0rxVYO8ZhX0RKhPfpRagad/ATXR9QE9OudCm/DDk0cruCi/ZFfJ6I/UhmwJCxTuhqKaEYt6fjSu579Sg/XT0nJQbScXe2KjcNJ9JRU1jVTB71Mwji+vufJVv6QkrZp9SBxQNd7TvaHmCSOJDPP2yYbGDuPYS8sNorLQXM6NEYYMLrBbyI5sL+szuWsDJxz4g8sGccSYTFgUZhlsRh/uoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE31TQAOOVLcrabv6iSi0+SQh7ZscKDs3B5d2nJMVQ8=;
 b=SVitrFjDjYwKhHnznyzfG65gC+VI/OkS2fcWVbULOtgR8DEwL6GWFBmKItO60A1IYViFXuZv2S+fWb0sPrCTGYgiCDmHHK3RLF2fFz06FRs0l2w9jsa8GF9RxfJ6Au/cZDbqEu9OWwUepbtGc7A+UCUfb0+VNEqMkZljuFnYN6fra0UfxBt78W/VaxGADykjNp8LaKXnsB0pmuKsS74pLb4xYKvectLUGJbRp0TwXQ/nFOWWglbIsDB8EBaDfoBzDQihyDMtMYv2j5q3gYm0xN4GgUJsrp7Yk3ScXvg9xskCHhSuktXsAsKi8bWdEdLXHTH6nNJY7lyWmM9iK+wM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE31TQAOOVLcrabv6iSi0+SQh7ZscKDs3B5d2nJMVQ8=;
 b=OTgnz/43NzYBpv/+yUdoxUYxEQyZVRcMKEIOHPLe93NIvKQh15m1TG9RXUqooz7g3j91cCajLDC2cMlA5AmOnslYbDWIhsBMBLGMhgor3YHVyYaKlxKbn+oBGq1FzXJc9TDRUPCu/2xntkuUNFTfaWrynWMlDJhA9ETU/GrzlhHB9TlhU/b1IDItTmsyEC/wJvqdZii4rsMJoPsugnPi1Io6MwhgAJUnQTnyzLzs+/Fr/u1418qdW2GhfzK3YyQF+/CRKIdXvU6vG8i5c92T5wp/oGpBsF0IH8NGH9Siz+5NhKDDn9Tjd0b0neEgLumDgTHYD+boGz/tfpUHCfzCYA==
Received: from SJ0PR03CA0254.namprd03.prod.outlook.com (2603:10b6:a03:3a0::19)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 04:46:35 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::de) by SJ0PR03CA0254.outlook.office365.com
 (2603:10b6:a03:3a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 04:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 04:46:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 14 Feb
 2024 20:46:23 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 14 Feb
 2024 20:46:23 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 14 Feb 2024 20:46:22 -0800
Date: Wed, 14 Feb 2024 20:46:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <axboe@kernel.dk>, <will@kernel.org>,
	<joro@8bytes.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <murphyt7@tcd.ie>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 2/2] nvme-pci: Fix iommu map (via swiotlb) failures
 when PAGE_SIZE=64KB
Message-ID: <Zc2XHbcXZzV2a61n@Asurada-Nvidia>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
 <Zcv7uI6VrMc2EuGT@kbusch-mbp>
 <ZcxZD2GXmR5+vC/k@Asurada-Nvidia>
 <Zc1qpr4zCy1N0OND@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zc1qpr4zCy1N0OND@kbusch-mbp>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: a2256ccf-dde7-4beb-9387-08dc2de116b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VH4fWXtc6CKdLyTPdAVXg+0BKrzEwGymWO30BSsK7mcaFHcAXuvVxcuQmtZ44uIdCJqJO18dgJLnhud/nZs5qt84iyWHWOjXqtZIyZQLHiH5HNKjvmgHsxUgCRmWuctgjaRBV/6IVrLoO+X7sJcS3/pWNLJlAK9doKXre/aGwXvtG9FUg/fYtR/v9vBIsZQfRg6aFtZQQlf1GtA/R8cwTghzH/stKmEasKBX+CrnKDZLZqhkdudMQECeBRhZMx2gSP4/4CMFOUyd/c33PBAEchn0rdmzJiZqG+Eu8GMprYa0swz5dzkfWp4/HkQaHDtiFPVkgTCwUwIEUFgZFiqfQbZGyvHixBmb7nOaReDNqvrChtItmnmR5hJOSkbhGpt55R/OUUCgt7eSf4OdICxD5lWEYwmH/lcl8QTFWG8HovPFZRDP/T6ULbegJUNs5ybLTt1kz9Cb9S8RVGO67ERORpDSdd0aCZ8et6YCYGVcbX+1ObXndmmiOsYanyqRyvtlaG+6Bw878MTvHXc1X6J7RX6CG5MJPa+eQJbaH9JaXRvCSGzmyH3u901uM/3fB6//YumndDLmQ1H3exLjgR8PV1r+BWpvhCX92kpCgy76+ckovwzLzqU1YqkppcYSADrGc5MxGd2R3ZxMGfU+Ivwjdl3ijQbtBVZLvTLs1COh7f4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(36860700004)(451199024)(46966006)(40470700004)(55016003)(478600001)(9686003)(41300700001)(33716001)(4326008)(8676002)(8936002)(2906002)(7416002)(5660300002)(54906003)(6916009)(70586007)(70206006)(316002)(336012)(83380400001)(26005)(426003)(7636003)(356005)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 04:46:35.0276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2256ccf-dde7-4beb-9387-08dc2de116b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903

On Wed, Feb 14, 2024 at 06:36:38PM -0700, Keith Busch wrote:
> On Tue, Feb 13, 2024 at 10:09:19PM -0800, Nicolin Chen wrote:
> > On Tue, Feb 13, 2024 at 04:31:04PM -0700, Keith Busch wrote:
> > > On Tue, Feb 13, 2024 at 01:53:57PM -0800, Nicolin Chen wrote:
> > > > @@ -2967,7 +2967,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
> > > >               dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
> > > >       else
> > > >               dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > > -     dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
> > > > +     dma_set_min_align_mask(&pdev->dev, PAGE_SIZE - 1);
> > > >       dma_set_max_seg_size(&pdev->dev, 0xffffffff);
> > >
> > > I recall we had to do this for POWER because they have 64k pages, but
> > > page aligned addresses IOMMU map to 4k, so we needed to allow the lower
> > > dma alignment to efficiently use it.
> >
> > Thanks for the input!
> >
> > In that case, we might have to rely on iovad->granule from the
> > attached iommu_domain:
> 
> I explored a bit more, and there is some PPC weirdness that lead to
> NVME_CTRL_PAGE_SIZE, I don't find the dma min align mask used in that
> path. It looks like swiotlb is the only user for this, so your original
> patch may be just fine.

Oh, that'll be great if we confirmed. And I think I forgot to add
CC line to the stable trees: the two patches should be applicable
cleanly to older kernels too. Let's wait for some day, so people
can give some tests and reviews. Then I will respin a v2 with the
CC line.

Thanks
Nicolin

