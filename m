Return-Path: <linux-kernel+bounces-101716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A646F87AAF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58446281B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD41481DE;
	Wed, 13 Mar 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2vgoljYY"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C03481C2;
	Wed, 13 Mar 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346335; cv=fail; b=mXOrdqdD87188SSuln6CG4G3UmsQM6+dFwhVGOFamQeUbCUY2NhKAnQyE578v3Qi2JlhXT7ai8dm3kgtSrJTNtb/1GtSADLuaMSyNPRweTyeSFqYb7f+ezgaLkoUlICIzvUpRVStGXmWJm3dvv82f/2KoX3bok0XL7FAEc74GBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346335; c=relaxed/simple;
	bh=sKCguQHUs09KUDZDeZNck88qw2BEZt55MnQKplntteE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UEZzud1crAf9hmETdduxsedukuGTzqhY7vTTmzPUpIKdpFuKQTee+F2ef16Nwqodi8sVT+QRg/q/CA4MD6JCVh+UywMm/DGvp0aK75QgMSJFFDCSx1lg5PlDQKCeplLi3dqtmlMzvY3RxcbHomTLMbw+GyI1EsXTHgU5QQfVUeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2vgoljYY; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9lRqlOfPDwf1HM7U0G7ctZg5vtO16R9o5cUIBdk9dfFWUXs2M8mWlMm01zvWr38e7zLenLhxvKXmY5Tti1HKE4/guac57llunnGhToeuolJ7sil70vsa4+gr8X/inr47U5SL8qfmtiHVvDBWonK6uVVywAAadP9H0qqaNuE0nxNkwfmDTq1rj7LhUkBBuz8rgt6LIO43Gn4C9pyFFLCMJpUT0yXzKx3Q9PX1eTUzi3mMAIcnIWSeIT/GoFnuX1dWvyCTkE4OZQT3TLo7BKcyozooQDxtI2wBnumg0gHQ6wiy7+q3J0KjSsDsUSUKed9nO+KMYjdwCPyxY57zFwbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IySCNzs8SImRkmD0HhRpqntHFFcS8EvomL8Zz9yzbCc=;
 b=Sz7H5geEdWpEf5Ictb4ENsMt183USIA3Q4GtZ/2Ije6AvnqTvy8td1JbfpoN+Xi2S1iM5Rl5JSV7Qx8o/8BloB3Vh5/0EptUFAv/r68idAtiBXkYaJwhuPXupJ4nmQwoUmhrn0QmV+hCbQ4AK4JWpmuvifQkX9g87hzNXkbfJ09j/1z+GXauQUHRecsIF8KnpRgBr8vIQ+SV/dNZOC6pbms/f0pYX+XAkI0211gBVZX4z1AF9teov7/kOlg27hSpU2g+TfFjsHzdkkWBWxEW2z95hc71P9uUSWK909hQMuEdReKcWR73xLKSlDUJooMEBYMjcdWh3phbY7AKEbX6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IySCNzs8SImRkmD0HhRpqntHFFcS8EvomL8Zz9yzbCc=;
 b=2vgoljYY6mVRYBDRPc24ICq/YkufbZs5GqLf432s/bJGB50WWqGjvdTeq/8ZfE8nXTAnO6H0kvDElF5bEdYXhs7CUBw0gmBidb2QZgegsMbyGjLVDCaAFp1Ba0XA/BBuoNxBPywyvKNZo0KWYnghpUe62FDaEHVy2w/c/A3GfbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Wed, 13 Mar
 2024 16:12:08 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d%2]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 16:12:08 +0000
