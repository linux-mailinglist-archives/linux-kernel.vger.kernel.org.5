Return-Path: <linux-kernel+bounces-102313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72687B061
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7043C28A33C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190F213A87E;
	Wed, 13 Mar 2024 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bcg88Wdl"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E34CB55;
	Wed, 13 Mar 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352163; cv=fail; b=VY1CkhTgHDKh6X4SsJlpG483nsn2qDgFr7Dkb/2RH6wB63DEHmaJF7cbZpf1zMN6kDO46AMXPGd5qRaqfDbSmeKnPmGh6GWeShZksKXoQS9/W4tTA1qvCHeXBbnkYWr4vTJPsb+9BhWVmOXMCpPlbYntKh+oPZjm5ydPnd4IzRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352163; c=relaxed/simple;
	bh=XA4wLciyC9RERlAwptEbgE8krLFnT02BzmdsUAwsNPQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soauFlGWsjRoQdnGsDP0rC23kjskss7t8znNbZSJTLygclv+CtafZ4W8oVmi1ieRsBTWS0G3SKIxJopO8hUaeverR4UEcVHXtl7fY4IAxVMq9Rot3cx2c3ojy6vrNnh9Wr4RL9wIUhr1MBoYpnAZZ77BYY3PzIwqCr6DguSXJiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bcg88Wdl; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bth5FXGFXsWmMCT+/1HC7ZJt9PK1EEbwHTudUNajyo8jzA1JeN3iMRFTtSAWOC9qEBJYgApkyB/poLoyd2D9rGoxCCc3vxAfjB8Yq8YwrWplF2LFVo1EXpTGA4s2/TVBWHJkilKNESpuQs6ya5tphH3m1BxMaRoNHnmVf8qw9P1TV1ObWkHdTifXCTECNifKH+S0oxFin5V3Oh1YIDtxtq0LLJaSsBC+ALie6ryOxHyNMb2+fh90E5Okew/L5WWO/kSsy9xPLvWjNzdXoB25xTlt5/bgjiHX7UO7KgE75/us+sQ4R5P6qIVgRGCDO/dqcrBvnYjqqfXhQqNz+e1t9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNBTgal2B8YQLtMOfkRGSaJmytXLkCTNXAbSPH/Kuqw=;
 b=JoBZ2Xys5WPVUMzJePk4rpxFr/qmXkj0YNNXQfAm+40b4OOJLH4W+ojx9hssSUEa9jk+kJU/IP7C34xWlLq4kGZt0SRbBWMXhlGE1/H/xYqJeHQooLo9mcleZ0WCsAavfcm5ZvngexjyXu36SlZ+tQHEn32lRRfzHQXpLLRmh3PGsaWP31glpy+c3vh5n6inxcqXY2+n9zEphz+Pshoi5kWh4+PrMDbFLeKcyyrsHpCg+jVjYeSHg3nBTo9gqzJlvMa9SFIj1egJcU48opB67ncQN7Yqi/pLNqLyQggazC2m6jou4JbRZlstUg3UWxWuWF3WIEXXU1mORfJeBEVgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNBTgal2B8YQLtMOfkRGSaJmytXLkCTNXAbSPH/Kuqw=;
 b=Bcg88Wdllik1nf8EABQ0xQwM2zcpz8eQSZPJslnNR+M8vH+t6xnq4G+OyPHxNBbR2Zks90XIRbOQZ36tj0+Amuop5JJ6aznSyDowDuDwCUxOCHr828/zR1zYiyqQOWzmmJLWRek2i2KBx+G9wFNworZB+duI/8PA94TSgkQ0fEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 17:49:18 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d%2]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 17:49:18 +0000
Message-ID: <af5168ae-973a-46dc-8766-d1949cc82ec8@amd.com>
Date: Wed, 13 Mar 2024 23:19:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
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
 <3f544c35-365c-4782-8dd6-f523b257f867@amd.com>
