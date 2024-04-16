Return-Path: <linux-kernel+bounces-146154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7588A617E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131061F214A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEDA17996;
	Tue, 16 Apr 2024 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hBI1HHed"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B49156E4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237549; cv=fail; b=A+VXKNGHv9xl0wHjx3/1pLRar4aAvFmYJr+BUdNtZkI8Mg3FfpgqJ2VtI9K0hD7IWj0fd34RWCw68+D3sRAKEe4tETr67xgFauZphIP7+ciFAK4LqpgLtX7juvIIRHcqP6MLjJlkxb3wkTVem3FJeTxDyNZQ3cV2pOJ8SyzXNmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237549; c=relaxed/simple;
	bh=6khMzFMYtBhc75FZlammopfZ/bUwuZFJwRZQpEVxH/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XIjG57G8sU3pp/25G9LMYi+9USKPFOg885iMyuCZpEyWEww+Kmdd2gpxXULjbq8C1qoULk1R1S3yuVKrw0heZwY1IU12oZdYnSg0T4em3LlY+IyF7TO7KbS9E+0woUSLoBSDg/JV32V5t9MbD/0oUhKS6XtEHfOKrYLONsXoxRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hBI1HHed; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIzxc7U/RUQRXMSYooyUYodYLtMYkP0dXBSNNpmnf5s5vpTyKLt1gHi+9mR4Lo/qLUXdOmJ1mCxSdC3FMJl/kxs5q7WoiHihOIXmoK0w1koMfHNtg2vMiHd8iA8ztfAhu3KnpYfvRjwJXyxfsCJVLKbHQPjy7ll1sAj4kz7kqWu8Y0gya4dQaRduXw/5ioltoT0RP1nWnOybAQEEEXpejqLVCt9w7p98rxyeBqZ14beLonEg4v4u0Qr46QTrW7GUm6gMKTdQqpNeN3MwdCZAaezGZcBUZLcw1imu4Er6rO4m8k6KWgtLYhvLzbi7M6boxXwEnTwMoyEDo9P6m+WIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNnujxBezo4w66+mBxQwb2LQIogNksGIoWCTA0ePO8s=;
 b=EmJDadR1zpIww19r6mlI3gSRg82PodtnYlW4SncEn8wCzh7togwhnlqjwh8mc8u45g6W5ubCSRYqIMqG3x1/B+3Z9nx++fZZ3vN0qF5YDrCwr0ZWGTjEGIcGv7a7W5pRiAq4bO60gFWjZ2pIzuZEiFK9tvovIXYH5msBKqBtig6EfAKxP5qjKLUGhoAwMaZINH4UMOJDtzK0FjASObiN9sL3DIxriqZug2gu0Lq3rkkBOIl0NAiccC6znOpGKjMmx0IUEZN1usmQl7wVbxJaKzXoShRQ9CLqoT37OchvxZ4NK9urk6awrYGwRGCrq55EbefV/wF53oFPQJP/Bdo06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNnujxBezo4w66+mBxQwb2LQIogNksGIoWCTA0ePO8s=;
 b=hBI1HHedn2fSOVZpnbnD9YWoU7QgD3d9fZxy4b+42BGsMJtZncC1t39w+dDB90wODVoxPlfoo2QyjLZVAhLjF/NqfJH4F4SY1/EbkoIm7UnADRkGVBnpVTcnfPUS2eArfVAnci7cBWinJ9+6OfGPn9D5DS63oTHzf4eAYM8/AuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 03:19:05 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:19:05 +0000
