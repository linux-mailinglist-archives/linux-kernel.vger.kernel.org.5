Return-Path: <linux-kernel+bounces-101712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4A087AADF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF61B1C21B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BD482EB;
	Wed, 13 Mar 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3BOczQ83"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA85D482C6;
	Wed, 13 Mar 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345860; cv=fail; b=dyu6jQpHpGbPDw4I1NrqZpn1Oti0KaiWiC+0lfzeKyr3XHhr2CxelUjq8yMcPth5NAxMSkqVW+I7HG/oXS7b2v86Uv6mIL8zYHGoxoka9AaUalE/5Y77OaGJDUju0Zk+3Pp4wOBUH/ogSXaUm+L8dqCTlN2ppBwwUdmdgo/+3PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345860; c=relaxed/simple;
	bh=63L0bHE/Fwfqh4IWA5YlcKhs1N2qVR5idwQ6tB22RXo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oFpz9SiWoyagNDICcFlK/l5N7G4WtmSwdX1tPdmMZQ8uVYv4tvd/t+EoEjz3pTxYEuIc8JZecahBUUttdr1a3qqHO87/uo0AU6EazNkWV2dx/Vw2SLu7bONMlbp+80HRI8tbezjgH/StErD8ck6ZrzKH/kIIT8Jj4yy/a1iDzeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3BOczQ83; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8OCI0rfwr+prh4cGl91XdaIeb0S/YGIqX475GXXbqAKDAM4y7PNqMqcf1ldWTPpzeDUSh0xBXzUC3t4FE3A2zdW9rC7ZJ9Tl/6YyV8VTbjc6WG1sPekogwNQVO0aiABWgjBNVeM6X03oXQdudvzNsiVez1OMzfYCb1A4foXv1m3i1yIUK5nriUej7BGcJ/IOhZmHBhKdF7owqbV1Q8BSpQoJBRYTVtddNtEWsfcWBDnQDrZzylMSVxmJVXdOuvMYSKXzdFCFa5gZ4fbi8EZjYFJ3MjGi0Zoxql0p2Mw0EtwUFP8h/bA5qRpLf1CZ9JtA0k2NwnZYRvdNJiA9oj0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRsb0rDOjUnnotUxINarqaONUDLAZ7dH4lsoxE4yLVQ=;
 b=EJJ0p6zCyKirSvSbvXBqY7IU6ZElsAnheHlefPG45DDQY4ljXGE5Wsu2cS8E/hOztMZ5s7kqs4DdWcxBhvl03oa/8Sc1A+Dosa4GOo3zcWrKy1FFYuGIMOmVIsixTKPcc/3rDHz5ni0J3spoEqVGYQYQjjqX3h3H+u01Vpf9SobHcErcyCnQ1upFv9ZOV0g1ZBG5WPHxR6nt4vtL6jY/4wzp0ta6zAW5qRbrAmX2XBngCMrkRJw+Fgw1H4VdZW/5anSv/kthFDpROUeskAYkhSx2SYc1/7/Ttx6OVX+27CUolWQjpS02HsifhtcJnwoC8+rURxsogkGJspyTTaoRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRsb0rDOjUnnotUxINarqaONUDLAZ7dH4lsoxE4yLVQ=;
 b=3BOczQ83vVuTMyiXATb2NGVHTen1EqLCSgNkAQEaQLJo5RF2XbTPk+cGlwXanxKSSr8NTI0lNUFns7xJlqfOJ3pbZUN/gHtB6oh7Vghw9uzKBTts4ScDYpRVFfLuuBY7I8smizaEUkST4FkqK0W0OdsCqa/2UvcYLdhsHhK40Zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.26; Wed, 13 Mar 2024 16:04:15 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d%2]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 16:04:15 +0000
