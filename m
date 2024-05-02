Return-Path: <linux-kernel+bounces-166719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE88B9E87
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C1B1F24E55
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512C160796;
	Thu,  2 May 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HiGirDSk"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFCF15E5B9
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667139; cv=fail; b=LtZZoTKgiBaesGKb4F3hfm0qAlgZ4w9rxdxy49MPAxVQCsQkmBNKkL7q4Engiqd8wJa8EDKnbCOhO/N2cHDJReI7qZpb6Z9Bfc3yuvBIAAc0mI2zvi+Jj6i4f4Yb68TG4xUdx+Uz4B/KoizLaHzuWkcjXaJJZGFOGZRENYjoLI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667139; c=relaxed/simple;
	bh=PTALQRY99OMNS+vcCrXTbZ9NmM6HueLhuAm/ywncXLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SlVA3a+7A/xwfPyLGwb9JC4gh3EBEN/M5mGgHCDRFI1qo34aCfKqe193rT+fCo/mQQEnN+OYTdPevzLmAP++lP6VJKKkBy9Jji0twiO7Ja35/EPz1xHjVgPh0O2mi0v0Px6zRT+7GQjm+Qi8C2FuXVeC31rE+A3DUaNo8Vx/Wc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HiGirDSk; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD/VWlT5p63ke17HsgKKn6i8t540S9idiW/t3oA/Oa2D7HtJzPwJq76FTRe1m9vetfTF4sWribdgajQ3sx69dCUMJ2eZhF9MDOzjH69lKcelh8IzDK3VOycnwBYwXlSzaER1OGYR3Nx6sXYwJrZgFWdV6zpBCJwvjjC+XabYgyZUNBz7CcXeLsw0wlROs+KujlowdOUseVNut1Yoj0QnoGKcfu/t7m7pa592jbIyyZk33fLCHGF1rI2fmr71Y7bwxt9f4g6VhxHKwJjZcNNb1wLaS1RM+1P9Dk8qj6fz4+ZHL9gmBn/KWhHzct6b1UYbRuf3qa5tL8Hsrs6GygMPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmNbJufrwkgirVbLBjf1Mj5gxvEFeUgfPMh+QYO8NLI=;
 b=gsB4QyVl/CH3z5DN3QLqF7gNOtXkXGWip2Uds5oJp/MT08cNmikFVzPGfc15j6O9GPW4qOY+E9YTPn4Pv50tU44m1NAEEjPz8U6bJGXKeQAj0O1eN6La8MYlLjks+iXI7ut4F9vq1S1D4zaKXrk6MYQu+U1dtHmCtpmB5MHMNIM0HzBTT9rwApUrNUqKeOx2EM88bfd4bhYlewCpygW26wW/xglfUBCEmXRSPfyR7OYH6E+mSrtevsahpHZ1L/97aWw3qgAXX5AFD3dCZywgH6T41TRNdrLmNWZcXjMrj9UDv2NWNZGsT46vnPJbnyPQSkYFyZ7maJGsRiMhb0qAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmNbJufrwkgirVbLBjf1Mj5gxvEFeUgfPMh+QYO8NLI=;
 b=HiGirDSkKHZAroXk96dvwbzqhZLsBRSy6LKORTppw2a3xwHE7Xddc0sDnpQNXkFA/r11SBrpCdPWio0IPg7WinnxtA7oe+9KIM2VvTpMuLq0wEulLd3ZQCye7io02mnqAOqcZzzDQI6z+3Wm0HlA55zMR6GIgkeInwfR86Hinb7XQvugNMeJBLas17cf2QQmfpQxg1dZOclqF7s5Qx7iU0iNIrY/bZVkSTypqITChF/FMSR8nA8ZQbVaqHUr7hOJosPSOCeVo6ZOsGk6r/j1DxNYdTfX2SdD9BwPkx35++HioWRaRBXz0oD3cisejpF/Dp6VL2mSw+7d2+sC5dRzfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 16:25:33 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 16:25:33 +0000
Date: Thu, 2 May 2024 13:25:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tanmay Jagdale <tanmay@marvell.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, mshavit@google.com, baolu.lu@linux.intel.com,
	thunder.leizhen@huawei.com, set_pte_at@outlook.com,
	smostafa@google.com, sgoutham@marvell.com, gcherian@marvell.com,
	jcm@jonmasters.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
