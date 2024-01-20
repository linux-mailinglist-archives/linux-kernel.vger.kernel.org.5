Return-Path: <linux-kernel+bounces-31895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8ED833605
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14BC1C20B7B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616FE11733;
	Sat, 20 Jan 2024 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f5B8mRkZ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF523CB
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705780804; cv=fail; b=UxXKoFspyyZf5TdruXKFzVHs6yMOxuqwgaZmQZ+aVfwhWB5XhtRt7YvaNBncOjNZNSYGsegLUeYCfa1PHfo64qNXV01UpaXVa1Czij/EOcCszeGGzieGG5g470afb/6rovOeaAyrpcTgGkyN7SGdz0FJEe93WuheUZYSKeAwDmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705780804; c=relaxed/simple;
	bh=b+Cy9XgPTN73XRNgIVMw7zX8NEsLDa4y9envOVwsOJc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLUOMG+7zxTgEIN9psEm2DCke4CqyFjLBuJGoo29ghsepxyY5dmRWB3FISELpvhyI4G2tof3NjU5prvIo6qKKsVEhrdRWP2NzX1LsyeUHyOFuRe7WXbrGxGr8Z4H/kKRgknNSbLZL9iKIPnlnxbwz9uyMPdIRasIWnFPmbH2hSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f5B8mRkZ; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgGowTr7f0/rlmsmOJKQI86AfuCFX7JMqzABH2Tu/6M2PDLF357WI560oN65Q69s62bLwA/q07nJ29WWnOJApXgStKcsCqn9S6VrsWj6VSB8ShnF0BvzM0y+mHmGMQh5YmH4Nt7+zggF1UzyOy6WFln9Vec17gQofvEA2R3JcOCXeSowDFyAUe+0KbRfwHMvAZLoAuKkSNt5RwyZK/KAND4ZKg4AimcZfxD4usLSEYQ0fbcWUOXsLguG05FFRz8nTshWCD6kODa/NJPOQVwYKoJF8axSUYFoUshXt0yHVXVEK8k8mBjxs1hABtGTBcbXhPupvhs80Qc9sIrJB82Ayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1rCnNPrvWYqAR2SUXL0dZtnpfqnt+2FNTUXJH8kkM8=;
 b=bvmlX1siV3/a5tljz8lGY1C5aTk907U/EaqUSc9H/m0ufMUixNlFfc2//VcM6fwB9q70tJrfvHAFJb7VXtmYtdaVLj0WQ1+bS0eKT3jqbdkkWA7oJ73lqEXarVhAqg+OdVHiF2keE8qG1Fl51KOUwqnw9lkuu6Hw/9KdYOolYkYCdYrS6o/XuY4/SFfjA1WY+jO1MO8SgQjoRPETKn4h3+KzryY8M8JIUgXW8AKegtaIRs3M22/9RP/git8+N8BtCyJkPTW9lw2hJiPIYHbYL+yAH2n2d0/cM+oKGaTZwsg6Kp7nTNAkwYT/LjrQoJqe/6jTbQH+R9m4iMhlASjLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1rCnNPrvWYqAR2SUXL0dZtnpfqnt+2FNTUXJH8kkM8=;
 b=f5B8mRkZXvl527DJvozmDb5z1n6+FTbHAyKFNe9okYEteWuZSAFeckIojt+VNFAss5ubP0AX+crXvQjURZxd8S9aqfay8Z+AnYkn21m2SzOt9Qa4d9jKh7CJtdykE5lYiPi0/fGysYrgQak90tKR6fCt5eyJK4xC7Z7omD1WBVhCBuohR9jeBGC+qS724LT+sP0C/Yl5p5tq2HZwjsZ4OtaGQ3D074Di/tUCA63f4mhLEsd3cwpm1X8evaOTiTqaAVm3bO3xmk1dxYcuZq9wzltC40kdpSGihNBbfJ1LHPPDIcLXBBn7is8/zcZTSTcSKa/OLN0bCHPgP29tmlVGcA==
