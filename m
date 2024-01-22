Return-Path: <linux-kernel+bounces-33062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A938363E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413471F27C60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26E33C693;
	Mon, 22 Jan 2024 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J+Q+4xSE"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548773A1A5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928519; cv=fail; b=X9w1kaK1xq1YjPiGIc3+RCrTGXFLlylfxeopipUMhpBo2j0SqpeZVcwpPmSHBP8yuuvo5vR9DKzUXUDNJy52Jzz0IvKH2xlGkR8raWcf4fkWbvBKYKexE378r/ROouLt9CjSu8qD9KPQD2TkCSM9j8vuYc99TCjyt9W2c3/BgL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928519; c=relaxed/simple;
	bh=WZoog5oIEx1V/8etxSAeGE/FG3r42fgIGiS+qxbQaSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JM/1udJOaKGFvochv3xhCSb6Qfad/HlFUpAtfXPHwqzmx5jDk4c09BNwStqS5/zZERUFXmvzpkxCp0lWAhiUajjpdnlGrG5NCHKUqiItNQNkJg37v4fK2qMDsDnIqia0zTit8NisCFCcfoqy280w/0JYAViwvpcQ/vhXxyEN/mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J+Q+4xSE; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu3uPEQsbXgd2azPL51BKTZ6KKoj+bR6e/FMYPrLUZGAXhEJswXJ9eUixOCTCrt/fzxtuWXZcu5ko8R6DsaMKvp4mC7XsXaGo8xzScvl06cYuf8nOejfnH5rR3IxRR83E5xJ2UC22pp+TlqrT2tz05F7JxSsXfO25+VAxLanAKxFanb5TbvTsD30ML5vgem0S7oOhmfqwGEL8p+vYXu/UeQj2a0g7tWTJWFXYOKF0ZXk4HduEvzw18bsYTvNf2eKIAfby2cbiA15daYPBVpDv8G7iWKwJ4iFxcoNg9HpBj9PQya1vDSA/g99Rmjl4g8PPLrHjdubQ8EyV0waFJdgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOpBZvD5bjNAbvcBhTtdcc2sOlJkzNsgspsLOgl4YPU=;
 b=nyTpXRopB3iyMpYTasSKIkDAzUPRxDwLBCDLh+Fq3rlv9mXAfiwERxmIghvvMTGwDNwmBYnylpoAk1jW+6ZC8rK5pBxFb9EijY0qlOBmU3ZkT0VZWOw4i9r6j948OrHOas4Aj+AA5lDekq/oLbN6A6yd6+msXTRNNBKexQ7zWEJCWskQSgX6R3QmueP2TjZGXzknmkwO/JtDkBQPu29GrRpzVd1YJRNStqaAFeM9X0kTtewtevY5AqLuWt2GLTUrMxJ1E62idUy4oCRVX4nsbFJf5svZU9JRnRoi7IgHUpcWIOJ/wdhj3KM4DE7RMmh6X7pFnGOD46sK3HihEFU+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOpBZvD5bjNAbvcBhTtdcc2sOlJkzNsgspsLOgl4YPU=;
 b=J+Q+4xSE7HO3oG+XFlEqcvm+85C3GIRjKD5xUAFV9ZBpqs8crOgspb7rwGfizlqHGMAdUGssVt8VsjhAScy2tAVOl/+SZ9WMF48uRKlAqeV2h8pKR5Pk+M9ID4UiyVkOLLP7VtiC+Ivdr8Yc9gsWM24ftu9I4T3e4WSwXqZxX2E1ipaBgEgO4pMqXDbDOs3UlCqIcrmLikdxxSu53vuB61fDFP4A4cYGea42gCmWWKPNjBbHTFaNiR3EOKCn/xr7h8IGluJ/0N2TtmaazFlOtTn3X2ubF8l0svJBfRVSVoen72YFdl79iqK5g2cgOUStStj0eot4sT9Vw6F0BmDVvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 13:01:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 13:01:54 +0000
