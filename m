Return-Path: <linux-kernel+bounces-33879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB5836FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A131C268D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829C50268;
	Mon, 22 Jan 2024 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CcIX0jSF"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92495B5CF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946227; cv=fail; b=FQXqtFGsC4IVY7Qqpg+b51NLM93sG86KhIn84MqYdudGk6lQjagOtFMl7OBGYAjp7v+1wYoUEytER80sdn9z4XTWjhH1dbfyFx/Bn1fDNTkIyvZS7mpWSTh9E4o0MpNvWonUHW34J3mekJB6+C04i+owFTKhLX5hT5fYjIHE9rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946227; c=relaxed/simple;
	bh=V6F2hdNtqsm/GIfFbzJKpyiDox/DJRuB1F/r/9IfMHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X3uxA59hfxPii44vfxyR0yhxSS35Rb3Hr84CDnGwv9SpA4WmGo+vFMzBmF6frZnMIx7z4AyOPghDC617/4uPwRXS44y61ijbizAY2pDiOGGJ1uQZ7149/NYb3nA+OsbvLfGTEBlDcVVb7GRBOkGD8kU+ASmZ62NfYctMT0kx57g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CcIX0jSF; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDWnrny3xGJK8JmJuWN/AfGtTH50MntpZKilfE/d/qRnEQ+kbIp085P15nGrMG3EW5zbcngxiUM/9s7fKCHYjm+OfrqN6y9x1qGM0DCyGiibUGxs3AmOlZILVl59jMxwoCPpLTrTQZjttqBKoYKwlSn/8Bqs2mwRpTlYwR+sPGfQmXzLcxpbX/TwcXHB6Z2LKQzRz9E0SS1BFjW4OsCPNvduS3q2It3DcaMdMKSvKAosTXEa5hadrfMzTa95L3h2nnZ9RazG6lT4+BnfdG/AnlJxPklWhif2McK/45TAm9kZe5SAAu8cPTz/f/+BT59fpNdiukwfjPd+9NHPGs8noQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gNV6i3XZ8sR4s38Bl74F33Xd1Xz/0sKK3b2Fec+Lr0=;
 b=PLW5D3PtyAl34lFqkfzUKpWeeS8z3cfGch5cT0N3JT5zzkilBmzx8tW3LvCi7ikEP0kJmAu04XLM4k+9ktENT1t3MSeS5OwGWEnbk5TPDa+S5DUrfsLM/c139r9xzU+jL2+wo5wuPXnLV4bPsGH8ihjVEq46KQqhSAfASUzNZRpWbOZIlA9uGLFE99p9t25pDZlZRWzMGi//YVcPIMJdxB8+fomTuYKFZSoiE3drrH3ZprHdbJjp4wuJr0zHwzmR2gzutKM5IC9dbrSVZ1/3PnVUbeHe5v2id2ptJWOXAWrFdjU6OHsJZ6MoGZPBHo4HatQPVzFJE8JdNH6gtdMWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gNV6i3XZ8sR4s38Bl74F33Xd1Xz/0sKK3b2Fec+Lr0=;
 b=CcIX0jSFJO5tv02LI5cwK6QDurUj2cbmBdb7OLclcAOkUGPcKL4KoSePzb8ncQyw/zMs4GKmch5gU3CHpj2WlwT4fSnYvxwc3eCr1nprGIW2WxQ4aIujf0cc+FaazS/qzyIy57M4fSAP6628Ik28PoO2AZtSHTc7ES+aBU/viXgASVANYBVjZvPkjWb49/q+V/Ezjva+FRcD8S0y2HA8ecauKDObSq+mnNZZHeQypYcVaJbr85FGrufpcvQjyEnakiwwEh9lLE8BgDJOFDs6N9zS6J2YFqDmVeatiG26FSiQWbVXvueOxOgdaPN4y41ru/BYRxXIEjZP205T9c0LHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.31; Mon, 22 Jan
 2024 17:57:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 17:57:02 +0000
Date: Mon, 22 Jan 2024 13:57:00 -0400
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
Message-ID: <20240122175700.GB1455070@nvidia.com>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
 <20240122130152.GP734935@nvidia.com>
 <Za6kuE4KUPuwk7+j@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za6kuE4KUPuwk7+j@Asurada-Nvidia>
