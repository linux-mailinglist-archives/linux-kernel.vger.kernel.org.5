Return-Path: <linux-kernel+bounces-85036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D286AF6E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89441F2693E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6ED1487DB;
	Wed, 28 Feb 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F4pJ0BJ5"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688173522;
	Wed, 28 Feb 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124617; cv=fail; b=N4lHpVA9nMOloN8I6kMSyS9xPYpq35772L5kGKfOZ0E+2N88ux6lphuuXCmwbMFbeWY5uXfarxV+uiIfJqIHLDThL7ha8vgsTT5+d5UDLnWy7mO7KvnRdS/WC8HibbSQ/TNkNloenYZuJ8onIUeHzxbOJ+XmCJNTtN6pjsUZCyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124617; c=relaxed/simple;
	bh=F9MOaP6UgGl5fISi0SXqco+lZR5uKdZDWPKkFjaFm3c=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FeYCV7Q8OjwsX87I+f1aESEdFqWnvHPjxX/5MUY7OevWGuXGsGhwrH1oOG4H6beDQBkMMcTNTDTygPXJNEzUCWaqyv4bpp6WWXZOUrC6MxyN014F36Jxpr+thHtTnqPAIxml5Pmm/TgbH7o2pZ7vMrTIrkSkuqXCKU63chXMMJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F4pJ0BJ5; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPf9Ty2L5r2bDD8cPmq9eOxWagesOlmKNbQhbmwmBw6mQE3+QZhHxL+ddqyatccf7bghHBqvx98E4i2zOJlohI9EQyDarHu/ZvkLcCI8zdVCbR6QW+ryzIa8SSOiLDGwKJHhvdWCEWYCH1G/8rAEMhqY87wmsolMyYV3mhwuy5YWa6t+hTYzNOUIFsmPBqoFZ2C24XfwtPgBO6fwPICjjI9obH7i6/2p96DaQNHnMSZdEmCyKdhBQjDUZHcTgXqS9xQkbPv+/VKb5VEBZ2u1enGcNCf5uY6I78+MVz3nO5lRMwCLT/RUa7nQTSnhFwuMA8VIG1bhwGET7YWvxlNx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFgy5rFy5y2km259MqTYGXGZgyzz389PFTbwWJ6yje4=;
 b=G3PA0j99VIpo0SYXegYQb8xhq10VMTtLHKn89lo9FG+HhyufMJs0qyO4XsoMB+Vc1/rXvk0jU+2QkGqHKA1T72vLd3OuEbTJ2XYTGGTaYIwwW+l5q8nCmHXSxk1bKUXU33wHLgkSJ+ESKzUd64w6v56OcaX6U0lG+tbLLAX5ZTcGpMqHifmiccFwQw20Qvu+gF5Dy27bVBM42W+19u5cjJyg+1WYevtu4yVhfPYrjRrgdnEDIjnu2PgjQVNXmTzO+iwwyqZREtjYkUnOny1qHMgXGtORFUXY8LH90ceqY2LnZhE6ixYe0Un0y9bAgEVLnJur1xcU0GEQz3aBy3Qtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFgy5rFy5y2km259MqTYGXGZgyzz389PFTbwWJ6yje4=;
 b=F4pJ0BJ5kogWRR2/rT65DsAP52hlNmiR+flnoDWDs09nIZ3WpFiEvQ/iR4X+7EijtuT9OEo27c4hY87MCgIOItHlIA4SESa6bbWq+AqdeXoSNxEochgcRO27bPtc9pYtLZChikF8NIBYZJjhUtMxyVGmjT/T4GENKZuHJBIe170=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 12:50:13 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ee44:e235:d5d7:94a1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ee44:e235:d5d7:94a1%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 12:50:13 +0000
Message-ID: <00f32f45-a423-2c6a-e53b-c132ed1cde50@amd.com>
Date: Wed, 28 Feb 2024 18:19:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v4 1/4] perf/core: Rework forwarding of {task|cpu}-clock
 events
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: peterz@infradead.org, namhyung@kernel.org, eranian@google.com,
 acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
 bp@alien8.de, kan.liang@linux.intel.com, adrian.hunter@intel.com,
 maddy@linux.ibm.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, sandipan.das@amd.com, ananth.narayan@amd.com,
 santosh.shukla@amd.com, lkp@intel.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-2-ravi.bangoria@amd.com>
 <ZdRluZx3fy0xx78D@xpf.sh.intel.com>
 <9eeb2273-9690-8f71-4f3f-595310d53600@amd.com>
