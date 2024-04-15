Return-Path: <linux-kernel+bounces-145876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E88A5C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26656285CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E9156891;
	Mon, 15 Apr 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rqu8ohWp"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87128156974
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212906; cv=fail; b=bwkTd0fo1mXn0N/Vw5SQ4iHAtOm2Z3LC20nwYEnf8fakudM/A4iIsZT+0AxaNo1VpHtpDxFVgLYGv1bIzcVvlM11n33GMfDyITjbsdFnF/kILJHKE2pY+gDI0/N+2TIg2os5gTcdfK0RzaXSTdw0NAVh2kAj1KnSdjtK2jaXqto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212906; c=relaxed/simple;
	bh=0xgNja4Z8e2M8f3fhQ7vTEZTDpK8aTxxLYFwIXAsAjs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pbut31njdhI9ah3KO6gQxX77RpYeBK/3lowGc+txy8SRUquipntvI1Qvrwq7W75qrbiOy9D/+leTNSCUu2Oa578o9NaR7b6f0SHoW5XTvelECBqKdfltr8x1p/o3lsWGqKI7ejiuf9+Q/+mToz03ChLfTZT9DyE/gA293zci8ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rqu8ohWp; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4fSpXIcvvm2NB37nDRq2n5oIM7fLdwoRAZ+qL9sDNnLH644QIWcyMWlHH56rRQtqp/zRUXj1NiVoI8MsLAvSsZoL0xVDlGaAUpYU8LsYISGpjTqC4Z6d7cLxPRC4OmrtLRVETC5LsgwSn6c3JVCS0Z2m/MAtr9B5w7xJZ8bTiKZ/G9ik6lUgo3Zq4/rgj83REbsE3RjGcxFFjYXwarXNb/QZfkcJkqc84rYrZ58nDTimFAAyj+UmAKZLaC+xQxQeSsR29RCjbyDKHZ1BqXhkjfBtjPE3re4IXhQZ8HtgfxM3b3biorYvamcwvYaHYwcmRZ3i75fKXP751bKre21Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37EjKS0AW65uV8slAV7bQjoSf06yiff3u485Rnakk4I=;
 b=SOaMspj2J3kUUPh/MjUBYTWfF8OIFbIVQg4MUIu6HxAskodzM1kcEM2sYtGkBihfq5BNJ+Adqtr5102Z6g+0Shocn0y3H9KD+YW/5qbO5SAlS19rww3881KjcItVM1HVFjNtLSzZCVkQ1pcBYIS9tyWqXGLHNQ9d7qXcMuLxtQO5U/wkMTO8srAEuErcJdQAKJWM91pE2VXPyEoALJNGOs/JTvxp0Lr7j1FytSZDkSh6lTe6NJekdc2PImmgHB582GlHfiKJdL2fego/UdlidXCczvjt9cis7siagMKApDQ+yL5+KxuyClDZB0Cty318D/a9NjZjbitdw+PugQNqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37EjKS0AW65uV8slAV7bQjoSf06yiff3u485Rnakk4I=;
 b=rqu8ohWpJlb+93GzYskM71ENnFgwvjGaxO2CLyyxDgDuJ2HRs/L0HRldBY9cSJRcIwyJU+4wbyfSSE9W8aNrjh7qyaJF5+vRdLGruPONJhoytNyFM5xvP4QgYPcnEKTMQ4snd5+KPaIWp6EnSvUu9UXnchtVbDnnqPSXMbQRJxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 20:28:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 20:28:21 +0000
