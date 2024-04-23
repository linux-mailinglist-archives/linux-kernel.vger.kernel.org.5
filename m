Return-Path: <linux-kernel+bounces-154934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB98AE33D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B5F28171D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D31F71747;
	Tue, 23 Apr 2024 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rf+07iSi"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F314629E6;
	Tue, 23 Apr 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870036; cv=fail; b=L1RnbUJaJODzI3Uby19viloF1PcyaZ5hhL8lTagswXRuIIm3z8qUnaEc3fqNCx1RgCiYW+vHxKsxNml17f6g1+eu7rNBl7XqdArmebuCyZjDrafseAqQ5uGQEumOgllo7GOpwXcNVd46ABA9Qo9q7TueqSA92lUfML97+55pKbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870036; c=relaxed/simple;
	bh=ezWYIZuerWRKxTNT6IkOMwpMlUhQeozzfeGvhCV5h8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WvS7AyygBfukMB2yCj3Fur3RPngaejNTI9V12qUKrz/L4/CqNHDKycWgsniPUb76UJJFRY2LmJyhKiP9aXJwWRkruOZYBeMy3PF/N5o0tV1tqd8FhHJWVLXHjVIwisRLZgCP6CsV5YxD+m4AUDB+WCCaghEbegYtD3tC/xv80Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rf+07iSi; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1iOMJv57fn6jsw/PqG62jzAb3N8ErbKb0qjCKOf6vnlPEckGeGbqdWlzHPeI1uXRGC0V5cW7Bf1t8bDsEKWVuoYYV27IfMMs7d8wyc4SVue3UAdejY10RlyPfJLio62QQFBxjmaUQgN9YhI8r6idUukhGNKriwF/yZQnidE42Zn7cYpr0IgZQmyrB5F4VnpW2pbb82aspiOEsBTqF7DzvKXLFRq6dVBZ0wZpzIKcyik7r2zsruvUeuSQZmBBif/NKvS6z2MgLSU8ULvUvC2g/iMre4IT3XV+ZtoRZzDgKCelovJq/lUAmqOtyJgLdSydLXZV2cHh4gXdyuctEI//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjlmEEaS6sDpEaXdwJD7NzN1b8QRtEL90bCtU0dT2ns=;
 b=YYqLEKI/s4GJGnwaC6goyamHVnEDbe06PBpgjL02EOoGkeinqnek6jTPXdCQEqhDfOambkSWsepBxsTVmzG0LqWBLEKiAq3vxyZr88A51BWDcOi5dOFplVhOo27BN1empqkda7IsgaaS3WaJz1/0lD1OT/cPBoTAt+rrVyAa81IGw1YGfb5fzufutEo4rmLtCPXc9l1FFoYG1wP+zYj78wD4XQG4HT5vmoYkgXSBHZCx1ytGiUU8Dy8s71o437RDAZc/46O2/V81x1cIH2HonYpI+lmVpQEKHFiFS2K1gWOQiH35H6SFQPgre+SCyOORV9CuOuoE47gRIw9eg3lOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjlmEEaS6sDpEaXdwJD7NzN1b8QRtEL90bCtU0dT2ns=;
 b=Rf+07iSijXr+O9wURN2K7Yh3yzWgm0IpphtHI82O1dABTZ26PwU0QTjYj2EHVW/2k8vNv7hCJh+FXzKXIHmS2U+ZxTT9ULYs5miVHEQCaeTpQj04pMWyjuqTG8zlqKf14MwlnSqJauTQoLRPcrwxLiU3YsHBsFY+310omyolSXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:00:31 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:00:30 +0000