Content-Language: en-US
In-Reply-To: <9eeb2273-9690-8f71-4f3f-595310d53600@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::25) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a68340-24a2-432a-46ec-08dc385bcdd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ymqim3mWNwXcJfmSAA0COpbrXRJBjbEXMZfFRhDyiIdPs6f4O2GMWx2L7KJCsf1EsRBPIoiQlfoYLLhaBT+ZWPrZcX3p/bA1R90X9IdgAl5E+OUaj110RegRexwQT4I6i9ms5/MiNey9kMJxjicNz2t1aB2sxVD0mZSKJ5etlQkLp6KDLHv3NNOE/ZoMTxqVqU5r/5JcXFcy0wSjhE9dRb6WjaMefHKmBvbdNHb16wofDE4z+qryoqkMrTNCNAeaCOFKSvwugr7P9uqufsWEK6/j7DRWUReUpDoJxolR9674W0095hM5quypLBMMWArm65Ewwf7cJQP24jx/ACr61f6Z1YpvtwrYU/AieqMgvXGHzQ16lB+/ZZO8X/Gz9Fy91j9QakpLdnRo4j0IGAIEsVt9ZiHhrg+l66rdbubvHrTwqat7zGM6gQHigBfiGZVW7IqA43QBUvtVv8ktF7+FTioQkmUFCEzY4EpgW7US6Z2c6Mj1xGZ0Bl9EbJJKxFmGJ95FfpJXBVCGSfowPSiB9PS7hzQ2ODiIlH4aVKqLt3roD9XHiHfvvk5+ORpZj+UY+4K5CnUfDr4WVW2UDr7g7y6ux72xeEbbqMDXRosQ+FVYakIO4vlnEyqN/g+is3QMLwSlrq2v4dHFZW/ne7YUfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDhIU09CaTFIU1FaVzhJQVVZbC9qRDZsWVQwMWV2Mm9tVXhEbkNaRVdxa3dX?=
 =?utf-8?B?dXlwREVCTndaZ1pWL3V0YzBQSjFmS29HM2dCRlA3RTUxOUltbTM0UEt5eTM5?=
 =?utf-8?B?eklBc2ZiQ1VEeDNqRWxiM3dDaCtTUlJFYUNERmJQa29OTCtkN1A1eWhkall6?=
 =?utf-8?B?ZkhNN0pYU09obnNVdzRnQXlFb1l2ZmtBT1lINmxWdjR1aTNDbEFvRVV3SkE0?=
 =?utf-8?B?TkZSYXpuWUJCSkliWkVwSjBxNzRjaUpVK3pQQlg2NHdtK0RCT3luaUc2eGsy?=
 =?utf-8?B?OUhQQ2lnODE0UmMzVlRFeTNxbmFMQ2JNR2VPT2plU0xabVFrdllPRm9SVzFU?=
 =?utf-8?B?SkswUXZ3ZE1LTWE5eVFyKzl4WndvaDFkTmJRYkg3RXRNSnBiRy82bXBJN1I1?=
 =?utf-8?B?V0o2Uk5ncjZEeWM5UHZ4WnRSWHNZRWcveVdwV1huMWF1UUc2ekRxd1l0bmxI?=
 =?utf-8?B?MzJHYWNWdlpnOTMxbVBvWm5MaXkyTGhYU3MzZG9IazRjYThUK2gxU3A3dzNu?=
 =?utf-8?B?elB0QjNxY0RKM3F4UjhHZytFNmZSOUkrdGJaVGhTRUNvNklJeTZ3MUduU09x?=
 =?utf-8?B?bWhpWDhjdlBwL0VpUG51YlN3Y2l4RXVzQXBOODIrdnM1YWlXZ0hsdW1IcTNO?=
 =?utf-8?B?dFprRVJJbnJPcE9jbnU0Myt1b21SZmQ0T2l2cWM0dHRhd2NXbVNZOVRiWmRy?=
 =?utf-8?B?eGNDZGxOY0dIdHNJY2NveEZ5SFF3SXVSbUxKNmIvOUd5NUdOMXR0ekVlbWU5?=
 =?utf-8?B?MEJnYWVocFVaeFVKbjlIeXNrY2I3NTJaam5hdUFmT0s3bXZoTXVhZmNsUlB3?=
 =?utf-8?B?N0pzUGhPdDRCMXVMQnhFMVZPc1gyV3g5ODFyTHNWMDJQMlpxblF0VXgxbG83?=
 =?utf-8?B?NWxkS1lCL1pEWTNYS1VOQU9TLzE5SU5sN2VlWmQvZnBmNFZDZWtxZUIrRk5S?=
 =?utf-8?B?RU5uVzl1RDRHMG84Q2hReEhvblFwV3EzNHkrWS92RXowNkxRTHhuNno5M2JR?=
 =?utf-8?B?VlovZHpPd1EzcEJhMXhKeHpFNFJCaGw4Slk1aTlIajE4WHpFeFRPUXUrWlUw?=
 =?utf-8?B?bTNmWm1FMkNDdUFWSW82SGUzR2NtQmE2cHdSaHh0TjJLa200QlFYMEdCdWp6?=
 =?utf-8?B?NFFnSGJTNFpNSkJuM0xpU2pacVNsTlo3Wm44M3lTVzVodUJxSEpBNHRwOU1w?=
 =?utf-8?B?bW9IMm1HbFR5Q0tBa29TeTVoc1c1Si9zVUNqK3lWeEFpOGV3dTVkSVN1QTZo?=
 =?utf-8?B?M1c1SWdRandGV1A4QUJlQXY0WnJKTS82dVhOVzBQZVR2bEpUckxtSXFFUFFH?=
 =?utf-8?B?UDNIOVlWUENBenJiRVY0eVdNRVltRVYyVFlNVHlDZlZSY0psbUhqTGJiNnlj?=
 =?utf-8?B?S2JSdUYyTkhuTk92SHA4YTV2OE1NZmhHZXNYYUdCVjhGcWRkaXFTUDF3ZkhW?=
 =?utf-8?B?SkpxSFVEdlp3dkxOaFZaV3pSdFNBMkU2dWdzNndxWkVyVW5NRk1BRDV0cHlF?=
 =?utf-8?B?YmVtdE1xQ0d3TUc5YUhud0svaUllMkhRSUlOR216RUM5V3ZOa0pYNjlVUTRm?=
 =?utf-8?B?czI0OXVPMTlqSHg0cnB6cU5DTW0vK2ZldmlmTWxSbWdNeHNpQk9wb1JQcWJC?=
 =?utf-8?B?UG53dHhsT0tiOHg3dTFPQ2tWcS9KVUt1Nmk4Uk9UbXVwdHdseDQ1M3l6NHgw?=
 =?utf-8?B?UmhrdjVKYmh4b0ZVRzk3QVp4NllERGIycmUveWFib0FUazlTNlZET1NrOFpI?=
 =?utf-8?B?MHNvbkRCeWU1dG5uOC83eWVHWmVSdVZIdkRXY2xDaElRY1FnelJBR2pGVk1I?=
 =?utf-8?B?YXJ4Zk10VkZQMjE5UFc1ckNBV0RhMkRscnlyOExsWWpMMlVaVWl4Q2hBY25N?=
 =?utf-8?B?RkZEUEwraHRZTStsYzJDbkNnbEdmZEtacUlBQ1hYWE1zdFBtRTkxbHlyRDlC?=
 =?utf-8?B?elpQQXZOUFlVMWRGY3FIM2w5QXdaczBRdHJ0ckcyek50Rkd5b0ZWRkpFS3pS?=
 =?utf-8?B?eFA0RjQ0aDFzZjR1MUs1VlYrQ21Kb09DSDVodkRpZlE5VDRsdVVuWEtwQTdI?=
 =?utf-8?B?WmQwQTBvUExkc1JhK3ZLY3Q2ZkxUSHdpZkdYZjFKSU1MOW9ualgvRmVNUzZY?=
 =?utf-8?Q?xo/tPuQhehpYuapQV7XzTE/dE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a68340-24a2-432a-46ec-08dc385bcdd3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:50:12.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iy1euVKdCi6TKF5DW9WPXLLzf1ZcnAuGSasmU2Wa7hzsiCIAXkk/L5Sij8rVW5ZcW67Eqf3YL6Gj7CXJw9y8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355

