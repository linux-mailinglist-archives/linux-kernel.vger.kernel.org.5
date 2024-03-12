Return-Path: <linux-kernel+bounces-100124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67027879211
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0F71C212E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67914F8BC;
	Tue, 12 Mar 2024 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i9R0l4xF"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6E2572;
	Tue, 12 Mar 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239556; cv=fail; b=cKj9wDAo+yCDv5r8AUu3JuhSBuaXIyAK/UMTl+3wF2gXszcVcQQoCoEbPPd5nhRQGJ+1YM/7GI1znKRkzrVPJeRyJ61+shYHhhG0xEomOAFvFZnRvqK969cubuoYfAT11HPjWON/CVN8XDvkKDyLvU0GlszfSsrCLbuGKq81oo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239556; c=relaxed/simple;
	bh=AHt5wasZSsRfcsD7H6UTIe3WrawBOEXf5F/H0b9I2Yw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AXJZsaoZJpMPAdO6EcrwEeG2w2hJd8jCFeH4ZyGDnXUJ2JVead1pVuBEFsUTNQWJmWgmaOwuwYc0fqoLYb0rrSijV18ooKhtmRCu0Iq1Y1rrEURZUztdhOBvJ/qH93n6ST89C+cOTYPgVisxqx0yN8I/v+74HYOvBXA3a1qLy0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i9R0l4xF; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hz5BdUqClTnasSUfquvpKp7ZHJtbKPemEMnXaNg/ip4Dz9iWvA/a9aopUZ1bsIcSyqclM+fow0BYdvhnssRAHOJKIF0f1l1/DiWw0cnNYd74SX78cCOkhSClOl/XCK94bhrrEAOMlGRIsB4xRZaVf54pSYwAB8GEYWd4KWr0wqwt9/RqZ9La+I9U2Ws2DSbHj9wPwgwEESxnjHuNPKuL0ntALZLcd2c8XDPlKWhQgV536KXD8Y9S88e746/Ix3AeCKBlNSlrIQ1xaI/zrTAaFE77Te6deuS8I36LQNoX2UCREpUPMpJW8mEIvrWWc+NykJf27eFNqJnyRiUG8Vdlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGDNWTpQo1Bk7VZE6npM1l7QqPs+2fqOof22uMEKG04=;
 b=O5mcUKxHAU8065cBaKrVgffwnH/MxBtF4LAcIe0Hc2H7TBS3tcKRFsMK89vqkILofoEm49cSSa91KoWy5I1/tVH5OTUbkrHycCRnfogu5fIrv8puq57IL6KTQPqRXu/8UqmbYI96Jvx3i/cpCzUlDqF3njS4Hd4oBaGs9YOo5FDTb5Bg+G/idp3UXcGrjb16F20YYSXnWOCa3FM17NiIPbleE1mdWV8ZN3ywdw7TrC7jvkW4dMgu/M0bQrZltrHWd90+Dbn0mxKmbdzPjiwK43e1seWiWDZV0Y1+ZDNW4caNP4zrd6wwcjTvnpGQjIoAYK3c6hay+qKOgPDIA37OwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGDNWTpQo1Bk7VZE6npM1l7QqPs+2fqOof22uMEKG04=;
 b=i9R0l4xFvzYnGW03KTScvsj16oSJx7IbgF2kFmWWq6nTOxG3sEUbxsbxXDmJ1pz96ODZZuUYq1ag5QaiH3Ur7VhN2Tqp3XS7KJlH+1lNUnBXZklHv9VEZyBP05L1dkR3hgroHKMZ6xsvB6iSNtggs/M7k39iltYKJPE/GhAR3x0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 10:32:31 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9dcb:30:4f52:82f5]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9dcb:30:4f52:82f5%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 10:32:31 +0000
Message-ID: <392278e8-7ef2-4bfa-a18c-797325737951@amd.com>
Date: Tue, 12 Mar 2024 16:02:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] perf vendor events amd: Add Zen 5 metrics
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com,
 ananth.narayan@amd.com