Message-ID: <20240502162530.GA578685@nvidia.com>
References: <20240425144152.52352-1-tanmay@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425144152.52352-1-tanmay@marvell.com>
X-ClientProxiedBy: SN6PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:805:f2::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8711b39a-718c-43e0-1ff0-08dc6ac47d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ISCwDyGA9lisdYsqZG8mHtCzlQmbOfTiy1JrY12dNF5O3TcIRlzGOTBngemU?=
 =?us-ascii?Q?jSiq11qBcGjVCLc5nfr4d0HQ0CRFl7mROeScBT8SA7gS3blG8akXFOywFVUL?=
 =?us-ascii?Q?6TLO+m9RQloaCz6DQ1geusB0QwnbYmtvT5VV6R2qnHhRnluTgaLDaxkOMBFd?=
 =?us-ascii?Q?XlBZw3w5rI+B/QFadwyZBFEn9CC3IsKhWtzLGqbZTQHMYBElNkOz9GGRyO2V?=
 =?us-ascii?Q?P2gsnDzYdWTxy6mR7yr2mzZhAU0A7mr+kiQDfhL9lkYDw/9GJ+ES1TfEZFDb?=
 =?us-ascii?Q?/Wc/crBgTjVFe4Jjgin3browT3A3AP+vgvdknABrb1fe+1T0zuIN5jIGCgYo?=
 =?us-ascii?Q?6UlbHfoMtyjvOkoG7FwFmPWI21hQxDsuoVdlwi7tNUkFPSc21DbI355803Zt?=
 =?us-ascii?Q?vwVWTN1dmbEf6fbHviAj7NJvwc0BXlL0TiV/ZO9s2LrTcfLETAuABpMXfjZ+?=
 =?us-ascii?Q?PkyEV4RUNvhVnxsG3WAxxswNelbSVmmrp3+cDNtzHaQxojhiUbZgfZ9l9nmq?=
 =?us-ascii?Q?RZFz7SDQyuPUhLE7xxP6fpMumBqGhRVnOHAktSY/rcC7eo4U/qzVtGseQLq2?=
 =?us-ascii?Q?9e5IpQ36EqmCIxvjpBRYlDYk8dNCP11a7883vnD5xV6SOFIJLsZNpRnfUEYt?=
 =?us-ascii?Q?5z7rTjUtC79MYSOhMKJXLPdQyaliedZcGoBchUEv5aDVtivwFAgiOVUGa1eD?=
 =?us-ascii?Q?ugq/gvqb3xgTANc26bC8X/yqkgeo75+dFSAdI+vhwTEzJUqxrUe13JWEiugZ?=
 =?us-ascii?Q?T93oypdtMv4wEb9upIzPNP4pTw+9AImyuFBM/CZN8tj//veB4AfuIVTnHFlW?=
 =?us-ascii?Q?7IKKLV5FOufQfKZhpQJT3ekpiQ7/H+8SYG6iembJy4njg3pKLtvPXczY5Jf/?=
 =?us-ascii?Q?TDU63WMmFAOPLV91SxhmxSZuzI1kc779AHcJZZUZcfJ4Y2v6UGRwrt2iT5UY?=
 =?us-ascii?Q?26NT1eONPIgvBWZcMwFzB8zbCaciMSz30yxD5f++6Z3JVQ61GSH1YK3qsc9T?=
 =?us-ascii?Q?87OucrASmUSQ64O8RhH+DbadD0StN5GDNfP+b0EqRfFGCANEtwtxkWWdY8gR?=
 =?us-ascii?Q?dTwyqD4M9J51B4p4t5yeU3r8DEFN9kixpsNekC/7WU7EESiyP1QZllvz8PI7?=
 =?us-ascii?Q?steuIoN3iJKJyL3zBjTMgba2YYHNpQHpyYB8ZuUD6GKchuLuC9D2/jsPj7Md?=
 =?us-ascii?Q?RKOsw58o/HZCl8T/KZR13BEDUW9k5oxFv2+72N+SjejJHa45EACg4Mp+NLR+?=
 =?us-ascii?Q?QOc8ViqOR46K4no2zZnq4un+JsZHwk2I+tZ7ag5AdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AyQrBS7SMQIM72zGjcitWFNVFLpBcMSWTbcESVIcFUxi17yNdTr1NbgbCbIE?=
 =?us-ascii?Q?kjXb0DFFcp2TozpU4nQWiUOAx6GwG7Bgm8FmYp6i8SzHmXeKj5aVJF9xF7vf?=
 =?us-ascii?Q?jmI78W59EeXHbDlFLxrok2D3/S8guMfj3EZE5Ff7pzI2RsK8zj3+uWJT+5+u?=
 =?us-ascii?Q?hKJBm7sEYlamdsbtaKlQZ4uIlwwVEd9y14rcSq8n5uz8JmveBWvP40ql3V9u?=
 =?us-ascii?Q?Jhm1isHbc7e0TXymIydu/XcJB5sCc1h7Bkg2BCxjTFRBS439Tt0MjqR7ewGo?=
 =?us-ascii?Q?5se1FvEVtuUiauXd9NmEaWcwwrjgQKVKm/C8LidW2MALZQgta4JHcZtkTTDw?=
 =?us-ascii?Q?paD9D2YtwoHIFcIbx/Ef5RdxzB0yKS/WNiWxldUFTjeLTmkDbECDChuToyvU?=
 =?us-ascii?Q?15+T65uvxApvVO3b8vq7gNIkMLxhnYzcOYLNdHImFMFR4eamVJWHL4WUa8o1?=
 =?us-ascii?Q?IlwBR1hAFXaoIgZSCN227CXNW+kfjGh4j8QaThaUjtRQQwhMtQTJlLMsY9hm?=
 =?us-ascii?Q?MSGmvqgp2DWT4QS/rODsqi1+/wY8yMTx9OQyVXWwIzPnyDF/NpGBNxCG7MdL?=
 =?us-ascii?Q?QbtbJ6duKF5L/ZcvLJnpXvmdmps0Afkjh26xoO4wMu8N5qQHYwQD+JzVK+xu?=
 =?us-ascii?Q?R93S0GnkWR2ATYPqcCDdYQJbrYibXpF+ZIv5pn2gnCGNqMPbeKI6lhfumeH0?=
 =?us-ascii?Q?9LonUv06RLDY91NTgGMmV+tY15R6Zq0l3YN9oVB/eel7tnHpqdbWu/HhNh6d?=
 =?us-ascii?Q?gp5BlXHdOjPDrIGuwny/0IdhMEG+lely1jWuBYmip/OfOvXKnqk/d4Arphat?=
 =?us-ascii?Q?hC+LDZE99TagMbDStLPZ97KdC2Ck3z7hNSeHvzwOK6mGQKifcFDTZWVSPlUh?=
 =?us-ascii?Q?hNzpDvum7oJoQp9wzUUHYezzh1xpjwOLcXj4Dpt27udjrtE+dfh+mYHeDYTR?=
 =?us-ascii?Q?mJgn12gKWHQ8koNH11zHWlJZqDD+FxnXlzs6ps+nsGnpC0CMXqOqRWzxOAP7?=
 =?us-ascii?Q?KqVm2wZMgmO1NvXN/OQMPMB9GZoDcM++OoPl4M193tYHhk6ltZRrBeJNr6/I?=
 =?us-ascii?Q?du1O223ULI2W9m7taTwy0FgUUQG46JEqN7LNeZVOvnWD8uGJWVgcwTv3rfvx?=
 =?us-ascii?Q?92pLSjuIPxCXjeCO601ULDZ+4c3ETyrupmOc9DCCKTkVeWzbv1mr8Wj28z6T?=
 =?us-ascii?Q?npbZfM3RnQhPm0SomjT/skAd0zRwF1eknLZSawdRqS9JsXsGdzDU18FPWvNb?=
 =?us-ascii?Q?I7Q6Iem+tVXabzlJdc6XL8Vr53sxttlGj5MohrzIFhimDLC7TiEclBAyR5PY?=
 =?us-ascii?Q?Qf/VkCNoSEmHbi7fGsJ9yObU8WzKAWP3iriKwrBlphr54emDyiNhss18l38x?=
 =?us-ascii?Q?d74NFac30lniycbKVVwnWqSLcBJUe6e+0K+kCIc/uIuhRz8j8NwdM365NwJw?=
 =?us-ascii?Q?VQGUTXL9tFzeOpd/tekhehDhDpihH2xOUjb9mfh5SuvTy+/kLkRp2vcm1RfJ?=
 =?us-ascii?Q?e7kvKzep0u1IERhHq+SzP26luZ8GFiiLLKwFd0DWGIkCAoH67IpN+zGd5vDU?=
 =?us-ascii?Q?71xtx5Y7LRRwsliq4gCSJ4FLOWd5YFvVsh6Qc+RW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8711b39a-718c-43e0-1ff0-08dc6ac47d78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:25:33.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppycXuNTRLElPdLkUFfioFXyEvcPLpUP/BxgtlWlg0Tvmqldzz6zo6D2brzPNaLz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128