Message-ID: <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
Date: Tue, 16 Apr 2024 08:48:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Content-Language: en-US
To: Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: wuyun.abel@bytedance.com, tglx@linutronix.de,
 Chen Yu <yu.c.chen@intel.com>, Oliver Sang <oliver.sang@intel.com>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
 <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d6f594-5321-4528-3536-08dc5dc3f8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8n/HQW9cP60R/5rSGkIsEjnJSo1PHw9h+jcj98eZxPXHD9pQ6VDow40YV8R31lgXAGUT12nt+6nbYRkg3dgvcJK5kqJNr3Nwf3i4Es8h7T0g/2vCxFjf+/Lx6dwVyedsU6BmMKMqm+94n539FOmqTY3HUjMOUmnkcfMBlRHBqpTjlK3moVUbOGkZghSQvDeM+haotDPZJu0EoBImGbvCH95BY7h1P9vf9JIbMgqtDhvXZYLH55U6BMpaf2FILeKgCv3PMJhIQMAypqU7kmQCitYZYym4DJ+QfBUVw5qrLjDQigHEY3lP3Efh6enPbfMiiAlEMam96nsFUUGYxWLhBSn/iNNloCd2k3Zkk0tuIfj3r0neakcngB56tU6zeQtms22eQ0lXU3NLZKjPf/f0DvBgxjqeR635CLQG2Ad6z+e7Ajxy7v4EaYidFPjf8VWE9pW8TH/CFQARghiHVYfdAx5IGBGH6PronJne3zslOlev7e44EiptTHv7dU+ySp9qU1J+kId2LPI2PvqgpA7NkTCmPicZZgBa4ZEuGDXXOGPGvWIwfdGF3PAJ/ZW/JmjEzlbof5vvL+Lx2Wlw5cFPemUiUCIfGdguKojTp28mEIhxZ9a7jEV9EHai/u5x9HdHNXh8TeIFBnWta6nAL+PJX5SrWadKKdTXhHs43bBmTLthn5t/o01ob5VrJAOcHtjfJMEdmeLqS/gqLDvurdmT6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlUzRlBHOVArVklpMnQ2d2RXWC8yeGwvbjZCZXY0WlZOcnZzeUQrUWRVYUdX?=
 =?utf-8?B?S3pnK21sLzVDblNKQ3FYdHBFSU5ydnRERnhqRDJicGtmVGVGS051N3IxLzZs?=
 =?utf-8?B?S2NGZFR2ZFppd1gzTGFJdFgzUi9nUWNHd1ZvcHNvSHJKTFo5R1BsbmpiSGZ4?=
 =?utf-8?B?M0oxVTRTZmJKdjJFVWdHYmNySlc2Z1JlbXJYc3AvRDluVkdRVjA5WnNxR255?=
 =?utf-8?B?VExTakEwMlRSRE42TndaVmRieG1LaTI3N052TStBZWxTeTBmTWhqU1pCTVNh?=
 =?utf-8?B?aTNPRTM3N25BSG1MbXYxMVFJWDJaOVBwT1pkdmFQUTlYRmNQN3p0WG1QYU1k?=
 =?utf-8?B?cFkxcFFvbDhIWU5TN1dTNElHM0tGbEpzT0wyN2E1eXBjOFlnR2pFMzVqTXlH?=
 =?utf-8?B?bTM4VElzcWV5VkpGY1QyRCs1a01pRUJlbDdidE5jS21rNzhYSThkT2JZdjdk?=
 =?utf-8?B?MWVlK0NBOTBTYVFvTlBDcUx6Y2FxSlZDd2hWcHo0eGZCdmFaRUFNYWdSV2hC?=
 =?utf-8?B?OUNOY25weUcvSHJNZFJTWW5lQWxUUTdUWis0Q0NJa3NLZTZTbkFLc3hpUU5N?=
 =?utf-8?B?QmZHelIxOHhOY3FFTDZlRjExYVZmdmp5eU93b01ZTnJCQWRlQmdQTDFrY2tk?=
 =?utf-8?B?ek5HZ0ZPNkk1RWNTUlQ4YWZVUXNrNXdWTGVpL2N4c2RhQUIrQ2NzSHZaT3A4?=
 =?utf-8?B?bUh0cERuaEpQTlA2ZWlnTGlBemJVUERKTzNXUy9tOGt6RGdmZHB4RDVtOFRL?=
 =?utf-8?B?MkYzNGJ5b2VHUVhWUDlNVXF1QWU4UnFNb1pyRDRxeTF3WTJWaUxjN3JnclAy?=
 =?utf-8?B?dnZEK1NSNU9DYjQrQ2xFUnRva0xUNzNNUnJZcWxmak1mSjBsUllKdjcybjY4?=
 =?utf-8?B?MVdTTGJqRWQyUkk0NXZXWEUwUmYvWVV0WjNJUTZoczFIMk00K3l5YlYydHFm?=
 =?utf-8?B?RS9yU29aUmV2ZHJDRTI2TjF1RFVZRURNU2NZanNxK04zcWhDMGVYdmRQR2ZO?=
 =?utf-8?B?dElBUThTWDJybUxyRVVSb3NEcjk1L0JYUTNTSUJOOFkrNlplRFBkZEVkUFRS?=
 =?utf-8?B?ZGxyb0FFeTJ1dTM2RTM3OTlMSFJXOStmUEhUQXExclNUc1RPZzQyRG56UFNU?=
 =?utf-8?B?b2p4OXhvLzBTWXJmZnhjMEY4eFJVbTBGNWdTakUzc0F1aEZJellQNUJ3Mlht?=
 =?utf-8?B?cUlrWG93dm4xbzNqYzJCMmxqYWwrMEVXZHl1M2l4RHhVRXkzZnkxalFLdnlt?=
 =?utf-8?B?U2lWcVdka0FEN2RyZnBiYjBlYnBOekJpZjE5eEtoV2k1VTlwRHBQbG1jRUln?=
 =?utf-8?B?MTV4UG5uNFF2ZUxKbFhXTHFLZXlVNzNhSEdOZXBnNURSRHJWSklRNWtOZ1Ez?=
 =?utf-8?B?b0hSN0xncDFqdlhtbEZ6RTVYM0M4MlJMbXI1eEdGZU9rdzR2MTF0TFpNUjho?=
 =?utf-8?B?Q1ZFSnR3UVZHbXFFZGVXaktmZlB0Sy9DWVhRV3UwYUJBOHA4YkdYRFNDbWVh?=
 =?utf-8?B?ellDYUxvNDE4dTVWWVJDQUorbU53UkpMU2lOQkltYzdmeXZBV0lqQlRMM3FM?=
 =?utf-8?B?UkdTVmVkalBNL3ZYc0x3a0VJWU9HUzlTOFBYYS95RDd1Y3NPL0QzaHdjRTAz?=
 =?utf-8?B?cGFZellIdHBOMjVSbmNiT0tpWG5sbnl1QjVTUUprYWFpbkJSTGxrN2hTRmg1?=
 =?utf-8?B?enMxRHQzd2dsUzZuRTZncUxKaVVoajREM29CVkxVbU5JUmJlVUNKcUxRYnBF?=
 =?utf-8?B?SkJhMzF2dVh2MGJNeEp5NmFLSDJZclpnYzVJZDFzeDRlL0hXQitzbjE2UWhR?=
 =?utf-8?B?NUs5L2Q0RStVZWdRRzJJVVFmRWFhOEQ3akIreVBoQ1VEbnc2NExXaXdEMVVz?=
 =?utf-8?B?eTB6MVJYR251d3RwOGhPYWZHb2dYYm5NZytHeTFncHJUR2tnZnlDbGt1YTNW?=
 =?utf-8?B?Z0Z1aUV0WXhXMFhkbnowUkV4em0wMzNkZnRCM3RMMGVQc2x1QjlJc1RNL281?=
 =?utf-8?B?ZzRvY09SQTYwNlhRYXhWN09KRTdsZ2h2MllyT0N6N0FiUHhWaTBzV05DVks5?=
 =?utf-8?B?NUx3djZKb1V2bk5RVllzMmNyZEhYcURwQnByZ1FvTTVyZGVRK0duZW1aRk1j?=
 =?utf-8?Q?6PyRYM0vVyY1LevrslfRtlrrG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d6f594-5321-4528-3536-08dc5dc3f8a7
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 03:19:05.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQ4PANeWPFtK11UnjkWGCPwupj55mUgeECm4gpVoj2uqGn6aTCTmjwbrRg3HTYlZyJwngf8VU2a0lngvWS5f2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657

