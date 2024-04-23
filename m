Return-Path: <linux-kernel+bounces-154851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23428AE1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC46DB227C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473A962171;
	Tue, 23 Apr 2024 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uQ1YJ3rX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4060882;
	Tue, 23 Apr 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867806; cv=fail; b=rtQ7AW/WQL2fpXFAdxaX9yn+rqxbPkUQXX5qLOPgqhwwjX6UPFad1ORmfr6IHhAHgVGNGKycuJ3wZqUgOSPrXIR/PrTVTxdF2dvcx8K9TGJA1Mp0xDsGMquB2bY2LOupJY14fPyyAIjFHB4PspSf2EKADOFOd9DIOvE69FKRGOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867806; c=relaxed/simple;
	bh=GaInQ7dYjQIEQafI636jLhu6/OTLRZBb8Rh9phwI0ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i7gADfQVQFDQU3azy6SlkxhjPBNRzoEvJZZ8QUH4NeB1iKdpCkQ0uej4gh2r2ZjjSWU/z4H1eC1eD/nUXWaTpH8YMR8BkTtOBdZjdkFT8NdNQDlD1Jys4A8u/QU8HHzAoPHs3J2ZltqXQiBfQ4dZ7iYD2luIf9VeXmRs2awggac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uQ1YJ3rX; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O31V5D2vBnSWbYldxe3YwWP2geqANnWUfGnmKvYfWF+9FMq0pO9MxIZbI9lonq1eVvE2ZnaG+FB23Uh5F/CXxmISnK1QOlEtwaTBipXPE8Y5PiWltnivRGfVy3/DooFQDdD6NCTRyOkLjD+3edB+T5jwExyiouDGXwCENYQ8RCXvOyHu6wNSl4Ne2Xu+GNUCbpRhfrEngnbIh4IZG41QZSHLuEyHlF98v6rehG9y9dkYkKYsgbbHArBQHydy/tJsoiMsqxN+dew/5naZnF2gOzp4q8isKULWpuepK/l0IcJJ8ZPZlFUNrae8xO5qhSCnP3OS7V0mCnnP1drc0zGjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wO/kKxxQfD4taljZ6lDUpRXUjOXN5gmXMpesAYxb8s=;
 b=IFPfKA4MXPV3fT2Ma8vbjYpUZhrDK5aI9Phc/pg1l0s2IsoqS0KMXGHshvB63lX2flNvJP//PH4o+ITg07uBxTo2xiBp0DdsF+/BMPW3eRiUPCwK4Cyk0CVPpA2PBf7/DjZF+VUKoeghjRE8q8gK9L2FMIAmIGo7c9yXIWRv9wcGgEwadIl4wxqJRvhsXFPM9vz7UzE0xZ82eHGoVLVrg+GFPRpp+2qpiPWTqpc9hnMtaOrgtLR8V5kyTVxWya3++wd//LbodKXvC1QTog8dBPy/hqzvl2YLujwrIF7NNSA3zbJ9kzAUzJciy5mhrvxZg4l8/qHatAubCftRx7tYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wO/kKxxQfD4taljZ6lDUpRXUjOXN5gmXMpesAYxb8s=;
 b=uQ1YJ3rXUxfFNpzZWdmH77SrO6vsTeXktBstDWSSGfqgR2moHkMbiwwVpp0zaa/1rNXMjZbXdNIb596syYf7fcW1tGJSuUvy5m0UnPwUkoEGTCwWvgkmcxYBaRjN6nEpIBCtaN2SRYOVHDxlcmWVlQaF2TuZeg97kEsvb9rQJXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 10:23:22 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 10:23:22 +0000
Date: Tue, 23 Apr 2024 18:22:58 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/8] cpufreq: amd-pstate: Document *_limit_* fields
 in struct amd_cpudata
