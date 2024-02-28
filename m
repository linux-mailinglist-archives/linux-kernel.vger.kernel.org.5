Return-Path: <linux-kernel+bounces-85450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAEE86B62B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0D51F27DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D615A4A2;
	Wed, 28 Feb 2024 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PVImyU5S"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5A36129
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141875; cv=fail; b=PvOgrSmZoVHZGe00vCfGYJ2pTc+oKZ5dQ13Sk7M2JhPjjMzaRil4T3/4aVMeBCYJGTPBBZDDuG4BkyW1nXj+GBH3deepVD8I417yOEF1OqgJODSAVyZWsdrrg4AUWeaaWaS+Mh3cplx3S1fECNFlNwARwmFKVb7qtrZH95RKbPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141875; c=relaxed/simple;
	bh=ISN0ghM0qixJrubOpSZhwPLLR25+FoY18StmHdq68Yk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lCAPQzuEKpWONNEs+WroPIMDQp+Gwr8y9ZVZ6r0qquMJbNSHn3p1CuJGb1bLpydf9/akBRYtHqOznmjnBUkSRrH+kC9MB18XkR5i45VHfqs4RCoutIyuX7oJ0yMtVYK0RaOxZ4HTqi//tC6+ZaEQ/eBTBr8qQS/nREjW8LJ0PnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PVImyU5S; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfFpG3G1pJ3rpPrO+/J4v2npQe+STxIU3ecpv5rAi4pe8SwMnpNoXHOsOx5tb6qKtiHxo6Hj2ZsBUEZ9N3hQV9sx9CUwRAswv+28oyRN7qD1P6dcNogF4i02QUUc7DcFpemyKBi9GQFW1oXBbRBKW1q4W7UZkdV0+AGfjhwHKScqhi0fLcfOWycx8qxzcXj5vLSVc695pPomgbF8dgTxTmQlbVVBHrHxgba4lBejjA6eJZFoboNMmm/U0VRpV3sIGYxW2goU61jh/8bjG84141qSYyznId5e0l9sxYCOxuDHbUWP6amE2WvnnYs+1GPqYKfT/0WOmIhSFfEXs3Xomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zznocRKaxhAVINNkaGO+FdfNEKjph0IounojXBpRhJ4=;
 b=mzfLPrCwO1pkYjTq90WBcB/2uRTl8Bfnsqci/Lzefr+zGFTXwsvRLqENyDt3FQ55QLXV9PBlGVp0M2BAshCsJ2eywWrFy8AgmIWKEa/yER8FWRkivwxIiMm9ZU/3eTbtqkd9zvXkGQY/jLb3tAt3srrO9xtXb+bMFI3HH2hFZ4qfybds2FhBvIfH1HVC4yygw+L2Zq01LRDlAhxzHRCeSZmdi/2bfdwatJU6P/qrk6K1L4aIgdfj6/7nrymRwz87tzj8PBbvfJ52zIOpohCoyY9LTT3lg30Sj7/ymwxgekwKfpzLkI8m4ND1QNCAi1up4PIbYYe1v2W2B5zrr3k1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zznocRKaxhAVINNkaGO+FdfNEKjph0IounojXBpRhJ4=;
 b=PVImyU5SzhEORR1aY5tWNVG2Ok9LZ3iPQfZ2tzWEnwPxj4+kP0QSNu2GWMpa7mnIWPyxleibyBIRqWPyhdb9nQl9EibYVTB6lxS1nCzKmWQAcJupZFWIdJix49SNEuZ3SRZDClLlRjVNJaEYMWnZEcg/wA/hmSKn4xQz8rHDbOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 17:37:49 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 17:37:49 +0000
