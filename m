Return-Path: <linux-kernel+bounces-34713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A214838679
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEBA1C21DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5920E4;
	Tue, 23 Jan 2024 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2TdosJpw"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D371FBF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985926; cv=fail; b=pD18/kZbHq2D3Zt2EJsBX7r/ktnng79Go0VZPUvyPBjUyHulfeK84PYiH9AdoB05du7S8NlHP7ffs22hABsWerfjbkkv/LlBnUW7XNJJHdyB5clP3xBAKsJsRqXaRBbH2aS3Zt8miQwjGkUJh0Qv6e0xXgniamQi2l9aTxHlxzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985926; c=relaxed/simple;
	bh=Rl83s+5PWdH2Hw0TU4fFdMYKJ42lyPG7IsqLbNJO16M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aMh+Co+1jK4ZsCPfMSjzmXh/TGU0RSdwoew6Sda5synNXrI/krrgKmivYddnTPqHg+yUyUdyWNip767f0r9k3q+gFNqeitmOfTBulzm47Ern7/TD11PNueqTShL0zrY35l6McfZfjfoFO2fvk8LGoy7EpMOYTnPFQqW8XKh2RAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2TdosJpw; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGJ5flyBoxy+fgzH34QMq5fV2HS53RWLhiflWWP8jWOG2WHcv0RwXHUe9WKpDotmOz3jr4bRNgDfAQKccowQkpXFnTFUd9E1LcTaZptvUE3qiGOJ/apx58RzjihjDN1ePlLhtCPp1c0E2Y0aZ68Z7+dh0pi8dI8QjHAbCwSOKYAMI5KkGR86rE9eA50rRFEpMHeWBWY2P1HQy/osoFmJ7k66nla57tCP7qQDbg/k1zA/rCSGbhR13UiSqSd7j0nBrPJpbFzz2RSNd6YL9+5mQLJ7126+AgXhmIMC1ljk177yI2D1O9RsoYzBUAA7N2BzUdm+28k8RI6EPWiy6CEGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbm7401ecWLPhbaAxLwkueqWnIjBEI8GD3JDIW49KXo=;
 b=LbpGGVi0z+5Gd9dwGkqfbBKeLWCjnQz4BsGn3JGGL/w2TaBqAErtOe61NbEcx1+CCQqo44jCHXkzRVAP46SQuLZpY4Dknm/0iI9nd/S0Aqw/E2S72I6lu7XLRy24NUwLbk5d/97HGoNCh3vBP0vkzXN//Rl8+7Ffe8GLsDeX7sSLCpLHplprwpKl8VljxMCsVkFHXj77w7PQ/eUtVbKjUycYlw9fJvEZgcGxDG//sSwszqTiPiF0gVz8hRoT9kJneq1SWWSGenUMy3KqEqhuC9Njju9FzH5PiegH8oWnpfRGVHISVyGPFGk9cmTvPVmeMPRYtVzOByJjMZU3n93rLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbm7401ecWLPhbaAxLwkueqWnIjBEI8GD3JDIW49KXo=;
 b=2TdosJpwDkzpLOHi9nMgTX4UnX3K/7fN2g8f5J442ptWZWX+lSOTKIAZDkgviuOdAvjKH62JBws22JL3VYM+J16trQa1ZVgCfskwqD/Hj/7+3ey62+X2F+DL/0uAwB6QGdICVAniCeptMml65mquqO20EnkLE2QTaqCp323pA80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 04:58:41 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::4803:9b3b:a146:5b97]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::4803:9b3b:a146:5b97%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 04:58:41 +0000
Message-ID: <21c8694c-26e4-3bc1-edd8-2267b0164a09@amd.com>
Date: Tue, 23 Jan 2024 10:28:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] sched/fair: Skip newidle_balance() when an idle CPU is
 woken up to process an IPI
Content-Language: en-US
To: Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, gautham.shenoy@amd.com,
 David Vernet <void@manifault.com>
