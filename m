Return-Path: <linux-kernel+bounces-84524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738E86A7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8C528984E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6246820DE9;
	Wed, 28 Feb 2024 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5G4F82rh"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4720B20
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097174; cv=fail; b=AoNwr45J6zAsJKj47yuVX3gmYOSsTJvuvJfSWVi1mRbXnhLuLO0z8hCSWO2OJ9jvDoiwmnrVn6Q0JM+Ffsiq2doxoyqhDbYRABQsr2Axei1PdfT60LLWp6PlGmHhcGuUU4ILjgQw3DFWUj5VYyXmILy0OnGkoVxMdUyd+al8iIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097174; c=relaxed/simple;
	bh=w2yXVPb7Iev0qKlQ7JtLV6qwA6d5Y9fewM80mMc2REU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i+1HFxyDhK68Dg/sZnaR8xev6MUkJmA93QEraaPEpe8ooaaUi23ocGSZN0tDpRCijCanRh9ZQ9CIna+3gn2YtlEnRj1J3kOGqL6Jv7RB9N6wGZ5fMR+CLSNGmahbknaxOIPIae8uH3QubGQvhs5M8PfMnoYaaE5c24xqTvaFj6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5G4F82rh; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hll7iWQ0F5HpuSkE+2wSMVoyXBdDWqksBv2lHWpFr/0VYmvDNZfWw7QgstSF1iCSMiWtInPT/onSzw5lBFadLLQZkAnZprseQJqr1kSlYD2XGgAwtaJg2fHx0QoB+sFt1Salm2VXo/oACCMZGqtH5wvruBYmdqLEoKW2kF9bZMyizK9hzsjNMHT0Mo2r8bFxQ9JAUnzwb0LNS6LP5NVbR5SIFsOEhQZghIxnXUvdSW4kFDkg3BhOnvfuMPzdPXe279J9YoTxLMP6qXS50a1ONCCZ3SiRfBtrhswkm/73NEgjQuucUxYwR1QmH6XfpNqSLWH7r5s2h/en1MYjdoO9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVWB1xbEZ+5ACUD8CcfU3L1Z+zXqEOOWkxj+Zir9D/w=;
 b=KWsyAG3G0tunYMzXsNO+7596UEgFikHjVifQNkNfPRTgVanA+u6bhHb/JDc2Ij/J8lvU8++CM8mR/LFim/kNxVQOtLIRyp5wR4jWL26HBpC/s3ke8J6uQcXfTHdI4FifL0Z0ZP+ZHWtBMW7mPnSrrMHe6S1XqLNLFnQLT5j74XHOdQdEextI6CRVDyjE3rx52suglP8nIGRNNwo8a7xxae4RWRDT2JP8rNGSr7IGG85xcbdn3B+KwCkHrbOAYZTo/CZ97CfK16HtdsJYZywICi/PeBqhe4jPVvA0InjAasp2eVGsss3smPd0bTMSHT7vMPPLd0juLSZqFgcM4lWOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVWB1xbEZ+5ACUD8CcfU3L1Z+zXqEOOWkxj+Zir9D/w=;
 b=5G4F82rhiwA5bOys5z3AGQCTdI/M/kATKNREc6E7zz4hZ4eWzRrUBbim4gKEgBoRbVjeXMVKruWHw4LOtT4rl9iQzKq6wlE0vjeTAIGCvAQS6HirkIQi8r/N2Pxplhj1oVduBmsKOOxMBhcHv0DBqGdJgT6Rh80VViZGKgfDt+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 05:12:49 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 05:12:49 +0000
Message-ID: <0c606d04-6765-d55d-61ec-c3625daea423@amd.com>
Date: Wed, 28 Feb 2024 10:42:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RESEND][PATCH v8 0/7] Preparatory changes for Proxy Execution v8
Content-Language: en-US
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
 Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
