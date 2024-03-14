Return-Path: <linux-kernel+bounces-102886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6D587B804
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E70C28332B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A5523A;
	Thu, 14 Mar 2024 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YIcaKHiy"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1274D27E;
	Thu, 14 Mar 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710398333; cv=fail; b=JB2a0oh4UCNvM//KRV9DGj1kmi6GNI42VYqtzN+ob5MOqF1rUabf1kbxK/sCgYWJz5GUnYAaasaJR33E1bDA9L3dVKwu6zDHKSG39g0eZRMqk0ZKu1qi7t8hvUUQWjqTgRP4yVozsMg1Xx87UWqicOO8h1SlxWXJELoAxUmtAQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710398333; c=relaxed/simple;
	bh=4YRkq8vo3f3V/p2YNfQDbfSslQxrNIvnoxXuPr66XoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SrazfrkTdU0FJjYnn+/I8NGZdYGFu0EUkLdIOASfQmC2WUsxHJmUl7LIauTUMVqhIVbuA9rprasvvbuDojLtPo/dPp8tSphc60uvusfjaNcrV8lN7S691oC8Kyvk0RRjGm6vp4q5b/WAcnAwRBvuuXpB/2ks5Km2ezIMlS42p/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YIcaKHiy; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOhj3zz6/p62IyAm2TJ3ykQR3VeUV+SXkfD9WJG3H6ModkM4MDeXjL4GGfIkRkN8a163r872VpGYWIgysnFtYTE6vq5kseSR+uy2ZPXB1DezGWx2Bu6WE0ntMrjjavaOCKzuX7oRIaN/Kjwl2z6Wskkpny5wNPwkw/jdH93a9gAFneW/wGM8WIaVT2om4xHc36ybbDwqLkwWOXT4Pv3hdsPYtvPe9iJmhFe1GQreN2gASvLvv0fRjfpzJJeMgKZhi59NHpNOLaVXCBILgqYMJcHxavFLsgVEtE0xu07Tfv0Gg8rzriqgl3nLvzwPSeqOdunZ4XWo/PH99lsjvuClOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPhTKJ9O7fLx2RDSKpTYB4qZ+jHH8BS2xQdeicF7Cj8=;
 b=HgS7jk/oDZx+64y9iIj70kv1AFTv6s+P8XNcTtkpP3sfAqS8qT/YgQFZHeW8C7E9tIkffTeGt0uRQa5DFFqTx++V8XG62YN11ZEatSoYgoOeP5K5t+MI3ugWjrvd+iGpu+Um/OMwqXFzj7F2iV8eJw6WE7QefUJxbYcDBrw+vliDHEzDgHFWSdkfrjBI/NoCPYyid7U2haFhhbYu4SeOD1JQY29oLSsLLC8rik3LCACbdBHhu4q2aYzaMGUEG+awTFdxzEnCrVMCaL2PBEBSEtI/C6+y74waFCYOUAw6dyc4In2fQfL91J00ZOny59zwZTbXZRbfsTeyCa11/0emfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPhTKJ9O7fLx2RDSKpTYB4qZ+jHH8BS2xQdeicF7Cj8=;
 b=YIcaKHiy6S0obqzNhnK6ovbi9NiMfYKGeEgt5zeFuxADSpZtLld69e9BnGHJgJIUhCBf2yWLrKLU8FLPg6Ljw7e3JbYZigDRy6ZQLSMlA8ZzUgyYNIL4aF0FmCYGhznIXOjODwYU6zSTm7qacjsoR+4+w9J8MvreYygeL2C/MKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Thu, 14 Mar 2024 06:38:48 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 06:38:48 +0000
Date: Thu, 14 Mar 2024 12:08:37 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] cpufreq:amd-pstate: initialize capabilities in
 amd_pstate_init_perf
