Return-Path: <linux-kernel+bounces-101719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3D187AAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2508D2833B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D1481DE;
	Wed, 13 Mar 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iDQOJvDy"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3614270;
	Wed, 13 Mar 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346784; cv=fail; b=mVqRF6SVl4z8DJJfg6Jf4KjYjva21kx5Gg2i3yR/XtU8KVCwQe790JkdigaXyhTdXjleJzbDMxdoh3JzKm3pgO9C2e5A9O4wSATRT0ICG64Ahno2/rP9LY8rkJUKOEYtxGn68CzP4LGszGKFpVCsfpWMwlQYRwEp+WswAGfLypY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346784; c=relaxed/simple;
	bh=XjPlRtmBsXg8MD7h0yWhn57vWEh1awBtFoXLKsmi8IY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RPZSdoFsmzkI30ppY9y/Kr2Hb0eE6/c0Ic6NbwlcseR7jLlgIqh6q63qlcp8cLX9Bt7Ttzmfq+YMYloEaaQVWE3bh0lfB0v+/CVt2NRBSgnQkrCHeadCVQD0dNMxBLEwerFnUXlhquv949qxqBVnO3hY4rptLPJ5zaeM851yRL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iDQOJvDy; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBLWMizOIqlRKT4Qs07ZAfyWefE8gbenCtWuocjIv7pZVhR9N/D4rceE5CNs464dolzKKjCmMgIFuOR88QMWt4B6nuSJINQdRcLmdxPSFv1txrE+cRjUulOh/cVMLzg8CrmEFcpSIdFQd4EonA/7uERVlWJ2qMt+cMAwyW7El0eWxmYsv9tUmZxllJ5H3ifWuIDSs6129Pq8/8sx7K2ezO11UlR7zwcgtLWI/QtyBgX+eCYrM6XJxCCcs4iIcwWXHGDzNfdNKU/VRyT+D/1KaIudbPOyMdrsrGNgSvlluwrSJ2lK0wfZU1lKikLx4CieF2pRy/in8wOsgN3SOuPSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKXkctPf/Vmim++sayw+fJ0qKJKNKHSEYZ+mUqK19Ng=;
 b=nrFHt6RHFkFMkA8I/fJNLDfAqhwpWxymHzaSXTwA7z8u8wKJmAwU2y8vHJ3sA7RGL3g4z8OrNNCyviRbGFQZuIr5goAlsLk1HU4tkK8ctuyQ+UR0JcExOwlAWgUiXjlz/mf6pDOHNcJ9Yn+v7NndzRJEGmJIqoNOuPiVIFPp0D3C9XYzEhE7bNnfmL9zkycTcGeBu4pZUHcYHRYQufbM+OmMusUz/hQdx50Set3oWwK8FCi4nf+N99osi6s4+q9Dig8mHaUSqo0qp0y+xqImO29+4kTgraZmZdaPmjzythAGS4qxYmNQpC8Xii1HVZXDBEiUQmUVlaIOrq+BqMKMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKXkctPf/Vmim++sayw+fJ0qKJKNKHSEYZ+mUqK19Ng=;
 b=iDQOJvDyPGb7oeBUd/L5hv2s/oMbty2tayJjkkQOdBvIs3Ue3x0q5QWPjlAMNoMwkjs5WKVlrI5VlQ0vESemEdovgsfozpgQnkPvkH3ZoP0rorgAzeYauD7fi9jmtmmZoaXRnoHfm6QBNh3uh4TawcUQXC5WmXdjn1YeDgsMx0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 16:19:38 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d%2]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 16:19:38 +0000