References: <cover.1710133771.git.sandipan.das@amd.com>
 <017b0abebc24535e3e96fa9f9cc4ba4c11fffb57.1710133771.git.sandipan.das@amd.com>
 <CAP-5=fWc5ZJaiR_tS8RHPxcdAPST61CYUS_9Qvc2ztzBUETQbg@mail.gmail.com>
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fWc5ZJaiR_tS8RHPxcdAPST61CYUS_9Qvc2ztzBUETQbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::13) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab42ff1-49df-4089-8022-08dc427fb8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pxT0kDrZITVfFXRGGgREGM2aqZBoTgwsFNIdZiac3fknx+tP6w9MDKI4YPcwIVGj7TknAlX384TH3SbTtWbuPGnNR9cuXJUlKYi7h8bONLROp7YdfD3fQ2vg7LDA7zJK5UECk+0/5QFEMDHRPH+bfRy+LmN4NIV8vYBN72xhgKXpU7+yjnSisj1Y/eaH0Z4/ieChps07dX8KprIIsfQB8HyYUlqScictGfv+QpHSf2Ka3LR9eO1FPmYhXmtFSJqVrrmqM2FQUKIR6f4fscuAzQQ0WY40Ybq7Hg44/nvTI9TN5UgueY9ZCaFzHFILgiaO7Z/bRsskmzSChKN9zqEmrdHH+v9jXFqOBDAYouuPZZxRX1PHi9JYYmHlOaBz6Oh7QbWx3vlb03E/dKF3faNWOdDHzDtDhj5V285LrAggOJfo/mAg/eiTJFucHgPr7dYSedClWZaYV78OOvBnWo8yclnXbkEPJjyjVx9hXJIaZRUoDGH254JCp5recmqLjLR1ghZVlHyxwZRL0fTF8kzlNDvfhbvK4yHvz3Lc9L/HmD25J6HjMPOtdtviTrgxEw0M1J8n4raGYgBJcMKqZKxS+P2JEL/LXslX+bkQeUADlPbRMvFC0mOo4Q07DefvG0ij
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2ZIalJaaHo0cjlZc2lkc0tkZWxGQUlJRncrL2YydWVoQmRVVzNJb0xJMEpJ?=
 =?utf-8?B?YjB5RHFGVUJKaldjdWVHL2w2SzY1NzZESm8rbGdvZVkrRHRKK2ZkejFxWXJx?=
 =?utf-8?B?eGhqQldwNkhLMmZGSUQ2NHdLUVRzNGFSaTBuNFltNlEwa0NZT0Jqc05MN2Vl?=
 =?utf-8?B?ckxCYWxCeUlKVUxlOFRFa0QzUHNqQS96bkEvQmpMVEJpVEJmSHZXdFF2M2Vt?=
 =?utf-8?B?RktSVEluaVI5N2UzZlVaTlBuWnFLM2dTWDVUUHhpSjJmaGp1bXRGRFVYemFP?=
 =?utf-8?B?cEdVajVGWGJwNExXTm95MGY1WEFXUHhiK2twTHVMTHluTmNlSWxzQXJMU0Yy?=
 =?utf-8?B?Qm5iWjlBUkpiUy80OURzZzV0ZE95VGR4bUg0bXMwUjFvR1pnUWtIZ3VOYkxW?=
 =?utf-8?B?akJ6L3hpbWhJQVo5d1llZytrOVcxbURqOGZTUkU1ckRYVTNud0FiRlNJdy9X?=
 =?utf-8?B?R1NMci9FOVM5K2kwV2Z3eXlQaEhUK0JDaUZVZkR3ZlRrUEg0K2Qvdi93dVNG?=
 =?utf-8?B?aE4yZmZNdWRHVC9qR1RtNkxzUE5lMXlKUEJHWjhaNllqeTZvSnlhdlludzBi?=
 =?utf-8?B?ZE11L1NTV05yNkRSQzkrKzczSVFqdjRzaEg3MXAvRGpZd2JYdkJHUUpHcnVR?=
 =?utf-8?B?OGZwZnI1eWxQVmhjRVNhUzZYWTZYRitsbHo0amxCWFg4SFo4eVp1emd0SG9x?=
 =?utf-8?B?RU5QK0ZOU21UNlRnUWt3T2RLanlpQXZHWXZjckZ4YXgwTklSeTg2bmFRL0tL?=
 =?utf-8?B?dUdXdDBIM1ZWQ3JjUnBhV2o3ZFZzeC9McmZKc3BHSDY0ZlRmZFRCYnFlTStY?=
 =?utf-8?B?NDFRYldOTnBkbU9OUVZQbXZYakxRcHNjejU0a3liOCttZjRHdDNrNWR0QTAz?=
 =?utf-8?B?a0xWRDFZS3R6TXZMNXZYbEkydTFUYzBNTEh5TXppaldVM2xmckhKU3ZvM3k2?=
 =?utf-8?B?d0svL1RrdWVHUnF0TXJxNHh0QzVwWE53L0dJbCs3R0liTmc1WlpNcWdXZFRo?=
 =?utf-8?B?ZnZVNlVXb0ZXZ09FQU4vNFR5N3NNN0pMWEZzNXlvc0FyTHl2Nkc5NGtrSVhW?=
 =?utf-8?B?Sk9EYXljdXFGL29EekZMNG5qbE00TlhweVVDMnZsaU8xLzhCYm5US0MvVmcr?=
 =?utf-8?B?dFZWcTVKOStjVlRUV3d2YVJxcFBDR043Y000UTY3L0hidnNiTktMRVZFY0ZH?=
 =?utf-8?B?VE1BYnI0VElLMzQ5OFIvR1hSRG4vM3dqWk1Seko5NWt3TE52MnNBNHI5WnM0?=
 =?utf-8?B?c1NTTHpobW9NOGViVFZYZERoRENoY2Q3T3YrWklSdVduM0NKdnJFaXlBek4x?=
 =?utf-8?B?bEZlUld3cHluQnptRTFDeEhXQmdUbC8yVzZaNWtEWFBmRUV2RHYwNUJ2dGMv?=
 =?utf-8?B?bUxYSDNlYkI2QzdxUlg4S3BCa3Y4S3IzSjZ6QzNERVJmbG1sVThDT2RGNmk5?=
 =?utf-8?B?eGZqbDBVbllLM3VGMWErZVVyWk1FVXBUeTVMRjRkdVErb0p5dkpLRDVaWHc2?=
 =?utf-8?B?ZHdhSFBmYnE2cStYMjR5ckloNDhzWDRpWS8yQW9rbkRKdlJ6UldlNEtua1hy?=
 =?utf-8?B?VzdWYlVxdnhjelE5UkxRVEFybGlYcTc3MmU0TkVnRWdLYU8rYmVTMHpFQXY5?=
 =?utf-8?B?MGdab2NxdG5YZmRyVFhlS3YwTVp2QVlvc2FZUGRTU3dmem96ZVJoYXVzUS9m?=
 =?utf-8?B?T3NScVRKVDFBVlZWVVpJdjNJcnFPZ1FJOHBtMHlhd00zbG9HRXNtWmNtRDZX?=
 =?utf-8?B?eGNURiszY09acUdqUzJZRTVsVEVsb3M5cUFCb0g4S2lEMEZFYmJzaVl6RkV0?=
 =?utf-8?B?N1NSSWtYSnJROW0wL2tiQ2ZHN3lkZWtOWDR2UDhLRW1rbjJucmpaRVNkVVp6?=
 =?utf-8?B?MnpVM0pjUVVXQTcwSlhZMm1wTVdUWlBzRno3SzVEdkZ2QnlrV2JFSEVmVkxS?=
 =?utf-8?B?NUpZd3hHajQxd3M2cGJoMGNIZDNYSDVXQUZPZmRyNEZ3Y2dqUmc3SURqMkxu?=
 =?utf-8?B?Z09ldWFyczl1VFJFUXZsQm4yOWlaNWo4anNYZjZycnhOYjg3S1hjQllYUC9M?=
 =?utf-8?B?bkEvM0ZsTGh2d2lpQmJpbXQrbnJnQWUrQmRRSkJDT1hvWlpxRi9PNnkvZURC?=
 =?utf-8?Q?re6/lLzUv2tqGpWOLU7/8VA3N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab42ff1-49df-4089-8022-08dc427fb8b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 10:32:30.9469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm/EcKnw/tGKlWtIlKdcLmuwRkYsads73X1KEtoonR8dBk/LxIG8xLuFToIG92VWaeN46i3DehQLGLg76/szgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247

