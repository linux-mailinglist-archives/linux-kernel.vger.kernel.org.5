Return-Path: <linux-kernel+bounces-73728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC49A85C902
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81591284BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A1C152DE8;
	Tue, 20 Feb 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1trGhlRm"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9347152DE0;
	Tue, 20 Feb 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464484; cv=fail; b=DLOEiZ0CAztU+nLfJLUfuvZQG291bZwQITUnW+UHV9x+XHljtBQwjCKOk2+uVsAJk5Zc8IBHzhMElsk/uztZKAs0YfMA0WYnZNIZWUskSv5HCD7fG+y7nARtfdSJJvB0Kzc5sBtZ6RZ26luka2pHCoz27rXJ2JAZPuOudTFpbtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464484; c=relaxed/simple;
	bh=RoVWWcBj4XcLL1V5wVzJ8Rvsu1vsRCLw0GhmoIh+Nb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GlSVX6JLa7YY1z8D4mjfqw8MRIFNliB3Zxv+67hgUHjsTV3s05EjdrRfW5zP0yeUsojJyyjYtgeB0VRhdNg+zebbZx2YKIJbajSayinXPO/iVc4newKZBcTEaChmRCENoKU6OmTusD9Pu/QW1688kflpR4BfHmw4B3+SCZwDKAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1trGhlRm; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNcimW5yU8uyr2bTaoIP3PdmiOtJUZDBc4i9RvOGdiAFOEn2RhlRG8ki+Rd5xX3FS2mX6DtTm96mH6KEVTe0bl1DBgJJXOPSTgdI4zzfztEdwbQcbh40l8QZNwUORqs0b2wsUGTzBFo8mwP5/o3D5ni9Rbye0j6107/XZ0PmN14GIcmF9CoYEVDm1Zc/JWYhnvbQo86kWIXYtDg8C/RPob+d+WYg4rv/lFtJBtO6fO0Mnyw0tX+yH0Uiyh0WyIbRmSQJpwbUPfF5MeqE7s8pCL/tqpofoFBXTeKyT2LY9b9jG76Zx+I/FbpNf9L1/UPV/F3xmnH2zFszIbMpHpH2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK6sVMkorVJvmo5yjEy7OFflpxsoAEA0eQzTKuMc60I=;
 b=f17YjNCMdleo1VDPLfrZ/lvbEdW8NjHoYmrehaUpqgV4EpTcvoucdZGGpjGkVK6L/EKI41VN8dJlRmWh4hVVKgE+Z9KE5a//ZkreR8iWNGgKNO1h2IwYo3aoP571WI2yG7jN3j2uyjxWxW4Mm03To7rSMYZb5LDT4JQCL/7VK8cZziicCgh4b43LoFWDE2L7Chy1KxFgXu50xZkli8mbtMixvepzjVxRUyZFf+ze5ozwb3wufACuspc1uqz/5OR3o+VwPHIlHjdi1yUZPoq3ST9WPcgWuj1JpAC4sCDkmosqnZgkpb9JWs+kh2UW9RuOcEUhPwYuCMTci+5zWe648Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK6sVMkorVJvmo5yjEy7OFflpxsoAEA0eQzTKuMc60I=;
 b=1trGhlRmNfYWqpsZTJoBn20uFc7+lF8QZo0dNnSggGHAlTYxIVrpzTu6uGN2H8t3oEBwEF9KRCTTvCBGPW4uDO8iG9TtnDhFAB9I1AAWuZzDVvjAoFKqO8K7q9/64i1Xzrl/oNQY5lXPQY4OM3LnxM2UfwHtvWHzregY9N5M20A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 21:28:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 21:28:00 +0000