Message-ID: <0790c576-944a-45f8-bc43-01eb0a8f67a9@amd.com>
Date: Mon, 15 Apr 2024 15:28:18 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v1 02/31] x86/resctrl: Add a helper to avoid reaching into
 the arch code resource list
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-3-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20240321165106.31602-3-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:5:333::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0da6f9-da7d-4977-9329-08dc5d8a9808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hAoDC2lkBwBlq3ryy/nNAlK0y/Gf1StogtC754rlyDRHLExBq0/GoJSPPbD1K3cSQAs3uHX7YMEcHsRshvS01spHVwKIXCWtm65z5FCM1yuqqwqt7pmGrkKIrv9U0if5Rb50IOkszdYVQOt1A791quLgiwNF3IOMJMmw7JvozZGWUDOTsbXjj1sPcsq8sJ/aybS8ocUUXywOh3ZHkHQeZOd1cixOPa70IHCitqUf6KkfVHR3Kj7r/FZfemA6tOObw//S6dwQbfeSmcvOErDVDQrnbP1BItj3xF9cQ7VVUQGotwFL41BkYiJkNnoHol+wQc6xZbyrFHM3hPfXDQKcMhuK9RnSX+bbQ/VP3z+gF7PUXXRysYQia6usjw7tPMkk6nmMCXE5J6d17NXsaV4kljsstuz8pyoENXDUoCrjcCOZm3gMf0c+zwv7cOxpW3u57VrZ9V8oOPHrMaQ8jh+U1x26YRcqTE0fHrdp4UJrQfOP56PMhRRJhCmiapEhmiS4l8OmsFOWpKG1jgGeJanfDDMRKzEfIHWVwNhjOKSuXVtClVQnrC9DUC3KghB8sNd6kj2q4zrFb8QAja3apyJ/wjHPbdv9qYDy/ULFjkqZwINbrR/X5FrTp3embmh+IeOxQYwE/NAUrZO+744iqZVbIygGOsF6Ykze2d20ky//eIw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTkybXhWejlNb01UMEdDTnFaU2ZvR3o2NExZajJUK2h6SWNqQys2eHI3U2FB?=
 =?utf-8?B?NDJQbjVaTXNqcWNEaDJHVlBPaUFFNGpzM1gxR1JxMUpTRzE5SlE4Nnp2ODgy?=
 =?utf-8?B?ZENJektwVkNQK0ppb3lpcFh3eEJLQ0xHdHllRUU0S0doQXh5WXZoSHFSelA5?=
 =?utf-8?B?Q2FHMHZQaEhaaXpQN0IvOG9rd3E1akhjU3lxakN5M3RVODlINGx4ajFzTVRG?=
 =?utf-8?B?R1d6dHBwZk55Rm13R2dkZkdGS2JybllQSHJ1K0tlQXBDN0NudDA5RloxQTZO?=
 =?utf-8?B?OE9NZEh4dHhaOVJUNVBKNHRwWHZVWVZkdlgrYURsV3I5RTFhKytQcE1DQjha?=
 =?utf-8?B?V3ovUVkyR3BqWGVXOFZEZi91bjgwK216UnN4R1BjdDJaQ0puVm1YNStGT2NY?=
 =?utf-8?B?dklEeCttM1dDSGxIbDhYMVdzUzdtcVNpd2ltYVdXVUpIYmhvTjdFVUp3RStR?=
 =?utf-8?B?SDlwU015ZVRDZU5yN2YyT0JUSElOTnRMSjVyU0o2MFljT0dpVll5dnorelFX?=
 =?utf-8?B?M2d2TFBPOWpEZnhvWjRpa2RWTUlQcEt4OVBLb1FZbnVCZ0lVeEl3Rkp4VzFl?=
 =?utf-8?B?WTAxL2F5cUNXbTdtZjFUMVlGa1ArRDMweGV1ZXRoSlBNWEgxNTJiZVFCUFBt?=
 =?utf-8?B?dGh1MnJHWitpMWVhUnpGY283VGtxSGVhVTlZTFR2SC9wTEtGaFQwR2dEZXNz?=
 =?utf-8?B?aTRpeDhvemoyOHFVVUJydWNHODQxekpZSUFsckVYMENjcEtyT2Z5eXpVRitQ?=
 =?utf-8?B?eTRxdDQySTh2N2tXbDFNY3l3YWQ2NWZneDV3L1hBQzMvc3NucThLZlBrbHJx?=
 =?utf-8?B?dWpVNml6V1VxUVRkaDZXMDBnT3dNUWJiRmRpRTh2TFR0MTBRanhVdGsvY3JO?=
 =?utf-8?B?Z0xTNUE4T0w2blgwNllqVDJkblJWcEpSb1llTU03bmp1aVI0RTZCcmRwRFds?=
 =?utf-8?B?RDBhTjQwaWRNMDJDQVkzSlNvNEd5TGc1QnpCcGlHMVNxUjBTdFdkellDZkp1?=
 =?utf-8?B?ZG5QaGx6MVk4N2FsZ2JwTkVLQklEZmk4MStNaG1HSk1xbml3clE1TU13Umla?=
 =?utf-8?B?OEFqaVhhaUlPY1JUbkpvY2V0Y2N5czBYWEcxaDVib0RnOWZLV2ZjeGxLcndC?=
 =?utf-8?B?MTdUVkVIVGZvaENkU09USUtabUI1MHorZmYydGdGMXYyYlFKTWZjSSt2ZnFk?=
 =?utf-8?B?dDd1dHlOLzRCSVhIK1VkQ3dmcWgwUDR1NXpYVlRzc3h6dHZPWFFXREMxZ0lX?=
 =?utf-8?B?bThvS2NiM0JGbVJ1SC9FRjliRWV5cW9adzhLRlZwVmh0aEJ4VHRpRysrK3BS?=
 =?utf-8?B?Wk1vdjIyZVlXVHV3a3RTOUpCRitRbE1CVlowU0IrMTFrbTU2QXpIU2FRUGxD?=
 =?utf-8?B?bkJTcE9EaXM4bWplK0dQRFhKL1RTMTFKU2pOTFFwUnBQRUZ2SWw1cXh4QmJi?=
 =?utf-8?B?eXdyVFNGU0V3eVEyQVhoVzNCck9CQm94SVIwZzNwdlQ1WDg5dEU2bjBaMFEy?=
 =?utf-8?B?N0hkdzJpY1hUdHU0UlVmYXRkSGdLNmt5bkdsYnN0b3lpcDk5UXcyWUFIektm?=
 =?utf-8?B?MHc4WmtOc3QxYUordytGOFVnaEttSTl6MXJWN0ZvRm5hcW10MzN2WWl6YWM4?=
 =?utf-8?B?OS80dGVHSS84TDBDWUtoS0R4RENJbkR1YUZnVjJTdEpZL01yZURVVWYxKzBH?=
 =?utf-8?B?UEtTUmMzYnVZdy9iUXBaVEx3R3JCOHFRZmdUaDVVRmJ5dVZtMTdVVEt5NTRU?=
 =?utf-8?B?bGJHcU9YMjRqc0JxNXc3azd1VitHb2FUSGxJVysvVkc3N3dkTmVqb09FSGJ4?=
 =?utf-8?B?OWtES2pXck5TdXZ0SzZjOW41dzV0bW1lVSs5cTRVYlc0clQ3QlA5czd3SWc5?=
 =?utf-8?B?MXo4cEx2QitKOHlPWjlpTVl5SFB1c2U3N0h3eXRPclhlWURTR0xzTXRWVnhN?=
 =?utf-8?B?LzRSbW5qSmV0MkhjM2pkZlliZHRRcEw3bzRRTVZBdWF2d3dSMHArMTlmWERI?=
 =?utf-8?B?WERLVGZWOGtSVndWSlFDQzlKZ0xURi9PMThuT3c2YktSSFg5RGpvSjFBMEFZ?=
 =?utf-8?B?djgzQ2djVGFWL0U0V1A5djFvYTNJL3ByVWE2dDY4WEJiOWZ3WnBqNEpBb1Ro?=
 =?utf-8?Q?k2GM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0da6f9-da7d-4977-9329-08dc5d8a9808
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 20:28:21.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBgCL9cDXB/V5tjbv6vIY1/f3DqH5jFOlplukRZOr2JwnWefmKne/p/arJ0bhDDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

