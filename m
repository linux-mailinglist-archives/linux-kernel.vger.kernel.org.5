Return-Path: <linux-kernel+bounces-118399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFA88BA50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730E12E53AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0112AAF8;
	Tue, 26 Mar 2024 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YBnJlyZ9"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2123.outbound.protection.outlook.com [40.107.93.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A633DF;
	Tue, 26 Mar 2024 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711433812; cv=fail; b=OORXF7Kt4xmF9mLKPuMgc6GzIKlefGFgA4iAsC2eMDAJ6CxElIayzeASGzazdpipdErXaIO8YbceGJ7spenmiwSjfLR5rOiq+jOIuZ5tkoDeOZLszTs7S14kA5fkYhHAszwWXwISSSMQwEMvVQA4+SPj5H6lk/mPCy8SfcDC2LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711433812; c=relaxed/simple;
	bh=E5P7kpZTFOf8hi38otG5KcxAUPrjO5j3gGkOaDXvMOw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i/zV1f8py6ER+zXGbX+ZceTjdHg825GoO9/Y7J4lkzEmzBeDTxpF4qQ9c3+SqeP/cqhIaonjVwv60CXx394h+rehqnvxIiVisXx/LZYf2Co8rN74dts4S1KU2CHYviHyVBnp2Y7SNpI3EvcMAFf+c2YWBRZM+/zv2RDZWpR8lyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YBnJlyZ9; arc=fail smtp.client-ip=40.107.93.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUZJ37bpiLqjZsRFOeHFb1I8l3H+F/FFF1nNMrPjDJz1shLDeDGAvi0NB43p97DLqyNRaypZSZiOw+QiG2WuJgo/2ahgO3+cLERN1S46iV8UZuO61N3565oXmitHUlgoNDjooKL7jeCDiwdgwzx3Z67SuFqSq8zAQgSXlwNZBUpN2mxvjJh5shMFeuNN2eCeniYfBBgYg8HUk77/UkZbK2fJP6l+slu5lhooJlxDIvOBO4jEhLwXfIIAJaHFfKONsjwt0k/JsK1QyqEacRCnIjcVMzkuZpVGxJrRFUYrMDijpBljJc31Xz4Z5OvoSANC1oIpSozwTdNUW2d3YKFPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMhnZJulJF+g2RKCt0ADD69AUu4t1qe2nh5ibm3rzrY=;
 b=Lyu+Xd3OY4TzvjMgsYs826RFj5uGHZGAbco/dzAu27VT6g40TSAyqUXtXc3b6psoyZMfRWQQqkXm9xhIZc6zqIfqq4rbqaV8vmZZV1FwI3frrn4AZsGP0yz3/XQldB8pkXzK5udyqN6wDXllkKNc0HRxZkX9hJUBJ3GfCKOO5r+yajei7/E/6wP3VCdtZkOmWe5K9lywHTqY7rJNe7DpD6uSsQObryU0gOKPSHc2L8MmXjarY9Tl8TGdrWZsLqDttwj57rGPtcTN5UTa2e8aTUREdFBBgtOeVmuMIiYvBvpvT1+g7ZokQSQpWi7IK0bTyXXcc1+6bQ33RJPo/PJewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMhnZJulJF+g2RKCt0ADD69AUu4t1qe2nh5ibm3rzrY=;
 b=YBnJlyZ98nLY9YOOw4/otuW97EQqK77bWERZX+WUhU4o6qAgi8bK/NwjkneHicxaVYmuwcQk9Rgfj0opVzEWcJY6oK/DI+lgF6DptqT1KvjHsox+d6nqLyIhIUvTox+94P4VetMe1dVAvQzsS+ljs25yqOWq4ZndRtozEmNdxjc=
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 06:16:47 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2716:d557:4236:8f0f]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2716:d557:4236:8f0f%6]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 06:16:46 +0000
Message-ID: <3de9ea09-5a30-4469-95b6-c752e3a485ab@amd.com>
Date: Tue, 26 Mar 2024 11:46:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/amd/core: Add ref-cycles event for Zen 4 and
 later
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
 eranian@google.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
