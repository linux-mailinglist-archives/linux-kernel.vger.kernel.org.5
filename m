Return-Path: <linux-kernel+bounces-147979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A08A7C19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A4C1F21BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6C6537EC;
	Wed, 17 Apr 2024 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aA4DwBbq"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B365524D4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334118; cv=fail; b=l1jwXAbHmEP1l5vAOpUybHnbXBBGw58NXJYzfqniBh6vEQclmmLQHqnvWy2yXZ9BZYCjFQBDyETwUeMnFTeIhhIZqggxuaIgH9zYfEmQ9rwuYqVpFNijzLQoQCW9N/LJx6EotHXZ1hiphq3kutF/HpMAg6+JijxKV64Q3QevGnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334118; c=relaxed/simple;
	bh=X+Pg2+gd+okkOt/VHEgiITV/qFIPsYa4ZnwQIhFW05s=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UOWLjb0keIR3JPtaewp+OusBqROYBLApZZ+f4kuBUHno3gxVps9gKOF59NlqPkWNnw7DdRsSM3Fxg5YC2Fw0Q7T4DXf5VxCzrdjGtFHTRVptumAB9ibjSDxv1zUDYwzva9tH2mOP9iaBpzUb3AX8jTiMTCUk44Fh90mxZaU7fkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aA4DwBbq; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVOSn3v7P63T7RxUVRvjtn7+8j0hndDcZtquv3CRTxL8p5vyDA9a92Kn/wR72lDGqCBem+ci4TrfmTVGu2WlUwCzAM5skyHgBFRbedCSVrYRRjX45o1WtJvFs0Jyvq7reM6+eEbnNM+E1GXx/DQi3yqUJa6HgSfNrwDpsByIIbm5swhy9+K0IZh1dO1vzLlozmTmWhp4dQ+bp3qkVF1W27aIoe/HaIjJhvwAR38W8NjqBoWli/6sH4DX4aYTPzvVUOb9BMZYPj7iX0XLf6/5w2kcmbpDFLlJWY4pevmv3TGnvpJJINoeUaG3Pnuzirhve9azm/uA3CUlWFBY+bmanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/6hAubT9yOm1ml7FjLbrEQ0kz9bbGN2y72q8rwZ4nI=;
 b=bkfK7jNq7ElBY3EXV6afE2uxBAHK8HrwuVBFqhMPebWwbNSLsOs3N/mxM8zEMP7zBQzIXu/A43Px+hx2CHlgOFsoV1s+SubUbiE7Y5jO4No8epPvTLm1+csgR3e1jFth0v4RpGgjWxt6ljg+DUf0BhnYyUA+xF5fBL6q/GDMwfAPqCfuDu5N1se+HpbhmQquHeLoOnKcSgEbN48ogG3U5n1ODv0DE2xdoeSEpeChxXzepb+WsSCuZJYhfheEC+7KR+Z6icTmHxoB+Vwcf1BDHo0JS3cz1RQp2S3Fa57EQVmfLQ94cokOYcVJTnzoJTmc5pBILD5YyWKxPwrkTXbYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/6hAubT9yOm1ml7FjLbrEQ0kz9bbGN2y72q8rwZ4nI=;
 b=aA4DwBbqCVltE6FIr0Ed9t6veREP0RBBUJzleWPU815zb01Ew6zen+jKJkn8+34+zOLSJCJBdoqRpQNIrwlpWZW8tiujYHQkhe8Sp5wDHpixNytX0dF30iTC1Q8Ru5ahdBI4QteM/NjaV3ENztexaPn6LfFEwKfx9ZfaLYb5m9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 06:08:33 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1%3]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 06:08:32 +0000