On 3/12/2024 12:16 AM, Ian Rogers wrote:
> On Sun, Mar 10, 2024 at 10:24 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Add metrics taken from Section 1.2 "Performance Measurement" of the
>> Performance Monitor Counters for AMD Family 1Ah Model 00h-0Fh Processors
>> document available at the link below.
>>
>> The recommended metrics are sourced from Table 1 "Guidance for Common
>> Performance Statistics with Complex Event Selects".
>>
>> The pipeline utilization metrics are sourced from Table 2 "Guidance
>> for Pipeline Utilization Analysis Statistics". These are useful for
>> finding performance bottlenecks by analyzing activity at different
>> stages of the pipeline. There are metric groups available for Level 1
>> and Level 2 analysis.
>>
>> Link: https://bugzilla.kernel.org/attachment.cgi?id=305974
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> 
> Could you consider reviewing:
> https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@google.com/
> 

Sure. I did start going over the series a few days back.

>> ---
>>  .../pmu-events/arch/x86/amdzen5/pipeline.json |  98 +++++
>>  .../arch/x86/amdzen5/recommended.json         | 357 ++++++++++++++++++
>>  2 files changed, 455 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
>>
>> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json b/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
>> new file mode 100644
>> index 000000000000..36dc76b793ae
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
>> @@ -0,0 +1,98 @@
>> +[
>> +  {
>> +    "MetricName": "total_dispatch_slots",
>> +    "BriefDescription": "Total dispatch slots (up to 8 instructions can be dispatched in each cycle).",
>> +    "MetricExpr": "8 * ls_not_halted_cyc"
> 
> Should the unit be slots?
> 

Yes, I'll update this.

>> +  },
>> +  {
>> +    "MetricName": "frontend_bound",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because the frontend did not supply enough instructions/ops.",
> 
> Given the output is in percent, is fraction an accurate description?
> Wouldn't "percentage" be better? This issue repeats below, but I'll
> just highlight the first instance.
> 

Will fix this and other instances.

>> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend, total_dispatch_slots)",
>> +    "MetricGroup": "PipelineL1",
>> +    "ScaleUnit": "100%"
> 
> Perhaps "100% slots" ?
> 
>> +  },
>> +  {
>> +    "MetricName": "bad_speculation",
>> +    "BriefDescription": "Fraction of dispatched ops that did not retire.",
>> +    "MetricExpr": "d_ratio(de_src_op_disp.all - ex_ret_ops, total_dispatch_slots)",
>> +    "MetricGroup": "PipelineL1",
>> +    "ScaleUnit": "100%"
> 
> Perhaps "100% ops"
> 
>> +  },
>> +  {
>> +    "MetricName": "backend_bound",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because of backend stalls.",
>> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.backend_stalls, total_dispatch_slots)",
>> +    "MetricGroup": "PipelineL1",
>> +    "ScaleUnit": "100%"
> 
> Perhaps "100% slots"
> 
>> +  },
>> +  {
>> +    "MetricName": "smt_contention",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because the other thread was selected.",
>> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.smt_contention, total_dispatch_slots)",
>> +    "MetricGroup": "PipelineL1",
>> +    "ScaleUnit": "100%"
> 
> Perhaps "100% slots"
> 
>> +  },
>> +  {
>> +    "MetricName": "retiring",
>> +    "BriefDescription": "Fraction of dispatch slots used by ops that retired.",
>> +    "MetricExpr": "d_ratio(ex_ret_ops, total_dispatch_slots)",
>> +    "MetricGroup": "PipelineL1",
>> +    "ScaleUnit": "100%"
> 
> Perhaps "100% slots"
> 
>> +  },
>> +  {
>> +    "MetricName": "frontend_bound_latency",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because of a latency bottleneck in the frontend (such as instruction cache or TLB misses).",
>> +    "MetricExpr": "d_ratio((8 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x8@), total_dispatch_slots)",
>> +    "MetricGroup": "PipelineL2;frontend_bound_group",
>> +    "ScaleUnit": "100%"
> 
> Perhaps "100% slots"
> 
>> +  },
>> +  {
>> +    "MetricName": "frontend_bound_bandwidth",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because of a bandwidth bottleneck in the frontend (such as decode or op cache fetch bandwidth).",
>> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend - (8 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x8@), total_dispatch_slots)",
>> +    "MetricGroup": "PipelineL2;frontend_bound_group",
>> +    "ScaleUnit": "100%"
> 
> Perhaps "100% slots"
> 
> It seems unexpected that a latency (above) and  bandwidth metric would
> be reporting a percentage, perhaps this needs capturing in the metric
> name.
> 
> Same issues repeat below...
> 