Date: Tue, 23 Apr 2024 19:00:09 +0800
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
Subject: Re: [PATCH v7 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
Message-ID: <ZieUuaKRAPFr1EzS@amd.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
 <5a357c1ac3504f8a69def8834a6d9557b5d592ed.1713861200.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a357c1ac3504f8a69def8834a6d9557b5d592ed.1713861200.git.perry.yuan@amd.com>
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 42732365-ea78-451c-db84-08dc63849711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ccrkD88KwlqF5TDxYls5kUoxarRXeDiMi9xngSkMmK/PCzJluSYn/79MnPq?=
 =?us-ascii?Q?anfnKjWujjNalQWbyrhevaTo1G0zRK1v3s1lUt3I7H9pi5xhJrmAxKxEXCBy?=
 =?us-ascii?Q?6XSIMy3NTNC+ddbGfAxqapu3ERFCRTU8zXunPYmllbInqojXCRgFEyseJe9c?=
 =?us-ascii?Q?9LhEYIVu37OMRHlDrg776746sW6QtEC3ltuloSD1OxSLqu87ue4dJTmP1OCs?=
 =?us-ascii?Q?Ifsuj41quhFtkBs+2R24EguxEOJzFbUnflSaBccb/pUqoSFE0wXlGNnPyiho?=
 =?us-ascii?Q?rSD20h/ZolsIlqlKsu7Bq+f9LW0idwvW/bejPz+uuMRI6dSkTGVcBnztoRmY?=
 =?us-ascii?Q?nLeecqbYUKx1mUODVqlw5ECMQ7q4c+RZda9HYOfqKYdnVq3vaAj03c6CAHOv?=
 =?us-ascii?Q?Z52KyVdfhzi1RhUa2pj6JlP42YM2wpmiz3Z/TCzUgV16QA2tJuIJWjLX2NxC?=
 =?us-ascii?Q?nm7y7haMkB7Zhn4HkQ+AfrEh58gQ0ilUEScyhqdh8CPcZjGBJIljtRhl0MxM?=
 =?us-ascii?Q?sjX7yKXUJ0kJK/EWoHAmSoVWC1BK2wFFaRUJbLQakOvxtdmat/dg6RcpudHu?=
 =?us-ascii?Q?D8CxJwCpfLpjtEQDua8CiqP1XuDFj4BWDu5hZ02oK1gSz+Dz80qVEgxntCu9?=
 =?us-ascii?Q?00Auqdu9t9HjmoWUQXipJpTc7tJe/vf5XIc4nloIVhIe69hhzs22cjYB5ELq?=
 =?us-ascii?Q?vey+ziTAZa/6JhMGGZTzMkZHypGKTjgMGp8fG0n9lqg47q65A7Bt7SMoYuxl?=
 =?us-ascii?Q?lHDK8AiCYF4n1q0dpiEUuwHbXpMDd1maoMq50l7YIsqdHd9X7F+9kBSPaObr?=
 =?us-ascii?Q?buiSWHWF0iIs6bueH3BvESesk/Z9gEHKbm7nN+OK8C19e5nHSPufKk54Kjh/?=
 =?us-ascii?Q?Qmr8raSxq43R9h1lZmhgzY3TrIo/pdx9IkyambrFylT+FvkE4ixK/xTgf4fs?=
 =?us-ascii?Q?Yzi6Hpm8CmAdzb6OHvDkrfQvSwtGS3HyGrxlqKrWGhI1nYg5GYQ6JPigbKwL?=
 =?us-ascii?Q?l+rxs8Ar/tt0EmXnaeLbjNnw+XtEzGfraldw2EL923RjfskbcPP38iUwt6ur?=
 =?us-ascii?Q?h8NCvqUHlgLnN24EQBZzYwtrySD/WxmorSiwEB8D1YIPG5N9CMqID+u0PjL3?=
 =?us-ascii?Q?zCRuc23Tuq4NHyo0AY1wVHvB0mXoRRr2/Aiq+Y/FqPSX2cTpY3vLpBBHtuhs?=
 =?us-ascii?Q?lpb6dy+W5wIjfP/eWUjKhX1NlX5PaTiJAUOFP41R4l920IuajNS2HgfqLYpQ?=
 =?us-ascii?Q?FU8TNMx0gjB34kNXPFIt2tQ6QEFIxaAZTHM8vXh4oA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h5D+tqs1FDgnUigTcAffzckZRnUqP3bbcFA4nFdspkzPtXwQ3hhGc2sxWiCx?=
 =?us-ascii?Q?+3w0vrBc8IIzOGpWicOqJN/uufnymJ59MbLNhBDkRZ5y03K+mG4qFInueYoF?=
 =?us-ascii?Q?vNZ2T8W02tEDE2xNyTMn2gXCp9IY0pKCdXh+E7rcel/RuukFmxOe+sWuPtN9?=
 =?us-ascii?Q?pMLsQYEWzjSiz2eIpl2q9wryBmM0OmXREesDvgdDY4uhP8DjsK/2kb0dGOmW?=
 =?us-ascii?Q?UVPqIfzkH6+7/mjZoDqtz+nF6kTNNEY8sCLgMrmuhISNdQ6HEef6M3eaW/UW?=
 =?us-ascii?Q?YnxgnfNwbFAu14KNd8jM77rmQnADJfgRmflhdBXTmCJCBbR4bS+4UuMuGV3k?=
 =?us-ascii?Q?0YbIwiWbwWm59K7/BWzva2V8AZg/ffoNGijhZW0HrTRd9zfG1BOcvBh2tbwM?=
 =?us-ascii?Q?SbewgllBLITvPnYgbxsqSDiPCxwrUb+FVSt1/spiz+MubLNuWrrUl1HoUsg7?=
 =?us-ascii?Q?BPPV/bKzA9o+OBLWdipmAnUkzoPZXA8UCO555992WSEpYpRmId/+vmbxshbt?=
 =?us-ascii?Q?KxsOz5yYg2mwE2g5feutzrtE7YM3flA2ugKec9RpETRqTaQCG/L7ViVi2kCJ?=
 =?us-ascii?Q?G18fYDwxX/TY783SSCX77brXiPcsOGdhyjP+pbM5wLnPaW967IHPYEALmx50?=
 =?us-ascii?Q?oEyLoqaotmTtDiD9Q9SR2sddwymqhB0iiW8WjRxylrCNPoUwtKmcCQvxasUo?=
 =?us-ascii?Q?2h9/stShdL22JcMrSzwUhqmM4y1LAMjZj62L1z9+80jbkLRWx29O5ZrC2k2X?=
 =?us-ascii?Q?UUmHSrchCTAaFtGGqy98kr6wlThI9QPTTESkNZJNDgTundMSL72icv7l3ynO?=
 =?us-ascii?Q?3mk9enNA67wp3SzUD8WYU0AylpLqbKuQeVyw+fzLxnYpmCmcm1hzJlpbP0+9?=
 =?us-ascii?Q?HIPum0+3rADZqG6+ixJXCWX/uawkKxK+vsNAAfKXc3IGLiRxckIqsIxMCm8U?=
 =?us-ascii?Q?ccL89gCKf53MgHiGWvoiMYQ/ang9U2bf1qrDD4ZJX80tDPdlke8PdAmyYqx+?=
 =?us-ascii?Q?XvRatfwHFMAFZqL5I1p8wKBLB4yVb9tdu3TF3FBdC9ppkdDaZUf2lUcIGJXd?=
 =?us-ascii?Q?ns2GUYlbCPVkgQEno1+d+OHvHKWlwt78SlEcfJvNy0Yevr0OE6QUFABv3Lhk?=
 =?us-ascii?Q?cym4dUkFPVKWGFsE+ErWV3KVjotrl18ZchseKFjVVi8jhev3CMjqVvRusyjY?=
 =?us-ascii?Q?bAiOMnRxOQpWfx6Omp0Xxdrzkj2VXnP/atRY76nZoDZ5szw8bZ88ZxlBmwpW?=
 =?us-ascii?Q?Eb/dvMdvrvfkFJ2DQppBbZlKIfQ66M8D94XxI7xW3m5q6t6UajDpWnNB5/nq?=
 =?us-ascii?Q?w6Mvv5+Fxn3yqpwAebnSWLEJOTBaZIj2wIjwowUlwVgL084zP9yOCuLw/ja9?=
 =?us-ascii?Q?uAAtNAAUWefQBaNq4DE+akjld8QWvQN9IszDPx+4f/vrxTp3NIjfBzkc4icc?=
 =?us-ascii?Q?UYgmPeteHYvjqUlSJ/NWMJZ/lsXALKTsjV8y0VldacSIMbQPKj5ilQMtyrVC?=
 =?us-ascii?Q?wL0Sfo96SI5ZNMmQ+iO6qO9kZPdZKFwn6GFk6OpO1+K0/bD2FrKKorBedH8X?=
 =?us-ascii?Q?jFRfZfcbZSb76YvJ4hbn9j6p8RAEu+CNgNF1W5YS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42732365-ea78-451c-db84-08dc63849711
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:00:30.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3H46eNh9fffwI4nmP6jeDNcln2/S9QrRRT0BAw79XFcUZ7M5pFvkn7GiR5aGnn2STlvucLyNHGqPVFdM5IeKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

On Tue, Apr 23, 2024 at 04:40:56PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> With this new sysfs entry `cpb_boost`created, user can change CPU boost
> state dynamically under `active`, `guided` and `passive` modes.
> And the highest perf and frequency will also be updated as the boost
> state changing.
> 
> 0): check current boost state
> cat /sys/devices/system/cpu/amd_pstate/cpb_boost
> 
> 1): disable CPU boost
> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> 2): enable CPU boost
> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 99 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 3d86cd7c9073..49eeb38fcf20 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1291,6 +1291,103 @@ static ssize_t prefcore_show(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>  }
>  
> +static int amd_cpu_boost_update(struct amd_cpudata *cpudata, u32 on)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpudata->cpu);
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> +	int ret;
> +
> +	if (!policy)
> +		return -ENODATA;
> +
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> +	max_freq = READ_ONCE(cpudata->max_freq);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(7, 0);
> +		value |= on ? highest_perf : nominal_perf;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +
> +	} else {
> +		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			pr_debug("failed to set energy perf value (%d)\n", ret);

Do we need cpufreq_cpu_release here? 

> +			return ret;
> +		}
> +	}
> +
> +	if (on)
> +		policy->cpuinfo.max_freq = max_freq;
> +	else
> +		policy->cpuinfo.max_freq = nominal_freq;
> +
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	if (cppc_state == AMD_PSTATE_PASSIVE) {
> +		ret = freq_qos_update_request(&cpudata->req[1],
> +				      policy->cpuinfo.max_freq);
> +	}
> +
> +	cpufreq_cpu_release(policy);
> +
> +	return ret;
> +}
> +
> +static ssize_t cpb_boost_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
> +}
> +
> +static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	bool new_state;
> +	ssize_t ret;
> +	int cpu;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	if (!amd_pstate_global_params.cpb_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)