Message-ID: <79abd35f-1e15-3585-c5dd-1f2841896f4f@amd.com>
Date: Wed, 17 Apr 2024 11:38:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 1/1] sched/eevdf: Skip eligibility check for current
 entity during wakeup preemption
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Youssef Esmat <youssefesmat@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Tobias Huschle <huschle@linux.ibm.com>,
 Luis Machado <luis.machado@arm.com>, Chen Yu <yu.c.chen@intel.com>,
 Abel Wu <wuyun.abel@bytedance.com>, Tianchen Ding
 <dtcccc@linux.alibaba.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20240325060226.1540-1-kprateek.nayak@amd.com>
 <20240325060226.1540-2-kprateek.nayak@amd.com>
 <CA+q576OCK24VSp+s4OLD2ogO48i95y39_JO=zV=TwHSEg3_b1w@mail.gmail.com>
 <f59c92ff-259b-5b89-9af5-fcaefccd4b23@amd.com>
In-Reply-To: <f59c92ff-259b-5b89-9af5-fcaefccd4b23@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::11) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6842ba69-bdfb-4c91-fa4c-08dc5ea4cecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JUv+nnOnnPfE/F+4ydekgbK0B0CZgKrU6Sg3L+lIW1QyJlGA77W+5qyv7+TJRmlf7N9JgMN1LdQwFy4Sunq9E5p897v9DeIqaRxyaNzW25PPa08IJ2i4qKZT+G04x0Y8tC19Klfr21DTsHgcQOJ/5Ls5xQRcIU/ny2MQw60ACxakTlm0mz+kRDEJc1aSnChsmw+5LKxBg0zRaCQlzOGlWTm73nCYPI6wKCZkTEZOuWwdw6DMQWHPtx+Jc/xPG+vulXxQIH6ALqwr8PuW1mOg8nT+TmSUHbY8LQO9se6rBE4waUqZidH93CfxqeT+FwjzTyA2I1mmt0nN7nJDTSwzVVA8cqBMnuPLfEDNjklWgN7Zo6x0ixZo22VIVldJe6h4gLmw2ExuMPmXSXcKIqVpdW7boaj80FdaAhIVftwMggBdFeFsec1MGlX5j2ifCaE2/s8KfKfvIGg0gKru0x9zQcukiFt1L7IAdxq2gvavB41n38D1Fwlm+v7tC3vsa7fR4I7D65zvBx7y7yMxcoI1Z9kM1pXPQlFu17vsSGEV3QrbCQCZX+ZzaINOME1f79f6XHdW2l5i1ELrX3x0Wv0UA8OuXYFYVM6gCurrU3dCGdzTphvqibFoYB+7CJr6RDFcQaF0QQRNfsN2rzp+E4ibT+Y95QaJMTN5BtUXHlAWdsg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eENYNTlNaFVmOE85VUZiQTlkY0FGQkJ2c0JUN3E0TGlkYUpTc2lOMm14aDdX?=
 =?utf-8?B?RlpCY0h4bE1jQU9lZDlhaitiejEvTThYaml2ZFlWTHpQWm5xWXp2NHVCK3o5?=
 =?utf-8?B?ZnNQc0Q3RVVmcG1rZG92M1dGVDlOOWlCT1gyZldBV0kyYlV1bEdQL1JZM3l3?=
 =?utf-8?B?di9XdHdMd1dJTWN6K1pndnZUdmRydnBCZ0l6Rmd3aXBNZzlXcEtrRlhiaXZJ?=
 =?utf-8?B?NUlZUDJVcmhOazY3Q1FvTSsxY2NvSHp5ZUF1SGdjTkZMcnE2M2o2NjVtaWNG?=
 =?utf-8?B?OGVsWmt0STJiUGNzR1JCQUdmU2xLazlOdXhBSGVKcm5oUFY1SmJFNGlWRmpw?=
 =?utf-8?B?ditWOWdRcWY2UWYrd3A4TksrMFlFWi9lMHg0Q096cmVDSWt4WFFaTDdlNEpk?=
 =?utf-8?B?bjA1RFlWTVBSbnQrUVM2UVNhL2p5eDJjdFAvM1h3U3ozbWp6NEhLOTRIMTNo?=
 =?utf-8?B?ZWVHUWpwdjQ2TzAxVTFKc3BoYk5pUzdROUt3eFhOZ1ZKVUNPRUlmVmwwVVBE?=
 =?utf-8?B?UG4vbHFmdUlkd0VRWUt2a3lOU2RnTUpFQzhnVHdXazdwQklqYXpITFNDdGhv?=
 =?utf-8?B?Tk1KQWhnTDdvaVBuZ0U0cDJEdXJGNVBlMmlhVDF1SEdqb3p3SDl2SFlBQm9y?=
 =?utf-8?B?Ym8wTndicjFnUlM1b1phUVVvSkhBM0YwOEQvdFk3bm1oSVBYQ2JEOFRUUFNL?=
 =?utf-8?B?N0tYeWRPaDhEWUNEYldsaVpOOXEzT0hJcXZPYml2QitGM1g5cXBLRVI1YVdP?=
 =?utf-8?B?bGI2TlF5S09ULyswZkFwMXY3Z1ZiN3I5YmpaN3lETElIUTFRNUtYMDFEdUlY?=
 =?utf-8?B?SmQvc2R5dzN1RTRSNjV2OHpKY3A3ejJGQkY0MXZLbnlZcHh3Rlh1bVZKdjZy?=
 =?utf-8?B?Skt3Q0FZaXVxb2h6bXlFYnVGbHNyQTl4YVk2Mnc3em1qR1hWRlJKamVYbG9m?=
 =?utf-8?B?NThoTVlZTXg3cmNDYXNvUForVDh6RGk1Y3J0VTBIY0dwSEdGeUhraE5qeE5u?=
 =?utf-8?B?d1hHOHdoTUdkcUllNUg0VDROemNldUVnSUduN2FxRnN4SCtjUXN4aXpuamZr?=
 =?utf-8?B?VmNCc0Z3d3B4bmd6ZkRCNzZPMUIzM0h2V1dNZjU1MFg0Nk9qUjliSkVuV1BB?=
 =?utf-8?B?eXdLeDBHQzMzbS80NHU3aEZnSEhOVUk2RFIrK2NDUC9NT2J0UDBuL0tDcTdJ?=
 =?utf-8?B?MGo5MWlhRHFDcWMyR0xnTkZJRHkwNXpOZyttU1V3MlpoR1MwZy9xUXhsMXFV?=
 =?utf-8?B?bHVvK1BWUmtncTJJV1FQK2g2WkNpODJ0a2pkWFJjaGtRcEhZdFp0UHpMNG5Y?=
 =?utf-8?B?aGVqd0FyZHZZeDNZTU1la2NNbzV4WDZyVmpLYjBNSjFFajQvSGlmQlB5Zmlw?=
 =?utf-8?B?UFBLSHp1TEEwZnhRenkvUVAyTUx0Q1A1dmxQYjdhbjBQaVhXSzFRK0ozQjhG?=
 =?utf-8?B?NFlBUWJaakdRQkdPRU43Q2RPK2x2MW5EWjViSW8xcFY0SVI0TDVXeGVwSW5U?=
 =?utf-8?B?QmtSeTY5SjlKRFlzaVZIaE9qRjBZTFZJalc5RHFiR0ZSZ2x4TE81TGlzMEVD?=
 =?utf-8?B?NGEzaFY4SElRclRnNjMycWo5Tnc1NmZpeFZGYlZrSFJNSDhuYTViUlNZQW41?=
 =?utf-8?B?K2FMME93Zkx2TDg4dTl4alU1cDRVL0xzUUZpbWV3MG1TQ2FpQ1I5SmZ6aE1r?=
 =?utf-8?B?RWNFSWM2M1ltOGJYVHdrZ3VQZDk5MnZkeFE1WVhJTnZoYU00ZVlXMjF0OG83?=
 =?utf-8?B?WWp5NjdNZUNwQ294UDJQeWNBelpiemNrZVdrUFduLzR0MzVwaU1hZWhKVGZq?=
 =?utf-8?B?YVZHSWhVNUxqSVo3STVGQUl3L1ZpWko3d09memtueC90Z3JkRUFaSWIvSENW?=
 =?utf-8?B?SHN2N1BOTGxTRE1qU0FiQzUxUXpCckdEbXFpbk44dVZPbjdremgyaFJ0NHdv?=
 =?utf-8?B?amNYY3JpbktoQkIydzV5MlVZSHhudEFhdGhyOWhwWFZ6dG9UQ3dmUVI1NXgv?=
 =?utf-8?B?TFZOVEp0dDVNc1FidVlVZ0tmSWdzK2RRMWdadm1rVEJFUmp4UmUrUWcvajFU?=
 =?utf-8?B?dVA1d0dwc1Rtb3FDNjJmMzhtb2NySitoVXh2MlNjNzdqWjM2NGorZzk4Vi9B?=
 =?utf-8?Q?opYQ4upLO22ENHnCbM5E/me1v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6842ba69-bdfb-4c91-fa4c-08dc5ea4cecd
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 06:08:32.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ovSgm1kqjymEKRos7IsyjtYcQd34XcRf13kK0h4OWh9P1T10893mCtfBGs98gg48NfnJu2boI/QpMnJxrrgJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989

