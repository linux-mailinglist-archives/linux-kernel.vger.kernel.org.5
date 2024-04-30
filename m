Return-Path: <linux-kernel+bounces-164131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F18B7979
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEF71F22C14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68303176FA3;
	Tue, 30 Apr 2024 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ju4OgisT"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1113D28D;
	Tue, 30 Apr 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487055; cv=fail; b=m7d17fOCKoPzA3GjTmejlri+6Ixza1mWA05GxZHLPYaU1d2wiQRt9KxIIgGEfVgyjJdOfhAXb7cq60NxqLPZzYYVhujyRu5D7KyjRhwJtOT67vbcobYn6DZIKaOowFMqJz956cwTOspak5cI4agXDml+XqbuSHj2xhfRVgQuorI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487055; c=relaxed/simple;
	bh=nqFbfCUGHbjD1L31jVCevtYz9Z+SuGThjZSx3uZfuOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g6kT/S9hDzsCdPSiV5ivvHissEAszqMwcxxVd344ozFhNGSF83lQSLs1sX9gcLUspr3mUKB4+qNpNlI4GXJCApCybGSEX24Nv1fNy6KJqA9ejMbWGs9LT4+BLCqKgb7udqlgNmUuhgYshNoGnlxwPpFfM2Q6RY1ZL6MFELEF6gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ju4OgisT; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do9TpCyA5l0Pvdfr0Th7SiwJEbhUqPnozfguG6aH79O9fkbDzXLuUuA5MAvw82TvDwgXi637jxvkOtONTu4Zx3yoH/skmN7gIiGFW2lfrkCGqKFi//lYiSypcofkrPHlKjm1P5wcVECilxaYEBupAMcAfFaePYdaDfg44eYUk9GaQR7yr0be13arfEayuzr1Usgk2IyczG6qib8CPMFmHf7HVqAxG1hzu2Kra6JtcoFcJPIg0tll39UCYZGx8WBsDbjLd4cFbJdFs5CVwdL/j9cM8iYqFBWVXIL0MREGqmcdLPq6SkfI4MrdOO36g373ejXDG215c0VIyP7+L+l32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwMmx7eIf0T/g1faPgBeMBmMMCe1tyr3fvZVEXOVia4=;
 b=M5XF48ZQE85Z9hsOL8tYujX2THBDMYRlINdlBIGuiGQK8/kqDqFFINid/hJuVKyhRo4vYvRHWeN4VCukEboX1RoPvMIHIxjrtjH8pTYEdMqDIE1tsX0hvbVB+frQcn8Hu+YZj/+2yZJy3NRg1rQKe5XcyYSUOgNDdyAu4QtQhl+d8fHI9thiwNDHLoL7NDjCdTeZSd4dCjSN57CG3xIoLed+fGoRHND6ReI6bCHceMYmTAAkUoXcm+1OwsZMepZYCQjIUpM0aKN9jaA4MQcDCCYHlBrkkxl+EtlHT052D90k1tw+5ZSBUsQAofHxor8Ro4n9D4w6bwip8nftLAMrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwMmx7eIf0T/g1faPgBeMBmMMCe1tyr3fvZVEXOVia4=;
 b=Ju4OgisTm6Q4+vKdiw2MBHaq/ZIotAmMVK8rZzXZxSb0nxyJowch1HsqnH3RPrw4DxJcwnnRIXhhuA7ZvhKcjNlR3cpVmsBzEFgtwNxTdZUg/tW3gLEUDvxV4FNopOtFvdEDaxU9VQBJ7N7fWLXG7sPhyp6lUFw3YP2X0UQGG5TVwoFY03xvwicACtznwJ4zpLtbDhXD46G+Jw2ALlef9ALFjm0KxO5Sxnb5Ws/t08H16QzFKzCsU+HDunMc3Z3EDGeO87fMMUrjST1vdByDtGF717jzgLJ/87HSs2IUDlS8eq/MEp1zrqNbA533sjRP+6Sn/B5HQSYvjDm003znfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 14:24:11 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 14:24:11 +0000
Date: Tue, 30 Apr 2024 11:24:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 3/6] iommu/arm-smmu-v3: Make arm_smmu_cmdq_init
 reusable
