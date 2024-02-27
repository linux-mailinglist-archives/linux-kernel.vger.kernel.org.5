Return-Path: <linux-kernel+bounces-82509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD286858F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0274A287CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A7F4A31;
	Tue, 27 Feb 2024 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Asl02ldA"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2030.outbound.protection.outlook.com [40.92.103.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5A623B1;
	Tue, 27 Feb 2024 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996194; cv=fail; b=gRFbJFZ5QqUp2Z4/eSUNvayUFM5HOL37qpMRXb+bTjWzhLGex00XjGV1spLU0sSonh5dGtX3zr/G5nj+NDz0c7Nb70cvKkHGnCsICn2QtqUcHeF1zrV0kZNxt+hTYq6JPMu/ry6tuMxPDwtRTbvFyu93J5HS3xNy5CJdhzZ+FWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996194; c=relaxed/simple;
	bh=N4wtrGoA39k7iaUMNC+F3XNjvyF2dLZF3rtz8DC+w4U=;
	h=Message-ID:Date:Subject:From:To:References:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=XdspPSYOBNZUzy6IcBeE6sd3mc1mC/NeLv7kWjxnhxfNAYb4RL+diCcGmEPkv2JgOJbZMMgwPof1aG7nijEHSdQunLcEAmb7nQ4Kf3HJfan4UlmjQcrvwaPYHalY4vfJ760fW+CRMlmoY54Hpc4A5m6DNOcQzSFT0slMbvXzj6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Asl02ldA; arc=fail smtp.client-ip=40.92.103.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3hPkGe2ig4VUKuSMxDgJQV6yNDrpOk2U+S7fLpniJAfIMd51adicDLOUBCSe2OfMPLMOaB2UJCIWq2AaVhd+foqc7CdxNmTiZIHWgNbRWGDIgSMYXdG32ecDoTe8A3wHgu/7HALAgDeCDEhKpcmIX/FJ+3Ylf0yAmtBMgqXxcMr8PQ4hsIr1YNfb934whScm2FwJDiPlvAvOs8zpXaUVmsP7cO4u7enIvhkpb32lianYeE3aONLeYr8tf2h4bDqx6dCfCB78vwO88W0PHwpUrxr7eGjzj+1JR56gvaF8DucYNQWGdmONLnbwVfxpLPX7O955UZ446vF6gz5iGwV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEFW7z3hcdaOooNGB9OZ1hY6Rk6BSpKhU+YfzSoqnsk=;
 b=hKgRbTjpLrXeFhZBeEuUul4ZcsPI6KliGn1veUAaSZ4xYCUX2Wpjd58m4Cvn19ANiULVczqFvRtC2XpqxMbIFmrH1Yl6fdUC9o8Qca5xzZ1i8CcTiN7FH1lecw8uf35METqVtzL6+zy7PdUp3PRYAgBWsJtkBsNoyntsfbgAGMNTpjozbOC05Xmmj0yUZiSENwGgbNC0HPE5V9Cdp2+mM0qaIksafURObYjGLFRH/omDO4Ntidrva/UnmJ2eIdSRGdTO6TXPfaMNWEoD7fmPO7gplto//9tEWt9tbP0UEwSjEgLynptQFYGwwf9fCJLee+BDO5QpHpSvTNoVYJRl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEFW7z3hcdaOooNGB9OZ1hY6Rk6BSpKhU+YfzSoqnsk=;
 b=Asl02ldAhSb3Ar5giASxjRCP/lYL77X4JO7bZXblZ/85U3vaJFrPwMZL3XyOZt6lBqm89UrfLzHN84YpzbFZO1NvKmq/FA8PBntRfL38a00jLDYy1MNeUaYzIRQBuVIvDmTmJVmF7GtKBLf4yAQ58WfJcfv2oApPau2MDEg2CsTk5ZsV+d5lnLseawRLR6E+QUFYPV9ItzNXHNtoVZgbK8dPWUBYRRhadRDVeYN+88HaWPVT/wSy9aati4tXHlyFloSCvIxHJaHy2dkApgB/Ak+DwJHKTneKQCB9aDpNPo+/XMIAT3w5eYUMjQHP22nynsYkQyu9jfsfWzM+RFkYwQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB2235.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 01:09:44 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69%7]) with mapi id 15.20.7316.032; Tue, 27 Feb 2024
 01:09:44 +0000
Message-ID:
 <MA0P287MB28224A3BAA6CA0D4833B5C30FE592@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 27 Feb 2024 09:09:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/5] clk: sophgo: Add SG2042 clock driver