References: <cover.1711352180.git.sandipan.das@amd.com>
 <089155f19f7c7e65aeb1caa727a882e2ca9b8b04.1711352180.git.sandipan.das@amd.com>
 <CAP-5=fVFh8rN24JnUUGx2DjYBSY6HCHi00tvC3=HBow3oTpMbw@mail.gmail.com>
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fVFh8rN24JnUUGx2DjYBSY6HCHi00tvC3=HBow3oTpMbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::31) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MN0PR12MB6245:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XVZ1QgxvNGHeY2XngaWsduTyuzYT4M4KeYSw9wAj+cy62XpShO9v3NVntsl8dGfyFqonRgZwK9klmYSvD+glVg5eluAI5PkjX1fhwrE9Ivw5yDX1AfOsmCwCnp0S3UrVkYq6+SwhtIR+6438TUnUkE2oYxNDf1Hl7uBl6IAeBlJKtCFADn+nBz7/VAC87xtg2kxbUhxAiK+AW5XQg9zfM2XlItaG28f+o7WlhP+BrYUIaNB1V7o1M6aQGH5vKqAPojE6b9r/Ieuc6DkvHnmoM0EEpi4czAIYZNvn9zmxSf6QOdYBO23rxxaa6gZXrTnnGH2G03MASH22kCQFYpLEoxW3rPun9D6tbk987MqbTm4yKFh5UfGXh+LlTya12BpLGUsrLaP1qS8QnRndZSs/EINJNeZNKh/XoMvd3r7ASh2G5MOQJbeLMAQ1fcjEGGJnhm4EaTZCXK1WliAAlYfA5koVYdt6orNfpeLussDERW3xoQA0NNFRDvtxy/CCZtrg/tpvhY8s//c2+XKqMvrqYI0bW+klJeccix+HTvMBgAKhIDS7SabSlorFfDf7wty/CPQb6TD/441vMu5/c6NAm/4T6d+ox4UcnDgo0tCNxlawqSM3FpH8wMv55q/PoDjy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDlBQnF2cDh3bkMySVN4M0NNUFBWamcvNlVHdkdtUWZub1MzRGtWOFMzRC9J?=
 =?utf-8?B?cURoS1NEdG9mZ2F6dWo0ODBvNTJIWFFzR2RBOFVGNU5JYzlxaE82c3FzOXpL?=
 =?utf-8?B?dEFnVVRaTVJBZnZKZzEzYjF5Wmp3MXBHTitVRTJubEtKbDNXUmZ6aDBLTTRx?=
 =?utf-8?B?M01HSEl3VEgwOWFkMFlaSThWcitsdUZEQUZkZHlCMlRrcnM1S2U1aTZUMHp3?=
 =?utf-8?B?UXRwTjhlT01lNG5nRzVXRXgwQ3BRVTdOOXBlYXo3YnN3b3VYVEhwZE9HQ1lN?=
 =?utf-8?B?aDVQTGk1WFZPRlByTVE0cG9HUmFTU2tISk1xc1JITHRWTnpNYzNLdFlkemx5?=
 =?utf-8?B?aUszeTJjc0VDa1I4bVNqUlAwL0MzNERYYkJMc0hvcVBwU0tGMXlva3JJVWJZ?=
 =?utf-8?B?cUZvWU5ja1B2RkhXQndNQTQ0YkZkVXRXNFdsM2Rhdk5KSDljR3N3NFZYN3Ay?=
 =?utf-8?B?Ymt1aGt3T1VKKzBuRUFmWEttdHlqRmQ4Y21za3JmTjlyUlUrV2k0M0lvWEVv?=
 =?utf-8?B?Y2NIdVhhRHBVcmUyamNhcC9GOHFkYU4zNm5keGw3RmdiNzVkeUF0dEVnR3cv?=
 =?utf-8?B?QmptNWZ5enlvaXRWSTE1N0dONEFCb296SWhNcUtRRUxXRWRsdGlWd2ZBMmRi?=
 =?utf-8?B?TEhhMHBta1pLeWVnNWEyVWJYSXJlNUFvSURXQlhxSWZ3Vi9OYTE1SzNjMlcv?=
 =?utf-8?B?NTZycXM2ZlJOYmlObHdhT0pwQkp2eWpsZURaUkg1VVhsNlg5VXZUVXhnNDBi?=
 =?utf-8?B?QVlBRUQ1ZFNhdDFBVjhhcTlxeWNxOHc2SnlwYnFnZzZZM0tEd2xXWnh5RzNt?=
 =?utf-8?B?czhJV0NBYjNKR1REUGVvZjZtek5wakF0SE8vYnBVUlA3b0dGMW9yZDNWNVRD?=
 =?utf-8?B?SFZRbW9JTU53VGdiRU9uNW1oWVB3SFB1bEpNQW9sTDFITUEyVkVFc0dyYnBw?=
 =?utf-8?B?djlQa0VHQkJsV0l4TEdFQ0dYeGxmTmg2eHpqcUxEalEyVGRYWmRKdVRZbXN5?=
 =?utf-8?B?U0ZRTFl2eUo3MDRXWXlnb0ZGRS9ZTlVzNzdOQWNERmVqbHozMTA3clV0M2RC?=
 =?utf-8?B?TWdxVjR2czFzMzBTaUVGcWFTYWNDa2U1dGdsOWtmdUJJbWhCWCtHUmx4U0VS?=
 =?utf-8?B?c0E2U0ZYTE11MDB4c2dSMFNTclIwbmdLNkErSXdMM29lY21ReDdYa3dzOWh4?=
 =?utf-8?B?SVdPM3FMYk4zcFZNdUlteDFoU2tNTWROYklobGRsUVpYRkczZnpIVUI1TzZk?=
 =?utf-8?B?ck4xMkNXOW1zVVFSb0VyZitPM0p4MnNVdzVNeDMwZHl1TW1jUTdiNGpXOGpN?=
 =?utf-8?B?cnRUTmEzcnllMkFmeXFSZ1k4aHlYQzd6UUdYdExlYTIyT0dpN3M3cGYzdTQ0?=
 =?utf-8?B?RGt4WlhOblFrWUdEVzZtQmlVYTZGR3R6bmEzc2ZvaVRDeTB1L3J4bjV1NGpz?=
 =?utf-8?B?bjZwTFVkR20zbFZ6RGZzeFVHd2lkWkZpdGNFU01ERGN4U1NwQm1MV3RzNTNw?=
 =?utf-8?B?Rm9rVmg5Wk8xdU1URkhabVpGdEprcmdqZnZlZ3Q4NmsrQzJWbEx3M3c4eDhI?=
 =?utf-8?B?T0xQMHFtUEF4K25oTDB3RTNnUWpMOTFCTG5LT3hFZHNxTkJHbndzR2xGNmR5?=
 =?utf-8?B?SWo2VmpJV0RxZXNkVm5lRnFiNW04ZmdhV0QvWXZDNjg0TVhXMUdPTWFHeGRT?=
 =?utf-8?B?QlcvS1h3Q3NrTDJvOU9nWkVwN1djT2F3OFNVVjYxWkJ0NjVMdFJSdVBaMUh6?=
 =?utf-8?B?TUVnaVd1OGZyZ082S2VZelZGZEwrSHVyME1UNUhJS3F5ZVQxVEJYVDlzemtR?=
 =?utf-8?B?c0JTQUpYdHdYb0xZV3BUaUkzWVhnS0JTckxLd29ZaXdaU1ova3ovNHJRdHNT?=
 =?utf-8?B?c3hFSlpQTTg3TGk5enQ0bGVnMm9FbTFTSFhkNmdVekREZ1JiQW1HdEk1L0Nt?=
 =?utf-8?B?T3ljQWpheGE4eWRERlFtcGMzNFJ2azFXakpzVHVWZyszZmNhc2RCa0ZWemw3?=
 =?utf-8?B?SGZjT1dreGh3S3BjazF2REd4cjF2L1lpTVhFcFlVN2p6dmc3Tmlaa01YVkVk?=
 =?utf-8?B?TE5JampIUjdyQitPa3cvNld2YUxhMWxobnFRa2JyOSsyTElpVzJpUUNkL3lz?=
 =?utf-8?Q?gKo6RILVUldT07jc+sMgw7cFv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67f20a7-801a-4a2d-c50f-08dc4d5c5057
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 06:16:46.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWk2ggq/MYh2mxvXH5XrGLFNydHOcXzSt2gEQd0hnP9vDHFqHlneVaAUBbq949+5bAUAK3FS4btU104hn4I9Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245