References: <20240119084548.2788-1-kprateek.nayak@amd.com>
 <b4f5ac150685456cf45a342e3bb1f28cdd557a53.camel@linux.intel.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <b4f5ac150685456cf45a342e3bb1f28cdd557a53.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::15) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 26486129-99cb-40e5-efa1-08dc1bcff7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t7BB9YVGtu11W2OKEmBsEPJT9CPr8S3B3VqJRP4awwO+tgaZMDdMoG/gNNTrVPmVwinEAaay9syfLmcrA91GvqzXDv9k+lxMuf2gcG4/idJHeAtusz8gxaJY3+ngy8biGEi8yr39svz1klQgaUvUGH2Ls5PI0PgU74i1EheH9dNIPmaBI2tJinkn57pUYSZG9cb7PMsf2u7pH2a4tzPYhCp6aPtJasyGSbOV3wDL48S9TZOCnQnknTFG5FZS5qEMUHttQA/On/Fw7BTtY60L+zkBUIjGPiYWf6C+j9qiC1xcjG5V6+mV5VdkXqT0ih0FrkJYfJYQqhVBz2zp3HEP9fTD6+Co4sPcmbZrAUHlQ/fLyWbvmzqJEJchzlFGGscmqfXYkEAEgduDJ/ejc38T8z/fb3/uqo66dHl6yuvDuW6s22KMJybdhFYr2w1t2DvjFmHHBD5o7ElmfAqRpoH0z+lchAoYcmW5QwEnsk6rkCYnwHBsr+cD8wKXarZhyPUNV7cLnMM0rpHpOb4Gc58T8Zswbqan6ZYVJ/hVuzg1n9latdtLM//J6zS7kIFwy73Nbt2/ixUp9t/j24rKj0Fz8btUnihfvcvzWX/WcyK38mCBMGaPzcQwJ0n47A3+NNAvU0Qnfapzq5KPem2Xs711hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6506007)(2616005)(26005)(6666004)(6512007)(53546011)(83380400001)(5660300002)(2906002)(7416002)(41300700001)(8676002)(66556008)(478600001)(316002)(6486002)(8936002)(66476007)(4326008)(66946007)(31696002)(86362001)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2l2YSt4ZmpFck96WmwvVUtZWmVrbWNsZG56ZGhkM0QveWVJYnY2UENzRXRM?=
 =?utf-8?B?ZHJVOTJ1YjBjeldmMVo3QWY3NnhGNVc5MHJNZmtBSjA2R0Nxc0wzdFF6KzJ6?=
 =?utf-8?B?UnE4MmcxMzMyNTBJcUNPK2NHMjU3M3lxcjgzYis5WUVsdlkxMjd4OU5ld29u?=
 =?utf-8?B?TU0rR3lVTXBqaURCMTZJY0ZzZnUvSUNka0tKbTZ4N25oSmhBME1jVmtSbFFQ?=
 =?utf-8?B?Ri9hOFIwcEVJWlVIb3FFeEwrVjBiT1lDT0Z0WUVTQ0pyeWhQaHRGUUdXanB4?=
 =?utf-8?B?MDJ3MjZieHhzSnJNYXl6aHFaa0hsYXN6VzdSVGQxVWhhbEloakoxVDFKeDk0?=
 =?utf-8?B?MTRyWTRkWTJzRUhNbmJ5aHpIekNiell5VEtndWk4aVJVenlJaTRYdGZTdmdh?=
 =?utf-8?B?eEFLUVV2M0dSczk2Ymora2RyRHpQaWhnWElyWjFxRk1SVnJlVXF5Ym1odmxE?=
 =?utf-8?B?STFiOWpRSU1ZamxJZzF1TDU0YmNzQUJjRzJTNnBwaVVhdU5TUWswZDd1dVcw?=
 =?utf-8?B?Y0pBckgwbXFmUDJVSWtuSGFEalIyMktHQWJJMSsybFplak5CMnUzRUdUc2d5?=
 =?utf-8?B?TUdIT21mYnZJWlpaKzc4SG13MFdhbnZJSitnM01iWXozY3k5YzRrcFBMOHNK?=
 =?utf-8?B?aVZKNGtrc0VCa3NWTmd4TzJwSEJrVGdCVUlVK1JnTmp6bGV1WXg4bnpLdkZm?=
 =?utf-8?B?bmd2RHpFN2xNL2Y5bnpVcWZ6T2dwYmNWaWUydHVWYVdIMWpzenlBcUVBRUFQ?=
 =?utf-8?B?d2JtejE0bUZWM3NVZHREVFdtUXR4dTN1TXFXU2RCSnVoMkN3YUNkODVoZG1P?=
 =?utf-8?B?QVdFWTYwVzNpOTd5dC9iRVZKM2xCSHlrQ2YvQ3lWUHZKaENpUUgyYk9iRnc0?=
 =?utf-8?B?cmduVUJGRTd5aXh5MUNPK1dnejFHSDMwbGpwSmZVKzZzUzkyMEVnNS9xVENB?=
 =?utf-8?B?SFdabk1HWHFIL01XaVpqNW9ZTTNTbnF3ckdWSmFJUDZZaWpPSUQ5cHlQNDd3?=
 =?utf-8?B?eXBCaFdPZllKMXRwT0RGYXJ3QnpZVmRGT3MzczZWdWsrTkF0aXd5T1VreEtx?=
 =?utf-8?B?WGlFdzluQllNSllsbXhxWk42TXZhbkNMOFJhaUMwN3dlWk93TFFKOE90a005?=
 =?utf-8?B?akZ2dTR5cmh6MlhjaCt4WXBrSmNTQU9mREtkK0VNcjJhZmxhTk8ySk9nZFNT?=
 =?utf-8?B?RDBlV1Y1bXhOekxyMVE4YjNST1FZNUZuazUyOHk1VFF0UnNuSlErc0JWd1hO?=
 =?utf-8?B?NjRJTkxxdVdoOXpwTE9HRnRtNEZHNUZKbnI1bnpKemJ0K1RUdjNmaHc1Qmly?=
 =?utf-8?B?d001WEtZdHd6czFVKzdUNHdpNTJsR0hxbXVFd3pNTXpLd3hvZDg3K2c5bUpt?=
 =?utf-8?B?TmlJYjZUc2R3YzNid0hNU0Z2WlJXaGp6NkxzRWFxaG5xSjZYbFBRd0VUdXZJ?=
 =?utf-8?B?RnF4Y0Y4b08yTXVIaTRkc09FMG04T2p0R3FoVWs2cldzQzVTbndQZUdUaVM0?=
 =?utf-8?B?WVFvSUZCNkgwUFZqMUVVRnJYbksrL2R1ZFlHMGtZNGdzR3ovR3AwZ3k4MFM5?=
 =?utf-8?B?eGIrUXFJT29Kck1mWlFMTzYwRkFGN21BVW1abWVCQndLcWNVcnp2em9hdHFN?=
 =?utf-8?B?SG9SUk1rbEcvckhZSzZqK0FPelplajloUzR0aXlSN0xyMHRiaWdwMTlIaUk5?=
 =?utf-8?B?bkVCUUU1ZXNUYVpETVJHNTRQYm5EcWR3SFdDNmM4c212YXRCSEVEcDkrY2t1?=
 =?utf-8?B?NWE4cENWY3JlU2YvTGF5TGlmL2RTdldKSS92eHk5OEtCaXBMcHd4TmtBcFJu?=
 =?utf-8?B?eEVmQTQyNnVIRkJLb0FUbmxoQURqbjdmTEZRaU9teVVCTGtJeFUxR1d2akhp?=
 =?utf-8?B?Sll0SFk4Mm14QnhLWmw5UFFmTFpNaS9uaGgyZjFFN1VJZlNCYjRHTUlTS3pm?=
 =?utf-8?B?Y3Q0QmU1NFV4MjVzOFAycHB3N0VqVTM1bHJpbFkyME12RHFLb05ISDNkWUJz?=
 =?utf-8?B?TmlhRk5HQXhjbmZoQWZFYjZGZ0c5aUdLRXl4aU8vUWZ5NHhBS0hCaE9rRGRq?=
 =?utf-8?B?aTdVRGZzbGdOLzFSQkpsN1FzOXpTVTRaenZiK3BpUmxOb2VPUStxRzZvejJr?=
 =?utf-8?Q?bWO58+KuocyTGDfjpw+8dqEzm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26486129-99cb-40e5-efa1-08dc1bcff7fe
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 04:58:41.6301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIx8kBusq2eJv+GBxw8+lhVmleY6jh8/AV0CMBHDRUC4kBYFO1W19i+IWrycKVbokqIrNszu6hfB0EhGxlmWDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