Date: Mon, 22 Jan 2024 09:01:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "will@kernel.org" <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	Alistair Popple <apopple@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <20240122130152.GP734935@nvidia.com>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
X-ClientProxiedBy: SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: d160f608-e69d-401f-2aa7-08dc1b4a4ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9BoBn6Pf3hNFk8Vo0r5AynxTpcv+HIKcvfaxVK3El6SVMlCK3F3l5hCPzqP3dJFVoisanATjiD2PfpjHotwFOgxhXCh9oM3nEdPqc/L+eHI6HPYPeRaM7PHLACjkufWfPVoK//OwZvD89Spey0G+xGNQUOd9Nk3r/o4OXHZBGuf3IEKDSxMxVeTnpgze4UI52rXRxrc5LL2goZebON8jtQ7R+P02GN+BslJwECP1IMlUcqmHwBmTkkkd2xqfua98B6kdvbEAk495A5RbwnsbNkfdzIyCEP0C4d6WtH9HJ09KhIX43zH1xzx7nUQGXyziVPVFXYXFxjGnXyG7Gde0F3krQ78vhee3RGzuQZ46GBRS4rsCF0/TulDNOEBVavV9upKrfxmsiC9lGkzcR8uRgCCN+lgET49kM3xfGrwqF92LeiFH4HcNdZR4xvexQfcofrhzNJbGiFNmNekH0Au0Lq+87Wq8OA5ojlXF2JdGsXYqsg0mzzVvY7DK+XZIQEvFXGyN8OTKWILipyAUgQAmFs37i7PrJ250qGIw99Z0ET8dKadxBnVXvzEQJ3Y5CJi35jp7jKgX7AfhO5+Ik0KawFyg8PO0vepgRn01j0reuNVGhcvzOkepJv8bHIONEboa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(26005)(66899024)(1076003)(36756003)(2616005)(6506007)(478600001)(83380400001)(38100700002)(6512007)(86362001)(54906003)(6486002)(66476007)(33656002)(5660300002)(37006003)(66556008)(66946007)(6636002)(316002)(8676002)(2906002)(6862004)(8936002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HdaB3srEul6WXc7T7hzTJKPxJ5iTjXfZ1wDz0gt8JzdAZpmwzhg1maQvDqm2?=
 =?us-ascii?Q?bzgfyuIpsGBfoZBxTM0TKRmgV5JmzkweojQ4bPyb/nQe3JDMTn1WByulShHo?=
 =?us-ascii?Q?0GMSFDwk8CP4CHkNOBW6yDQ/MVoML9ZtwA11vIv7zuvJLWhMH9GCo51ap7et?=
 =?us-ascii?Q?OszQGECGoGg+Bg9ptN0pXwo6f5jK0GeicmX5KK5RMAKH1oGng0iGR0ma4z7O?=
 =?us-ascii?Q?+TVYyh267wpuGB7bgO+pdrQpLD94u7P2jJbCpnbjcssJ8xChovbRANBRVUfD?=
 =?us-ascii?Q?Rx2i6VfUhYB2mUWYRs/A4vouDtMf1bXVP3LbZBjnSRJ+Hk7K1G8J8hMWgip0?=
 =?us-ascii?Q?Q4uuhCsNfpkCLnyVOp71HY3X94sBnbeKd8ULbqEgTcAwKFMK2OO9a0D15403?=
 =?us-ascii?Q?A5Zn1rnlQbPrgK6HZk9mmXoAuIHnBuNdFe3/V10PbdoMUocisOI0uRObkWIv?=
 =?us-ascii?Q?fGI+gG+j162ri1jc6YI5NWDsqp1pQjc6PsdtK2uuvStOv10uAK17baMgJo7/?=
 =?us-ascii?Q?7isfwGHFpr7LeAPm3WaEDjYGMDBG4heOb65wejLgkS+yJKKzKeT5gSh/V/x6?=
 =?us-ascii?Q?KADwfFuaX9zHwR6YnO3s1D4IZj0iG/q/ETEDCx9LoFtuCDv9fjgLs/34307/?=
 =?us-ascii?Q?eYqv424QGikqch9iAonZiA7A4ALJuIYQ64gFGr+99GO+4EXwwaG8yTTWc04u?=
 =?us-ascii?Q?HfbqYP4RzoZXTLtlXchNNZQ1koJN1iaV4XZwSpyzuUITF2FOYqLAwnds/2lE?=
 =?us-ascii?Q?5ImqTVrIgLJT8pD/hjZ1JpJMDrzck11msaZDAw7h+1guKIC8vu2y2e70//B4?=
 =?us-ascii?Q?88RLJuiR8kR1MAa17l1O1sPR9oC/f5UoTx+DDUVwvKU1uWnBv0zyhNwxl76t?=
 =?us-ascii?Q?r8nnLFQQj8hjVE4en/FrsmOf5vrOdhgKWqTP99jWtsWeAz5HR7d5MMyJjY2f?=
 =?us-ascii?Q?qGBKx6MguAbcDROmq+yLo8Vc5EUk89wlEawmxO3aGZThy4isaqUgvA/MEtam?=
 =?us-ascii?Q?0oWL6VN+96BeArKTgm08nBVBN+xXKFKumcfmAkafKPmgQSIw+fUCCKpfJ8oa?=
 =?us-ascii?Q?A4TcosjSdlV23kX2XMrvY0VbFQ1Di//buHekhshF85BKsLun7lTA2uuWlZ+T?=
 =?us-ascii?Q?PiknruP/2mXVW2Q+W1GbDL3Kt5SiFRqkkXUNjY+xDVz+W8akanVXKsM10XiL?=
 =?us-ascii?Q?mokk15sNlqqV8BRN+BT8TjTkmQjzSpkJy+ZRp8sr9IlYQlVaUeOYnH5CaAPY?=
 =?us-ascii?Q?TV8coYU18SPDfH1k4HCz6snWvv955BeDxS4kFOZ1Q/Lqh4cBrv0Id5x89wG5?=
 =?us-ascii?Q?6dOLDTuupThkHtE5R/0k+vK1OSTIX1A9Mjag0209S7Ck89joCiE+TbL3uzf0?=
 =?us-ascii?Q?SnDvHA/0+KXinhRZT4A+qy91zdMwDQIjNAbKYsh+Zr1cZtvjugGZmKRDTK5R?=
 =?us-ascii?Q?eoOW+35/Qqx3yXQ+mU3RTxQ4Bgk04bvBKN6Kgh4FL7f4B6et/oc4qytPWVKl?=
 =?us-ascii?Q?SoKeJ3VR/ePYsN0ahAL0leF2nh7288CnONVLGKunNQDcnxkjgKy87Wr1Ij1f?=
 =?us-ascii?Q?y3PvPn4K4f0fOgTwbs4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d160f608-e69d-401f-2aa7-08dc1b4a4ed2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 13:01:54.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtO0bIfG56TzHwbJSLJ12HL76j6DTRpZ5ijpF9YGqYqMBcJVfJyRzX0pB2xJq40W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508