(+ Chen Yu, Oliver Sang)

Hello Mike,

On 4/15/2024 4:26 PM, Mike Galbraith wrote:
> On Fri, 2024-04-12 at 16:12 +0530, K Prateek Nayak wrote:
>>
>> I ran into a few issues when testing the series on top of tip:sched/core
>> at commit 4475cd8bfd9b ("sched/balancing: Simplify the sg_status bitmask
>> and use separate ->overloaded and ->overutilized flags"). All of these
>> splats surfaced when running unixbench with Delayed Dequeue (echoing
>> NO_DELAY_DEQUEUE to /sys/kernel/debug/sched/features seems to make the
>> system stable when running Unixbench spawn)
>>
>> Unixbench (https://github.com/kdlucas/byte-unixbench.git) command:
>>
>>         ./Run spawn -c 512
> 
> That plus a hackbench loop works a treat.
> 
>>
>> Splats appear soon into the run. Following are the splats and their
>> corresponding code blocks from my 3rd Generation EPYC system
>> (2 x 64C/128T):
> 
> Seems a big box is not required. With a low fat sched config (no group
> sched), starting ./Run spawn -c 16 (cpus*2) along with a hackbench loop
> reliably blows my old i7-4790 box out of the water nearly instantly.
> 
>     DUMPFILE: vmcore
>         CPUS: 8
>         DATE: Mon Apr 15 07:20:29 CEST 2024
>       UPTIME: 00:07:23
> LOAD AVERAGE: 1632.20, 684.99, 291.84
>        TASKS: 1401
>     NODENAME: homer
>      RELEASE: 6.9.0.g0bbac3f-master
>      VERSION: #7 SMP Mon Apr 15 06:40:05 CEST 2024
>      MACHINE: x86_64  (3591 Mhz)
>       MEMORY: 16 GB
>        PANIC: "Oops: 0000 [#1] SMP NOPTI" (check log for details)
>          PID: 22664
>      COMMAND: "hackbench"
>         TASK: ffff888100acbf00  [THREAD_INFO: ffff888100acbf00]
>          CPU: 5
>        STATE: TASK_WAKING (PANIC)
> 
> crash> bt -sx
> PID: 22664    TASK: ffff888100acbf00  CPU: 5    COMMAND: "hackbench"
>  #0 [ffff88817cc17920] machine_kexec+0x156 at ffffffff810642d6
>  #1 [ffff88817cc17970] __crash_kexec+0xd7 at ffffffff81153147
>  #2 [ffff88817cc17a28] crash_kexec+0x23 at ffffffff811535f3
>  #3 [ffff88817cc17a38] oops_end+0xbe at ffffffff810329be
>  #4 [ffff88817cc17a58] page_fault_oops+0x81 at ffffffff81071951
>  #5 [ffff88817cc17ab8] exc_page_fault+0x62 at ffffffff8194f6f2
>  #6 [ffff88817cc17ae0] asm_exc_page_fault+0x22 at ffffffff81a00ba2
>     [exception RIP: pick_task_fair+71]
>     RIP: ffffffff810d5b57  RSP: ffff88817cc17b90  RFLAGS: 00010046
>     RAX: 0000000000000000  RBX: ffff88840ed70ec0  RCX: 00000001d7ec138c
>     RDX: ffffffffe7a7f400  RSI: 0000000000000000  RDI: 0000000000000000
>     RBP: ffff88840ed70ec0   R8: 0000000000000c00   R9: 000000675402f79e
>     R10: ffff88817cc17b30  R11: 00000000000000bb  R12: ffff88840ed70f40
>     R13: ffffffff81f64f16  R14: ffff888100acc560  R15: ffff888100acbf00
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #7 [ffff88817cc17bb0] pick_next_task_fair+0x42 at ffffffff810d92c2
>  #8 [ffff88817cc17be0] __schedule+0x10d at ffffffff8195936d
>  #9 [ffff88817cc17c50] schedule+0x1c at ffffffff81959ddc
> #10 [ffff88817cc17c60] schedule_timeout+0x18c at ffffffff8195fc4c
> #11 [ffff88817cc17cc8] unix_stream_read_generic+0x2b7 at ffffffff81869917
> #12 [ffff88817cc17da8] unix_stream_recvmsg+0x68 at ffffffff8186a2d8
> #13 [ffff88817cc17de0] sock_read_iter+0x159 at ffffffff8170bd69
> #14 [ffff88817cc17e70] vfs_read+0x2ce at ffffffff812f195e
> #15 [ffff88817cc17ef8] ksys_read+0x40 at ffffffff812f21d0
> #16 [ffff88817cc17f30] do_syscall_64+0x57 at ffffffff8194b947
> #17 [ffff88817cc17f50] entry_SYSCALL_64_after_hwframe+0x76 at ffffffff81a0012b
>     RIP: 00007f625660871e  RSP: 00007ffc75d48188  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 00007ffc75d48200  RCX: 00007f625660871e
>     RDX: 0000000000000064  RSI: 00007ffc75d48190  RDI: 0000000000000007
>     RBP: 00007ffc75d48260   R8: 00007ffc75d48140   R9: 00007f6256612010
>     R10: 00007f62565f5070  R11: 0000000000000246  R12: 0000000000000064
>     R13: 0000000000000000  R14: 0000000000000064  R15: 0000000000000000
>     ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b
> crash> dis pick_task_fair+71
> 0xffffffff810d5b57 <pick_task_fair+71>:	cmpb   $0x0,0x4c(%rax)
> crash> gdb list *pick_task_fair+71
> 0xffffffff810d5b57 is in pick_task_fair (kernel/sched/fair.c:5498).
> 5493			SCHED_WARN_ON(cfs_rq->next->sched_delayed);
> 5494			return cfs_rq->next;
> 5495		}
> 5496
> 5497		struct sched_entity *se = pick_eevdf(cfs_rq);
> 5498		if (se->sched_delayed) {

Wondering if you are running into the issue where pick_eevdf() returns
NULL despite there being runnable CFS task on the runqueue. Can you try
running with the following patch from Chenyu -
https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/

> 5499			dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> 5500			SCHED_WARN_ON(se->sched_delayed);
> 5501			SCHED_WARN_ON(se->on_rq);
> 5502			if (sched_feat(DELAY_ZERO) && se->vlag > 0)
> crash> struct -ox sched_entity
> struct sched_entity {
>     [0x0] struct load_weight load;
>    [0x10] struct rb_node run_node;
>    [0x28] u64 deadline;
>    [0x30] u64 min_vruntime;
>    [0x38] struct list_head group_node;
>    [0x48] unsigned int on_rq;
>    [0x4c] unsigned char sched_delayed;
>    [0x4d] unsigned char custom_slice;
>    [0x50] u64 exec_start;
>    [0x58] u64 sum_exec_runtime;
>    [0x60] u64 prev_sum_exec_runtime;
>    [0x68] u64 vruntime;
>    [0x70] s64 vlag;
>    [0x78] u64 slice;
>    [0x80] u64 nr_migrations;
>    [0xc0] struct sched_avg avg;
> }
> SIZE: 0x100
> crash>
> 

--
Thanks and Regards,
Prateek

