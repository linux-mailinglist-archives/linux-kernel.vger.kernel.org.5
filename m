Return-Path: <linux-kernel+bounces-65903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633B85538D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B001F24BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083913DBAF;
	Wed, 14 Feb 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d2TlUizf"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8913DB89
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940672; cv=fail; b=JdKaB/Re/oFGzYiu2CfYwtu4LcfcYKi1fdUoG/FoQcVHIKdmsRucSn9p6zymXeHDKBZpgHjxYsa2PaXmOtZ93ngxjYPvZIYDOP4CTTHfRijTQi7Ecs/7UC0P/75Kk3sct8sApLE1YzGa6yCiUpc2IHl8PTdkfSNr6WcSOHDZysM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940672; c=relaxed/simple;
	bh=7YRYn2SAKkky3v2X4XmxwjdgQxnfVO+9+plUTxW4RdE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEuN9S9ERSx07Q+I4qJLmNup+AFh3MDV1qDGRpo/1Y7X82pStacPGn7VZiHpa5+VOP1RHaNaKwvsJM4lUOOF1aXB8bwQa7Iyf3Ox2LK8+h0TzA40zD5pN5j4bghxSiIz9ic3ZnnL+a9pybTE9gPVVYODIYlM4e+A/hHeNNRUBC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d2TlUizf; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APyLxyxkr0JSLT6erWJoXKUEmAUzkpgjIibo1q7YOIxfToAXk2dE8kq92rfnYvCK71U9uGU2oDOkYJ3VeXmsWzGXn2GtZlo71AYwtanr/gurofatjh48LR5EM8TxErh2/2FIuYfw0n5xasdGAnBefXVSGY2BqmDETeSHD0dcmYNNdt4p8FrAfY+vQipgvEAXx5HC29PYofsEoRmklGusqB8cFzGYRUWzKZwf9kP9iFDfz+oDffOzTDqoklhGGv4sinXJkUx8kUpnnqFyVSJZvGK7KITCdOZBaDaNmXYfvMi93eWPTwwuvdcfBIdhVOzOeg+8xxiGcrQiYCycc5lIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f9gxrETEuRfaZrn83Vw971b9MljLgOHwCVrmXxxwKU=;
 b=gMgxdJPTQWcqCLvU2vcHT5lzguJgxK/CPR4SShhnnoAfcpsi+O4vAFQdOvc4zwyF/v0a70z6HqHXzUP/jW86j+Sv4rg5ycY1oQiDTQnPQEFoauZMEvHMwH6Bm7NAa1yF2YG+Mx6/XKhyis4jjdr0+r0HE8z+ATizoP+qHZWBJsCwJvAQGEklx1Zs8Ek9eUxNAhAtWzSfb94/dZb1gROcyRnBVe484kNAJseJgmk4WShA8P4nk4FXnZWMlezmHsNlY4W5lNwOiLuNzZUcMnsmpscITXBVS+vKV/QbqbRfuxfYvaCrKXn6j3iHnTYPg1RuaEWKvKg4rFsc3B5tnWiPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f9gxrETEuRfaZrn83Vw971b9MljLgOHwCVrmXxxwKU=;
 b=d2TlUizf8bCsO3+LLr7vv25aCaXbaMV7l4lmie8f/lvOUVVo8n6urdfUglzho6qWB4AS/Jrkz0rwmcy4EpfEJXQVEIQFsklGm7IGDCqpP++B0YGgttAEwjik/XtaY9mTXlUJA52IO5CVfVPnI7m273Y6QDWb7J5cISogeqC0bNbQvDxznZKxdYixD39Re6p2CbHgX3fp89pfa/voBhCttdcwBctT1XhT7RpCGpnJhSr4MC0nRGssjy/JuACPW7BDb9b958PkfdB7Y1QJk948cmyXc2mdZHCuCnr15tJb3vVzna9/SuSvwHgqdkzQXsucuYUQmHxL3arAJHA6KVXkSw==
