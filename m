Return-Path: <linux-kernel+bounces-36633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BADB83A41C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D9C282BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB11756F;
	Wed, 24 Jan 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="czFYMKH9"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429217562
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084805; cv=fail; b=h5Y2beam5MQmTgEdBqQ9pvRxAP4FYc6aUeiD4xHk92zxdpk7M5OSV41z7A2INNoVZ1yyYkipFnel/I6CwTbLBAhM6zolpomcnM/p3XwvrTkg8ub2V5G6xTCwrLJYeTDrfNhWAOOzcZSPdL1SfrAIn+dN+HwRZoFcgAD9T0opoR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084805; c=relaxed/simple;
	bh=QDFqDVWuVh0qHcnxIDOEdSiuv7ui+xa+4GBG1/2hW3o=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SJCljMZlaQhAzZtq6YYsbABcu24LBrIYI/aQo4G5Ahg5E/n1Z7NHY5DdrjgBzanU4MNKazo9RE9wG4ciIhoQDyV/HzAoV5vehabtbWWran57KdqajkHaAMVm3pK+IkHE3XO4GEe2akhc39D+Dgc0ZADsL+UwUfHzQUqoD4X41eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=czFYMKH9; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4ZbfJ3DN2ZMc+ksvhzgxtEEBuYiWJYHDPADXrC76BgBuMyp+L/Ny+eaJ2AI8yJnqKn9TgYclF2Bz0Rn+TrJ8VUrUkmiEdc42EWnqIz3v42jMRzE0GOPJHeUcAhF3OMCQ0yzs4qKq7W40HSvFcpivOVijxdsrLIHqSZMKtFF97vf0nHeHid5QJOdoxNr+duA6DGIl/Z0RstbFCq38cb5OdKGwKBuE38G0ye3+DZZb32/5gk2sCz0w5hHcKN/PFQxVQj9vXWvJqeVB2SomQpeWKrVEQQywtY46EnMuAX6zL/UaxWMkA8pxl2Ls9tgahCJOPIqkMdfEn/EzFpMFXvwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNw+42mP5/RAe3OWbVLCrG9+I6iU4LK2L/YBTJStbEE=;
 b=TPtB9gy2iy3DnM7ow1G/Qpuln+1Xf80pbSHBO7gv9j2qq9MoGGS7wb3f5bhKy9SZAtdu28FIMt6hSjMHUoTcIITZ8C3ivOXL65oQSZ6F19Nx89PXUicCVVGtaJB0YeLDZOxzhNq5XU2gJAw6oPmlBPW7FwbSxItH605ffe1tKCRumz1pjrkTvOCPIoQYTYsPQGfOjdqNhBTrcmH8NrdWiolVf1El4Qz3ettD2VOVhQvwy71MS4x0IrGBKr9nwzOXWtX8MHJNWuW7tLCp70tmLw7I+PEx8qg9NHFvBwNoEjl7gBpS5l59G5aSYymyvO8kg2bTehoveE+sH9My4gsqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNw+42mP5/RAe3OWbVLCrG9+I6iU4LK2L/YBTJStbEE=;
 b=czFYMKH9KHHuIcILdAO+rvHsizFoYsGm/3+3O+gDwkQhmrrxqgydcDRdHqsPgYii6uUJjW6/CBo8pLqwZ4SafsMDwgVrILOH5uIwP8UThsEhxkoqp2Cj/zl/6B34VfRWF5EM2ImBLauA/94jgN5+juaQ35Ynfe7Pmt4J6K7LnYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 08:26:40 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::4803:9b3b:a146:5b97]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::4803:9b3b:a146:5b97%7]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 08:26:40 +0000
