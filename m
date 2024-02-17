Return-Path: <linux-kernel+bounces-69690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE09858D54
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AFD1C212F7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020481C691;
	Sat, 17 Feb 2024 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fhjmwjq3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4BB1C68D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708147202; cv=fail; b=nMsY7OS8CcdiLT+mFlyQZGTpgMuw5Fs1ZGF4fy4/+/cfkug3zo2fX4JUCP6A3Ntj5Xr1W9NEJ2Nzp43U7RX0mQnhn4yonONo0r4JLAdimtnXgnGvyzOLDqya2aYvaByqbsAjPJdpfJDj1tOPwgZxdTYwwEv5GwfHbUAaDKJfEu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708147202; c=relaxed/simple;
	bh=8028RpLsP13I6vfrW0EFmS+mMykXaKrEar0RLUMI2z0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CekE95SzWNI/T+35Ai53p/y26seiDpxVjWPzo+k0nb/pjGPrqFSpDcd/Lg1jldhCu/kCpFM6+8KF5NOVLJg8QGL1UONlYXi+SzWdw4q5e4PuxObZ3oBap9OFG+8+LKcVZHiRR3zi+JkQOUgaUfD9Kz5RSP5rQyuKAT66g/Jn7SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fhjmwjq3; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD80Mq0UC13neH+ZFephEB7Efveo3xrkqYX5oWGEoDXzAknVvkS3EZMjS4tmiDF+WuZNRoel/SG3C0z/XrkN2ma0DzDDcbVNRiFdb1Lm6r/VAbgvlhDyCm6KdGlq6jSlw+M9eGICGi0wHLGzDOx8yJqf2eE4l2Ke89aKp1dhma7oGuGBQtwYoOoLJkFIp/6xGde7oVONQxx3+zcZjsLbvH8nSDFk/p6lUc97xina8jvHjaS/YDg7ZTmvcGqX10lUzZFf8vhZkdFCTzlbOogtBL3a4SmeqifkUdpiXlLDWPTTRffv7t4N1CL8jkTzJcGvAoyomoAvFSuSUQzXSHiVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ync0L8Wo4W0zR4gp834MGlYuV3DQN7eagJtxvoQzt4Q=;
 b=aRXtx8lLAuA2v8yZ0kCHWxZVnGePfzRzvyqK6//+qkYLv0LJhy2IwrTfXwRNWo6vEvdM1IOvLa9JGSRABLJi78WhTtXji2AX2iTQ6vI3rw1qZ+QsPdwpbHYbZtSuRsKeY6wjUloB/NUppt4A55rklmx+LnPDByV9dU7Zk8Bg8C6TTgasPFUCdWQdGfP63b81mk26Oe+S8AbI/DJ/ufL3JNf3P6+NQeMRYu3THrNk3P8pE4lgjVTZITsRpR0vrONSxhSz+LXjdBZTd+SZhrA/AFdLYUjwlKnl+TCOfMU7RJ0R3T4NsdO78mDw/PqJBjZomW4TV+Q6pbrUDxr4sC8MSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ync0L8Wo4W0zR4gp834MGlYuV3DQN7eagJtxvoQzt4Q=;
 b=Fhjmwjq3EG44OD1ZVHhIwJbP11+8ooEVn77mBzaRUQfnRhRUA8fRldy/oAPVYWXFY/7mYReP9yDo+7H5/aOr1CkjIao78WaBn4TdvfPCTaRAEHm/n1f27y+eFK7ZTrf+aKRFgP/WWUSAOf2HkuKjWbxZx71csI5RMHgVheB8JB72nfO+4xLoHf9XNLShlxLCo3YYLgckL9WW6eafQuPm9qKNsVxF17Y7A2XWSnl3oqy5mn1kpGk8KFv6Y1FsD0PhsTB1l118dEc2QAJ2/2CR3xurW18YYSQ5zcU6PlbGKmRN+034iggh2ct36q7BqNFajCqSZyuAVvV2KihMBpmQgA==
