Return-Path: <linux-kernel+bounces-164404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D09648B7D47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDBB1F21DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F40E17BB06;
	Tue, 30 Apr 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cQENze4r"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6B17B4F7;
	Tue, 30 Apr 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495059; cv=fail; b=I+EUOGiuyi7vRWQYqVdEZuMMEqmv/EBEVSug2uRzq9rDxBAWfo/q//qiRDZbxa/fHvHool7Wq9OIgc+ktLKA9+AEPD5SzA+/u4UlMi87bVR6mOB7GL8TQgiqTqFiJe/a2TDMQbLrPQ5sE9qp7n6UVuSXKmM89YyTbT0RtrK3Vpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495059; c=relaxed/simple;
	bh=GpE5ZGs8q/eoD/4P9E4r4F11dHzEKetwfr5G1nWWprw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LNPZAe3Gs0zZ3mulPUfUZ2DJIxw3cNOqWtJmq3SUXqOwhwf3SW0aILMjjSwFV4a4cfeuqBtjLS4pHyCgiOTkWSnWYcVdiKaXjeYa0D2ozVHp/9kVOF1xtQ0D9ISQ21sF89+9bXeCjzNiCsxvMcfJ5tI5pTQNHaDPMpdrHCRmf4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cQENze4r; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCDJmOHS5TPbZq7yPOd8ofOAVHGNCew6VoRXt/vxbj0iNVkOF9P1T8Z4EaZ/jU1078p3FUPp1cQoZlIZYrmGueK43R0b5yR8jq7jaPsNhIHpM6a/wg9LxHTA5ol8obK5BQHnh+5yvHz20qiynP6ijmXBRls4Whalei0Ja/mNwnSI4l0tlJmrfejLcw+fjnjWLIeTyAQ8UkYhY7Lf6T9+PG7SDw8ZTQc4QLQAmtxPAlQp1i3nLCv0QiNKE7Lrpp+JP6DK2AwX17DOwcWTqCOn0UwvZ6/VCCPx1QsimIyZXMDKUtFZ57I1in8XWDpAcY4fK2xbp6oC6on34HeAXS1wGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTullI3D7u3q4ZYqrc1gDAuLXDeawXLSSeOit050px8=;
 b=nCmZQx9OdWAJoo+ybHfQTTfFDfKNsOSEqc84srm6mmeB5VFoc7LtgAWMBOalJ9mFvlYSSXTf6c+1XxVHBLUlxBEqeCSLpPtFrKpbuDLO8XFAy+IbzZsi5hn+tCSUd4EuvG9o39KbrZErBMAdX5J7lfSFYT1Y40h56LI9mvcp0K1FzlAQUUc2JpxTTqpyP0NrmicdKboXSljvXmqdGY2Qwj7DJ+LS4yWt47MJIa3WqlYM8zwXE1kVYH/Y5soE9t0HTvjc09q4bHXuov+Y+KXD3RfDIEXPH72XlcjhsUXZDuuzVHMsr1rIuhObLQbaRfVIVPVwlJa77DNxrLj/pwPw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTullI3D7u3q4ZYqrc1gDAuLXDeawXLSSeOit050px8=;
 b=cQENze4r672cFZ6yZujdt6rIkjHUr5M4PA2VYA03g6LUOafAesNr1zuNIXx04tbNTcD3RNWDkgbLjmowNGs7RntQyyMceYKZmLK6WKzXwOlCBfkByGYYBD3v+x+OAp2c4jaEzEBN072iQ428mwaw0RzKpolAjcyYB5yo2n0S4Ja+9IM5Oisa0hQxT3NZA4kG/USS01jkp4BZY9UXSYh0xEe9JgfdahRUeONlyD48ROzg60gLxFf4mcxD5FDonU4yQrsAwueFqsIgSmbMMz37cCjFlvWQOE6tl90rgJ1qO1/yST4Uq/WT15vmnkvKHNbtOsq80U7rMGSWkAedFSjFNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 16:37:34 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 16:37:34 +0000