Message-ID: <c26251d2-e1bf-e5c7-0636-12ad886e1ea8@amd.com>
Date: Wed, 28 Feb 2024 23:07:37 +0530
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
 <0c606d04-6765-d55d-61ec-c3625daea423@amd.com>
 <CANDhNCpb2Ve5saKtnBgTeAQXFbaWf84G_ky-509ddsfhOhdiLQ@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCpb2Ve5saKtnBgTeAQXFbaWf84G_ky-509ddsfhOhdiLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbf3b04-61a4-4a2d-5c51-08dc3883fba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZY/XVrA586DlyDYITfO3e/EIUp9hMq367M85lYj8IHVzmR8rqGC2hdgFOTRt6LLYuYceNWydhWUwBg0FlhD4i3PU0h3lD0WWmDnC+BfMNHVL0UY9npHRwKnnK7Gj39mi3i5d4ngDCECy0OcHkd6GNPzRcBZCZtYShzJq9oTuzKEqwFJ0ukYBDKLYiF24yhM7VvaaZ8V89T72vDKuPLG+bgKzdINwqoIRdBDzryv/4kr3lFOIXNlmdbsjiUesSg/FigoHxveF4T28J/tAQDEooKTWhSj8jxJB9RaWNePJr4Cnl0CeZsmy+vBVvlO9RqmJnhwypEhPaImXXvSJbi4oB+HFyBfR/ZEpYZprYdb/sCZhR2fcyEws2w++R+wUDpniiwbIxYeCXGKzfFYcB3gRWABwC1n7bV3JTd0iqAy5tfcL0MmQse/BFqqLyxMFfSTFY0zltNX81b7u2vDPyvG/Z6fZi4DqZZlTw/YBJheuQb3Z9jPVMfESXFNEm3GbWJ0fsXHDU61viUEtA9mPlId067AMVRlT5KtrpQqbA+/alqcsRIGfcrshxNXEQCkgp7Y7CFkfIqFCn6hhfDIufLeBLbmd5gPotIJnxWxq8J9JxirygEStLtXCrnCdHFauQw9mRN38/oi8ebLVUV14d7Y7xw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTFsTWlBc1lrWFJlNldQL256ZG40UGV5T3BvRlRYcFVkRVNXMEZUa0FMRDcx?=
 =?utf-8?B?VW1La3MrbjErT2JIVHFBYVFHbWpMNmtOTlVlK1cwWGZmSUJMTWk0YzFjZGVO?=
 =?utf-8?B?SXhDZEVRMVdiT3dCd2pia1ArTktzQXNpcjJzL3p6R3U4cWphamZxYzBOVEU3?=
 =?utf-8?B?dGtvU0kzVEZuakdNWXFFTVhKSXg1T1BSTmh5RktMbnczV2tOazE2Z0p3RGNH?=
 =?utf-8?B?ZVpMZm0waDFmWjhBMXpZWWJCVUc0L29NdjVnSVFLeGNUcm5oL1lRWjMzTGRi?=
 =?utf-8?B?OXpOK3ZLbjlpbUpvL0pCSWJsNmV1dVlOa3lVVkt5a3VuTXpwOW5QT2w1bHpI?=
 =?utf-8?B?ZE95aEhFNUc4U0l1YjltMkpxc2g4emFlNktVWWd5c1dMMDlScXRlUG5TY3dl?=
 =?utf-8?B?dTMxYW92YlQyR3NSZWVOZFlVZk5sN3Bha1Bmc0ZxamtKdkVXNmF4RHdJdzFH?=
 =?utf-8?B?TjkwMU9RUldtODFjM3NGbXdidWdVL2w3cFBpaG1xZHRGTnZLVVdZSGg3WHRn?=
 =?utf-8?B?WnN1R3ZTaENqa2VvUTRueTdSWnQ3MWpvRCtjem4zTTMzWC9kUVdFWk1XKzgz?=
 =?utf-8?B?MEFCTnU2ekM1VDNlZS9McjNXT0hxTVdTVWdRUHBrUytiZmMrT0NXVDcrbzBv?=
 =?utf-8?B?OFFBcExEak9ZWDdLcU1zOXJ4c3A0Z0lUM0dTSkRJbTF4TTltNFdUOXkrVWto?=
 =?utf-8?B?MEJIVlYzSTZhb0t4Z3JPdXFBUTR5RmNHSFJxUlRsUEIvWVNvN1B5NHY4bXVm?=
 =?utf-8?B?OGVyb3VPUHhNM21IUkREUm9YQVZ4ZkZYNVRWayt5cTB6b0NHRktEeXUxNzQ5?=
 =?utf-8?B?Z0pTV1FuQXZsUWp5djdtY1QwTktGaTY2R1pkTG5PKzdEWlAwZ2lRZ1lUNjUy?=
 =?utf-8?B?TVpGNmQ2UktzUUh3eUljaEwrVE0rTitkeUxkV3pub0NzRDFmRUhJWlQvOFNt?=
 =?utf-8?B?WFRQb1AzL2VBRnBOL2dBRVBWakVoMitsNnM4V0hIZEJRVEdjNEh5OWZhbHJh?=
 =?utf-8?B?eG5WZm10VCtaYlEzU2FUWkx6ZThoM1FFbVM5UmozYjFTWThOZTN6T2wrUVFz?=
 =?utf-8?B?b2J5MnNkUlkyNmJZNlY0QkNCVWgvejIxWWhRdjNYVEVabDF1eHpQTXh6NCt5?=
 =?utf-8?B?bXlBTVNFQlF3bUcxcVdDWHVYcE5FVzIzQUV0TE9FZ3R2THNiVWM1aDhTb05B?=
 =?utf-8?B?R2VFS3pIR2tZdDR4WlB4M25QSkpXQmFhaGg4MWZLc2xjc2VmaXdlMzhJM1Nx?=
 =?utf-8?B?d3ZHV0hVNmZPUGhUc3BiVTNWejBmdlpwakF3YWp3bTkwU2ZnTXJua0phQ1l2?=
 =?utf-8?B?VGw1R2V3MGljWkRTVzR5ZEVOb1pVOVJiQTRrSnBnRUF1NE8yclE5SXdzdGV4?=
 =?utf-8?B?RklxbHNjSGc1TjVCQnUvQVdoR2x0RVpMbFQ1UXlkbi80OEN2NCtmNDlnTDBl?=
 =?utf-8?B?STY3R1BIbnk3MEgvRlJIcXRGaHB3RE45Qmpxcmd6VTlXaWxnSFhGb3h0Z0o0?=
 =?utf-8?B?cGtlazRZSnJxeklKbmF3Ny85UTl2dkZCcVYvZzMrd0FPMTROMm9UcUFYQ1h3?=
 =?utf-8?B?a2U2N0M2WFZ5bEJjVGd3TmdQaEhYUEdLL0NIRXpQUEFyYk1KdVNPeU5iNUF2?=
 =?utf-8?B?UWdjRzN2K0JRWHNWL0srdjlVV0hhWkgzcE1ndFlUYlZHR0NVSFNnUE9QOUlz?=
 =?utf-8?B?V29YRlNCcDlqV053WDZZZWtCd3FJSlhNWFdXajVhK2pqalhRQlNJZjFGbzhn?=
 =?utf-8?B?RW5VeVVSYUw5QWtvc0tYMkd1bXZtcWttUXVvWFhvNVArRGNvNnVKVEdpMXJR?=
 =?utf-8?B?d1lTR2Z1NU5MeFlFTEkxcDd0WGlHWml5QjF6WXVPS1htazlva2M1bFg3bkQw?=
 =?utf-8?B?VUtkTU54bnhZeGNpcXNZeXdNME83azZYekJ6RUprd2NxaEhuVmFXN1ZlNVha?=
 =?utf-8?B?VlpGODNKOS94WENab0R6RnBxMmc1WGlKdjNxR3hEZVVDdE9ZbDMzRk9rUGxO?=
 =?utf-8?B?OWdvSmkxYkdtRVgrMFVESXpNZ0dKSCtuMWcxRkpqbmViOHJ1Z3kvdkV6SkZ6?=
 =?utf-8?B?bllCd0hBVnlXaG9iQm13ME4xVWRZQzk5N05pSXBKMWV0aTI4bU5zSDljYmow?=
 =?utf-8?Q?BqqRd5dUpWcwaM8F8jlm44jvD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbf3b04-61a4-4a2d-5c51-08dc3883fba0
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 17:37:49.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PDyuL1uD7egwaOHlhjsGKqyl9v30CwMxsl+x4Mn+o/iYFR4DGeeAULVjorWDOLdiSVl8RaTgnWfNQaTJJ+JAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985

