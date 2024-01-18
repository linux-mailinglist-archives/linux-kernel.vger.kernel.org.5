Return-Path: <linux-kernel+bounces-29973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89274831611
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA2BB22498
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0221F934;
	Thu, 18 Jan 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="lGGCFvdd"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2090.outbound.protection.outlook.com [40.107.237.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42A1BC2E;
	Thu, 18 Jan 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571038; cv=fail; b=rSIui46rhP50szd7ta0C8xpe2L5llxXzgLJrX51sHBCpA9jnLL61BwoBbRgDxzl3oSYHYVLrgHn2trVMM9GHYmYGpuYbMbzRWpFzuxos9eo5WC4s6p2BCZ/B39qFJ6QQbwP+Sq3psMXoCgRPOWevNlCYW+tLHdpiCmNPa4JnwWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571038; c=relaxed/simple;
	bh=ZpgSKvZ84pjrTzhJpjvDpT3GUyqXdjPEL9W1Zrl45VI=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=GxDd0YMN/rVSUDqC4P5zoY0HpPv7QhSbj3flhjdZ/XLW1cykZbjvBZtU35sAeSu2hN1+UVQDa99j20/SRLpxyJmttvZyYjmMhrlN9VzJ9zqZVFaHDdfMGmAdlhenff+W6BT70AfOjuADGDau8/GlEPNAUVDy8d/bp+i5Oj93LFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=lGGCFvdd reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.237.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQIGEtWootoUXey9ZzcMd+launavz0klPqSWIYNE3l6Q06VgjkKcFZhVZ7T9SB2Bj0TxEoq5iooJgKrf7CKh9TvX2iQBZ9UWwDwwLfYy+u+uarII15VN2rbeeMbzi84u0dc6UeWEn0r/JvFelQp1SSPatb1S3ireSyJx0IgGnOax4qPrN51oz5MZRxqF6Yhr9AmDTXtF1Umgor47POCNs7SiC2xhYdDNqs/s/Wob6DQJlUnXLP2IcZ/Wc9La7r1OgkV9GFVdULy6OZLbOFBxaRi/UDXJOY2160dCgtYqftBAdDNs6/ZLt9tq751RwaC1axjT4r3564ia0Z5q4fE7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge6lr17kU3oUFaV/jyv+EtN3EYLB8BzBl/9CAG63juA=;
 b=KRK0kiIRvrCeXiinoTIalbdXgFY4uvxVHMKt1DCAqK9CMZqVuZSYjDhWUowVhLqq8i2DOUmuVrYRB4i8RuetW3wJuOfAgWjYRvzkL3IqiFU55+mS0Yt4FsoTFZJJfT3qwFJjUJk75b8Hq5/T4V/xEeOEtley4KtQL1zK8iSVAe3mB1IZbTZPH8woazhauLcTcsKMbEksc3CXL++Q4qHkqWji4QJNXSKr/GyTsYkp4flB96kY+rFfDUz5Jwss3w/vY6PXbuwuCAEPh4e0r5Oj2fgmWmZ/FVlF+zAJ5wcF9heL0//sYpA7Lyd7aCibKAgIqI8Ytubi0auh5SwCt/P4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge6lr17kU3oUFaV/jyv+EtN3EYLB8BzBl/9CAG63juA=;
 b=lGGCFvddQL5/UNUdunC+S1VfH55GIsOiqTaju5/b6j1isVr7QkYUymKHO8MUaY4A/NPKzEYRs3+TvCUBryKRIO/DAK30mLyvc4ubkubtDgOlgKU/5R+CuhhG5nGA6vGY8IdpJ8Jl78BOwATT21QFfkBG3+yyg7IAq3X8yFETye0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BY3PR01MB6690.prod.exchangelabs.com (2603:10b6:a03:363::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 09:43:45 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7159.020; Thu, 18 Jan 2024 09:43:45 +0000
Message-ID: <b5d793c6-2951-474c-8439-8f541e65a538@amperemail.onmicrosoft.com>
Date: Thu, 18 Jan 2024 17:43:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init: refactor the generic cpu_to_node for NUMA
To: Greg KH <gregkh@linuxfoundation.org>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: patches@amperecomputing.com, rafael@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, yury.norov@gmail.com,
 kuba@kernel.org, vschneid@redhat.com, mingo@kernel.org,
 akpm@linux-foundation.org, vbabka@suse.cz, rppt@kernel.org,
 tglx@linutronix.de, jpoimboe@kernel.org, ndesaulniers@google.com,
 mikelley@microsoft.com, mhiramat@kernel.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org,
 cl@os.amperecomputing.com
References: <20240118031412.3300-1-shijie@os.amperecomputing.com>
 <2024011820-path-throat-b7c8@gregkh>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <2024011820-path-throat-b7c8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::7) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BY3PR01MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e947797-4c3c-4723-03d4-08dc1809f6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JdZniYWrIC5GGNy6Y5Nx+uFe/EeEFGaJMxT4FLkpYoq9jFk/Zh78+NlUrvmCOyamvFXClpqF8wiUp2GeWQfT9sFYwNUO43VkLG6+EG8rMms5+q7CpAA3eOCBnYgAItmvJb+B6A3Ot+E11WqHbOcpa1eYMciBpX5QGyj650S1kq6dVxn7r9D6KNj44S2rmifNqM0I1dTMSV50kSW4qTDxjIjymbUFwVLlXXGUg2KWvGEoI9NTC7MjFeKe4X2CsmmDcZ1m8PQBBXaM1AHMuOmAQGKBbr71EyytL59AShmiAnnWXeX0HKd/LHjatSm8IuQPH8uGQdN/jPa8sfF0eVwg+Ur2x5Aa190l//SZEMkv335Q/KZXpHJbxrPVRRPKladiZ+42A6KW2IzUf65W2T/6Yv8uoqwgPFg3e92btpZwcFIhGxMGV/qnFAJr7z24d9anN+UgFCCNWnzVgJgay21RNluVqNa4c87K1UIeTfMwMMWjV30kfI7OYEthIjDhMTcqlmMGmo/ElDj57UeCWqvYPdJl3910TkViJdZJllC8HNKwHP4Xkd+3WAFmINdUD905GkKomxIetrDlR/7Tmqadm1EhcJtu+RIfNvcZjV68iYCLaCx11zsWIHMkkOkOWiQvSgyCfuskESIt96i49xEjwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(39850400004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(6506007)(38100700002)(6666004)(42882007)(2616005)(6512007)(107886003)(7416002)(5660300002)(4326008)(8936002)(2906002)(41300700001)(6486002)(4744005)(8676002)(478600001)(66946007)(66476007)(110136005)(66556008)(316002)(83170400001)(31696002)(31686004)(41533002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2ZTb2w3Rmx1SFNCTEs2RkR6WUludUtrNkkrUFRDVFBoMlM4UUI2blpNRU9i?=
 =?utf-8?B?Sk8wVHdMYVN4M1VEc1dZeDRGam1BY1M4VGRwV2N0MW1tSmhybjRFTVJHa0Fx?=
 =?utf-8?B?NGE4d01jUDVITmlwUTUyYjUwTkNJWUZsNnNzOUxxTkVyRXczWWVHOTg4cS9r?=
 =?utf-8?B?UTNVcHFMMjBBbCt6Wkl3NHFCcENOVEIvb1RBcnlmSjVuRWRZNkZxWkl3NnpC?=
 =?utf-8?B?TnNTemR5NXVFd0dya1VTNmVrUUxLMFovbHpGYVhpZHlKdnlDL2o1dFlZeTNX?=
 =?utf-8?B?ZFBSVjZTanBvQ0xRS2RlYURrc0V6aCt6UDhqMXZ5OU5TTW9RQmVsL2hkQytV?=
 =?utf-8?B?RUFIcWxJNE9qeTlGbTNKWHRpME1RekorUnRxT3RQOEJiaHFwWVFtVExkWVYx?=
 =?utf-8?B?NG1hZFhRTURqc2xWTHdMdnhubkRFOEZua0o3bmliOEVsNjUwT1JrUjhISHc3?=
 =?utf-8?B?SFF2NVViMnYvSkNaZGNmYW1qWVQxSXVnOE4rVXdqOWpIZ0hPY2xURFNqWlZm?=
 =?utf-8?B?c1dvdHhnT2U1dnFpT3d3eUVkOXd3TGFiUnNHaVhBY1lrVnZqVm9NQWNBOXdU?=
 =?utf-8?B?U0RCZlNzOFJVaWJRVGNhbGVDb2hWeFdWQlpGc3hlTkZXeGhiWU5ZQkt6ZW42?=
 =?utf-8?B?MDFiMitKWElJYjNCWThxUWhDT1JPM0JSZVlpT3ZvUGZPMXE1bUJuTVZKeHNl?=
 =?utf-8?B?c0pKRzZUak9pbEhMNkNZQVdTalNXZnJxa3k0R0Jxb1NRK3IzMnBseVhqRWRJ?=
 =?utf-8?B?UnJDYUZqUzFqUlFrZjhGKzRYNXVTVlRvMzVRNmZQWVN5NXBRMnJhbUJNNy9a?=
 =?utf-8?B?aXVQZHBDbjBydllCM1hoR0JIaldUQTB5VWtzNkY0bENLWkNSOVUyeEdxbi9i?=
 =?utf-8?B?VEJZb3BHMWZybEQ4S2FuTU9LWHhEWTV5V3VSbjRGUlpkTlp0Nlg5VCtvNFBG?=
 =?utf-8?B?aGtrQkNCN0RMQ1lDY1lldWpTeDE3a1o2UGpGcjhYNEovSUVVaXRHQmpLMWhn?=
 =?utf-8?B?c3l3RXBHZWxSSmk4R2d0TzdPREsxS3cwQlJwZUVSVjJyQmhEeS9wTUx0b0pl?=
 =?utf-8?B?d1Vtc29wSGVIOEVjY2JCT3VuZmV1MFdoc2hidjNxRkNSOVJWblJYS3lKNFF2?=
 =?utf-8?B?d2piTWduQXRxRUUyTEYwRUgxcWl0UjhPb3hXMFFqVWFvZ2E1ZDJCb1ZTbksw?=
 =?utf-8?B?NFNFdHRHN3RUVldnZlRHOERDSlV4MVVvdVp6ajRhdVpFdUh5MWRRMm1tazBZ?=
 =?utf-8?B?UUpqYkxHc2RRaGdMejI2OVdWODJaS3ZzTEh3MW82bGVhWW4zRTdoTlVHYWRI?=
 =?utf-8?B?cHlmdUZ0SXR6bnBwZUxMQWFJN29hOGxYYnNybm5DVmtJWlpSTFkzM1ZqODBH?=
 =?utf-8?B?eEx0c2dvamROeXZGV3YxSndad2tnaUJkVmhTaWVSWnVzcDlPMERXaHVvcnlk?=
 =?utf-8?B?ZlIyNUs3amd5UDQ0WXR6OHhacWR3UHRpcmc0a0ZSc2dGbndrdDU3UVBDS0hu?=
 =?utf-8?B?Z2hPK2NUNGNoNDAvcmF6cERxUjBmWGNyVmZoeDFYNWg4dkxZL2FzWGdUc2hs?=
 =?utf-8?B?VXBHZHdvRnpOMHhwamM1ZFZBd25JTVMyeUVJcG1XQ1lhcjMyZktSZFlCS05C?=
 =?utf-8?B?NStEc0hiaDVqSjNhNlNEaFJuUnpKampnclc4Rlc4RlRFOHVrUGhnYkJJVlpt?=
 =?utf-8?B?OHBUSjU2RlVaM2pyUHBTWWxxam8vbkVVZnltMElvUm56QVlxMVNrVjZTeFFS?=
 =?utf-8?B?WUY4QlgySEtBZXFJa1JwRGxSQi9GV3l1UWNyWVJJaytGUVVJNWQ2dUc5a3Fj?=
 =?utf-8?B?UUp2bDY1RFM5ZVk5bHU1dVBUTzJ6SXEvR3pCcUFDc2J3Y0FhZEdEMUpFallB?=
 =?utf-8?B?cmhiOEdqU2x0REtYbXlSSmEvVzVKRkorUk9aajhDL0JBREtjQWViZ0FLNVA2?=
 =?utf-8?B?UC9HM002YXROZUtBV1lFeEpSOEtPb0RjblN4SkZraTBPaHJETURpczFRY0tq?=
 =?utf-8?B?T250d21nU1A1ekZucjFrSTRZdjU3ajBwTlIvSHA1VlhaeTg5VEErT20xZXNm?=
 =?utf-8?B?MmpZSjBaRG8rdkJnNlRlYUVXMXBnUmUrcVNsV2luRExGd2F3Sk0zZVJVL0Qy?=
 =?utf-8?B?OG1BelBxZHJIYUg1eUpFTDhuNXIxM1ozQVdGVlN2c3VYSzllaXFQY0tJNzls?=
 =?utf-8?Q?bf/LcA/Ft4kE5Pe0rCf1Md4=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e947797-4c3c-4723-03d4-08dc1809f6c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:43:45.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Q3TpdTXa7ZTHeqzxbkBIx32wdM03n3dQGMoyZ6K6JvjU77V364stTIgahzhdrnk+G1IdSlnDaEXONK6XuS8UpLoHZAans7qDBI9sWMh/AOgONjkTxrX+r/Jpm34urEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6690

Hi Greg,

在 2024/1/18 17:27, Greg KH 写道:
> On Thu, Jan 18, 2024 at 11:14:12AM +0800, Huang Shijie wrote:
>> (0) We list the ARCHs which support the NUMA:
>>         arm64, loongarch, powerpc, riscv,
>>         sparc, mips, s390, x86,
> I do not understand this format, what are you saying here?

Sorry for the confusing.


I should put the conclusion at the beginning:

   The generic cpu_to_node() has bug in some situations.

   The generic cpu_to_node()  does not work in arm64, powerpc, riscv 
when the CONFIG_NUMA is enabled:

      The cpu_to_node() is called before it is initialized.

  So all the four places are set with the wrong node id (get by 
cpu_to_node()):

            a.) early_trace_init()         in kernel/trace/trace.c
	   b.) sched_init()               in kernel/sched/core.c
	   c.) init_sched_fair_class()    in kernel/sched/fair.c
	   d.) workqueue_init_early()     in kernel/workqueue.c


Thanks

Huang Shijie