Message-ID: <c75f35d6-aabc-ab2c-9cb7-5911f14ed5a0@amd.com>
Date: Wed, 24 Jan 2024 13:56:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
From: K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH] sched/fair: Skip newidle_balance() when an idle CPU is
 woken up to process an IPI
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
 <211132bf-3a50-bfe8-cdaf-af40ee7d0ce2@amd.com>
 <CAKfTPtC446Lo9CATPp7PExdkLhHQFoBuY-JMGC7agOHY4hs-Pw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtC446Lo9CATPp7PExdkLhHQFoBuY-JMGC7agOHY4hs-Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::13) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM6PR12MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 52910eed-14b7-443c-466b-08dc1cb6306b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I8CZwiuvdOzkBAMjx4yhhfA9oya7ITJomRcijXdf6E5L3n7n9K3A0BTNF3mMOXuHylBRp+KsayADHtbizkXIr07FFXVj74Ez1y810uF5gIwwKlTuSaWKil1uqFzXWhKt9nllvwz39NEk+Itlzt9qzfoZKf49UxTBbFIhIVFa02lp80Lt6R9Gz/jFLjAIJpABDuZ3Yu3Nh3LT8Rze02PEdTUdvQav45sm2Ydz0IW0mZwna2H8pyeWYbH+YdLQSnJHEcCRy6HsdKo4t3bh70P2oR+g940vCm2rXszKUIyc3Oc/KdX8tt0V3RTnw7yUFMIdCMjBrQ4ueizo2NW53RqT0+0YEK6295/5Cs9VeIlToJyUIJEEfoViO1DMogytMYXbyZSQHGioHSvPJQHqWoJBiw43Dq0t3Y8Ekm7H/WN8WpLH0YNFHheh8TORAk5tJYQ42ESGvLxdK/4tLi6BLd3TgtWDYx2Q5B6/NIenemKLG3H5Ohk53L3/L9tY6Mj5p1G4oghDIEX5ebTwaqTu61cGa8ME3atnTUMx2z+wZILepYcbWYhBsEPxzY54PPgx9mUNZm+cKlu0T8oPZD7NVVH632Jkqi/HYAs/Zo3y/33llBHZdGwGEJPznZOvGZSglt1sFkPrXVZLH4RLUsDwldBq6+OCMxRheKBwiOlOrhTGomoPsQ3QK3dX+dh1eRDhQy3e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6506007)(6512007)(2616005)(6666004)(26005)(53546011)(66946007)(41300700001)(83380400001)(4326008)(2906002)(5660300002)(8676002)(8936002)(7416002)(478600001)(6486002)(966005)(66556008)(6916009)(316002)(66476007)(54906003)(31686004)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0FLUHJKSzlubVlMZ0xDaWZydG1ac2k1Y2ZBZXdNQyttay91N3VUWmMwd2xD?=
 =?utf-8?B?TzFJVVhTemd5NW1TY2tJUFdaMGJJTjdEQW1Zc1JoaE42UVIxMTUvNjVRaWx4?=
 =?utf-8?B?SWJYZUR4by9peHdZSS91Z202Qms2MW5Ec2lmNy9LRllEZkExLzE0NGErWUFG?=
 =?utf-8?B?eW1uWkZjb3dISmdNVVRXL3FoQTB0Z3dYenpPNGRhbzE1V2VOWllqeVFwNDl6?=
 =?utf-8?B?S2QwV0F3RHdBQ2drU0ZraDcwbU5EOXlmbU5LalNBeXcwaURJckduaXV0TDFK?=
 =?utf-8?B?WGcrSGVrTlRraGsrTlA4NDJ0YnJIUUZaYTRhb2hQS3JMSzRrdkwzRDU1L1Jj?=
 =?utf-8?B?ZDlQRjlhc2FaQUZibmwyTGIwekM2eExjREtFZFQyL25UNXBFSDhJbXRRZ3lD?=
 =?utf-8?B?cGRZeXVtQ1BMSnF2YUFpaU1Ka2tHdmZ4UldmMHNCeFIwdENzNjlTOTlxU2Ez?=
 =?utf-8?B?VDBmMlYrMW8xbFJ2WCs3a3pZYmhYdThFSzQ0Znd3Y3VYdGRiTEl3VlpoMTBn?=
 =?utf-8?B?Y1k5OVloaXVoMjhsQndLYXZOV0NoZVZtLzRoVDF5NUJCcnk4Z1NsU1A5QU8y?=
 =?utf-8?B?WmtLWTlHelhjcFNOaVg4WFY4dFpOZW0rYzNtcDVuZXI0aTNUN0pvRmdoRUw0?=
 =?utf-8?B?VCtiaitQRXJzUDdVZlFHaUlEbHc0b1c4Z1BlQjVRSmVRbWdmZmZlMmIvcGxj?=
 =?utf-8?B?Y1h5VnZhTU9wV0NnVmw5a3NuSERLMjc3MGNWOFhsYlhjTWNzell3cEJGcjVu?=
 =?utf-8?B?NTlKQW9nL2JacFkyZHNwTjlWVUVoMkU4R25ycTA3OXR2M1Y0dFJlY1p3NU5Y?=
 =?utf-8?B?Z1lYRmZHeUlLcy9NTm1CZlRodnVnN3hwaS9XRnBicmErNXVFVFg0MU9BMG5S?=
 =?utf-8?B?bnNUZEZ1Y3dmZmJVbHpLRDl5SkVqTjNhbmZXbVA5WW91SWFwSjllbnZzNXp1?=
 =?utf-8?B?eDQxMVJDNVlMZGxMM2NFd1R6UjRvdTcySTVLMnh0YWYyb29OMFZtMTZTY3Bk?=
 =?utf-8?B?STVsU3VuZU5PZVQ5U0c3bmd6djA5Ymg1bWQ3UjlrZXU0akNqUzBCMlhBOUxD?=
 =?utf-8?B?cmNXWVhEUHU1Qk0yelNQUUpXZyszU3RVU1lYbHp3ZzhLZUo1K01oVU8ybjF6?=
 =?utf-8?B?Z2phcldGN0FicmdmTWpZLzRPSjl4MVFVOEU1a3ZzSUtibDRPQVF4TXJyRGRa?=
 =?utf-8?B?Nmd0WXZXN1pReG13V2IweVhFQTFKeUNDT1dtazg2U3Y4OG10dlk5QlEwc3Bq?=
 =?utf-8?B?N3BRakJwcjJoVnBOYXNuRnJSZFFZTzhITXgvRXVIUGttWVJxejQrYzcvR01M?=
 =?utf-8?B?cUJwcC82ajFwTjcyYnhhZzFHZjh5SGd2RGtqdXdLZ0E1NGxsNnl6NXV0MW9X?=
 =?utf-8?B?cFExekVYVkY2UXBhYkJpWHZFeG0rTnNXS0pmaTVRSDlTQmVNOEJzRmlNdkNC?=
 =?utf-8?B?VnBqa3hXcWFsMUt2cnRCVzIvcnRlVkdCRVNlZjRPYVhLeS85dkpOY1U2cUc3?=
 =?utf-8?B?d05IdjFnQ25DaVp6TERGQm5DL2pLd1RYdElmVFFCbWJWLzBrMXlHNHplNWxB?=
 =?utf-8?B?di9VOFZ1emZyeGZPNzNET1A1QXk1YSswRzR3S0tXTVJESnUySHMwZ2xEY3BP?=
 =?utf-8?B?NWJhWTVtRy8reGNaRUd2NTY5WXpRVTJ6aHMwMlAwM0ZhRFoxVW1CV1Rmbmlj?=
 =?utf-8?B?cHZ5amFlWXVnQ3BqYUVpNDVrMWo1NW5KQ0pLcElIK1lHRXFJQWF0RjdxUklw?=
 =?utf-8?B?MVl3bUdKWWZOVlBacElzREtlWEVSeVNiQ092Sk1DUTZrTkVRVkQ2ODhPOVRk?=
 =?utf-8?B?amR3WGxNbVZPOXVXTUNoVERmeHRuWVVWYWVBaElyRmMzZ29CRjZOOVo1eHVj?=
 =?utf-8?B?UmgwODVzc3k4TE1vd241eFNObUVUejZFVWt6ZVg4Z0taeWlWSU1rbWVnU1VO?=
 =?utf-8?B?L2Z5bGdWVGV1K1RRVWM2azNTV0ExZ2lyOHhFWjh5U0x1Yit2RTVqS21EU3o3?=
 =?utf-8?B?QWpiYzlKckJDN0lkT3VvOWV1ZGExUU9vcENLYmpwa3pCYS9nZlZuelNDTXp3?=
 =?utf-8?B?UEs2QTJIWTFaZW15KzkvcnRQN0x6M3BEUlhtUENKb05HWExwWFpsbEFodnRz?=
 =?utf-8?Q?JQs9zNJ/aI/7ATebH1uLrIu5a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52910eed-14b7-443c-466b-08dc1cb6306b
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:26:40.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ut/iRb6d1O9HMG6WZxT4EeIWePuMzWtn0cq+eDeXk8EuxQABiD/X6V4rWtdsZdRVRS83a4EupkKttGb5DEV/ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925

