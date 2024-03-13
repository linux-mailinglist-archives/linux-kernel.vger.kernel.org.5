Return-Path: <linux-kernel+bounces-102112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5813B87AE82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CF01F2EA00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530B5FDCC;
	Wed, 13 Mar 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L67BwN8/"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9DF5FDC4;
	Wed, 13 Mar 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348913; cv=fail; b=ceCRwSSSjI22IYOtffgfvQ0NSAJ67oT4SmlN9qC4lIIzmUXwaR2HiK5i7jLAYDHIqv51hK2Tx/aGsZEDCP4AHp5EYns8z+vjmYkG1oMv8VshI8+Ul6s+WwJVfiR1b1qE48oTpJbcgk76qGclPKD4rEo3eiaPtdbnfWk20Qwlpo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348913; c=relaxed/simple;
	bh=o+m5bARjoysIX8AqAKlAZug3jLMlc0gixV5f+cnde1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iTm0KfhWSollSwpsL5uoBiqDDmCsCSUdCe4pFKmXse4Zc9nA0n9ZHfSVW5xaG8hiqOJADPs66Vdd5rcnvW0JFs6QDgSI3nl9sSWgjt8P0SxXiT49NjcyDC3XIxTG6VHbXx+Npy2teR01SwBjDuLbv7bDkFJ9r2ithx0ycMe9D6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L67BwN8/; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H84bf134KTYfWjfgjO1fJuRjeKUCmuVDmBM0MwIANAZvqR/lJC7Xzy6fBZxbMeyyXloV0b5NxIq/IhJH9Uuk6mkyey+lYJ4Q82X/pp30DJix8jWjhRMw3v0w+X8g2wFy6rUa0quZ7IYds6HcpkcvKHPh4ZyyXVUiyzNQqdipBy3HJ5i+Y/x+HyG7gd//a39TRyuVEQpTymCZL06kzdzgFPjXWZSbFC+9yExlOalW3xRA24xFtrhYB/YP2xrEbMW9N9B52nYZAuTx926HuzQNX2n5wGZtNAIH4EMy454+BFeG+gmmXMSDlMtbvX/MuN8o0RJ+H21fyu/dMpKGLHfxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUekxvWCae1QkWqJ/7QB5OpEDC0W+20A/KzdL0hWaPo=;
 b=EHQKgAJ23pxI5OrDFfdJ6+rh8CjoQwVUZHAogtl8FpnI5XL8q9/Wqhvr6ycKc+WZcP7BwDy22rTHfs4jCYZdSPg4woKCxpGimgd9Y6/QsEVxdnR9iNdOfOSQsmlw7nK8IBQLyRxIEO4Yq8xZjFJ8kjTFECDma6FLjB+NWHsKRyQjmMF3tXo+PgCKIQRppUC84dP8YRxXjpiGtaQBwPtAi/XWlZxlMN9dwdBaQO/iZ3Xq78CW/rqCCSHwmhPCA1f2xEG0tXbsyVbO3VElH/XoilL+K56obYkphk8u2V7c5sud5yn2N5am7FcXy4Xc38S4Wy7c16jqnOeh5b711KoQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUekxvWCae1QkWqJ/7QB5OpEDC0W+20A/KzdL0hWaPo=;
 b=L67BwN8/yPM3KOrLUrQKhTRW/oC6rOA/r9LmEGIF0V8ei1hHjg/SV5d/1azHr/KmGXtmkqAJTNDkfSJ17P6Elrcmih6MnbOz4VJGKBwO3x+BWP2iSrXhKNjARC9vjLj2lMYXbkasc3A8iotPfTnuVR6nJjjDnQuxLVx5sEGHI7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.19; Wed, 13 Mar 2024 16:55:08 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d%2]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 16:55:08 +0000
