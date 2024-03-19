Return-Path: <linux-kernel+bounces-107394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D83887FBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C3F1C2215A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186C05474B;
	Tue, 19 Mar 2024 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JmypF+uO"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2130.outbound.protection.outlook.com [40.107.94.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4F1E498;
	Tue, 19 Mar 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844616; cv=fail; b=WWTJ0Dkl3ttRS21VicID4KFAiuJfpuO63KlC6gF8CyD89QiokZaXUBcUOHjmKHNwDyjsJ4JuKcNC9AIQohlXzIY04X/D96YlvZ0xl5PBLEkzFtPTEBj36UBMxU0KWzQAl9CQxx0nO08/oq54XgVfAJ+h4FL0PSHE1UEEOMrT3D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844616; c=relaxed/simple;
	bh=sBwy+nFsUrnUsTNxhXRNTkNUAQZ+sJTCUhZCr6/qdPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LrOKySUdWEJy02qMJikPhhp+UftgCW81C23TgstLzbq8ZZtzvaKhynPmx+UrQn+/nc8FgE9BmRDZ2gSJBu/3hpz6sEeMcul9NWMnSNdHPVZD+QgytaVETepC6V/P3KpDx/jJpc22ybFO8G219HHP5XKrdhoQmuM3CGTaRj8urh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JmypF+uO; arc=fail smtp.client-ip=40.107.94.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM4I4fQTMsdsnjPoElOuaUQQDrlDiAFcWtP6An3d7XTszEs8T64n4FQ4c21ssVEYNdSivh6WjDa62xTts+6FpOEUnoIUZQeiGcjzXBMjSoUn0/IbkowQnZrKCIOmGTrUZueXGu1Wb3zpkPTznUUUwp5Hw6qC+AsYpIF7TT8cSgbPKW0cendYkBfCRQSEXnM+K4cdk/aHGLtfVyrpFlAmvLvTDZJZ2GJLO2kuDLQSrMLNyxkZXUvHyQV9996KA99QF21lUgqN/ZamToxO0aIoLi8hxGipYiu6mDubj6WNCdjgk2i9C3zM21JKQiysxL65zDNkiI8chMhq+SNg0oSb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz43jIkMKiT10QP6Uh0f3lmSrSYzn3EiTzVd6GCIeB8=;
 b=Ds7S/5/IUKZYJUyT4NAruYLjSs9ksXox+zZm/neca/alvKe2ExBXNhV78bPYWTbgA3jEBQ5V/BH5jSEHMjJ5El5lsmGGVWf1ndAxaatVGvFXa8SrMKEr6R/bAUjtl91wozdYF0NrWQdGuT0WMKd++ZD2pxg9vfYF+h4AvJ6UhMCaRngIJx+pMT3cQEMjqVpNSZy4FDOqUCJ2Y2Y/frZPWdj0+awAhABm75AlMTYXFEU6zEyVJBOqqSOiMWtVGo1arzUIcFNlVI7ACNBONoKOBVCDqiTeIYysjf1HUQtAEjsadcUv/7QBNg0voBTlP+Pv62Se5M92GI6lCaBzRv+QCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz43jIkMKiT10QP6Uh0f3lmSrSYzn3EiTzVd6GCIeB8=;
 b=JmypF+uOHg6u1DQp+dj5f0B6+wII5JLk7efDiLsAAcRe5JhbI9fziAmUgt5v5p5/1g2a4tLoUzwn9PHKsGRX/iE923C+/tkafQV+BUI+O9SJKhPwZo068l1OZKDXcRI64q8oDD1tYSk8vyEx4SfrtCQyR/j9INWDgESi8Y7ZWFs=
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 10:36:51 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::6783:2c77:d369:41e8]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::6783:2c77:d369:41e8%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 10:36:51 +0000
Message-ID: <67908fc3-b8a9-4a05-a1ff-2e56be2a6568@amd.com>
Date: Tue, 19 Mar 2024 16:06:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] x86/cpufeatures: Add dedicated feature word for
 CPUID leaf 0x80000022[EAX]
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
 seanjc@google.com, pbonzini@redhat.com, eranian@google.com,
 irogers@google.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
