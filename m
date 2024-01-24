Return-Path: <linux-kernel+bounces-36639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E47983A43A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39171C21A50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B717580;
	Wed, 24 Jan 2024 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MYLNmChm"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6FA1756B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085338; cv=fail; b=YpZRPwjMnr49K8uX99CBzgQeJFwrDT4pbctIIBXlfF4GXzdC0NEmQFWwhXOIVLqt+V+OQKf5FvLVp045YJZfLhBwhp44AEjFIIVJTPwmUWee3CuX6F+/ppSVQU6cYUOr6GoYzZ5dUjAOZMs8r8lilbj707TFFni9zth/1Cmcr1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085338; c=relaxed/simple;
	bh=iJdBIg8EF69rP25GbiYs89uLmQ5ernLjLK1jMIMITIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmzLUM8+yc52ym3MZGfR3bGKxRZK9E8QNyxpm0iWfO+Koc5gSz4EAU1owU3djjRd3ptJkE+yfDxboVEM7Lz8hcNnG39GzY7w5/HPg5DwJPzL3tJh/EFvCnnfZsYuYnnVCNeMNJAClB206udfQGtVvIOI4wpLFDGzk+8tY5pvGCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MYLNmChm; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM9m1Bp8M+vEJpoOxyNLMM/U9E+6UXiYkJCBLypX2JJIJ/dsKK2oBurinm4twEoYx9+ESwvMidUO+RoyzUiIimGVKmPhTXw49ekEAzvBaW+ROHT/4X37yiRSJ9o+J68G7VO7TYQDYk7vIB5LmnjwqO4CDRYobQ1Tq4WsaK3yd83ICLf6Dip6BdSxGpTKb7S6N2Hd8IZjCx4XAG5CH53MFjlL0JY85F1dgBiFo2fCtkrzsdkEOqQsjhzsXb5/6XIOv3HZmVuOgdiJhauWKozD2wf99OJWBOA9nEp9Ed/lFCSD104zUgZ/HFjxeCWoIs0gOjEzrmgOMBOTFNNhCNgT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6a9tSIrfaacXC5gOThA6Ewix1anS5CVMfreRyf1Yt4=;
 b=C7I0Nf0pndSMiQj5dE6+wOUNow2+XFZovPVY2i97UO2AhCA+R1GIKNySaOtv+2PbrwVheNCValohxaVjdk+51DtkiXBBfUe0zM+uqI4PGhcKjOnFgDAWeSqBISM3y2papTCOqHmA6TPR5CGsXnTPNPYxq9GX2gQK6xNzCtnUV5Jt2xmT+nOw2ekquWnkKgMUqGb+EuIGjztFfO/MBQ1rNjbqpQjlcn0AvKC/JNRQk5548sr64L+i6JT6sdqJCZdreWgAK7WC2HGVzbfUNA7SVTXDqAXH3GXMsxMkB3aqlfUvPuasjyoEduXg20yOOeHsJm3Qk/vDN8uyydkG6xlV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6a9tSIrfaacXC5gOThA6Ewix1anS5CVMfreRyf1Yt4=;
 b=MYLNmChmFnN1uFhKy2GFm5Q4hYUo5x3rPPKi5eVtM/WidrwNZ3gdRIeZQtenBs+2MXjOBonFROyCKrJ1gDSvNq7x9SmxRb+TQEBbRGfDLFCLTTwz12NlzSt5gJUjlXCLYuWrPy3Au5HP1qBJe6z56yUNOGRHWk/Xc/YtlF4rog0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 08:35:34 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::4803:9b3b:a146:5b97]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::4803:9b3b:a146:5b97%7]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 08:35:33 +0000
Message-ID: <f7db8b6f-d97d-630d-28b3-97062fa2c7cc@amd.com>
Date: Wed, 24 Jan 2024 14:05:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] sched/fair: Skip newidle_balance() when an idle CPU is
 woken up to process an IPI