Will update these.

>> +  },
>> +  {
>> +    "MetricName": "bad_speculation_mispredicts",
>> +    "BriefDescription": "Fraction of dispatched ops that were flushed due to branch mispredicts.",
>> +    "MetricExpr": "d_ratio(bad_speculation * ex_ret_brn_misp, ex_ret_brn_misp + bp_redirects.resync)",
>> +    "MetricGroup": "PipelineL2;bad_speculation_group",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "bad_speculation_pipeline_restarts",
>> +    "BriefDescription": "Fraction of dispatched ops that were flushed due to pipeline restarts (resyncs).",
>> +    "MetricExpr": "d_ratio(bad_speculation * bp_redirects.resync, ex_ret_brn_misp + bp_redirects.resync)",
>> +    "MetricGroup": "PipelineL2;bad_speculation_group",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "backend_bound_memory",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because of stalls due to the memory subsystem.",
>> +    "MetricExpr": "backend_bound * d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete)",
>> +    "MetricGroup": "PipelineL2;backend_bound_group",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "backend_bound_cpu",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because of stalls not related to the memory subsystem.",
>> +    "MetricExpr": "backend_bound * (1 - d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete))",
>> +    "MetricGroup": "PipelineL2;backend_bound_group",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "retiring_fastpath",
>> +    "BriefDescription": "Fraction of dispatch slots used by fastpath ops that retired.",
>> +    "MetricExpr": "retiring * (1 - d_ratio(ex_ret_ucode_ops, ex_ret_ops))",
>> +    "MetricGroup": "PipelineL2;retiring_group",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "retiring_microcode",
>> +    "BriefDescription": "Fraction of dispatch slots used by microcode ops that retired.",
>> +    "MetricExpr": "retiring * d_ratio(ex_ret_ucode_ops, ex_ret_ops)",
>> +    "MetricGroup": "PipelineL2;retiring_group",
>> +    "ScaleUnit": "100%"
>> +  }
>> +]
>> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
>> new file mode 100644
>> index 000000000000..986f8b2b2d5b
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
>> @@ -0,0 +1,357 @@
>> +[
>> +  {
>> +    "MetricName": "branch_misprediction_ratio",
>> +    "BriefDescription": "Execution-time branch misprediction ratio (non-speculative).",
> 
> Is ratio or rate better?
> ```
> $ grep -r MetricName tools/perf/pmu-events/arch/| grep _rate |wc -l
> 246
> $ grep -r MetricName tools/perf/pmu-events/arch/| grep _ratio |wc -l
> 135
> ```
> 

If having both helps, I can add a rate metric as well.

>> +    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
>> +    "MetricGroup": "branch_prediction",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "all_data_cache_accesses_pti",
>> +    "BriefDescription": "All data cache accesses per thousand instructions.",
>> +    "MetricExpr": "ls_dispatch.all / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
> 
> Perhaps "1e3instructions", and below.
> 

Will fix these.

>> +  },
>> +  {
>> +    "MetricName": "all_l2_cache_accesses_pti",
>> +    "BriefDescription": "All L2 cache accesses per thousand instructions.",
>> +    "MetricExpr": "(l2_request_g1.all_no_prefetch + l2_pf_hit_l2.l2_hwpf + l2_pf_miss_l2_hit_l3.l2_hwpf + l2_pf_miss_l2_l3.l2_hwpf) / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_cache_accesses_from_l1_ic_misses_pti",
>> +    "BriefDescription": "L2 cache accesses from L1 instruction cache misses (including prefetch) per thousand instructions.",
>> +    "MetricExpr": "l2_request_g1.cacheable_ic_read / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_cache_accesses_from_l1_dc_misses_pti",
>> +    "BriefDescription": "L2 cache accesses from L1 data cache misses (including prefetch) per thousand instructions.",
>> +    "MetricExpr": "l2_request_g1.all_dc / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_cache_accesses_from_l2_hwpf_pti",
>> +    "BriefDescription": "L2 cache accesses from L2 cache hardware prefetcher per thousand instructions.",
>> +    "MetricExpr": "(l2_pf_hit_l2.l1_dc_l2_hwpf + l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf + l2_pf_miss_l2_l3.l1_dc_l2_hwpf) / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "all_l2_cache_misses_pti",
>> +    "BriefDescription": "All L2 cache misses per thousand instructions.",
>> +    "MetricExpr": "(l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hit_l3.l2_hwpf + l2_pf_miss_l2_l3.l2_hwpf) / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_cache_misses_from_l1_ic_miss_pti",
>> +    "BriefDescription": "L2 cache misses from L1 instruction cache misses per thousand instructions.",
>> +    "MetricExpr": "l2_cache_req_stat.ic_fill_miss / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_cache_misses_from_l1_dc_miss_pti",
>> +    "BriefDescription": "L2 cache misses from L1 data cache misses per thousand instructions.",
>> +    "MetricExpr": "l2_cache_req_stat.ls_rd_blk_c / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_cache_misses_from_l2_hwpf_pti",
>> +    "BriefDescription": "L2 cache misses from L2 cache hardware prefetcher per thousand instructions.",
>> +    "MetricExpr": "(l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf + l2_pf_miss_l2_l3.l1_dc_l2_hwpf) / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "all_l2_cache_hits_pti",
>> +    "BriefDescription": "All L2 cache hits per thousand instructions.",
>> +    "MetricExpr": "(l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2.l2_hwpf) / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_cache_hits_from_l1_ic_miss_pti",
>> +    "BriefDescription": "L2 cache hits from L1 instruction cache misses per thousand instructions.",
>> +    "MetricExpr": "l2_cache_req_stat.ic_hit_in_l2 / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_cache_hits_from_l1_dc_miss_pti",
>> +    "BriefDescription": "L2 cache hits from L1 data cache misses per thousand instructions.",
>> +    "MetricExpr": "l2_cache_req_stat.dc_hit_in_l2 / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_cache_hits_from_l2_hwpf_pti",
>> +    "BriefDescription": "L2 cache hits from L2 cache hardware prefetcher per thousand instructions.",
>> +    "MetricExpr": "l2_pf_hit_l2.l1_dc_l2_hwpf / instructions",
>> +    "MetricGroup": "l2_cache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l3_cache_accesses",
>> +    "BriefDescription": "L3 cache accesses.",
>> +    "MetricExpr": "l3_lookup_state.all_coherent_accesses_to_l3",
>> +    "MetricGroup": "l3_cache"
>> +  },
>> +  {
>> +    "MetricName": "l3_misses",
>> +    "BriefDescription": "L3 misses (including cacheline state change requests).",
> 
> local vs remote?
> 

Unfortunately, the underlying event doesn't provide a local vs. remote breakdown.

>> +    "MetricExpr": "l3_lookup_state.l3_miss",
>> +    "MetricGroup": "l3_cache"
>> +  },
>> +  {
>> +    "MetricName": "l3_read_miss_latency",
>> +    "BriefDescription": "Average L3 read miss latency (in core clocks).",
>> +    "MetricExpr": "(l3_xi_sampled_latency.all * 10) / l3_xi_sampled_latency_requests.all",
>> +    "MetricGroup": "l3_cache",
>> +    "ScaleUnit": "1core clocks"
>> +  },
>> +  {
>> +    "MetricName": "l3_read_miss_latency_for_local_dram",
>> +    "BriefDescription": "Average L3 read miss latency (in core clocks) for local DRAM.",
>> +    "MetricExpr": "(l3_xi_sampled_latency.dram_near * 10) / l3_xi_sampled_latency_requests.dram_near",
>> +    "MetricGroup": "l3_cache",
>> +    "ScaleUnit": "1core clocks"
> 
> "core clocks" isn't defined in the attached documentation. How can one
> look up the different clock types? If "core" is basically all clock
> types in the metrics then consider dropping "core" here.
> 

The correct unit for these metrics should be nanoseconds. I'll fix them.

>> +  },
>> +  {
>> +    "MetricName": "l3_read_miss_latency_for_remote_dram",
>> +    "BriefDescription": "Average L3 read miss latency (in core clocks) for remote DRAM.",
>> +    "MetricExpr": "(l3_xi_sampled_latency.dram_far * 10) / l3_xi_sampled_latency_requests.dram_far",
>> +    "MetricGroup": "l3_cache",
>> +    "ScaleUnit": "1core clocks"
>> +  },
>> +  {
>> +    "MetricName": "op_cache_fetch_miss_ratio",
>> +    "BriefDescription": "Op cache miss ratio for all fetches.",
>> +    "MetricExpr": "d_ratio(op_cache_hit_miss.op_cache_miss, op_cache_hit_miss.all_op_cache_accesses)",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "ic_fetch_miss_ratio",
>> +    "BriefDescription": "Instruction cache miss ratio for all fetches. An instruction cache miss will not be counted by this metric if it is an OC hit.",
>> +    "MetricExpr": "d_ratio(ic_tag_hit_miss.instruction_cache_miss, ic_tag_hit_miss.all_instruction_cache_accesses)",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "l1_data_cache_fills_from_memory_pti",
>> +    "BriefDescription": "L1 data cache fills from DRAM or MMIO in any NUMA node per thousand instructions.",
>> +    "MetricExpr": "ls_any_fills_from_sys.dram_io_all / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_data_cache_fills_from_remote_node_pti",
>> +    "BriefDescription": "L1 data cache fills from a different NUMA node per thousand instructions.",
>> +    "MetricExpr": "ls_any_fills_from_sys.far_all / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_data_cache_fills_from_same_ccx_pti",
>> +    "BriefDescription": "L1 data cache fills from within the same CCX per thousand instructions.",
>> +    "MetricExpr": "ls_any_fills_from_sys.local_all / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_data_cache_fills_from_different_ccx_pti",
>> +    "BriefDescription": "L1 data cache fills from another CCX cache in any NUMA node per thousand instructions.",
>> +    "MetricExpr": "ls_any_fills_from_sys.remote_cache / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "all_l1_data_cache_fills_pti",
>> +    "BriefDescription": "All L1 data cache fills per thousand instructions.",
>> +    "MetricExpr": "ls_any_fills_from_sys.all / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_demand_data_cache_fills_from_local_l2_pti",
>> +    "BriefDescription": "L1 demand data cache fills from local L2 cache per thousand instructions.",
>> +    "MetricExpr": "ls_dmnd_fills_from_sys.local_l2 / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_demand_data_cache_fills_from_same_ccx_pti",
>> +    "BriefDescription": "L1 demand data cache fills from within the same CCX per thousand instructions.",
>> +    "MetricExpr": "ls_dmnd_fills_from_sys.local_ccx / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_demand_data_cache_fills_from_near_cache_pti",
>> +    "BriefDescription": "L1 demand data cache fills from another CCX cache in the same NUMA node per thousand instructions.",
>> +    "MetricExpr": "ls_dmnd_fills_from_sys.near_cache / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_demand_data_cache_fills_from_near_memory_pti",
>> +    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in the same NUMA node per thousand instructions.",
>> +    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_near / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_demand_data_cache_fills_from_far_cache_pti",
>> +    "BriefDescription": "L1 demand data cache fills from another CCX cache in a different NUMA node per thousand instructions.",
>> +    "MetricExpr": "ls_dmnd_fills_from_sys.far_cache / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_demand_data_cache_fills_from_far_memory_pti",
>> +    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in a different NUMA node per thousand instructions.",
>> +    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_far / instructions",
>> +    "MetricGroup": "l1_dcache",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_itlb_misses_pti",
>> +    "BriefDescription": "L1 instruction TLB misses per thousand instructions.",
>> +    "MetricExpr": "(bp_l1_tlb_miss_l2_tlb_hit + bp_l1_tlb_miss_l2_tlb_miss.all) / instructions",
>> +    "MetricGroup": "tlb",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_itlb_misses_pti",
>> +    "BriefDescription": "L2 instruction TLB misses and instruction page walks per thousand instructions.",
>> +    "MetricExpr": "bp_l1_tlb_miss_l2_tlb_miss.all / instructions",
>> +    "MetricGroup": "tlb",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l1_dtlb_misses_pti",
>> +    "BriefDescription": "L1 data TLB misses per thousand instructions.",
>> +    "MetricExpr": "ls_l1_d_tlb_miss.all / instructions",
>> +    "MetricGroup": "tlb",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "l2_dtlb_misses_pti",
>> +    "BriefDescription": "L2 data TLB misses and data page walks per thousand instructions.",
>> +    "MetricExpr": "ls_l1_d_tlb_miss.all_l2_miss / instructions",
>> +    "MetricGroup": "tlb",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "all_tlbs_flushed_pti",
>> +    "BriefDescription": "All TLBs flushed per thousand instructions.",
>> +    "MetricExpr": "ls_tlb_flush.all / instructions",
>> +    "MetricGroup": "tlb",
>> +    "ScaleUnit": "1e3"
>> +  },
>> +  {
>> +    "MetricName": "macro_ops_dispatched",
>> +    "BriefDescription": "Macro-ops dispatched.",
>> +    "MetricExpr": "de_src_op_disp.all",
>> +    "MetricGroup": "decoder"
>> +  },
>> +  {
>> +    "MetricName": "sse_avx_stalls",
>> +    "BriefDescription": "Mixed SSE/AVX stalls.",
>> +    "MetricExpr": "fp_disp_faults.sse_avx_all"
>> +  },
>> +  {
>> +    "MetricName": "macro_ops_retired",
>> +    "BriefDescription": "Macro-ops retired.",
>> +    "MetricExpr": "ex_ret_ops"
>> +  },
>> +  {
>> +    "MetricName": "umc_data_bus_utilization",
>> +    "BriefDescription": "Memory controller data bus utilization.",
>> +    "MetricExpr": "d_ratio(umc_data_slot_clks.all / 2, umc_mem_clk)",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "umc_cas_cmd_rate",
>> +    "BriefDescription": "Memory controller CAS command rate.",
>> +    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1"
>> +  },
>> +  {
>> +    "MetricName": "umc_cas_cmd_read_ratio",
>> +    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
>> +    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "umc_cas_cmd_write_ratio",
>> +    "BriefDescription": "Ratio of memory controller CAS commands for writes.",
>> +    "MetricExpr": "d_ratio(umc_cas_cmd.wr, umc_cas_cmd.all)",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "umc_mem_read_bandwidth",
>> +    "BriefDescription": "Estimated memory read bandwidth.",
>> +    "MetricExpr": "(umc_cas_cmd.rd * 64) / 1e6 / duration_time",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "1MB/s"
>> +  },
>> +  {
>> +    "MetricName": "umc_mem_write_bandwidth",
>> +    "BriefDescription": "Estimated memory write bandwidth.",
>> +    "MetricExpr": "(umc_cas_cmd.wr * 64) / 1e6 / duration_time",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "1MB/s"
>> +  },
>> +  {
>> +    "MetricName": "umc_mem_bandwidth",
>> +    "BriefDescription": "Estimated combined memory bandwidth.",
>> +    "MetricExpr": "(umc_cas_cmd.all * 64) / 1e6 / duration_time",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "1MB/s"
>> +  },
>> +  {
>> +    "MetricName": "umc_cas_cmd_read_ratio",
>> +    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
>> +    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "umc_cas_cmd_rate",
>> +    "BriefDescription": "Memory controller CAS command rate.",
>> +    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1"
>> +  },
>> +  {
>> +    "MetricName": "umc_activate_cmd_rate",
>> +    "BriefDescription": "Memory controller ACTIVATE command rate.",
>> +    "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1"
>> +  },
>> +  {
>> +    "MetricName": "umc_precharge_cmd_rate",
>> +    "BriefDescription": "Memory controller PRECHARGE command rate.",
>> +    "MetricExpr": "d_ratio(umc_pchg_cmd.all * 1000, umc_mem_clk)",
>> +    "MetricGroup": "memory_controller",
>> +    "PerPkg": "1"
> 
> Units of umc_mem_clk?
> 

Yes, per memory clock cycle i.e. umc_mem_clk. Will fix these.


