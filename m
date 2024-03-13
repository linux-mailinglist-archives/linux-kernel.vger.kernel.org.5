Return-Path: <linux-kernel+bounces-101346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BC487A5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCBF282C14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105639ADE;
	Wed, 13 Mar 2024 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jUMygvwB"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED08387;
	Wed, 13 Mar 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325621; cv=fail; b=qceq7H9+rQJih5liOlFDIr1M2rTAtKDRR09oG8IbeMXHDO11+JJBcSzitoHLpPFh8mp+TymGx1PjhThxNm+Hc8Uv1vV7pd5v7C/LGuHdyVtS+RRM7lFYUoTjw6WjicH6wLNNDpSell3UN8jLLghM4AJ0e4POLNtZucwWuLoV+iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325621; c=relaxed/simple;
	bh=oKF01wXUo+KE8rNuQncUIvkT+AypCfIu9ehobK5aT4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QN+J/r0TBI5wNugn7vLPWeiCZrxlX0jSbPkrUZkvEHdpDnyabQPqQEKlrtea5S54Rg+3fZ+PaMQB4s+fOOPI5RqGUfiqjgCYsrJpAKaHKCtkOS4b8U0Sby0cjNRwSjVbesdEtFubXsAQmB8ACiZXODKm/ZULXwXxFse26e3L1kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jUMygvwB; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQ5gFS8zXR2RwxIx9qzcqzozsuE/VgpIUx2i/rmwKmOyUNhA/ny5GXjPOl1iwoFT1EOUtxnki47XhezeHQ5QjYNustnbdh++7wSeEgR07G7jXxdQ2hcewBFPkEVKGS86NZRL42mYgPSyAPmEDlc0slb2rdhU6C8RsD7x0Qc4BTk8XW7JP9PqiajZaaXba+i3gyUlTD9qusUHo5e4rKYS7Fuup1cn3RQrUbGl1V/2LbocP2rTHH6yXPEB8sldEyP252LadYeo/jlCT8MLHSxUMnhmDtBRFPbPhAr50ef8NDc1VvNA6eTN6o1aMhpxhZlGRzw34aCt/cK3dE/3G7PqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12eczx+x6eLMExeLGEBzsuAOv4ZLnaGTlwx3USMDf+4=;
 b=M/evedmpSnes7eYl7cIbJggMMXiW2StxhxGdMdMiZcFeEy/4612UV2Rq/GK6jrhZvRz+xMVvMsnXwz1qJC93zeWIMfu0Q1XPz2gb+qYJOMHxU0p5mkoNWLYEKxtbGA9YrGdrxeCJi0fpkWzxgycW816ZjHkEZzqnOFD+DJgOzUyuo70EI09YWtdHwLusVBwQwS8vS+w2rDGvOsDCMB+Dyp6MbDhxoFzDW3G05p/mFldWiUOihKMJtIVH9OreKc2mpso//Jk134YcVYTx1yuHlXKtPZ+C0UAtXfe+irvJD+cpThPhm3M5PVp4ah6DxUCBZhPtPwyOQFY4qXkMHpq5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12eczx+x6eLMExeLGEBzsuAOv4ZLnaGTlwx3USMDf+4=;
 b=jUMygvwBUGIUpQAk3BQkgvG9a0CiXsfMUFCRrZRWRnLIaUdB5oOXgne1Qw7u23ihVoF26mSxu8ZsRRaPAgzSmA75uzAjTCWIXcxUeBZM0S0b3vzKD4evoh3+f/Ru1aA0PpuxL2U6KacZ9sW7kDxvqTn/4PtsYAZFeFdaaMhW8rE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Wed, 13 Mar
 2024 10:26:56 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9dcb:30:4f52:82f5]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9dcb:30:4f52:82f5%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 10:26:56 +0000