Hi James/Dave,

On 3/21/24 11:50, James Morse wrote:
> Resctrl occasionally wants to know something about a specific resource,
> in these cases it reaches into the arch code's rdt_resources_all[]
> array.
> 
> Once the filesystem parts of resctrl are moved to /fs/, this means it
> will need visibility of the architecture specific struct
> resctrl_hw_resource definition, and the array of all resources.
> All architectures would also need a r_resctrl member in this struct.
> 
> Instead, abstract this via a helper to allow architectures to do
> different things here. Move the level enum to the resctrl header and
> add a helper to retrieve the struct rdt_resource by 'rid'.
> 
> resctrl_arch_get_resource() should not return NULL for any value in
> the enum, it may instead return a dummy resource that is
> !alloc_enabled && !mon_enabled.

Nit.
You may want to drop the second half of the statement. We don't have a
dummy resource.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 10 +++++++++-
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    | 10 ----------
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  8 ++++----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 15 +++++++--------
>  include/linux/resctrl.h                   | 17 +++++++++++++++++
>  6 files changed, 38 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 83e40341583e..b773b3bdebe3 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -122,6 +122,14 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  	},
>  };
>  
> +struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
> +{
> +	if (l >= RDT_NUM_RESOURCES)
> +		return NULL;
> +
> +	return &rdt_resources_all[l].r_resctrl;
> +}
> +
>  /*
>   * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
>   * as they do not have CPUID enumeration support for Cache allocation.
> @@ -169,7 +177,7 @@ static inline void cache_alloc_hsw_probe(void)
>  bool is_mba_sc(struct rdt_resource *r)
>  {
>  	if (!r)
> -		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
> +		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>  
>  	/*
>  	 * The software controller support is only applicable to MBA resource.
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 7997b47743a2..788ac0395645 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -599,7 +599,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	domid = md.u.domid;
>  	evtid = md.u.evtid;
>  
> -	r = &rdt_resources_all[resid].r_resctrl;
> +	r = resctrl_arch_get_resource(resid);
>  	d = rdt_find_domain(r, domid, NULL);
>  	if (IS_ERR_OR_NULL(d)) {
>  		ret = -ENOENT;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c99f26ebe7a6..65990def6c79 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -466,16 +466,6 @@ extern struct rdt_hw_resource rdt_resources_all[];
>  extern struct rdtgroup rdtgroup_default;
>  extern struct dentry *debugfs_resctrl;
>  
> -enum resctrl_res_level {
> -	RDT_RESOURCE_L3,
> -	RDT_RESOURCE_L2,
> -	RDT_RESOURCE_MBA,
> -	RDT_RESOURCE_SMBA,
> -
> -	/* Must be the last */
> -	RDT_NUM_RESOURCES,
> -};
> -
>  static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c34a35ec0f03..06565153ceb2 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -321,7 +321,7 @@ static void limbo_release_entry(struct rmid_entry *entry)
>   */
>  void __check_limbo(struct rdt_domain *d, bool force_free)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
>  	u32 idx, cur_idx = 1;
> @@ -467,7 +467,7 @@ int alloc_rmid(u32 closid)
>  
>  static void add_rmid_to_limbo(struct rmid_entry *entry)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>  	struct rdt_domain *d;
>  	u32 idx;
>  
> @@ -669,7 +669,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  	if (!is_mbm_local_enabled())
>  		return;
>  
> -	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>  
>  	closid = rgrp->closid;
>  	rmid = rgrp->mon.rmid;
> @@ -839,7 +839,7 @@ void mbm_handle_overflow(struct work_struct *work)
>  	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		goto out_unlock;
>  
> -	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>  	d = container_of(work, struct rdt_domain, mbm_over.work);
>  
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1767c1affa60..45372b6a6215 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2253,7 +2253,7 @@ static void l2_qos_cfg_update(void *arg)
>  
>  static inline bool is_mba_linear(void)
>  {
> -	return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.delay_linear;
> +	return resctrl_arch_get_resource(RDT_RESOURCE_MBA)->membw.delay_linear;
>  }
>  
>  static int set_cache_qos_cfg(int level, bool enable)
> @@ -2341,7 +2341,7 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
>   */
>  static bool supports_mba_mbps(void)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>  
>  	return (is_mbm_local_enabled() &&
>  		r->alloc_capable && is_mba_linear());
> @@ -2353,7 +2353,7 @@ static bool supports_mba_mbps(void)
>   */
>  static int set_mba_sc(bool mba_sc)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>  	u32 num_closid = resctrl_arch_get_num_closid(r);
>  	struct rdt_domain *d;
>  	int i;
> @@ -2625,10 +2625,10 @@ static void schemata_list_destroy(void)
>  
>  static int rdt_get_tree(struct fs_context *fc)
>  {
> +	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);