Hello Tim,

On 1/23/2024 3:29 AM, Tim Chen wrote:
> On Fri, 2024-01-19 at 14:15 +0530, K Prateek Nayak wrote:
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b803030c3a03..1fedc7e29c98 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8499,6 +8499,16 @@ done: __maybe_unused;
>>  	if (!rf)
>>  		return NULL;
>>  
>> +	/*
>> +	 * An idle CPU in TIF_POLLING mode might end up here after processing
>> +	 * an IPI when the sender sets the TIF_NEED_RESCHED bit and avoids
>> +	 * sending an actual IPI. In such cases, where an idle CPU was woken
>> +	 * up only to process an interrupt, without necessarily queuing a task
>> +	 * on it, skip newidle_balance() to facilitate faster idle re-entry.
>> +	 */
>> +	if (prev == rq->idle)
>> +		return NULL;
>> +
> 
> Should we check the call function queue directly to detect that there is
> an IPI waiting to be processed? something like
> 
> 	if (!llist_empty(&per_cpu(call_single_queue, rq->cpu)))
> 		return NULL;

That could be a valid check too. However, if an IPI is queued right
after this check, the processing is still delayed since
newidle_balance() only bails out for scenarios when a wakeup is trying
to queue a new task on the CPU running the newidle_balance().

> 
> Could there be cases where we want to do idle balance in this code path?
> Say a cpu is idle and a scheduling tick came in, we may try
> to look for something to run on the idle cpu.  Seems like after
> your change above, that would be skipped.

Wouldn't scheduler_tick() do load balancing when the time comes? In my
testing, I did not see a case where the workloads I tested were
sensitive to the aspect of newidle_balance() being invoked at scheduler
tick. Have you come across a workload which might be sensitive to this
aspect that I can quickly test and verify? Meanwhile, I'll run the
workloads mentioned in the commit log on an Intel system to see if I
can spot any sensitivity to this change.

Adding David to the thread too since HHVM seems to be one of those
workloads that is very sensitive to a successful newidle_balance().

> 
> Tim
> 
> 
>>  	new_tasks = newidle_balance(rq, rf);
>>  
>>  	/*
> 

--
Thanks and Regards,
Prateek

