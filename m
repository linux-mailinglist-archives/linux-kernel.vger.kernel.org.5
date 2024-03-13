Return-Path: <linux-kernel+bounces-102264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7785F87AFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBF828B467
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961C839F8;
	Wed, 13 Mar 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OxKGpAAD"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753182D8B;
	Wed, 13 Mar 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350777; cv=fail; b=EjHtw5s1z5twuPSbKqwjg1gqngqRRwQY7kqgZCqC5I24ykYPpHwQB1uK24CpKz+Ffx/VYj74LTwnaEBk17cV8lT4BINOEEEB0XZEFH98UsqnX4tew/Qyl0dBq1QRK3PspSRnPpXfhge/f/JAgWKlTYnVGOoqI1Pko9FwbURMoC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350777; c=relaxed/simple;
	bh=Jllauhp/WakEWPpYrJorX/1Xd9oJA0sZy6+UQ8H8hD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZB1Jzdx6S2aMRZXGAZTSr2vVK+tV2lbku21UhaeiXjSvGeami7ltvcHcomZBWb0tAaa+e0kyiSiMiK4Nl8aOhTAn342+z2fG780QUDfLXDsCDiweyblCaQ32J8f+3BiqCJjqnoiONudj9VKRQpX9n/9UEsztFb6QsvSPjClmzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OxKGpAAD; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXNE8EiedpAL2ZNDNUe5WMZc6owzhHcTKiHsnVr668VOO1nja3MgPeKq2RJk0NeoPQZ1mRg+dPrcMz7x6/G1GU0JT7nA7MHMc8NuaSoPZct5UuY0jdSfLNwOePgC2Y/85aXQRYTDgqJZPdePMeA1nhcJQRxeugK5hZeYbuvXTtNKeAbS6Aj0ojJQaHVr+Vo7K+Du2+XqDsc9xGGK+sF5UXkx+81AOm9ssARCgDrvgz1kbYqXTo+k8hlMJCjJQZDJaGqYsHEQIfUNgWxNv+Gy2TJJOyl34IJNgU3FybqM+vtxwBDpyD8tfnighH1mTycnEZN692N//wWJqW8U52e6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYOwuaiQM1TNpY+m/vLPZMqZ6Ox9XKh/XPWS/19hv6c=;
 b=SNt/Q6xfpQ09WEEPD4fkh1HZ3WCCbH37RF2jgCoqvf/6PL+to6DyJTKJRJ0paB+qnQyYZShp1HCU8n78r3NudWR3KygNPl3a0IqW5QqfK2oEFop/SSXH7JZWDcR8Cot+KracJpctzkUkbO/5DH7SyNtyr/KSo1KIjxKC/Ywexor2tXv8MocWv6U0hbdIbPjfHhF+zhshC3Jvtjby0vjMGktqvzpxVq2eFbbyeJk7NJGGhhUF7gTaoa1jAi7H6FjHt2pHQSCjhP1ilM11P7FfXhmmZ5pazK9ATJcpqpVyHzU0xdLw6bnyYHLUpXl6rTsuf6xEwkWfYAPE4imtIJCNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYOwuaiQM1TNpY+m/vLPZMqZ6Ox9XKh/XPWS/19hv6c=;
 b=OxKGpAADMDhogllT9iIjj3Q4wG2+QCr8x9rPrE3mPvnMRtt6a4dNnxZZ7cT5TGXf5w02MBIBBrksG+X97ESF0jfvgBUTTu7JZ5sY/gWtg8eqLLF0UtGdLByb8U1G/Qzxurtfey1C1oDKjfLMQTTTmCPC6iA5xJYDVR7idbgR54c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 17:26:12 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d%2]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 17:26:12 +0000