Message-ID: <35e009c4-d52c-4b96-ba10-afa0be9dfd5e@amd.com>
Date: Wed, 13 Mar 2024 21:41:58 +0530
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
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <ZfHDwPkPHulJHrD0@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acafbd9-fcc8-4b0e-d223-08dc437854ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MN/L3S0VSfV0JK2h8FjOg9Pzxjg46xAlc+KCxoBvH6uRBJdhYSyir77iGpuI3O8Rh1fqkpX3S71dgAF4503ShHK0Si2F6AuwdPlVxiXMUWj7X0pOezX2r8V1DO0XuBANSrRfe7nOt2FClDn67XSnTEDGqHaNO5rwRDAbqIOuJ+22BMzUR/S8k5nIRTwUHNoeYo+QHLtpUyHG//r2bYOLy20Xe2Rw0lEXW2R7JQj6VJ+4ZXRtF38/lyM6SXDrlHDOQfjTlzHr+jzHDidPGx6X3xFNQshJ6cHF/HAqFVk1wPujU2v4Dqgr4tPXWBlqu9UL7ihi/pUc0wjHvQOHlAA9h18TdinuriSiw7W0y3bcfjkvnyroMpq5r6y9v363HHaDof/+1oBSNhALyQs9TeW7ex8cNBiIeZHObh838mZaM0wEUlfPPXWa2/OSahKX/QWJgiKkEp3W3zblhUquxzRtvu61+PJBAYTqWKimHX2p1gG9PWLhR8hMhFK4jnCcvOi2LXAYT3i9P3PALPXiyk3dyUtR0v3Ak31oP4yXo2ngw8siZm/vARTbSjZGwGTrrvN3w0+8yyluTPL7UpGTcovQOR25xxy6qWZM/Rfp8ebinbRjFoRLrbs51BOnmIzILakHxFBilYxnnE2QwN7+snI202r/GFL/+6Sq3TH2ceABw6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3E4TGJhOVJubW15R2RCemx6OGkrZXQwTkx0MUYza2VMTkF6VmVzTzY2V0Ry?=
 =?utf-8?B?SGJ5TDJuZDRNOUNvTVBQZ1NOSURxRSt0MUhTNmFXcXN0MU5mTzJJSnpuRk8r?=
 =?utf-8?B?Y3h5NG5WU1N2czZFam5ocVpYdlNWSG5iNHdjUUZ3U0NPQXBhL2tQL0pmS09t?=
 =?utf-8?B?WE1hT1JCQ2M2SlhqejRuZHJHYzR4TC9sK3FsYVVBc1c3LzdCOERJQWZmbGw2?=
 =?utf-8?B?VDFBeUNqT0RtZnlJQ3F1aWZGeGtBUmhvWS81NWd6UEE0T1BwR2pORmdyUWJs?=
 =?utf-8?B?LzVDZktXRk0zbERKbWhCdEMxZ2h2RWRGQWNHckhhSEtQNlNCNXJNMUNJcVFz?=
 =?utf-8?B?WVhDU2VoVHltRkdZeTdZTDFEaWxHWU85UlN4NTZGVmdIQ2NidmllMzB6OWFM?=
 =?utf-8?B?QTBaejdab3RmSFcwZ3NwWWxIamlHaU1MbHA5NGZPUWhwWHFhZDd1ZWI4TFAw?=
 =?utf-8?B?N0lLeUdzZlVKaGNBa3VlakNHKzhNRUQ3SWNXbFFvRE1nd2JBMTJHMi9hbWQr?=
 =?utf-8?B?TEdwSnlrSC9JdTh5K0UxZ0JVMHk5WHpvdVo1VjJJSFNiWmM1NGZFV1ZYNjhh?=
 =?utf-8?B?aTRPdWxmK2RoZXBIRUl3eDF3M3BHRElWYXE1YjgvRktWUnJwREJxbWJOUWNZ?=
 =?utf-8?B?K0VjdDBxZEJMNFR3UG1IbWlrV2lqUnp1TGNTWndPOStlRFBLTndYOTIxZUdt?=
 =?utf-8?B?OXdTK0IvYWowWXJqNzNDamtxWkJuY3daSi9CQUsrbGdsNWVZNjM0UTAxRlJl?=
 =?utf-8?B?djlnZ0prY0wwbUZvb1RUTUd3NXFKR2ozb0ZDejhYTnVRQXJrcGNsVzVJVmxG?=
 =?utf-8?B?K0h1RDNKSGFUK0o3aHkrWDh0WkE4WnhWRDFFeTBXS1BRSG9rZTZhRjFrbDFE?=
 =?utf-8?B?anJHeXowc0toWGlNdDFNdG1GOHl5bUlzckg4Y2lNZVJVVVhDRS91TXpvOHZZ?=
 =?utf-8?B?bjk4b2R1bHd1bWlna0FkK2ZCV3ZqQllINTZJd1VzZE9SSHBsVWRxVkc4Z0ZG?=
 =?utf-8?B?c2F3WmVVY1dVeGZEc0Ivcm5KMUNMSEkrZXhjd3lrdWRuTUdhSE1qaXM3N3Qy?=
 =?utf-8?B?RnRLYmIxMnJ5WXRESFhNVmV6dTdZM09pZHVGV29mMjJEcE9DMmlwMFNLMXJI?=
 =?utf-8?B?c1pJVWxtUE10cy9JckNpQ0dRUmFRU3Q1SCtoM0FPUURGakhQdU9vNC9wbzgw?=
 =?utf-8?B?dElDRGJiUEtvVUhwdXpXNE1EWXVzTDMwUUFOaVlMeWcrWTBKbVBHcXBPU1dp?=
 =?utf-8?B?cmdpUjd3MVJteUdlbStVY2tGMUZML2tEV2lqR2dsOFhaalBZOTZHZlROV1R2?=
 =?utf-8?B?K25pamVzWXE3TzhXdGM3aUpMb05ramNVcjVWUkN2N3ZndDlMUjlkZ0hnVFl1?=
 =?utf-8?B?M3VseUhBOGQyaU5aakN6dTNPdThCTytVWnFNR0hIbnk5bUpGeTRvbTQzNStH?=
 =?utf-8?B?Qitrd3lvcHpUdGoyM3ZHdEtQYjYvK2pRbUhSTmU3KzE3ZERoTWhKS3h6MGV6?=
 =?utf-8?B?YXVtNjFQcU1oRnJzVEtmVjkyUmFydVlvME5seGRzTHZuTzJ6NHRFcUNReDlC?=
 =?utf-8?B?Q0ErZUpVMXl6bkl3SFZ1WVFIQmxhSDRjWlI0UER1eVNCQ3MxekxYL1hQQzNS?=
 =?utf-8?B?QjdhYzZUanl2NHBlTXJpNUhBazI1VVBqR1lLQW50YUtPQ3p1YVJMeFdOa2I4?=
 =?utf-8?B?ZENUajBTb01iMkFrODBvU1h0WUZDcEVEdmRTdDBNZVFQQ2FzRDdoQzNsTVVN?=
 =?utf-8?B?SmYxS0JyelVwMUI0NkFKRXdTQllSbmNkUHp6WkhIS1ViUSs2VDZXTGt1cFB4?=
 =?utf-8?B?NlVvMU9GQVcwVFp5cXZ4bWM1NDg3VnRNL3B3QnNPWE1SNExuWDNuZXFwY1lq?=
 =?utf-8?B?dWQrNk5yVmdRem5IZFllOGlpSStpMXVMME1oWW12czZackR0b3IyRDFtNjhu?=
 =?utf-8?B?YzZESUhiTk5mcmxzYTRQRDB4RkdXUmhoUnVHMGxUbGd3REV5eTJaSjRHOFFs?=
 =?utf-8?B?SnVOYlNVbi9CQnFzTzU5Wk5Ya1FHVEJpZUtCRUxSMml6dHlYM1d5c3d6dGFE?=
 =?utf-8?B?Qi9BbzIyUERkOCtmSUpMRjNtYVhod0o3QzFiTk85TzRROUlDOWg0OWpubkhY?=
 =?utf-8?Q?kwp3+t6PsYjj/5NxtAeintLtg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acafbd9-fcc8-4b0e-d223-08dc437854ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 16:12:08.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6QjpBJesYeDMmjDiGp5bQ5Pf749GylyjwiOoOFoKw4ayCxR7UqDlJinjrzezALTqp+QPCaqltIriiIWZUClCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846