Message-ID: <a3651bc5-55ba-44bf-aef7-503350c49760@amd.com>
Date: Tue, 20 Feb 2024 15:27:55 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 04/17] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
Content-Language: en-US
To: James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <bba869886410265ffac0250ba2a495e3e7576dfa.1705688539.git.babu.moger@amd.com>
 <50bd1168-5461-43de-9e64-cbe0019d571d@arm.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <50bd1168-5461-43de-9e64-cbe0019d571d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:806:a7::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ee007b-b2c2-4781-9b10-08dc325ad05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1GQZVYyhY2HzzWkGtiSjBDwMMhpAkS/J6eTZSD+vR/g3ikfN1QbMlYi6otBJj5Kehi+kZm2kvOXxOYKsS/CZfWmIOsEBM/Za5jFCotqGaqAJtWHVIQAOqMnb29gKSGEMKYocAre/DXEpXFCK9YMnoeokB8YjWrQRd3u1WgZd06KdvelA62CBIhHJAfsrZwKdedOyWG+HNTGtMLTUv1ysGZ5pDT7YFF3n71bhJbDl7QgQQVaS5iGtmfcD1K7zpTqRpODwIRoNZHLm0XK+vsPQXFfeW7JCJ15WJ6bXogiAWm8KdM20J1S3sT1EgO6AuNuClWFHY8pOZwL294PzvLERqYLp9zHmmIkA6FZm5dfbRoCgPfCFRtp9TXDlYwCzUuRs2FoWFWMTsge9JbY2q7ttpM20INASi8MKF9sWi6YOeKkPfzQ7299n5Oh/SH6i9lVEhgvm8OBSY6VCy7q0Y6graKd8nOm31RJsjrvu94JcSaTqWW1qSSWdNWhel0IDbnGtGIv6uFZKPXfOyCabibYiYdE7yPkOtN6YM6xtO6rO+7A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkRFL2tBcHkrVEZsZm5MbEtlVnJyditVejI1T04xZXFnb1RjMmpZU3YyT1ZH?=
 =?utf-8?B?YmkzcGsxVUtQbWFONVY2MnhrbFcwcmtDd1l1V3A2T3prZTBIZnJ1ZUt2UnJO?=
 =?utf-8?B?UEpWd3RUL0dhdHZtd251QmJJY0xIVHJTOGZUWnBNZFV5NWYwVFB0TEwyajNC?=
 =?utf-8?B?YkRCNWNQRVNTQmNIOUF4Rm9KUDRpNGR4NkRtTXZTbkVqa0J0bGFFWUhialNy?=
 =?utf-8?B?ZVhXWk5tYmJCakVLUVo2OTE2M0NRU243QnBTTk9VVG1MaHppRGErVERRemxu?=
 =?utf-8?B?QmZQVmVSb0dscVlQcUtOU0w3ZnlLNnJlRURleG9kN25UMGF6TENOK3NwR01q?=
 =?utf-8?B?dnJDeCtQaS9YMEtnbW9Yay82UFhmcFlmNDJCVDVDbktVeVl6Tmtpc3kxWmFy?=
 =?utf-8?B?RDFVbkowOVZUcWFpeks2UWJhZ29kMVlTOUxPRzRmU3ZYMnA3RDNDcGFEQ3Jl?=
 =?utf-8?B?V0k3V1VqRiszMFZCS2ZlM0RSMzNrNVdyeU5jNk1wbUF0NkhFSXFZekQwa2Rw?=
 =?utf-8?B?RjBXc3VQMWJBTlF1SEY2Mm9TdHZMUkVPaDFzZ0M4MUxobjNpbllFZXY4dTRj?=
 =?utf-8?B?REV1d3lpSUxpbDdOSnNKaW1VR21VbCtWRXM3WEJMOXdXa3NSQjcwUjFUN1M1?=
 =?utf-8?B?dHZBV2RnMlZ5a1V3QmRYVzFvYWRjRllUWXAyWTdsbmxWU2JMSGU5OU42aEpk?=
 =?utf-8?B?ZmRnZmhPWk50amV3KzVVK1VuNnQ3eG5kZGgrTHR4UDhkWEpHQTJmczI2cHdx?=
 =?utf-8?B?VVhhZWRlSVZyejBUSjdDZ1d2bXJRUnRlejUzV0FtNEQzNGN3Wm1HUGl6cVQ4?=
 =?utf-8?B?NU16Vi80ekRCMmNRZE9yZFJ1UmJCdmpsUnBQck4xWWFhOExoZEp2YVJrK3lM?=
 =?utf-8?B?RmE4dytyYko1Qi90ZHcvWk9TZG1SMHBsdzJnY29IcjdHZTNnVnphRzNEaGdp?=
 =?utf-8?B?c2dkK293SzdaTlRLYUpIOFdvdjg2UjZhSDMvbmEwbmMyTUI5OEo3Wk1pNUNI?=
 =?utf-8?B?U0xsKzhjV2Vha1gydzJNZnVEcXJ4WmVGdFpxb0dRVGx1L0RySnhUcWk3T2Fi?=
 =?utf-8?B?OHBWSjZ0OU05b3FKUm9LVGMrLys2dFdWVWVhVXpjRkVESWpNbTc2cG96RTgv?=
 =?utf-8?B?V3N3QkppdGV0RGQvU1ovV2diTjc0SUR0Vy81QUt6enhqemRDZU1ZaWFVVmdI?=
 =?utf-8?B?Y1hvbzJiZWpEQTNCOGVlb0YyUnRXUFVsRGhYdnhRc0lQUFVuTlFaMDcwTTlQ?=
 =?utf-8?B?UTFML1B6QnhUNis2MXZuK0RWUUhzM1lFN3FXL2NubUdyemNXVUI0ZWkzVWFU?=
 =?utf-8?B?OFkxeHA4N1piZThJTlRuT2QyRTNZMEhEUWppUHpUUDFNV25tRDU1K2xxQ2M2?=
 =?utf-8?B?K3NpVDZHTGpTdURia3FaNnM4bXpWQk5FaUxkQi9sOG44Z0kwY0RiWHo2a0Ny?=
 =?utf-8?B?R1NBN1ZjdHVqU2Nwem9vQkczMjk0Z0VabkYwTzBMMmMwNHpHVW10UU9tR1BT?=
 =?utf-8?B?YzN1RDlmVEhxc05wcjYyYm5takVGRDhBSk5vMUNvU2Z5ay8rdWNQOHF3S3hL?=
 =?utf-8?B?U2s5KzdDNlFleWxETEZZTlh0SnJkSkRrSFpnb1B5Vyt6YVhvN3ZiWklQeDFU?=
 =?utf-8?B?TUpTZzhYVnorUzZsWXN6MWpUQVJHMWlEdjV3MUs2K0xON25PYmF6SzZzcUZ4?=
 =?utf-8?B?Y29mekxRU1UwM1ZXZ0pNNW5kYnpCY0RXL0N0ZFdQVm9YUk55RlJtV2crSEZU?=
 =?utf-8?B?RSt2Sk5yRU42OXBPTmFPRk5Dc1B3dUxMTy9tcVRIOXlaZjRMajJXLytBRWFk?=
 =?utf-8?B?YUVrTFNqellKU2pva1hrSTY5VmxDZFJUNklqWVJ5d01kUTgyaDdzemJCUnBt?=
 =?utf-8?B?cUVtVHZSSVYzakZldWFEcnZNYWozUDRxMzMwdXYybGRCS1dQM1JaMzNtcCs5?=
 =?utf-8?B?Sk9hdWt6MHNBVFY0bjZmMkY1ZUNodkdSU1JhQk5QeDZQdU8xNVZFYzVoLzdC?=
 =?utf-8?B?WGdGR0F4MDUxSktQUjQ0TExUOWFjUWJBMnBzTHFBRmRQSkwxRXZPSzlINHNB?=
 =?utf-8?B?Mnc4MTA0alhROExtMEEvUFhBeERXaS9NRmlCMVE0U3JPSjhJVFJZZ1IrLzdP?=
 =?utf-8?Q?SKvU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ee007b-b2c2-4781-9b10-08dc325ad05f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 21:28:00.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9eYRQ2aH1N5L/3fX0xICHGciRHzcETJ3QduYt3QXz+nWAJNW3lpFvFUlvZtCCU8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