>>> Currently, PERF_TYPE_SOFTWARE is treated specially since task-clock and
>>> cpu-clock events are interfaced through it but internally gets forwarded
>>> to their own pmus.
>>>
>>> Rework this by overwriting event->attr.type in perf_swevent_init() which
>>> will cause perf_init_event() to retry with updated type and event will
>>> automatically get forwarded to right pmu. With the change, SW pmu no
>>> longer needs to be treated specially and can be included in 'pmu_idr'
>>> list.
>>>
>>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>> ---
>>>  include/linux/perf_event.h | 10 +++++
>>>  kernel/events/core.c       | 77 ++++++++++++++++++++------------------
>>>  2 files changed, 51 insertions(+), 36 deletions(-)
>>
>> Greeting!
>> There is task hung in perf_tp_event_init in v6.8-rc4 in guest.
> 
> Thanks for the bug report. I'm able to reproduce it. Will try to spend
> more time to rootcause it.

Although the bisect has lead to 0d6d062ca27e as culprit commit, a minor
change (shown below) in the test program can create the same task hang
issue even with 0d6d062ca27e reverted.

-   *(uint32_t*)0x200000c0 = 6;   /* Use cpu-clock pmu type when 0d6d062ca27e is present */
+   *(uint32_t*)0x200000c0 = 1;   /* Use software pmu type when 0d6d062ca27e is absent */

