Return-Path: <linux-kernel+bounces-132322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40F5899306
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCB92890E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6ECFC19;
	Fri,  5 Apr 2024 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Ed13c+5"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2CA28EC;
	Fri,  5 Apr 2024 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712283319; cv=fail; b=Um70L+cYwzszhA1MRByZjtc8ogZZnFFbGMk0Kdh3/bgWpKImB9VkUZQXQjXs3hN3uukzJfoUgcoGNgZsw9I7kTUkauzZDHKgkXtvJ2HrNuLHsgsutAZSFUGziHUSUtiYHwmHTAFm901Kz19/5lMpQeX8lgcrZb2sgEARhY6Migk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712283319; c=relaxed/simple;
	bh=pQZnkxiayu9stpWG1LAI9qmH/NQC8sg4vkeb8gIkX4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jI4OOnof61UQP+J1sVk7ojen6RPMH1ROPNhvNKU8r/1Pp+9047Y24/3GgaVdjBjZHjYd91b5dQFzMILAHbKNi3nsoNYkzhKDeP17UmUjV9S1jP7s6C6TU37RXJpWqEpxLJcLPDcvGBbLhD7J2T2txpMN15AO8VxCZWN1PY0vkkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Ed13c+5; arc=fail smtp.client-ip=40.107.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxlhUNfx7FKAsiCZshMrJThaC+WTLRtv/j2UNjgB1Xs4toiJOZr5TlQar4joA2GSWybC7UGcj7pisXlXrk4qaSebnypdu7cJ/54VfYgMPI2vA2YIfxZIXGOy3ebTu0S7wFtT2PyNJ6xTBtXJfKCNdDD/I0CnVuRhJWQYEGf4sNAfn2x2oQGdW1r/uV5LhPKmPoud1ESJmUIMPE8WgyW4zgCRiwG27jbc/z7nqiI7vp5as8vMvwp7BJlYJfzWCZPSIY9zOXX2S880iVvhILoncYSDegGGR0nsJl7f9mL21Lf5ePdJoew6CS6K0LoVFgQx/qAeBR9AScoY60ygp4CF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ7RzYgDvhK2NTouNTsp50PZD2YMnRMMcsmKVnafSuk=;
 b=SEn0tmE732y4l+6wwcqKNaVggk33hvMEurGYMl/nEBlnavSPtmConLzBIsejJiVImFKxCTAbtuzDlMPOUC5Zz6NRBdlp0Rl4kD2BcmQBp+vudFg4+9VzTEYTCo5xvNvskfFdrrIj40oJxbJuGyIsdNTM2Q1bveex+JzrNoEuvOJJxw7IepXUb1jw/ejdVTJR3jTXOnc5EiF+kdXfGjdpLQE8783gJGMt1Cnoxy0NAWbUHNCVT0cW/KQPk9vCOpu/tBOk6jvB4KBWvLuVf0gv31oQ8ODzoLbxrINgCiDaaVSb1Ep9nd9kvBGxPQoi+DrcnBzpzLcj4tjYwp8r4OHm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ7RzYgDvhK2NTouNTsp50PZD2YMnRMMcsmKVnafSuk=;
 b=2Ed13c+53ABs5tBkfRzVCPqGCVGP8SnmLAe1in7jsVv1eZBeiwJzk15rlf2MF6Oa1YXtiswv0D40lYQowuHFbGaNgEAfaEPPGvL3aSYukmOgpmOJUANDXfowLoiN94YYUkOAl2W3YcLTKr+O3kdt+4fxQys9E4T7+F8xWwCoR0U=
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 5 Apr 2024 02:15:13 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::1cea:ca41:bbe9:c22d%2]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 02:15:12 +0000
Message-ID: <0fae21aa-d9a1-48d1-85e1-ad746edae361@amd.com>
Date: Fri, 5 Apr 2024 07:45:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() delays when all wait
 heads are in use
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, joel@joelfernandes.org, urezki@gmail.com,
 josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