Message-ID: <23206ef3-e019-476e-9e6a-3cb40148ee1f@amd.com>
Date: Wed, 13 Mar 2024 21:49:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Content-Language: en-US
To: Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
 frederic@kernel.org, josh@joshtriplett.org, boqun.feng@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 neeraj.upadhyay@kernel.org
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
 <aa221e99-bf08-4d36-aef1-07ffc5e71516@joelfernandes.org>
 <6c1ac571-b758-4168-a992-3704c60dba61@amd.com>
 <06e83751-3aef-4c7d-b4d4-e10e7da6d50a@joelfernandes.org>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <06e83751-3aef-4c7d-b4d4-e10e7da6d50a@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::11) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: dda2409c-3cda-4fd2-0830-08dc4379612a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KTzLGKrl3+fgQHUJGqZ7CqfdHo4Q8AmBzC3CvqYBCTq3tRf/K26aAoRc9T+q78QjQvZyY02IkxeA7rHnb6j6bKwe1UWNch1ys1OeqdGd24i0EOO90cmau+LXZ6YlThK7N/NtS3mbDgPPYK2d0FrhwNcHvzC1rf2osL2xnxyu70XX8Ij2tiyEqaxpFL98anOyowx4BiGY3k7z5KUg1sWjTtow26PsWLQhtAOuby8NfMeIc1uMPkRTxWkXAHJ9qgwCeo0m2jhwLKznV0vdUuc0JH3pJ7F4fiD+em8mh6v8GYtZGaps26Tfp4A9psS0Nea3uK/jgxNIwz9rc11aWoDv5kNQq1MxmiGxMBo9GTzyUYESUcSgxHbgfKBEujw6TDIgc5IDAKX6HeO4P1Wohn4Z0JOl5W5IiEh51lkEXgjZfWAWjNWMB4RBfOlBHG6F2Z5ntXSoymQI2llGlwaH84L28Z23vH2kDtQ2VEZQeX1cwcjxuBQZZvpxgoFHMJKJTtS9OcAF/+c06vMCGttXCiyifh1qeYx+u9sjoSuKHmxB3fEuT5vWXEmKLRxsl2AsYi60KdEYK4oVVl5nRk0fZNxuznBGwU8i0ExR7dvSnFrcZyd3cdMjfvcP3SAfAjS4Ycm4HcUqK8mIhvAHDDCB7fMU+zjdm1muj/610EsSWHQjIQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3VYYzU2MmczejM3TUJFaHB6YTNXdTZKRmc3TGVMOTV3dnlDM3RJRFhSOVAx?=
 =?utf-8?B?ZEhnUlpnWWpnL1RWSWpCTG90UkZoUXFxcGRoSHk5c0lBN0VHdGZvRCszZ21Z?=
 =?utf-8?B?RXduQ3QrZXJyd3p0S2o5dHJZYTBxSWY2c1VNS1pscktBMDRINDF5K2xlbUNr?=
 =?utf-8?B?VmNXd0dETzByUm5PREh6V0ZMK2xnY1hWbnBjYXg4dFlMeVlTK0hJcUovWjlO?=
 =?utf-8?B?ZmxmV0pEU3hCWXpLeUI4NlhaUlRZMnNQNG1xVE9LeEJXVW9oZi9PMk45bDhE?=
 =?utf-8?B?QTIrcEl6N2pXQUF2aFRFRXZLSkRIQUlEWjZpdUU1MzRFcGtvM1hhd1pPdmRQ?=
 =?utf-8?B?SU5PdllOS1o1MmNoVkh6V1BuNDNMSXRENzQ3RTM0MzI1cnk1TVo4TmRzTnVJ?=
 =?utf-8?B?YXhETGt1Y2FLaWtFUkpJQXpTb3FTdzRLTlZ4Y2dpbllCMUFWSURSU3R1RW1K?=
 =?utf-8?B?R1RrQjl6Z1liS0s2NjZkS0VEYmgycHhDNmpTOVJnN3lIY0FLQ0o0NzdueHkr?=
 =?utf-8?B?em1Db2R4dmF6ekdpem0zczdHUEJtaENLNXFCNWdYcFVkTFBENHBURnhIWVJ1?=
 =?utf-8?B?TVlLdDYzUnFnU083NGV0R3R2YWQwNEJ0ZkpMYjBxT1VaMTJqbHhZaXdFV3VR?=
 =?utf-8?B?NzlzZVNxMnNxL29IdkpzSDA2Y0hxUmlJRGpJN0I3dkxUOUQ2aWRvVkxKbzI0?=
 =?utf-8?B?ek42WFFRSjNnWWdXWmhXQjRzTXBkYWxwdUJ1UkF5ZUZhSEdnZTNqUHN0Tm9J?=
 =?utf-8?B?VWpPdUgxcFZnTFNoM01QQnVTUFVaRWFqaDdYNmVJVk4vUUZkaUo0YzBCSVR4?=
 =?utf-8?B?bGtuVDljcTl4L1YwVFRkSGxaVlkxUmhQd1BDV2E0eW1sV0dxdzBKZW8wd2hF?=
 =?utf-8?B?K1luL0VkcnJDUnBTU1NXNHZYMExQa0dGbERBWGh6NUhtSTdRT1B6b3pRZzBs?=
 =?utf-8?B?ZGZpYXRkWUZld2lCL3RMQkZlSzhYb3hocEF3bm5ZTklIOVkzYTdSRWVuWEpQ?=
 =?utf-8?B?NjVJQmFuZVhwVDdyc0NTbU5MRk1iTzdKOUNTTmtBY1NZMEpMUE9pWnM1R3Zq?=
 =?utf-8?B?SWpwbDdzUUl1K3JFd2p4VHhDRVl5eEJIZjM1ZVdHSU9RYkNWYkduTUZEN1NX?=
 =?utf-8?B?RDRJWGhwUWx4TWlNeS8zSVU2YnM2aEduRnFaMGhZZEdsMnErUE1qenNXRDZF?=
 =?utf-8?B?aTJSYVNaOElYWW5HRFBoOENWVEZ5YXdDOXRzWE9yVUViWHFSNEV1UkZiVW9a?=
 =?utf-8?B?VXc4SksvWTNEbTFrdDA3dzIvcUpiOTVmMyszdGJoYUlsbmhOd0Iwak5rVFh5?=
 =?utf-8?B?ekdVNHkyYWVSc2Z4WEExd1BaWUNjK3RmeUhiaEhrWkE3RVZzU1V4My9QRDVY?=
 =?utf-8?B?Z1pxSzBZaGlOTEhMWHJVSjh5ZFFhM2xDei9FQnJGZnQxSnloVm5sVldUY1BJ?=
 =?utf-8?B?L1ByVXI3L1puN1ZoVUpWOFRkQXNZZ0VSRmU0ZS8rMEdPREJBZ3Z5K2lUWUtK?=
 =?utf-8?B?RDdTcFdqdjdkSnNkMWJwcWQ1UFhoYktSdThwREtYdnpuOEEvbTQyaVhwOXV1?=
 =?utf-8?B?SVo1UjJ4UTl3bjhNbzViMldlUnZqeXYzbzQ1b3hmMVExd3lmS3VFbnRTVHBZ?=
 =?utf-8?B?Zmc5QVdXc2FNNDNEZEljT0RuUWxic2NGUTZ6aHp4cktOV0NMbkQ3b24rdWwv?=
 =?utf-8?B?YzB0SEtNaXBZenhYSzQ3RFNpKzFhTXdqeWVCWDNLL2RKdnBFcUtOOFhQVVJM?=
 =?utf-8?B?V2ZHdDNFLzYwNUtNdW9PWmROaXl0TFlYTGU4T2NTQVlNK05nQ1VwTFdYMkhy?=
 =?utf-8?B?TmtxbFl1YWU3c0FXNVY0Q1pnZXhIYm1zeXEyTXc4UWdVTUtZcDNOemphaGgr?=
 =?utf-8?B?NGJJRFBhaFBqVUVXOW8veCtYNWMxWGJaR2ZaV0xmYkRoUVNKVmpUYjB1VWJR?=
 =?utf-8?B?VTVWbUJuS3hPQ1ZHUk1CWS80QlZreGY2T2U2bnhuQzlPZkpaTlB2anhCNlRT?=
 =?utf-8?B?VGIwSzFnQVkyU25lZm04TldIUnFPUVJKbGEwVVFzcTUzcjY4UzM1MTBNZUZo?=
 =?utf-8?B?YmZKbzFtZC9wUVVmaGhtY0dzNlhwUFpoY3paUUxGaWF5MUpuTkVVM0grcCtl?=
 =?utf-8?Q?iGK0fAYlV8B5f/OfvSF8ZdCu0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda2409c-3cda-4fd2-0830-08dc4379612a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 16:19:38.3685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw6uXItQyagZU+qF+IEKU94bBPi8bzazN+DfN+8n3A1HmUMuzuYuUuQhDXcSRQtSarVsLIHNQcq/yrYcAF5qNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981



On 3/13/2024 9:43 PM, Joel Fernandes wrote:
> 
> 
> On 3/13/2024 12:04 PM, Neeraj Upadhyay wrote:
>> Hi Joel,
>>
>> On 3/13/2024 8:10 PM, Joel Fernandes wrote:
>>> Hi Neeraj,
>>>
>>> On 3/13/2024 4:32 AM, Neeraj Upadhyay wrote:
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
>>>
>>> small nit:
>>> Does done_tail access here need smp_load_acquire() or READ_ONCE() to match the
>>> other users?
>>>
>>
>> As srs_done_tail is only updated in RCU GP thread context, I think it is not required.
>> Please correct me if I am wrong here.
> 
> But will KCSAN not scream that its a data race?
> 

For reads from the exclusive writer context? Interesting, let me check that...


Thanks
Neeraj

> thanks,
> 
>  - Joel
> 