Hi James,

On 2/20/24 11:56, James Morse wrote:
> Hi Babu,
> 
> On 19/01/2024 18:22, Babu Moger wrote:
>> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
>> Bits Description
>> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>>      Monitoring Counter ID + 1
>>
>> Detect the feature details and update
>> /sys/fs/resctrl/info/L3_MON/mon_features.
>>
>> If the system supports Assignable Bandwidth Monitoring Counters (ABMC),
>> the output will have additional text.
>>  $ cat /sys/fs/resctrl/info/L3_MON/mon_features
>>    mbm_assign_capable
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 4efe2d6a9eb7..f40ee271a5c7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -303,6 +303,17 @@ static void rdt_get_cdp_l2_config(void)
>>  	rdt_get_cdp_config(RDT_RESOURCE_L2);
>>  }
>>  
>> +static void rdt_get_abmc_cfg(struct rdt_resource *r)
>> +{
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +	u32 eax, ebx, ecx, edx;
>> +
>> +	r->mbm_assign_capable = true;
>> +	/* Query CPUID_Fn80000020_EBX_x05 for number of ABMC counters */
>> +	cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
> 
>> +	hw_res->mbm_assignable_counters = (ebx & 0xFFFF) + 1;
> 
> Please put the mbm_assignable_counters field in struct rdt_resource. The filesystem code
> needs to access this to allocate/free counters and report how many are available.
> After all this gets split and the filesystem code moves to /fs/, the rdt_hw_resrouce
> structure is inaccessible to the filesystem code.

Ok. Sure.

> 
> 
>> +}
>> +
>>  static void
>>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
>>  {
>> @@ -815,6 +826,12 @@ static __init bool get_rdt_alloc_resources(void)
>>  	if (get_slow_mem_config())
>>  		ret = true;
>>  
>> +	if (rdt_cpu_has(X86_FEATURE_ABMC)) {
>> +		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +		rdt_get_abmc_cfg(r);
> 
>> +		ret = true;
> 
> Does it make sense to report rdt_alloc_capable if the SoC has ABMC, but nothing that can
> be configured?

Good catch. Will move it to get_rdt_mon_resources().
> 
> This code would probably make more sense in the get_rdt_mon_resources().

Sure.
> 
> 
>> +	}
>> +
>>  	return ret;
>>  }
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index a4f1aa15f0a2..01eb0522b42b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -391,6 +391,8 @@ struct rdt_parse_data {
>>   *			resctrl_arch_get_num_closid() to avoid confusion
>>   *			with struct resctrl_schema's property of the same name,
>>   *			which has been corrected for features like CDP.
> 
>> + * @mbm_assignable_counters:
>> + *			Maximum number of assignable ABMC counters
> 
> As above, please move this to struct rdt_resource. The 'hw' version becomes private to the
> arch code after the move to /fs//
> 
> 
>>   * @msr_base:		Base MSR address for CBMs
>>   * @msr_update:		Function pointer to update QOS MSRs
>>   * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
> 
> 
> Thanks,
> 
> James
> 

-- 
Thanks
Babu Moger