On 3/25/2024 8:13 PM, Ian Rogers wrote:
> On Mon, Mar 25, 2024 at 12:48 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Add the "ref-cycles" event for AMD processors based on Zen 4 and later
>> microarchitectures. The backing event is based on PMCx120 which counts
>> cycles not in halt state in P0 frequency (same as MPERF).
> 
> This reminds me that we lack smi cost and an smi_cycles metric for
> AMD, here is an Intel one:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json?h=perf-tools-next#n274
> The metric uses APERF but runs with freeze_on_smi set:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-stat.c?h=perf-tools-next#n2115
> so the delta between cycles and aperf is the cycles in SMI. It would
> be great if we could get something similar on AMD.
> 

Thanks for the suggestion. I found PMCx02B ("ls_smi_rx" in perf JSONs) in
the AMD PPRs which counts the number of SMIs received but there's no way
to know how many cycles were spent in System Management Mode. I also could
not find an equivalent for the Freeze on SMI feature.

>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
>> ---
>>  arch/x86/events/amd/core.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>> index afe4a809f2ed..685bfa860d67 100644
>> --- a/arch/x86/events/amd/core.c
>> +++ b/arch/x86/events/amd/core.c
>> @@ -273,8 +273,23 @@ static const u64 amd_zen2_perfmon_event_map[PERF_COUNT_HW_MAX] =
>>         [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x00a9,
>>  };
>>
>> +static const u64 amd_zen4_perfmon_event_map[PERF_COUNT_HW_MAX] =
>> +{
>> +       [PERF_COUNT_HW_CPU_CYCLES]              = 0x0076,
>> +       [PERF_COUNT_HW_INSTRUCTIONS]            = 0x00c0,
>> +       [PERF_COUNT_HW_CACHE_REFERENCES]        = 0xff60,
>> +       [PERF_COUNT_HW_CACHE_MISSES]            = 0x0964,
>> +       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = 0x00c2,
>> +       [PERF_COUNT_HW_BRANCH_MISSES]           = 0x00c3,
>> +       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x00a9,
>> +       [PERF_COUNT_HW_REF_CPU_CYCLES]          = 0x100000120,
>> +};
>> +
>>  static u64 amd_pmu_event_map(int hw_event)
>>  {
>> +       if (cpu_feature_enabled(X86_FEATURE_ZEN4) || boot_cpu_data.x86 >= 0x1a)
>> +               return amd_zen4_perfmon_event_map[hw_event];
>> +
>>         if (cpu_feature_enabled(X86_FEATURE_ZEN2) || boot_cpu_data.x86 >= 0x19)
>>                 return amd_zen2_perfmon_event_map[hw_event];
>>
>> --
>> 2.34.1
>>