Message-ID: <ZieMAr//Ofu1ZE0G@amd.com>
References: <cover.1713858800.git.perry.yuan@amd.com>
 <c50374885172571e1c25d95552dec8467c37ea24.1713858800.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c50374885172571e1c25d95552dec8467c37ea24.1713858800.git.perry.yuan@amd.com>
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb79681-59c3-4f5a-47d7-08dc637f6705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wA6ade3xnieVs67YC6i/JoGlEXVx0+eYYku5KCublWrYqxLLGelJDgwfG8c2?=
 =?us-ascii?Q?vKcAXjMB32Rh88rFb6Sa6CJoVxMviZ+HpoEuYcMI7PiKCLQ2b/TPdrm6iJTT?=
 =?us-ascii?Q?QRXAjkAciF0grKrFrdmNGvf5r6LaBgA2bw1JFk41wms01a1CR7nBC2YSu/OS?=
 =?us-ascii?Q?4M2Z2rBGSq423WaSvm6+qrGQwE+yko9yA2D8+Dj8Cmh2L4QLSpz1+gHM1hqc?=
 =?us-ascii?Q?1SRPvZwUfB96CgmHqstTC3pUCM4VNRc1UUBOfeEdwlfMIJCsl5+dSrJK1p2j?=
 =?us-ascii?Q?M1ezc/qikOfUibigbTOsY3MBdMcDoToFMI6fdwuYvEh+R91CeEB2TdaW16d5?=
 =?us-ascii?Q?yusgSgBvJr9uZBGpGvoXaVtgpL9H7Enj8CXDw+eWc4ZhoaynZObHnrNoJO2R?=
 =?us-ascii?Q?oBy9QvuA200JotmXeEzaiqFVKgJVcfenjVihk+quOzDNcAxnMDf0GPiq7uui?=
 =?us-ascii?Q?xVzVOQZSVGKN1x5gJtvnsf5jhdTSFBALolyFpH2qtQyPZ7X8XmW5eEKBvGc6?=
 =?us-ascii?Q?Vb/huH2zY63h77ukWmjIAvWURDlJdSVIR1eCSaQbGCE4FAjWyX4o8kJ8jc1U?=
 =?us-ascii?Q?g0JlJFtLdp1KzELdOx9nhYnQhcs23k0RaNslJuPMG3j7aZHqzMG2wxPc8+1D?=
 =?us-ascii?Q?HA4wMrOI7Wq96z09o087gVabAxSVFBPo1wX2CWrHhrAECiTCAqqLIJTNEriA?=
 =?us-ascii?Q?chXjth8atnNgehpw+PMDAIumUFnwfceWIrsPmPY+l9WoahB1c4PuNDAr4jt3?=
 =?us-ascii?Q?pHehTjpVLFwMYDaYFAApMIFh2fghTvcKjReOaahDY2GlcPslyTm5lkpknN7p?=
 =?us-ascii?Q?DXhQbu5b344vDARz49L5kWjo/8lpRo2kBE6XfKmGMq8FS9i9NtiuhmnCNku5?=
 =?us-ascii?Q?wXBgluerepy8idmP2V9fLCvxn+c2FJK3olReUv+Vs9XlWQVdqOSjr4kyPTeu?=
 =?us-ascii?Q?MWQfNa95MhNMlqpCW9aZZ/59kQFa0b7qLvHgnENcJwMbR1A7or4IHcNxD5Vr?=
 =?us-ascii?Q?7mUGwrTXX/kqfvTX4M7Zyyr2uqpl9e2CEk/7lIouxSnXNUx3tBML+Dwi3AL0?=
 =?us-ascii?Q?ZLHinaMMmP+vMMPxJG7HoCXEoAh7KYUajTlQok4tM3/nhULUNFu8QTosp5os?=
 =?us-ascii?Q?vO7xl5z6jLwCDvUq5y22pCP+GCaipYxFudRliPk3WFIV+bJOuUJVFvN40y9a?=
 =?us-ascii?Q?hwQW+y5H0r0PMzt3AontlI7J8QUXAWKumGRH95j+MoErALZ3lsSmEHw6nMUZ?=
 =?us-ascii?Q?dMCRrgCUr9bHUDGajyzG9CHxfHe2kj8o0HmwxFmkRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K4vRKJ4Gl3UwveKIA1rrmpwJU/JKAJzxP7iefiQQIBKMTd0BPi8iO+SUeq3b?=
 =?us-ascii?Q?kZ5FbzcOoriBokPSkGpoISp8iMps6EsGBpetphKBls7zMnFi8aTxdQ00wCT8?=
 =?us-ascii?Q?PEH2hhLN6aLGomSTLK7kaNrHg6LhNBnQ/r7qM03QmjwMxLG6n5wAxxZh88S5?=
 =?us-ascii?Q?K0xZK73CckYI91svw7GU9ioCrT5T3flQjSdH2npEXd/FQnsvh9IUNeHM+kvs?=
 =?us-ascii?Q?mLV+vx1J0TyuxRmfplEcrJ2ruH/g76ts+YXZ0ojTxqlRuxkQvfjdTMUWSNok?=
 =?us-ascii?Q?xDVBKiA1wrvwk4WaqedFKmc8OlmdfMDNnZMc/oi7YcdPtJ9g3AS+Z4tg+x81?=
 =?us-ascii?Q?RCbcWMReismNO1HUGJJGhFNsVpcTQZha9nu0pqVgb9EY6Bq2Ct/E+dy/GXSf?=
 =?us-ascii?Q?iPzECaBaOWqshnvZvG/2/puiYAEiRJvO7hVyg6vzb8TEVnpEt/77zRVmu+zX?=
 =?us-ascii?Q?VEG+x5CwKQlv72EMEJsElSN+FYoKWh8GD7VXMGBnWHsSCJXK5RkW61VwUakO?=
 =?us-ascii?Q?BO73emd7BUqpcs3+bkZaf2IJcLGapUUCwTVjBAhXBDg49OwuU0eQpGP/DweW?=
 =?us-ascii?Q?qeUZqK32A4CUcHA3dFijFwnNKwaTnDoDI2g47lkPg7i4FB3AxGCl1AJAljnB?=
 =?us-ascii?Q?mxlt16yhQG+gpRxm3YhFE1zRml/486izQ38IePfj/Yj0kkZtxrW8dgILq1dE?=
 =?us-ascii?Q?9m58/lAFPvEcBTN12bWNDlbWDUHBsmVl1L1ES4iABUvtFjxfQlWye/ARHAB+?=
 =?us-ascii?Q?DPsgh/UFxXd7ARSeYTeODqXOOXN9l3bEnhd5Lqop3i49nq3jXfwiqF9JHcDS?=
 =?us-ascii?Q?RkO5QV8L2wWYb/pDeeZ+J/xDxdOm17JHuxTCfonmyOE+C6geaTteoXO0uhfA?=
 =?us-ascii?Q?3zCOmBabZf/GVugkKauG0TjuDTh1ShmgHvtrslOIujk73dyRV0Z/qb6LXbNL?=
 =?us-ascii?Q?Yq2266XBlFFLFLLvkcfm1fd0zWo1Byw6rXeHj8HYZrXKk7ZZbZZP9tmZv3Bl?=
 =?us-ascii?Q?0FAExCh2yCseR9N7cHfnS45QNgozNz2rKlUoE8Cl00CdsqioQ1NOX2kBRmKp?=
 =?us-ascii?Q?2FIEK6rVFbvPdMp/bKYUoHUtTRSrSxTUA8V8DqCLbIf2K+aQ39EL94L00QIW?=
 =?us-ascii?Q?Wvh9lVEftbdH/AX1qQQMHyFZ/JL8TIixqo5nqSZKGYRCrFisWXFVHqaV9HJ7?=
 =?us-ascii?Q?tcUGza6fC4havm4jeXkn8zrqXh8RpTl5dRyqRGRgsF8dKUdhpP//BPI7Q7+5?=
 =?us-ascii?Q?kG4VkAbGDN6GW01K5pMMZotxXd8yfYDwkeGMtkdI9ZVLiQ8cHBnpC7Sc06Kh?=
 =?us-ascii?Q?H5aqRqbt9Fqq+1ZiTrjl0JEhaQX2jogBY57TMd7fwE5A2/MRo6as4Qu13MBi?=
 =?us-ascii?Q?rdtlrPV4nDIZm76GIEFPzYxp49KSFY83qVCTDgIacTSiwAuVq8QEoyytieby?=
 =?us-ascii?Q?EwD4o2//MFSFAC9B+EAbIF8c6nhNjaF8/NYjtqDsle31R9yUmkLckibavA90?=
 =?us-ascii?Q?0MH/nKSqRdctyoo1FBu1b3MHRtvoDEJYBwYTdMTZ8/RT1cl2VAIY/G0FlR63?=
 =?us-ascii?Q?gqCA2hBsunsrrylF4pFhv7mpQ/3XBAiEkuKcFnAU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb79681-59c3-4f5a-47d7-08dc637f6705
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 10:23:22.3198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hg3Swx2MNewCymE5/U4t5UWzaqMX5myPjmBveCJqZMakGQ+pubBJcC8EmjQbbcejQ8KpreRWA2votvjxSu66aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

On Tue, Apr 23, 2024 at 03:58:17PM +0800, Yuan, Perry wrote:
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> 
> The four fields of struct cpudata namely min_limit_perf,
> max_limit_perf, min_limit_freq, max_limit_freq introduced in the
> commit febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
> scaling_max_freq update") are currently undocumented
> 
> Add comments describing these fields
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Fixes: febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update")
> Reviewed-by: Li Meng <li.meng@amd.com>
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  include/linux/amd-pstate.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index d21838835abd..212f377d615b 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -49,6 +49,10 @@ struct amd_aperf_mperf {
>   * @lowest_perf: the absolute lowest performance level of the processor
>   * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
>   * 		  priority.
> + * @min_limit_perf: Cached value of the perf corresponding to policy->min
> + * @max_limit_perf: Cached value of the perf corresponding to policy->max

Perry, you didn't address the comment in the latest version.

https://lore.kernel.org/lkml/ZhyEwE3Hr8Waf620@amd.com/

Thanks,
Ray

> + * @min_limit_freq: Cached value of policy->min
> + * @max_limit_freq: Cached value of policy->max
>   * @max_freq: the frequency that mapped to highest_perf
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf
> -- 
> 2.34.1
> 