References: <cover.1710836172.git.sandipan.das@amd.com>
 <846eebace0aea3a600b81b06bddd0024e5ac1350.1710836172.git.sandipan.das@amd.com>
 <ZflmU+H2Lt2I0VOq@gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <ZflmU+H2Lt2I0VOq@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::18) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|IA1PR12MB8077:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sXF3eO24IEtCjCm2dIuSSKtCe2W1N2rNAjXeBrmb6GvPjjajdzZgTy3OKwAkHJyci52hG87sPOlNpdNcJ7azftEQSUxsvgr0rKraGMYlgRpcBrsC5nRIIjTaZv3s1xjfyZbTXjqmlqyNAYvwUbAMBlsQvntBuFCkBKdAwFmrRt8Rd11eiDg/jv1bkUXKBDnebcK2T2+unNCAzEMxFFkORNx3HHUJ2Z8dJCuk1P7bEN7iPeMLAXoJ8ySg/o3+SQaEgXIiGHlIVsojzVko5V8k9VCCp8AcB8am7Tfc5KB5MvjrbLiKZAFTTMk8guMjFx/ubJlp4m5oVfVZw0FjrWHHFWoEat0lnXnuYtOfCwFUep9MB3GWhUJnvCUwJC3FQ59Y2keWjcFvt7F6dCTBTEcuFkf9MA1Fofg11CQ3bA934nOLICPO/L0vX59smdIB3QPVLSdZZDOdbShV9Z+d3FmEgA+7QSmHAwoDPeI1Fp5IwyyHZbuLBRFKFkqgat4lKSnhO6Knlvm7H5/aKWGyQR22FQW5vm8nBoWdPgp8FPiFE2wQVQlPXps1sQTgROOnzkxNtkiA51G/AKrOxQq4k5qWokdCqgFIZg7xt/esOPlyBK8JOV1VizKmzQpp1swaglGfRD4Kc0ElD8wsakjAzFAcIDUeGacFHDSCet/c5sXy7es=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rll2R0FvQ1FjalcrSUpaQjM1VXlZUnJoY0pVc3JvanFOVGdSdjBoZWlNR1NM?=
 =?utf-8?B?clNOUmxLV2xuMmhBelBZWTdJT1ZhTGhkVGJBdTc0SWludUhrYjJnajQ4K2hP?=
 =?utf-8?B?Y2RhZGQrL1hsTE5lN3VMM3lZdHc1S0J1VklZTVp6TmM2MGNvUUFQS3hRTkY1?=
 =?utf-8?B?MFJBMHNidlNyYUZDYTFOWlRuc29QNU96SmlYVUt4aTRhMDJ4L3gzTFlBZ0lo?=
 =?utf-8?B?YUFnQ25JTTNGblBmbTRYbUJvZFJVL0JNR1MzQjdxS1VzcnFPR2QycU5makZw?=
 =?utf-8?B?MUovOW56eGVjQ2Q0UmpWYnFmZUFzOFMvYUtXTEZvaWJJZlFZWWV5N01WWUJl?=
 =?utf-8?B?UzkrVkJGeXhBeFJ0VjkrcWluUG03LzlMWVlmOEF2cEVtTzQ3ck05Tkh3NWxv?=
 =?utf-8?B?d2dvR3VZcDFKRnN5ekJ1V0xuSWZRUGxuY3YwUFpIMml3WjMrVm5wSzFkdy8z?=
 =?utf-8?B?NWVsSjNrc1NOYW8xVHFqeFI0bHRadkZRTU8xN1Fzb3Bob0ZmaHEvK0E2SEdK?=
 =?utf-8?B?K3RDUndIWS9vMFNxYVJqZ0ZNMXR2WlB6SlVtbG9FWlMyQ0hVWmlNaitEOTNy?=
 =?utf-8?B?b3RMS29JZzdseFRUYm5YZEtHdGVPVHc2YjQxcGpLTEszMytrMEdlSHVSVlBt?=
 =?utf-8?B?bDZrSGpXVWlSamlCczZRKy9YYTJkcGhnYXYxWVNkN0pZQ2NXQ2tsQWlWTlFU?=
 =?utf-8?B?b0Jvd3NSemhYbnNiWmw3Rm9kbzdnZkNYOTFiNEhNbkt5UmE3U2VIbkdqQjUz?=
 =?utf-8?B?RlZnVjNkNG9oNnl2dnRubUw5dFN5Q2hzUlprRUhIWXVFbUx3S3hCWDdWbE5r?=
 =?utf-8?B?VkoycFcwMnpRdkpJcmFpdkt3Q2YzRFRmK1d4K0FQOVhUSXFsbEFnWWY0cWp2?=
 =?utf-8?B?T0lFcUVkMUxHSHRXOXdrdFhVc09PU1JzbHpyOFNYWWFJL244ZER4bFhPYVNL?=
 =?utf-8?B?SDduWUdNME4vMG5zNSs0bEV4TFdjUGtPMExTR3cyMFkyMkxxVno0U2pta3pK?=
 =?utf-8?B?dk8ydkYzNnJkb0ZzYm5nQmZPTUV3VFg1UFo3QkZ0SWI5MTY5a3M1cWZ6QkQx?=
 =?utf-8?B?QWFVYXpBYkYwZFppVUE2NXNJWGFoZnBDODJkenZmNEJkclNXOUdJTUltRFFZ?=
 =?utf-8?B?aEpOSzY5VSt3M3J5NVljYlRHSDdObENwNmd5UWxLakxQUFB4UTZOSkpsWWo5?=
 =?utf-8?B?UjFRc0M4RDJmdzdINEtNRU42R2pLUkVVek9qd2F2K0dnbjJxTk16bFV4dXdt?=
 =?utf-8?B?d1dpZy91SGQ5cmtrZ1YvVXRReVRENENnYXRqdEFTcll3cE5ENysyNGFLYmhr?=
 =?utf-8?B?Y3grUmRJRE54VUFFOGZ3Q3NKNkh5Tjlyd3pWN2lsaDhheFFrQWU5T3hlY09W?=
 =?utf-8?B?V1QzSEFqWkhKbjZETm1RcElKUGZoaWZUNHVZQkd6K215R29MRzJ4ckMvWjN4?=
 =?utf-8?B?NUI1VnBFWndRTWVYVTFtdTlId200WmRxVVlSYkVnYkprd2M2dldEZ1o5bC9X?=
 =?utf-8?B?c1A2M2xsc0VBbTZsU0cvMUlQWndTcUJKUTRTVTFEenVCeXk5dmoybk9mY3Y0?=
 =?utf-8?B?UWY1c1licVVlMEdMM3VQTGNIOHM0TkZHbldFQ0U0WWhFVzBSU214ME1HSkhO?=
 =?utf-8?B?UnloeG51MFIvcjFnZmpZcWtiQWtLVXlQWkVxZmNCZURZNFZ4UW5qemd3Ni9B?=
 =?utf-8?B?RndVV0luMHVhcGszcWcwK1BaVGV5REh1RnBCZEhWRXRDNnIvQkVvZWNWRlFD?=
 =?utf-8?B?NURWZ0VZSTd5RG43ZXNJWHZmaUt2QTRCTVNaaVFnZEp4VFJJNFFwYXRIZU1q?=
 =?utf-8?B?RkhwMU5yOEpveWlLT3NTOXJrYVZOSk1IQmdhRit4aGQwME5BTG5rUXpUdzlD?=
 =?utf-8?B?VnRHc2ZaekUvOGNHcnU2ODUwdWM1c2I0Mm1EUE84REJWVHF0TWZRcGVyU2tR?=
 =?utf-8?B?Q0Jvb0gyY1NxYnNXa0JhZjZPRDA5Rjd0M2t0L3NRRWIvZ2lTM09ZT1J1VVZm?=
 =?utf-8?B?SHRzRlZxN3BNR01FZFNyZjg2bHZMVzN2STRsNUFkVEpsN1Q3emVZOTNJMjNn?=
 =?utf-8?B?aFpJbk5vZXhoU0RKZGxlRDBKL2FWc1BGK3pyMWpBSzBudUJKR1h4dmZTenQ4?=
 =?utf-8?Q?gHAYsK7XcCQ+O8GO0+4G/UENV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95e03eb-a194-4fd1-c383-08dc48007d03
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 10:36:51.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hy6FqBL22gCJPjXDQGa8H/cJd3dfiB7FBhYos3rb5Zl8lWijYPN4+RTajjp2uV5/e9XBwUy8ArOqmOTOFQpWcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077

