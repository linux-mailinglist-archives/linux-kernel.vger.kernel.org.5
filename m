Return-Path: <linux-kernel+bounces-103097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7570087BAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541FBB2326C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E8D6D1BC;
	Thu, 14 Mar 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E0Olffkc"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0A6D1AD;
	Thu, 14 Mar 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410839; cv=fail; b=YU5NSapz8hoSXKM1s0GLW6UoP0S4CxlHDwvKJxyCkO1AoPBFsfSBxjATP+GKkCw1O30is9Gs8b57UV6NZd0GXitFRHNYJ2k0d62pBO8YI59k5DzfVhk8qulBvOhHjFdhkRmHZuP7Jn8AFmdRazt+in+i7zKzF0DLvl4aB6Z7G2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410839; c=relaxed/simple;
	bh=Tx9sVs2XxKxXlisZ74JMjdFrfCeTDSk061OvGrPPQM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drpO1AC/SpQA4ruHycj28JGHwHi69E+c1GZigSt1zkqEI9z/qpIJNtK8snVFZkL0eTvCrAItYx6M/Rkb79p+mJCfdnj1rTqaF8AuBa9/FFhOk4xaEfbo7eX0uHfVrXcXZjF33/T2WLeUgSJ5iX+/gMmZqN7iUol+xNvhw1XLM7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E0Olffkc; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2vlvZG4rUZ6o/CeyU+AsfxvCLKZrp7QZXCePTm1527H+3XY5X25Np0U+Fs8NGHvqUDEldmHMg8Mum4vg9mP0GE7ZYSThziEoQbAFW6/2/ksqTt7t1Q2UxWoBmvgf7hNVlFGOI2yghJUguZFImlJh2M479BMpl5e2HY7TsUTNnUsm1lnxxABernQWfMfVRebzyqW6mLcNGT1vt2K+myltbpGPyGlMV/qFOOj40aeTyahWISu5wGUa3+IUYE3brbNyEXTp/sBKE1R1EdlLwKBeYj6H2x1pTPOCQYiQALgrSHdmeiWmV7l7KYtbH9jBhPfCSg61Oz8HugMDYacH9RALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/yNxR3daOUOikl2b4O0Gtb00uTwvaRGy1cRZ2aDTZE=;
 b=R/AchBn1bv/fzjmNaPafbcqDm5sjSkuCaRYhqcccrTH4bRVYv1NEoOn/3qqNt0G1c0QQMt9ZXEYkZfHvMnBJY3U1jyJcDItmc9JGPF9sZtj63WCuGRPvhOeEtyE69qUjednT+N/YmxD3J2h3QthvFMQSikzaMZK8JkFwTVr2t5jD5Z/Ew1Fc5s70oiX7OcYOIeh4DF7xOs07LPgFMERUWJKP1cMCztOCw5dBPrAmjCgb6g2jW7ECab2DGNa9BEI7KodAnVk+9/LQjmBrBPVEN5/RcCP77c11WaqExCHFqYbLIi+Kv6aTAgOlc3ZkQ+Cf4g8Q5WzCWX15qpFdXwv2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/yNxR3daOUOikl2b4O0Gtb00uTwvaRGy1cRZ2aDTZE=;
 b=E0Olffkc7zpyNdGiJ4zEeITouOyDrsENteVeGJLzAbImmEiBv6cWGRaeLIpN4BJwJ+bGyCN2ZYaDrhwmUk34YSgVE6gTehXLWCkguBPAvNFr7N6/Z1DdBDJG8z1zg51xO/TKwCXjmj7Dx5qa5IdEv8/vhcoTEEzzoaon3HJpzYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.20; Thu, 14 Mar 2024 10:07:12 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 10:07:12 +0000
Date: Thu, 14 Mar 2024 15:37:04 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] cpufreq: amd-pstate: remove legacy set_boost
 callback for passive mode
Message-ID: <ZfLMSIptCObdf4pS@BLR-5CG11610CF.amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
 <c9653c82afd9a11a7d3fa466f60d64d7e457968c.1710322310.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9653c82afd9a11a7d3fa466f60d64d7e457968c.1710322310.git.perry.yuan@amd.com>