Message-ID: <ZfKbbY2HfQngRfAl@BLR-5CG11610CF.amd.com>
References: <cover.1710323410.git.perry.yuan@amd.com>
 <e450342257c4c80d42245723b273a80a521c00fb.1710323410.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e450342257c4c80d42245723b273a80a521c00fb.1710323410.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 2350b88d-8b9c-4c0d-f888-08dc43f16785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GNyMHNtxs/D0E19i9fZYgH1ysAtL68Hl9B3AGRKPulJmh9rsB7MCaye2jEhf8Zck9ZX5dvfEpuYqpdrcl7jWQtg5MuGzWGQWm+XFe4LUkmrj0hliSPSKrDr34cShaCd/IaZXGavRMG0FxlWlJsIi4sivK8//bBwkap+mTUd0K7Swr/xexpVsDmQo60KTmURZAQG6GLDtDQB4J1/Pm5dvH6lB02sPvoIHrXunPKrtM4VXCqTy+7ffDgt2cv2YYTM+/FBMROXCQTYIKhWorMB5AqG9wNgz0ahndKsDS262LY+cwBTuFSt1oaPlZN3tNRjDDiKLaXgG+f9M2cUJ7t7xJU6mzK5+u/kBCHr+sH/3EjxqXTmYA79UmNcGH6usPr+onomvAaGVon10izy2uqQ8THw2/LAZassZafKMKAtOLmGfqaiUJEvyTO6NXKDKgVr9lXiRURMGwEC3udqdafs63kkWLfDqmCgzjxz3jpHXTmlqX5JqLKVlD5bhqAnHqdGJttElArTNw2jutBMBPuXiujgve66Bhm3cUiCkA3xHbIr2FwDl6EQYSEvPlOVNzWUkQj/P7kO9nymxLrqvUUEkgnYuMEW7Wc9BIknoSPJRTGpj+tdKsrIzBVGoCK0nXWlIDLMJpra1YFijs6ML87BQiGxJEj2nCk72t2ryW3ztPnQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6pfk9xkdZ98wC1i4CUxS0c4HoW1bmnsIiJVch2nrY3E623uqTJMArMPbqiza?=
 =?us-ascii?Q?Ki/PBaW84H9/IDmhdpFDK7uoZXX1GI1zscETtgFXj94H0cpwK2tsRjKRYVSM?=
 =?us-ascii?Q?9ZljQGQ1nRIjjmMOKrFZP7ITL15Kmtyk1ihpbixOUpnLNvbuhDmNUAiE3Y10?=
 =?us-ascii?Q?uO8ba0dNcr5bY712iTVH4EakXNPQhHzdtcZPe/94eMGNZPV3YYCAH6H0XdEo?=
 =?us-ascii?Q?ktBiSu8h6WJmt58obEyWoBpEFtMJAOMa9gAoS/1JyDfZ8TyQmdlVeiHPJxi3?=
 =?us-ascii?Q?xVVddTsGvci1sgimN4UC8h1d6euyvDW7fIs/nA3o0fLLHNbI3r3CtGyLjuFB?=
 =?us-ascii?Q?3qHeAPVG91Mc5C6wyIiB2dJKbIEsPFCE34xfifWyUizYijSpOGliP7YIAbL4?=
 =?us-ascii?Q?sIJYKIauhoRFZGpn6AC/0l186anBe1Z4LIH0Sk3yiPR/5+tfnjUlKqYBQ93l?=
 =?us-ascii?Q?1nd7FnrDq6tyyVlOZd+XT24Vw7tGKDUAYAtodJ2v9U+eIQYFXw4C9XXPKxe/?=
 =?us-ascii?Q?rQ5nuvkHKjKd602ouUAKWutsolDcE69vhYhyjFsbTL4esI0rwQcqIHzTj9ND?=
 =?us-ascii?Q?c1iycQK8+mdU9Zx95XeNng7VLdaC8AluSfrVUjpjLWrnA0XF21V/cUHx5I90?=
 =?us-ascii?Q?tnhzZ58M0AFD/apxT5WB52RQaJgmNFoFYWroQl8deFWwBPWdPHAsnL/d8+eV?=
 =?us-ascii?Q?XVc1HGUvmPMjSdZek6lb40ziO5cJxuBZuycXAco86GzeNiUnL5iVSUzyCucp?=
 =?us-ascii?Q?bFs50gWdGiGr/7qMdqdvBXRNB3vqSRb0ma10Q5ZHo/gwPtTvYnHbEBPcuJ9z?=
 =?us-ascii?Q?A4H7zRSSPsXfAr351N0QNgDG4KPD1pUxkzfAgTDJ4fOwce+Ja45vL5cE++j4?=
 =?us-ascii?Q?pJnvip4dLh1ZzAyTJPZzbZ7sEReHvBoWXfrfQ8+BBCrIDf0f/VA2WjwNNk+p?=
 =?us-ascii?Q?IcS8qkqnYYwQgDf6QP3ZUQE6U22/OfdSC1QscASnORRAMaMiF/fOKiUy6iVJ?=
 =?us-ascii?Q?jaNw2IqCRlGs0nr1DAvPkXTlpgNo42MiKOQTGasJC+8yT+W6Vra96WUA7eZC?=
 =?us-ascii?Q?flnR7arnRMRKwVB4uLwCKVNmVCbMKb56DsowKoKGZfGbG/2pVNf/RjhIYG7X?=
 =?us-ascii?Q?oc1SW0bxNYvyaLpJfJQj2ByFm1V1ORrlQ0KwekwxsYf3rMkxbQU6nrWLIX/A?=
 =?us-ascii?Q?5Tm7DMk2+909f6Pqt+szWkpPuKILjM99hk96Ghu4cySZZfXIoFfu0PmovHIm?=
 =?us-ascii?Q?QGcKDbvZDNP8tsuEU4lthPxlASvda1qSpcCtXQPw2Qutb7G7FgYP+6nWaJql?=
 =?us-ascii?Q?c8+r0Y+hglBNBWT/BwIU0OXrZi9FsWHOEAeOG7ZYEKGrgHwfN92P/inrRamv?=
 =?us-ascii?Q?9pENclnLW1wu3CR3vVtAh9JgL6LJOM2P6mJOgl9oYbIYzjrG4f5N+4NuKsbM?=
 =?us-ascii?Q?ehsoFhlvbYh5UbBvmd9KOV5FYmXy6Tc+ADzqqKuvEHLFfKz5SoQ+fR99DVP8?=
 =?us-ascii?Q?R9FlF58QnloUXeMfWdDPAm321CAhfUuCOiEqwA3Q3QGBQw4u1v60vTWivZnr?=
 =?us-ascii?Q?1X06/yj8gvg90UHmMFmy5dEv0bZHnEuWPoJd2ym+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2350b88d-8b9c-4c0d-f888-08dc43f16785
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 06:38:48.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj7PrDy6jtE4dt+h7gUXGYxKbISTOYu4LH08FbZA93IwZwq6fMXvleh8WHXTszaXhGCnKoP/i60mBFiDFjtjeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612