On 3/19/2024 3:47 PM, Ingo Molnar wrote:
> 
> * Sandipan Das <sandipan.das@amd.com> wrote:
> 
>> Move the existing scattered performance monitoring related feature bits
>> from CPUID leaf 0x80000022[EAX] into a dedicated word since additional
>> bits will be defined from the same leaf in the future. This includes
>> X86_FEATURE_PERFMON_V2 and X86_FEATURE_AMD_LBR_V2.
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  arch/x86/include/asm/cpufeature.h        |  7 +++++--
>>  arch/x86/include/asm/cpufeatures.h       | 10 +++++++---
>>  arch/x86/include/asm/disabled-features.h |  3 ++-
>>  arch/x86/include/asm/required-features.h |  3 ++-
>>  arch/x86/kernel/cpu/common.c             |  3 +++
>>  arch/x86/kernel/cpu/scattered.c          |  2 --
>>  arch/x86/kvm/cpuid.c                     |  5 +----
>>  arch/x86/kvm/reverse_cpuid.h             |  1 -
>>  8 files changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
>> index a1273698fc43..68dd27d60748 100644
>> --- a/arch/x86/include/asm/cpufeature.h
>> +++ b/arch/x86/include/asm/cpufeature.h
>> @@ -33,6 +33,7 @@ enum cpuid_leafs
>>  	CPUID_7_EDX,
>>  	CPUID_8000_001F_EAX,
>>  	CPUID_8000_0021_EAX,
>> +	CPUID_8000_0022_EAX,
> 
>>  #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
>>  #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
>>  #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
>> -#define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
>> +/* FREE!				( 3*32+17) */
>>  #define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* "" Clear CPU buffers using VERW */
>>  #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
>>  #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
>> @@ -209,7 +209,7 @@
>>  #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
>>  #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
>>  #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
>> -#define X86_FEATURE_PERFMON_V2		( 7*32+20) /* AMD Performance Monitoring Version 2 */
>> +/* FREE!				( 7*32+20) */
>>  #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
>>  #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
>>  #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
>> @@ -459,6 +459,10 @@
>>  #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
>>  #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
>>  
>> +/* AMD-defined performance monitoring features, CPUID level 0x80000022 (EAX), word 21 */
>> +#define X86_FEATURE_PERFMON_V2		(21*32+ 0) /* AMD Performance Monitoring Version 2 */
>> +#define X86_FEATURE_AMD_LBR_V2		(21*32+ 1) /* AMD Last Branch Record Extension Version 2 */
> 
> Thank you! I presume you tested both patches on the relevant system 
> with the X86_FEATURE_AMD_LBR_PMC_FREEZE bug?
> 