Message-ID: <960ce5ba-a8b1-4db7-b76c-b97869c61f12@amd.com>
Date: Wed, 13 Mar 2024 15:56:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] perf/x86/amd/lbr: Use freeze based on availability
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
 bp@alien8.de, eranian@google.com, irogers@google.com,
 mario.limonciello@amd.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
References: <cover.1706526029.git.sandipan.das@amd.com>
 <12f378d5c9459e765c6c3a14b092e6f91da596e3.1706526029.git.sandipan.das@amd.com>
 <ZfF8sIol5xQcJM9F@gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <ZfF8sIol5xQcJM9F@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::20) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b704b5-6b27-4601-36e3-08dc43481b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pkFCNYE8xZSDR8tdM1u18ABJoFDcXEARTr4Q7rG6MVPdgQMKc1Z/FJ2NoL3WAo7v9Zp55aNOLmJiKzefZKE7E2HNtTxhll82tLVXI7n1dDI6VBfPznfD7O5+8FgB929Khgj4KF0EJaxSp1X3JEPXXjnxleqk69nlE7TUMZC55RwlnfLWQ1hvC84J4X8tYOEPRoVtfV8WHqS1zZsfd93YdEd/QCWRAzzP3fnEkz5zjRnNPzLyau7dUJWEu7G7+yroor0nS4TY0XcmcnLgJX8sm5II9tEFd2qLHFy73qjk2sRfQIUltA+s9Xo/zdhAzTO52ZAYEXbbyKXU6mXOAU3N6O15G9C0XvNLXW8KjaMCcvWGZ07fOnQExk09m2/lC/Awg+bn6i4DdbHBVcq/tdgoP6kjo8A00iAmZuKZn5uYkQeqB820w5sVCh1YhHkWg83WW3QobY1AtuQXviMShzrAI3l86qKHf6L+cKeny5O+xJA4MzcPtp+XWZWO9nxiN4BFvzBvI3Cbwr7lsCKfjbuC6X2pYe0kPL61gct5TkyrODnJfd3v8rPryk2Rd3H/iY1xOgLJa5mQUlthph2uTMgYHX3UMks22eMMoZi/BOV1m3dd2vs1ukrbChGpuhui/nN4OXTRmY+7Z0HRovGQTwhhUnEOs7x7tvj+qjLrJx00JC0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVdkYllWeW1IdGhERDQ4WUFXQWpnVVdVbmlBdDZKTndDTk42bXZyM3BEcUMy?=
 =?utf-8?B?SldIZUVMblBrWHR6TEprWE92UGNsTlowb1NxSGw2NXBYMGlWVGhxbGFJYkNG?=
 =?utf-8?B?aW1Cc3VRb0FtTlFxSWRrZ0dIclJiYXF1Z296WDZoMDhLU3Z6b2w4blNSNjd5?=
 =?utf-8?B?NTNjUUs5TjFEWHRFWG1iVHUvT1JLaUhjQzA3TDdsamVWeHlmK3h6SEJPTDlF?=
 =?utf-8?B?bGlIeWtjdmRxZ1FNLzBJdlB2Y243eThnbFgzRkpDU0tUckVySVoyZURObXU5?=
 =?utf-8?B?cFdUOEpPWm1iUWtjVWxPWFBzYXdRaFJ3NFVMd0d6K0xkRitzUUI5QjlVWkw5?=
 =?utf-8?B?UDZVRzBkQmR2MlMrVXlmZlpISHJDQUZiTklyeHRPV2g3MFcyNGZ4L2ZkN1ht?=
 =?utf-8?B?RkNDV1FVeHNGK1JVTVA1VGt3SFJrbEdyREUwREhRejVrZ1VISkxlbEVVR1J0?=
 =?utf-8?B?NTM5blo2QytJYkhPaVJUanlJUWJ3ZlpUMWtFcWYzd2crdUdBRWhna0lDcUx2?=
 =?utf-8?B?VkhjMGRCL1hwSlBqM3N2ODc0bk5QS01mRGNKdVJPK3lhd0ZLdVNEUFFwYTJU?=
 =?utf-8?B?djlSOWx1ZUdCVmxiZGxsVmxVekJCRW5hcTl3Tzd0dXBrd0x1Y0x0Yks3S0d2?=
 =?utf-8?B?YTFYY3A5UGg2VFdFL1ZIWEQrb3ZGTWFTdi9FRGxOSW9xUnJVeGhsbUxhRzNQ?=
 =?utf-8?B?L0htMnJIeTZvYklidlVIM004SWRHOGZ4MStXNHVJQzNSM3g2SWhiK3Q3QmtY?=
 =?utf-8?B?V0pCQzhOLyt5b2t5dnVOekdMeFQrdG9uNjh5dlZNR1ZnbjA1ZHZqekQ0S3lI?=
 =?utf-8?B?c296RFhnUFlteGdDZlIvOTFSNDBJdlJLVUsxRS9uQWoyNllBd2ZranhJUGJv?=
 =?utf-8?B?NVYraHpRZGpaTERtbUxtWVBTOXMxMU5nRWQ0ZTJZaTE0dnRicThQY0pDQXN3?=
 =?utf-8?B?bWZ2Y2JWckVmZ1YyWmVQQUg1cXRCR3RVdDIxK1RKZ2lUUjlvcUYrY0hMQlZB?=
 =?utf-8?B?R24yMFdhME5Hc3ViYmphbWpoeFdJRmg4akljSGl4Y2hZVVZ6UUdoNW5JUlZT?=
 =?utf-8?B?ZHBmSG1zV3gvV1hTaUI1TU5mblUvL0lXV2FyMVNQY3ZkdnlRQkhDREk3MUtW?=
 =?utf-8?B?NzB6UHlHTXVXYUo4RmppdEpBTlV2N25tTW0yL2VNUTZnQis1WWptSXpFMU5w?=
 =?utf-8?B?dVM1dTR5WjhDS3Fzd2tiaDZwZitnbmVKekJkbWVBc1ZkNTRkNUNyclBBYVps?=
 =?utf-8?B?TUMvNWwyQVhiSVE5bXJsSnQySkhqSktCQnB4M01NNEVCSE80eFdqbHJsWS9F?=
 =?utf-8?B?UHpoWGhrUDlvNFVZYkR0clNuaC90U2c1bHB3cDAybnl2b2YxQ0srNHpadUNG?=
 =?utf-8?B?dVFIVW9TeWtWWTcrOWp6YkVuSDB0RU9RM2NRRkIwYzg1dVNOZW1JNnExUkZu?=
 =?utf-8?B?QnhRUGVRMWJzN2FUZWpCUnNQWFRJYjI0UWtMdXJtVm84T3BtaE85MEF2eXcy?=
 =?utf-8?B?M29oNkZsM1NTVkFCcHpTQjVTbk05S3RaeW1Vc3ZmSVYyY2tVVHFveHFRbDE2?=
 =?utf-8?B?QkJBZk9pWVNkQzY4S3ZPN2huNGFyaDFzaFRseFlaM25TVnd6NTN0QU4ydDFH?=
 =?utf-8?B?eXd3WTdVOTA4eW9rdmZiQ29DM25KMExmQ0M1ZnNqYmtKRmJrN1FKckJlNE04?=
 =?utf-8?B?YXZNbVlPbDNMSW1CQ1UzU3dGaVplRHFESlZHNEorYVRhUXk1UXhRNE9KNzFY?=
 =?utf-8?B?NVIxMXdRd2FVb0FQc2luVjJSSGUxMDBuR2t5cFAvajhqdi9IOXlMTkxreVRG?=
 =?utf-8?B?RkhzY1l3UTNKblB0Y29MKzg5NVVmalE5clNnVW90Z0FzQ09EeHVvN2RCY2Uy?=
 =?utf-8?B?WnJpc2lKOEVBTlZiVEVROE1VQmhHN3l0NWZWaUd0aWNkY0hDU1FsT2Fpbndr?=
 =?utf-8?B?aDRWQUJuN05EMGVaNGNrYzF0K2pXN1MzRUlGcldqTlNlUTZrQ2NROHpZSk82?=
 =?utf-8?B?djBKWStoSkRDNXF6akM4L29uMUZUbHNXVjkxaXRFZWN4eTdnRlRkaStBZlB5?=
 =?utf-8?B?QkV6Zk85QnUxM2FRNW9WQnpjRklFQWwvVVZzcU9mdWlxRzhVd0xhSUtHVk5a?=
 =?utf-8?Q?pCPeDH/v1RV/qeF9LXTEbY/e3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b704b5-6b27-4601-36e3-08dc43481b95
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:26:56.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyIO84NFfg6c+xs/bgHRgV/xKe8QZniS3KPIVJcQPUKqhbhlp/TU6c4DW+twAhKMrjx+n7v8nk4CgzaKYQ86Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477