Hello Vincent,

On 1/23/2024 7:09 PM, Vincent Guittot wrote:
> On Tue, 23 Jan 2024 at 11:01, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Hello Vincent,
>>
>> On 1/23/2024 1:36 PM, Vincent Guittot wrote:
>>> On Tue, 23 Jan 2024 at 05:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>>>
>>>> Hello Tim,
>>>>
>>>> On 1/23/2024 3:29 AM, Tim Chen wrote:
>>>>> On Fri, 2024-01-19 at 14:15 +0530, K Prateek Nayak wrote:
>>>>>>
>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>>> index b803030c3a03..1fedc7e29c98 100644
>>>>>> --- a/kernel/sched/fair.c
>>>>>> +++ b/kernel/sched/fair.c
>>>>>> @@ -8499,6 +8499,16 @@ done: __maybe_unused;
>>>>>>      if (!rf)
>>>>>>              return NULL;
>>>>>>
>>>>>> +    /*
>>>>>> +     * An idle CPU in TIF_POLLING mode might end up here after processing
>>>>>> +     * an IPI when the sender sets the TIF_NEED_RESCHED bit and avoids
>>>>>> +     * sending an actual IPI. In such cases, where an idle CPU was woken
>>>>>> +     * up only to process an interrupt, without necessarily queuing a task
>>>>>> +     * on it, skip newidle_balance() to facilitate faster idle re-entry.
>>>>>> +     */
>>>>>> +    if (prev == rq->idle)
>>>>>> +            return NULL;
>>>>>> +
>>>>>
>>>>> Should we check the call function queue directly to detect that there is
>>>>> an IPI waiting to be processed? something like
>>>>>
>>>>>       if (!llist_empty(&per_cpu(call_single_queue, rq->cpu)))
>>>>>               return NULL;
>>>>
>>>> That could be a valid check too. However, if an IPI is queued right
>>>> after this check, the processing is still delayed since
>>>> newidle_balance() only bails out for scenarios when a wakeup is trying
>>>> to queue a new task on the CPU running the newidle_balance().
>>>>
>>>>>
>>>>> Could there be cases where we want to do idle balance in this code path?
>>>>> Say a cpu is idle and a scheduling tick came in, we may try
>>>>> to look for something to run on the idle cpu.  Seems like after
>>>>> your change above, that would be skipped.
>>>>
>>>> Wouldn't scheduler_tick() do load balancing when the time comes? In my
>>>> testing, I did not see a case where the workloads I tested were
>>>> sensitive to the aspect of newidle_balance() being invoked at scheduler
>>>> tick. Have you come across a workload which might be sensitive to this
>>>> aspect that I can quickly test and verify? Meanwhile, I'll run the
>>>> workloads mentioned in the commit log on an Intel system to see if I
>>>> can spot any sensitivity to this change.
>>>
>>> Instead of trying to fix spurious need_resched in the scheduler,
>>> can't we find a way to prevent it from happening ?
>>
>> The need_resched is not spurious. It is an effect of the optimization
>> introduced by commit b2a02fc43a1f ("smp: Optimize
>> send_call_function_single_ipi()") where, to pull a CPU out of
>> TIF_POLLING out of idle (and this happens for C0 (POLL) and C1 (MWAIT)
>> on the test machine), instead of sending an IPI for
>> smp_call_function_single(), the sender sets the TIF_NEED_RESCHED flag in
>> the idle task's thread info and in the path to "schedule_idle()", the
>> call to "flush_smp_call_function_queue()" processes the function call.
> 
> I mean it's spurious in the sense that we don't need to resched but we
> need to pull the CPU out of the polling loop. At that time we don't
> know if there is a need to resched

Agreed.

> 
>>
>> But since "TIF_NEED_RESCHED" was set to pull the CPU out of idle, the
>> scheduler now believes a new task exists which leads to the following
>> call stack:
> 
> Exactly, TIF_NEED_RESCHED has been set so scheduler now believes it
> needs to look for a task. The solution is to not set TIF_NEED_RESCHED
> if you don't want the scheduler to look for a task including pulling
> it from another cpu
> 
>>
>>   do_idle()
>>     schedule_idle()
>>       __schedule(SM_NONE)
>>         /* local_irq_disable() */
>>         pick_next_task()
>>           __pick_next_task()
>>             pick_next_task_fair()
>>               newidle_balance()
>>               ... /* Still running with IRQs disabled */
>>
>> Since IRQs are disabled, the processing of IPIs are delayed leading
>> issue similar to the one outlined in commit 792b9f65a568 ("sched:
>> Allow newidle balancing to bail out of load_balance") when benchmarking
>> ipistorm.
> 
> IMO it's not the same because commit 792b9f65a568 wants to abort early
> if something new happened

In case of commit 792b9f65a568, the newidle_balance() is cut short since
a pending IPI wants to queue a task which otherwise would have otherwise
led to a spike in tail latency. For ipistorm, there is a pending IPI
which is not queuing a task, but since the smp_call_function_single()
was invoked with wait=1, the sender will wait until the the the target
enables interrupts again and processes the call function which manifests
as a spike in tail latency.

> 
>>
>>>
>>> Because of TIF_NEED_RESCHED being set when TIF_POLLING is set, idle
>>> load balances are already skipped for a less aggressive newly idle
>>> load balanced:
>>> https://lore.kernel.org/all/CAKfTPtC9Px_W84YRJqnFNkL8oofO15D-P=VTCMUUu7NJr+xwBA@mail.gmail.com/
>>
>> Are you referring to the "need_resched()" condition check in
>> "nohz_csd_func()"? Please correct me if I'm wrong.
> 
> yes
> 
>>
>> When I ran with sched-scoreboard
>> (https://github.com/AMDESE/sched-scoreboard/)with the patch on an idle
>> system for 60s I see the idle "load_balance count" go up in sched-stat
> 
> If TIF_POLLING is not set, you will use normal IPI but otherwise, the
> wakeup for an idle load balance is skipped because need_resched is set
> and we have an newly idle load balance  which you now want to skip too

I see! You are right.

> 
>>
>> Following are the data for idle balance on SMT domain for each kernel:
>>
>> o tip:sched/core
>>
>>   < ----------------------------------------  Category:  idle ----------- >
>>   load_balance count on cpu idle                             :       2678
>>   load_balance found balanced on cpu idle                    :       2678
>>     ->load_balance failed to find busier queue on cpu idle   :          0
>>     ->load_balance failed to find busier group on cpu idle   :       2678
>>   load_balance move task failed on cpu idle                  :          0
>>   *load_balance success count on cpu idle                    :          0
>>   imbalance sum on cpu idle                                  :          0
>>   pull_task count on cpu idle                                :          0
>>   *avg task pulled per successfull lb attempt (cpu idle)     :          0
>>     ->pull_task when target task was cache-hot on cpu idle   :          0
>>   -------------------------------------------------------------------------
>>
>> o tip:sched/core + patch
>>
>>   < ----------------------------------------  Category:  idle ----------- >
>>   load_balance count on cpu idle                             :       1895
>>   load_balance found balanced on cpu idle                    :       1895
>>     ->load_balance failed to find busier queue on cpu idle   :          0
>>     ->load_balance failed to find busier group on cpu idle   :       1895
>>   load_balance move task failed on cpu idle                  :          0
>>   *load_balance success count on cpu idle                    :          0
>>   imbalance sum on cpu idle                                  :          0
>>   pull_task count on cpu idle                                :          0
>>   *avg task pulled per successfull lb attempt (cpu idle)     :          0
>>     ->pull_task when target task was cache-hot on cpu idle   :          0
>>   -------------------------------------------------------------------------
>>
>> Am I missing something? Since "load_balance count" is only updated when
>> "load_balance()" is called.
>>
>>>
>>> The root of the problem is that we keep TIF_NEED_RESCHED set
>>
>> We had prototyped a TIF_NEED_IPI flag to skip calls to schedule_idle()
>> on CPUs in TIF_POLLING when the idle CPU has to only process an IPI.
>> Although it solves the problem described in the commit log, it also
>> required enabling and testing it on multiple architectures.
> 
> Yes, but that's the right solution IMO and it will prevent us to then
> try to catch the needless TIF_NEED_RESCHED

I'll discuss with Gautham on cleaning up the prototype and testing it
some more (we had only looked at ipistorm case) before sending out an
RFC.

> [..snip..]

--
Thanks and Regards,
Prateek