Yes, I tested them on systems which don't support freeze.

When kernel branches are captured on such systems, the records mostly
point to amd_pmu_lbr_read() and native_read_msr() which are called to
read the branch record MSRs. This is the expected result since LBR
does not stop recording branches after a PMC overflow.

E.g.

# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 190K of event 'ex_ret_brn_tkn'
# Event count (approx.): 190144
#
# Overhead  Command  Source Shared Object  Source Symbol                Target Symbol                Basic Block Cycles
# ........  .......  ....................  ...........................  ...........................  ..................
#
    24.98%  branchy  [kernel.kallsyms]     [k] amd_pmu_lbr_read         [k] amd_pmu_lbr_read         -
    12.49%  branchy  [kernel.kallsyms]     [k] amd_pmu_lbr_read         [k] native_read_msr          -
    12.49%  branchy  [kernel.kallsyms]     [k] native_read_msr          [k] native_read_msr          -
    12.49%  branchy  [kernel.kallsyms]     [k] srso_alias_safe_ret      [k] amd_pmu_lbr_read         -
    12.49%  branchy  [kernel.kallsyms]     [k] srso_alias_safe_ret      [k] srso_alias_safe_ret      -
    12.49%  branchy  [kernel.kallsyms]     [k] srso_alias_return_thunk  [k] srso_alias_return_thunk  -
     6.25%  branchy  [kernel.kallsyms]     [k] native_read_msr          [k] srso_alias_return_thunk  -
     6.25%  branchy  [kernel.kallsyms]     [k] srso_alias_return_thunk  [k] srso_alias_safe_ret      -
     0.02%  perf-ex  [kernel.kallsyms]     [k] amd_pmu_lbr_read         [k] amd_pmu_lbr_read         -
     0.01%  perf-ex  [kernel.kallsyms]     [k] amd_pmu_lbr_read         [k] native_read_msr          -
     0.01%  perf-ex  [kernel.kallsyms]     [k] native_read_msr          [k] native_read_msr          -
     0.01%  perf-ex  [kernel.kallsyms]     [k] srso_alias_safe_ret      [k] amd_pmu_lbr_read         -
     0.01%  perf-ex  [kernel.kallsyms]     [k] srso_alias_safe_ret      [k] srso_alias_safe_ret      -
     0.01%  perf-ex  [kernel.kallsyms]     [k] srso_alias_return_thunk  [k] srso_alias_return_thunk  -
     0.00%  perf-ex  [kernel.kallsyms]     [k] native_read_msr          [k] srso_alias_return_thunk  -
     0.00%  perf-ex  [kernel.kallsyms]     [k] srso_alias_return_thunk  [k] srso_alias_safe_ret      -