Date: Tue, 30 Apr 2024 13:37:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 2/6] iommu/arm-smmu-v3: Add CS_NONE quirk
Message-ID: <20240430163733.GT941030@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <81d79f51c69604a38ea4f72c8ac2c573c52e8609.1714451595.git.nicolinc@nvidia.com>
 <20240430142201.GQ941030@nvidia.com>
 <ZjEcs4rY1HpPz4Oa@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjEcs4rY1HpPz4Oa@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:208:160::41) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: e2609e41-91f7-4367-b252-08dc6933d6b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QpMKHY5KoQZcfiZ18AEOotAmjzQZ/XVYs+XdNrxpLhY/GCNfMp+dsRRpaV95?=
 =?us-ascii?Q?85xdPxYkju7wh2b+8mDtjTujszXa75biPPA1G6FWvxyl3odqd6D/di33jNJ2?=
 =?us-ascii?Q?l6PWvUVBUShbyy651j02iNca/YqUH6iNaKI7CugMGaVPf7pn1dkJTUzBo97l?=
 =?us-ascii?Q?qHBHrj3uJy29rPHH6YNR8L/GFaBi+bo6o48W3w2RhxuefVSK0MYIBbfLd46J?=
 =?us-ascii?Q?OWMBc0kZHMVN2SyDrPzZenLLguUJEI8To0uEWNmmXdBjOcUMXuzgbK/h1WnS?=
 =?us-ascii?Q?T3KRdCEEa6TUfN8b03RxJCgPuRcFvG2CkkUpfPPZ+tlILFbRlAcnEqBGNHP5?=
 =?us-ascii?Q?r/zCTI1P+NQ3QhNNwqQGrCwwmipDlAEw1fx2hN1XodMDahYJ9S1oZyXXj9RK?=
 =?us-ascii?Q?wztLm4pK3VRCsrfC8CXKs19G+ijacYklM5u7jPmTb69J0KQsUxMgQ5u7y0j0?=
 =?us-ascii?Q?mOhBQ6RwuEBqNYi7f01fjeXRydf1NAVnJh2p4rPeVavpfbOAR1bOupswqn8V?=
 =?us-ascii?Q?QCion9j4L8NU70dKm8jV11aSJCT1y8KMGtis6anZxyp2eHqjnU9xxJgYFZvO?=
 =?us-ascii?Q?gr73SNz+uU8+XiHiqFxBoPoV+TJWUqGE80p1Ndml+xugDfVLx6PVG45N/GJO?=
 =?us-ascii?Q?CYi5/pGrhAhAAZ64L8vjRWzaXo3SGKU1ERoAcGDx6c8MsssybDY7/F1MziA4?=
 =?us-ascii?Q?B/v8I214F3DSVPjW3DL3v0nhpEwYAFGb11WjdrMDyTK5iHRk1caTxWPaXUVX?=
 =?us-ascii?Q?pBBUkm2tAQW5IC8R2JzyM0VWdh0H9HHDgTD4MRd81fVjC7OJCE7M+7Bahepd?=
 =?us-ascii?Q?L1R3iBfwAD7zTNdg9uIGFq/7yue4HI5OTQeRz88FTUAuPyr29YK6PzJNbFpa?=
 =?us-ascii?Q?9sDKTbWv+7UWk1Kq6PGeogjz13J10uUv64hq1a9sSOUkuoo+kZpt/B/ORNlz?=
 =?us-ascii?Q?xuB4UE/NQL9tGqRl99P+nxADO7g+I+8pBiLQS9sEnjV64qNhndeZqj2SDSBf?=
 =?us-ascii?Q?kIuFcscrRl43oTqxGD/4s2lt+WNFF5F53qoGO2AzpE9M418IA1wErlzzYH2j?=
 =?us-ascii?Q?SLiEDXcwjkZXJbDpp/OFb1VLp69i9rp8wm/aV6rFInFuvHwpxO3kWT4V+ZQM?=
 =?us-ascii?Q?EHHZuizYrFfsRzhmAGb1NskpeCeUdYCOLvo/fCx9OI+wG7T5GysY15UIA0rj?=
 =?us-ascii?Q?ghos0s26pWjSoXHyW8wSFF5v/Oo1Tx+KJ7JCvPQa7IFZIaNf6QLzvU4qwFhZ?=
 =?us-ascii?Q?f95IwqCFpu3IC9tEJPPiGprkFbz5Zuc/rvJk1h9+jA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HJfnBUn7+tI1BcY9gdjsc+561JvaTFOhBIIPBdnhlOGBfVLiQCEugkCS6D6J?=
 =?us-ascii?Q?uR3o893fgqU2ig65klcLweh1H4NQczm0T2HZGarPwONMVUeK5vMAEjNTSW4A?=
 =?us-ascii?Q?Uol9vuwcEhe+75bVh3iUCg0sL5AROvWhNc3ZJH2jPI/52jQ24M9LigNLtr56?=
 =?us-ascii?Q?3swFQrtfaPGvaHCkuGe4zet7uaKxhDNEz1mhFiBSHmdN2UzzshbW+GySrOZm?=
 =?us-ascii?Q?WjcLsTCIVOS/BsoCU83YwuEcV08NTgJo7H0cgXIkEcXuYuImU8od/bH34pwh?=
 =?us-ascii?Q?XpPeydZuQi68o3sVInacVpIcxwp0uh+Sj23G2PAo7jIyPSH0FgrSRt0ZKdXx?=
 =?us-ascii?Q?b2vJiKtQsWBsyH3bQBkP32ebwZoOKY69rYXMPSTQM0fGUefMOpx97Hs2MlYt?=
 =?us-ascii?Q?ROk0RjilADOXNv8aqv7LXD4FGiKuI3jeABKNAjrVfF89SH3h94iQ4PnlxXsi?=
 =?us-ascii?Q?atQwujpbzYaaKO8Y/hU3rjaw6xjRisyNtKpvwac8jh4zeRsrNmRz84sZ/cKh?=
 =?us-ascii?Q?A5WxmvsA4lnWg25Rjhcmxbi08u/Cp/prKjJhY6bvcEL7lfZCSIJo7ZdIAGhl?=
 =?us-ascii?Q?bNsEI+uDn9KKiRu0icrOOHjKeyXcvERZLYAMp+JP0d5OLEe+DfjWq8i5S6CU?=
 =?us-ascii?Q?0isu3sMADeoHLMV/8z1xh9YPMNy1jeEF9Nc2xsSp7wqpgQjpD9PquxCeAs5+?=
 =?us-ascii?Q?nXfQVgDh68LQo9dj7//BWk/iREIi4fyfVvvmbM+vF2mT2/EkA0RkUsq6MKyU?=
 =?us-ascii?Q?+h4ckdXWReGjIbZO4ZI0dEGbuDX1ISMjGrroYM+zg9kGg/uyzgpP2/ZuAi3n?=
 =?us-ascii?Q?pQArVK+yqhJjYHG4HBsCaEni9PBDwye6SqcR3xd2rndh20NXn3N8sHhll3En?=
 =?us-ascii?Q?lYaqcY4hxu+4L/umkJaPP/lNssw1bDL9HizVaEs814NpuWXKtcT4dl9QDmPx?=
 =?us-ascii?Q?jLqhQ6xW5WdWJ81oCpikodgBCiR2zG5t96ZB+tMdSD3R6CYH5sIwEV5n/xaK?=
 =?us-ascii?Q?7Hj6tqc+tKWqaArKFSym5KxAcueL+YRDLlH3vJrwzG4Q98tXNGp5OxpVq35x?=
 =?us-ascii?Q?XO71iJ4oohiFpd8AeBFy6fRC7Ns+nS1jOBYqvSLH1dDUA25nXxJshEbFFLrp?=
 =?us-ascii?Q?uuUl+b2WwS+rY3PyX9ZlSW1ODOYjClWkZHCON714Iz+zLmY5ODiS2cBhDLUK?=
 =?us-ascii?Q?Y0vEfaO1XJ1+zhRx2KAbaBH/KFMRtAO/JmBj3u4k5NTvtU6Fte3jn5NB2dOm?=
 =?us-ascii?Q?BwTqtQb7HhwArKe1MazdiUi8tsJsIee1UcI21Z7HIiMtVtZ/wOS+DMs8DWAV?=
 =?us-ascii?Q?DA9zr5LLFy6OB8eUqlywObf8dALALvMDRxYI3orZBYkz7dWfl2138liAt2SQ?=
 =?us-ascii?Q?Qzl50bPybKsX6VZRZwKouJuxjQWLDYkpeQzjwdRmXPTcemoboRV46D2YaH/g?=
 =?us-ascii?Q?34U40O4ailH2eN1LpVMJUrWkmslx6QPNITC4P9HQNt/Zk8E/NmoPQrdAiIGV?=
 =?us-ascii?Q?/8jP3LwElW1PdBDi73qUnZPGF8d2b3LRvSIuIKzczZF7IokcFcGae7jWb+4S?=
 =?us-ascii?Q?At+RCeVR7V5TZTcpp36L6BdEUgF649fdJfhYp4GB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2609e41-91f7-4367-b252-08dc6933d6b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:37:34.7369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LhipoxOScgs9VyS1e88YPMWLmuC2Ja8c1Ct7LWYb1XJWID+Z+0SWq/HVKuz8X7W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

On Tue, Apr 30, 2024 at 09:30:43AM -0700, Nicolin Chen wrote:
> >  	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
> 
> Here is the only caller for "msi=false". Maybe we could just do:
> +	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, q, cons);
> 
> So, no need of "bool msi"? It would slightly change the behavior
> though, a SYNC for ARM_SMMU_OPT_MSIPOLL should be still a SYNC.

I don't know, I didn't try to figure out what to stick for prod in
that case. It is probably OK to convert an error entry into a MSI
sync if it works out?

Jason