References: <20240403105212.237354-1-Neeraj.Upadhyay@amd.com>
 <Zg8ezv2vzylVwg2q@pavilion.home>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <Zg8ezv2vzylVwg2q@pavilion.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|LV8PR12MB9136:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6YryI59CP+FElo+6nwIXpOdrxqiRZsS1qDErDU7EDHvMdviG0VPHnp6ZOxoG1hTPi7ncxOjU0YpfboGYylfOfpRt9fC1mAu6fblGNKJcdKwJNyP93nvVWE/+Z9gKLWgptLytnLgb7Cd9X2hcbUUAFqDKkjQTRzgwGsNZPNskZZ7Bx1aFO15wrFeQiXGaHlxlRb8QL+pJaGksTFnAiL8CpdBsLjlDAmJIgwZeUjBEqCZzPzaJRLkmQvTPjzMxIDSYvZA5i9oDtTCPM/MV8fmNg356ULajUzEt58Lm0PdhTwgvjZqInGtoOHD4Khd2FM469mw4SydUy79Gr2mRS1pC+CrQpZX74Q+BdIFMmtmr8F34Z9eTXlRmvaD/6YDhsJ2D8ELIY0AQxGFKZIOlHJIhe1cVwRVaH+sxm145i4vXTUt5PSSQOnBm+delHCtGZvCZDPazovr3E4FEwHDAIBX01gBloxxWhsFceytuEiFmYbbSli7zpdUjBN+fIQcodhffaOAlMA/n2D8ZhWsvU+6aEquDiZqrdtItdrVq1FKisg/EwJvfkZgzdVJgJb9njAnraSrDFmh0bCR3MeI4C42yXZhWXdIKnSgD6YUgvjZkn0NPUohH8iCSN8ARDgnUZ0g6fS/Kn6Hi9kn/ZFjfmZCI51cgSyS1V+OcG8udZvV5TLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUJuOUc0Vk50c3I1bThseGZWSDF1SnNnRXcwVXdIenVocHQyUGlkSVFwRDcv?=
 =?utf-8?B?YVp2T2ZoRE8rNGZoM25GUHpSY3l5WGNCUmdEcWpBcHRUQkxPb0hFeWRVazdF?=
 =?utf-8?B?VUFqTXlwUEg1eDh6NWJYTklLU3VlTEUrZHpTeWZwY1AzTTVJV2ZiYUkvTkxD?=
 =?utf-8?B?SDZyT1FadUhPdU9nbVJLcXpTeUM4SEsrbFdmRzQxOGdWL1pqS09VRGdVbzdV?=
 =?utf-8?B?dzY3Yit0bVBoTVdQb2U4anczdmFxOXlqY0JqYjNBZ1ZyL2lGZThGL1dYWThy?=
 =?utf-8?B?M0t6Ulh3T2RldTFORVd4eEVRNGd6K0xiSGtwS1pBTHFtd2pqdFBCTXFyV1NP?=
 =?utf-8?B?eXZkakszTG1BLzlXOEtBbTZzUFloaTJJZE5vbndIL1VhWm9xRHFPOEY3VEZt?=
 =?utf-8?B?eEpvbG54WEJkMkpCbitRY21CU1dvMTdpbTZTRjF1YTVBc3N5cnRCOExncVpr?=
 =?utf-8?B?c085dW80SzhpV0JDNUJtRU4wMmtaYXQ2dzcxWituRmN5OXhwNWhEUEJDRENw?=
 =?utf-8?B?MEZoOUpUSmZ5eHlldzhKeUZ4WXptUUMzT3A4NkxwUWY2UmVKdXhnUU5hQ0dk?=
 =?utf-8?B?eWNDSTNnUkgzbUNjRERTbVBlUWQra1N2Vm1rS3orVDF0Yk1EcUplMkU2YnBI?=
 =?utf-8?B?MnloSWJITVFsSFNYTEs0bHRCQzBrdUN5bjBZZGlqY09oQzlzT2pQa3A1VG8r?=
 =?utf-8?B?S1lSOTRhbEQ2eHdJNXp1ZWhqMzB6VmtpZVI3bFVGZ1dEU0MrQllUelpUdC9C?=
 =?utf-8?B?YmdJVWdKYVI2aVpjcFNtUk51VkVBTGFPaHVxR05NYXo5c0grdWUyNm5oTDR1?=
 =?utf-8?B?czZuNHdYSHZRRGhCQlp6ZDhoaXFWQ3dxa2FWUnY5ai9VUTFqZm1MQ0QyQi9z?=
 =?utf-8?B?SWVxSmt4SFpYTVpuT1R4TE1xTzRwaWd3ZURrS1B6MTI2ZGdtbjhRdlBSSU93?=
 =?utf-8?B?SzlxTWczUEFwS2Y3NnJHSElMbDR5d2ptSEVxcEsycXNHTVVJcDhETW1LUGNP?=
 =?utf-8?B?eFYyRytOMDhHQ1lSaUxtd3Z6UGJxRFRPV0VPMysrbno5MS9KLzFhaXVzY3Bm?=
 =?utf-8?B?dy9uSTEveUFETDlyT1owMVRwNzAySkl4bGVtOE9kck5KSFZwMk90d0h3aHlF?=
 =?utf-8?B?ZEVpd0hvNzFxN05aSEFxdTM2SldxeFlINzVoY0crQy9FYytKTjFoUzc1T0xR?=
 =?utf-8?B?RTJ5ZDZnbFJEcHhFMTgycTdLejBJUGE2bTdhbGk0WEE0SUpXdXlUMlNZQnAr?=
 =?utf-8?B?aWtXa1IvTVVlQ21PcTlsSXI2SU80VUVEZXdEQW8reEFSelNsb1JMUU14SU5u?=
 =?utf-8?B?Yk9Fdmd4aVp2RHVJOHpFV0lHelIrWWtBckVONUVQVGFSZHBSQ05rdytRdTBW?=
 =?utf-8?B?VW1vWVZsTVpKbGVuLzltVHJCZ090Zzk0SE9XYmQwTHlHQW9zTEJNTjVabUFk?=
 =?utf-8?B?T3FTQU1YRDRoamcydUhrR2U0eDQyc3ZwcDIxRzd3L0xvN0FFRXVTMDVZTE9w?=
 =?utf-8?B?N0dZcUNrTWFuWFN1NHRtTmNTOUxGWU1lOUxxNzNUcXBoZXlTelYrNHlmUFBy?=
 =?utf-8?B?OWxkYnpQSFRpNkpRV2sxVkE1c3NnR3ZBTUxUV0cvZi9YakhMYVFtODV6VnpC?=
 =?utf-8?B?ODRFQ0lJUUVuTU5qdzhDUW1BUVp3UnljbUN6eTdCU3hwckMwUTZwRGRCYmdt?=
 =?utf-8?B?bVlwZmF5ZFpVV0dnNnAvcTV1TWtPd3l6SUlZMi82TThNTm9lNFdLdzd5ZE9F?=
 =?utf-8?B?YWxJcHZxWjQvSldCTGIwSWhIaVN3STBJVW50QmF5TU0yYmpSci9uSlFGRGVT?=
 =?utf-8?B?ejR3Q2Q2YWhsWXRNZy9LZXVJUjJTQmxuZEYrZ3p6eHVaeVRMUjZOcFltWVd3?=
 =?utf-8?B?ck1ETzdSdWV3amVJdTdWVkVGSFN0VmtJRk1hT1RqTjNNSjAwVXBKTVVpdDRH?=
 =?utf-8?B?UFgrM3BvVTRXSjRFdGs5SFVPSGNXeE1BRE5yMnJKMnZCN2lIa1BHdnJreTlt?=
 =?utf-8?B?VlV1TE5EWmtrRS9kM2ErcE5EM1pweWFnVW1IZ1lIcnVOWXV5Z2RDdlF1Wit3?=
 =?utf-8?B?a0E2cWhXVzArTWxQVGQ4U1pTTjZUaG1TMW1ic2xzWkZJU2Z4V05HWi8wVTZr?=
 =?utf-8?Q?NzR5/NscSohTimCHe1GqrIpWB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6ea172-4d23-43f1-4933-08dc55163984
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 02:15:12.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMYTeRkyAwF+0FABgOd0Wozt2pSYvNwB0NsKiUJKgMqJQZC/G6PvB8AQWc0IDzAB3wNmBPnmXHknD6f5VHmXWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136



On 4/5/2024 3:12 AM, Frederic Weisbecker wrote:
> Le Wed, Apr 03, 2024 at 04:22:12PM +0530, Neeraj Upadhyay a écrit :
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
> 
> Looking at it again, I'm not sure if it's a good idea to
> optimize the thing that far. It's already a tricky state machine
> to review and the workqueue has SR_NORMAL_GP_WAIT_HEAD_MAX - 1 = 4
> grace periods worth of time to execute. Such a tense situation may
> happen of course but, should we really work around that?
> 
> I let you guys judge. In the meantime, I haven't found correctness

I agree that this adds more complexity for handling a scenario
which is not expected to happen often. Also, this does not help
much to recover from the situation, as most of the callbacks are still
blocked on kworker execution. Intent was to keep the patch ready, in
case we see fixed SR_NORMAL_GP_WAIT_HEAD_MAX  as a blocking factor.
It's fine from my side if we want to hold off this one. Uladzislau
what do you think?

> issues:
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 

Thanks!


- Neeraj

> Thanks.