From: Chen Wang <unicorn_wang@outlook.com>
To: Stephen Boyd <sboyd@kernel.org>
References: <cover.1708397315.git.unicorn_wang@outlook.com>
 <d7c74c2cfa410850c044ff2879720db06c2f8272.1708397315.git.unicorn_wang@outlook.com>
 <MA0P287MB282275AB71CC3A7E2F3792B2FE552@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Cc: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
In-Reply-To: <MA0P287MB282275AB71CC3A7E2F3792B2FE552@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [0mChtVThbM5wabG7JeN6mGo7R5US1Jek]
X-ClientProxiedBy: TYCP286CA0290.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::7) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <16630cc7-3c6f-4950-98cc-700e8f3b58dd@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB2235:EE_
X-MS-Office365-Filtering-Correlation-Id: b649b014-d85b-4a70-4289-08dc3730c7c5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ylba+/GJ7Jn9CX3gYcl8vHFzQI6sPi91Aqg2yxcjWYTzY/9aw5/IiV3PGJ2XR5Wnc1t1YW93ar7iCoiblfcfR0eU4RcxDAPCdZm7Fb+6Ly6YK49S/IhAb/GL8M4Wh4fux7tV7pw6d3YdBhZMyYiovlxOIA7EcdcDlE0MitZlAImS1lwY5RwYuky1ASPG8Qfky4V24Wrm89ZWCXZk5IFdY6T2UVYGDjDuD9j/YYU64C3PfbyVJIK64tzhf9hEbwR4vA4uv1pSWGXNSAm5BIcwePXontcL+kEbjGAzZkmcnrcsgRUwuR7+Q5TFW8Qenqf14OYg+x5TBC5t995/FG37Ni0hWVeD6YjGJehR4ewzSoFXFBRdRZ2kLjk0DHG8E7EewvpBkJZoFlMCFDSBcm3BioXwksU/RL8AOSRBPzMYopT1X/xpXyVX3wUjsUmITFbGZoTLKWsNKDVCSbOIHJYy3nKWywWUXDEfoOnqqHEwqVZ5A/Wr67FxmgzFGhClfL/YuXaKVf4jtA1l/H7Tc6jLy/PxuP2gzBRTmERyrLvqujGaa2d02KIAdiyLSahbkNHVd1eVPeQxFR++lFUqdOp3Xhg9JNFEuXR1888jFCl/gZsNOUMHvezYG2oUabUZuXTKxXJ/WxLn4/bGBKUaFp2Q05I6wuOokpRa6QQT3+K0uWI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDh6WmZQVGlqcjVqdFJuWjlkTGhyZFU5dzRIZ0IxRXd5VFg2eHN2S1JWeGVW?=
 =?utf-8?B?Z0ZZSm14SkthUmZyQXVLRXVkbDhOdWF1THpuYXlFaDU3eFJXQTRsTzZ0RkNY?=
 =?utf-8?B?T1VHRi9xb21nUlpvdDhFNDZMTDJSeTU3WVV3YWZrM0orQXhvSXBuT2N0Z2N6?=
 =?utf-8?B?RERjdktrWEhad1hHbU5KRTdQK280cWxiL2YrOEpobTlJYzEwOFUxNTI0Tmtj?=
 =?utf-8?B?VlVpOURna3l2SUFCTmI0WVhWZC91SFd0c01ZMjBFYUQ4ejllUFY4dGRTWlA1?=
 =?utf-8?B?enN3TUN2UzltUjN5QjJYUVArT2gwakF3QnArWW9NTE9QbzllOTRXWk16RnMv?=
 =?utf-8?B?TTlaam8yRGFNSnZJK2VCd0dVckhqYkkvdEgvTzhuUUYwVzh5WTliK2FwdjBy?=
 =?utf-8?B?RHdxOVpqUTJ1eWQ5bUx5d041VTN6SUlHUFp1ZVpSOVJMdGY0RXA1MGtIeElS?=
 =?utf-8?B?RS9QRUtVc1B1Zm1LMzhtWU9MeWY2UUlaRmxpTW01eFRic05adkV0SXlIdG9z?=
 =?utf-8?B?TlczNVBEZDd4YnBDYkd6RFJ1V1k2ekdSWU9uTDhuSWdCMjQvOXJ1T1JPeHcy?=
 =?utf-8?B?TzQ1RmFRekNvTzdjWTBkdGtqbVRtWnlaenZnSndldXZkY2ZDZWthdmYyQlRY?=
 =?utf-8?B?UkpkbFRhMmtvbWtNczhCaTVGWWhrckUvYmNFNkUxMnN2MWdxTzJ1WjgyQndQ?=
 =?utf-8?B?bXlXenpyd2o0VTRsWWowTWZ5ZldGUCtzdFViVWM2YjNIb3kwMEw3MkVuQzky?=
 =?utf-8?B?cHU5OEltOUpqZUtwZWoveFh4ZzZxc2E2S1RtR3JHbFlYcFV2SXNYMzhiZ2tF?=
 =?utf-8?B?S2cyNHFqOVRyWXFiZjMwQmNVQWx6YXIwUmdIanpIRFNxUzVsdTVCc3lWRXFk?=
 =?utf-8?B?clJhN0RkekoxSFQ0N2VtUWxTUU5EV3Q5SkZ0ZFEzaDRCTlFNdDl1ekNLdHJo?=
 =?utf-8?B?V2xoYko4ejllS3dvUzJFSkxnbVJQYnV4aGltdncyQVJpUkRFbm8zTHdKVzRG?=
 =?utf-8?B?S1ZwN1g3cGhJcHBYbXFQMXhIdHA1OVVwYWQzaWtIVG1XNmZNTG9rNmcyYW9P?=
 =?utf-8?B?N1VMeVRBN1UrR050OEZ6bDhXSTNEU3pwV0ZqQ25pOUZBMm9LUTBuLzlVZnMx?=
 =?utf-8?B?RWV3QmJ4MkNtWklITS9BMkcrNGNIQUhQZlA2OVVKTkdPTG5nMVovS2ZvOUNX?=
 =?utf-8?B?cWt2SUd6VDFJcjRmVjFwdWFSNkxZRWh2aGo4ZHJBd0Q4c2E4cXBiV3NTWXpW?=
 =?utf-8?B?WjdLRDJucThCN1QxMXhubmd5V1BpT0NEMVE5b1laaHYrYk9lbTRKRlVXSm9s?=
 =?utf-8?B?NUV2NHlyRkZHOVVFL3Y4akd0eldVbWg2L0NxYVlJTHJuS2NGdkRXcDhNazVE?=
 =?utf-8?B?SFp0b2JiY1V4YzBqWmJIMlpLZFg4cUYwSXlkRFJteU10WjY2V2s1Q1kxcUgy?=
 =?utf-8?B?K1VodUovSE53cUo1OERJSnVVRUUrTSsrUk1lcFJpSTAwSWhKM3FDa2MzRlIr?=
 =?utf-8?B?Nys0cjlyekFwMlE3VExpck1zWTRpYVJKTFNWVDRmWnEyS25qS0RMTzFmWi9y?=
 =?utf-8?B?RUFOa1F4OHkvRk9jZjd1K0ZzRWpkMzVnUkQxWHpmQk83WjdBMGFBYkJrSDRV?=
 =?utf-8?B?NkdLWWdybENXdGw5ZkFvWWpKSXB6eTFBa0NvdlVGNUU3cnRzMUs2TFdmMWdT?=
 =?utf-8?Q?ApvHLxtuCX+AGUESLmDh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b649b014-d85b-4a70-4289-08dc3730c7c5
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:09:44.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2235