X-ClientProxiedBy: DM5PR07CA0115.namprd07.prod.outlook.com
 (2603:10b6:4:ae::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a767ad6-7c3f-492c-b9f6-08dc1b7389b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FAqLoYchVAGzqI5b7pAtsTNFzk/p/JFFTLGNCsBDO1TiHRS/EiKLnhEddz/BTgtUsCLBYr8FzeGcMidIgbZUpMjTsNbKL5i0jzO6LKGTwSRbOIyv02XsjGc1ay6VVuWJlEoJjE5eyg7K/EZmlWaRYBZjhQMNMheKmlh/9eVf1IKqp2naxHarPc6i/IWNp8U3gm4vD1XRxbVGhvFgqPoXoIpzZZoFDZpsgqoHjQdjwcgaJh8mkGT6TxdeaU4bTf4vAxPdAj3uEXOj8VVIUVLntYyo1kIldXtFTxTDHHyZ+gzS4Wa8m3FnziC8iCDysCfeVLeaFOSpooEmmrMUnu7nqWlktaCgXxyhuDlS4lF0+PV6ljw/AgO2xHT2wlsjjOa7BOvbpqBk+7Lpadl+P8jqvib+mR2QpCuytVR8PfhShVAkkzwH2X78ldgqJGcMvJHqW1UoGGiL3SGlnlDH0BM+rITk/1KJHkXbo/XODWIqC9TzIUBsIbtMB1jm1ru/xTN9ec7WfbkYlJTD9veVZa8aDUL0aTgrQq37vsro5PZw1wmB+3z3yekirPfKDwIlsR+ApfbY6E6oL+vusNx55/XbIqtqyOOTamWCfzAlKirJfYeJUm36jwV6A41SeKtHKhLJRTtxMjjs532sT2X7I8TOUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66899024)(83380400001)(86362001)(33656002)(36756003)(4326008)(8936002)(8676002)(38100700002)(6862004)(26005)(2616005)(66556008)(6486002)(66946007)(966005)(6636002)(66476007)(5660300002)(37006003)(1076003)(478600001)(6512007)(316002)(2906002)(54906003)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LdVAc6CCL2dDI3fKOVSLYvm5k9a7FdahbZS3AgMeZY2upPn6tC39tIGYAS+j?=
 =?us-ascii?Q?qAMWmmpE8c1gJc/FJvDDj1MgDUUNi+sAR4st8dY2tynkRrGiDt/PJ8lND3uK?=
 =?us-ascii?Q?ciphfCgPJ0OKfYnz7gaP9leoPkntZWzga04OmxnYvw1cHuc1vpfj5C8uOXf5?=
 =?us-ascii?Q?qxbfgRcpZN84DCLydFmCCRIJLExQUF7KGTAzkKoWwjZIXO3+XQm6ovcB3RKv?=
 =?us-ascii?Q?x+bgPGUYFztZ9YOwqOU2TnWeEKkzZ1p64gEwQo6UyxbYljRZ2Bx14ETQOJHP?=
 =?us-ascii?Q?nKWgNB2/wjXc5Fv0bKQ1ub5qbDb8nKLem51uArmCBP/QsBA8rSJiAYBvVofc?=
 =?us-ascii?Q?8Zh9cCn7xDPpN42E1aJK1tQf7jDETcifDEHFdW0L9D5wpmA6EjUB8pZB53Zk?=
 =?us-ascii?Q?bt5TBGnMOw35T2HCgHozQS7pGhWemu8j3uS+jdiGECSxBkBn04hm9dUTlObD?=
 =?us-ascii?Q?DlKhyPL7sRmWU3sMDfZmhH0TlttlcbrT/UO9FPXvIJq1fuxbv8ql0MGzQTUg?=
 =?us-ascii?Q?NdhM5xJRmMd9c+OJIqRMApVM1PHvE+vh0f3IQeAbXldTBAHs9aVh72Ar+Qmo?=
 =?us-ascii?Q?aWY3hsYiy5hec6FfSpWEcqWlMfDbborzCCm5HC15beE1v1f30Y8J9nNf3r46?=
 =?us-ascii?Q?GrCjcBeOosO8Z6EPEim9fGIlk1/QoSmPQyLvVySfQqMk7tc5/NwTweCWwpK7?=
 =?us-ascii?Q?hy1B8d89KltJ4R3V+7tiZPn6jKwlhC0CnE4DQX/3rI7J+ZrY/DlA1wKT4BCw?=
 =?us-ascii?Q?pQqfmU3dI+heTgIEvHXrnmSVxlUVyqxqZLPLEgtp7ESbr5cxxXK3LiZAT04j?=
 =?us-ascii?Q?ri/zkjSfFoS0OMI8IDm28mJOJnU9Vi+jm2/NHKuaAKxvhYk1FurqNz4wPI4Y?=
 =?us-ascii?Q?w3ABn7Z7vEpa/YA6HNOjZN+Writlqvr3Z6ejLqYo62pT7WTfnKxKatdUlKLc?=
 =?us-ascii?Q?mByoXM//XR/Y3z8H3xYE8b40YlU9ijvr3EbC9rO3q2Od41BtlXMquPsqxFFD?=
 =?us-ascii?Q?OJOLSJTUBBmSVgku4fuPfEDJgoYF2zpimxriw2/PYzSBcnlJJuEirGl3NS3E?=
 =?us-ascii?Q?d/A0Ci1CV1LScQAmVnwT9xtOjZRmH0DDdbGCRYaMCKEE4S/ANb32SbQNhMay?=
 =?us-ascii?Q?DLYJo3v6GNJuUsG7UHC3hetq2WvDwWdw/EzJjkeEnKL90Cca6Ch6TJ+AgygU?=
 =?us-ascii?Q?rUv8rETu1riWJztauPFaxy4AJNeXLI4rft9kB6OmFTjSuLBQDbLkNeh36XAl?=
 =?us-ascii?Q?PBmtZMEfpA3CSio108cZngpyPQC68G0t0wmDJvlE7sBLT0CrfrES0IiVIW7p?=
 =?us-ascii?Q?m49kmqNcnDAxBNfarjRtWKBTq7QO9ROxYKp+hsjuScm22/5nh53oEAWKcWBg?=
 =?us-ascii?Q?vQDKOVeWdRl5iAhEIT/OD1NomT2ulyFjfxBg/SGzMiuLaYshqGPmgdN4UvK/?=
 =?us-ascii?Q?evjFUB4KSlsEKzQXuM94NUv/mm+RhGd06v8qX8mVAxG9aLl/NFsk1KM0aRoJ?=
 =?us-ascii?Q?x74Hu/EcRJa6/QjDsSu/4FPIJZSjmQQUhuq74N6tItQnvgwByvMlm4w62ntZ?=
 =?us-ascii?Q?TO8dq32sTD541mSm+mnV3Vcoic1rkReOjvJbGGLx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a767ad6-7c3f-492c-b9f6-08dc1b7389b5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 17:57:02.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/UNgAaYmS/jHeT+NyjlA7/0i2cl8dz2lgSDz4yJP4b4gPtEWd4awTLPwHpdsFhk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025

