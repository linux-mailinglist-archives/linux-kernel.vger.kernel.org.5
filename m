Return-Path: <linux-kernel+bounces-118394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B898688BA23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC8B1F3B4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FB012AAE4;
	Tue, 26 Mar 2024 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gRzdywb4"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1956823C7;
	Tue, 26 Mar 2024 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432977; cv=fail; b=mEZE/8nhvPhRS1UWVYPOOC18e+t8OtcNMdsz40KJ95+d0Y5CbZyJ51yP9LhPGpxqY/h/daLP2rdqGY4vwrCHIYhN8RjYuDCGzKe5IkqE0KyaMEUcVyBAOYelglfEYFZ38Yj8f6Du0X6gOvU3zbKulqlNghC6tjN+cB3XuK1hkPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432977; c=relaxed/simple;
	bh=S4ve10E+hznKi2KSgXbvrkfcd4csYrVgDE3shJGr6aw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jhNGe36N59FU9nCHWLX5CMzREMq6DMGO6bVQ76UOAZQ1ZvxCuD3fwOsThAdwac7xmd/nWFoy4oSXYhVrRxp/RdSMaQVAvsg6EqPj0UbCD2ZyYbNmk3UcC4sythMEmJxyTkar8DzOkGqYn/SEctsb0gXMjHiNx0Rfp7GkxCEMG3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gRzdywb4; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOTz7wdfAGEPa39GgeDomrgB2CBBVYO/4pOR/F14xfYCJRy60KJDjv29xcpwptL3RUHpek7Bfk7kbZNKGcwY1EE2957FeL61DohBpoCXnsXHqKv6S0zEeJoCvyNM99ysLumA5H0Ds3Ojdf/ZAwEWaiGadKsK6hDyQDif1e0Rnvu8ghcinimRetWQf52bJgvcGl+6LQSu4D+HLDQM1bJloqTtmXtgyUVxFNULY2tqP8gZV8nyQoce7X++VcPGeKV1T6TqUAXicLE989a3AwStgOk0Us6fcKzoYZBaSIMXM3bP8mTQxGdenIlLpxxQwMF00UaldcWm6MFp/k3UIcM9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b549lvw/sPsl133FqS7uXelyKGK7+k2/2iAp7rjKad0=;
 b=Bg2tAi05PmGnqg7qeGWYP3SOCF5/RshJrvHQjDk4V06NsNlckZ3JmN1MslbBS96cpuBPSHMImpNtQcwSulHuZp96JnCxB/pi2uyXejYm5g72vokhD/IJ1ENmDfGw1oj/c0dZLkszBXHEObgU6v42+SeZBmM6egqToR47Gq5Hceg4WOUPxW3lcmDaytbzj7enXgbf3LTJQKlGtQV6i6yKfqMl8AIgd0nL56E4KVMCMAyFIKc69fRyHrsY2u9YAumCTJ69kJVkk7/zlTPFpNC3g9Trssz8fnJ601SKtNsDgB+2lArH8Rx6xB2t9vKW2n1HG/05r4WEK/PmtTPie3weCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b549lvw/sPsl133FqS7uXelyKGK7+k2/2iAp7rjKad0=;
 b=gRzdywb4VP0NNOFXgHcLnPgpD8tuOZTuQKAzBq2E9RXTUivGnNrX7zceBTAdq1mC4ru4ZSjFYFlJEw81EKPmAkT+RAWWqrn6aTCVMXPER8YlSnMQVtn3lxsL/LThDLBycVHQtLnaaPqgn0QSW1CPOeIsFjPrLtEe30dhazJqTOc=
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 06:02:53 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2716:d557:4236:8f0f]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2716:d557:4236:8f0f%6]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 06:02:52 +0000
Message-ID: <5749c648-b6c4-4400-9628-3cd38d953f58@amd.com>
Date: Tue, 26 Mar 2024 11:32:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/amd/core: Update stalled-cycles-* events for
 Zen 2 and later