References: <20240224001153.2584030-1-jstultz@google.com>
 <3937e057-6b47-77fe-9440-ade079ee2cfe@amd.com>
 <CANDhNCqUrd4RNfKKMPRZj9ft1tTMNZq-XgYsU1dHpN4ixcZuJw@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCqUrd4RNfKKMPRZj9ft1tTMNZq-XgYsU1dHpN4ixcZuJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf84777-7e91-4ad4-fe21-08dc381be880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cWg0NclgTgVL35xjOrr13C+hRNuCNTPlOnxRFrmiS3dEDD7DLyvfK8GZ0s2hbndn9YcOd99V1vFmK7xs6ZnULAdpRQQx+CqYMVR+VQwV5ExIOSXu+Jr2dejXlSTaKKVvieGRFaMGqVxFISW4pFit2Dl6xupRsZ0afHkaN5O8r0L4dkgJufUC46PjdJCjxQCWaG9ixB4CwRusz9alIYSX0dANfLmsr/s42VeKUWhk6+kivgKxZTy4fanwwDwMH3schRxZ/1Rcq471WDXFt5G0j69gDJmZ/oYvHL/YC3jeq2iQ1ymrYefPArUWDpd9EiGUcBkPDBhHFtJPQ1uDh9IpZnyQzlbL638yWvNnkfXUOU0z/FR+X5ekaQAZaY7aQ3PLE/RWVTPC3BlOT6zwPp1VdCbCMS/eIPIsCuxsEN6zi7tywh2D/G37+pJHCqNkrPpYw2JvdrJ7bDn6U0XBC/5457yPPPUANLUlFFzET6BNceUEUUWFQfNFOFUSe1OBpoeT1IbvCbrOIPvaU3yxIGeSli1zKkE4plo/gNS9vy0Y5Z88WMAC5FnWTPhrjjeugzN480ACs1KY0eiBuLwtiB9/9C/iwW9K5vt+7OLj9MwYpzQVE8wI6YwgGsynwTHBzWFBbFAjzRoLYYIyL242XOaSGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHBIcVRLUzNEZ080WUNFdExjOVhxMVBicUJPVDdKSlQySzdvLytsYlM4bm5L?=
 =?utf-8?B?Sit0VC9NdkNQeDhVYmJTVkRFQzVLNmpVZDdjK2pyYm5wVU8vSHlTaE5aVy9Z?=
 =?utf-8?B?QTAxc3BFOUhzSksyY3hxYktlRVZLVWJmQnVuVWFXZVBsSVVBUnJZY21wSFp4?=
 =?utf-8?B?akNwSTkyUzBFRHJxWUtjaEU0RUkwT09WdmdPSXpiVVIyZUR6aXAwSXlZZXhr?=
 =?utf-8?B?T1VkTlN4WWhJdy9EdGE4NzZISzVQeUJoV3owbHA2Vy9pZEhGU01SVnkxK2hK?=
 =?utf-8?B?b0VzTDJNNHAwSW9ZMU9iOFU5U2xpb0o0SGdHVUZqZ0ZQd0RnenU5NlZCZ3la?=
 =?utf-8?B?TGRpTGZGNEYxdXhCRkEycnNVOThzQThoSUlEdUMvdlNEYXpFbXM0VVJneDVn?=
 =?utf-8?B?SllTdko5cldQMXk2Zm01bjNSWGlMcGpnYVAvR0VmbVh2U3NtNnlSSDNmem1H?=
 =?utf-8?B?UUt6TStGM0hVMGpUM0RkMGYzVUM3cnRCVzBsMTJaZ1lYN1M2clNHYVJYbG9m?=
 =?utf-8?B?ZXlLWk1ENTM2aFlXQUpzNHRZRnZDNktXc3prN1ZHSVdGU1RDbUJCUE1ITHh4?=
 =?utf-8?B?dUtGMUhYZEtVWkQ5VW1QSUdyQzhUek1OWnd5a3BPdEJ4MmJJeXlYd1VIZnpx?=
 =?utf-8?B?S0tHTEUrbjYvVnViV01PaVNQTk40TlZ5L1M5QWRhbzIzRDErRFYrais3Qk8v?=
 =?utf-8?B?VEk0bjJ5UkJZV3hpYjhlSFkxZUdCc3VjWG5WZ0NlVnE3NTdMSWpwMkNPNGd0?=
 =?utf-8?B?U0RTME9mSWphRllKUHdtNTN1SHJIQVE5dHh3ZHBiYXpGb1RBSmpybWVPV3JW?=
 =?utf-8?B?QW1GRGpibHJHcGlyWW5JeElKcFV0bzFic1Q2QlNGQ1c4eFkzT1h0MDE1QlJz?=
 =?utf-8?B?VjdMQjhlemJsUjhZNHBxd2RRa2lENldGWDlXK2tlTkU3YUFaaGlPSUh5M0hj?=
 =?utf-8?B?OFBSZ3ZBOFhhQ3ZZaUFEODRVMXVnTnUxZHhmTzdvZTRuUWRucE1SYloyZXdT?=
 =?utf-8?B?MGZsSFFsUjBROW5iRlE2Mm9HMDVYakk5bWdMVEJBelRTcnpaT055eE5aN1Jz?=
 =?utf-8?B?bmtJcGlsdE9zMVMyZFplTXRCVnRlMllqME5ZeWtyWHFVenNFUWNnbXRod0Iz?=
 =?utf-8?B?S0szQWQ0cEtzL2ZWUUU5aVozOHJoQXViN0Q5UnA4Y0FwSWVDZVk1Smc5TXVK?=
 =?utf-8?B?ZHBYcnNIZkNmU2J0bTIvL2dBT0NCWnNXNGRFa1JtT2I2aWFXUlhIUzRidk1J?=
 =?utf-8?B?cDRvZjZ3YUFQMXRtR3RKb096bEJHeFBmVWNnYVB1Y2V6SnpBYWgzRGpPNlhB?=
 =?utf-8?B?aSs4eVoybUxpbXBncjh2dkxMNDVyUk5lbDJTcHR6RDdZNHhtS0VMR0lWQU5s?=
 =?utf-8?B?ditUbnVzUGR6ck9hU0huM1QxOUxPK0lMWGx3SFF0WEZJaWVBZStONjlsVW93?=
 =?utf-8?B?VWd4aTN6SkdmdlNDNm5RNHRGK0tWbTVvdlJ4eUQ1WjdHZlFSaW02NU11TFhL?=
 =?utf-8?B?M0JoRnB6Q2Jjc1hxMHBpL25UZHZmSThvSUpQbFZVbUVxVGxvWXNjVWVMNnRQ?=
 =?utf-8?B?KzVqbGRHQWE2amd5WWZBV1RQZUUwa21tZm5XWUlYYU9mOEI5ZDYyT3dGdlpB?=
 =?utf-8?B?Q0tWZDNobGNldlFZNkJTemk3NERmZ1VmMm14a0NkckZXOE1SNzdtRmEwQ1ZD?=
 =?utf-8?B?cy9GK25ISTFLS3A5MmQ2emZkaFlEenlScXllcURmVnZBWTlJQ3kvTEZMRHI3?=
 =?utf-8?B?UlVpdENsTXpPNUhoU3ZPZTBJK0k5NFRvdDU0aVdsbU45cUttSEQvbXh6SUlW?=
 =?utf-8?B?MVRINldoSVR1K3kvMzVNY2RNUitiaDZZS0prWE14Rm1mb1dDU3EzSUdRbnZP?=
 =?utf-8?B?YlhISEVwakNMUjRTSFBpZkg3UU5NbEVmZkw3OVVXUXdPWXA0d1hTajFkZE1N?=
 =?utf-8?B?M2VPVWlRNWZyU0Z5LzVJUEoxa0pwNG9vL3hWbmp1cW1YaTdpcE0wb2gzcEFp?=
 =?utf-8?B?c09VNU56dllJVW1BYWo0bXZnbGl1Z1d6amRlVk1mcTM2R3VESjdOTFdMV0Qv?=
 =?utf-8?B?ZWkrR2xmN2w5RjJtWGhEYXFkSFBRVDdWWGhEb255L2g3YnoxVTRZcms2Z2c3?=
 =?utf-8?Q?zVlkTh2xmjFwQCgRpbHrVuVdj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf84777-7e91-4ad4-fe21-08dc381be880
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 05:12:49.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqSbC0WUVdFYGhZfPN/SyHdotwCodJO4uGGXb/d3sXu/1Ouag4f0y5R44s8PP+x1Iuc3oM6Fwc2OARg4mgRakg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573

