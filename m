Return-Path: <linux-kernel+bounces-35061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B642838B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE14C28F075
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359C5A106;
	Tue, 23 Jan 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BTy0HLAa"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA15A0F2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004071; cv=fail; b=oRNRnU1+lgUqAmLfRssCN90ex+goBUrPzbiqgDWgrbO01H3YEG4GsOb5ZWMamk1k3ZdEX1dh1waHsT+tsHmuQ1qBYSK3o4l/rWPpxdJ2Gblnjw3m9ONgbNXDveFY7gI1PmQPelnTu1rP+vsvtk+kneFITC001PChAGx3IGXnDKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004071; c=relaxed/simple;
	bh=vf3fYC44T+GQ8eyJweAHgj5Bd3bPrnHcWDzVD69pX08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d5MtHqfbEqLyGXyrnYauhvy/dHMd5e3JNPAaPRUag/4vdH8gl1wwrURGfRVEc6PdkkGXroEXnzUu23DWdOkNLAllrUeWLK5eudVqLt7k5QrsGdUjIb98fssGCtUFGzVZnpspYIBBhdU/Q/vHlwpKf0PpInkB1/MQb9f/7wgPuVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BTy0HLAa; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWYl0BpT+/rHBxphIZuu+7Y8vGeKspujnIh2JbeE3Pqgkd1gnzdX6VIWsI1W+te5GSHvtxpP7NJeg/O5MnA/Xf0wimEx+/nWoAveA2z5HY41PiObuo6QCu3yDiwcZU0HSJ7xooZpTM/syylBrP9KtG8OsCqw5P4i0GMwRaik0WixI+goCUKLq/GU479OQSzijboe2KKBa1Mu77MLZWgR7RgffzEpEZzPcwariQ5Qc2gbTlYL2IPykSC+hzUQCOlzfLNBGPxggR0xVqVB78H3awF+khXmAbDdyO5w2phVpzhOc4FUxTviWCZpt07EbY7SrOClGWUNoO2RnOjwrWXgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX31W9qsQRGqAy8WaVH3ckanR4/t2rSDwRZHef2aZD0=;
 b=UEyPM3uLclj9HB85ILPkq4NDl2RufrLYGcPeav/YmNCfmG14Owd2NwZKMQ/ZRG+mtrOW//UAC9aqYcXdfhATNLxy/o+k0O0m142Hb+ZOOUPFoioHxzTkpJQQFtQnhn7J71k7S8IYOjjBDa3EDm33od8hBegDrqXOK1uy4oi9vatGmor5q0J7LpcQ00qt2vzi9grjsAnRW1I/H32KmcII04jgGQXg4bVZAMcLwebfKXUmha6MzGCp590peVapdemfsUIJEWhl0cxAQ3NwacMv90jpqGXrWPWwBrA4hFNWBvKZaUx216+h1sWid8LZ7eiVwlRYQeEzCR+NPnhsVQ4cHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX31W9qsQRGqAy8WaVH3ckanR4/t2rSDwRZHef2aZD0=;
 b=BTy0HLAauYHe08fQGRlBMz+SYRlnBp6Lzm1r3q7eSftRt87qImwW62SglICGLq9LlSGICQvt7K/iowv9zE0tjKlt7NUibtsmH6NQ5I7isimNKkelzNhobyBZsinmRdgFZ6isS9XIpyAcSKko3z+1q1Yn3/AdfcpmcLGYz0+O5V8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 10:01:05 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::4803:9b3b:a146:5b97]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::4803:9b3b:a146:5b97%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 10:01:04 +0000