To: Ian Rogers <irogers@google.com>, mingo@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
 eranian@google.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
References: <cover.1711352180.git.sandipan.das@amd.com>
 <03d7fc8fa2a28f9be732116009025bdec1b3ec97.1711352180.git.sandipan.das@amd.com>
 <CAP-5=fVLWMnT4TV2nvbOUTTkWHYowbEOFDYqAvf1hkUEDpkKfw@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fVLWMnT4TV2nvbOUTTkWHYowbEOFDYqAvf1hkUEDpkKfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::8) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|IA1PR12MB6065:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OHuJ2U0LVYbVHbzyQ9cLwqtO8MSmLJph8Y6SOrM2pXcC2gIYg2uElfQM8nf7MDgQRAd3b5pbZ0SVyK0Y64pUKMorNhd69WWGDUtX/sXACRv4cRtcRpAGH9eJYsEsLOsFFI8mL2BSn7ZosTHc7G3eDuKYh62k+nPaEBi19ExA8ic+dZc9Ds8j0Rw1x3xWZh8ce0LDMRLgTZRhbt3I3L/dG2t86vr5qQ/8gn3mIK9jd0rNqI+H+Yra4RYOBCRROduYgoB7oZOSIGVPEk73pRkuOLu2iAOWHmOJf7Fhs7OJkGnqCyJtK3KTqsrapMkLv6hilO7T0BCl1ZKXeAsdmzQlu5+zcjMF+VitYQqrZWpSQ2JDNYhPdn8eBhyzZBiHTFOlcdXB/z1eJizGMJcqDtYSbeamIO0onCHosCV5qtnLZoavXrNoCcDeyBL2ahP9A/nq1J8Dukw55nzyQZtxEO1CKTCcz3qtXQHPtPSNr7fjcpZAGVLHXyhTKpDMObFB1/g381tSrvL7T3zwkGvYz1o+sCWrDzhaQ/7IaOr79yJHV5IlP34czDfJEShyInwfuqoPnN4XAgUJ1aUYnI5v77/3wH99GNalW54fK5WdYt76AJnTIUxGGe1uWPGMjjBghZgA8TOasBPsnytxld9At2K9lPdRatQ0wtbDytAm3sQIDK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDBEMmM3a2hXdk5NYjl5NGFsTVB4a3ZMMnFld0NkTnpQQzZUeGlPMjVveW5O?=
 =?utf-8?B?bUJFbVhJUlpPdGd4QkZ1OGlHbkpPR1ZvSVpGb2UrT2RjOGdXOWFpdkhwbVp0?=
 =?utf-8?B?ZzJ4ZjZBVUo4WVh3S291dUZFdldlNFpjZ1g5MW1taTgvaXIwbmZEOE8zVHVK?=
 =?utf-8?B?STVnMlRsbzdSbStPd3h0RmJBQW8wTG5BRHRyaEVvSUxDUUxNUDVNenBkWkZM?=
 =?utf-8?B?U21vRU5zZWlOUmQwdDZsYm5kaER3WEpGdEtTQkNRSHlkQnFya0orc0FhekNJ?=
 =?utf-8?B?K25BTDRyRFpLeVFFSXorY2pEL2FyWjlGTHpzbjlSdGNsNjZIOGRKanhXVFFw?=
 =?utf-8?B?MmJvV0thK0VJczh6UURySHErSUoxMmx1czZFUkRSdlJ3TVpkaFduR3FQUTd1?=
 =?utf-8?B?M3Fib3IvMGdzbEFwekhKR0lMU2xJdlRQeFRGWXZvWGhMcXlDa2ZQMWtHUC9Y?=
 =?utf-8?B?UzdEQ3c3T2FsREpjK2FpRG1MT1ovN0EvZXNuM0xPU2IzZmJqdEJHUURnMHJr?=
 =?utf-8?B?RDBCbVFOVFpOemErbUhYUmtNdnFUOG9nM3JJODJOMS9FWmVOa1ZjVHdERUl2?=
 =?utf-8?B?cmw2czFIUll6Z2Y1YzlqZ09sdU1Kb1RLMDNCOU13aWY1dS9wWDlON3NuKzlO?=
 =?utf-8?B?S2lKWXVUYmpmVDNBR2gwS0MvNURDdG11b0wwTURWa3BCSTJvdGx6OVRFM2J5?=
 =?utf-8?B?dEFTRElmSDNpV1dwbHkyL1ozbGpoanFvOTZLc1lDbXZRM2draktoWUVuV3VL?=
 =?utf-8?B?ODFPTk9OZkJRejFISS82MllBYWxuQ2NFYTJrU0RsZ1diOEdaZFhxQjJib0Fs?=
 =?utf-8?B?dTBTVXZRUmZXaGJEVjl0M1g4WWZKL0VOcWxHT2hMdnl6OXpiRDJiZk5CRWdV?=
 =?utf-8?B?Z3JVWG1oeVZWYkcvTmpzQXQ0NTRyaWsyRUZ2Z1dDbmRzSFBLWHFTWEtETCt1?=
 =?utf-8?B?aDUwNHhHZEhKR3VtRm5TT3NDN3Vwb1ZibkNRMGNsNjZPSVJ2UW9aL2w1Wm5B?=
 =?utf-8?B?Vm16ZnNxWWlzZENRSU5QcUxlUmNPM2Z1dFpFREFVOFpZZHpQc3Exd0ZYOXBS?=
 =?utf-8?B?NkhmZGxLMXkyQWdHcitZaGdNd3VuM1RKUlZ3SnRPQytWUVhuOUlIY2xZbk9y?=
 =?utf-8?B?eHQ2RWloRjgrbG1IUjRZUHpDeTZ5VHJRMisxQ3pwTEJHaEZNY1JrSmJHZnhW?=
 =?utf-8?B?YTRWaWkzVm9FSzJWaWs4VSt3Mzk1c2hkZXNUVHJsb3dFb1ZpNldnNGc3clFE?=
 =?utf-8?B?YXk5ZTJmSHVMZGdoU0F3TElMSTdnMkF2REJqdklxZW4zTFpXQThPak5CbitC?=
 =?utf-8?B?dmVUMVB0SFFkV0JDVzBTOHdCaGxJWlNKWmtEZlZZdE5ZamtjMjQxUlRZSkpy?=
 =?utf-8?B?SkVBME8rRXIrU1dxRnlVOXRlSkRTOC9GWDh0aW15OURKaFMyL0JNYkRQMkth?=
 =?utf-8?B?eGkxMm93SEw2bzJaOUIxRXhEajFTWkhXcE5HQ0FHODZWb3VNbStiMnJnQkF4?=
 =?utf-8?B?bVFtOFhvZ1diNTY5d3d2ZFVMT0pYMTNxVExMcUwyUFUvK25uNVZSSlVjRFZr?=
 =?utf-8?B?c1prWEErMWdYaHN0VWNpcEtCaVl5UDJNbllXZFhXems5MlNMMkxsQjI5V0RI?=
 =?utf-8?B?VERjQjFXUEkvbTBMb21NV0hkUHFLcUkxTzlBeDljcUlUeXNQRUZISWNwcjNa?=
 =?utf-8?B?MG9ZMER4eHR0TllGZVlqcVFPRkJmNnlxZSt1cXZTTkdTMWl4WDVHamhTOWF1?=
 =?utf-8?B?WHBYYnVQemhjSXFpZGdPOXFNdnFvQWF3c2p4WE5rZWxmTDFrek5zbGJXaVhL?=
 =?utf-8?B?Zm5jeGhMV09iU21IMFNza0x4ekRwbzdjNGtqTU1ZSFVMdzliTkEyUmJFR0U1?=
 =?utf-8?B?WUlBQ2JUZXdmMEMyZE15ZDJBOFIwMStId2hXT0pXYlAyMVh0aVlMVUQ4Sks0?=
 =?utf-8?B?UlVzQk9iclU5VkdNbm9CRExpTWNYa3liKzZPK0pCMnlZRHBIUCtCdHB2aytn?=
 =?utf-8?B?NDQyYW10ZnpWVXNmK21vRXp1N1M5endDZlJqeDdHUlpBRVl0OVRwRVg2Zk9F?=
 =?utf-8?B?OUlaTy9mSnZOUjJrQklDQVZ5QTNrRUFVbHZDS1lMR3hSRDV2V1g4dXVwc0Yy?=
 =?utf-8?Q?EvxCmCOMouABuWPVtAuAcRBvV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61586faf-5269-4b54-69b4-08dc4d5a5f82
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 06:02:52.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c31M8OAQhX+chM+AQeAHU79NyPjh1Otfppmtvncb5VM4mKnoqhemr5m0lt08G+kHcMm6lw/mwbjqR/F6Xv+9WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065

