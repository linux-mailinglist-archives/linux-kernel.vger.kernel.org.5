Return-Path: <linux-kernel+bounces-33802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E47836EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0674F1F27EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45C053E28;
	Mon, 22 Jan 2024 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G94cixVc"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979453E19
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944275; cv=fail; b=YmRFkYvT+pYLHyFcrRUKnjUkPytlx2S4c6+xzQT/6KuLO5979rorD699j6CMTplrJBxzPobWXPxhj8XfnsvBbmzib/WDmm90e98SbGNjnQfEspx6vPauHhY82Vqu8Mp40ECxxhdgTcm2OO0nlHIYs6wk0whqzT+GNf0wAwYjgWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944275; c=relaxed/simple;
	bh=KT1D4ey727PULoBrq+lq320gVtYRgnDTQBaSuQ56zz8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1COvZi5IgsRP1QJ+ysz512kfT+VgQAty9zg4jIFKl7XBMOG1NgVtZyvWUj1+tq32RfTGsEr7D11QJ6g9n87YkRhS5Rmq25IEPw1rywPaMXnpfFSHKKphrMky2HLV7FccPX17gGFGmqYIDsowjur8NjCf4vrEDWMyzmiUFgNiKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G94cixVc; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsxECND+U9e49N2p7znM8BSL3EQ3TWQwDhAuECyMcu388MsmSjNAgLIsDWfzDSIdvOVHDwayGIZUH6yDSqlw1dvz4hClj4geyIE4Gz3MvLHSIYjeEXc6VAVS1OsXjAcvHiGJdIvHS0zp9psCYmFTxGBAMUXExt36qrZgtaqbSCUZho5xsd2JKmZt+x7yRSdkpXQ2QWyQtaPAQ9B0dp0JTokQsbx59U3true1qRynSjzxinUHgvRVwE4wc03ras1kkdyLpL5gvJmGIaaTFF6OOBbICxEwAN72RfH6Ft1Ed7twSd0v3zmGWoFnKbjzNRFSSYLadrkGAF8/y5xKEHOdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt5Pu7g/cHBNi6wldpBk3S+6XSSffMb7qnU8ZeDEIRA=;
 b=IVciDouQZfYtaohIXhLVMps1S2SVEPl3Q/QEIQVA1exIICoxSwBfYJdsvjBIpKtKN8FxTISJh8voxdLDfaqgJm6kpRqbi3/bNQfGLDYBvdetOL/7uXa2b/lob51Xw7CtXvgYC2p3ekYTC0f1/F+j30XQUBAGZqslyj94N/WeQBy4kQHUoJCnnHVOG0evJ4yamctv4mpWMB5bKddF0pwgLF8ArgZ1rBKimeTY9zerjICfmUY21VHbhYrrv8Mdz3Igb8SVBMReY3g9zjwyv8pwhYHnlalwJN+TaevObgFl1pNSAzor4AC14BTOI+GxSlc2oHiXgb+gAEpOlIM6U266mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt5Pu7g/cHBNi6wldpBk3S+6XSSffMb7qnU8ZeDEIRA=;
 b=G94cixVcWDJvLMW8VxRbKszaHpKeatVFwXP33Ldbio7B3Ld8r0C1o9d5VburJdYtTfbcMv+pftgR5ipUiTvitC0SGjtRmfiRWHg7/kK5KPWd0CF8fR8yt9PPdqnm3kANTe6PbEysZf1GlmDY2kE4u02J5Hyp8UEjx67hIuEUQlKUOLzsbAxXMs1imn/M4Y3P2/tfMxn8kJpj9Rd7YMbMC9k/ek6xqlbNMHmzf0iddz9bR+pvHyZtpR/eo/vi7lH7HpnEjbfVGQpKqVtAfL7R7Ae9upTGTKPJoJL9WCPT9tKtqFE4OM3elp4wPlJXK92Rc4kmLrqe/V56JviFDDgIUA==