On 3/13/2024 3:45 PM, Ingo Molnar wrote:
> 
> * Sandipan Das <sandipan.das@amd.com> wrote:
> 
>> Currently, it is assumed that LBR Freeze is supported on all processors
>> which have CPUID leaf 0x80000022[EAX] bit 1 set. This is incorrect as
> 
> That's X86_FEATURE_AMD_LBR_V2, right? Should probably be mentioned in the 
> changelog.
> 

Yes. I'll add it to the changelog.

>> the feature availability is additionally dependent on CPUID leaf 
>> 0x80000022[EAX] bit 2 being set which may not be set for all Zen 4 
>> processors. Define a new feature bit for LBR and PMC freeze and set the 
>> freeze enable bit (FLBRI) in DebugCtl (MSR 0x1d9) conditionally.
> 
> What happens on such Zen 4 CPUs that don't support LBR Freeze? Does the CPU 
> just ignore it, or something worse?
> 

In this case, LBR ignores PMC overflows and the branch records keep getting
updated continuously as execution progresses.

>> It should still be possible to use LBR without freeze for profile-guided
>> optimization of user programs by using an user-only branch filter during
>> profiling. When the user-only filter is enabled, branches are no longer
>> recorded after the transition to CPL 0 upon PMI arrival. When branch
>> entries are read in the PMI handler, the branch stack does not change.
>>
>> E.g.
>>
>>   $ perf record -j any,u -e ex_ret_brn_tkn ./workload
>>
>> Since the feature bit is visible under flags in /proc/cpuinfo, it can be 
>> used to determine the feasibility of use-cases which require LBR Freeze 
>> to be supported by the hardware such as profile-guided optimization of 
>> kernels.
> 
> Sounds good to me.
> 
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 4af140cf5719..e47ea31b019d 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -97,7 +97,7 @@
>>  #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
>>  #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
>>  #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
>> -/* FREE, was #define X86_FEATURE_LFENCE_RDTSC		( 3*32+18) "" LFENCE synchronizes RDTSC */
>> +#define X86_FEATURE_AMD_LBR_PMC_FREEZE	( 3*32+18) /* AMD LBR and PMC Freeze */
>>  #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
>>  #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
>>  #define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */
> 
> Could you please port this to the latest upstream kernel? The 3*32+18 slot 
> is now used for another purpose, and we need to define a new synthethic 
> CPUID word, word 21 if I'm counting it right.
> 
> Don't forget to increase NCAPINTS from 21 to 22, and consider the fixed 
> asserts in the x86_bug_flags[] definitions in <asm/cpufeature.h>, and the 
> asserts in <asm/disabled-features.h> and <asm/required-features.h>. This 
> new word should probably be added in a separate preparatory patch.
> 

Sure. I'll rebase and send this along with the other changes.
Thanks for the review.