Content-Language: en-US
To: David Vernet <void@manifault.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, gautham.shenoy@amd.com
References: <20240119084548.2788-1-kprateek.nayak@amd.com>
 <b4f5ac150685456cf45a342e3bb1f28cdd557a53.camel@linux.intel.com>
 <21c8694c-26e4-3bc1-edd8-2267b0164a09@amd.com>
 <20240123211756.GA221793@maniforge>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240123211756.GA221793@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::13) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c3dcc8-5aae-488a-4cf1-08dc1cb76e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Hu6tQHAmnYHUh4n0Qoyo3pIaV7em+z5EcQ42Q27L6pPcEi8RfBOJoJr0HPaE+o6csG+Nu5GgSHxi4pORKK2OuEsZ/bloW/23ETgwaApLhx/DWvDrTkpC+1RI199AdMfM58DyepyhZRlSlwBEa0cuZDLIxY2I8hoJYwt9vqGF5geEVUvvzd8WUx/+l2Faxc10Qn61hpMpI6FeftYCY5X4dXqrxvsD7lTa+U7DacwZa4ikckWf09oy3W54doBWiXlLH23pdCcmMdNt98oK2jabnaonCUXbRP/ZAlynEWaAD/qf8adnCra1GEvN/Qi0MbyqAW5vuBz/qsqm9zepi2WhceYgkQt2bAMXxlJwYlh3O9zUOlJlz1rRpzI5WSrLTbcGIGSfBrqjnjmfM93FE/3Wy5vFW3qcBDNfqaN/u1417Qre04krc9FKc2FCTe2LFm4M9behC59f89V2l7RSJlg3PFi0Jt9djgTDpWE7jItKT/mTE/M5gZ31T41iTHrLlNmFTbj2t53PdDVzuEA1WbZpaz0ECrSdHlNg2kVhccsadw2Xg3FJKvx7JeQ3QE3y8q5Z/RZwGmll9L8iM3Iqca1Mj/3USYltXNt+7A6Eg0lxRq/d5zDsCQ+zEhbW/psgXyYLEYHQprAb8GsAehxLEaObHmI2hQacV1cQAEa/xkRiWwOj+dx1R9C4U81oz3o8jMi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6512007)(2616005)(41300700001)(26005)(38100700002)(5660300002)(478600001)(4326008)(6666004)(8936002)(8676002)(7416002)(66946007)(6486002)(6506007)(66556008)(66476007)(53546011)(2906002)(316002)(6916009)(966005)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWVaZDBsanVXRklJK2h3UjE2R0pmRGxqRncrazFRdlVNN2hDUmlPQWltTUZv?=
 =?utf-8?B?SDJCSW5WUEpmMUZGNkpUdXRoZEhXRlN1NWVLTHdrR2lwR2JsUlpsaHpvNzdB?=
 =?utf-8?B?amU2Y0F6aU0xNGs5U2dRSHRiRlJ4cmIwSDJzaDJLR3FWNFpId21iSVRPS2Rj?=
 =?utf-8?B?eXcyL3l5aEo2dVBqYXZremxrckdVbm9hMG51SVJYZ1N0SGM0aWVhZUpUdndx?=
 =?utf-8?B?T1N3TDQ1WkZXQmtyZkl0RUtSekFwLzdaMjc1OVZRN1ZLTFNhb3JvV1A2ZkZE?=
 =?utf-8?B?bGROSlh3WVBjUnp5UlRZeUtqOGxFUm1qNW56MC92UHorbEhVSzN4bCtncmgr?=
 =?utf-8?B?UlptY1hWNlowSytMbFhxSWN3ZVBFMS85eVNaMUlIVWt5RXQvTGJDWlpuMThG?=
 =?utf-8?B?b09IaS8wM0RKcnhPa3doQUNwTURZNHlOdFdwdGFDTlN3VmIwdDdkdEFvcWkw?=
 =?utf-8?B?OXlaNGl5VSsrUnNMZ2c0RXAvRTlUNnlwWjM4dXYrRFlicVNYc0NzQ1o0UUNv?=
 =?utf-8?B?ek4wWFovbnlXMFFpSXUxUTZ1MTZwZFBna3FxaTUzRnhHditObzNtQzZPcW0x?=
 =?utf-8?B?UllnWFgvNThEcFlrd1lYUDJZOTg2bzcxa0QwMnNYN2JzRG16OWNGTStDWDcx?=
 =?utf-8?B?SHIrZXltU1RXZG44clJDTm44Yk1JSTV2SUMwYXZZSG9nbjMwMERNa1VtMnUv?=
 =?utf-8?B?S0NueS9rNFMvdUdrNVpCRXNjU0k5dE5yenU4YnJQMU5xQVdYcmxOb3hHTjZ4?=
 =?utf-8?B?NnVIdUtkZ0VSbzIrNmJKTVI3VmdLODZJa1hvNmhhSEZnemRFQ1BUMnVpUG9h?=
 =?utf-8?B?MXRpSE1uV1RJWXM5MmRjZDBHb1p1N1RFNnQ5WUZUeld1UDk1U0NVMmJBcWlW?=
 =?utf-8?B?bWlBVkZTM2lHd2NMT3VIOC9qQ0tPNkozOUxZRUZmL3dFclROY3AvbHRNWVBp?=
 =?utf-8?B?UTNweGdDSGljVlJsanUrZzIrZmc3bWNYNTl5RktOSnd1amk4bTVMS29zUHho?=
 =?utf-8?B?QjNSOWo3dVVZK29VeXoxMllXOFQ1UFlYVHg0RjNjd2JPQmZOQUFaay9MZkxr?=
 =?utf-8?B?aFpiN3kzNGpsUHB4ZEl1Und6dktrTU5lU1VQNG90aVFqeGZkWFVGQ2JNS2tW?=
 =?utf-8?B?bkN3V0xxQVNTeEgxYUEyalRrTlJWS1RTSy9rS2ttRWZkdmlOSzBGaCtKd0xQ?=
 =?utf-8?B?VWQrZDlyZjZESHlOaVhxWjF1V3JKYVV5cUJPYmZFV09MWUhObzZ0bUp1ZjdN?=
 =?utf-8?B?M3VGYUhYNVpndzVOK29EYXpkVXJOdDZwQW9KbWYzUEkxV1BsUVFsSkFFVTJq?=
 =?utf-8?B?eFVxdTQyM2RHc08yVFNab3BjTkxOeDNXMzRzQ1lhcCtsZ1ZRb3F5SWRjSzRy?=
 =?utf-8?B?WTkvWmpPN0FGQkpNOTZNSlNvTnJxRnFRQkVJMXV5UFhRbDlLaUMwSHUySVBh?=
 =?utf-8?B?RWUzdVNEbWRCejNGb1p0K1F1ZkM3cXUwNmtSaGRlR2RjeitVbkFsdVJvQmlP?=
 =?utf-8?B?WVVUN3BSVkhsTmRCWlB0QzEzamtSSzBoQVpiMEhTeWxNbjB2UVRCTEZTVy9v?=
 =?utf-8?B?K1l2d1UzKzdJZDVBOGorQUNFR1lTZFdreVZMeEZNUTFzbmxFdGUwMFF5QUwz?=
 =?utf-8?B?bzJVczlwb3VhdEpKeDJIRkZUUXN6YzR1OTA5Tk1rMlVYL1ZRYzZlV1Exb3U5?=
 =?utf-8?B?TTRxNGVQL2tLaktvczFGb1RzUzVHeUNTZS9HSlJWay9rVjZiemxRMEFQVnFU?=
 =?utf-8?B?b2t2Wit4YnFHcGRYVDVwYlZQekc4VjdmVFRXK2NZbTB6WFVmY2pjeUUwQ0Fj?=
 =?utf-8?B?aE5pNDZkbHBSUTY4dmovZ01rOFpNVVNpVzEycFBxSFJnL1BGc0tqdFZ2S3VR?=
 =?utf-8?B?TXZIc3hvanFpWjhxMjFPWmNiVDl5MGRwTUR0THJqZEwrbUlxemsrUHRJdlJH?=
 =?utf-8?B?cGJ5RDNLYS9ZRU9rNnIzWk5UNmZtUmM2bjM5QzY1TldDNS9mUG5naHJlcExX?=
 =?utf-8?B?VTlHdmxla29YTGFuZkRmUndvbWtPelMyUUtjK3lwNzRJZS93R1U5R0NGME9C?=
 =?utf-8?B?NzlhbEJGcWhWUUp3cGlmUXF2bWE0anNLZ3dIZ21MbUVTOGJxb0lnT1k5czhJ?=
 =?utf-8?Q?dWhuG2v+Xih3vJnCKgR++cNvM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c3dcc8-5aae-488a-4cf1-08dc1cb76e28
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:35:33.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WowTbyBXj07wNFHm2l3iEob+69NujFewkJHSMqtSi9B3mnYM1/fZCekzOxSV6H0uihHpa2EhOQLcw4jUpVC++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