X-ClientProxiedBy: MA1PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 587d4875-0321-4ead-29a0-08dc440e8406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fmeDTT6BjZXjODdud3gxS4R6FdXNQm+SU6EyQfTmvhRq/b9Ehka6/aqvsFtSX1hdvbrgSNl2rWI7dNmssbxUddpHcq4iV3q+rTQvB+K0teMKx5VlirNxyDtLiC8lKogrHUL/h7PxwDwZTQebhHbo0O6d1Xe6ErOEMGtkAZpZccfyVnh/0KSFuWFyITuy0BwC0S9dQbGF1wjzcm+uBqxLS724wl0yRw/dotcEAkLNWbH+K2EKG9nJ7RsdsHaecdKXKAxsO1gy3T+o6LpnRlrOaAN4BZEIhDzsaumq7i9vZa+KO1tIbHQ7/RyAUlen3+fUD4JHOCKRKPQFeTcd+pgxBI1Lmq4LQuuYVMA+7H3KoDYmfD5pHMP17n1Ae2sUS3ugNu8hETryiOSF1HJxrTEc4cr90AulfSnIaB6Z7W0ZsgqpL5AMNaZqkHLs+4mUnlp2fvIVtiB/xtWGEhWyrum+58JK+SbBp7qFAFXvCHMWRvPb/Yc3T394+hU3EcsfpjQr4++Phf3TisOVJqc9kaVO/Z9jTn5zTrDMbb3SY9Va4w4aHnu8JUSMGUCpgsDyT8FGSNiI6YYSkTzeWS4kiKAuNg/sCbOGlvF1FltIVnTQJQ2cWKVfibKAg/ZLlZsx7PzJnRa2C3mUIm56Da35klblUjdFhzYwmjb/iaHIytOQjnU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gci4jqTnjz2mYv4xIksOf5SmkCDpQSHmEJ8JC3UCbC0dhhUWrfMpOkzHC+OS?=
 =?us-ascii?Q?Yh6OjnoFL5aYTHvL4wKQrzmFqFWpEHP8+RDusVgCOv7zBTlxKTszjr3FIPju?=
 =?us-ascii?Q?VsyMWLGR/VXDMPXb5/iCeA7FDome31W9lK1ccVgX+qDyMp5vfRmX+GJNr0iR?=
 =?us-ascii?Q?M+3txjI5T8W9EmNO3JictAlyw5UxGJRS7Ql4GnZZJdhc//QVy2KfI6a2o2ut?=
 =?us-ascii?Q?M1eq8AKmFbkCibgcv/C6YANedmsEJeX1iAmL6DBSuKIUPwDVLu7zu5r7Gmlx?=
 =?us-ascii?Q?X0nLTE6a8bW3SyryuGygWUGUzi+o10I4d9BVoTiRvIuLsevx9erZLg1s2xgQ?=
 =?us-ascii?Q?nAJFFt1Yzxg4g54NytckSCSD5iAZ/KUTIspSPZI79NF5QB3gIYs55AzAVwTU?=
 =?us-ascii?Q?SDiJAAv1op0lr6gtDeYvsXIdsxtCeo8WuhNk40u61D9GzKQ5IIzs7kcDV33X?=
 =?us-ascii?Q?3YBCKrnPtS7Ww3eT4/Mxl/0kbpRRz17EjxDSZpQ6oqRz5tWYfc6Yi3QEicNC?=
 =?us-ascii?Q?ptuLT5LnCsFtL64UiJRC2oFhoj8pPS2ehzdBFTIerpXzgQKbGEG5MVw9Rfhq?=
 =?us-ascii?Q?D2kJHENCs5pvH3ds3MHVNwVkjk4oFQ9+wq/Jj1RAZgJ8z2IQLEGoK7GuCYtD?=
 =?us-ascii?Q?5BRSbDYnhYPciwE7bgaUgXUY7fEWsGxuv4i8HjRkoHEL1vDYCZRVCSBmpYg6?=
 =?us-ascii?Q?//pEIjbRjdJrbvkfObOu5p9pZ2geR6RwhPjhDFL8LaQP9E3sqP6Ko+4hzyOz?=
 =?us-ascii?Q?xOJuwGDeeaYbbsLyDe+cqu49set4rXiHpfjOHvC3cwo+B+J4QCg7XTwySRBL?=
 =?us-ascii?Q?xLYPW0Krx1j+uyYqZPBfepwtVHCPs5J0fNg4+nXMPcf6sxaYDKx9l2ffgvpf?=
 =?us-ascii?Q?ebyPGAfnp1Rruepym0rLLm5tove9aEsahch7CWBjGBX1O2fAdMBGZuyXnka6?=
 =?us-ascii?Q?esNVbVnL3FvNBC0xDOrafkN1ZeRHMLI5uTIPlAX37f30hEYLvr5ed5nHhjob?=
 =?us-ascii?Q?LEJmwMuE/03JLT3TOPhd1a1WvMKIN/yvc3BZ59JYO/YOPhAxZdKbHuf83N08?=
 =?us-ascii?Q?XwkbwxJf9ZzOV4RQKVuGuzADKbBY115rUKwubK3duGkMzmm0uLUoo+iyyW9N?=
 =?us-ascii?Q?KQz7mQM91wqQTnln3T+brlowOQSqK4h2lDZBXcxGD5tElPlTnZZWKRN1N6Et?=
 =?us-ascii?Q?xzzMRiM0cUfZ1UeagI6sYO8H89gYH7q9d/vw5CUqcHEtLpWvrj5pWeabVSKV?=
 =?us-ascii?Q?6l1jYwqIDBKjEYbmKw0fU9z29W8f5ANOZqfdIYbg+nkEcfa0+6xAwhMiRdI+?=
 =?us-ascii?Q?Vkp5Zln4LPYtuwM9i2AcW9XzT19qKfWmS1YJ7V0ORNdOvHSIaDgGSf5Vvx1e?=
 =?us-ascii?Q?ctmdNvVYmmJET/oBjDWJ/jdxG6aPBqc1ZAKtETas9G0AsgHo2bzyL5X1iKgE?=
 =?us-ascii?Q?3jadvQBI4jWguPxvYGZbbOwG2N60QyNzgvmQFqvtJt6rX/4Cw56DQBKaWDfg?=
 =?us-ascii?Q?vuuws9wclVMITZ+gPP2B5hJwnKcI31E8vp4ZN7hujhFjjyHuiw2IBCe4mqKN?=
 =?us-ascii?Q?X2Py7qr6lbHMiODhBm0eg1hJOlGWO1GLTDLvrx2w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587d4875-0321-4ead-29a0-08dc440e8406
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 10:07:11.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saCvDj6iSzwhgM+jSXnLP2/52v7YOL4PMINuVx7dQArZCZ9idfP97PHpdTWXZyLO5VMkuNBEN9lUUwluMlunpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947