Received: from CY5PR15CA0254.namprd15.prod.outlook.com (2603:10b6:930:66::28)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Sat, 17 Feb
 2024 05:19:58 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::77) by CY5PR15CA0254.outlook.office365.com
 (2603:10b6:930:66::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Sat, 17 Feb 2024 05:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Sat, 17 Feb 2024 05:19:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 16 Feb
 2024 21:19:46 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 16 Feb
 2024 21:19:46 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 16 Feb 2024 21:19:45 -0800
Date: Fri, 16 Feb 2024 21:19:44 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <axboe@kernel.dk>, <kbusch@kernel.org>,
	<joro@8bytes.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <murphyt7@tcd.ie>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Message-ID: <ZdBB8BYsK6WvwTYC@Asurada-Nvidia>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <20240214164138.GA31927@willie-the-truck>
 <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
 <20240215142208.GA753@willie-the-truck>
 <20240215163544.GA821@willie-the-truck>
 <Zc6rr/LleQ2krkyg@Asurada-Nvidia>
 <20240216161312.GA2203@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240216161312.GA2203@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6443f3-0ad0-499c-18c1-08dc2f78159a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NN4qgR9ylHpFArZWokZvWHdLEsr2ZHMBc2kzKVVWVzfJTG3fFYmayIu+mhkNUbX/MEft08/3sEQHpA/NgiXzxUohSalip8fIBJU90tRCB4afXh8zqYu4qKZ7BKcfRAmVYmrJagYPIY4ojjqxRAFgucnk9RwnJzx02YYO/LD/Cwy6mKyCb8HPzlDgoE1Jyr558HV9ZkP4zI2jdogo2h4pozaNsu3PAeEhJ7F+QBrpqfYMm/bLk3GuN3ndc2bBdYwac4Gx/k7NoAS4Z/Gd6+GqeASmunhP1FT9SLKOCvCjnnv+NjBvIfRypC1XQW0DYsakz4LlDUMdfQVxYzPCqQhVyADjPpWSothH01l4MmGkM/qRfALjWuscxVxYPkPNTGfognPtPmbILK5m6xpJMJ1jIV3cfYC3CEAnBUIm3/lVviKTFhMxkP+DjlBbn+rB8FFKuCxriDUxDNYHrHdc9AALRx7ZAJ6ZoOhz7HZcA80KMOblQ4gStpgntOekwFjQtsrd1D8ThDx7tK2Q1pgCgwecFkaSXFqqnZY818BXGt0mqPyqc1DYW+TeLaq/UWhbZlYK16w3Nh3h8IrfvcVGcFmZyUqkWzwRpmXb8bEtX3kNIjEswGNPtC4ErlngNuEvYW+jlcxewPNbWITMSVMUpEBzmuSHbSh4iaftEiThD204SzQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39850400004)(376002)(346002)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(36860700004)(40470700004)(46966006)(356005)(86362001)(7636003)(33716001)(82740400003)(55016003)(83380400001)(8676002)(5660300002)(7416002)(2906002)(70586007)(70206006)(316002)(8936002)(6916009)(4326008)(9686003)(41300700001)(478600001)(336012)(426003)(54906003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 05:19:58.3831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6443f3-0ad0-499c-18c1-08dc2f78159a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413

Hi Will,

On Fri, Feb 16, 2024 at 04:13:12PM +0000, Will Deacon wrote:
> On Thu, Feb 15, 2024 at 04:26:23PM -0800, Nicolin Chen wrote:
> > On Thu, Feb 15, 2024 at 04:35:45PM +0000, Will Deacon wrote:
> > > On Thu, Feb 15, 2024 at 02:22:09PM +0000, Will Deacon wrote:
> > > > On Wed, Feb 14, 2024 at 11:57:32AM -0800, Nicolin Chen wrote:
> > > > > On Wed, Feb 14, 2024 at 04:41:38PM +0000, Will Deacon wrote:
> > > > > > On Tue, Feb 13, 2024 at 01:53:55PM -0800, Nicolin Chen wrote:
> > > > > And it seems to get worse, as even a 64KB mapping is failing:
> > > > > [    0.239821] nvme 0000:00:01.0: swiotlb buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
> > > > >
> > > > > With a printk, I found the iotlb_align_mask isn't correct:
> > > > >    swiotlb_area_find_slots:alloc_align_mask 0xffff, iotlb_align_mask 0x800
> > > > >
> > > > > But fixing the iotlb_align_mask to 0x7ff still fails the 64KB
> > > > > mapping..
> > > >
> > > > Hmm. A mask of 0x7ff doesn't make a lot of sense given that the slabs
> > > > are 2KiB aligned. I'll try plugging in some of the constants you have
> > > > here, as something definitely isn't right...
> > >
> > > Sorry, another ask: please can you print 'orig_addr' in the case of the
> > > failing allocation?
> >
> > I added nvme_print_sgl() in the nvme-pci driver before its
> > dma_map_sgtable() call, so the orig_addr isn't aligned with
> > PAGE_SIZE=64K or NVME_CTRL_PAGE_SIZE=4K:
> >  sg[0] phys_addr:0x0000000105774600 offset:17920 length:512 dma_address:0x0000000000000000 dma_length:0
> >
> > Also attaching some verbose logs, in case you'd like to check:
> >    nvme 0000:00:01.0: swiotlb_area_find_slots: dma_get_min_align_mask 0xfff, IO_TLB_SIZE 0xfffff7ff
> >    nvme 0000:00:01.0: swiotlb_area_find_slots: alloc_align_mask 0xffff, iotlb_align_mask 0x7ff
> >    nvme 0000:00:01.0: swiotlb_area_find_slots: stride 0x20, max 0xffff
> >    nvme 0000:00:01.0: swiotlb_area_find_slots: tlb_addr=0xbd830000, iotlb_align_mask=0x7ff, alloc_align_mask=0xffff
> > => nvme 0000:00:01.0: swiotlb_area_find_slots: orig_addr=0x105774600, iotlb_align_mask=0x7ff
> 
> With my patches, I think 'iotlb_align_mask' will be 0x800 here, so this

Oops, my bad. I forgot to revert the part that I mentioned in
my previous reply.

> particular allocation might be alright, however I think I'm starting to
> see the wider problem. The IOMMU code is asking for a 64k-aligned
> allocation so that it can map it safely, but at the same time
> dma_get_min_align_mask() is asking for congruence in the 4k NVME page
> offset. Now, because we're going to allocate a 64k-aligned mapping and
> offset it, I think the NVME alignment will just fall out in the wash and
> checking the 'orig_addr' (which includes the offset) is wrong.
> 
> So perhaps this diff (which I'm sadly not able to test) will help? You'll
> want to apply it on top of my other patches. The idea is to ignore the
> bits of 'orig_addr' which will be aligned automatically by offseting from
> the aligned allocation. I fixed the max() thing too, although that's only
> an issue for older kernels.
 
Yea, I tested all 4 patches. They still failed at some large
mapping, until I added on top of them my PATCH-1 implementing
the max_mapping_size op. IOW, with your patches it looks like
252KB max_mapping_size is working :)

Though we seem to have a solution now, I hope we can make it
applicable to older kernels too. The mapping failure on arm64
with PAGE_SIZE=64KB looks like a regression to me, since dma-
iommu started to use swiotlb bounce buffer.

Thanks
Nicolin

> --->8
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 283eea33dd22..4a000d97f568 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>         dma_addr_t tbl_dma_addr =
>                 phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
>         unsigned long max_slots = get_max_slots(boundary_mask);
> -       unsigned int iotlb_align_mask =
> -               dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> +       unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
>         unsigned int nslots = nr_slots(alloc_size), stride;
>         unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>         unsigned int index, slots_checked, count = 0, i;
> @@ -993,6 +992,9 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>         BUG_ON(!nslots);
>         BUG_ON(area_index >= pool->nareas);
> 
> +       alloc_align_mask |= (IO_TLB_SIZE - 1);
> +       iotlb_align_mask &= ~alloc_align_mask;
> +
>         /*
>          * For mappings with an alignment requirement don't bother looping to
>          * unaligned slots once we found an aligned one.
> @@ -1004,7 +1006,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>          * allocations.
>          */
>         if (alloc_size >= PAGE_SIZE)
> -               stride = max(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> +               stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> 
>         spin_lock_irqsave(&area->lock, flags);
>         if (unlikely(nslots > pool->area_nslabs - area->used))
> 