So, 0d6d062ca27e is not the culprit commit.

Additionally,

o I've seen task hang or soft-lockups on a single cpu KVM guest while
  running your test as root and also as normal user with
  perf_event_paranoid=-1. But the same experiment on host, no lockups,
  only task hang. So I feel the bug report is false positive and there
  is no real issue (since the experiment requires special privilege).

o 0d6d062ca27e has inadvertently started allowing cpu-clock and task-
  clock events creation via their own pmu->type in perf_event_open(),
  instead of earlier design where the only interface was through sw
  pmu. Is it harmful? Probably not. But worth to be documented:

----><----

From c7ae1c57e2a23a05eb982524d37bc8542c9c9a34 Mon Sep 17 00:00:00 2001
From: Ravi Bangoria <ravi.bangoria@amd.com>
Date: Wed, 28 Feb 2024 17:29:04 +0530
Subject: [PATCH] perf/core: Document {cpu|task}-clock event open behavior

The standard interface to invoke task-clock and cpu-clock pmu is through
software pmu (see perf_swevent_init()), since these pmus are not exposed
to the user via sysfs and thus user doesn't know their pmu->type. However,
current code allows user to open an event if user has passed correct type
in the perf event attribute. This is not easily apparent from the code and
thus worth to be documented.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 kernel/events/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0f0f71213a1..4072bccab3ba 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11178,6 +11178,13 @@ static void cpu_clock_event_read(struct perf_event *event)
 
 static int cpu_clock_event_init(struct perf_event *event)
 {
+	/*
+	 * The standard interface to invoke task-clock pmu is through software
+	 * pmu(see perf_swevent_init()), since task-clock pmu is not exposed to
+	 * the user via sysfs and thus user doesn't know perf_task_clock.type.
+	 * However, allow user to open an event if user has passed correct type
+	 * in the attribute.
+	 */
 	if (event->attr.type != perf_cpu_clock.type)
 		return -ENOENT;
 
@@ -11260,6 +11267,13 @@ static void task_clock_event_read(struct perf_event *event)
 
 static int task_clock_event_init(struct perf_event *event)
 {
+	/*
+	 * The standard interface to invoke task-clock pmu is through software
+	 * pmu(see perf_swevent_init()), since task-clock pmu is not exposed to
+	 * the user via sysfs and thus user doesn't know perf_task_clock.type.
+	 * However, allow user to open an event if user has passed correct type
+	 * in the attribute.
+	 */
 	if (event->attr.type != perf_task_clock.type)
 		return -ENOENT;
 
-- 
2.34.1