Hello Perry,

On Wed, Mar 13, 2024 at 06:04:43PM +0800, Perry Yuan wrote:
> With new freqency boost interface supported, legacy boost control
> doesn't make sense any more which only support passive mode.

Why is the legacy boost control restricted only to the passive mode ?

Can we not add .set_boost to amd_pstate_set_boost in
amd_pstate_epp_driver ?

--
Thanks and Regards
gautham.

> so it can remove the legacy set_boost interface from amd-pstate driver
> in case of there is conflict with new boost control logic.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 1 -
>  include/linux/amd-pstate.h   | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7afbded6e3d..4a24db868cb1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1689,7 +1689,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.exit		= amd_pstate_cpu_exit,
>  	.suspend	= amd_pstate_cpu_suspend,
>  	.resume		= amd_pstate_cpu_resume,
> -	.set_boost	= amd_pstate_set_boost,
>  	.update_limits	= amd_pstate_update_limits,
>  	.name		= "amd-pstate",
>  	.attr		= amd_pstate_attr,
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index c6e2a97913de..7130b297c522 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -56,7 +56,6 @@ struct amd_aperf_mperf {
>   * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
>   * @prev: Last Aperf/Mperf/tsc count value read from register
>   * @freq: current cpu frequency value
> - * @boost_supported: check whether the Processor or SBIOS supports boost mode
>   * @hw_prefcore: check whether HW supports preferred core featue.
>   * 		  Only when hw_prefcore and early prefcore param are true,
>   * 		  AMD P-State driver supports preferred core featue.
> @@ -93,7 +92,6 @@ struct amd_cpudata {
>  	struct amd_aperf_mperf prev;
>  
>  	u64	freq;
> -	bool	boost_supported;
>  	bool	hw_prefcore;
>  
>  	/* EPP feature related attributes*/
> -- 
> 2.34.1
> 