On 3/25/2024 8:04 PM, Ian Rogers wrote:
> On Mon, Mar 25, 2024 at 12:48 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> AMD processors based on Zen 2 and later microarchitectures do not
>> support PMCx087 (instruction pipe stalls) which is used as the backing
>> event for "stalled-cycles-frontend" and "stalled-cycles-backend". Use
>> PMCx0A9 (cycles where micro-op queue is empty) instead to count frontend
>> stalls and remove the entry for backend stalls since there is no direct
>> replacement.
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> 
> This looks good to me. Should there be a Fixes tag for the sake of backports?
> 

My bad. Yes, there should a fixes tag.

Fixes: 3fe3331bb285 ("perf/x86/amd: Add event map for AMD Family 17h")

Ingo, I see that you have already pushed this to the perf/urgent branch.
Should I send a v2?

> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
>> ---
>>  arch/x86/events/amd/core.c | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>> index aec16e581f5b..afe4a809f2ed 100644
>> --- a/arch/x86/events/amd/core.c
>> +++ b/arch/x86/events/amd/core.c
>> @@ -250,7 +250,7 @@ static const u64 amd_perfmon_event_map[PERF_COUNT_HW_MAX] =
>>  /*
>>   * AMD Performance Monitor Family 17h and later:
>>   */
>> -static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
>> +static const u64 amd_zen1_perfmon_event_map[PERF_COUNT_HW_MAX] =
>>  {
>>         [PERF_COUNT_HW_CPU_CYCLES]              = 0x0076,
>>         [PERF_COUNT_HW_INSTRUCTIONS]            = 0x00c0,
>> @@ -262,10 +262,24 @@ static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
>>         [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]  = 0x0187,
>>  };
>>
>> +static const u64 amd_zen2_perfmon_event_map[PERF_COUNT_HW_MAX] =
>> +{
>> +       [PERF_COUNT_HW_CPU_CYCLES]              = 0x0076,
>> +       [PERF_COUNT_HW_INSTRUCTIONS]            = 0x00c0,
>> +       [PERF_COUNT_HW_CACHE_REFERENCES]        = 0xff60,
>> +       [PERF_COUNT_HW_CACHE_MISSES]            = 0x0964,
>> +       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = 0x00c2,
>> +       [PERF_COUNT_HW_BRANCH_MISSES]           = 0x00c3,
>> +       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x00a9,
>> +};
>> +
>>  static u64 amd_pmu_event_map(int hw_event)
>>  {
>> -       if (boot_cpu_data.x86 >= 0x17)
>> -               return amd_f17h_perfmon_event_map[hw_event];
>> +       if (cpu_feature_enabled(X86_FEATURE_ZEN2) || boot_cpu_data.x86 >= 0x19)
>> +               return amd_zen2_perfmon_event_map[hw_event];
>> +
>> +       if (cpu_feature_enabled(X86_FEATURE_ZEN1))
>> +               return amd_zen1_perfmon_event_map[hw_event];
>>
>>         return amd_perfmon_event_map[hw_event];
>>  }
>> --
>> 2.34.1
>>