Hello John,

On 2/28/2024 10:54 AM, John Stultz wrote:
> On Tue, Feb 27, 2024 at 9:12 PM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>> On 2/28/2024 10:21 AM, John Stultz wrote:
>>> Just to clarify: by "this series" did you test just the 7 preparatory
>>> patches submitted to the list here, or did you pull the full
>>> proxy-exec-v8-6.8-rc3 set from git?
>>
>> Just these preparatory patches for now. On my way to queue a run for the
>> whole set from your tree. I'll use the "proxy-exec-v8-6.8-rc3" branch and
>> pick the commits past the
>> "[ANNOTATION] === Proxy Exec patches past this point ===" till the commit
>> ff90fb583a81 ("FIX: Avoid using possibly uninitialized cpu value with
>> activate_blocked_entities()") on top of the tip:sched/core mentioned
>> above since it'll allow me to reuse the baseline numbers :)
>>
> 
> Ah, thank you for the clarification!
> 
> Also, I really appreciate your testing with the rest of the series as
> well. It will be good to have any potential problems identified early

I got a chance to test the whole of v8 patches on the same dual socket
3rd Generation EPYC system:

tl;dr

- There is a slight regression in hackbench but instead of the 10x
  blowup seen previously, it is only around 5% with overloaded case
  not regressing at all.

- A small but consistent (~2-3%) regression is seen in tbench and
  netperf.

- schbench is inconclusive due to run to run variance and stream is
  perf neutral with proxy execution.

I've not looked deeper into the regressions. I'll let you know if I
spot anything when digging deeper. Below are the full results:

o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode

o Kernels

tip:			tip:sched/core at commit 8cec3dd9e593
			("sched/core: Simplify code by removing
			 duplicate #ifdefs")

proxy-exec-full:	tip + proxy execution commits from
			"proxy-exec-v8-6.8-rc3" described previously in
			this thread.

o Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)    proxy-exec-full[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.08)     1.00 [ -0.18]( 3.90)
 2-groups     1.00 [ -0.00]( 0.89)     1.04 [ -4.43]( 0.78)
 4-groups     1.00 [ -0.00]( 0.81)     1.05 [ -4.82]( 1.03)
 8-groups     1.00 [ -0.00]( 0.78)     1.02 [ -1.90]( 1.00)
16-groups     1.00 [ -0.00]( 1.60)     1.01 [ -0.80]( 1.18)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:    tip[pct imp](CV)    proxy-exec-full[pct imp](CV)
    1     1.00 [  0.00]( 0.71)     0.97 [ -3.00]( 0.15)
    2     1.00 [  0.00]( 0.25)     0.97 [ -3.35]( 0.98)
    4     1.00 [  0.00]( 0.85)     0.97 [ -3.26]( 1.40)
    8     1.00 [  0.00]( 1.00)     0.97 [ -2.75]( 0.46)
   16     1.00 [  0.00]( 1.25)     0.99 [ -1.27]( 0.11)
   32     1.00 [  0.00]( 0.35)     0.98 [ -2.42]( 0.06)
   64     1.00 [  0.00]( 0.71)     0.97 [ -2.76]( 1.81)
  128     1.00 [  0.00]( 0.46)     0.97 [ -2.67]( 0.88)
  256     1.00 [  0.00]( 0.24)     0.98 [ -1.97]( 0.98)
  512     1.00 [  0.00]( 0.30)     0.98 [ -2.41]( 0.38)
 1024     1.00 [  0.00]( 0.40)     0.98 [ -2.21]( 0.11)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    proxy-exec-full[pct imp](CV)
 Copy     1.00 [  0.00]( 9.73)     1.00 [  0.26]( 6.36)
Scale     1.00 [  0.00]( 5.57)     1.02 [  1.59]( 2.98)
  Add     1.00 [  0.00]( 5.43)     1.00 [  0.48]( 2.77)
Triad     1.00 [  0.00]( 5.50)     0.98 [ -2.18]( 6.06)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    proxy-exec-full[pct imp](CV)
 Copy     1.00 [  0.00]( 3.26)     0.98 [ -1.96]( 3.24)
Scale     1.00 [  0.00]( 1.26)     0.96 [ -3.61]( 6.41)
  Add     1.00 [  0.00]( 1.47)     0.98 [ -1.84]( 4.14)
Triad     1.00 [  0.00]( 1.77)     1.00 [  0.27]( 2.60)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:         tip[pct imp](CV)    proxy-exec-full[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.22)     0.97 [ -3.01]( 0.40)
 2-clients     1.00 [  0.00]( 0.57)     0.97 [ -3.25]( 0.45)
 4-clients     1.00 [  0.00]( 0.43)     0.97 [ -3.26]( 0.59)
 8-clients     1.00 [  0.00]( 0.27)     0.97 [ -2.83]( 0.55)
16-clients     1.00 [  0.00]( 0.46)     0.97 [ -2.99]( 0.65)
32-clients     1.00 [  0.00]( 0.95)     0.97 [ -2.98]( 0.71)
64-clients     1.00 [  0.00]( 1.79)     0.97 [ -2.61]( 1.38)
128-clients    1.00 [  0.00]( 0.89)     0.97 [ -2.72]( 0.94)
256-clients    1.00 [  0.00]( 3.88)     0.98 [ -1.89]( 2.92)
512-clients    1.00 [  0.00](35.06)     0.99 [ -0.78](47.83)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: tip[pct imp](CV)    proxy-exec-full[pct imp](CV)
  1     1.00 [ -0.00](27.28)     1.31 [-31.25]( 6.45)
  2     1.00 [ -0.00]( 3.85)     0.95 [  5.00](10.02)
  4     1.00 [ -0.00](14.00)     1.11 [-10.53]( 1.36)
  8     1.00 [ -0.00]( 4.68)     1.15 [-14.58](14.55)
 16     1.00 [ -0.00]( 4.08)     0.98 [  1.61]( 3.28)
 32     1.00 [ -0.00]( 6.68)     1.02 [ -2.04]( 1.71)
 64     1.00 [ -0.00]( 1.79)     1.12 [-11.73]( 7.08)
128     1.00 [ -0.00]( 6.30)     1.11 [-10.84]( 5.52)
256     1.00 [ -0.00](43.39)     1.37 [-37.14](20.11)
512     1.00 [ -0.00]( 2.26)     0.99 [  1.17]( 1.43)


==================================================================
Test          : Unixbench
Units         : Normalized scores
Interpretation: Lower is better
Statistic     : Various (Mentioned)
==================================================================
Metric	  Variant                    tip        proxy-exec-full
Hmean     unixbench-dhry2reg-1    0.00%           -0.67%
Hmean     unixbench-dhry2reg-512  0.00%            0.14%
Amean     unixbench-syscall-1     0.00%           -0.86%
Amean     unixbench-syscall-512   0.00%           -6.42%
Hmean     unixbench-pipe-1        0.00%            0.79%
Hmean     unixbench-pipe-512      0.00%            0.57%
Hmean     unixbench-spawn-1       0.00%           -3.91%
Hmean     unixbench-spawn-512     0.00%            3.17%
Hmean     unixbench-execl-1       0.00%           -1.18%
Hmean     unixbench-execl-512     0.00%            1.26%
--

> (I'm trying to get v9 ready as soon as I can here, as its fixed a
> number of smaller issues - However, I've also managed to uncover some
> new problems in stress testing, so we'll see how quickly I can chase
> those down).

I haven't seen any splats when running the above tests. I'll test some
larger workloads next. Please let me know if you would like me to test
any specific workload or need additional data from these tests :)

> 
> thanks
> -john
 
--
Thanks and Regards,
Prateek

