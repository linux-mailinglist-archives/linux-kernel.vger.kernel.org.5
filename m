Return-Path: <linux-kernel+bounces-53007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF2849F74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3862B282D94
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F332239FFA;
	Mon,  5 Feb 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M5tWlHMt"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135633CF6;
	Mon,  5 Feb 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150420; cv=fail; b=JLvpG5L1JA11PgL22EYERI/G6lc9fofWaqeYKG4SVtlsMNyT00oYf5q0VMY5lzaMIWwmfoInlRDFYP96AeataSfdyASPgnDCK28cI0ZuRiTA86ElygPzGBqlEtPohEYNt620+wIRDYiulGgDs4FrgGGHu49vm5EdnSlHtXYZ1mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150420; c=relaxed/simple;
	bh=4QOOuu8k6dfNkbzqSr+YkNEosfxMWm6b1m5IH77F2So=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tYDNRjblfxppemvUaHC4mVSapSoy7dXQuFKb8t4/z9z/LBxjKdAnVcwKVZMcg0c8z3uQYxgrnsiqkr9n4r0hLKOHj7d+0BvKGDfv32udBu73jJPCYjiFVLRq1cyl420Z+0zldD5eASj+6N2tu45Y/aUkVMgS0qkG9VSdnxeldXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M5tWlHMt; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1KdtO3SJtC3ysGD3JxtD+kZ2fYMM9rSLl2Up2M/ejAz9xM6/MCyauouWyPPN9zq0pbSLYOQfFCQVAw1d26JyYrGnGar8Gkdfgc000J1aa2B/w789iDEkedTrQj2/j3quIQb501XgrcOiSmuBIeMeNSATFTBNDfrXLSMKRRVxOI9P6A74kv+r9bmoGqfJZ5NfIWzrPPeGwjFdyhZ+qYGNaP98ZHA3kp0BKshwv1Iq4vRbCggtL1u/XwkHFCxJxvCeIav0cnLEvUnbSjjbVweo0OLyVImo6vgrTiYB0Tq5e9P8UjgpiFQkzjKVjGU2PKUZXzDuSOzTapbqZieuuVrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY7uX05zskkyXNxIuEU/Yx4zRpFLiSJS9PuzAPICU2Y=;
 b=V/whxGK7g0J39SCjiAYFbkUTAt/l98HH4r4oGmZqeyE4GqqHMngcjVGOV2Yanz/5lEB3yM6soHBKSZmv6Oblp0HLa1enFcptB/OwJtoUloHV6Ys0W169D2aeMBPSaV+VfXdXLQFm2CnmqUFocCEreEblvjFJP0SKnhG4v24s7ea/I5iKCdocdqsReS1TK6SlXpN9LwJt/mojr9tRR6OmXNch/MygXNkjCimRAMKOE223WxfVBi3y8SD39f/8KxWcYeDnL1UU/EnuFGS9xsW9tRvCM7XxXPJRwaDv6DohD5MqhlS9IvD1C0aSWc0mIXypXkD8ykxEb/QnGTPuAUwXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY7uX05zskkyXNxIuEU/Yx4zRpFLiSJS9PuzAPICU2Y=;
 b=M5tWlHMtOrsm7Rsn9g6L2bhJEDNTKYJIFYvSsnkTE2vnVON3LQadyjiaqZLDxupBSXrzJ5isY4aGYqkvqKNXDYDWaUyt1W+lsFCZfeV2uFvGPVdPbYcznqAe8Hrc+WKRu7Zemtih3WnTtTfRQwLTBKOfFgQqBsitzWdZ5xx8ea4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 16:26:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Mon, 5 Feb 2024
 16:26:55 +0000
