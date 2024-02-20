Return-Path: <linux-kernel+bounces-73723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A952F85C8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF53284DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD138151CF4;
	Tue, 20 Feb 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R3q8U5+Z"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3FB151CD6;
	Tue, 20 Feb 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464247; cv=fail; b=E/+IlCDGQalgreKWt0B1p+PvK9eGznXVKFSrlF/EeZjwBiFSq0PeWgXpTEa3tDV53OGhXV8SJZJrmflfv4sUkb7H64XJBpEIxNnIQqeCeBnf7LxwwMfc9vwzaenHpqZAjHT5SkCXYqkP0zbntyI0CQPAWgurnh4AmLKVuKLybDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464247; c=relaxed/simple;
	bh=c78WLIhi26KuXf0+aMSfy0T+FDwgQ1xo0R8kf/6Bjyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FEkWI3K0Wr7FUgk5SzB9bd/uZ7KrkaGx5L3YLxl9+ov6L5OUefm7GVJOEbV3Fjgc+B1CqDntJwkjuFA3/d1Cfx/Wxd+h03TAxh1N3+6ETGjS34bTB64WUZUvpVJFlJVK554NiP+txtXekV0ILwPJygjaoS7Cy+RklH98CkcMXWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R3q8U5+Z; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6o2sO8iFJxAlnxskbqWWALJlSeXU1pEcgH8pKHsNQ0P7/pC1uXJRHqwwE76sa4tgvf4nLErVspZjl082Z1Rt7Xa1KEFoLD/3zmYue+QDD/kAt+0JzNsb5uR9JFSGkgRHB8zadst8CxE88xwtXTElyHstnQVQ44JI7XLvc7OhKyw6zMbbQCIapJ9kNkYUhWsbbQ7U6N4iBD2yCbybwH+lc8J1tQXIBReJLN1A4Ms30/Na8PUrtjwOwNRzsgyZaoFrN7MV1Zvapl2AaOeuzRvdwkzCyEg0aXvsXcm94UjBNx/maafMXo+b3vesDVGjot3PHBK7PnuHf8D2pgXEQA94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/WwrtRXVYok7ijd2MPeT0QDJTe4J+ubp9Zrv9S5zW4=;
 b=BVhySqHj9dz/P+JlVx76uXD2lB6b77aKOQvCy80CVgTog8p9Ts6Bge1e+751pwgHJ0de8UT1ukVSzOKm/uQ/+kzylGZPRP7FlWJPKIwZgDgkL9652oo4sVE6+4Wh+tOHfppGRDHFKOT7diij29lAlc8/1kZrSFOruOxlZhKYEjeXXfUlBS9igX0k+hRZUvDo+UTGjC61ggKUPoB6Q+7SXAFCcYp/btj+qIWzmF/gd2SLqUAaogqnKJplQkmNueZP+mvNCEvPP+Ocqt6ZiQJg2dEkxb+AAuxm2c2BVq8Cd8uwac/Z/G3PVw9W99oHF1Tbb4jCVyQvc7FO+8oXdH02tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/WwrtRXVYok7ijd2MPeT0QDJTe4J+ubp9Zrv9S5zW4=;
 b=R3q8U5+Zw49bGt2Zmxei+ApKW19cXioJ+CxH2o3mjIFU+iVdBaKpR+4jcgTcGd6ZJsnhbiS/WtOygXBDXQSzm5RyBhOTtQDQMrMlanM5wxEo9kydfD/T7jWQWuqmAFQfe96sD2dySY8Clq0yWsTtEo2WFJD70TwM2HhfJkQVsDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 21:24:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 21:24:03 +0000