Hello Youssef,

On 3/26/2024 8:36 AM, K Prateek Nayak wrote:
>> [..snip..]
>>
>> Thanks for sharing this Prateek.
>> We actually noticed we could also gain performance by disabling
>> eligibility checks (but disable it on all paths).
>> The following are a few threads we had on the topic:
>>
>> Discussion around eligibility:
>> https://lore.kernel.org/lkml/CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com/
>> Some of our results:
>> https://lore.kernel.org/lkml/CA+q576Mov1jpdfZhPBoy_hiVh3xSWuJjXdP3nS4zfpqfOXtq7Q@mail.gmail.com/
>> Sched feature to disable eligibility:
>> https://lore.kernel.org/lkml/20231013030213.2472697-1-youssefesmat@chromium.org/
>>
> 
> Thank you for pointing me to the discussions. I'll give this a spin on
> my machine and report back what I see. Hope some of it will help during
> the OSPM discussion :)

Sorry about the delay but on a positive note, I do not see any
concerning regressions after dropping the eligibility criteria. I'll
leave the full results from my testing below.
	
o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode

o Kernels

tip:			tip:sched/core at commit 4475cd8bfd9b
			("sched/balancing: Simplify the sg_status
			bitmask and use separate ->overloaded and
			->overutilized flags")

eie: 			(everyone is eligible)
			tip + vruntime_eligible() and entity_eligible()
			always returns true.

o Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)         eie[pct imp](CV)
 1-groups     1.00 [ -0.00]( 1.94)     0.95 [  5.11]( 2.56)
 2-groups     1.00 [ -0.00]( 2.41)     0.97 [  2.80]( 1.52)
 4-groups     1.00 [ -0.00]( 1.16)     0.95 [  5.01]( 1.04)
 8-groups     1.00 [ -0.00]( 1.72)     0.96 [  4.37]( 1.01)