Message-ID: <7023f250-8278-41a5-ad44-684e83283814@amd.com>
Date: Mon, 5 Feb 2024 10:26:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
To: "Yuan, Perry" <Perry.Yuan@amd.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "Petkov, Borislav" <Borislav.Petkov@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du, Xiaojian"
 <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1707016927.git.perry.yuan@amd.com>
 <dc7fc753b596a4e262b21d2c2e8eec3570e4a97c.1707016927.git.perry.yuan@amd.com>
 <2719030.mvXUDI8C0e@natalenko.name>
 <CH3PR12MB8657029084397762A2ADD6249C472@CH3PR12MB8657.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CH3PR12MB8657029084397762A2ADD6249C472@CH3PR12MB8657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: df891862-7d68-46f3-fb2c-08dc266744b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gzy5Mhr5mAmwmD+YS4ysreLttjXz28j8TBAiSyl7w1G7DBLAmeUuWyPrkZ6Hpcmis+BUnKESk3M2tEulmS4YAwWSiNT+ketq/fDMr7VIDvraalw6r96Fx7MbMr+KvPjX4jfVYeMjcdR3zOZslRVYezMYOTM+qs69Zzqge0pGpb/MbuQPI1uFgOc1dlNqMrH+bTsnvfzCEDmKdQyCz7cJKFhVrBQ1o6jnxpkHJengSJBvfKAcC2y5szx14PFavehLfUT57Ko6tNzoX6Y99w4BHQwPus3tg2sbo0vpEWw0fFfEvWRjvn7XAPMsNI1dkyfT3mmN84MEp2/VpdNKav5XZ7XbmcBKHYaL7CokInschbG1IZ0iOCCNOy8d0/5o4pPqZG58rtBvJskutXrbYNBStSS+yqdpufkC+fvhHruTF8UeUOW/hBYfnVcSZVTMMlrUaTCbGmaqky1SJrYQct3JxfKPHaRPQnCyIGO1QG6jOG8HXR1JfftsA+nFZq8VOXTsQsWJ5zneIHjDwJuujU3+tSMWfvmLSS3G5eOqYO97emy2Fw4dIWU7gGKnx06ZIXdV8+v/5FSF4NEazmFRb/DknT6rlkXPaPYZx4ykCT8DVz6r+1MY422xcgzWf9Mj107IgfwLrIRH9qFqUNQ6EGVvQlZqkUNZAQhdabqaKzSLzNc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(41300700001)(66574015)(53546011)(6666004)(2906002)(921011)(54906003)(6506007)(44832011)(36756003)(6636002)(4326008)(66556008)(110136005)(316002)(66476007)(8676002)(8936002)(478600001)(66946007)(5660300002)(6486002)(26005)(6512007)(2616005)(31686004)(86362001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SndGdE5MQkMrc01DMTc2b1VzVjFxbUxOMUUzN0RaRGhSSGoxbVo5LzlUTFpx?=
 =?utf-8?B?RFpCOXlLN1ZBejQvYVdvS01rQTlpODFNM1NPSjhxWGgvdXkzamgxTWxFSzRE?=
 =?utf-8?B?VGt6bmRyRDJmT2FNVzJ5L1Aya2RsU1NGUnRiMjhIWlIrMHNtYlJJdENRdGdK?=
 =?utf-8?B?T3lZQzRvbHFQbEZJVUVNald5RHJ6aEtPSVFJTWFVRW9NWnltMUZGekRTZmlR?=
 =?utf-8?B?Vlp2aUc2MjVVTzcrL0xZbHdVd0EwZWd2eUtFVEhYQlBqZ3BiQzMwR0g4Tm96?=
 =?utf-8?B?S3pvNnlzQkhyUG5KbGtPQ0IwVTA3dndSVDNabUdveWtUWW1rZGQwSmNYQjlL?=
 =?utf-8?B?VFlqZzQwUGprUnluR2poVk42aVF4Q1RhcW9sdjI5bm9yZ0NlVHpSR1cwYm9V?=
 =?utf-8?B?ZzRpSVA1Yno0TGxpZlFDMzNlQlNPMFhEOTRSdHJGam42bkw4a3FxSWF3SmFB?=
 =?utf-8?B?R0pibjN5dnBxSVRsMVEwbXBBZExUR0VLT0dFUU5xdC9udHNZczI1ajZOUUx0?=
 =?utf-8?B?Sjh5dTBwT0RzaXZOWlpTTnc4TVJzSUN1SlNKNDV4ZDY2emxNZzNOckFVTzI2?=
 =?utf-8?B?aUtoVDNqTm9ONHRRSThRZ2IwVGdQVUxFcVNQSlJBVVNPQVloaStzYk1DYVpk?=
 =?utf-8?B?YXdhWDdhVUJiUFlwejVzVW5ZQjJlYkhyVkFkM0VCVWFvejg1OHd3Nm1WNk9D?=
 =?utf-8?B?VUlDN2RudWFVNmR0aXFCcFJ6eUZBMXFVNC9GbkZkL2V0UEZ6OGVMUkw1WkZY?=
 =?utf-8?B?TER2RHRET3VJbU0wVmNocHdyZmVlcmhhb0hzYmtNL3k5TmxVdWhiWTVIWW5X?=
 =?utf-8?B?bVQ4QzNtMVVXV3RsNDM0L1ZsMWlVaTVYT3NYZjJOUVBvczFYYW4yUjZ4Wlg4?=
 =?utf-8?B?MXJHbi82YXk1L016M3BZSEpBQS9tNlhEeHUvWHlOcjl4cG1ScENMTEJJNFdq?=
 =?utf-8?B?MmVEY0UxQmt3RitsczVBeXk0byt3cTdLT051R2xxUGJoZ2hXZFpUclV0cTN3?=
 =?utf-8?B?Vzd0NkdWWnFlRXNZWHNyaXY5cWQ3NlpUTFNSQUdpYlk4em1vbFYyUmN2K05O?=
 =?utf-8?B?WVNmeXNUK29yNWh0WENrZFBIb2xHU1c5Y0MwcDFwamR0bkI0Q2tFZjNvdzVw?=
 =?utf-8?B?a2hpWi90UU9TTnhYNTQ3QTZSRlNtRGY3YUM0d0FWS3NiclppaVNhaXoxRXJB?=
 =?utf-8?B?eWdGaUNnbng5c0NNVHNNczRscEVOcDcyUWVDdFpYOFhmM3RuL05QTmpVbTJQ?=
 =?utf-8?B?SWNLTmp1V2xVWitVOXpRdTdsOXE1ZE11S21EOGpCWnlrYldKTkN1UEVuSkFq?=
 =?utf-8?B?QXdmUHdwN1VCRzJBS1hRcTM4YUkyQjNYZDErUC9zOXlvQU92SlV4K1d6aVZm?=
 =?utf-8?B?akJ1dW0wZjB6RmRxSzduM0ZqR0lRbnQ4UldEQzlaQjRDVDIzMWJINmFPUEZ3?=
 =?utf-8?B?cXZxQmIxUmNEZ0xCTVNhZG1EWlpkb3BBVjF1dzRXZ0NTdGNHM0VrTFljVVdE?=
 =?utf-8?B?Z0Y5NW55R2lDSTZ1b0tZSURxN3FnRXBjQnJYNjk5L2xUM3ZtVnBkRk8vSjJl?=
 =?utf-8?B?TlFESys4cDB2clg1OFltR1p2QVNkV2ltdEJIZWRBTjVEOTllRmVlTy9URzR6?=
 =?utf-8?B?SzZBNjlKR29KWVBUM1k1RnVGd2ZnZnRsS0YrdXNQS0tCLzlTTnM3THRwQlAz?=
 =?utf-8?B?Mk0rMzZjSHkydGlPelVJSFYzdDRnNXBQMExKdldRT0JEUm5ma1ZQRWVNZWpL?=
 =?utf-8?B?TlFJZUE1Qlk0YURqdmF0ZjdZaThCQmoxSFJzamdJSlhHdkhhNmNVaVZNUlI1?=
 =?utf-8?B?eFNKM3J6YlFUTk9LVFcvWUI0T0NFeHczRWcyMjVtS3p4Y3J1UnJKSnZtQTBu?=
 =?utf-8?B?bno1QkRBVGRoTk1BNEZiT2w0cGgvNFEvaFRjR0h5RDc1a0RSRndUcTZDcVYr?=
 =?utf-8?B?TEM2ZHRISHVvd3dhS1VmblhFdkZ3KzRTRldEeFJaY2FUY2FYMEY3VU14Wmgz?=
 =?utf-8?B?MU5UdStISTV0L3kra3BnRVBQZEpzak1XcDlQYnVNck5VYkdxNU9JMUlHYkha?=
 =?utf-8?B?OXZJZWoxbWJwUnBxTUliYmZnTThHeTFWT1craWFRT0h3U2pTUDZXRXJ6NVRj?=
 =?utf-8?Q?X2wqhl1Lqj/JaV4VxjT0xcO8a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df891862-7d68-46f3-fb2c-08dc266744b7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 16:26:55.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j+ykfQqojjZfrVQO/AHk36PyDO7aXvcoyqxzdxYP9ZX0/rzQIxsoUA9CR18ay/S6scqK2ZwwY+/hC3o9AQHag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276

On 2/4/2024 20:29, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: Oleksandr Natalenko <oleksandr@natalenko.name>
>> Sent: Sunday, February 4, 2024 10:45 PM
>> To: rafael.j.wysocki@intel.com; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Huang, Ray
>> <Ray.Huang@amd.com>; Shenoy, Gautham Ranjal
>> <gautham.shenoy@amd.com>; Petkov, Borislav
>> <Borislav.Petkov@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
>> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
>> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH v3 6/6] cpufreq:amd-pstate: add quirk for the pstate
>> CPPC capabilities missing
>>
>> Hello.
>>
>> On neděle 4. února 2024 4:26:14 CET Perry Yuan wrote:
>>> Add quirks table to get CPPC capabilities issue fixed by providing
>>> correct perf or frequency values while driver loading.
>>>
>>> If CPPC capabilities are not defined in the ACPI tables or wrongly
>>> defined by platform firmware, it needs to use quick to get those
>>> issues fixed with correct workaround values to make pstate driver can
>>> be loaded even though there are CPPC capabilities errors.
>>>
>>> The workaround will match the broken BIOS which lack of CPPC
>>> capabilities nominal_freq and lowest_freq definition in the ACPI table.
>>>
>>> $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
>>> 0
>>> $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq
>>> 0
>>>
>>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>>> ---
>>>   drivers/cpufreq/amd-pstate.c | 49
>> ++++++++++++++++++++++++++++++++++--
>>>   include/linux/amd-pstate.h   |  6 +++++
>>>   2 files changed, 53 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c
>>> b/drivers/cpufreq/amd-pstate.c index 77effc3caf6c..25a6d8a808c4 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>>> static int cppc_state = AMD_PSTATE_UNDEFINED;  static bool
>>> cppc_enabled;  static bool amd_pstate_prefcore = true;
>>> +static struct quirk_entry *quirks;
>>>
>>>   /*
>>>    * AMD Energy Preference Performance (EPP) @@ -111,6 +112,33 @@
>>> static unsigned int epp_values[] = {
>>>
>>>   typedef int (*cppc_mode_transition_fn)(int);
>>>
>>> +static struct quirk_entry quirk_amd_7k62 = {
>>> +   .nominal_freq = 2600,
>>> +   .lowest_freq = 550,
>>> +};
>>> +
>>> +static int __init dmi_matched(const struct dmi_system_id *dmi) {
>>> +   quirks = dmi->driver_data;
>>> +   pr_info("hardware type %s found\n", dmi->ident);
>>> +
>>> +   return 1;
>>> +}
>>> +
>>> +static const struct dmi_system_id amd_pstate_quirks_table[] __initconst
>> = {
>>> +   {
>>> +           .callback = dmi_matched,
>>> +           .ident = "AMD EPYC 7K62",
>>> +           .matches = {
>>> +                   DMI_MATCH(DMI_BIOS_VERSION, "5.14"),
>>> +                   DMI_MATCH(DMI_BIOS_RELEASE, "12/12/2019");
>>
>> I think this is incorrect, and there should be a comma "," instead of
>> semicolon ";" at the end of the string. Otherwise the build will fail.
> 
> Good catch, I made a mistake here, I found this after I sent it out,  have it fixed in V4.
> Thanks for the review.

I'm still wondering if this is the right level of narrowness.  Does the 
quirk only apply to a single BIOS vendor?  Or any other sysfs attributes 
that can be generic to all affected systems?

Also would it perhaps make sense to rename dmi_matched to 
dmi_matched_7k62_bios_bug and then in dmi_matched_7k62_bios_bug check 
the model/family match.  In that function you can only set
quirks = dmi->driver_data

If the right CPU applies then too.

> 
> Perry.
> 
>>
>>> +           },
>>> +           .driver_data = &quirk_amd_7k62,
>>> +   },
>>> +   {}
>>> +};
>>> +MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
>>> +
>>>   static inline int get_mode_idx_from_str(const char *str, size_t size)
>>> {
>>>      int i;
>>> @@ -600,13 +628,19 @@ static void amd_pstate_adjust_perf(unsigned int
>>> cpu,  static int amd_get_min_freq(struct amd_cpudata *cpudata)  {
>>>      struct cppc_perf_caps cppc_perf;
>>> +   u32 lowest_freq;
>>>
>>>      int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>>      if (ret)
>>>              return ret;
>>>
>>> +   if (quirks && quirks->lowest_freq)
>>> +           lowest_freq = quirks->lowest_freq;
>>> +   else
>>> +           lowest_freq = cppc_perf.lowest_freq;
>>> +
>>>      /* Switch to khz */
>>> -   return cppc_perf.lowest_freq * 1000;
>>> +   return lowest_freq * 1000;
>>>   }
>>>
>>>   static int amd_get_max_freq(struct amd_cpudata *cpudata) @@ -635,12
>>> +669,18 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
>>> static int amd_get_nominal_freq(struct amd_cpudata *cpudata)  {
>>>      struct cppc_perf_caps cppc_perf;
>>> +   u32 nominal_freq;
>>>
>>>      int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>>      if (ret)
>>>              return ret;
>>>
>>> -   return cppc_perf.nominal_freq;
>>> +   if (quirks && quirks->nominal_freq)
>>> +           nominal_freq = quirks->nominal_freq;
>>> +   else
>>> +           nominal_freq = cppc_perf.nominal_freq;
>>> +
>>> +   return nominal_freq;
>>>   }
>>>
>>>   static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>>> @@ -1672,6 +1712,11 @@ static int __init amd_pstate_init(void)
>>>      if (cpufreq_get_current_driver())
>>>              return -EEXIST;
>>>
>>> +   quirks = NULL;
>>> +
>>> +   /* check if this machine need CPPC quirks */
>>> +   dmi_check_system(amd_pstate_quirks_table);
>>> +
>>>      switch (cppc_state) {
>>>      case AMD_PSTATE_UNDEFINED:
>>>              /* Disable on the following configs by default:
>>> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
>>> index d21838835abd..7b2cbb892fd9 100644
>>> --- a/include/linux/amd-pstate.h
>>> +++ b/include/linux/amd-pstate.h
>>> @@ -124,4 +124,10 @@ static const char * const
>> amd_pstate_mode_string[] = {
>>>      [AMD_PSTATE_GUIDED]      = "guided",
>>>      NULL,
>>>   };
>>> +
>>> +struct quirk_entry {
>>> +   u32 nominal_freq;
>>> +   u32 lowest_freq;
>>> +};
>>> +
>>>   #endif /* _LINUX_AMD_PSTATE_H */
>>>
>>
>>
>> --
>> Oleksandr Natalenko (post-factum)