Ping ~~~

Hi, Stepen,

Can you please have a review of this, any question please feel free let 
me know.

BTW, if it is ok for you, will you pick this driver patch together with 
the bindings for v6.9? Bindings related patches have been reviewed by 
Rob, and I can handle the other stuff such as dts.

Thanks,

Chen

On 2024/2/23 11:01, Chen Wang wrote:
> Ping ~~~
>
> On 2024/2/20 11:09, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add a driver for the SOPHGO SG2042 clocks.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   drivers/clk/Kconfig                    |    1 +
>>   drivers/clk/Makefile                   |    1 +
>>   drivers/clk/sophgo/Kconfig             |    8 +
>>   drivers/clk/sophgo/Makefile            |    2 +
>>   drivers/clk/sophgo/clk-sophgo-sg2042.c | 1401 ++++++++++++++++++++++++
>>   drivers/clk/sophgo/clk-sophgo-sg2042.h |  233 ++++
>>   6 files changed, 1646 insertions(+)
>>   create mode 100644 drivers/clk/sophgo/Kconfig
>>   create mode 100644 drivers/clk/sophgo/Makefile
>>   create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
>>   create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
> [......]
>
> Hi, Stephen,
>
> Can you please have a review of this, any question please feel free 
> let me know.
>
> BTW, if it is ok for you, will you pick this driver patch together 
> with the bindings for v6.9? Bindings related patches have been 
> reviewed by Rob, and I can handle the other stuff such as dts.
>
> Thanks,
>
> Chen
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