16-groups     1.00 [ -0.00]( 2.16)     0.94 [  5.88]( 2.30)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:    tip[pct imp](CV)         eie[pct imp](CV)
    1     1.00 [  0.00]( 0.69)     1.00 [  0.05]( 0.61)
    2     1.00 [  0.00]( 0.25)     1.00 [  0.06]( 0.51)
    4     1.00 [  0.00]( 1.04)     0.98 [ -1.69]( 1.21)
    8     1.00 [  0.00]( 0.72)     1.00 [ -0.13]( 0.56)
   16     1.00 [  0.00]( 2.40)     1.00 [  0.43]( 0.63)
   32     1.00 [  0.00]( 0.62)     0.98 [ -1.80]( 2.18)
   64     1.00 [  0.00]( 1.19)     0.98 [ -2.13]( 1.26)
  128     1.00 [  0.00]( 0.91)     1.00 [  0.37]( 0.50)
  256     1.00 [  0.00]( 0.52)     1.00 [ -0.11]( 0.21)
  512     1.00 [  0.00]( 0.36)     1.02 [  1.54]( 0.58)
 1024     1.00 [  0.00]( 0.26)     1.01 [  1.21]( 0.41)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)         eie[pct imp](CV)
 Copy     1.00 [  0.00]( 5.01)     1.01 [  1.27]( 4.63)