Hello David,

Thank you for taking a look at the patch.

On 1/24/2024 2:47 AM, David Vernet wrote:
> On Tue, Jan 23, 2024 at 10:28:31AM +0530, K Prateek Nayak wrote:
>> Hello Tim,
>>
>> On 1/23/2024 3:29 AM, Tim Chen wrote:
>>> On Fri, 2024-01-19 at 14:15 +0530, K Prateek Nayak wrote:
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index b803030c3a03..1fedc7e29c98 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -8499,6 +8499,16 @@ done: __maybe_unused;
>>>>  	if (!rf)
>>>>  		return NULL;
>>>>  
>>>> +	/*
>>>> +	 * An idle CPU in TIF_POLLING mode might end up here after processing
>>>> +	 * an IPI when the sender sets the TIF_NEED_RESCHED bit and avoids
>>>> +	 * sending an actual IPI. In such cases, where an idle CPU was woken
>>>> +	 * up only to process an interrupt, without necessarily queuing a task
>>>> +	 * on it, skip newidle_balance() to facilitate faster idle re-entry.
>>>> +	 */
>>>> +	if (prev == rq->idle)
>>>> +		return NULL;
>>>> +
>>>
>>> Should we check the call function queue directly to detect that there is
>>> an IPI waiting to be processed? something like
>>>
>>> 	if (!llist_empty(&per_cpu(call_single_queue, rq->cpu)))
>>> 		return NULL;
>>
>> That could be a valid check too. However, if an IPI is queued right
>> after this check, the processing is still delayed since
>> newidle_balance() only bails out for scenarios when a wakeup is trying
>> to queue a new task on the CPU running the newidle_balance().
>>
>>>
>>> Could there be cases where we want to do idle balance in this code path?
>>> Say a cpu is idle and a scheduling tick came in, we may try
>>> to look for something to run on the idle cpu.  Seems like after
>>> your change above, that would be skipped.
>>
>> Wouldn't scheduler_tick() do load balancing when the time comes? In my
>> testing, I did not see a case where the workloads I tested were
>> sensitive to the aspect of newidle_balance() being invoked at scheduler
>> tick. Have you come across a workload which might be sensitive to this
>> aspect that I can quickly test and verify? Meanwhile, I'll run the
>> workloads mentioned in the commit log on an Intel system to see if I
>> can spot any sensitivity to this change.
>>
>> Adding David to the thread too since HHVM seems to be one of those
>> workloads that is very sensitive to a successful newidle_balance().
> 
> Thanks for the cc. FWIW, I think a lot of things are very sensitive to
> timing in newidle_balance(), but it goes both ways. For example, we had
> to revert commit e60b56e46b38 ("sched/fair: Wait before decaying
> max_newidle_lb_cost") [0] on our internal kernel because it regressed
> some workloads by causing us to load_balance() too frequently. I think
> the fix is correct in that there's no reason we shouldn't apply the ~1%
> decay / second to newidle lb cost in newidle_balance(), but by causing
> us to (correctly) decay newidle lb cost in newidle_balance(), it also
> increased CPU util rather significantly and had us spending too much
> time in load_balance().
> 
> [0]: https://lore.kernel.org/all/20211019123537.17146-4-vincent.guittot@linaro.org/
> 
> On the other hand, on other hosts, we use SHARED_RUNQ to load balance as
> aggressively as possible, and those hosts would have benefited from that
> change if SHARED_RUNQ wasn't an option.
> 
> My 2 cents is that I think it's impossible to make everyone happy, and I
> think the change here makes sense. If there's imbalance, it's something
> we would uncover when load_balance() is kicked off on the tick path
> anyways. I also agree with Vincent [1] that your idea / prototype of
> adding a TIF_NEED_IPI flag is an overall better solution, but this does
> seem fine to me as well in the interim.

Thank you for the detailing your explorations and giving more insights
around newidle_balance(). I'll clean up and test the TIF_NEED_IPI
prototype some more before sending out an RFC.

> 
> [1]: https://lore.kernel.org/all/CAKfTPtC446Lo9CATPp7PExdkLhHQFoBuY-JMGC7agOHY4hs-Pw@mail.gmail.com/
> 
> Thanks,
> David

--
Thanks and Regards,
Prateek