Hi Frederic,

On 3/13/2024 8:48 PM, Frederic Weisbecker wrote:
> Le Wed, Mar 13, 2024 at 02:02:28PM +0530, Neeraj Upadhyay a écrit :
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
>> +			return start_new_poll;
>> +		wait_head = first;
> 
> This means you're setting a non-wait-head as srs_wait_tail, right?
> Doesn't it trigger the following warning in rcu_sr_normal_gp_cleanup():
> 
> 	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
> 

Oh I missed it. Will fix it, thanks!

> Also there is a risk that this non-wait-head gets later assigned as
> rcu_state.srs_done_tail. And then this pending sr may not be completed
> until the next grace period calling rcu_sr_normal_gp_cleanup()? (Because
> the work doesn't take care of rcu_state.srs_done_tail itself). And then
> the delay can be arbitrary.
> 

That is correct. Only the first node suffers from deferred GP.
If there are large number of callbacks which got added after
last available wait head was queued, all those callbacks (except one)
can still have a GP assigned to them.

> And the next grace period completing this sr (that non-wait-head set
> as rcu_state.srs_done_tail) and thus allowing its caller to wipe it out
> of its stack may race with the cleanup work dereferencing it?
> 

This sr can only be completed when done tail moves to new node. Till
then, it gets deferred continuously. So, we won't be entering into
the situation where the sr processing is complete while done tail is pointing
to it. Please correct me if I am missing something here.




Thanks
Neeraj

> Thanks.
> 
> 
> 
>>  	}
>>  
>> -	/* Inject a wait-dummy-node. */
>> -	llist_add(wait_head, &rcu_state.srs_next);
>> -
>>  	/*
>>  	 * A waiting list of rcu_synchronize nodes should be empty on
>>  	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
>> -- 
>> 2.34.1
>>
>>