Received: from SJ0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:33a::9)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 17:24:30 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::bb) by SJ0PR03CA0004.outlook.office365.com
 (2603:10b6:a03:33a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33 via Frontend
 Transport; Mon, 22 Jan 2024 17:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 17:24:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 09:24:10 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 09:24:10 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 09:24:09 -0800
Date: Mon, 22 Jan 2024 09:24:08 -0800
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
Message-ID: <Za6kuE4KUPuwk7+j@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
 <20240122130152.GP734935@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240122130152.GP734935@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: bda83114-0a4f-45f0-5c90-08dc1b6efe48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SxkrbkbmD5cPncWs3EI/Drh9/CaR4YHQx6TbCFyketlZ2mJFXeFuObLGibZhrqlMEp+g+FaGHeiVn+lBHjm6dlD9rJVTCOdK7FqU5ollwD/DUUETZgpoGXTMxiLsb1s8ZK6gaXEfxrUarYr1NMZ1UXmJKm5jL/9jhWE+HT2lPa4GADC4pBJir5H57Y7HRrkH4ihK7U4MRduDm6ayphe7m4PchxETwiwuCT9JygZb2gc0KVAFvWVg0T3FTy4WDfMNs10GT/DieE2ugKYnd0ImhTXba8YMzuCBxYouLE0vJCA96iynzFkiINaYYYY5b96jLu341RakMC8WPLS1tUJVb2AWiYAF98325+XVadhA+m9hkKTniFZ1WFnSwW5ZkSW4uX1m/l9xHmhLGhIVY+qUjTczc0kOuc3y7sDFSp2/z164SzqvMjYUP97v7XcVm9AgTf8zBTKnkLTA0Qu8Wn6K6bcmL9R3Ro4NspV/+aPKLmUJ2NJ1nPDh9M3T7PgBO1eezx1ucTd6BJz46ASREg/e8FPpq5j7a/CfD4ti4YgrU4TfXC3llGwZMEwPs8SpNgSffr9dIk8R33D/hPX6OC+BOnBoVrGBFZfps0xHsONao6P7nPbLyM+TbKqDKS/i3InuQ2xJYj59n/MFV9sdIzOe1JiOkuxEWvLJJDH5oYqcGVvBK0GiD5/Rnanf9i/MX4s0EoGXyveKF3ABVppU6of3vD7qG7CgVhw0QjvdkGfjjySZ7vnTVWl1c2qIsBSc1T6yWXtOA3uksYvDRMsXn+h870ijTtTkQKiuqOyRlmdAeU/aKcBGXVOADTKLVhA22xuQahc8OKqzhSLjzlJeMtwxX4h5JhWFM6mk9rdd8S8RjIU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(66899024)(86362001)(54906003)(6636002)(316002)(7636003)(70206006)(70586007)(356005)(33716001)(9686003)(41300700001)(4326008)(6862004)(5660300002)(8936002)(8676002)(47076005)(83380400001)(336012)(426003)(82740400003)(2906002)(26005)(36860700001)(40480700001)(40460700003)(55016003)(478600001)(966005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 17:24:30.5025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda83114-0a4f-45f0-5c90-08dc1b6efe48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174

Hi Jason,

Thank you for the ideas!

On Mon, Jan 22, 2024 at 09:01:52AM -0400, Jason Gunthorpe wrote:
> On Sat, Jan 20, 2024 at 11:59:45AM -0800, Nicolin Chen wrote:
> > Hi Robin/Will,
> > 
> > On Tue, Aug 29, 2023 at 02:25:10PM -0700, Robin Murphy wrote:
> > > > Also, what we need is actually an arbitrary number for max_tlbi_ops.
> > > > And I think it could be irrelevant to the page size, i.e. either a
> > > > 4K pgsize or a 64K pgsize could use the same max_tlbi_ops number,
> > > > because what eventually impacts the latency is the number of loops
> > > > of building/issuing commands.
> > > 
> > > Although there is perhaps a counter-argument for selective invalidation,
> > > that if you're using 64K pages to improve TLB hit rates vs. 4K, then you
> > > have more to lose from overinvalidation, so maybe a single threshold
> > > isn't so appropriate for both.
> > > 
> > > Yes, ultimately it all comes down to picking an arbitrary number, but
> > > the challenge is that we want to pick a *good* one, and ideally have
> > > some reasoning behind it. As Will suggested, copying what the mm layer
> > > does gives us an easy line of reasoning, even if it's just in the form
> > > of passing the buck. And that's actually quite attractive, since
> > > otherwise we'd then have to get into the question of what really is the
> > > latency of building and issuing commands, since that clearly depends on
> > > how fast the CPU is, and how fast the SMMU is, and how busy the SMMU is,
> > > and how large the command queue is, and how many other CPUs are also
> > > contending for the command queue... and very quickly it becomes hard to
> > > believe that any simple constant can be good for all possible systems.
> > 
> > So, here we have another request to optimize this number further,
> > though the merged arbitrary number copied from MMU side could fix
> > the soft lockup. The iommu_unmap delay with a 500MB buffer is not
> > quite satisfying on our testing chip, since the threshold now for
> > max_tlbi_ops is at 512MB for 64K pgsize (8192 * 64KB).
> > 
> > As Robin remarked, this could be really a case-by-case situation.
> > So, I wonder if we can rethink of adding a configurable threshold
> > that has a default value at its current setup matching MMU side.
> > 
> > If this is acceptable, what can be the preferable way of having a
> > configuration: a per-SMMU or a per-IOMMU-group sysfs node? I am
> > open for any other option too.
> 
> Maybe it should be more dynamic and you get xx ms to push
> invalidations otherwise it gives up and does invalidate all?
> 
> The busier the system the broader the invalidation?

Yea, I think this could be good one.

> Or do we need to measure at boot time invalidation performance and set
> a threshold that way?

I see. We can run an invalidation at default max_tlbi_ops to
get its delay in msec or usec, and then set as the threshold
"xx ms" in the idea one.

> Also, it seems to me that SVA use cases and, say, DMA API cases are
> somewhat different where we may be willing to wait longer for DMA API.

Hmm, the lockup that my patch fixed was for an SVA case that
doesn't seem to involve DMA API:
https://lore.kernel.org/linux-iommu/20230901203904.4073-1-nicolinc@nvidia.com/

And the other lockup fix for a non-SVA case from Zhang doesn't
seem to involve DMA API either:
https://lore.kernel.org/linux-iommu/e74ea905-d107-4202-97ca-c2c509e7aa1e@huawei.com/

Maybe we can treat DMA API a bit different. But I am not sure
about the justification of leaving it to wait longer. Mind
elaborating?

Thanks
Nicolin

