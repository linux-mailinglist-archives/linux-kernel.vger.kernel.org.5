Return-Path: <linux-kernel+bounces-129828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE32A8970E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409531F2348A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07667146A7E;
	Wed,  3 Apr 2024 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yhurcTnk"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2111.outbound.protection.outlook.com [40.107.220.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590DE1482FA;
	Wed,  3 Apr 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150755; cv=fail; b=OgRDSqdba6g1On+tVsbkvHzr/txU+13S4wXOaJMChs0/Cl2vj5ZOAu1RXYN8MbnQ83iWOKjV3FklKrIZ1kGFcBt20BCOndVYUuVIMBz0fjlKrn5Hqe4drDlSz3FCm7cLSgeC8RAMh8Q11/8GmkR26F3sVtbK3rsxQe5pyMMfnkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150755; c=relaxed/simple;
	bh=HiGfjZ+d5X/USkdbdXaPDZeXkyOPVsrYIWY1gbiS+qw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FRuQvuh/GauxYh8FKQsCYjtKVqdlNHU39WvW8AYeFCFRFN8IrWsUI2aw9Gwc+Aly2hTkbfym7goXX8r7l0KVu/BE+xS9cgQJ8uvm4MEiX7KaPakuHX/AiAv1UBUgJHqllVsCwvqXwztWMWIDgenrLRchwwqFtvcV0G7EvLMc098=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yhurcTnk; arc=fail smtp.client-ip=40.107.220.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2Rcd5YHUPttzGVt8EWCflUKkAm+AYj8UfCDfji0lOw7DJ5QjEPrAs3QlWEzyYgqvaJOaixrV0xUOK7imxRqrgiXJeQQyh4W3oBkXQA4YoPC8pPhyRSFrjjoPKkSM2CtQI2UsilRA77aSPT+8ezap2rt1/Rc00Cfv398sUUw7R5b6At9bdYbwfwaNg2i8HKaiy7BydeOHqe01lWZxRLd2RKVZ6hm/ComuRFKoT3d3R4gAnRjkc3JJpNWhfb3JPo2ZBmlqTLelh2+j+extu8soasBWnLks8zf3VNCsjr/vmHdkgutbkuSEyPLVvoL+jP0Mz2Hr3dEjtJIONn/a6G0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQUkQ7rHA8RYI2xu/Uvvi9GfRQsi9n3vLAUOgU6MqXc=;
 b=ZYsXdXHqdYEqMmhKNRtJGoH9Ko62AF4P1hztR/llsdqc6los6mQYMYBmgwMqJHMRfUvEwTHJ9E2zNyDhToOazMEIHz5596V6m2VbtmQXecCAqvixU4K2wWCQ/8TwVPIr4dglu3WBzth22d/bFfK4Lc/RXPQZmnB1reOKAO3wyGSrOHfeuu/JwD2mjoT650yKob7dnRUE89RiPqUjC4csQKGhDymMJl9oRz6pFGPqFiAM3lZ3JRaZ3bylXVMJzXahgShbmjGNVVo8BLSvvfY/gtlvvbaFh0cnFrrKiXmsSA8r2UpeLAoxdRl7U35gVf8iJNQ9bcTPg5IuFQoFRNZ3MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQUkQ7rHA8RYI2xu/Uvvi9GfRQsi9n3vLAUOgU6MqXc=;
 b=yhurcTnkRBTwkZ9Mf93O/CB2P/O+QRK8JYLuHtme1VDF+tiw9D8+eY09RfcUy9cf57djS6MfBbRUpLzwnR1mE8l3yjZCuch4/iwWoC1T571wthNXLhFfoXe2fdUkkAcLGD42HmDrgqXaT6UKixCw2RbCj/dS6ZVJN9+ZoWduaZE=
Received: from DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) by
 SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 13:25:51 +0000
Received: from DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::d380:b56b:46dd:8758]) by DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::d380:b56b:46dd:8758%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 13:25:51 +0000
Message-ID: <77f5c5ed-881e-c9a8-cfdb-200c322fb55d@amd.com>
Date: Wed, 3 Apr 2024 14:25:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor
 value tracking
Content-Language: en-US
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
 ast@kernel.org
Cc: harishankar.vishwanathan@rutgers.edu, paul@isovalent.com,
 Matan Shachnai <m.shachnai@rutgers.edu>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>,
 Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>