On Mon, Jan 22, 2024 at 09:24:08AM -0800, Nicolin Chen wrote:
> > Or do we need to measure at boot time invalidation performance and set
> > a threshold that way?
> 
> I see. We can run an invalidation at default max_tlbi_ops to
> get its delay in msec or usec, and then set as the threshold
> "xx ms" in the idea one.
> 
> > Also, it seems to me that SVA use cases and, say, DMA API cases are
> > somewhat different where we may be willing to wait longer for DMA API.
> 
> Hmm, the lockup that my patch fixed was for an SVA case that
> doesn't seem to involve DMA API:
> https://lore.kernel.org/linux-iommu/20230901203904.4073-1-nicolinc@nvidia.com/
> 
> And the other lockup fix for a non-SVA case from Zhang doesn't
> seem to involve DMA API either:
> https://lore.kernel.org/linux-iommu/e74ea905-d107-4202-97ca-c2c509e7aa1e@huawei.com/
> 
> Maybe we can treat DMA API a bit different. But I am not sure
> about the justification of leaving it to wait longer. Mind
> elaborating?

Well, there are two issues.. The first is the soft lockup, that should
just be reliably prevented. The timer, for instance, is a reasonable
stab at making that universally safe.

Then there is the issue of just raw invalidation performance, where
SVA particularly is linked to the mm and the longer invalidation takes
the slower the apps will be. We don't have any idea where future DMA
might hit the cache, so it is hard to know if all invalidation is not
the right thing..

DMA api is often lazy and the active DMA is a bit more predictable, so
perhaps there is more merit in spending more time to narrow the
invalidation.

The other case was vfio unmap for VM tear down, which ideally would
use whole ASID invalidation.

If your issue is softlockup, not performance, then that should be
prevented strongly. Broadly speaking if SVA is pushing too high an
invalidation workload then we need to agressively trim it, and do so
dynamically. Certainly we should not have a tunable that has to be set
right to avoid soft lockup.

A tunable to improve performance, perhaps, but not to achieve basic
correctness.

Maybe it is really just a simple thing - compute how many invalidation
commands are needed, if they don't all fit in the current queue space,
then do an invalidate all instead?

Jason