Message-ID: <33ff03f7-0301-42fb-842f-17f21426cdc7@amd.com>
Date: Wed, 13 Mar 2024 22:24:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, joel@joelfernandes.org, josh@joshtriplett.org,
 boqun.feng@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
 <ZfHDwPkPHulJHrD0@localhost.localdomain>
 <35e009c4-d52c-4b96-ba10-afa0be9dfd5e@amd.com>
 <ZfHXrTUHRhAVjBOE@localhost.localdomain>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <ZfHXrTUHRhAVjBOE@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::23) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb2ba2e-10b5-4273-fb78-08dc437e56da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pAeoa9JYqaukSrPfvP+clJPUlIC9sZgJxMUikENStZ2e2jSxoyX2/Kq18c/B3JN+3V7Jrxf1lmAs/JlEH5JeJlCX8L79HKfekyB21o8cw49CpXm6OsyMmv6exbhpwHCEZzo78sYGuuUA++kPxI9m+bE6iAIJzthLqlCpcW4fC5K55XCI4W6KZWTg9b9oSAH/UpNDVIVN2ws1+WPZ/ohi9lxm9te1DqlVh00Jt/PpiNpRGsjuNt3/9He7yr4AUAp3+Cz4hIVa5DY3QEe85R/gM0BVw1Z+lUAwUD5f6WMDhpV0fBejEy+jzv2QfcFvCtNZDoZnYVHot067q/55E4z/AJTUDCfcv+pX0SE65syoN642zPIs2l0uMH3vFU0jCRi+Ou0CuV6FUieLQ2mke90QTFnHVtMCmCgEACOTQSj3rdz8La0k8oYvmh8mySMzz/Y3EigJ50NeS4vkOI5m5GElQXuWFYWVVGIcYhLO3DREsZAK/LYxwfDWgelD81evoqeFkzy7pqGGCD94m8nr2RLR1SzLUzhBxDYXOoTpGaA+RO/N7UUBafUZoLvpj1nbPd9vY4KZBwbok0CaW6jJgCNKmsJaURNFRL0xaDjlfYKyCrsu041Ampfq31QRvBvzTPoA8Y6A3B/IFuYlRNi8TfKNRAKw7j2WvsuuvmRztaE+L9I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDNNb283NE1OUXVTOXZYN2xLYzczN2FLdEdFbHpPS2ZTZGVLYmRmaXUzMjZq?=
 =?utf-8?B?S01tUUE5SzdWS1J5cHErWnNGT1lHdHZVQjEvT2trTHJFM3hNOFQvMmFLN3B3?=
 =?utf-8?B?Nzh6cGhmdDlIY0lsTUpjR3hFeCs4a2loSmpSNnZ5ZWRLbHB4b1JTK0ZuTnZR?=
 =?utf-8?B?VGlPd2RnbzhRYjBnRzlCK1dpMCtUMm1lT0JacXI2UmFBRUVwdlNaMmpoSllw?=
 =?utf-8?B?WHM0MmttYVBFVkdaN1VRZ2R4MHk3Z2x6a3VhemtKWkNtRmpSRERMemU0YU03?=
 =?utf-8?B?eUVnc3dwMTdudGs0YnJkbi9UekpmcVo2Z2I4MlBqMzlRRnZKUVBpVTVEVncz?=
 =?utf-8?B?SkVEaThEbmo1WUZEN3FqVXNUeHZsZzVhNnNHRDhKeGg0R0JNZjNxTzlpWUhJ?=
 =?utf-8?B?eXVTaUJPNHU1ZHArZHlwVVhMNlk3UUlLbmdsa3l4bkJTdnNSd2E1VmN3aXc4?=
 =?utf-8?B?UEdYb3pOb3M3UFJpbEUvVVByY0drMUJUR2VUdEJaYk93QVo0cUpMZ0dER1BX?=
 =?utf-8?B?alNiQUc5YTJDcTlhVkhmOC9VTUViZXVYeS9LWUo5QVd2emt3ZEp3dExSWUN5?=
 =?utf-8?B?TnBYNk95RC9wSXRaMTZJME5Bbm56VFdPK1ZqTFBoYnRxOG1McFQrWjQzY1hC?=
 =?utf-8?B?SmVxcmRIVlZyTEtGa2pDK1pVenVBTkZza1pobmZJMFB5bEcycDhDZmxYSU92?=
 =?utf-8?B?V1ErODdVNmJ2MURwU0YwallHQUM3LzhqZ0lQU2czVVZLeDZhM1hhQ3d3azZv?=
 =?utf-8?B?ZmVvM0liVDd2TCtqd0p0RFVZemFrSW9sOHlhNUJsdXpNOWh6TjdyUlNScy9N?=
 =?utf-8?B?QTNtVGRlRktNVVA4TVJ0elJiMElBUzZyQ082UzNSYlZ6c1FXS0pNbnA0YjJ0?=
 =?utf-8?B?bk1vMVZJWlBCVm94dSt6dGdXZFZDa1o3SVFiMmE4dFpQMEd1ZzdJK3RGczlu?=
 =?utf-8?B?UXFyejMrVnhSWDdXQ1FwTUIvS1RNQmQzWXZzSTVobUpQajI1Um5ndE53SFZp?=
 =?utf-8?B?ckxXVTdxdnZwV3FwUnlZenhlbUluL0JuWDNLeFc0azVhdE5mNWZEc1hVM2Nw?=
 =?utf-8?B?YnV0Qm84VVVkV1NCcHloc054THMvZ2xvN0M2blRoak1uSjhTZjZvSWpYM2xx?=
 =?utf-8?B?Q3dJY2FER3lkdFMvemFiV1prM1MrSzNmZ0FJcW8rSHVvSjdmOVVSU3Jzb0dW?=
 =?utf-8?B?OFdJOWVkN3BvbkljM1hsR1dVWVZyZkNuRFE1UUR0QklNQU5Md3hsbUNwUFJa?=
 =?utf-8?B?d0d2WXlvdGhabzY0bHVqWnRyT2dJOGtkTkJSa1NvV1RSUllOejZlY3o2eWlQ?=
 =?utf-8?B?WU5yRWlYb1QwWWV2MDZhdENUUzBQRlRPWmMxZ04yOEtURm54bDF3OFhjL1ox?=
 =?utf-8?B?TGVoL1lWUVRQaXhSOC95MHFiWnZsZG52MCtBY1NZQU91SzhJV1ZlZzlMVnRU?=
 =?utf-8?B?eDZTQ01GWHl2NHQ5N1Z4bWp4bjhBa0xUQ3NGdCt1M2U5V1dPRzFtczRHWWlI?=
 =?utf-8?B?QXNPeWpKN2JUY2NncDJKV1Z1SE5pYkZ2ams2eUM5UWNBeEZWL1Z3dU04eXFi?=
 =?utf-8?B?cUkrK0lJd3Nyd3o3cjczTG93L1V0QjVMWm5jNHZvOGhOWUhIR083dGFLUFJX?=
 =?utf-8?B?dDkxVm5JamwwUGJtRC9BejFHN2VQdWtRSFVZZ0RQcmp5SytXSUpjYUxBVmxj?=
 =?utf-8?B?bFZRWG5waFd0bGsrdGFjNVh0RW9vMnhZaG9tSUVrQ3gveVY2UmNZTkVmd05h?=
 =?utf-8?B?cUZlSlhqZkNoODhmMGllZGRibHhUeEZuYjN4NVFwcUdmdHJZK0prNm01bjlt?=
 =?utf-8?B?VndQSXI1dnFSMG5RRWxPWWR3aUdaNm9mVVRya3J6N2NaL1lhQTBkS3ZheGVx?=
 =?utf-8?B?WnBwWEVOZmk5TVllYlRKV1FyK05VMXAvWGM0UjgzcnI3Q05pRUJUMmdpQkNs?=
 =?utf-8?B?Yk9ndWZDQUV2UkNuLzdiSFhQNkNZeTYva1UyTXRvaUJpWnBsVVpvRkFZazBz?=
 =?utf-8?B?WGVlS2REUXdhcjJ2L001TGJuRzBheWZIZVZWOXEzY0wzZzIyS0xaeUVyRTVC?=
 =?utf-8?B?R1RtSVlBVVBiQmZCalRlRTNrOXNvTHIrZFM2eVhldFlrY3dKSWpVSUhWc0h0?=
 =?utf-8?Q?R2PY8Sj4ZVe48Euzcznvy+28b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb2ba2e-10b5-4273-fb78-08dc437e56da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 16:55:08.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPSPU14E6AGAVRPhl2gfr+XdctZwbFyUBlpvNWV50CeNOZTLjQSVJJJa9XBJXGyQgQuTlr72rlCqzsbrWadWqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553