Hello Perry,

On Wed, Mar 13, 2024 at 05:59:18PM +0800, Perry Yuan wrote:
> Moved the initialization of some perf and frequency values related
> to cpudata to the amd_pstate_init_perf and cppc_init_perf functions.
> It can avoid duplicate calls to cppc_get_perf_caps function.

Does it make sense to fold this into Patch 2 where you are caching the
nominal frequency for later use ?

Otherwise, this patch looks good to me.

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 43 ++++++++++++++----------------------
>  include/linux/amd-pstate.h   |  1 +
>  2 files changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 59bcdf829c93..3877d4ecb5d4 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -330,12 +330,18 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  {
>  	u64 cap1;
>  	u32 highest_perf;
> +	struct cppc_perf_caps cppc_perf;
> +	int ret;
>  
> -	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> +	ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>  				     &cap1);
>  	if (ret)
>  		return ret;
>  
> +	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> +	if (ret)
> +		return ret;
> +
>  	/* For platforms that do not support the preferred core feature, the
>  	 * highest_pef may be configured with 166 or 255, to avoid max frequency
>  	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> @@ -353,6 +359,9 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
>  	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
>  	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
> +	WRITE_ONCE(cpudata->lowest_freq, cppc_perf.lowest_freq);
> +	WRITE_ONCE(cpudata->nominal_freq, cppc_perf.nominal_freq);
> +
>  	return 0;
>  }
>  
> @@ -360,8 +369,9 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
>  	u32 highest_perf;
> +	int ret;
>  
> -	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> +	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> @@ -378,6 +388,8 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
>  	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
>  	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
> +	WRITE_ONCE(cpudata->lowest_freq, cppc_perf.lowest_freq);
> +	WRITE_ONCE(cpudata->nominal_freq, cppc_perf.nominal_freq);
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE)
>  		return 0;
> @@ -642,17 +654,12 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)
>  {
> -	struct cppc_perf_caps cppc_perf;
>  	u32 lowest_freq;
>  
> -	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -	if (ret)
> -		return ret;
> -
>  	if (quirks && quirks->lowest_freq)
>  		lowest_freq = quirks->lowest_freq;
>  	else
> -		lowest_freq = cppc_perf.lowest_freq;
> +		lowest_freq = READ_ONCE(cpudata->lowest_freq);
>  
>  	/* Switch to khz */
>  	return lowest_freq * 1000;
> @@ -660,14 +667,9 @@ static int amd_get_min_freq(struct amd_cpudata *cpudata)
>  
>  static int amd_get_max_freq(struct amd_cpudata *cpudata)
>  {
> -	struct cppc_perf_caps cppc_perf;
>  	u32 max_perf, max_freq, nominal_freq, nominal_perf;
>  	u64 boost_ratio;
>  
> -	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -	if (ret)
> -		return ret;
> -
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  	max_perf = READ_ONCE(cpudata->highest_perf);
> @@ -683,36 +685,25 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
>  
>  static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
>  {
> -	struct cppc_perf_caps cppc_perf;
>  	u32 nominal_freq;
>  
> -	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -	if (ret)
> -		return ret;
> -
>  	if (quirks && quirks->nominal_freq)
>  		nominal_freq = quirks->nominal_freq;
>  	else
> -		nominal_freq = cppc_perf.nominal_freq;
> +		nominal_freq = READ_ONCE(cpudata->nominal_freq);
>  
>  	return nominal_freq;
>  }
>  
>  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>  {
> -	struct cppc_perf_caps cppc_perf;
>  	u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
>  	    nominal_freq, nominal_perf;
>  	u64 lowest_nonlinear_ratio;
>  
> -	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -	if (ret)
> -		return ret;
> -
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -
> -	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> +	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>  
>  	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
>  					 nominal_perf);
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 7b2cbb892fd9..1fbbe75c3dcc 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -88,6 +88,7 @@ struct amd_cpudata {
>  	u32	min_freq;
>  	u32	nominal_freq;
>  	u32	lowest_nonlinear_freq;
> +	u32	lowest_freq;
>  
>  	struct amd_aperf_mperf cur;
>  	struct amd_aperf_mperf prev;
> -- 
> 2.34.1
> 