References: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com>
From: Edward Cree <ecree@amd.com>
In-Reply-To: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::9) To DM4PR12MB6207.namprd12.prod.outlook.com
 (2603:10b6:8:a6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6207:EE_|SJ2PR12MB7944:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	haBopKVD2q1feeUoF4MnYPWnpNVt/RENC2WOJykRskTItl3dQsFdKxUfJoiBfxRsoiKedE0ACJ+6pB3jKONLqKfF32FTdl6GVKwg2SO8n30Xcunx64kkJjsWHXbzUMn0kSxQg8TW8ChSrWw6PAn9xZl1P6uSQvlJTl7sn3nuCi6SAYqn9ZSP1/RMpYIICiWGyP8SGSHtFDwTFhl7uTDAsLYyr/OeGOT7kAeMshKoie+i0/sNuq4gG1VAt0STFQ8RwYHGIcb9LRXGD2Gfmn4rDf+VOF8m9Snrgn6NOylKZrZLZ+QY+EVd1Utd2bazVXbLLhVUEG7QZln4+ok+tanXqeNxab56CfjT1SxB97cUw+TMgxLKd9cxPqo77Ui83JU4rWJcmXwcz5nYXjyVqFt6dq0hgPCO+ak5GYNoUft/YUgQez0o3LAi75obCUWmQ63ogJxYxTN6n1a2qKsITKIU3wmsra3ANkcJfUKf2RJn5iGD96LGY7QSg0y0nBNgYdIWONg3/DlmoqgHrqhzNex7SJg1gmB9CdfmNMZ6JPIxf/7stqiE5u1lCfIULlE+A3tz115T3bKup5dzqH+xFlGYkrFSxdzVg2OiRuDM6JRoZK18VUA2MKQwBsvYL44hzayv5gtqHb30VcA4W0p2OpeRKKLjxImeAekA0aRkPbp3Nic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXZqOXBBc1BTc2NrczA0ZGkzbGNVdG5iaHJwMG1XWFJuRk1DZ1VvQWhDUHpI?=
 =?utf-8?B?VWpNMGNtK1dIWUZzVXZDbk1GNlZHbElTYXMzaWZXaDZ5TWdqWVJtaDdzWjhi?=
 =?utf-8?B?UXhWU2hhWElzUHh2UDduaXRBVFRnTWZiTFlFV2pVZWgzcld5cnJaTXB2aGRU?=
 =?utf-8?B?REM4amhIMldzREVuN2dVQk9Qck5oQ2dFeXJ5Qmk5R01lRy9FUmhiTXliSDZS?=
 =?utf-8?B?OVYvZmlobGo4cnYvcE9WWE8xbitzZDM5cXR1VWI5cnFLV3d4WEh4bVJIclY1?=
 =?utf-8?B?Y1VHQzlyclBPa1F2UjB5YmNKbGpqSHBIQ0tkRVRoTGlYWFZ3cGhqdzUzMVdJ?=
 =?utf-8?B?NXNqMllCaWt6WHFzdFpJSHNBRkhBUTY0SHRQeEVnQkRMLytpZW1kSk11NkF6?=
 =?utf-8?B?MlYyVEVEK3JMcDBiTHhrSkl3OG9MQWdhZVRHTTZQTVFuNGR5cjY3V01FeUc3?=
 =?utf-8?B?OWFBdFgyY3RwMzRSVkZOOE0rMlF1c2RDOW9PZG9rN255T2hBSW9LSkMrUlpY?=
 =?utf-8?B?TCtYbjVwU0NkNWo0S1hoTjNYM2RzaXMvMmJQc0xyM1JNY0VCQjVNdmY0SE9x?=
 =?utf-8?B?Zm8vbGdIaXlmTkZVa0VXbmttaXRyU0tNc3RFWkg0Z08xemlnbW5ac0xlM0Fh?=
 =?utf-8?B?WE41SW5wdzJzUEJNR29YczhibklEdjhHbTR3MHgwb1hXcCt4NHgxb08xNGRp?=
 =?utf-8?B?Tnd0NFhBRDdzd3I0LzR5aUpHVGlaeFA5MjB4TVIzSzB3YnJEdUhhUUxjUlV1?=
 =?utf-8?B?L2VYVEFzZW02ME1Ua3J5b2hEcStPNElMemxNTm45Z1d4NUtncEpBSHpUUlRU?=
 =?utf-8?B?dS9ESnZLbzJXeHhwNVlBTWpJeWtYUVVhWjlEOHBXbERFU1Y1eUNpTlpFeTN4?=
 =?utf-8?B?aEEwWS8xVUFVZVNDYVliQytZZkt1bTFlWEFqdmpCV1Z1Ty80cXNJcjB0bkkw?=
 =?utf-8?B?WS9LY3hpUkFiMXc0d1dDS1NIY1RuNGpDanh6NjRDVEw5RHBQVzZ2V2dCSU5t?=
 =?utf-8?B?RHBMUGVWNWptaHVWeEVFZFdJTFFocVZBWDV6bnQwSGx4a3FMZzNrbkdLS2Zr?=
 =?utf-8?B?akNLQWxlYzNHMjVTTW91eGxSUUpLRzB4dXFwRTNCcksweGgyVElWVEcyYmtK?=
 =?utf-8?B?dkthT01MZzh3NmR4bGR4YjY1Z0VoTUJXYm1hMWxLTGswTndLQnNFM1k5bnN6?=
 =?utf-8?B?aUd1akN0U3NWK2R2N1ZkN0VtL2hjZTgyN3REeGhvMXJwUXdaZXAxTTR6czlM?=
 =?utf-8?B?ZzA0Z1VqTytDdWt1NS81akhkZG81emFwWnlMdzM1elJUaU8rVUkzSUlEdExu?=
 =?utf-8?B?SmJodWRFU3F0WWNDaUV3ZHBNQ2NZUkR2WGlSSmN0RXY5bXZkWFIza25tRk9o?=
 =?utf-8?B?OFlIWHlteU1rU0lwVjdKNGl3NXB0cXZWeUVCcm9kYkFuMlI1UUFLM2JYVE5K?=
 =?utf-8?B?dUw3anpDOU11RUVLWG13T3dyOWRPN1dWSHZSUUlmcFB2NnVaNXVGZXB1SWFi?=
 =?utf-8?B?aXg2NlpaSFFUeFNEc2ZhRG81YysyV0FzMUVkZ2NJWC8zQURBcnZxOW9STTJT?=
 =?utf-8?B?ZUhubXBPMzAyalZacHBYa2FqRFUwM2M5dGFscEhURWdsb2MzQzgvMHluVmpz?=
 =?utf-8?B?aFZJMGRnWStvalFYbDZVUy9kUFZrR25hd3NSMHFDNjZGb21PQWh0UnUrUFdi?=
 =?utf-8?B?dVB2UGtzcXpZcStncVBOenNIMFhLUzdTdDdveEpXRXlZMmRUOTZTRnc1V2M2?=
 =?utf-8?B?UDBoVG80WnV4c2xYSEw2QlpzOFpRZUlPWnBHSDVhWUtmZFhDbWExQVVsbGxo?=
 =?utf-8?B?MmUzTXJVMjU0dHBxK0ZwZjJRVVJMSnE4VU5pSUx6ZmdCaU5rWDdxUnFTWVNM?=
 =?utf-8?B?RXpSOUJndzlRMVM4L2lPNisrUUk4WXNLMEhXWnY5WU95SXZXT3E4dXBTWVRW?=
 =?utf-8?B?Vm1pck8xQ3V5ZHdKaUZDZEo0UVVwRlpWQ0Jrd2FtMUtHazdCbGVMRUsxV011?=
 =?utf-8?B?TmZCSndwY2x6TEs3dC92YXo2eHZNanJWWVhlZEtmZ0YxOFF3MjdDSFpzNXJ0?=
 =?utf-8?B?bnE0UHEzc2VrTEVUc1U0ZTNUcE5kazY3VnJUTDJQSXBITGh5dlNQS3lobVFk?=
 =?utf-8?Q?gslk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27d5cd7-480d-4d0b-0014-08dc53e194ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 13:25:51.3783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOQrC/UydIbFkfYyskhNOR6VF56BV+tXmwWVRsJG0+BRMtQDB5H38keED9VYUTR+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

On 4/2/24 22:20, Harishankar Vishwanathan wrote:
> Previous works [1, 2] have discovered and reported this issue. Our tool
> Agni [2, 3] consideres it a false positive. This is because, during the
> verification of the abstract operator scalar_min_max_and(), Agni restricts
> its inputs to those passing through reg_bounds_sync(). This mimics
> real-world verifier behavior, as reg_bounds_sync() is invariably executed
> at the tail of every abstract operator. Therefore, such behavior is
> unlikely in an actual verifier execution.
> 
> However, it is still unsound for an abstract operator to set signed bounds
> such that smin_value > smax_value. This patch fixes it, making the abstract
> operator sound for all (well-formed) inputs.

Just to check I'm understanding correctly: you're saying that the existing
 code has an undocumented precondition, that's currently maintained by the
 callers, and your patch removes the precondition in case a future patch
 (or cosmic rays?) makes a call without satisfying it?
Or is it in principle possible (just "unlikely") for a program to induce
 the current verifier to call scalar_min_max_foo() on a register that
 hasn't been through reg_bounds_sync()?
If the former, I think Fixes: is inappropriate here as there is no need to
 backport this change to stable kernels, although I agree the change is
 worth making in -next.

> It is worth noting that we can update the signed bounds using the unsigned
> bounds whenever the unsigned bounds do not cross the sign boundary (not
> just when the input signed bounds are positive, as was the case
> previously). This patch does exactly that
Commit message could also make clearer that the new code considers whether
 the *output* ubounds cross sign, rather than looking at the input bounds
 as the previous code did.  At first I was confused as to why XOR didn't
 need special handling (since -ve xor -ve is +ve).

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fcb62300f407..a7404a7d690f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13326,23 +13326,21 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>                 return;
>         }
> 
> -       /* We get our minimum from the var_off, since that's inherently
> +       /* We get our minimum from the var32_off, since that's inherently
>          * bitwise.  Our maximum is the minimum of the operands' maxima.
>          */

This change, adjusting a comment to match the existing code, should probably
 be in a separate patch.
> @@ -13395,23 +13391,21 @@ static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
>                 return;
>         }
> 
> -       /* We get our maximum from the var_off, and our minimum is the
> -        * maximum of the operands' minima
> +       /* We get our maximum from the var32_off, and our minimum is the
> +        * maximum of the operands' minima.
>          */

Same here.

Apart from that,
Acked-by: Edward Cree <ecree.xilinx@gmail.com>