Scale     1.00 [  0.00]( 6.93)     1.03 [  2.66]( 5.20)
  Add     1.00 [  0.00]( 5.94)     1.03 [  3.41]( 4.99)
Triad     1.00 [  0.00]( 6.40)     0.95 [ -4.69]( 8.29)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)         eie[pct imp](CV)
 Copy     1.00 [  0.00]( 2.84)     1.00 [ -0.37]( 2.44)
Scale     1.00 [  0.00]( 5.26)     1.00 [  0.21]( 3.88)
  Add     1.00 [  0.00]( 4.98)     1.00 [  0.11]( 1.15)
Triad     1.00 [  0.00]( 1.60)     0.96 [ -3.72]( 5.26)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:         tip[pct imp](CV)         eie[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.90)     1.00 [ -0.09]( 0.16)
 2-clients     1.00 [  0.00]( 0.77)     0.99 [ -0.89]( 0.97)
 4-clients     1.00 [  0.00]( 0.63)     0.99 [ -1.03]( 1.53)
 8-clients     1.00 [  0.00]( 0.52)     0.99 [ -0.86]( 1.66)
16-clients     1.00 [  0.00]( 0.43)     0.99 [ -0.91]( 0.79)
32-clients     1.00 [  0.00]( 0.88)     0.98 [ -2.37]( 1.42)
64-clients     1.00 [  0.00]( 1.63)     0.96 [ -4.07]( 0.91)	*
128-clients    1.00 [  0.00]( 0.94)     1.00 [ -0.30]( 0.94)
256-clients    1.00 [  0.00]( 5.08)     0.95 [ -4.95]( 3.36)
512-clients    1.00 [  0.00](51.89)     0.99 [ -0.93](51.00)

* This seems to be the only point of regression with low CV. I'll
  rerun this and report back if I see a consistent dip but for the
  time being I'm not worried.


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: tip[pct imp](CV)         eie[pct imp](CV)
  1     1.00 [ -0.00](30.01)     0.97 [  3.12](14.32)
  2     1.00 [ -0.00](26.14)     1.23 [-22.58](13.48)
  4     1.00 [ -0.00](13.22)     1.00 [ -0.00]( 6.04)
  8     1.00 [ -0.00]( 6.23)     1.00 [ -0.00](13.09)
 16     1.00 [ -0.00]( 3.49)     1.02 [ -1.69]( 3.43)
 32     1.00 [ -0.00]( 2.20)     0.98 [  2.13]( 2.47)
 64     1.00 [ -0.00]( 7.17)     0.88 [ 12.50]( 3.18)
128     1.00 [ -0.00]( 2.79)     1.02 [ -2.46]( 8.29)
256     1.00 [ -0.00](13.02)     1.01 [ -1.34](37.58)
512     1.00 [ -0.00]( 4.27)     0.79 [ 21.49]( 2.41)


==================================================================
Test          : DeathStarBench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Pinning      scaling     tip                eie (pct imp)
 1CCD           1       1.00            1.15 (%diff: 15.68%)
 2CCD           2       1.00            0.99 (%diff: -1.12%)
 4CCD           4       1.00            1.11 (%diff: 11.65%)
 8CCD           8       1.00            1.05 (%diff:  4.98%)

--

> 
> [..snip..]
>  

I'll try to get data from more workloads, will update the thread with
when it arrives.

--
Thanks and Regards,
Prateek