In-Reply-To: <3f544c35-365c-4782-8dd6-f523b257f867@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::19) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecfcc66-f309-48d1-c676-08dc4385e7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+M0o/1BYWKN0BLbwBLSrxDFRN4Csht3plcewYxbkZiNDM9ySCzcP5FYHELVcdAEWEFgqtm51iMCuIScuc0fHtP+BIKx9hWXc+HWDbtRJKSvmuyuWLkXXcMpwUUy4QjQmpYMaf2A4jv4zmtaKbGqlvj1dR5U3KXFecCzQx/GTYBXAH6J/NtmQ9gIMRs/Y+OLzuB5XJPI1yy3WbgsnasEEqlTWI6gnuBzvCd2A9PXmZKgINK9kKgbPTtgv0JUHEFqsNEhHufjtmq6a1+ElOYBsquhToajn90eThBR9q/dzj/PPw6bS/Dlw6J6CRMDxMN5F2UVwW/Rw0l6Bqv+lL1/3eKCstJMNtc/xvtAv5+w8t76xKHZTZA4jEeABUisY50yLnifOZ0neW58xKKcBrRsYsOQMwURoJTzMX6JG24V1ojxx6JLJ4yS2N4Zc7GqrAt4asTHJj1zZFLUr5Arb/ViC+CyACSk18FRkIhY3n3X1ytY7xmtwKMdsH4TZywgSVHeJmm7/Wud042NFZpcOnQpR/+gsQF9ziHiX49Evw4yP3d3TcFl5ILDvBcbQgWH88bkHtvS1WdoO90l//zOZv1IaaIbKeBwEUQmt0biMf/Pp67RtUVPw8685gp1anf4PKCSHOB02tpPXSNDZ+KV1L/AtHbpcMrwNCIYUMNoCgxmXYs0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm9za2xqWlF1M2YzSGVaOE9JWjEraWplWTFuRDFkTnYyZ1Z6OExCV0NzTmRh?=
 =?utf-8?B?WlFYb2ZrMGFUT2FxOGRXdklwOEpLYVNId0k4aWJZK0xrN2hGQld0aW8vcllj?=
 =?utf-8?B?cFd0NDhEMTFqb0dVSk5YVHhpUDd1MjNKYUYvdUlTeU1YQThTL2xQTVM1MDBr?=
 =?utf-8?B?UFRmSWNvUlJPbEZ1SXczVjR2R2t3UzE0ZWpsRSsvRmx1enM3dFp5REM3eTRE?=
 =?utf-8?B?VEFVb29sMktPSUpKdjFLam1Nc29UZmRCeUdsMDE3elZETlNrOGVVVXBMWStC?=
 =?utf-8?B?SHA4Y1hxdS90NVVpUDVCNjlDN3dDZkR0cjlaQnNvVVljTUZOZml5dk13M1BC?=
 =?utf-8?B?ZkZKOVJoUmNMVG5wVzI2Q3hYbzlrSEp6d2kzREZPZGpwSVExS0w0c3IvUmtJ?=
 =?utf-8?B?dlpDYVFQYm1ndGtFSEptKzhmREx5bThtNy91M015dEdGWFVpNm55ampTaUxN?=
 =?utf-8?B?UWRBb1ZwUHJkbUlVb2JWT0dXRW1QZitaUS9YMHRpNHhwcDdRMjJOQnRXbkF5?=
 =?utf-8?B?NGx2RURCekxNUENqMFRIREVtQzNISEV3LzhxUGNHOG1LMDZOclpyaHJCaDRV?=
 =?utf-8?B?TTZidU00UXJsU2o2NnBta2NibUxrL2JMMHY3a3F5SFAzbkNINlZSREFUeVBO?=
 =?utf-8?B?cTAwVEtHOGI4NW1KU3JqWklMakg4QkdHYWNlUkNtUzJtOUV2UWM4WHpqdncy?=
 =?utf-8?B?Q01NT1hpNzgyZU5zQW1XTU5NY0ZrMGcwdFpKUFREblo5WHEzdW9IVWVCOUJo?=
 =?utf-8?B?T1UvTTV1Ri84Z084dHhGSVE4U2crSGxIdTNzWW95OXZXeUNZYmZLTDI5UUZW?=
 =?utf-8?B?czRERUw0L1pvenJzZnNOZFh6TWx0b29GZnlWSTkrVURmL1JjTGtwRFl5Rnd3?=
 =?utf-8?B?NzdFRVQvRlBnZ0M2OTliTkZxRi9qenRjZHpVVEtaTktEUzlYWFd0OENDWk9U?=
 =?utf-8?B?OHdKMTNPT0tnSG1FQ2E0QS9kYURRdy9oL0tvYmlHMkdwaXZVTGxiVlZJSHYx?=
 =?utf-8?B?TksxL0pkK3lsQWZEbWgxY2lKbnU4MGJRSmFSQWY5Z1p6YjU0WlZQNlJ3aXpm?=
 =?utf-8?B?ekU4WU9hNmU5ell0MDBPTGptcGtNb1hSc2hhM0VHZ3hkRWp0TDlGU25yY2h5?=
 =?utf-8?B?QjR2akFmR05NbFFqWnZWTFFtWko2SVJXam9xYnBNNGRuRVR6K1gwaytiUExq?=
 =?utf-8?B?c1cxTlRYNWJHaUxLdWdNL1krUFcwV3JQSGNOcEJxcCt0QkQrYzdyKzZxRjFL?=
 =?utf-8?B?QjlkZ09BVnllQmhvREw0K1F2bWlaZ3VOekllVDhhd3ArL1p5MXZuaEZpV3JV?=
 =?utf-8?B?dUlubXU4T0xNUDdDNGkwRTZ5U0J2WFY3Q21Vd1RWQ2dyQWI5MmVKc3U2MDZN?=
 =?utf-8?B?cGVUWlpUVHZUN1VMZnhTQjlnb1hYWWlUamZFb29JQnRZUFN6QXFFTk1OS2tG?=
 =?utf-8?B?NHp2aXhlVHhwcXk3UlkxeHc1TExMdWtaL09VREdqV0Roa3BxWFpWSm12RGFT?=
 =?utf-8?B?bmVVcjJWWWhYMjZ1cVRyeU5jNTZpQlg5a1BEUm9CanR2TGQxZDBwV3NUR3Y1?=
 =?utf-8?B?WjlaV0VqbVcya1hPSU1Fa3g1bXlBME5DMm01ZW9KMFdkRUVlWFhaQldQWUVp?=
 =?utf-8?B?bTlxODFiTmJzTnIzeHh4MS9Vb2oxTGJQdE00OUZlYkcvVVpDKzFRdnBqSDVk?=
 =?utf-8?B?dURtbXRwRzd3WVZaWElCcTRrYnpIVm1peUhaOWxqVlZnYXM4UkRDQ0dublQ4?=
 =?utf-8?B?ay8xdWE1OXQyaitXYmxNOFFwcFVKTCtBTDFERFdhRGtsYWRPanRzOGlaREsx?=
 =?utf-8?B?aHc4bTlkL1NWY1dCdElHOHBiaExHYURWUzU1RVBId3RNZTFtSmlvODZNc1Q5?=
 =?utf-8?B?ZW9HZnB1OU1DWWpacnhRZ0JuSGl2ZUw5S2xmbkQyeVJHYlpsQWZzM1dHbEMy?=
 =?utf-8?B?UjJ2YmpkTU4rb2xkRFhFZ0tMbGgxYzJ5cWxnR1d3S2c5ZlNKa3FIUXdXb1Nz?=
 =?utf-8?B?WVNXcEJsN1FTcFJCeHNiaGFDYlo0bllvcGFIQmIzRjNnc3N1REowZlZqazVi?=
 =?utf-8?B?ZzhVUlQ1UFhpb1h0MGVzaVdlbHlIaW9ZUjZyejBLdVEycjJReDYrbXU2VXZs?=
 =?utf-8?Q?Fw0IXhc3mgZoEITgA93jRCCYM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecfcc66-f309-48d1-c676-08dc4385e7e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:49:18.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7c6dx2Jphd3W5yCEV1edti1xebCb+tRU1gK33Gkrto1oNBJBIG1b/pNic/hUUL93IPorTspfVo+vAGR1oy46kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769