If get a falure, amd_pstate_driver_lock will be always locked.

Thanks,
Ray

> +		return -EINVAL;
> +
> +	amd_pstate_global_params.cpb_boost = !!new_state;
> +
> +	for_each_present_cpu(cpu) {
> +
> +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +		struct amd_cpudata *cpudata = policy->driver_data;
> +
> +		if (!cpudata) {
> +			pr_err("cpudata is NULL\n");
> +			ret = -ENODATA;
> +			cpufreq_cpu_put(policy);
> +			goto err_exit;
> +		}
> +
> +		amd_cpu_boost_update(cpudata, amd_pstate_global_params.cpb_boost);
> +		refresh_frequency_limits(policy);
> +		cpufreq_cpu_put(policy);
> +	}
> +
> +err_exit:
> +	mutex_unlock(&amd_pstate_driver_lock);
> +	return ret < 0 ? ret : count;
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> @@ -1301,6 +1398,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  static DEVICE_ATTR_RW(status);
>  static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RW(cpb_boost);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -1325,6 +1423,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  static struct attribute *pstate_global_attributes[] = {
>  	&dev_attr_status.attr,
>  	&dev_attr_prefcore.attr,
> +	&dev_attr_cpb_boost.attr,
>  	NULL
>  };
>  
> -- 
> 2.34.1
> 