Message-ID: <211132bf-3a50-bfe8-cdaf-af40ee7d0ce2@amd.com>
Date: Tue, 23 Jan 2024 15:30:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] sched/fair: Skip newidle_balance() when an idle CPU is
 woken up to process an IPI
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 gautham.shenoy@amd.com, David Vernet <void@manifault.com>
References: <20240119084548.2788-1-kprateek.nayak@amd.com>
 <b4f5ac150685456cf45a342e3bb1f28cdd557a53.camel@linux.intel.com>
 <21c8694c-26e4-3bc1-edd8-2267b0164a09@amd.com>
 <CAKfTPtCFJ5TRdsHHiH_fz9R2TC3euz_Rp=LH+aQ9KeZx3uH+ZQ@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtCFJ5TRdsHHiH_fz9R2TC3euz_Rp=LH+aQ9KeZx3uH+ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM4PR12MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: d43bfab1-157f-4f94-e13e-08dc1bfa35de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X5+Ri35jzpMVVXbx1hKqh0wrTn7wtdTEZ/7ktwC7cKsqQLb7h3j2xDAOiRiQIFTPNmDJspScBnTRP+rUJUrfUk/32vVRgif8rbP1mxEyX7fqGRuMd2Rw/0s8OcyQqYhXBIvTLQ0AmxG0+OzZs1Fgtp1az/P5IHd3E5i30Okl///7p/psUvgu8w+9RKfuI79cX/aTNLtdPiMleJrhHWCYZLqqzurN+6Jpz85SO4gCBbOUjueOPCy+S5WyereqTG99uLZ78Ke6ZKJ+ahvEcTDI4lh6Ng/CAHG80k4MUWrGNHcPzUg7jFZnh4sc6+UL+OznuEVMV6ufPX9A6gMUXWJGjUek7vtfsNYCNRRHNl+2ZA+3CIYZIlaEFW6m5Cm+6jimAM9kes5H8mVpzYyuHgHkelYA6TJ1cL5VbyKs/jma5vdkb2WgHkVvxLLU4EUD5wGmO5VylDESVG7f8p13uJZYbCajg6Tb+pwJC1XOaGsQt/O1TeETGx6YOIQV5JIUOAVoqWmncPBCWNUfvxkpwSNhVCj6AP+zAdCr8J3J0KxZOYFOgLVBoJsLGhylybP9GvUfP8DkLMRkt80N9nD4dbIMpnaRdCrhgChJHtGGSd+nNRZ9H9B7DmYYR4uTy5daHWWeDual1W7QWqc4kxBuXi2FCVL9i8OwvAzBoz83/iOcmKDkDUbj54Fu7XgzoLfvC9XD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(36756003)(8936002)(8676002)(4326008)(2906002)(5660300002)(7416002)(41300700001)(26005)(6512007)(2616005)(83380400001)(478600001)(6486002)(966005)(53546011)(6506007)(6666004)(31686004)(38100700002)(86362001)(66946007)(31696002)(6916009)(66476007)(66556008)(54906003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzNzWTlnWUk5eTBxVVl4cUVueVREUys3aU83YzRoV201UUtwUUYxSEMxeFZQ?=
 =?utf-8?B?bTQwRFE5MmJSNzB5ZGN5UHp6RUtzNUt6UlBESVdKQW9lYUxOZHZLWi84RzBF?=
 =?utf-8?B?Q3ZSeXcxWEJSQ1p2WVNxSURIOHJQc1dnYjRseG44S0pxOUtWdkVHYlhQL2RB?=
 =?utf-8?B?KzRuejQyWkdwUzJOUzh0T0kvM1o2cHIzRk9UQkV3SDVZeHFLeWMyZXdrSWFY?=
 =?utf-8?B?dTFPbzFVOFIvemVocERxQmNpb3AvaHU3dkZPTmgwS0YyeWJJVE5NcG0wZGNj?=
 =?utf-8?B?WUthSnVjamE4YXIyanhkUVRtTlB1RXU5R0lVMG94WWYvSWJuTVR5d1lpUEZi?=
 =?utf-8?B?TVkzT0dEZFdrNUxvNmU3Sk83azluMVAzNWd1TlFHYWRBTVhpOVk4TjVOZ0VE?=
 =?utf-8?B?dy9VckRWR2hBZ3JJeXVHMUtHdDNoOUt3bFdqQzBFNUJHNDJKUVk2azYyS09i?=
 =?utf-8?B?SU5NeGZYZFkrVm5Vc3B4dERxT1Mxc3JPWEZaNW5BUUVMNE9UTnZCNXExNjBX?=
 =?utf-8?B?RHRucHJDbXRkM3JFdmYzalp1anVwWmZjRGNBQjJSR0Y1R3JHTUszWGNpU0xw?=
 =?utf-8?B?Mm1aajU4Q0FZbXZFWDRFYjYzS3Q4bVhLN1B6bWF1SUR1K2lKbEMyZkowTXVN?=
 =?utf-8?B?Ymdkb0xxK0V5NjllYlNvRjRjL2ZJbU9HaHhjZ2dHMlc5QzFJYjgvRVhsbVlt?=
 =?utf-8?B?VGU0eTAyaUhiV1ZJZGthenJTRXIzOUdUYzNHRU1iT1pwdlJXTVFsUzR1ZVV2?=
 =?utf-8?B?ZkVXRmkwblpyYTJGbE04dHF4R1dOR2dIdnFlOUR3QVZOWUcyQ1kzaEl5Tkc3?=
 =?utf-8?B?cytPK3BtdFlGODBHL0tadFZ3Vk1aRVFzRXFhMlJhZ0s3ZXJtVzY4NHh6d2cv?=
 =?utf-8?B?Q3N1ZzNhRFVWVkQvLys3anEwSXpzWU1rYzJDSFlUczc1KzVjVDdUcWdYc1Ro?=
 =?utf-8?B?MDZGUU5EckVVRzlMSnlKUXIvMk9mNGUyRVhpN2dFUDc3ZmtQdEdCVFRXb3VU?=
 =?utf-8?B?bkNQR1BiWCtuUUt0THQ2M3N5Y3NhUGZpYnFsTnZHVEl2SG5LaG1xT2gvUC9C?=
 =?utf-8?B?ZWl2NE1lRGd5bVBGUDhNNUtBQUg2NDZ2WnI3Z203YzVneTM5TmliREdWaUE0?=
 =?utf-8?B?OVZKNHpNbDVzUGVjOVNjdjZYL2gycFV2SVlZTXFnbjVPZG5pRjg0QndVN3hZ?=
 =?utf-8?B?WGs5ZENZSUNGdXZJS0pyK01QZ3IrS2lURHcwbDlNWkdWUE5NNmpjenF5WGZU?=
 =?utf-8?B?aXBhOGEzMjE3UVZyNmNiSGxQZlVwTG5EWmxQdjVrUHdnVTFzR1QxdnJ6UGtr?=
 =?utf-8?B?SXNEV2RDTk00RHdFSWQyU2VFVjFFVlNYU0xuRm1JZURLUzlCbnRaN0F2WmFR?=
 =?utf-8?B?RUJXT2dhTFF0VC9FQnFXYkNFTm82U1JieEd0NU1qOWRWSncyYkIzS21LWEds?=
 =?utf-8?B?OFBZVTBMK015N09SeEZPUGZQQ3lIYStZSjJKQ0xWKzZkNm5nYlp4YW0vTTd0?=
 =?utf-8?B?T2NzSVRBY0xyUVhqRWZTd05YSzM2YWMyeGRrbzJ0dWwrY2NFb2EwOXo5MXRB?=
 =?utf-8?B?VS9ITENFRHdJYjNFRURDdDltVjMxMEFpdksxNmVvMkxoQ1hLMC9Fck0zc0pa?=
 =?utf-8?B?WEhaTUtqQ0poSVlSb2h1STBnUFZJMkQ4NXF1eWdRL0tWNFhYcmMxbHdCbW9L?=
 =?utf-8?B?TGVxcVRndDVEWll6dTZMRjlOa1FGNnREbUtFcUM3MHFZTVRnU0lEYytONFhr?=
 =?utf-8?B?b3hNcnFGTmFLd25GeXZrV0NPYUZnRDdkRllSYkFZcjJBWmdhQjBEUVNNYlNH?=
 =?utf-8?B?MUd6Q2c4dkREcTBrNlFxZ3VkTzFtTi9ndkREQ1FLZUliTElIbC9xQXFrMFF4?=
 =?utf-8?B?WS9RZFlidmZiclZ6anVocHhlK2tRUk1sbTYvTnV0L2ZHSUtCQ2hKVGtnV3J5?=
 =?utf-8?B?OGFETWtYYjY1L21RdjlKV3JQVG5iNms4TGVTWVlaV3puQ2hjR3NING92c1U3?=
 =?utf-8?B?ZTV6YUVpSzVZNGJsR1VZa2R5SG1xZUMrdUtmSEFRZHhZbXd1WTlwdnFiRmla?=
 =?utf-8?B?OVdGcmdKYXppRHZlNSt3cmxMcE1ZVzJHOGJzUDZ6RXRCQVVvUEhScmUrOGU4?=
 =?utf-8?Q?oJZMeVOCMg2wZBkX6wRFLmFrN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43bfab1-157f-4f94-e13e-08dc1bfa35de
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 10:01:04.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuCSm2ZaM/62Sw0blcZaI7kiY5m5Y1U5MDkWDApimiYYsz9tqtlPwjvxLvG3Y/D6kDbpmXKySh4pRgTjchVTRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216