Message-ID: <6c1ac571-b758-4168-a992-3704c60dba61@amd.com>
Date: Wed, 13 Mar 2024 21:34:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
To: Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
 frederic@kernel.org, josh@joshtriplett.org, boqun.feng@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 neeraj.upadhyay@kernel.org
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
 <aa221e99-bf08-4d36-aef1-07ffc5e71516@joelfernandes.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <aa221e99-bf08-4d36-aef1-07ffc5e71516@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: afbbbf0b-6ad5-4d42-3d9d-08dc43773b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B0pqLa4ljEID9mfSOoFFw89lFdurkaRh1J3NobQdbS71ALieFuPhpzfDMzov1cw0Tpa/PuMD2pa0STC5WBxyVVYX+dW73qaRC2iZeTlQh5uPIcH8ngRa24Efaw2DxJfd7+6fGzLQ9ogo0TVGfFPSAJU6Ovnh9dNrc7sHlNngMb1hjRJnv5y1E9biXvfGT0Qov7YfJJrOxLXbIqTlE8A+nB2SPPe10CXGxEKbv31Rlya94NRRvDMCYSPe0LUhYNA9dQImD/l4tpz7//Y84wsH+ZM+EaMxi1UF5s1Fa7nPUfFywe4McNC8FDsjQ/e8lrJJn/8s++RmeKXjr5uUwbf2dV4kg3YvSKpZVSXmj4DRWmRgrWFcJpzY8Xzn7YDagHET98t7rCwnsF3frbkhQrWT97vz7vbCBDxZHgnf165JL76cNLkEyKyx0ZkJpQvO3V+sz9sHn0067+F9fXKpMgDNuvlE/PJjT6A15VZwOe5HM1mMA9nn0XdQ5qkTHYa/DgfdNUfh3eZhOAy7YgzgGQDApgoGE0EZDJOT1LyiWZOrF0FzKQWATJcW5xtZ9ZoO3Wy8ikO6yf80NgsDvDgRQ0SWAxuhRkEmcCnHQrAroiBsBe0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1lqVkFINFBYUVc2eXhsWVpUSElWc1hQdUV2Wk5rQ3ViY0lLQUlHejFmVlox?=
 =?utf-8?B?VTdHT1M3QjFmM1FFQ1o0OTZuZmhWL0txS2FVdFl1R0hJbEY1YXB5NkwvbHVZ?=
 =?utf-8?B?c3N2UUFxVW56eHZHbW9xcVIxb1FXeGxiV3crU2QwMmN6UEdGSmxyaVQ5Tkta?=
 =?utf-8?B?U1pteGYzck53VUw0M3hpT3NNSDdXc1NKZFBsaTdiUEtFd0E4NU1uNnZScVdn?=
 =?utf-8?B?R1BVdFlYaG9DOGhPRTJjQStlTWhsK2paV2thRzVIM1ozckJ2TG1vNy9odmZJ?=
 =?utf-8?B?bFpPQlJWUGpZYm9kOTExdm9VTVBrWTQ3MlJFSGo2VWpiMm5WQURXVERZYk5m?=
 =?utf-8?B?eUVTMVMrTU5oVHpqcHl6SjIyRERuU3NPQ2JVMllTcUxBR1BVcEhtMURnaXBY?=
 =?utf-8?B?aVFLTXkxY0hUNWJyVHJUK1hhdVU3YWJ5UzBrZHVuUlB1Ny9aYzNmNmRwcHpF?=
 =?utf-8?B?bVhoWkphTDdPeVFoUytKeTZVY2taOFdQb0Y4ZUUxM1c0cFFITlhFdHIyaXBk?=
 =?utf-8?B?UmtMSXpDK2h1ZUF5WmFYbWNSYVNQbHFDRnBBR2l5N1JpdS9vamJtMlpUcGRv?=
 =?utf-8?B?ZWFHb1luVyswd2IrTEdsSXNwNll5Q2RGRTFJVTFXd2c1TUZCRFl2NEk1K2RQ?=
 =?utf-8?B?L3k0d1crZE9aS21mWm9PMGUxUGFHYko3ZlQzQnA5RTlYTVh0SmVDVktUTlpa?=
 =?utf-8?B?ZzBFbmljU043Zk5qVmIydDROelRaNG5mMk9Vd3lLMmIzdTRaTmtrWXlBcXBW?=
 =?utf-8?B?QzRoaFkzaWRXVk5JS0dUbjBYWmorRVhwdUtIZk9Vd09YUXJic2RvVVZKQ2Za?=
 =?utf-8?B?S2dRbVZ3TDlNOUZlZTJoV2ZESCtuOEQ4OFRTdE9NbU1HZ2RDak1NZFhaYmpL?=
 =?utf-8?B?Qkwra2owbXV1QVgwN3laMDAvUjVtanluM05HVnZBK1lZY0JkS0k3RlRCOGVL?=
 =?utf-8?B?N0JIZitmdGk5eUs1NWJkbXFyNUkwaWEzY2xsTE5XS2pkeWtDbU96eHkyRkky?=
 =?utf-8?B?RFpCMzhkOW1MR2RoemJiVnFvYjM0YXduZndxNnpJMmN3MStsdUp2eGJmNlZz?=
 =?utf-8?B?dkx1TjI4czBVSDE3dHpwRWl3YjF1YXUxZ0t5aGdlWGtsNlJQNlJua2ltU0p6?=
 =?utf-8?B?Qk9NV1IrTFBudXNaN1hjTi9TWjMxSnhlS2pMbHcvOW5JM0NzWmNGUWM4bFM3?=
 =?utf-8?B?bCtDNUFVZWZidU5hNDhJVTVTa3VWcU1WZTlnQ0dCYXFnbitrMXExV2VOUWJq?=
 =?utf-8?B?cVV3UGVjRk41Q1BhRXBJUTJVTVFMZGpSb1pUMnZmOE5lNnBxK3lGOFZsOUZW?=
 =?utf-8?B?eGFQZjdvekdLaHVKRzQ0dGpWUDd3aSt5NzZ6ZTRPN0NnMTNscmIrSmx4WitI?=
 =?utf-8?B?MDBFdVlCV1RYcWRSL3lxR3NFMlZ1MVRCMmg0R2dScEhBL3RNQlBVUHA2RjdO?=
 =?utf-8?B?dVFBK3B3M3pIZXdtdG0waWp6ZTNlY0RoWXd6ZTE3cjQzVmhhRlpHbnVmRlIv?=
 =?utf-8?B?WDdzYTMwYnRNSFh2VVZhaHVjN09lYlN1UTdWRDdJL25UcTJwMllFWlpuclpB?=
 =?utf-8?B?OW84b3VRcUZkb2NBUHBzRHFPMi84L0RFM1Vsd2l1a2tsRFlwVS9VOTY4d3B3?=
 =?utf-8?B?VVRCSWR4dFBVNWcvMzQxMTl3dlFTZ1RYK2F6czdwbXcrREZ3SWlJZUU4d3VS?=
 =?utf-8?B?NDJzUDN2TlZicVMrVHVyanJ3cTcvVXZybXRFMnc3c3FSK3VjZ3Y4TlRGaGFK?=
 =?utf-8?B?N1d0RDdqa2RGVzB5eUVMR0NualNUNFFFRk1INFhJTjF3YXk1dEsxbzFKZHoy?=
 =?utf-8?B?alVFQWRNR1RsdW5zZlNScFo4Mlc3SmlqNXFXbkN4cStnSTVQUVhFSFNiSkRJ?=
 =?utf-8?B?WWRKYzdFYmlNd0hsRWptQ2lsUC9BTUhmRDVsa2lGb21wOXNITlc0cVJMVUxG?=
 =?utf-8?B?eDIyV01IL2MrdXJKN210aFVJQnJocHloT0J6MzQ4cDR4bGdBVGFWMDI1bnNM?=
 =?utf-8?B?ZFBXNXIxVXlaTjhSeS9Temw4K1dEVFFieDI5UTB0MFJybVZFQkxWN1lBbCtH?=
 =?utf-8?B?bDdzUnNzaW9GVGRVeHI5ckN4MC9kQnV2WmVKVlF4RjdqR0xpaVpGZ0hFRm9j?=
 =?utf-8?Q?J/oITAPKUgKCMuEs2t8GUvDr8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbbbf0b-6ad5-4d42-3d9d-08dc43773b06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 16:04:15.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+IXOpW0Jb/BjDdSCPUtb/zSUfu4uLtXyV2JI/H2PDdUxFDpZig4YE9osCNzfU9biqaUpXa6eQ37AjuQFlP36g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677