Message-ID: <3f544c35-365c-4782-8dd6-f523b257f867@amd.com>
Date: Wed, 13 Mar 2024 22:56:01 +0530
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
 <33ff03f7-0301-42fb-842f-17f21426cdc7@amd.com>
 <ZfHfNo_J-XZX0BS3@localhost.localdomain>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <ZfHfNo_J-XZX0BS3@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ccdfef-5a3a-4082-862b-08dc4382adab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bjSFqzgU84HxCylDWeLUFTzxfIRWAXsxblB+gcqFNK9ktQqeAXC7g1ODK5cELprTmNHwhHkmC1OFGu0Uxs1ltYI6AvwOf032oGtfjnx4c5ZMpVJcm8Dhxll0/wm76WSCO9Ie+WLlbi3RJy2WY1yzWlIoXiBmUILwYUbH20YwvDjGE9rf4FLY4IJPIG56DDNFpKxea3mOKfecEF2oUwHrCs5jMO0MRLKjefRVe5DdFV3yrj59CcD6jp3SQIkyXTO4EEmAO198BWjXdXnqkwOreHYpkXO/ThKsHUZN+cDHGsrR9F7vtbgiQooHgu7tG+263VkVxGAjnnSEw9pTQhLrQ0KlanWV9qMA7go+GVVo5XwRzbVzuuYIeXH/6X+6nJ4Sv5b9wVo/eKxr05p9+lvUerhYHySWdlzqiQFtSfCycoOz9VEwAkwTzxH9VybEQ1RjvgG8oisFtpntugtf0r3jXnFl8BfeZ16oYRkPoyO59z7Bjza737+ohgFUr8j11OUJMVO0pge+yWaBmurQgTubxuYYhjFSKdOm+pMEPJvQOgK/FHJPVZAaVWtL4s4oqIqO23SVwzfdWZBpB5reTLFveGC3UD2uA9sFGDv9ErlX9wMJInQKeXaMqx2ExuUyp9fPxEoul31eWoCgdpwwXLtDUJpfWdIcY7v2y4KGrvprPiU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2FEVVU4cjdKcmNLUVBUTlJSZnRMbGtRWHBxbFl6VHg4YThoQUVXbFpwUzNT?=
 =?utf-8?B?WGxNZDBZY0sveXlGeWI5ZTJNZjVhZ0RTYmJISkRNZGtZTnFmVlN0R0dRcmtm?=
 =?utf-8?B?dUNlWC9vTWxSaXBsTzFwQnNZNGNRQ3dlRy91NERIRDlLSGVxSlNISkkzVHpw?=
 =?utf-8?B?T2hLaUZCQ3FJaTMydjhKQnl4THcyNGoyMnpsQzFsemMzV2VXVlZsQTJzZjJJ?=
 =?utf-8?B?SFpuWFo0SXFKZ3h6a243UWlodC9wNFV1TXMrWHhxUCtDL2Q5eE12bVhjVFhr?=
 =?utf-8?B?SFRwdWNiam1BeTJoV0RObU9SQlFZUVdIREJnWVQ5YURQVUkxN0Y1TTVLMThj?=
 =?utf-8?B?ZjB1S3p4cmV5eklHanZtRm5wRFQ4NVhiUkkybmlUbXZHRjF4cW9XTm1lMlg0?=
 =?utf-8?B?Visrd2Nmd0l4T3owYklvSWMwZXNvQ2xYY1Jjd0p6dE1xbi84Y0gwL2g1RTZJ?=
 =?utf-8?B?bUpGY25id3docjZDYldRa1owbDI3cW4zWW1OS01MNW9Zdlo1Qk1uVFRtZnNh?=
 =?utf-8?B?aWxUNXVIbHBiN2IyMW5SL002U0Y1YU5aUXVqZHZSdGd2ODIzcVAzcDJBMVBl?=
 =?utf-8?B?L1c0b0tqZk1ucE5XbFY0NjJXTVVqRzBqV2FwMzczMldmU1VvNXRVZWpPUkY1?=
 =?utf-8?B?NGx2cnErWmY3NjlscVpOaE8zblVnTDE5SlpYekV1SjA2cmRIZW5FMVFkSDlI?=
 =?utf-8?B?QlNrbTRRT1REaklocWJsc3EwV3l3MTE5UzZhSERaZytRTjBkRjZzMjh3dGJK?=
 =?utf-8?B?ejI4WnhSdGNHcEpFT1o5ZlpuSkc2dzJ3cEhZWHdXMTc2UG5pbXRhTlJCZW8z?=
 =?utf-8?B?M0lJOG52KzZSR0piMldUWU8zZHVncWw0cGNQNDFnK3kyRERxREE1RkNkTG5Z?=
 =?utf-8?B?dVgvQnY2c2w3eUVYdk1oZElBWkRMcVhUQmZiak1ZQ09wZ0l2NGNvTEdPb3BR?=
 =?utf-8?B?YkVuKzNSQUl1VEFSbTdwU1JKK0ZxbTBaTzBaalhLM2xMaTVCV2NXbmhyK2N5?=
 =?utf-8?B?MzVnU01aV0FBdm5MenJWdVVPV3o0UDI1WGJFY0kyT0NnRW9mRjUvdEZWQldV?=
 =?utf-8?B?djFCNS9iOVgrNTF0S3d3QUJnTHdJYk4vSjQ3eDlLTXNkcmkzM0hveC9BcG1P?=
 =?utf-8?B?V04rNjF2b00zbFk2RlJGRFpjajFxdG8yR01PeFlGUEYwWVpTK1l3MXdmdlg1?=
 =?utf-8?B?NEFxZjRoZ3psUEtkZU54UzV4d1djRUI3Y3NsUDhFdlptOFlhTW16cTA4N2tU?=
 =?utf-8?B?cEFjYmFEMTVPNHhnWWhQN0lJcGVYUFBQRDBVMjJvR3lZRXRBUjBZT2lualBl?=
 =?utf-8?B?MTdTcytwd2s4bFJyamRLdTlqOEgvNXlSV25NSmk4Qk9ZR3phMFZONFdub09p?=
 =?utf-8?B?dDBBdHhTV2wyZ3E2L3R4c2pBU3JhaGp6ZVZtaGRNcEhrR3pDSUtWYWhJZkln?=
 =?utf-8?B?YzRxOWVselRoMGFsWXl4SERlUkViWmVuM1VraktWKzJ4bHVGemttN3BQenFh?=
 =?utf-8?B?N0ZCdXhKdGVDUVR4WllCSGtQSVlHeURQaVJsY1VHYURObG4rL3hMTmkya2Ji?=
 =?utf-8?B?MnFsVFZNQmd3eVpzRHNVZU9qT2huWUFtd215VmNBQURrRm5RdU1WektIQ2Ru?=
 =?utf-8?B?UUJXOUZOeXdMdkNIRTUydGFrUDBRTWFhRzBxOFJXS2lVbmduWVBCK05pQWYy?=
 =?utf-8?B?d2RKS0h2MmovVzhxWTRkc21hTnhPYVdUekFQRitWWW1ScHhHV0FuNk1iWWFE?=
 =?utf-8?B?R3gwRnQ0YW01VTY5RDZBU1kyTUZWTzlIcE1vbFY4bGdSVkY3Nms2UXE0d1Ru?=
 =?utf-8?B?SkpmSGFaYTR3Wko2eTh3a2l4RUhFTnBWdnQ4RkxhMXRIV281dDkwdnAzMDY0?=
 =?utf-8?B?MGVDM2EzdFNjYlRGNUhlNGVSc3BUSC84bmc4dzlGQWxYTkZ6QjBiMzM1cmtt?=
 =?utf-8?B?ZWswREdlMWFjZWZDdk1HYWhEZHdiRlNsV1paOVZiV2sybFJjRXZ2T2E4NEJF?=
 =?utf-8?B?RUY4SFRONGJNUWFDcmpCS2VDYmZ5ZUh4ZjR2Yjh5YVdXQm1rakRuc0tNY3JP?=
 =?utf-8?B?bjFFYkx4bmYrNlNWbjRQdlFxNGdINndCMlJmakhab3liRDJNOTgrNGs0TmFm?=
 =?utf-8?Q?YIpuynVfb7PcnhF/4pjDgAV7x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ccdfef-5a3a-4082-862b-08dc4382adab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:26:12.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpMGIyD9zbGJfqRu8vY6Zn25YDo2m0Zu4WerpmuVFSf0rLvHgRaElmyu8EfFJ2GgdzFEi04AGgjS3o8V8r6gNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210



