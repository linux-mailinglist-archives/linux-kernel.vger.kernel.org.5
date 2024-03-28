Return-Path: <linux-kernel+bounces-122321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CF988F52A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB99029005F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985082562E;
	Thu, 28 Mar 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Srt+N8d5"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11022011.outbound.protection.outlook.com [52.101.51.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13218D;
	Thu, 28 Mar 2024 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591764; cv=fail; b=DputyY7ogXHmZ1B2B5BQLt5OVRr0gjlsCuJEMmlPcPW/QJCgcz6Zx3xsKMJUxg4YV6qVm1D81XkI6RRJozAQFpEo3D8UVy4zLuPfkWpU6bJJ3NJLrotI5pW8pwP3LzemxL74+uKGs4v5VRYzZ97cGa1TKuwkBG+bttG29LNALL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591764; c=relaxed/simple;
	bh=IECHZSw84LD68+BMuLOn3tYo+N7rCzAVX9B9tvFVRlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sm++L0LWJnnGH5F/3qfuXffEhZZzzYZ0S4UYQ188z6ElVJGmsGxvC2VvRQSTIp7pUbS7fvLkTaKDfm8yVz+QAS687bjgx78Fspo8/TIs9xpvtWjjv1DfISwJBrotebvYAx0H//TdzXiqHtKKIopHTqHvrtIKttnkjkWr2nmW+5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Srt+N8d5 reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.51.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz6k5wXCWBTka0aInD/jTs4WuBJT8qTTWXHu9HImY0Q9w+IHAUnzuPlSgW7bzdhuhUa+Q2N0UOaijxL9DawdbBftlgztZGSRMz5MalTIQ8yObTeNLTW1YkYlvTTeY9BJbq6KY4cTfeIFZrlXQ7V3aXfYEq/OUjajpWwTBSRQAWxM18NNltu3rQ8SJ0suaPY1EQ5ONhg5BdY1q4jw0LAk5Rvb/PWVnUW8lWetepYG4nfTikAF8Q16znSYTBIuGyxSX7O8t2v0OFX6WgyMyi0sYRto+ThEjDUNSPDAaaWMPQ06iwJ4IQbQRFmWiUqWqeZinp72ieuHNPt57DKu731Ovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIdUauLTFeCwbakpr4Q2dCGAc61J1SA9QaxWp88h4JQ=;
 b=UT3EakVWFU+jHYB5rzab+/VI+oA+cw0tPiIyAL+sgZxKo/bO97WOdRU8ilrBtceAAaUwyclcfPHDgICCZePMZnxLQbVDywU4q9P01qwZTwdsF+OlgCzZ+tS1jlYVXJDHQKG5+/Oj+X/UscMXhgjMla767Ag3f8tN8CWo3gj3ocnNjlAQ3loB6O4HqtZ00H/kvftKYBw6iQZ+NUCqwzRhrzHTLJzYqnB7qVvDHSnQQBto9I+sbglkGguhr1mk/N6Rcf55fdbXryzaBIVd0QrD3eEXPT/7faSk+EzAdaW+GHIQ6gn/g1GI6/Jd8fEbCJA26mMzeW77Pfr5phDXlDCTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIdUauLTFeCwbakpr4Q2dCGAc61J1SA9QaxWp88h4JQ=;
 b=Srt+N8d5vmweyREnoJzhieMiTsfHIMcLTCJbEQyXdVX4oH+/YFC7B48tqMOlSVIFguZgIRZnXuXhmot8U1+04qa4GqS/P8H+54VqFJ/Gfm4fyALO1055xwwB4LL1jf0mrrT/DfbghelqSlXYEahu74RC6ieNto3HYQ8CVrkYQZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DS0PR01MB7914.prod.exchangelabs.com (2603:10b6:8:14a::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Thu, 28 Mar 2024 02:09:17 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::c97e:78ae:2565:dae7]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::c97e:78ae:2565:dae7%7]) with mapi id 15.20.7409.026; Thu, 28 Mar 2024
 02:09:17 +0000
Message-ID: <c3817e18-e2ae-4ac2-b2b1-f68cf10ff418@amperemail.onmicrosoft.com>
Date: Thu, 28 Mar 2024 10:09:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] NUMA: Early use of cpu_to_node() returns 0 instead of
 the correct node id
To: Andrew Morton <akpm@linux-foundation.org>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: gregkh@linuxfoundation.org, patches@amperecomputing.com,
 rafael@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, yury.norov@gmail.com, kuba@kernel.org,
 vschneid@redhat.com, mingo@kernel.org, vbabka@suse.cz, rppt@kernel.org,
 tglx@linutronix.de, jpoimboe@kernel.org, ndesaulniers@google.com,
 mikelley@microsoft.com, mhiramat@kernel.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org,
 cl@os.amperecomputing.com
