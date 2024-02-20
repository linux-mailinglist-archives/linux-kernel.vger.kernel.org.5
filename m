Return-Path: <linux-kernel+bounces-72576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F9785B56D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33C9281CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA1E5D8EB;
	Tue, 20 Feb 2024 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="5Bb00git"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2104.outbound.protection.outlook.com [40.107.101.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B125D486;
	Tue, 20 Feb 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418256; cv=fail; b=dqoASALBS6OthZEKy1NCEu8U/Oreaueg/pxnG669cSWzVtJr7U+U2dzJp+xHDjL9Nps9Ng6KlJfIeo2kiw7l6iIaoRZvXrdUYHW/wTx9PcWffZCxEyoar5mSPEl5iXBBUsUx+jUKEJJleahKAQ3a7StHXGxMe7HFENlbsPgcipQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418256; c=relaxed/simple;
	bh=HOO57Gzu61/FAkjjB5M1Sf2CRzGCCMM4uBcr8gsCFXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oou3eAEz4cHd+wz3wFfwpUpdf4GnANWty73l7nmBGEkKS6UyJNn4A67qHfBLgxuIWZYuuXc4g4nAMHXgntOfda4HiUPa0LFHTPh/jZ3w3s5aYCbqsPWSX6alhvuJUdyL5AEsamHwlcDm3kCOXTm/BfvjNQMwKD2wzlktV1WJ1Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=5Bb00git reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.101.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVEvSBa8qiDj9ski9eQcgYWBheO+ltErQTWc8huW/xXPxrF9KDnxLjti6BVAiq/+ggwosCPcCH+TF8EnvGYw6EHzwjJ/CGcb9Wr1v5OqEqvbNIpXkA47ihVJ0x3htzfd1IdnVUzi3q/IjG5rTTNGofzn5w1G1g0pSLiYeO0HyT0UpJLofdAsol0dvtPld+4ngi6+0lA9tRXKwsnLCsEha7jqiddlh7nJEa9CWFZZug92iOxMiHzxUWS/ESBR/CF7XC2gnbAInEOpITsBrJdaweoG4YeDZckcgVsu+BoSE5t6/IfwhZGZUZIicDyFfFR0Yul5+632E3z1hCQ5BlLfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEG25FcoNrcfvRfxmMd0yKJAqmwtq7AU1GJN2x7KD5Q=;
 b=lT80xg6I4SIZKKCKU0/u4+VRDkFeurW8oRrwI/Jsi3uP1EA9pwmfj1PRK7M2vb9ihbT5a39Om0hlu4zSJ0sopnHmgH6TuX4dYzcmAMLQmwOOgrnQf7u4JMKuj/2Tdn1M6/JesU6/nRYG/xNwchphomvqUaCvJt13eTolzUt7m3I2hh+XAjG6VPPMZW/KAVzGfRGkyGViFrDBcYsQtpprkZH4shZ9p6TOwBXyKsDeO/YTQVpHBQ+2pbbaoVsBVeTr+muUkyxV0vRrd9pPG64EgSWHmG3LpECZZpLI7u4S+/XAv9GkdBJ9949CjXy3DYrgG+AzYKqKwSUD/MCSbQncTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEG25FcoNrcfvRfxmMd0yKJAqmwtq7AU1GJN2x7KD5Q=;
 b=5Bb00gitDYXQ9Ca6zF9udPBg7P7bdKIu5rEqz8PtXedSmE402Gs8rbNWGidVABxrXq5eaJRpEI3rO87T9It3YMzZ6xofdttln21Txj6+BxUzWlRBNZw2Ey1nIGkfmVCCBxv1Yh7dxeYGofNzDcBbuh7xJPdu5kP86I7PD7x7JvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CH0PR01MB6905.prod.exchangelabs.com (2603:10b6:610:102::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.38; Tue, 20 Feb 2024 08:37:28 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7292.029; Tue, 20 Feb 2024 08:37:28 +0000
Message-ID: <c2bd73b6-b21f-4ad8-a176-eec677bc6cf3@amperemail.onmicrosoft.com>
Date: Tue, 20 Feb 2024 16:37:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
To: Eric Dumazet <edumazet@google.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org,
 patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org,
 ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com,
 aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, cl@os.amperecomputing.com
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
 <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <bea860f8-a196-4dff-a655-4da920e2ebfa@amperemail.onmicrosoft.com>
 <CANn89i+1uMAL_025rNc3C1Ut-E5S8Nat6KhKEzcFeC1xxcFWaA@mail.gmail.com>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <CANn89i+1uMAL_025rNc3C1Ut-E5S8Nat6KhKEzcFeC1xxcFWaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::17) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CH0PR01MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e25453-0f5a-4658-af1f-08dc31ef2be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4yR5meek4TdIZcpnJMSC+lcEd/mJi/N//ytHjG/V+TFPgSe4/jk90CeAqXdACuE6tmDEMUhP1Erm/Y09FGrH0UxmbIxen+An0BUKTf36m5PmNa2+rWQgB60Hmdb5h32t4PALr0AH/awR8oLWyupNFQGzJdRYWpaaVQORygEDvO+IEnsW3LzqiK8RhSzKiNF/gzbBJtJhcm4DeRyiVPKr6lZ4RwI5tpQFKlPF/qwPxJyIGYUOB+n622u6Xn9UEwmYTcGGSJtkkdjosD55uWYD9qwKloCVsy4m0C3qZSq/U+pMnDeq1peA0H74rJUjHEeluwVXDbg5hikFbe5aXdTcji3zy1bJcpW4m2bTAIfhvKzlba03BoLjiMz4ba1nCEooGWs/MNbn/iHnUbNP2k2RplEX0bJNidvwUVJlshjr9hk6U8P+FhXUnUuEabboUWDSFQQnDxTIL6G7o+mIg9Kq7YbLANBvwzb1qOyEFJMnbtoY6TRJqcSSrbaGe0G520zbGcfi/WMDYwRQjJ17sAQkiwR9YMMKAu3/5cawywM1qaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajJVOHoxTld4SXNkaGpsTm03a1lGS0dDVkxPdG5MZ0Qwdm9UWERJekpPNUhK?=
 =?utf-8?B?ODYxYUxDWDhtSDJXSVo5alFMdkpZc2prK25LVzFUMFN3Yi9Qd2tiakhUQ1kr?=
 =?utf-8?B?WkJJN0kwSkNUR0ZJMlFIS0ZPcFY0R05vbTFBRG5uNHI3S1lxVkF0eis2SGJV?=
 =?utf-8?B?UjlNRjFvMkUvUDI1UTVrRlFsOVJEK0oyN0VxL1JQSlJycGg0MGJOMWJGalo1?=
 =?utf-8?B?cUJaTFZwd2hzNVpvdXN2WTZLL2xYMU9RTldGaU1FSW1BcEFhNFV5ckhndHhk?=
 =?utf-8?B?OEdKdGNIWFB1WThmSmlZMnQ1R1hnaGJvOVFTVWtOYWtvSDY0NGRZOEVWVUg0?=
 =?utf-8?B?OEJONHowbGFiMzFVYzJrMkpNVUxxUFpHTEVnVUFCbU5ScmZSZmVXRkxHWXdI?=
 =?utf-8?B?R2JwSEkwcTZQcFFEalgzYVlIVXFmQWV4YnpSTjVXbmN1dXhKc1h5ZGRiSkoz?=
 =?utf-8?B?NG5zcURuM3p4aXo5elBiYWJ0M3JhNjNmbE5zcUxWeXBDY0lNR3VpN0hSd1Ux?=
 =?utf-8?B?TUMwOElGVWFERHorNXl6OW5ubk9SV3k4RkJlSjRHNW9FMUhUaHBENXZCeksw?=
 =?utf-8?B?MGc4bnNQRFdGc1V4Tko0a2hpK3MzcnJlM2dva2hNY0gyb3hyek8rUlVab3Uy?=
 =?utf-8?B?eWRCNUlqWjhsZG5ML0tLVDhPYk5aVHV5N0tzSzF1S20ybHdCRENqc2wrYzE5?=
 =?utf-8?B?bU9pWjRwNmNDalN2QytpNlBlUUZCRGdqRnE1UW52d1o5NFRmN0laMDFTU2Fs?=
 =?utf-8?B?QSszdy8yM3dkRFk3WHp3VnBIc1NVQU1ySit5YWM0RHdWOXUwdThiVzZIVnlz?=
 =?utf-8?B?U0VUQWk5MWxIV24vMkJ3SkNoT0NDc1dPTGtDTlpTWEdWczg1Uk91clF2Mmdi?=
 =?utf-8?B?LzBGc3NsS2lCbHRHSGdBWTBUR0F2Sjk0THZ0dVJoV3Exbm1QS1RuY2wyY2Iy?=
 =?utf-8?B?N1FFbWtNbDlGN0t5UkM2K1pzU0tiMUtGY2tINU1IUUU1bE12bUhTczFxbll3?=
 =?utf-8?B?QjdzY0NBQlQra1YxQTRiSU5DdkZGZnh3emVubXVxZXcyUmlINjZaMTJwVWxC?=
 =?utf-8?B?cjM0R2I2c1RIWjRNdVJRdmphUGFRSGNqNXRIKzUwYjFxVm01SmFvQWZTQlQz?=
 =?utf-8?B?eXdYMjkyZlRHUEJQcnBPK2Z3M3BYL3NWdmdiOUNsdk1KVXltTjNvV1p0bnZz?=
 =?utf-8?B?aXIyYVlBa3ErbDRpWkZ0L3hHVjEzak5BY0psYmY1MXlQR3R4bmtyTmgwVW1o?=
 =?utf-8?B?UVNtczNKM3FLanhYU00xR3RNdVJHNDVQc3dXSVpBUG9TWGNtajRpRm5ZdTl0?=
 =?utf-8?B?R0tOVnVNcUJnMFd3cEU0SXA3cVRCQUdUNTEzckRVK2hWRndySnQ3VzV1ZStz?=
 =?utf-8?B?OXRlVGh0RW54c1NsblRtSHNqSzB4enB0UzN6eGlVdHJlQURmK3lldG90aS80?=
 =?utf-8?B?TmJZY1poMU0zd3d2QWttWU0xaEw1cmU5VFRpQnQ4TnFnOG5KQWp0am00MGdo?=
 =?utf-8?B?NnIrcEJSeHdLSk1LWVBaajUybDRFcVNjWUhubk51UG9SMm90S21YQTVaWWpr?=
 =?utf-8?B?eXMxWUF6RkhRSFYzYmpuVnJ1MEVLWFVWbHdlbEMxeFl3WGxGMUxoaXU1TGQ0?=
 =?utf-8?B?QkdmNWNHYlpOOTlpV1ptdHNlT3ZiZ0VrT2tuSGZ1cC9yNHNnWHJRczF0Z2Jv?=
 =?utf-8?B?SGR0ZUZlVnhBT2FsQ3I2UTFGenU1NDhVcTBvU1d1Z1dsd2pLY0M1djRYZ0xE?=
 =?utf-8?B?THFuRHE5S210N1RrV3BNTE4yeDE0ZW4yb2xUNlhCT1U4VEowSlZDU0p1N043?=
 =?utf-8?B?T1JGTVFRQitoMVBBaEVqT3lTU1loUmIzb0MxNHhYUWNaLy9rZVhWSnczd1JH?=
 =?utf-8?B?K2duL2VuTFNWbGphanp4RVQ1RW52c05SdTBoM2ZvTkt5TmxIMGF3WmdsWDJS?=
 =?utf-8?B?dmtiMzJLZDgxTjY2eHppYlR0V3pROC92bzg0bnlsQXM0RUNBOEtNb2Z1QUNV?=
 =?utf-8?B?Y1hWWGFHUElQYnRjcEcxb2xUb2xGTzRUNUhlbTI4dGh4VHhVb1pwYXJ2UjVU?=
 =?utf-8?B?UUJ1Mmw2c3hIYTdzbG9iQlBHNUVxNk5TRkFzY0RUeSt4VkFTd0t6VUR5cVZ1?=
 =?utf-8?B?alJSeEdhZ0pQcFRjWHFLVGp0RXlvRERCR04zRWIyYllDS1dCUHRaTHNTejMr?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e25453-0f5a-4658-af1f-08dc31ef2be9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 08:37:28.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YwmD1l5N40Mer2iMLmpZ/lFsPWqaBpTNj5QMnn3QqdXsbTwF9wbZtKO3NuDFGYAbsGgjjXIpr1Nu6pk1sYcmYVpyjkQOxuCS+bGjE+mJVS0WAy8vp0FUc8vw7Dq0tv6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6905


在 2024/2/20 16:17, Eric Dumazet 写道:
> On Tue, Feb 20, 2024 at 7:26 AM Shijie Huang
> <shijie@amperemail.onmicrosoft.com> wrote:
>>
>> 在 2024/2/20 13:32, Eric Dumazet 写道:
>>> On Tue, Feb 20, 2024 at 3:18 AM Huang Shijie
>>> <shijie@os.amperecomputing.com> wrote:
>>>> The current code passes NUMA_NO_NODE to __alloc_skb(), we found
>>>> it may creates fclone SKB in remote NUMA node.
>>> This is intended (WAI)
>> Okay. thanks a lot.
>>
>> It seems I should fix the issue in other code, not the networking.
>>
>>> What about the NUMA policies of the current thread ?
>> We use "numactl -m 0" for memcached, the NUMA policy should allocate
>> fclone in
>>
>> node 0, but we can see many fclones were allocated in node 1.
>>
>> We have enough memory to allocate these fclones in node 0.
>>
>>> Has NUMA_NO_NODE behavior changed recently?
>> I guess not.
>>> What means : "it may creates" ? Please be more specific.
>> When we use the memcached for testing in NUMA, there are maybe 20% ~ 30%
>> fclones were allocated in
>>
>> remote NUMA node.
> Interesting, how was it measured exactly ?

I created a private patch to record the status for each fclone allocation.


> Are you using SLUB or SLAB ?

I think I use SLUB. (CONFIG_SLUB=y, 
CONFIG_SLAB_MERGE_DEFAULT=y,CONFIG_SLUB_CPU_PARTIAL=y)


Thanks

Huang Shijie