Hello John,

On 2/28/2024 10:21 AM, John Stultz wrote:
> On Tue, Feb 27, 2024 at 8:43 PM 'K Prateek Nayak' via kernel-team
> <kernel-team@android.com> wrote:
>> Happy to report that I did not see any regressions with the series
>> as expected. Full results below.
>>
> [snip]
>> o System Details
>>
>> - 3rd Generation EPYC System
>> - 2 x 64C/128T
>> - NPS1 mode
>>
>> o Kernels
>>
>> tip:            tip:sched/core at commit 8cec3dd9e593 ("sched/core:
>>                 Simplify code by removing duplicate #ifdefs")
>>
>> proxy-setup:    tip + this series
>>
> 
> Hey! Thank you so much for taking the time to run these through the
> testing! I *really* appreciate it!
> 
> Just to clarify: by "this series" did you test just the 7 preparatory
> patches submitted to the list here, or did you pull the full
> proxy-exec-v8-6.8-rc3 set from git?

Just these preparatory patches for now. On my way to queue a run for the
whole set from your tree. I'll use the "proxy-exec-v8-6.8-rc3" branch and
pick the commits past the
"[ANNOTATION] === Proxy Exec patches past this point ===" till the commit
ff90fb583a81 ("FIX: Avoid using possibly uninitialized cpu value with
activate_blocked_entities()") on top of the tip:sched/core mentioned
above since it'll allow me to reuse the baseline numbers :)

> (Either is great! I just wanted to make sure its clear which were covered)
> 
> [snip]
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Thanks so much again!
> -john

--
Thanks and Regards,
Prateek