Message-ID: <b3aae7f9-2a42-470d-a465-98555a58863e@amd.com>
Date: Tue, 20 Feb 2024 15:23:59 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 06/17] x86/resctrl: Introduce interface to display
 number of ABMC counters
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
 <c16cac16c813a203390229d77d5ab37ebc923d95.1705688539.git.babu.moger@amd.com>
 <5ad6f627-45c6-4c2b-b761-c74f0fe85f6c@arm.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5ad6f627-45c6-4c2b-b761-c74f0fe85f6c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0089.namprd12.prod.outlook.com
 (2603:10b6:802:21::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6934ffe4-d3ae-4338-8cd7-08dc325a42dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mgDGBG1ngkVKzlOHz3Mf2BdFcKIahfNBS91PaRljHPmwwAJnnrmIARFCaE8G56NRfWoZSprd7SV0XTuEh7+a1a6QYPxtV944bgfc4VSEIQSDMBhx1Tb+SDnTX055TBTsczp+L8CqkdO98ZoNCRKycVo0XYefzI0pSPb8jnRruZZdM6aAdFh57jdmBJvWMbl5Xw3ISHv8uP0Rx7GIzivCcFU+sgeUH5RhFo+ce2dIKfX+8TesauOqxmrZXnQVdR/hMRO7r054SJLGhqeRuURLWPbFRINZWLc0UOaxYYLeqYmuZU0EzM600XXFhXoWSOyOuCiezufDI6a4swb/V9XVuwHx4RFFnBdjaDh3P7u0go9VD1ANcT4llk6MCtNcaGaanaBiJKJurEKWAripp/swYq+2PEap9cEsEo1MGWz+x7PwzXdoO6z/f+Iu1Z9GAY5ocPfqPYVvp8QApQjwtAxYJbHMWVOoTmVOVZLOGwgv/jc+FbTxCvUffAjrl+hbCxZPthVRBixqFiRD3cDKeHJsOpU4T9sLDmAiko8N7RJTyxs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHZjYTZlbm5aWUdsU2l4NEFacVJyRTdYV2FmVHp1YjU0VlNrSEVKN2doaC9r?=
 =?utf-8?B?cm5vTHVNbkdWaWJsdGk2dG94NTI1S1FLREpMZmJoTmZzMUxTejhYQkVsVUc3?=
 =?utf-8?B?dDZ1cStjSHVKS0c4WWFXQ3BkN2FsV3ZtZmFFR2pIYzFCZkhpMklPNnptdW5x?=
 =?utf-8?B?dXJFb1ZEc2E1aGV2VG9FalAzaStPdE1XeXlnUVM1eTVRSXBIdGdLWEM1L2tU?=
 =?utf-8?B?emhxM1UwOFVXQm92R21YQ2dJaHJyVlhzUTFEc0NiZU5WT2E3blJsaWozR3BS?=
 =?utf-8?B?Q0RFMEhYWTNVeTFRcE9BV203a3JLVFBYSFZOc1VETDdKb1BDcjUrc09MenJS?=
 =?utf-8?B?YzVWWDNFU2FTbXZzTGQ4UnRENDdZTEJpWkU3OVhOQ1Boa2lGRWVCM1RlTFE3?=
 =?utf-8?B?ME5vQzU0dFB0KzVTODM4aHZuWXJyOHdNSW0reGFCaE41eStHMVg4SytBUi80?=
 =?utf-8?B?QXQrblFSZE9mR21sVTdEckxrVGpFcjBUdXZXT0hwRDQ2OHQrbmc2Y3ZHRUtR?=
 =?utf-8?B?QlorR0JtbjRnOTdsUFp4NzNydng2OGN5am8wUXNObHB5Smg0NVdoWEFDY3J4?=
 =?utf-8?B?QjFpclNZOHU3OEVoSnl3RUhYcUdwRXVkb0JqTkhJSUFKa3k3UnBEKzFTMDBu?=
 =?utf-8?B?L05ndDBNZjZ4eVhnTkxFWHRoeEJLNmxTdUFOVGZMOGNNRnpTMm5Uckw3RlNW?=
 =?utf-8?B?NU5IQUpZSjhiZ0lyck8yMDdSb1R2N2dRNi9Qa3JXNXhEUWZVZldCV2EzRml2?=
 =?utf-8?B?RlVsUjYrUUpqRnF6aDFQQWRpNXY3WUR1N0ovWldNQWFIbDBCb1llbWtpQWZy?=
 =?utf-8?B?UlRVWm1ob3B6N0ppbTVmNEowTFBheWdHeEpyV1U5RnZ6N3ZSU3F2bDRIcUsx?=
 =?utf-8?B?RG9MTUhENHRwZ05odDkrbTZaOUZGK2E2OWtEa25kRHpjRnVJZkEyVjA4UDRD?=
 =?utf-8?B?MnRzRWJINHMvcHFob0pIVlBScWFlb0RDQ2p0MW5TQ3BrSkdOejBVazFiMmRQ?=
 =?utf-8?B?SU1VYWloRnFnakxhVEk4WTFLakUzWkJqZ2dQQnVwZ1dDakgxSmlQR3Q5dlI0?=
 =?utf-8?B?VXE3UUlYSkRTUjNyQXNYVXZOOFhoNDhYVjAvRFowaGNmVEJFLzQvNWtuNlY1?=
 =?utf-8?B?bnRGQ1M1dTRRelBXM1RZRzNRblpXTnFnd2pZUXlYQkNJRWRESXFhS1RycWFS?=
 =?utf-8?B?a0YyeFVPWTJObVZhOFI3Qk1Ubm1vYjZobkRzSzVrZnIyemNPcytrSWQ5bmFj?=
 =?utf-8?B?M0Yzb0wxSzAvUWR1RzJNZDAzQU44c09sZ0Fld2lQSTBnK3VrdW5aOXMyL1Ji?=
 =?utf-8?B?dUZnNmJkSVplY0JLeHhFOWZPbkpRVmFBd2RGckZLYXFRM2hWM2hISUZYeDVC?=
 =?utf-8?B?OHpoQXhlZUtHQkhXbEdFcDNRaE1BVUNOL0YwaityZHNhYmx4bFJ5Sjd4Vjds?=
 =?utf-8?B?b2Jqc0NqWVFOMGpOQ2ZnUUhvRzlvMEZ2L3hadm5ZbG5mamhlbGVHc1RQVk5G?=
 =?utf-8?B?dVEycGorU29abERRdWwxL1VmcVB1U1R5eHhSVzNqSFpWWDVlbTUyT1lxMDZI?=
 =?utf-8?B?VEx2NndQZzhVUkdjTnRBS3B1VFJ1Q01NdEZ2Um5XT0VCRVRUbzJjVjkvWXBN?=
 =?utf-8?B?bzlUQ3pJSXA2VEsvWis2Vyt0N0ZyWnQvTzh5Snk4WmNLdHR5a0xrMERUaGFR?=
 =?utf-8?B?WjJ1d2VocmJVU044NGV2Q2Q1QkRqMmVBWHpKMXVhT0xiTU95Y0RVZWlxNkk4?=
 =?utf-8?B?L0FyeVZpcVNpMzJiNU9qSTFMbnFia3NudjdHaGk5ZEtFOEx4RitLdWhDc1hi?=
 =?utf-8?B?cytZMjBIL1JxaUljQ1dZaThNcnFqUENRa0c4VzRxUnJhYjdDZjR0WDh4SWhW?=
 =?utf-8?B?bEpONG5lcmR5Z3VBUjVtOWc3MjlKc05HZ1RaNkt1VlBLaFJaZFhYamFmNnN1?=
 =?utf-8?B?eGhrSklHR1lodGVJbVpUMndkc2ZzaHQ3QmJZTHhIK2Y4NmZjR3AyVjd1cXQv?=
 =?utf-8?B?VjFtbExOdEpuR1VxUjZyNEk0NmMxSmJiODJGMUxMWmxwR2NjV0VLZTQwcHI4?=
 =?utf-8?B?cC9lSGU2dzhnRFA4UU1UTVQvbkJCcExGcnk1YjRORE1hMi9NbTBiNFUvb2pN?=
 =?utf-8?Q?T3AY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6934ffe4-d3ae-4338-8cd7-08dc325a42dc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 21:24:03.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWZYdlX+UYpi0kkTr6FWGZiJeEk3J34dM6hh0QHfWo/tTFMABSlTx3YWmemRz98+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

Hi James,

On 2/20/24 12:14, James Morse wrote:
> Hi Babu,
> 
> On 19/01/2024 18:22, Babu Moger wrote:
>> The ABMC feature provides an option to the user to pin (or assign) the
>> RMID to the hardware counter and monitor the bandwidth for a longer
>> duration. There are only a limited number of hardware counters.
>>
>> Provide the interface to display the number of ABMC counters supported.
> 
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index a6c336b6de61..fa492ea820f0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -823,6 +823,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  			resctrl_file_fflags_init("mbm_local_bytes_config",
>>  						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>>  		}
>> +
> 
>> +		if (rdt_cpu_has(X86_FEATURE_ABMC))
> 
> Please put this in a header and calling it something like
> resctrl_arch_has_assignable_counters(). These X86 feature definition macros aren't
> available on other architectures!

Sure. Will do.

> 
> 
>> +			resctrl_file_fflags_init("mbm_assignable_counters",
>> +						 RFTYPE_MON_INFO);
>>  	}
>>  
>>  	l3_mon_evt_init(r);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 3e233251e7ed..53be5cd1c28e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -811,6 +811,17 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +static int rdtgroup_mbm_assignable_counters_show(struct kernfs_open_file *of,
>> +						 struct seq_file *s, void *v)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
> 
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> 
> (After the move out to /fs/ the resctrl_to_arch_res() macro is private to the arch code.
>  Needing to do this when providing a value to user-space is the indication that the value
>  should be in struct rdt_resource instead!)

Ok. Sure. Will

> 
> 
>> +	seq_printf(s, "%d\n", hw_res->mbm_assignable_counters);
>> +
>> +	return 0;
>> +}
>> +
>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>  
>>  /*
> 
> 
> Thanks,
> 
> James

-- 
Thanks
Babu Moger