Its is probably best to keep the resource name as r here to be consistent
with other changes.

>  	struct rdt_fs_context *ctx = rdt_fc2context(fc);
>  	unsigned long flags = RFTYPE_CTRL_BASE;
>  	struct rdt_domain *dom;
> -	struct rdt_resource *r;
>  	int ret;
>  
>  	cpus_read_lock();
> @@ -2701,8 +2701,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  		resctrl_mounted = true;
>  
>  	if (is_mbm_enabled()) {
> -		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -		list_for_each_entry(dom, &r->domains, list)
> +		list_for_each_entry(dom, &l3->domains, list)
>  			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
>  						   RESCTRL_PICK_ANY_CPU);
>  	}
> @@ -3878,7 +3877,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>  	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
>  		seq_puts(seq, ",cdpl2");
>  
> -	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
> +	if (is_mba_sc(resctrl_arch_get_resource(RDT_RESOURCE_MBA)))
>  		seq_puts(seq, ",mba_MBps");
>  
>  	if (resctrl_debug)
> @@ -4068,7 +4067,7 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
>  
>  void resctrl_offline_cpu(unsigned int cpu)
>  {
> -	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>  	struct rdtgroup *rdtgrp;
>  	struct rdt_domain *d;
>  
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index a365f67131ec..168cc9510069 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -36,6 +36,16 @@ enum resctrl_conf_type {
>  	CDP_DATA,
>  };
>  
> +enum resctrl_res_level {
> +	RDT_RESOURCE_L3,
> +	RDT_RESOURCE_L2,
> +	RDT_RESOURCE_MBA,
> +	RDT_RESOURCE_SMBA,
> +
> +	/* Must be the last */
> +	RDT_NUM_RESOURCES,
> +};
> +
>  #define CDP_NUM_TYPES	(CDP_DATA + 1)
>  
>  /*
> @@ -190,6 +200,13 @@ struct rdt_resource {
>  	bool			cdp_capable;
>  };
>  
> +/*
> + * Get the resource that exists at this level. If the level is not supported
> + * a dummy/not-capable resource can be returned. Levels >= RDT_NUM_RESOURCES
> + * will return NULL.
> + */
> +struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
> +
>  /**
>   * struct resctrl_schema - configuration abilities of a resource presented to
>   *			   user-space

-- 
Thanks
Babu Moger

