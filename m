Return-Path: <linux-kernel+bounces-39216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8D83CCF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F68291D84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFECE1339B2;
	Thu, 25 Jan 2024 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uaFbojnD"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF11350D7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212575; cv=fail; b=gFJnICm1F/2eoK4QoQGC1Dgm2LIMIEy1JwQ+3UkPFZXuzo+R7fWVmWqhXLA8qEQ/KF8hfhdp2MG6rAgbPmGuNuVA+bqHXZqpYmkrk7CYh4QI1DcENzMBquuR1o2W7WynTQvTdAp0OLLAcWaDnyw6d4dTD97nh7Vdc4iOD7zC68k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212575; c=relaxed/simple;
	bh=i9Xbpbv1o4XLQwaCshHFd2p15g2bOMtqgmQmjqLG/U4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iogH7aQ9r0IBwKO1rAp4YZs8z5qR6LBGzk73StHTV/ryhaMwXXGECs5fz4a+XurTBSM09IeRTWLiJU71mTIO+hOq/q1IU+0gI4EX/v+15CwezXOnVdSXqB9+oxHVaN4Qv2guK0GskMJoTN9Gvan2NBfxpFNldhvWJGJZoSQLmJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uaFbojnD; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIYPZR7FQhqz/aW2wpNXnQPoXENQNXbTFz6UbuH7EJ0XMdVdKcthzL8ko3Sfc93ROiG6B7eVANVgvgScK/KsZWYTKSBlLvt4kWPbiJAL19HMn7flZ1wIcoQYqR8JbmxP68QYSuwlp0M5U2zmkk8snJP4f5J9MqR8TBfLOj+wfFOEEdJ7fX/tIQeQcVvHEJF1TEZFvXED5Uan8vwGG+a5Z5ONHDqdmUVPuWfVN9VzZP5LfFbSWulACpAQC0WV1/167tlZO+woj1Ufd2n3X3AfkuuN8ENejnJFgBL5CfpHuJs0mNFi2wAfJurzKol8VKGZ3+3XTu2fbr14cZuPEdHN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhZqUncc1hO7qGO0tinPjv4U9XLEdukstuowcIhOXho=;
 b=YYQBJiWBXkLzlzA2e2Lq9uuo21eYy5MEhCQQgjTc/ln4NU5CfKQ5QygU4+EUPAkb0MkHE7K0ZQZ517Cf9uzV1dVhMpPv9H4w6+0FfmBSUnf2BgMQxMDiyTGiXjzuFQiTQt6j3sFCgAsvaSQsqbWueMdckKkB5B4kDOZMM6lKEhhI7SuU9pyv4LsioIDwnxiPPDIp/vvpudNGcou4hy/pax01lhLofWGQcOYkReZ3hVP1bzUj/Gq/La03WpBNboalq+tC35n0ObDkZolCOKb9UOWPUTCDEGvlZmEDWH7FFTnAwcRy3QZHkM3r3zZ1pUjMXoPgx4+QMbekzWwWE7Q5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhZqUncc1hO7qGO0tinPjv4U9XLEdukstuowcIhOXho=;
 b=uaFbojnD+JxfGL5svBY538vwvw6KOKbJRgQwx4GFCZnUk5Jzx4+NZx8pBrX3OqtehniuZFWSz1wzdeoV3erkRjvXbpGQh8Hc68TpfY9V1gvliPg3ti9fW0IMFZ8OueSlExTYzeukIYDlT4LaQRzZgEY7Zhs+h8LVmi7r6DrXapiRpS0obshwQdtNQ8crRpW9szm4Ua1MyU3UTB/ogX8DxF6kklCtk/JMR/bY9PBe8NibBIqKcwVB2y6DkCOWqA9Yv4xSfHIXBAedVvgE3hmMA4IaQOm6WTsSUXv2INIPJpBchzrsQ1sjW/hYFsxhON95DEgLoY7GpFSwRWfGcWPU2w==