Received: from CH0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:610:11a::11)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Wed, 14 Feb
 2024 19:57:47 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::88) by CH0PR03CA0360.outlook.office365.com
 (2603:10b6:610:11a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 19:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 19:57:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 14 Feb
 2024 11:57:34 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 14 Feb 2024 11:57:34 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 14 Feb 2024 11:57:33 -0800
Date: Wed, 14 Feb 2024 11:57:32 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <axboe@kernel.dk>, <kbusch@kernel.org>,
	<joro@8bytes.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <murphyt7@tcd.ie>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Message-ID: <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <20240214164138.GA31927@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214164138.GA31927@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 016addfe-ff54-4ebe-7b13-08dc2d973732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qXrZAmJ9AYHHTEZNGrDOlQdvxJyajZGPAC8xYENKvtPDRfXvDN3B0RFP/RCcjH+m8O1ome8EVS2KsJItLNXJZ1JWRMDShZnLoVQgIilezkI2VXc8VDA/Dq9mDKHkxsnmJh1T+dN/th4WSGwD3gV8sG9rhm8mGxdvI4QSceBYYKSo7+kMVmhhCuQGiJVaeDk93L/v2Sr7W5uVZtQ5NjPsY5O9SiNTvpzMGok0ZC5uUfcFI3h4LoRD96Sjwd+6d/liGZCSKrK2lywzTPGrmlmEamh4i29gX8C5vFvwIbKgp6cYPuPuErj6zsj+hB1YPTR1izRgWKjjGWSiAmjuH3ks14EWneWJ7FyoKERy2PrvfAFuZ2cPMBvjULnzONC6T6/PnZGsQxn12O7wFJVzDdJNs7S8owD8xV1vyUzeDljub2LpF0UZg6NsEapO9jXEhwXEEBOofwUwEJbFdUZQLgpP/+9CWRyRXNPCPzHIB4ZrAirBAAEaHqJtAJg7RG7iTwdlFlglFVYw6eOaPqz30LOhM9I5fAtZzFi3ywx2v0lZmUu+GViSb+VpuYst5mtQjn+q1/+Gg7QcEC0ZgVqDTu310JY+7CLJI2ptYahalD2pB+HNM2nnwGo+xpdxQ5DLJNsDBBppPEa+bWJsMDfu0XFM3w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(6916009)(26005)(478600001)(70586007)(7416002)(426003)(336012)(41300700001)(83380400001)(8936002)(8676002)(70206006)(5660300002)(9686003)(4326008)(54906003)(966005)(316002)(86362001)(82740400003)(356005)(7636003)(55016003)(33716001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 19:57:46.7572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016addfe-ff54-4ebe-7b13-08dc2d973732
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035

Hi Will,

On Wed, Feb 14, 2024 at 04:41:38PM +0000, Will Deacon wrote:
> Hi Nicolin,
> 
> On Tue, Feb 13, 2024 at 01:53:55PM -0800, Nicolin Chen wrote:
> > It's observed that an NVME device is causing timeouts when Ubuntu boots
> > with a kernel configured with PAGE_SIZE=64KB due to failures in swiotlb:
> >     systemd[1]: Started Journal Service.
> >  => nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total 32768 (slots), used 32 (slots)
> >     note: journal-offline[392] exited with irqs disabled
> >     note: journal-offline[392] exited with preempt_count 1
> >
> > An NVME device under a PCIe bus can be behind an IOMMU, so dma mappings
> > going through dma-iommu might be also redirected to swiotlb allocations.
> > Similar to dma_direct_max_mapping_size(), dma-iommu should implement its
> > dma_map_ops->max_mapping_size to return swiotlb_max_mapping_size() too.
> >
> > Though an iommu_dma_max_mapping_size() is a must, it alone can't fix the
> > issue. The swiotlb_max_mapping_size() returns 252KB, calculated from the
> > default pool 256KB subtracted by min_align_mask NVME_CTRL_PAGE_SIZE=4KB,
> > while dma-iommu can roundup a 252KB mapping to 256KB at its "alloc_size"
> > when PAGE_SIZE=64KB via iova->granule that is often set to PAGE_SIZE. So
> > this mismatch between NVME_CTRL_PAGE_SIZE=4KB and PAGE_SIZE=64KB results
> > in a similar failure, though its signature has a fixed size "256KB":
> >     systemd[1]: Started Journal Service.
> >  => nvme 0000:00:01.0: swiotlb buffer is full (sz: 262144 bytes), total 32768 (slots), used 128 (slots)
> >     note: journal-offline[392] exited with irqs disabled
> >     note: journal-offline[392] exited with preempt_count 1
> >
> > Both failures above occur to NVME behind IOMMU when PAGE_SIZE=64KB. They
> > were likely introduced for the security feature by:
> > commit 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers"),
> >
> > So, this series bundles two fixes together against that. They should be
> > taken at the same time to entirely fix the mapping failures.
> 
> It's a bit of a shot in the dark, but I've got a pending fix to some of
> the alignment handling in swiotlb. It would be interesting to know if
> patch 1 has any impact at all on your NVME allocations:
> 
> https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org

I applied these three patches locally for a test.

Though I am building with a v6.6 kernel, I see some warnings:
                 from kernel/dma/swiotlb.c:26:
kernel/dma/swiotlb.c: In function ‘swiotlb_area_find_slots’:
/include/linux/minmax.h:21:35: warning: comparison of distinct pointer types lacks a cast
   21 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
/include/linux/minmax.h:27:18: note: in expansion of macro ‘__typecheck’
   27 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
/include/linux/minmax.h:37:31: note: in expansion of macro ‘__safe_cmp’
   37 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
/include/linux/minmax.h:75:25: note: in expansion of macro ‘__careful_cmp’
   75 | #define max(x, y)       __careful_cmp(x, y, >)
      |                         ^~~~~~~~~~~~~
kernel/dma/swiotlb.c:1007:26: note: in expansion of macro ‘max’
 1007 |                 stride = max(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
      |                          ^~~

Replacing with a max_t() can fix these.

And it seems to get worse, as even a 64KB mapping is failing:
[    0.239821] nvme 0000:00:01.0: swiotlb buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)

With a printk, I found the iotlb_align_mask isn't correct:
   swiotlb_area_find_slots:alloc_align_mask 0xffff, iotlb_align_mask 0x800

But fixing the iotlb_align_mask to 0x7ff still fails the 64KB
mapping..

Thanks
Nicolin