Hello Vincent,

On 1/23/2024 1:36 PM, Vincent Guittot wrote:
> On Tue, 23 Jan 2024 at 05:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
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
>>>>      if (!rf)
>>>>              return NULL;
>>>>
>>>> +    /*
>>>> +     * An idle CPU in TIF_POLLING mode might end up here after processing
>>>> +     * an IPI when the sender sets the TIF_NEED_RESCHED bit and avoids
>>>> +     * sending an actual IPI. In such cases, where an idle CPU was woken
>>>> +     * up only to process an interrupt, without necessarily queuing a task
>>>> +     * on it, skip newidle_balance() to facilitate faster idle re-entry.
>>>> +     */
>>>> +    if (prev == rq->idle)
>>>> +            return NULL;
>>>> +
>>>
>>> Should we check the call function queue directly to detect that there is
>>> an IPI waiting to be processed? something like
>>>
>>>       if (!llist_empty(&per_cpu(call_single_queue, rq->cpu)))
>>>               return NULL;
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
> 
> Instead of trying to fix spurious need_resched in the scheduler,
> can't we find a way to prevent it from happening ?

The need_resched is not spurious. It is an effect of the optimization
introduced by commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") where, to pull a CPU out of
TIF_POLLING out of idle (and this happens for C0 (POLL) and C1 (MWAIT)
on the test machine), instead of sending an IPI for
smp_call_function_single(), the sender sets the TIF_NEED_RESCHED flag in
the idle task's thread info and in the path to "schedule_idle()", the
call to "flush_smp_call_function_queue()" processes the function call.