Received: from MN2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:208:234::33)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 25 Jan
 2024 19:56:11 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::d6) by MN2PR16CA0064.outlook.office365.com
 (2603:10b6:208:234::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Thu, 25 Jan 2024 19:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Thu, 25 Jan 2024 19:56:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 11:55:54 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 11:55:53 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 25 Jan 2024 11:55:53 -0800
Date: Thu, 25 Jan 2024 11:55:51 -0800
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
Message-ID: <ZbK8xxdfeuJ7NQ8E@Asurada-Nvidia>
References: <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
 <20240122130152.GP734935@nvidia.com>
 <Za6kuE4KUPuwk7+j@Asurada-Nvidia>
 <20240122175700.GB1455070@nvidia.com>
 <Za63HOMZE2fuJKQ4@Asurada-Nvidia>
 <20240125135537.GP1455070@nvidia.com>
 <ZbKY9BmXZiHPiEOk@Asurada-Nvidia>
 <20240125174728.GR1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240125174728.GR1455070@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: ff578901-742e-4b87-fcb6-08dc1ddfae1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w07oHQ/T6ovrx05gMbFdQqCwrIgV8PfmBmK6rQxhtBbbASrtD2ZWG2NWXK2jriUeK9sgBXIDHO1qbDYtDF7qux6Ww3IuzI5gWbgt0QnRXwTni2QuOwo5oBb8+4s0LABCxwhXXqfEOTLT5fMtJR4NOuMsM1p+DIV/cNk6nNo1Ys/1I762YUBGD2qFG/wT29AxbnPhMw/FW09XNPflnd0Ui7Z+GWLTAClCDjlQA5ZJxcQMIf4NfhYQw+kc+eZcPAkNscgl5kKXtj2wTOoPeSHNJLAsoUhOp8ixJsMrx+eQQR7yWYRbK2QeS/PfkTi5OZgMxZBA1+un2bvSAUQ2hqAAmuza+aTt2ukWXLT0wOzqTjRBoGpB1Rie+YRUdCvwuGXBZ+YNbi2LDKVObX7Kh7lCQAYmmeVoAIcn5xeYkxYv586a8GN+gvZWGLrKm23dpEKZiib/T/OvZOFc2SsqNdE5q0M9qj2h+GW0sFgpkiy7nRy6HgKUXso235BmeN9HyD6gNDRvYL7gOy8NaBxthKgd77f8Bi+lqsiyVSEPwHtjJEy3ieZSgFbaGhbt0YvW9mI56Z9D/BfQeuA+Tcsswt3cL8MMEAhLWJzYb2J7fWOBexLurBKAy1l5eCDo/HXx017Kto+129RBgY2+xDzjyNbqUxmeT1JtsIXeiGWV2ASYa4ETJa1iljka+NtJy0EF6amL+eqdxcuJGyfun9dKoLVRYKUE04JVzg0wMq0k7Cl8t723SitMFPuBicw59CqDrw0j
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(8676002)(6862004)(4326008)(8936002)(316002)(70586007)(2906002)(5660300002)(86362001)(70206006)(6636002)(36860700001)(47076005)(7636003)(356005)(54906003)(82740400003)(9686003)(478600001)(83380400001)(26005)(426003)(336012)(41300700001)(33716001)(40480700001)(40460700003)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 19:56:11.3653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff578901-742e-4b87-fcb6-08dc1ddfae1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837

On Thu, Jan 25, 2024 at 01:47:28PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 25, 2024 at 09:23:00AM -0800, Nicolin Chen wrote:
> > > When the soft lockup issue is solved you can consider if a tunable is
> > > still interesting..
> > 
> > Yea, it would be on top of the soft lockup fix. I assume we are
> > still going with your change: arm_smmu_inv_range_too_big, though
> > I wonder if we should apply before your rework series to make it
> > a bug fix..
> 
> It depends what change you settle on..

I mean your arm_smmu_inv_range_too_big patch. Should it be a bug
fix CCing the stable tree? My previous SVA fix was, by the way.

> > > > > Maybe it is really just a simple thing - compute how many invalidation
> > > > > commands are needed, if they don't all fit in the current queue space,
> > > > > then do an invalidate all instead?
> > > > 
> > > > The queue could actually have a large space. But one large-size
> > > > invalidation would be divided into batches that have to execute
> > > > back-to-back. And the batch size is 64 commands in 64-bit case,
> > > > which might be too small as a cap.
> > > 
> > > Yes, some notable code reorganizing would be needed to implement
> > > something like this
> > > 
> > > Broadly I'd sketch sort of:
> > > 
> > >  - Figure out how fast the HW can execute a lot of commands
> > >  - The above should drive some XX maximum number of commands, maybe we
> > >    need to measure at boot, IDK
> > >  - Strongly time bound SVA invalidation:
> > >    * No more than XX commands, if more needed then push invalidate
> > >      all
> > >    * All commands must fit in the available queue space, if more
> > >      needed then push invalidate all
> > >  - The total queue depth must not be larger than YY based on the
> > >    retire rate so that even a full queue will complete invalidation
> > >    below the target time.
> > > 
> > > A tunable indicating what the SVA time bound target should be might be
> > > appropriate..
> > 
> > Thanks for listing it out. I will draft something with that, and
> > should we just confine it to SVA or non DMA callers in general?
> 
> Also, how much of this SVA issue is multithreaded? Will multiple
> command queues improve anything?

The bottleneck from measurement is mostly at SMMU consuming the
commands with a single CMDQ HW, so multithreading unlikely helps.
And VCMDQ only provides a multi-queue interface/wrapper for VM
isolations.

Thanks
Nic