Hi Joel,

On 3/13/2024 8:10 PM, Joel Fernandes wrote:
> Hi Neeraj,
> 
> On 3/13/2024 4:32 AM, Neeraj Upadhyay wrote:
>> When all wait heads are in use, which can happen when
>> rcu_sr_normal_gp_cleanup_work()'s callback processing
>> is slow, any new synchronize_rcu() user's rcu_synchronize
>> node's processing is deferred to future GP periods. This
>> can result in long list of synchronize_rcu() invocations
>> waiting for full grace period processing, which can delay
>> freeing of memory. Mitigate this problem by using first
>> node in the list as wait tail when all wait heads are in use.
>> While methods to speed up callback processing would be needed
>> to recover from this situation, allowing new nodes to complete
>> their grace period can help prevent delays due to a fixed
>> number of wait head nodes.
>>
>> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>> ---
>>  kernel/rcu/tree.c | 27 +++++++++++++--------------
>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 9fbb5ab57c84..bdccce1ed62f 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>>   * for this new grace period. Given that there are a fixed
>>   * number of wait nodes, if all wait nodes are in use
>>   * (which can happen when kworker callback processing
>> - * is delayed) and additional grace period is requested.
>> - * This means, a system is slow in processing callbacks.
>> - *
>> - * TODO: If a slow processing is detected, a first node
>> - * in the llist should be used as a wait-tail for this
>> - * grace period, therefore users which should wait due
>> - * to a slow process are handled by _this_ grace period
>> - * and not next.
>> + * is delayed), first node in the llist is used as wait
>> + * tail for this grace period. This means, the first node
>> + * has to go through additional grace periods before it is
>> + * part of the wait callbacks. This should be ok, as
>> + * the system is slow in processing callbacks anyway.
>>   *
>>   * Below is an illustration of how the done and wait
>>   * tail pointers move from one set of rcu_synchronize nodes
>> @@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
>>  		return start_new_poll;
>>  
>>  	wait_head = rcu_sr_get_wait_head();
>> -	if (!wait_head) {
>> -		// Kick another GP to retry.
>> +	if (wait_head) {
>> +		/* Inject a wait-dummy-node. */
>> +		llist_add(wait_head, &rcu_state.srs_next);
>> +	} else {
>> +		// Kick another GP for first node.
>>  		start_new_poll = true;
>> -		return start_new_poll;
>> +		if (first == rcu_state.srs_done_tail)
> 
> small nit:
> Does done_tail access here need smp_load_acquire() or READ_ONCE() to match the
> other users?
> 

As srs_done_tail is only updated in RCU GP thread context, I think it is not required.
Please correct me if I am wrong here.

> Also if you don't mind could you please rebase your patch on top of mine [1] ? I
> think it will otherwise trigger this warning in my patch:

Sure!


Thanks
Neeraj

> 
> WARN_ON_ONCE(!rcu);
> 
> Because I always assume there to be at least 2 wait heads at clean up time.
> 
> [1] https://lore.kernel.org/all/20240308224439.281349-1-joel@joelfernandes.org/
> 
> Thanks!
> 
>  - Joel
> 
> 
>> +			return start_new_poll;
>> +		wait_head = first;
>>  	}
>>  
>> -	/* Inject a wait-dummy-node. */
>> -	llist_add(wait_head, &rcu_state.srs_next);
>> -
>>  	/*
>>  	 * A waiting list of rcu_synchronize nodes should be empty on
>>  	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),