Message-ID: <20240430142408.GR941030@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <47a2ec844ec42694872d3c3b1a09f1b870712f78.1714451595.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a2ec844ec42694872d3c3b1a09f1b870712f78.1714451595.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b57e2a-a8ce-4b07-1e72-08dc6921341a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/7jYVNRDNXRUMedzyu9hkNF9idfOP90WAFPGwxJRSUvzBQOdGSzVxJcBlDl?=
 =?us-ascii?Q?3skVRHR9J9wT3q822YD5Vjq7ckSvciBqbKCBI5cS9OD1/j6ssFwWAAbTMfOp?=
 =?us-ascii?Q?SKNa5oAYZ67By6sYBS1Capt0SLS+bkRrFEvyA8Ej0qta1/NsGo3UCh/JH2gF?=
 =?us-ascii?Q?2BY9Db64I+7XfQ+FSURBiWYoa8xnY37SWJVeYjcTetG0EwovViNNpFxul8P0?=
 =?us-ascii?Q?Lwh0hoEFNwGLaNfvQucK222lVJpZMieTlhbdpsNPsWPAbAQj0d+DjuUOwR2+?=
 =?us-ascii?Q?QrAT24+Lj2uFNOmHxATJ1yuHEaBx7m+wq3CKT2W6XdB43dMEFXSlj65U4A8E?=
 =?us-ascii?Q?Nv+h+03UBF3b2hKhYF1v7tx/XkY15tU9rSPOm4Yp8K8djdmJItcyxRFZXvr5?=
 =?us-ascii?Q?6tYW3TIsObaDUcrcdOI/8ZKr67GuFfg7wNC0JfP0j59pV0lat+R9KrFn24hk?=
 =?us-ascii?Q?tETNwUID2o3UHTf1H10L9d97csyEeHv73cEGbTgOPx0PWjLvhCCaxQesG61c?=
 =?us-ascii?Q?YkjUAzJtoDSNHucZocCvaM0TrNhQWCu1vscm/6x4QOdlj6w4FDW1vjvhdkrn?=
 =?us-ascii?Q?SwBZ0cDXFAwnyEJszQqlxm3+zE6+AQEgtkSyn7j4DDOsPbvCNXy+tYQ30EHi?=
 =?us-ascii?Q?J5v5Ju+HvTiKNuWfGhuwcCywPhD9JY61yQf15OTh+P88JVUW+j/bw4ZMO+Ns?=
 =?us-ascii?Q?cgnBYNj+zLU7u1gR9QrnWcHcjrsuV5vAY6EybG+ehLeHaOmYMAmF/GJp0wRC?=
 =?us-ascii?Q?EH++ccwBKJXrGewkORk+2N0WjoH105DXlieV/CypzqWDnFoihWDU2fkVgP8c?=
 =?us-ascii?Q?f+VQYuwQo/gUZfMfLP8fr7OQRaVj2mWpC9xq9CSrbcXmH7z/PG7pF0S0aNuW?=
 =?us-ascii?Q?JFbspzVy7T/5vcc/CPnAP0eG/CKTYfTMi77G9QrbKGYWa0rghueZs+zpSZ4j?=
 =?us-ascii?Q?OWqmIwkt1oLuK2DYh7hxfpJZlj7/zT435q/nMvGVDuGBTZSTjo65fxt9fszT?=
 =?us-ascii?Q?U8XfJPayG7q4Oh6CTaCD2CfrZMvB82qPAU+qxXDTYE1InlmTmMXNOydn3JeM?=
 =?us-ascii?Q?xnRUNk1SU0OVUFL75+iVi2kZUP3Ee857j9ZAANmGSdVge6chuPHl3dlwbOGi?=
 =?us-ascii?Q?B6NEncbj3+d0TZPfgIERW2oX8c2ArCjer13fVdcP0vMcdyHNoIbbZtZFxIu0?=
 =?us-ascii?Q?b4kE7aFyMhr2apmr6tdH/54oTlj1XNLttb1YXqRgnDHe6UuaQ4Po2o1Rlk7v?=
 =?us-ascii?Q?Kj/2ciiCdp14Rd4u/ypnPtbcS7CWzMRDARsFJGIGfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/U/FhejZM/e8VW260Yd5rTmxPeNfggGGqHltVx2EwyFXivSpEwt9TRcAi9z0?=
 =?us-ascii?Q?EAS747uEgCQVwTa/w1MqQ4VN2NVTe6nKsXe9cEZB0qrvIkIrx/ZHbQ6n4Zkr?=
 =?us-ascii?Q?MM3Vz/Jr8rf+yeHmlZ/CIHLp5t2o4GiEO/6KPaivZo2/P3bIIALEEOUBOOHN?=
 =?us-ascii?Q?O1ZxyJUp3fib/6T5khX7rMWqVWk9IwTLv8zJexkgr1ImdmYwiXin6grXXNe0?=
 =?us-ascii?Q?lxctHEfe0D11ZfLdAKGtM1jD82SVBVwtBUdx5zXh5WxfggJIJ8emYkO48gPN?=
 =?us-ascii?Q?NAMTKaZsH2X0iXlO7iSJc3kIs9MUTLfiIQ8pVyIe76u0IZ6cLezel4sAUvxu?=
 =?us-ascii?Q?ZPlrtOU1uUaq+iYIDcGyPK+Ea+trnywnUNBRrVqZgjvzqeNiSdVPvEJ9KKRg?=
 =?us-ascii?Q?QxswrFQoShFZDA44Kwoe9MttfEXBdzn9S5JrJ4W1HBa+1oA7chNh83x/ZJJ6?=
 =?us-ascii?Q?qPhlrRMZP3ypvZVUh3nuQqmXhMbMUCN03AUIlit7O3NAssMNd/6g5nohOiLD?=
 =?us-ascii?Q?xq4seOdBLgx1rKMabu8f5AD7JLvX0lleVzHJaNgTwyqhyQ/r91S/azVjjJuq?=
 =?us-ascii?Q?9gmmVpr2OuJqJir7bIwLs/lvMBUiIkL/kxlFQxV/bAFGQclow956IBxw7c+L?=
 =?us-ascii?Q?vRpqwkIalNPkriZ4LyIcPeNj6jVzn0t1Y+Hm/7LW29dYs6JR6nD4Mp15cGRn?=
 =?us-ascii?Q?fpQ3PG8jShZRF0isTMJ5ZGJXmqTtJZK94ZSw+MWSu+Nt/ZkpvUSu3MYVlUdu?=
 =?us-ascii?Q?EUu+NhGA/NNnhAFfmRTF2Bzt4eKjQm+6MPWjrvJUkTqgiDICVwBJGN4Zho83?=
 =?us-ascii?Q?KhCemMhhBOudmMSJxz/o5DXMpZzDvT7BkC6CMOU5dXT24goeZ5oMZeffaySz?=
 =?us-ascii?Q?4FRT4V6WFLpZI09SCZ7oJTGZXrQdyYOAOmguaAS/40MkN+47q76+Z5NGuLnX?=
 =?us-ascii?Q?wdcXBdWAzR1qcvBekj7Jhazu25X0iZ2Gsq2nMsw9cn60wCmprx1d1sa3OF6R?=
 =?us-ascii?Q?MUtDW9TW51OMbzcP3wQuwKV8J0R0HoVg5xdUvuAi/gtyGWblS1RRSAfULZWn?=
 =?us-ascii?Q?+n9xSdE26Xvw55h1fRANo+DkT0PSno3h1EQolUp8gHaJdK7KlqLx4F7ZpuDa?=
 =?us-ascii?Q?MqPG3aQT5qfTYL66xxRnVGA7YlE00MDaf9/uJrfagXA7XqHdu5uFzRxWWqRe?=
 =?us-ascii?Q?+QmCMT1GD6qRPjrJRgWKZ5u84c81zYCDoGESirk3f4AcyUfgIea4jss66ajj?=
 =?us-ascii?Q?W56d4yZE/UOm+s7rsFBIUvUDvAk+1FW75w8SNvTDvA6bMJu/j3n26sm6SDiY?=
 =?us-ascii?Q?y/awqvg7LL6uK0K5m4lDOIimDhhy5JHmc51sMNUiiQ9UVIeoeZY6K8r/Uuk+?=
 =?us-ascii?Q?AWjCD/dF23oH9jb9OIfi8GNf1gNuHuKwn6bTn4CeUhr1EwsZ2tyLkvytRueV?=
 =?us-ascii?Q?j402gcSnxa4j2asxe+SKA5EtJFYdmieM3YKk4QbbS0uW6taWextYATUx7GCg?=
 =?us-ascii?Q?aIbZj8c8p2FWLkmZ+nxFOXnzhf66zhtbJSHWSSj/LIDSn3+9sJJfxy9q7/X6?=
 =?us-ascii?Q?dgjGJ7VaPCj7+UqtQgUqrbegFSbIb5j0wurKM0qT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b57e2a-a8ce-4b07-1e72-08dc6921341a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:24:10.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuEL8XiIL3LtTtq5p14MGqzWdGj4clQFMxPCNtgQO49CcBjqOGiZ7Mza2sJolzDS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

On Mon, Apr 29, 2024 at 09:43:46PM -0700, Nicolin Chen wrote:
> The CMDQV extension in NVIDIA Tegra241 SoC resues the arm_smmu_cmdq
> structure while the queue location isn't same as smmu->cmdq.
> 
> Add a cmdq argument to arm_smmu_cmdq_init() function and shares its
> define in the header for CMDQV driver to use.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +++
>  2 files changed, 6 insertions(+), 3 deletions(-)

I would squash this patch and the next together:

iommu/arm-smm-v3: Make symbols public

The symbols arm_smmu_cmdq_init() and __arm_smmu_cmdq_skip_err() need
to be used by the tegra241-cmdqv.c compilation unit in the next
patch. Remove the static and put prototypes in the header.

But the code is fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