Received: from DM6PR11CA0034.namprd11.prod.outlook.com (2603:10b6:5:190::47)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Sat, 20 Jan
 2024 20:00:00 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::ba) by DM6PR11CA0034.outlook.office365.com
 (2603:10b6:5:190::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29 via Frontend
 Transport; Sat, 20 Jan 2024 20:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Sat, 20 Jan 2024 20:00:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 20 Jan
 2024 11:59:47 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 20 Jan
 2024 11:59:47 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 20 Jan 2024 11:59:46 -0800
Date: Sat, 20 Jan 2024 11:59:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "will@kernel.org" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, Alistair Popple
	<apopple@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1c5f57-34ef-4ffe-f994-08dc19f2628b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zNAK7cmz+fwpfNQEua8ezcyngekqJe7bMnQMZbb6v9qulaZUxvkRYS5gtgYgaQGed7Y9T81+xsDsaV49fsXWIsuvbJ4djt4e1TFYzhbzrxDaBpjvMTgwJNUHEo0dPcfsWd9vLmwFAzNaGA9l1OV/qUOyl7TaABl2+OhxxexPOTsghYdyOfjrU5vD9tvI/XjLeKVnSswCdfKfSFEww0bkNHE0woi/NY2h6mhDZi+7tHcl7wP8dwPlFH+tILqJZ3mzQg3A2PWmH6MS5kAJ4wEFKvtQKFxm6HJylcZ/qa7iGLmjjAgsLB3PC+OmGB6oIPArY3bJVA4HGbUQgraOcE4S0ou2dSj+EVFHxIdZc5p1lniXWE1sSGIJflLM5K/0KHHWXoRb0RvfSLoGWMUEqScLnHZekYGtmZkA+0WtEKW6tAU/w3GtSxsF9BJOo/ybeEc5a0i7sMxP5zl+6ikJM5CvqXXI2gi9HjFRNuw61LMHoH0R98t+VrfbEI5htDZQqZUhyFK37Y65fpETVdFsCT8OACW0xwzW5qNgf3IJoGsWsVkQEIK1pHFG+qtYHLs75lhZeQWi6BmsQSsrJ6MVQwOD8XKhki8J2DhrRrwEc/4ksyXMGpV0uJbiMTDcTdnIJ/RQNlLIJljifhJu47U4hwZjvZpbUrdb3P+X4TQ9mGD8Xu7uqs62hDR9uwSVsQBLQCuvC5l0f1NP1LAiSqL9JelRipDAOpi7e0fpWgyMhdWzJfAs9bXHf1zIj4GHnvI2Yv3KhNK3s6NhHlGub3W5bmDaE0sTSm7K4LSY/5TB0iQFLJ4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(66899024)(55016003)(40460700003)(40480700001)(426003)(9686003)(336012)(26005)(7636003)(82740400003)(86362001)(356005)(4326008)(36860700001)(83380400001)(2906002)(5660300002)(47076005)(33716001)(41300700001)(8936002)(70206006)(110136005)(966005)(70586007)(316002)(478600001)(54906003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 20:00:00.4325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1c5f57-34ef-4ffe-f994-08dc19f2628b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

Hi Robin/Will,

On Tue, Aug 29, 2023 at 02:25:10PM -0700, Robin Murphy wrote:
> > Also, what we need is actually an arbitrary number for max_tlbi_ops.
> > And I think it could be irrelevant to the page size, i.e. either a
> > 4K pgsize or a 64K pgsize could use the same max_tlbi_ops number,
> > because what eventually impacts the latency is the number of loops
> > of building/issuing commands.
> 
> Although there is perhaps a counter-argument for selective invalidation,
> that if you're using 64K pages to improve TLB hit rates vs. 4K, then you
> have more to lose from overinvalidation, so maybe a single threshold
> isn't so appropriate for both.
> 
> Yes, ultimately it all comes down to picking an arbitrary number, but
> the challenge is that we want to pick a *good* one, and ideally have
> some reasoning behind it. As Will suggested, copying what the mm layer
> does gives us an easy line of reasoning, even if it's just in the form
> of passing the buck. And that's actually quite attractive, since
> otherwise we'd then have to get into the question of what really is the
> latency of building and issuing commands, since that clearly depends on
> how fast the CPU is, and how fast the SMMU is, and how busy the SMMU is,
> and how large the command queue is, and how many other CPUs are also
> contending for the command queue... and very quickly it becomes hard to
> believe that any simple constant can be good for all possible systems.

So, here we have another request to optimize this number further,
though the merged arbitrary number copied from MMU side could fix
the soft lockup. The iommu_unmap delay with a 500MB buffer is not
quite satisfying on our testing chip, since the threshold now for
max_tlbi_ops is at 512MB for 64K pgsize (8192 * 64KB).

As Robin remarked, this could be really a case-by-case situation.
So, I wonder if we can rethink of adding a configurable threshold
that has a default value at its current setup matching MMU side.

If this is acceptable, what can be the preferable way of having a
configuration: a per-SMMU or a per-IOMMU-group sysfs node? I am
open for any other option too.

Also, this would be added to the arm_smmu_inv_range_too_big() in
Jason's patch here:
https://lore.kernel.org/linux-iommu/20240115153152.GA50608@ziepe.ca/

Thanks
Nicolin