But since "TIF_NEED_RESCHED" was set to pull the CPU out of idle, the
scheduler now believes a new task exists which leads to the following
call stack:

  do_idle()
    schedule_idle()
      __schedule(SM_NONE)
	/* local_irq_disable() */
	pick_next_task()
          __pick_next_task()
            pick_next_task_fair()
	      newidle_balance()
              ... /* Still running with IRQs disabled */

Since IRQs are disabled, the processing of IPIs are delayed leading
issue similar to the one outlined in commit 792b9f65a568 ("sched:
Allow newidle balancing to bail out of load_balance") when benchmarking
ipistorm.

> 
> Because of TIF_NEED_RESCHED being set when TIF_POLLING is set, idle
> load balances are already skipped for a less aggressive newly idle
> load balanced:
> https://lore.kernel.org/all/CAKfTPtC9Px_W84YRJqnFNkL8oofO15D-P=VTCMUUu7NJr+xwBA@mail.gmail.com/

Are you referring to the "need_resched()" condition check in
"nohz_csd_func()"? Please correct me if I'm wrong.

When I ran with sched-scoreboard
(https://github.com/AMDESE/sched-scoreboard/)with the patch on an idle
system for 60s I see the idle "load_balance count" go up in sched-stat

Following are the data for idle balance on SMT domain for each kernel:

o tip:sched/core

  < ----------------------------------------  Category:  idle ----------- >
  load_balance count on cpu idle                             :       2678
  load_balance found balanced on cpu idle                    :       2678
    ->load_balance failed to find busier queue on cpu idle   :          0
    ->load_balance failed to find busier group on cpu idle   :       2678
  load_balance move task failed on cpu idle                  :          0
  *load_balance success count on cpu idle                    :          0
  imbalance sum on cpu idle                                  :          0
  pull_task count on cpu idle                                :          0
  *avg task pulled per successfull lb attempt (cpu idle)     :          0
    ->pull_task when target task was cache-hot on cpu idle   :          0
  -------------------------------------------------------------------------

o tip:sched/core + patch

  < ----------------------------------------  Category:  idle ----------- >
  load_balance count on cpu idle                             :       1895
  load_balance found balanced on cpu idle                    :       1895
    ->load_balance failed to find busier queue on cpu idle   :          0
    ->load_balance failed to find busier group on cpu idle   :       1895
  load_balance move task failed on cpu idle                  :          0
  *load_balance success count on cpu idle                    :          0
  imbalance sum on cpu idle                                  :          0
  pull_task count on cpu idle                                :          0
  *avg task pulled per successfull lb attempt (cpu idle)     :          0
    ->pull_task when target task was cache-hot on cpu idle   :          0
  -------------------------------------------------------------------------

Am I missing something? Since "load_balance count" is only updated when
"load_balance()" is called.

> 
> The root of the problem is that we keep TIF_NEED_RESCHED set

We had prototyped a TIF_NEED_IPI flag to skip calls to schedule_idle()
on CPUs in TIF_POLLING when the idle CPU has to only process an IPI.
Although it solves the problem described in the commit log, it also
required enabling and testing it on multiple architectures.

  $ grep -r "_TIF_POLLING" arch/ | cut -d '/' -f2 | uniq
  csky
  x86
  powerpc
  parisc
  openrisc
  sparc
  nios2
  microblaze
  sh
  alpha

This optimization in the scheduler was the simpler of the two to achieve
the same result in case of ipistorm. 

> 
>>
>> [..snip..]

--
Thanks and Regards,
Prateek

