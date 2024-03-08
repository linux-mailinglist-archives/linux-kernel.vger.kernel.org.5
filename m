Return-Path: <linux-kernel+bounces-96663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3079A875FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E272928313A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E022F00;
	Fri,  8 Mar 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BMsenh1x"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11012009.outbound.protection.outlook.com [52.101.128.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DC846C;
	Fri,  8 Mar 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887087; cv=fail; b=aWUVjfmEfmRKjsM/m6HBFStExzO/7PH0hpf0ESYHy0YUwiiHr4fldoljjvkyHYMWY4qvQEPExNqETb2Qb+t3N1ldaFMdGPPY9fS1i453BRwXyI07u6MQogefs+S69AMis7kOFGtUqOUJKSEg6DVA5KeQj/Od0e9p2LztqrCJRJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887087; c=relaxed/simple;
	bh=JimobX8zmyjDLsdZziJ0Qni647ZdQe1iV1VvzoSsglI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YEGbwI2KGnizVXlk1e/yNT6sData1/FeMFBI84YO3UIK210I9Tq0GT/kzl4gECpUMdv61Wk3T3y/kS1PQhaVyoAwhV0wheF10i5+mNamPlXJJL9QyTaR05GMyk7HJqPk8kBRMsbihCby7Yo+JsjhbYEvJ7mNZp30P8YGWOEpxd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BMsenh1x; arc=fail smtp.client-ip=52.101.128.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXRQfHuw8Rl2AACBDWikKI1yCthT9aI0jxGNcp8X+cq72FDI0AhK1TIbhFVM4VzDficwQsxaEdJo5j28hQGPIKl1SX9jDpOXZthKQEStsMfJlJhnoJ7QAYfm10WHIooQUhjq2FU0L78VVtaYEe1/ixtFWM9GzQ6phlFVRl9ZfKXnLKJWO5aZrbcw4Cq8MhzhQP3GH+lkxBxlRCCu0L0XmdCyMPpKoXNkkuP/XIz/d82BvdG6uOlF7vEgMe8JSZyte5E3O1ezcvSBmvkQSXfj5/WA2YsxAUcxPhiaupUwDlgDeDM5/8acVgRBok9Ng1X4jh4ZUI7S/2tAR9rzkZi79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JimobX8zmyjDLsdZziJ0Qni647ZdQe1iV1VvzoSsglI=;
 b=LMhiuPMQYsg9eMUG9DV3Rt5MTdMeHda4URNVV+/N0x1SdidLk5bOErLjvL/LkVjnFVrN5+obIrUPWjIqyUJZV8yIn6CBNi2YfoT8YgWlxDhnOsBFs1uZFEIx8tcSUjXWAm8sHTMN8Mcmf1NbK4Ippp6aZ00QYb5cZnuyI3mXsF2q+sA4FSwmi0E65wfyG8AecgeFkz1FGUJyGm4WJM62UIToeqp9WxS2Lzt/yAyWknrqG6Eowsf72+ck4Rk1RFzAsraJ4s8rcITKxmWJtvkhSbrdGHSYUyUj4N3QrOYx0MFO6I+qDuRbfyUaR0gZHMmJb4mvtVmMYKeeyDe/u9Cs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JimobX8zmyjDLsdZziJ0Qni647ZdQe1iV1VvzoSsglI=;
 b=BMsenh1x3BxDu1LpiL1V6DjVBxdDvZ86hLLQzXZphd82XYzHuXYrzl42O+5f0H8O5Onu/iQQJKbqm/8f4ni3P1lcbNHEe7niJnlwkwLlmCIFveBJbu9/ytokAf0t5GGFkugD0Bx+m8bc7Z6XxafQYgefRCfepVcj1reda0f36goxfpVCTanKZDNzG8y4jBJOJbOC/2mMsyk6duTdTMFOhPGqy8PxSoMRBjTckKPue60vlM/ug7BN0QdghPVscYhzfiTZWk47RX4njcTUDcGnE3jrgfNifCOVMVu+CcxfuAapzSAzdJt1aZSJjyn1zffv4onCxDY30Kw+zI/f4pqNhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4037.apcprd06.prod.outlook.com (2603:1096:301:33::10)
 by TYUPR06MB6098.apcprd06.prod.outlook.com (2603:1096:400:358::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 08:37:59 +0000
Received: from PSAPR06MB4037.apcprd06.prod.outlook.com
 ([fe80::d9b9:81b5:e5a8:d05a]) by PSAPR06MB4037.apcprd06.prod.outlook.com
 ([fe80::d9b9:81b5:e5a8:d05a%4]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:37:57 +0000
Message-ID: <a78ec810-016a-4866-b19d-f7a4928bd0b2@vivo.com>
Date: Fri, 8 Mar 2024 16:37:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v6 0/2] Make memory reclamation measurable
To: Michal Hocko <mhocko@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, akpm@linux-foundation.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, opensource.kernel@vivo.com
References: <20240105013607.2868-1-cuibixuan@vivo.com>
 <fac8d079-100e-4b8d-9a35-db8219b28b51@vivo.com>
 <20240220212202.59ddc123@gandalf.local.home>
 <3d4f44ee-f533-446f-a9e6-7f58afc78d65@vivo.com> <ZdWpyN_8Z6dvDQ48@tiehlicka>
 <a32030f0-b6f6-4bd6-8284-bb762ccf9205@vivo.com> <ZemIOtbIoMYqcf-V@tiehlicka>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <ZemIOtbIoMYqcf-V@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To PSAPR06MB4037.apcprd06.prod.outlook.com
 (2603:1096:301:33::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4037:EE_|TYUPR06MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0147fd-1e58-4c0e-102d-08dc3f4b0e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4TPZHBFczDafrdLEmvyKI77hqCTZ54dPKVkRkuvLZUrXR75w/blSt+4NK6/2LbL2+/VE0OyferPtHtj0uMsIdu0QLEZSDiC4fW3F209cHzpUMGdqPtAwav+hsrTbRtiIwi32dsywFkU3UoBkVC1HT9XkHRBkSDvVSOQ1xjS1kuFPzd21+H2n3+ypVUwKaClTBcEYm2KeaYqjCD6ABbuVL/Row13GfmSRlgfFvs1oC6aVtVs1qFaqnENRj4c/LclNScyWAdOYj0Zr1BOqR6VUuLiN7diRtyPEquJ/PfE7CRCtYMXZvVHP+MyfP0B/EGt/QlqMWpSR/hDVylPwVcSmClYFyUE69MxBBh4Aw35f6cFFiRteHuz9vn0QOEdq5i/GqPZ896FmRcnymZrAy1UYjgVyol2amwYR0SCegFgiMecTOaIzJ+Qsc1FDmHsvo//81KDjK82CQa2J1hC8Ur9n62blHWtHovVU8OyygE1HTzBxZOZ/DukiPmDcc7S/9wUSWvTtDvovN4SL0FFiW6oKrlU+pqkHZSaFCaq0DdMM/JEAt/ZlYT32pOwICPAsJOMPCNFv0fBSxslQusjmRuBbLRoo5GxIT5NvnfB9qvOQkrMrCljIqTDfwlcalJSUKrhN6nj3AiGQx9S/ra0O3/W/kJANm6af81MmQSeto+6SAHtM9BDSamiHe7NnIvDsSphPV4WhLWzbumqX70l6vBHefWpJD2rCVsXNSP0EOyhrWLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4037.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlRldWpZdCtLTWFRRDNOMUducXcybVJXOHhrNk03ZnhseEZmb29VQ3h0YXRk?=
 =?utf-8?B?eTQybDYzQXA1TTl5QXJrMmdVU0labHp4R0FRaDhndXo1UCtYc2FKejJZMHAv?=
 =?utf-8?B?Nm5sYUM0bTB2TG9saXRSZyt2OFVjek4zOTNKUkNMd2Z2ZXJQV0dnUG0vbjJh?=
 =?utf-8?B?L1lQU25Mcnk1R1c0czQvdHY0a01TcFdBUkRlZDZaTEM4NzA2TUEvSkxkTG1R?=
 =?utf-8?B?ZHNBMHpUVzlxZW5DV2p1dHM0NGdvSmxsYTU0MTY0SlgxUEtOTzNGeTlqL2lT?=
 =?utf-8?B?WTVpZTd0cTlLd3NjWnVMRXhDdzFUaU1wdWFjcExpa1ZFS25DVC9pTjY4d29z?=
 =?utf-8?B?SVY1V1l5OGNidFNmOThBaDZ2WFJFemlIa2pQMjFHcTBhN2FNZ3lPeWFPZDVy?=
 =?utf-8?B?L2JUQWNLVVJBRUNZZEJycnphQWFQNVMyUkI2ZnUwc3cxdlNwVzhzSitaYzJQ?=
 =?utf-8?B?Zk5WWTVMS2lHalROU21BbDJSVWNpaXArQjhORmpPK2NVMEJqc0xFRGZ1ekhC?=
 =?utf-8?B?R3Q0dkdlWXNqNlN3a1NMdFdKL3VuM0o5ZXpENEZVbnFkVmEvSzdkQVBRZGlJ?=
 =?utf-8?B?V0IvNXA5MG92NTg0TG40cXJKYWNSTDlHWU16dGRUOVA1UlE1TmJrSm1ZM2hw?=
 =?utf-8?B?ck9yamFBOFJBckFDZFhYWHVMUnNMM1FCUW5LWVhQTU11eUtvRld3T2JWQWtX?=
 =?utf-8?B?cWZGZWw4bVNiWHFTVUxRVVQ0V0JOR29Sck1rcFlNV3R5NzRtUDBERk1BdFg2?=
 =?utf-8?B?NkphSmN6a3U5OCt2QWozdHcvaEdaVTVwU3lScVR0cE9EZ3dDQ3VpYTJrSkFY?=
 =?utf-8?B?RDA3QVowbzM2NXJWTHJxZG1LbHZQQ2p0elBVTitYM01xNjlTQWNkUTdEaEZS?=
 =?utf-8?B?bldIWGVSS2htcHdGcHRZeWh1OW12ZXhXSUgzZ0doTnFBaldFR3BKdzVVVUlJ?=
 =?utf-8?B?TlZxcmNQUTFKZXlXa0I3aVdLM0FxdWlGa1h1a2M5VzFlZHQ2OElScFE3NCtR?=
 =?utf-8?B?TFphcFkxVW1qTk8zSDdpd1dJMVRjL0dzNGdHMlgxdmpxZ3NQRjd0aS9TY2Zk?=
 =?utf-8?B?cWNBaGdwUStuQlExR1hONGZDNUZJSUxnTURKOWdVQUxLY05FL01LbDZGYjJN?=
 =?utf-8?B?MjB2Nm1qekkvTDdSNUxDMUQ5WVR2clZVYUJIWXpLOERnc01ndnp0YlBzdk52?=
 =?utf-8?B?SDk1WldVeEdqWW5vMEJEK1dPSHh3MFFoV3ZvWWI3YjQzeTZxVXpYaUR3bDRi?=
 =?utf-8?B?Q0ZteXVndTYwN2VtNTFCMHVoUmRnbXJZN1A4K20vekhZa0JQa252anJjcHVu?=
 =?utf-8?B?d1l2Q3dVZWRXSzlQcTNQUlFMcGdoTTBZRU1WaU0rU3FQMC9jT2Jvdjl2Z1ZP?=
 =?utf-8?B?dGg3ZnF1SXErS1d5RDJvS1BGdFVVMHJ2T0JXYzNjVFE5MHBSWW1FeWVFMHFO?=
 =?utf-8?B?WCtpMmhaeFVGRDUyWEJQWFNKWm9kanRoZ29RQ3V5aFczTWVYOHNGWWF0Qkcw?=
 =?utf-8?B?QjBvbHJocnFvc0JHZSs1a2ZZeVg0Y3VEVDRnSzJwcVBLTitGTzcyRjdYUDNY?=
 =?utf-8?B?cVYxUTBoalJVbG10VERDazFIbkhIcm50NFBMME9RbEpHMXNjNVNqNndVRmZ6?=
 =?utf-8?B?NzVscVZjbUJ4RVZ1ZDNjWUhKMm16bHlWdDFXeUZydlZXT3JWWHl5Y2duWkd2?=
 =?utf-8?B?S0xrcDIrSHpia1NObVYwb1NjWmFzenRFNytsK1lSc1pkcGVZdGFlQ3ZWZWU0?=
 =?utf-8?B?TkFLb1Q4dDZRL2U2Q0trbW5FV1JNSFFJNm1qTHdqZHYxNENoMzBjRk5wbmZ3?=
 =?utf-8?B?WVcwQ2ZsckRzYVRQLzdTMUtiaUdMdHRnOFBqbmRPNEJacERudVRiUlJ4ZXBY?=
 =?utf-8?B?WnhkYWZPQ3R1SzV4ZkdEMnAzS01Hdk9RRHljeWcwZEJaTzlISklqSGptemlr?=
 =?utf-8?B?a0sva1dFZllyaHNyNDhTZ3VQR0xaMWxvYlc4bDJNWFRlQk9raUZXV01ueGNR?=
 =?utf-8?B?RDhJekx4b0xrem9FdXgxNzZzM3FYazdPV1lseFJiZmZ3SUFjQ1V2YmF0Zk04?=
 =?utf-8?B?TTFkbnJtK0ord2U4QS9oeUVmdTJsSXVsd0xwRTY4Z0ZWbXk5Q3p3d2lkekFU?=
 =?utf-8?Q?V7XBfpIanw5/op/Oj5A8X4abz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0147fd-1e58-4c0e-102d-08dc3f4b0e47
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4037.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:37:57.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOQAoKGy+Jw2L8kmiTctRebruhDDDr6f63JCRkhJKlTj0g5bjIW+nNv4bwoV1C4Gbhe9sdD8GuC+2V3opPNaJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6098



在 2024/3/7 17:26, Michal Hocko 写道:
>> The main reasons for adding static tracepoints are:
>> 1. To subdivide the time spent in the shrinker->count_objects() and
>> shrinker->scan_objects() functions within the do_shrink_slab function. Using
>> BPF kprobe, we can only track the time spent in the do_shrink_slab function.
>> 2. When tracing frequently called functions, static tracepoints (BPF
>> tp/tracepoint) have lower performance impact compared to dynamic tracepoints
>> (BPF kprobe).
> You can track the time process has been preempted by other means, no? We
> have context switching tracepoints in place. Have you considered that
> option?
Let me think about it...

Thanks
Bixuan Cui