On Sat, Jan 20, 2024 at 11:59:45AM -0800, Nicolin Chen wrote:
> Hi Robin/Will,
> 
> On Tue, Aug 29, 2023 at 02:25:10PM -0700, Robin Murphy wrote:
> > > Also, what we need is actually an arbitrary number for max_tlbi_ops.
> > > And I think it could be irrelevant to the page size, i.e. either a
> > > 4K pgsize or a 64K pgsize could use the same max_tlbi_ops number,
> > > because what eventually impacts the latency is the number of loops
> > > of building/issuing commands.
> > 
> > Although there is perhaps a counter-argument for selective invalidation,
> > that if you're using 64K pages to improve TLB hit rates vs. 4K, then you
> > have more to lose from overinvalidation, so maybe a single threshold
> > isn't so appropriate for both.
> > 
> > Yes, ultimately it all comes down to picking an arbitrary number, but
> > the challenge is that we want to pick a *good* one, and ideally have
> > some reasoning behind it. As Will suggested, copying what the mm layer
> > does gives us an easy line of reasoning, even if it's just in the form
> > of passing the buck. And that's actually quite attractive, since
> > otherwise we'd then have to get into the question of what really is the
> > latency of building and issuing commands, since that clearly depends on
> > how fast the CPU is, and how fast the SMMU is, and how busy the SMMU is,
> > and how large the command queue is, and how many other CPUs are also
> > contending for the command queue... and very quickly it becomes hard to
> > believe that any simple constant can be good for all possible systems.
> 
> So, here we have another request to optimize this number further,
> though the merged arbitrary number copied from MMU side could fix
> the soft lockup. The iommu_unmap delay with a 500MB buffer is not
> quite satisfying on our testing chip, since the threshold now for
> max_tlbi_ops is at 512MB for 64K pgsize (8192 * 64KB).
> 
> As Robin remarked, this could be really a case-by-case situation.
> So, I wonder if we can rethink of adding a configurable threshold
> that has a default value at its current setup matching MMU side.
> 
> If this is acceptable, what can be the preferable way of having a
> configuration: a per-SMMU or a per-IOMMU-group sysfs node? I am
> open for any other option too.

Maybe it should be more dynamic and you get xx ms to push
invalidations otherwise it gives up and does invalidate all?

The busier the system the broader the invalidation?

Or do we need to measure at boot time invalidation performance and set
a threshold that way?

Also, it seems to me that SVA use cases and, say, DMA API cases are
somewhat different where we may be willing to wait longer for DMA API.

Jason