On Thu, Apr 25, 2024 at 07:41:50AM -0700, Tanmay Jagdale wrote:
> Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
> support for SMMU ECMDQ feature.
> 
> Tested this feature on a Marvell SoC by implementing a smmu-test driver.
> This test driver spawns a thread per CPU and each thread keeps sending
> map, table-walk and unmap requests for a fixed duration.

So this is not just measuring invalidation performance but basically
the DMA API performance to do map/unmap operations? What is "batch
size" ?

Does this HW support the range invalidation? How many invalidation
commands does earch test cycle generate?

>                    Total Requests  Average Requests  Difference
>                                       Per CPU         wrt ECMDQ
> -----------------------------------------------------------------
> ECMDQ                 239286381       2991079
> CMDQ Batch Size 1     228232187       2852902         -4.62%
> CMDQ Batch Size 32    233465784       2918322         -2.43%
> CMDQ Batch Size 64    231679588       2895994         -3.18%
> CMDQ Batch Size 128   233189030       2914862         -2.55%
> CMDQ Batch Size 256   230965773       2887072         -3.48%

If this is really 5% for a typical DMA API map/unmap cycle then that
seems interesting to me.

If it is 5% for just the invalidation command then it is harder to
say.

I'd suggest to present your results in terms of latency to do a dma
API map/unmap cycle, and to show how the results scale as you add more
threads. Does even 2 threads start to show a 4-5% gain?

Also, I'm wondering how ATS would interact, I think we have a
head-of-line blocking issue with ATS.. Allowing ATS to progress
concurrently with unrelated parallel invalidations may also be
interesting, esepcially for multi-SVA workloads.

Jason