References: <20240126064451.5465-1-shijie@os.amperecomputing.com>
 <20240327111740.f8d3802b0eae15bcb8727e04@linux-foundation.org>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <20240327111740.f8d3802b0eae15bcb8727e04@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610::33)
 To PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DS0PR01MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: b70c428a-7252-48bc-825f-08dc4ecc1281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YXiZmPWUjh4e5YXohQeJqLa6+/2pZpB9hFS2n2A+P7swCjV/GFb98xpFg4VAqD+pYTbi1zV05DqCzzTos8hPCerzbx0FYgm530hwQZLqzvRMtRXncU/nE/LxCJqPFUXQFuExhqNlmFdm+AGrc55cQb3ipZZY5UM8OYDMWZLTowQ3d9dLiXxFsZKnS0srOm8bDZ+i1FRd8QcsIgRNpSzwemOTwJTlh6vryBusOOm2Qgjt840XzLSPn3Kd6IIMykxtDFhqTUVCzeS56ozkT6FgdrcvJbv4aMHFwL4D4on8moUy46v+wmHqM33Fip1gS3hhJzHrXEDfkidkR3Xg2e36oktM3eo7N6gX3di/pvTftHbkjnWm+qisdtwyJaWj6q4/Uvwo14L/RKcxd7hhHkYOecOvhbZxSuA/5EjJ6UUhPKX92DKlISrFSi/9niMJehlJPlnZRd0NqGAGWtV4OWk0cCAko+kN1o+ZS0JVetFC5KamA4Xsw4QMZscRa+hfEXC4w07aYX+2oQm41UhLVLXqkhVz9lI+5jv+vZX+m7eAcbnd6mb/xFg/UKIROve+2sWI68eQBeCNENWYwK+WMKYYpd/1MOzaR8MLCOuifOdfPOPQ0I4QDYDjdSTmiZ4KU4aef5WTanbKdfxdX/WiiX/PqoBJVbLtwTSEyNjVEjszGTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmxMU1pwS1BzRHNvc1JMT2x6ZlUxaVVnUGsyeFZ3Yzl4Z0VuVkJ2WGxiWXZo?=
 =?utf-8?B?KzVWRHIzZmxTZ1VXN0orbVZtWHFtZGpmNy90cGRJSzN2a0ZweFJvSjYrTFhT?=
 =?utf-8?B?V0xDbHZkZWF1MEhOa3ZKTDNScnJPOHFuU0EzYmxXeHQ3SmpDeTJycG5Gc0R3?=
 =?utf-8?B?TlY3cFVkK3JVME45bUd2VkJXRVB2MWJZaWdTKytIdXFMS1Y0T0lUbzFBYnZ5?=
 =?utf-8?B?eitmNmQrL2RrL01UM2k4U0xESjhHNVVadkZVYTNPQkM1RHFqOGVQNVJjT2N4?=
 =?utf-8?B?NFM0NU1janI5ZEx2L3E5UDJOYUo2dVlkeEZGVUNCeGRXQUx6T0ZTM3M1eEVM?=
 =?utf-8?B?MGkzd0dXUW9od0ZIMTZzNWNUcEpYcm5WR2pRR1lkWjBPQ0J5VFdyaWhnS0sx?=
 =?utf-8?B?R3hORUhYQ2prZFlhY3k0UXdPSWpNdmtTM1JSQ3Mvb01NTlpFdWgxSDR2TEI2?=
 =?utf-8?B?N3lxdlU2cVFPUUdMS2JIMlcwdHZFQ0dsdWRkTWIxNlNoQWNHZGNoY3c1VlRW?=
 =?utf-8?B?UU9KeGxPR0h1dndpMjAzdFJOM3Q2dmEzTG1GY0dJeGFvSGFvbWNLV2NpUGZ6?=
 =?utf-8?B?dyswRGM1V1orQ2g2WUJKYmhRRmVGZDFGUWdCL2ZXN2xZK2tMR0RZUHQ4NHhK?=
 =?utf-8?B?aEJtUVVWL1ZBdEV5ZkYzS3lxMnVyMkRxdUxDSFRYR1A2OE1jWHR5Qzlpbjl2?=
 =?utf-8?B?bU1PUEpuVWlEWm93U25iWFg5ZXFYRnU5K3hxeldOWkhtOW04aUk5dWxNRHor?=
 =?utf-8?B?UFlyYlhISm5xVVM0SFlaY1lNQXpUQytsUkxIUzA3MGU2NlhZTVM5eW1DdG5B?=
 =?utf-8?B?cWQwUzhlWU9YL2I5bm9lR05hUlBUbU5XWW13ZHlieWt5R3hadnFPdTlLWFNH?=
 =?utf-8?B?M0RucHhrWUVidFNVTDE2U09DdVFGalR5alBXTGJ4SG0rK09LZXRNYUg1UWtl?=
 =?utf-8?B?UlU3VkxsQi9VY1pVRTJyUzZlSkJESmtFWHFPRm0zRUROT3grU2F0NEx6VU5v?=
 =?utf-8?B?VFQxS3ljeHB3YzBnTTZHQlI1NGxxbGRNMk13aFI5NkV4STNwWHNLUFNpbFBm?=
 =?utf-8?B?UWl4cXhiaThOVis5RCtPcXJYZU5uR0xYa1JMemI1ak9NS0VBZktjSjFPMW9q?=
 =?utf-8?B?dHplRVJQb3hzZkRocXJaT0IvczdFcFNJclRiSnNXblB5VWNwRmc1UUhVQUN3?=
 =?utf-8?B?Ris2UytFZFBDRlJFUjdxb0pNbzdEbXdwUFNNeS9Vbjc2UmEvak1ySXRGSWN0?=
 =?utf-8?B?MFh3TytvSG5ZRlBPTFRyZlpPLzBLT1U4MXE2eU15UkU1NEpZTmxGTC9iT0Q2?=
 =?utf-8?B?K0FTQk8yT1JCVUozWnBLOEVjbjdJODQ5ejRjcWt2b2NocXdXeEgwMEMxME95?=
 =?utf-8?B?QU94ejE2MW9jTWF4L3VKOEhGa25BSC81bVdzVThvN3VsMHBZN3NrUGhOYmtG?=
 =?utf-8?B?cmRPRmtFYUtMckZSZkxxcElOcGxCeTZOT1BFZ1BXZmhnL0hGYzRuY01QSURu?=
 =?utf-8?B?eDExNnFDSHByM292OFFJOHdzbldXV0VQWmZSQ1p3amo3OEkxQ1RSLzA2OWhy?=
 =?utf-8?B?Y1BXUzM1SGQ5ckl3OHFJcTNUNXdJNGdIWDZmZTNCUzJ4WEE2WG1Vb2FpZ1dl?=
 =?utf-8?B?b1FWWVdBeTd4TzRzRm84OENGVG9YcDZWY2k0UGJNUGt2SEJXWE5zdXlVREp3?=
 =?utf-8?B?R0pTTlV4ZGkwZFYwWmE2WE4vYXFra1lUc0d5eWdBZzJ6aFUvNStLVm9qbDh0?=
 =?utf-8?B?c2RUVEFXY2dxWTRpTUcvWmdiczQrd0JkcGlsSkRHZmx1M1VDNFk3OWM4cFh5?=
 =?utf-8?B?Q21rMzdSWHBUUmwwdWY2aEhETmVjQjFYK2h3UmRCWHo0NkxqREtxS00wd1A1?=
 =?utf-8?B?TkZsTWx4RFpYRy9LV1N4bXpuTzErbitoSXFwNFBUWTcxblRHMkI5Tm4xZXdv?=
 =?utf-8?B?cDM2WG1GMFlLUUpYT1ZFcXY1RmovcS80REVqNC83ZjBuUUNJeFh3Z1czbEhh?=
 =?utf-8?B?aFppVlV4QmZ4cHNUZW9IZi9HNjI3UzY0b1NZcVNDYW5vM3dxZlJKemlrRmFN?=
 =?utf-8?B?c2pZaWJEMXJqSStrMWVVZE9nR2J5ZlFQOTJKU1lSMUlsTzJmK0ttSUZUejBY?=
 =?utf-8?B?dW0ydWV2d3JPbHdyVXhrSGI4T0RSLzdSSExzU3VWbDJhZVBHRUkxcTNOd09m?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70c428a-7252-48bc-825f-08dc4ecc1281
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 02:09:17.5278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lxQFw0xdXFPsMazXDgRh+EiCrqzbtlniEo9q2/Wy9gp7bXwQrzl3SKRruekWydArkLAC+qliQj1CwcSU6NNaCdRQmdiCKzzaSdOGfNKZoHtWTVnUnPMT+8NsjhXmNJn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB7914


在 2024/3/28 2:17, Andrew Morton 写道:
> On Fri, 26 Jan 2024 14:44:51 +0800 Huang Shijie <shijie@os.amperecomputing.com> wrote:
>
>> During the kernel booting, the generic cpu_to_node() is called too early in
>> arm64, powerpc and riscv when CONFIG_NUMA is enabled.
>>
>> There are at least four places in the common code where
>> the generic cpu_to_node() is called before it is initialized:
>> 	   1.) early_trace_init()         in kernel/trace/trace.c
>> 	   2.) sched_init()               in kernel/sched/core.c
>> 	   3.) init_sched_fair_class()    in kernel/sched/fair.c
>> 	   4.) workqueue_init_early()     in kernel/workqueue.c
>>
>> In order to fix the bug, the patch introduces early_numa_node_init()
>> which is called after smp_prepare_boot_cpu() in start_kernel.
>> early_numa_node_init will initialize the "numa_node" as soon as
>> the early_cpu_to_node() is ready, before the cpu_to_node() is called
>> at the first time.
> What are the userspace-visible runtime effects of this bug?
>
For this bug, I do not see too much performance impact in the userspace 
applications.

It just pollutes the CPU caches in NUMA.


Thanks

Huang Shijie