On 3/13/2024 10:45 PM, Frederic Weisbecker wrote:
> Le Wed, Mar 13, 2024 at 10:24:58PM +0530, Neeraj Upadhyay a écrit :
>> Hi Frederic,
>>
>> On 3/13/2024 10:13 PM, Frederic Weisbecker wrote:
>>> Le Wed, Mar 13, 2024 at 09:41:58PM +0530, Neeraj Upadhyay a écrit :
>>>> Hi Frederic,
>>>>
>>>> On 3/13/2024 8:48 PM, Frederic Weisbecker wrote:
>>>>> Le Wed, Mar 13, 2024 at 02:02:28PM +0530, Neeraj Upadhyay a écrit :
>>>>>> When all wait heads are in use, which can happen when
>>>>>> rcu_sr_normal_gp_cleanup_work()'s callback processing
>>>>>> is slow, any new synchronize_rcu() user's rcu_synchronize
>>>>>> node's processing is deferred to future GP periods. This
>>>>>> can result in long list of synchronize_rcu() invocations
>>>>>> waiting for full grace period processing, which can delay
>>>>>> freeing of memory. Mitigate this problem by using first
>>>>>> node in the list as wait tail when all wait heads are in use.
>>>>>> While methods to speed up callback processing would be needed
>>>>>> to recover from this situation, allowing new nodes to complete
>>>>>> their grace period can help prevent delays due to a fixed
>>>>>> number of wait head nodes.
>>>>>>
>>>>>> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>>>>> ---
>>>>>>  kernel/rcu/tree.c | 27 +++++++++++++--------------
>>>>>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>> index 9fbb5ab57c84..bdccce1ed62f 100644
>>>>>> --- a/kernel/rcu/tree.c
>>>>>> +++ b/kernel/rcu/tree.c
>>>>>> @@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>>>>>>   * for this new grace period. Given that there are a fixed
>>>>>>   * number of wait nodes, if all wait nodes are in use
>>>>>>   * (which can happen when kworker callback processing
>>>>>> - * is delayed) and additional grace period is requested.
>>>>>> - * This means, a system is slow in processing callbacks.
>>>>>> - *
>>>>>> - * TODO: If a slow processing is detected, a first node
>>>>>> - * in the llist should be used as a wait-tail for this
>>>>>> - * grace period, therefore users which should wait due
>>>>>> - * to a slow process are handled by _this_ grace period
>>>>>> - * and not next.
>>>>>> + * is delayed), first node in the llist is used as wait
>>>>>> + * tail for this grace period. This means, the first node
>>>>>> + * has to go through additional grace periods before it is
>>>>>> + * part of the wait callbacks. This should be ok, as
>>>>>> + * the system is slow in processing callbacks anyway.
>>>>>>   *
>>>>>>   * Below is an illustration of how the done and wait
>>>>>>   * tail pointers move from one set of rcu_synchronize nodes
>>>>>> @@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
>>>>>>  		return start_new_poll;
>>>>>>  
>>>>>>  	wait_head = rcu_sr_get_wait_head();
>>>>>> -	if (!wait_head) {
>>>>>> -		// Kick another GP to retry.
>>>>>> +	if (wait_head) {
>>>>>> +		/* Inject a wait-dummy-node. */
>>>>>> +		llist_add(wait_head, &rcu_state.srs_next);
>>>>>> +	} else {
>>>>>> +		// Kick another GP for first node.
>>>>>>  		start_new_poll = true;
>>>>>> -		return start_new_poll;
>>>>>> +		if (first == rcu_state.srs_done_tail)
>>>>>> +			return start_new_poll;
>>>>>> +		wait_head = first;
>>>>>
>>>>> This means you're setting a non-wait-head as srs_wait_tail, right?
>>>>> Doesn't it trigger the following warning in rcu_sr_normal_gp_cleanup():
>>>>>
>>>>> 	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
>>>>>
>>>>
>>>> Oh I missed it. Will fix it, thanks!
>>>>
>>>>> Also there is a risk that this non-wait-head gets later assigned as
>>>>> rcu_state.srs_done_tail. And then this pending sr may not be completed
>>>>> until the next grace period calling rcu_sr_normal_gp_cleanup()? (Because
>>>>> the work doesn't take care of rcu_state.srs_done_tail itself). And then
>>>>> the delay can be arbitrary.
>>>>>
>>>>
>>>> That is correct. Only the first node suffers from deferred GP.
>>>> If there are large number of callbacks which got added after
>>>> last available wait head was queued, all those callbacks (except one)
>>>> can still have a GP assigned to them.
>>>>
>>>>> And the next grace period completing this sr (that non-wait-head set
>>>>> as rcu_state.srs_done_tail) and thus allowing its caller to wipe it out
>>>>> of its stack may race with the cleanup work dereferencing it?
>>>>>
>>>>
>>>> This sr can only be completed when done tail moves to new node. Till
>>>> then, it gets deferred continuously. So, we won't be entering into
>>>> the situation where the sr processing is complete while done tail is pointing
>>>> to it. Please correct me if I am missing something here.
>>>
>>> Ok I'm confused as usual. Let's take a practical case. Is the following
>>> sequence possible?
>>>
>>> 1) wait_tail = NULL
>>>    done_tail = WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
>>>
>>> Initial layout
>>>
>>> 2) wait_tail = SR5 -> WH4...
>>>    done_tail = WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
>>>
>>> New GP
>>>
>>> 3) wait_tail = NULL
>>>    done_tail = SR5->WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
>>>
>>> GP completes, normal cleanup
>>>
>>> 3) wait_tail = SR6->SR5...
>>>    done_tail = SR5->WH4->SR4->WH3->SR2->WH2->SR1->WH1->SR1...
>>>
>>> New GP
>>>
>>> 4) GP completes and SR5 is completed by rcu_sr_normal_gp_cleanup(). So
>>>    the caller releases it from the stack. But before rcu_sr_normal_gp_cleanup()
>>>    overwrites done_tail to SR6->WH4->SR4.... , the workqueue manages to run
>>>    and concurrently dereferences SR5.
>>>
>>> But I bet I'm missing something obvious in the middle, preventing that...
>>
>> Your analysis looks correct to me. Maybe, one way to fix this can be that
>> rcu_sr_normal_gp_cleanup() stops processing nodes in its context,
>> when it reaches done tail and done tail is not a wait head. I will
>> think more on this, thanks!
> 
> That alone is probably not enough. In the end you may end up with a real
> pending sr stuck as done tail without completion, until one day a
> new real queue comes up, preferably with a real wait head in order not
> to get stuck with a new sr as done tail.
> 

But after point 4 in your sequence, rcu_sr_normal_gp_cleanup() would move
the done tail to SR6 and queue a new work, which will process SR5,
so, we will be able to progress real pending srs?


Thanks
Neeraj

>>
>>
>> Thanks
>> Neeraj