On 3/13/2024 10:56 PM, Neeraj Upadhyay wrote:
> 
> 
> On 3/13/2024 10:45 PM, Frederic Weisbecker wrote:
>> Le Wed, Mar 13, 2024 at 10:24:58PM +0530, Neeraj Upadhyay a écrit :
>>> Hi Frederic,
>>>
>>> On 3/13/2024 10:13 PM, Frederic Weisbecker wrote:
>>>> Le Wed, Mar 13, 2024 at 09:41:58PM +0530, Neeraj Upadhyay a écrit :
>>>>> Hi Frederic,
>>>>>
>>>>> On 3/13/2024 8:48 PM, Frederic Weisbecker wrote:
>>>>>> Le Wed, Mar 13, 2024 at 02:02:28PM +0530, Neeraj Upadhyay a écrit :
>>>>>>> When all wait heads are in use, which can happen when
>>>>>>> rcu_sr_normal_gp_cleanup_work()'s callback processing
>>>>>>> is slow, any new synchronize_rcu() user's rcu_synchronize
>>>>>>> node's processing is deferred to future GP periods. This
>>>>>>> can result in long list of synchronize_rcu() invocations
>>>>>>> waiting for full grace period processing, which can delay
>>>>>>> freeing of memory. Mitigate this problem by using first
>>>>>>> node in the list as wait tail when all wait heads are in use.
>>>>>>> While methods to speed up callback processing would be needed
>>>>>>> to recover from this situation, allowing new nodes to complete
>>>>>>> their grace period can help prevent delays due to a fixed
>>>>>>> number of wait head nodes.
>>>>>>>
>>>>>>> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>>>>>> ---
>>>>>>>  kernel/rcu/tree.c | 27 +++++++++++++--------------
>>>>>>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>>>>>>
>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>>> index 9fbb5ab57c84..bdccce1ed62f 100644
>>>>>>> --- a/kernel/rcu/tree.c
>>>>>>> +++ b/kernel/rcu/tree.c
>>>>>>> @@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>>>>>>>   * for this new grace period. Given that there are a fixed
>>>>>>>   * number of wait nodes, if all wait nodes are in use
>>>>>>>   * (which can happen when kworker callback processing
>>>>>>> - * is delayed) and additional grace period is requested.
>>>>>>> - * This means, a system is slow in processing callbacks.
>>>>>>> - *
>>>>>>> - * TODO: If a slow processing is detected, a first node
>>>>>>> - * in the llist should be used as a wait-tail for this
>>>>>>> - * grace period, therefore users which should wait due
>>>>>>> - * to a slow process are handled by _this_ grace period
>>>>>>> - * and not next.
>>>>>>> + * is delayed), first node in the llist is used as wait
>>>>>>> + * tail for this grace period. This means, the first node
>>>>>>> + * has to go through additional grace periods before it is
>>>>>>> + * part of the wait callbacks. This should be ok, as
>>>>>>> + * the system is slow in processing callbacks anyway.
>>>>>>>   *
>>>>>>>   * Below is an illustration of how the done and wait
>>>>>>>   * tail pointers move from one set of rcu_synchronize nodes
>>>>>>> @@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
>>>>>>>  		return start_new_poll;
>>>>>>>  
>>>>>>>  	wait_head = rcu_sr_get_wait_head();
>>>>>>> -	if (!wait_head) {
>>>>>>> -		// Kick another GP to retry.
>>>>>>> +	if (wait_head) {
>>>>>>> +		/* Inject a wait-dummy-node. */
>>>>>>> +		llist_add(wait_head, &rcu_state.srs_next);
>>>>>>> +	} else {
>>>>>>> +		// Kick another GP for first node.
>>>>>>>  		start_new_poll = true;
>>>>>>> -		return start_new_poll;
>>>>>>> +		if (first == rcu_state.srs_done_tail)
>>>>>>> +			return start_new_poll;
>>>>>>> +		wait_head = first;
>>>>>>
>>>>>> This means you're setting a non-wait-head as srs_wait_tail, right?
>>>>>> Doesn't it trigger the following warning in rcu_sr_normal_gp_cleanup():
>>>>>>
>>>>>> 	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
>>>>>>
>>>>>
>>>>> Oh I missed it. Will fix it, thanks!
>>>>>
>>>>>> Also there is a risk that this non-wait-head gets later assigned as
>>>>>> rcu_state.srs_done_tail. And then this pending sr may not be completed
>>>>>> until the next grace period calling rcu_sr_normal_gp_cleanup()? (Because
>>>>>> the work doesn't take care of rcu_state.srs_done_tail itself). And then
>>>>>> the delay can be arbitrary.
>>>>>>
>>>>>
>>>>> That is correct. Only the first node suffers from deferred GP.
>>>>> If there are large number of callbacks which got added after
>>>>> last available wait head was queued, all those callbacks (except one)
>>>>> can still have a GP assigned to them.
>>>>>
>>>>>> And the next grace period completing this sr (that non-wait-head set
>>>>>> as rcu_state.srs_done_tail) and thus allowing its caller to wipe it out
>>>>>> of its stack may race with the cleanup work dereferencing it?
>>>>>>
>>>>>
>>>>> This sr can only be completed when done tail moves to new node. Till
>>>>> then, it gets deferred continuously. So, we won't be entering into
>>>>> the situation where the sr processing is complete while done tail is pointing
>>>>> to it. Please correct me if I am missing something here.
>>>>
>>>> Ok I'm confused as usual. Let's take a practical case. Is the following
>>>> sequence possible?
>>>>
>>>> 1) wait_tail = NULL
>>>>    done_tail = WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
>>>>
>>>> Initial layout
>>>>
>>>> 2) wait_tail = SR5 -> WH4...
>>>>    done_tail = WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
>>>>
>>>> New GP
>>>>
>>>> 3) wait_tail = NULL
>>>>    done_tail = SR5->WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
>>>>
>>>> GP completes, normal cleanup
>>>>
>>>> 3) wait_tail = SR6->SR5...
>>>>    done_tail = SR5->WH4->SR4->WH3->SR2->WH2->SR1->WH1->SR1...
>>>>
>>>> New GP
>>>>
>>>> 4) GP completes and SR5 is completed by rcu_sr_normal_gp_cleanup(). So
>>>>    the caller releases it from the stack. But before rcu_sr_normal_gp_cleanup()
>>>>    overwrites done_tail to SR6->WH4->SR4.... , the workqueue manages to run
>>>>    and concurrently dereferences SR5.
>>>>
>>>> But I bet I'm missing something obvious in the middle, preventing that...
>>>
>>> Your analysis looks correct to me. Maybe, one way to fix this can be that
>>> rcu_sr_normal_gp_cleanup() stops processing nodes in its context,
>>> when it reaches done tail and done tail is not a wait head. I will
>>> think more on this, thanks!
>>
>> That alone is probably not enough. In the end you may end up with a real
>> pending sr stuck as done tail without completion, until one day a
>> new real queue comes up, preferably with a real wait head in order not
>> to get stuck with a new sr as done tail.
>>
> 
> But after point 4 in your sequence, rcu_sr_normal_gp_cleanup() would move
> the done tail to SR6 and queue a new work, which will process SR5,
> so, we will be able to progress real pending srs?
> 
> 

Missed one point. We will continue initiating new GP until first node cb
is processed, which can happen when a wait head becomes available.



Thanks
Neeraj

> Thanks
> Neeraj
> 
>>>
>>>
>>> Thanks
>>> Neeraj