Hi Frederic,

On 3/13/2024 10:13 PM, Frederic Weisbecker wrote:
> Le Wed, Mar 13, 2024 at 09:41:58PM +0530, Neeraj Upadhyay a écrit :
>> Hi Frederic,
>>
>> On 3/13/2024 8:48 PM, Frederic Weisbecker wrote:
>>> Le Wed, Mar 13, 2024 at 02:02:28PM +0530, Neeraj Upadhyay a écrit :
>>>> When all wait heads are in use, which can happen when
>>>> rcu_sr_normal_gp_cleanup_work()'s callback processing
>>>> is slow, any new synchronize_rcu() user's rcu_synchronize
>>>> node's processing is deferred to future GP periods. This
>>>> can result in long list of synchronize_rcu() invocations
>>>> waiting for full grace period processing, which can delay
>>>> freeing of memory. Mitigate this problem by using first
>>>> node in the list as wait tail when all wait heads are in use.
>>>> While methods to speed up callback processing would be needed
>>>> to recover from this situation, allowing new nodes to complete
>>>> their grace period can help prevent delays due to a fixed
>>>> number of wait head nodes.
>>>>
>>>> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>>> ---
>>>>  kernel/rcu/tree.c | 27 +++++++++++++--------------
>>>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>> index 9fbb5ab57c84..bdccce1ed62f 100644
>>>> --- a/kernel/rcu/tree.c
>>>> +++ b/kernel/rcu/tree.c
>>>> @@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>>>>   * for this new grace period. Given that there are a fixed
>>>>   * number of wait nodes, if all wait nodes are in use
>>>>   * (which can happen when kworker callback processing
>>>> - * is delayed) and additional grace period is requested.
>>>> - * This means, a system is slow in processing callbacks.
>>>> - *
>>>> - * TODO: If a slow processing is detected, a first node
>>>> - * in the llist should be used as a wait-tail for this
>>>> - * grace period, therefore users which should wait due
>>>> - * to a slow process are handled by _this_ grace period
>>>> - * and not next.
>>>> + * is delayed), first node in the llist is used as wait
>>>> + * tail for this grace period. This means, the first node
>>>> + * has to go through additional grace periods before it is
>>>> + * part of the wait callbacks. This should be ok, as
>>>> + * the system is slow in processing callbacks anyway.
>>>>   *
>>>>   * Below is an illustration of how the done and wait
>>>>   * tail pointers move from one set of rcu_synchronize nodes
>>>> @@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
>>>>  		return start_new_poll;
>>>>  
>>>>  	wait_head = rcu_sr_get_wait_head();
>>>> -	if (!wait_head) {
>>>> -		// Kick another GP to retry.
>>>> +	if (wait_head) {
>>>> +		/* Inject a wait-dummy-node. */
>>>> +		llist_add(wait_head, &rcu_state.srs_next);
>>>> +	} else {
>>>> +		// Kick another GP for first node.
>>>>  		start_new_poll = true;
>>>> -		return start_new_poll;
>>>> +		if (first == rcu_state.srs_done_tail)
>>>> +			return start_new_poll;
>>>> +		wait_head = first;
>>>
>>> This means you're setting a non-wait-head as srs_wait_tail, right?
>>> Doesn't it trigger the following warning in rcu_sr_normal_gp_cleanup():
>>>
>>> 	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
>>>
>>
>> Oh I missed it. Will fix it, thanks!
>>
>>> Also there is a risk that this non-wait-head gets later assigned as
>>> rcu_state.srs_done_tail. And then this pending sr may not be completed
>>> until the next grace period calling rcu_sr_normal_gp_cleanup()? (Because
>>> the work doesn't take care of rcu_state.srs_done_tail itself). And then
>>> the delay can be arbitrary.
>>>
>>
>> That is correct. Only the first node suffers from deferred GP.
>> If there are large number of callbacks which got added after
>> last available wait head was queued, all those callbacks (except one)
>> can still have a GP assigned to them.
>>
>>> And the next grace period completing this sr (that non-wait-head set
>>> as rcu_state.srs_done_tail) and thus allowing its caller to wipe it out
>>> of its stack may race with the cleanup work dereferencing it?
>>>
>>
>> This sr can only be completed when done tail moves to new node. Till
>> then, it gets deferred continuously. So, we won't be entering into
>> the situation where the sr processing is complete while done tail is pointing
>> to it. Please correct me if I am missing something here.
> 
> Ok I'm confused as usual. Let's take a practical case. Is the following
> sequence possible?
> 
> 1) wait_tail = NULL
>    done_tail = WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
> 
> Initial layout
> 
> 2) wait_tail = SR5 -> WH4...
>    done_tail = WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
> 
> New GP
> 
> 3) wait_tail = NULL
>    done_tail = SR5->WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
> 
> GP completes, normal cleanup
> 
> 3) wait_tail = SR6->SR5...
>    done_tail = SR5->WH4->SR4->WH3->SR2->WH2->SR1->WH1->SR1...
> 
> New GP
> 
> 4) GP completes and SR5 is completed by rcu_sr_normal_gp_cleanup(). So
>    the caller releases it from the stack. But before rcu_sr_normal_gp_cleanup()
>    overwrites done_tail to SR6->WH4->SR4.... , the workqueue manages to run
>    and concurrently dereferences SR5.
> 
> But I bet I'm missing something obvious in the middle, preventing that...

Your analysis looks correct to me. Maybe, one way to fix this can be that
rcu_sr_normal_gp_cleanup() stops processing nodes in its context,
when it reaches done tail and done tail is not a wait head. I will
think more on this, thanks!


Thanks
Neeraj

